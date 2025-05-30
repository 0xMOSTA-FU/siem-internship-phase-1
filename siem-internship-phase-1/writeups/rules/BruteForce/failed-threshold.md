# Brute Force Detection Rule (Threshold-Based)

##  Rule Name:
**BruteForce**

##  Objective:
Detect potential brute-force attacks by identifying multiple failed login attempts (Event ID 4625) from the same source IP within a short time frame.

##  Author:
Mostafa Essam (aka 0xMOSTA)

##  Dates:
- Created: May 18, 2025
- Last Updated: May 31, 2025

##  Severity & Risk:
- **Severity:** High
- **Risk Score:** 73

##  Rule Type:
**Threshold Rule**

##  Logic:
Detect if there are **5 or more** failed login attempts (`event.code: "4625"`) from the **same IP address** within **2 minutes**.

##  Schedule:
- **Runs every:** 1 minute
- **Look-back window:** 2 minutes

##  Data Sources:
- `winlogbeat-*`
- `logs-*`
- `filebeat-*`
- Any other log source containing Windows Security Events

##  MITRE ATT&CK Mapping:
- **Tactic:** Credential Access (TA0006)
- **Technique:** Brute Force (T1110)
  - [https://attack.mitre.org/techniques/T1110/](https://attack.mitre.org/techniques/T1110/)

##  Rule Configuration:

- **Index Pattern:**  
  `winlogbeat-*` or relevant index containing Event ID 4625

- **KQL Query:**
  ```kql
  event.code: "4625"
  ```
![Screenshot 2025-05-31 124956](https://github.com/user-attachments/assets/ef3e9578-98de-4721-bb53-661a9798978e)

Threshold Field:
source.ip

Threshold Value:
≥ 5

Time Window:
2 minutes

 Alert Suppression:
None for now (can be added by source.ip to reduce noise).

 False Positive Scenarios:
User mistyped password several times

Admin using incorrect credentials during off-hours

Account lockout policies triggering alerts

##  Testing Procedure:

To verify that the threshold rule works correctly, we simulated multiple failed login attempts using a custom PowerShell script on a Windows machine.

###  PowerShell Simulation Script (Sample):
```powershell
<#
.SYNOPSIS
    Generates Windows Security Event ID 4625 (failed logins) for SIEM testing
    
.DESCRIPTION
    Creates realistic failed authentication events to test:
    - Windows Event Logging
    - Log collection (Winlogbeat)
    - Elasticsearch ingestion
    - Kibana detection rules
    
.NOTES
    Version: 2.0
    Author: Mostafa Essam (0xMOSTA)
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$TargetUser,
    
    [Parameter(Mandatory=$true)]
    [int]$AttemptCount,
    
    [int]$DelayMs = 300,
    
    [switch]$RandomizeSource
)

# Import required assembly
Add-Type -AssemblyName System.DirectoryServices.AccountManagement

# Configuration
$IncorrectPassword = "SIEM_TestPassword123!"  # Will always fail
$eventLogSource = "Security"
$startTime = Get-Date

# Generate random IPs if enabled
$sourceIPs = @("192.168.1.10", "10.0.0.15", "172.16.5.20")
if ($RandomizeSource) {
    $sourceIPs = 1..10 | ForEach-Object { "192.168.1.$_" }
}

Write-Host @"
[ Brute Force Test Configuration ]
Target User:       $TargetUser
Attempts:          $AttemptCount
Delay Between:     ${DelayMs}ms
Randomize Sources: $($RandomizeSource.IsPresent)
Start Time:        $startTime
"@

# Main test loop
1..$AttemptCount | ForEach-Object {
    $attemptNum = $_
    $currentIP = if ($RandomizeSource) { $sourceIPs | Get-Random } else { $sourceIPs[0] }
    
    try {
        # Create authentication context
        $context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext(
            [System.DirectoryServices.AccountManagement.ContextType]::Machine
        )
        
        # Simulate failed login (will generate Event ID 4625)
        $null = $context.ValidateCredentials($TargetUser, $IncorrectPassword)
        
        Write-Host "[Attempt $attemptNum] Generated failed login from $currentIP" -ForegroundColor DarkGray
        
        # Optional: Add source IP to the Windows event (requires admin)
        if ($false) {  # Change to $true if you want to enrich events with source IP
            $eventMessage = "Logon attempt failed for $TargetUser from $currentIP"
            Write-EventLog -LogName $eventLogSource -Source "Microsoft Windows security auditing" `
                -EventID 4625 -EntryType FailureAudit -Message $eventMessage
        }
    }
    catch {
        Write-Warning "[Attempt $attemptNum] Error: $($_.Exception.Message)"
    }
    
    # Add delay between attempts
    if ($attemptNum -lt $AttemptCount) {
        Start-Sleep -Milliseconds $DelayMs
    }
}

Write-Host @"
`n[ Test Complete ]
Total attempts made: $AttemptCount
Start time: $startTime
End time:   $(Get-Date)
"@
```
![Screenshot 2025-05-31 100714](https://github.com/user-attachments/assets/ad4cbf0c-b37e-403c-9f70-6cd8904b8df7)


An alternative testing method is also possible.

- Used RDP brute-force simulation from Kali Linux (hydra / xfreerdp).

- Confirmed alert is triggered after 5+ failed attempts within time window.

 Recommendations:
Combine this with GeoIP and host enrichment for better context.

Tune threshold or time window based on your environment.

Consider linking with detection of Event ID 4624 (successful login) from same IP to catch successful brute-force attempts.

 Tags:
BruteForce Windows RDP EventID:4625 Threshold Detection

  
