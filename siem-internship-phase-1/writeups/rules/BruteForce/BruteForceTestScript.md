# Comprehensive Guide: Testing Brute Force Detection (Event ID 4625) in Elastic SIEM


## 1. PowerShell Script to Generate Failed Logins (Event ID 4625)

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


![Screenshot 2025-05-22 082019](https://github.com/user-attachments/assets/dd9927aa-6df6-43b0-ba87-06938114d67f)


## 2. Verification Steps in Kibana

After running the script, verify in Kibana:

1. **Check raw events**:
   ```
   event.code: 4625 AND user.name: "YOUR_TEST_USER"
   ```

2. **Verify detection rule**:
   - Your brute force rule should trigger after the threshold (e.g., 5 failed attempts in 5 minutes)
   - Check both the alert and the correlated events

3. **Field mappings verification**:
   ```
   # Key fields to verify
   winlog.event_id: 4625
   event.outcome: "failure"
   user.name
   source.ip (if you enabled IP enrichment)
   ```

## 3. Advanced Testing Scenarios

For more realistic testing:

```powershell
# Test with multiple users
$users = @("admin", "testuser", "svc_account")
$users | ForEach-Object {
    .\BruteForceTest.ps1 -TargetUser $_ -AttemptCount 3 -RandomizeSource
}

# Test with different time patterns
1..5 | ForEach-Object {
    .\BruteForceTest.ps1 -TargetUser "victim" -AttemptCount 2 -DelayMs (Get-Random -Min 100 -Max 1000)
    Start-Sleep -Seconds (Get-Random -Min 10 -Max 60)
}
```

## Key Technical Details:

1. **How Event 4625 is Generated**:
   - The script uses .NET's `ValidateCredentials()` which triggers the Windows security subsystem
   - Each failed attempt creates a native Windows security event
   - Works even with non-existent users (different failure codes)

2. **SIEM Integration Points**:
   ```mermaid
   graph LR
   A[PowerShell Script] --> B[Windows Security Log]
   B --> C[Winlogbeat]
   C --> D[Elasticsearch]
   D --> E[Kibana Detection Rules]
   ```

3. **Detection Rule Considerations**:
   - Threshold: Typically 5-10 failed attempts in 5-10 minutes
   - Account lockout policy interaction
   - Distinguish between valid/invalid users
   - Geographic/IP correlation
   - 
![Screenshot 2025-05-22 082305](https://github.com/user-attachments/assets/8bc593e1-7481-4d38-9e5b-66f7501a4991)


