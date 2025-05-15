# SIEM Lab Setup & Operations (Phase 1)

## Author
**Mostafa Essam** (aka `0xMOSTA`)

---

## Lab Architecture Summary

The lab consists of:
- **Parrot OS VM**:
  - Installed: `Elasticsearch`, `Kibana`
  - Acts as the SIEM backend and dashboard
  - Network mode: **Bridged Adapter**

- **Windows 10 VM**:
  - Installed: `Winlogbeat`
  - Forwards Windows Event Logs (Security Logs) to Elasticsearch
  - Network mode: **Bridged Adapter**

---

## Goal
- Detect suspicious activity like brute force attacks (Event ID 4625), unauthorized access, malware simulation, and more using the ELK stack without using Logstash.

---

## Tools Used
| Tool         | Purpose                                |
|--------------|----------------------------------------|
| Kibana       | Dashboard and detection rule interface |
| Elasticsearch| Log storage and searching              |
| Winlogbeat   | Windows log forwarder                  |
| Parrot OS    | Hosting the SIEM stack                 |
| Windows 10   | Log source and attack simulation       |
| PowerShell   | Used to simulate attacks               |

---

## Data Flow

1. **Winlogbeat** on Windows collects logs (e.g., Event ID 4625)
2. Sends them directly to **Elasticsearch** on Parrot OS
3. **Kibana** visualizes and correlates them using detection rules

---
