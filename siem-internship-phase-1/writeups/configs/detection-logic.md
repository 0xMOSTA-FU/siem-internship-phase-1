Detection Logic: Brute Force Attack (Event ID 4625)

This detection logic is designed to identify potential brute-force login attempts on Windows systems, primarily through RDP (Remote Desktop Protocol), using failed login events (Event ID 4625).

Detection Criteria:
- Event ID: 4625 (Failed Logon)
- Log source: winlogbeat-* index
- Repeated failed login attempts from the same source IP address
- Alert suppression is applied for source.ip to avoid alert flooding

Additional Filters:
- Alerts are grouped and suppressed for 5 minutes to reduce noise
- Only alerts from relevant log indices are considered:
  apm-*-transaction*, auditbeat-*, endgame-*, filebeat-*, logs-*, packetbeat-*, traces-apm*, winlogbeat-* (excluding *-elastic-cloud-logs-*)

Assumptions:
- A brute-force attack is assumed if multiple 4625 events are observed from the same source IP over a short period
- The system distinguishes between actual brute-force attempts and false positives (e.g., mistyped passwords or off-hours legitimate admin access)

Suppression Logic:
- Alerts are suppressed by `source.ip` for 5 minutes
- Alerts missing this field will still be grouped using available fields

Risk Level:
- Severity: High
- Risk Score: 73

MITRE ATT&CK Mapping:
- Tactic: Credential Access (TA0006)
- Technique: Brute Force (T1110)

Validation:
- Logs were generated using a PowerShell script simulating multiple failed login attempts
- Manual rule execution was performed to verify alert generation

Future Work:
- Additional rules will be added.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---

##  Malware Execution Simulation

```yaml
### Detection Logic: Simulated Malware Execution

Detection Criteria:
- Event ID: 1 (ProcessCreate)
- ParentImage: powershell.exe
- Target Image: calc.exe
- CommandLine contains suspicious flags: `-NoP`, `-W Hidden`
- Registry modification under `HKCU:\Software\Microsoft\Windows\CurrentVersion\Run`

Log Source:
- `winlogbeat-*`
- Event IDs: 1 (ProcessCreate), 13 (Registry modification)

MITRE ATT&CK:
- Tactic: Execution (TA0002)
- Technique: Command and Scripting Interpreter (T1059.001)
- Technique: Boot or Logon Autostart Execution: Registry Run Keys (T1547.001)

Risk Level:
- Severity: Medium
- Risk Score: 55

Suppression Logic:
- Suppress based on `process.name` if identical command seen in last 5 mins
```

 **Notes**:

* `calc.exe` is just a simulation for an executable, but could be replaced by real malware.
* Persistence through the Run registry key is common behavior for malware.
* PowerShell with flags like `-NoP -W Hidden` is often used in obfuscated/scripted attacks.

---

##  Data Exfiltration Simulation

```yaml
### Detection Logic: Simulated Data Exfiltration

Detection Criteria:
- Event ID: 3 (NetworkConnect)
- Image: powershell.exe
- CommandLine contains `Invoke-WebRequest`
- Target address: `127.0.0.1` (local test, replace in production)

Log Source:
- `winlogbeat-*`
- Event IDs: 3 (NetworkConnect), 11 (FileCreate)

MITRE ATT&CK:
- Tactic: Exfiltration (TA0010)
- Technique: Exfiltration Over HTTP (T1041)

Risk Level:
- Severity: Medium
- Risk Score: 60

Suppression Logic:
- Suppress repeated identical requests from same process & IP in 10 mins
```

 **Notes**:

* Even though data wasn’t actually exfiltrated (localhost), the same logic will catch real outbound traffic in production.
* PowerShell + `Invoke-WebRequest` is a red flag, especially if seen frequently in logs.
* Suspicious `.txt` files with unusual size or location may also indicate staging before exfiltration.

---

##  Port Scanning Simulation

```yaml
### Detection Logic: Port Scanning Attempt

Detection Criteria:
- Multiple inbound connections from same IP
- Ports scanned include 22, 80, 139, 445
- Event source: firewall logs (optional), or endpoint detection (Winlogbeat, Suricata)

Log Source:
- `packetbeat-*`, `winlogbeat-*`, or IDS logs
- Event IDs: varies depending on sensor

MITRE ATT&CK:
- Tactic: Discovery (TA0007)
- Technique: Network Service Scanning (T1046)

Risk Level:
- Severity: Medium
- Risk Score: 65

Suppression Logic:
- Suppress if same IP triggered alert in last 10 mins
```

 **Notes**:

* Port scanning is not always malicious, but is often an early indicator of further probing.
* Using Suricata or Zeek alongside Winlogbeat provides better visibility.
* Without an IDS, Event ID 5156 (Windows Filtering Platform) can help detect unusual connections.

---

##  Phishing via Office Macro

```yaml
### Detection Logic: Phishing Macro Simulation

Detection Criteria:
- ParentImage: winword.exe or excel.exe
- Child process: powershell.exe
- CommandLine contains suspicious flags or sleep/delay

Log Source:
- `winlogbeat-*`
- Event ID: 1 (ProcessCreate)

MITRE ATT&CK:
- Tactic: Initial Access (TA0001)
- Technique: Spearphishing Attachment (T1566.001)
- Sub-Technique: Malicious Macro (T1059.005)

Risk Level:
- Severity: High
- Risk Score: 80

Suppression Logic:
- Suppress same parent-child combo (Office -> PowerShell) if seen in last 10 mins
```

 **Notes**:

* Office spawning PowerShell is almost always suspicious, even in a controlled test.
* Many phishing attacks start with a macro that executes a shell command.
* Consider adding YARA or Sigma rules to detect `Sleep`, `Hidden`, or `NoProfile` usage.

---

##  Persistence & Recon Simulation

```yaml
### Detection Logic: Persistence and Reconnaissance Simulation

Detection Criteria:
- PowerShell running `Get-WmiObject`, `netstat`, or `schtasks`
- Event ID: 1 (ProcessCreate)
- File write detected: netstat_output.txt
- Event ID: 11 (FileCreate)

Log Source:
- `winlogbeat-*`

MITRE ATT&CK:
- Tactic: Persistence (TA0003), Discovery (TA0007)
- Techniques:
  - T1057: Process Discovery (via WMI)
  - T1053: Scheduled Task
  - T1049: System Network Connections Discovery

Risk Level:
- Severity: Medium-High
- Risk Score: 68

Suppression Logic:
- Suppress by process + commandline hash if repeated in short time
```

 **Notes**:

* Creating scheduled tasks is a classic way for attackers to maintain persistence.
* Saving netstat output to disk can be suspicious if executed via script or PowerShell.
* WMI queries like `Get-WmiObject` are often used by tools like Cobalt Strike to gather system info.

---


