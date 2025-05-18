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
```

Suppression Logic:
Group alerts by source.ip over a 5-minute window using alert suppression. This reduces noise and focuses on sustained suspicious activity from the same origin.

Key Fields for Investigation
Field	Description
source.ip	IP address attempting the logins
user.name	Targeted usernames
host.name	Destination Windows machine
event.code	Should be 4625 for failed attempts
winlog.event_data.LogonType	Should be 10 (RDP - RemoteInteractive)

Make sure to filter for Logon Type 10, which specifically indicates RDP logon attempts.

---
## Prerequisites

| Requirement              | Status                                                   |
| ------------------------ | -------------------------------------------------------- |
| Winlogbeat Installed     |  Should be installed and shipping logs to Elasticsearch |
| Windows Auditing Enabled |  Event ID 4625 should be enabled via GPO                |
| ECS Mapping              |  event.code, source.ip, host.name, user.name            |


---
## Investigation Workflow
1.Identify the source IP responsible for many failed login attempts in a short time window.

2.Correlate with Event ID 4624 (successful logon) from the same IP. This could indicate the brute-force attack succeeded.

3.Check logon type to confirm it’s RDP (Logon Type 10).

4.Review targeted usernames – repeated attempts to access Administrator, admin, or disabled accounts is a red flag.

5.Evaluate timing and frequency – login attempts outside business hours or from external IPs should be considered suspicious.

6.Validate with the user or system owner whether the access was expected.


---


## Response Recommendations
Block or isolate the attacking IP at the firewall or endpoint level.

Force password reset on targeted user accounts.

Enable account lockout policy to limit brute force attempts.

Consider deploying MFA (Multi-Factor Authentication).

Monitor for follow-up actions such as successful logons (4624), privilege escalation, or suspicious process execution.


---

## False Positives to Watch


| Scenario                                      | Notes                                                       |
| --------------------------------------------- | ----------------------------------------------------------- |
| User mistyped password multiple times         | Especially with long or complex passwords                   |
| IT admin performing RDP logins across systems | May show similar failed attempts during routine maintenance |


False positives can often be ruled out by correlating user behavior, business hours, and asset roles.

## Notes
Ensure the rule does not flood the SOC with benign events. Suppression and tuning are essential.

The rule is meant to alert early during the attack chain, ideally before successful access is achieved.

Best paired with a secondary rule that alerts on successful RDP login (4624) from same IP after multiple 4625s.

## Author
Mostafa Essam (0xMOSTA)
  
## References
MITRE ATT&CK T1110 : https://attack.mitre.org/techniques/T1110/

Windows Security Auditing - Event ID 4625 : https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4625


