# Brute Force Attack Detection via Windows RDP (Event ID 4625)

## Rule Name
BruteForce

## Rule Purpose
This detection rule is designed to identify potential brute-force attacks targeting Windows systems via Remote Desktop Protocol (RDP). It triggers when a high number of failed login attempts (Event ID 4625) are observed from a single IP address within a short time frame (5 minutes).

This behavior often indicates an attacker attempting to guess valid credentials using automated tools. If not mitigated, this could eventually lead to unauthorized access through a successful login (Event ID 4624).

---

## Attack Technique

| Field        | Value                                                                 |
|--------------|-----------------------------------------------------------------------|
| MITRE ATT&CK Tactic | Credential Access (TA0006)                                           |
| MITRE ATT&CK Technique | Brute Force (T1110)                                                  |
| Reference    | https://attack.mitre.org/techniques/T1110/                             |

Brute force attacks rely on guessing username-password combinations, either from a dictionary, a password list, or pure iteration. RDP is a common target due to its remote access capabilities and potential for privilege escalation.

---

## Detection Logic

### Data Source:
- **Winlogbeat** shipping logs from Windows endpoints
- Event ID: **4625** – “An account failed to log on”
- Indexes: `winlogbeat-*`, `logs-*`, etc.

### Query:
```kuery
event.code: "4625"

