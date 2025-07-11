﻿# SIEM Internship Phase 1
 # Phase 1 – Introduction

Welcome to the internship and SOC lab learning journey.
[Full Write-up](https://github.com/0xMOSTA-FU/siem-internship-phase-1/blob/main/siem-internship-phase-1/writeups/Full%20Writeup.md)
## Objectives of Phase 1:
- Setup a mini SOC lab using free and open-source tools.
- Simulate basic attacks (e.g., brute-force, malware).
- Configure log sources: Windows, Linux, network devices.
- Send logs to your SIEM and build detection logic.

  # What is a SIEM and Why it Matters?

## Definition
SIEM (Security Information and Event Management) is a centralized platform that collects, correlates, and analyzes log data in real-time.

## Use Cases:
- Centralized log collection
- Alerting on suspicious activity
- Correlation of multiple data sources
- Compliance and auditing

## Example: Detecting Early Attacks
SIEM can catch signs of:
- Failed logins (brute force)
- Malware execution (via event logs)
- Suspicious PowerShell use (Sysmon)

## Lab Architecture
![MY SOC diagram](https://github.com/user-attachments/assets/b811d43b-b48e-4dc5-aa98-a4efcaf5b084)

## Tools Used
- Kibana
- Winlogbeat
- Sysmon
- elasicsearch
- PowerShell
- curl / nmap / 

## Folder Structure
- /screenshots: images from Kibana, detections
- /logs: raw log files used in analysis
- /writeups: detection rule descriptions, use cases, setup docs , Full ScreenShots for all proccess

---

# Tools Download Links
- Winlogbeat: https://www.elastic.co/beats/winlogbeat
- ELK Stack: https://www.elastic.co/downloads
- VMware: https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion
- Parrot OS: https://parrotsec.org/
- Windows 10: https://www.microsoft.com/en-us/software-download/windows10
- Sysmon: https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon



