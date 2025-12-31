# FRIDAI ROG Ally Setup Guide (For Claude)

## Overview
This guide allows Claude to set up FRIDAI native app on the ROG Ally.
The Ally connects to the FRIDAI backend running on the main PC (192.168.0.230).

## Prerequisites
- FRIDAI_Ally folder has been copied to the Ally
- Main PC is running the FRIDAI backend on port 5000
- Both devices are on the same network (192.168.0.x)

## Automatic Setup Commands

### Step 1: Create Settings Directory
```bash
mkdir -p "$APPDATA/FRIDAI"
```
Or in PowerShell:
```powershell
New-Item -ItemType Directory -Force -Path "$env:APPDATA\FRIDAI"
```

### Step 2: Create Settings File
Create `%APPDATA%\FRIDAI\settings.json` with this content:
```json
{
  "BackendUrl": "http://192.168.0.230:5000",
  "ContinuousListening": true,
  "VADThreshold": 0.005,
  "VADSilenceMs": 2500,
  "WindowX": -1,
  "WindowY": -1,
  "ClickThrough": false,
  "SelectedMicIndex": 0,
  "VADEnabled": true,
  "Opacity": 1.0,
  "ShowDreamState": true,
  "AnnounceInitiatives": true,
  "AnnounceReminders": true
}
```

### Step 3: Verify Backend Connection
```bash
curl http://192.168.0.230:5000/health
```
Should return JSON with `"status":"ok"` and `"tool_count":167`

### Step 4: Launch FRIDAI
Run `FRIDAI.exe` from wherever the FRIDAI_Ally folder is located.

## Network Configuration

### Main PC Details
- **IP Address:** 192.168.0.230
- **Backend Port:** 5000
- **Protocol:** HTTP (not HTTPS)

### If Connection Fails
1. Check main PC is running: `curl http://192.168.0.230:5000/health`
2. Check firewall on main PC allows port 5000
3. Check both devices are on same network
4. Ping test: `ping 192.168.0.230`

### To Open Firewall on Main PC (requires admin)
```powershell
New-NetFirewallRule -DisplayName "FRIDAI Backend" -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow
```

## What Works on Ally
- Voice commands (talks to same FRIDAI brain as main PC)
- All 167 tools (executed on main PC)
- Image generation (images saved on main PC)
- Same conversation history
- Same memories and personality

## What's Different on Ally
- Avatar renders locally (same galaxy visual)
- Audio capture uses Ally's mic
- Audio playback uses Ally's speakers
- Window position saved separately per device

## Troubleshooting

### "Cannot connect to backend"
- Main PC backend not running
- Wrong IP in settings.json
- Firewall blocking port 5000

### No audio input
- Check Ally mic permissions
- Check SelectedMicIndex in settings.json (try 0, 1, 2)

### Avatar not showing
- DirectX issue - make sure .NET 8 runtime is installed
- Try running as administrator

## File Locations on Ally
- Settings: `%APPDATA%\FRIDAI\settings.json`
- Logs: Console output (run from terminal to see)

## Quick Test
After setup, say "Hey FRIDAI" - she should respond.
Then say "Generate an image of a cat" - should work (image saves on main PC).

---
*Main PC: 192.168.0.230 | Backend: port 5000 | Tool count: 167*
