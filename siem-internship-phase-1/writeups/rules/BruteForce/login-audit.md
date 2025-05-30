Login Audit

Overview

This document outlines the process of auditing login attempts on Windows systems. Monitoring login activity is crucial for detecting suspicious behaviors, such as brute force attacks or unauthorized access attempts.

Data Source

We are collecting logs from Windows Event Logs using Winlogbeat, specifically focusing on:

Event ID 4625 – Failed login attempts

Event ID 4624 – Successful login attempts (optional for correlation)

Log Collection

Logs are collected from endpoints via Winlogbeat and ingested into the ELK Stack (Elasticsearch, Kibana).

Purpose

Detect brute force attacks

Monitor for unusual login patterns

Provide visibility into user authentication activity

Detection Use Case

We created a detection rule named BruteForce in Kibana's Security > Rules section:

Rule Type: KQL Query

Query: event.code: "4625"

Suppression Field: source.ip for 5 minutes

Index Patterns: winlogbeat-*, logs-*, etc.

Severity: High

Risk Score: 73

MITRE ATT&CK: Credential Access (T1110)

False Positive Examples

User mistyped password multiple times

Legitimate admin access during off-hours

Manual Log Review

For additional verification or manual testing, PowerShell scripts were used to simulate failed login attempts and verify that they are ingested and generate alerts properly.

Alternative Testing Method

An alternative testing method is also possible by triggering failed login attempts via RDP or using domain accounts with incorrect passwords.

Author

Mostafa Essam - [@0xMOSTA](https://github.com/0xMOSTA-FU)
