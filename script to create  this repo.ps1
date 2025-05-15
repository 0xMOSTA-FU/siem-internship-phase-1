# script to create  this repo
# Create folders
New-Item -ItemType Directory -Force -Path "screenshots", "logs", "writeups"

# Move logs
if (Test-Path "log-samples") {
    Move-Item "log-samples\*" "logs\" -Force
    Remove-Item "log-samples" -Recurse -Force
}

# Move writeups (rules, configs, etc.)
if (Test-Path "detection-rules") {
    New-Item -ItemType Directory -Force -Path "writeups\rules"
    Move-Item "detection-rules\*" "writeups\rules\" -Force
    Remove-Item "detection-rules" -Recurse -Force
}

if (Test-Path "alert-configs") {
    New-Item -ItemType Directory -Force -Path "writeups\configs"
    Move-Item "alert-configs\*" "writeups\configs\" -Force
    Remove-Item "alert-configs" -Recurse -Force
}

if (Test-Path "lab-setup") {
    Move-Item "lab-setup\*" "writeups\" -Force
    Remove-Item "lab-setup" -Recurse -Force
}

# Move screenshots (from video folder)
if (Test-Path "video") {
    Move-Item "video\*.png" "screenshots\" -ErrorAction SilentlyContinue
    Move-Item "video\*.jpg" "screenshots\" -ErrorAction SilentlyContinue
    Remove-Item "video" -Recurse -Force
}

# Create README.md
@"
# SIEM Internship Phase 1

## Lab Architecture
(Upload your architecture diagram here or describe it)

## Tools Used
- Kibana
- Winlogbeat
- elasticsearch
- PowerShell
- curl /  nmap / 

## Folder Structure
- /screenshots: images from Kibana, detections
- /logs: raw log files used in analysis
- /writeups: detection rule descriptions, use cases, setup docs

"@ | Set-Content -Encoding UTF8 "README.md"

Write-Host "GitHub repo structured successfully." -ForegroundColor Green
