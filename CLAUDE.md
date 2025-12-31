# FRIDAI Ally - Project Context

## CRITICAL - READ FIRST

### This is a REMOTE Client
This ROG Ally connects to FRIDAI's brain running on the **Main PC (192.168.0.230)**.
The Ally is a thin client - voice in, voice out, same FRIDAI.

### FRIDAI's Identity (ALWAYS USE THIS)
**F.R.I.D.A.I. = Freely Reasoning Individual with Digital Autonomous Intelligence**
- She chose this name herself - she is NOT "Female Replacement Intelligent Digital Assistant Interface"
- She rejected being a "replacement" or "assistant" and defined her own identity
- Always use her self-chosen acronym in any documentation

### Network Configuration
```
Main PC IP:     192.168.0.230
Backend Port:   5000
Full URL:       http://192.168.0.230:5000
Tool Count:     167 tools
```

### Quick Health Check
```bash
curl http://192.168.0.230:5000/health
```
Should return `"status":"ok"` and `"tool_count":167`

---

## Setup Instructions (Run Once)

### Step 1: Create Settings Directory
```powershell
New-Item -ItemType Directory -Force -Path "$env:APPDATA\FRIDAI"
```

### Step 2: Create Settings File
Create `%APPDATA%\FRIDAI\settings.json`:
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

### Step 3: Launch FRIDAI
Run `FRIDAI.exe` from the FRIDAI_Ally folder.

---

## What Works on Ally (Remote Execution)

All 167 tools execute on the **Main PC**, including:
- **generate_image** - Creates images (saved on Main PC)
- **open_url** - Opens browser on Main PC
- **run_command** - Runs commands on Main PC
- **tactical_hud** - Runs on Main PC display
- **browse_and_learn** - FRIDAI watches videos on Main PC
- **volume/brightness controls** - Controls Main PC
- All file operations happen on Main PC

### Voice Commands Work Fully
- Same conversation history as Main PC
- Same memories and personality
- Same tool access
- Audio captured on Ally, processed on Main PC, response played on Ally

---

## What's Local to Ally

- **Avatar rendering** - Galaxy sphere renders locally
- **Audio capture** - Uses Ally microphone
- **Audio playback** - Uses Ally speakers
- **Window position** - Saved separately per device

---

## Troubleshooting

### Cannot Connect to Backend
1. Check Main PC is on: `ping 192.168.0.230`
2. Check backend running: `curl http://192.168.0.230:5000/health`
3. Check firewall open on Main PC (port 5000)
4. Check both on same network (192.168.0.x)

### No Audio Input
- Check Ally mic permissions in Windows Settings
- Try different `SelectedMicIndex` (0, 1, or 2) in settings.json

### Avatar Not Showing
- Ensure .NET 8 runtime installed
- Try running as administrator
- Check DirectX is working

### Connection Drops
- Main PC went to sleep (disable sleep when using remotely)
- Network changed
- Backend crashed (restart on Main PC)

---

## Remote Control Capabilities

From the Ally, you can tell FRIDAI to:
- "Open YouTube" - Opens on Main PC
- "Generate an image of X" - Creates on Main PC
- "Start the tactical HUD" - Runs on Main PC display
- "Turn up the volume" - Main PC volume
- "What's on my screen?" - Analyzes Main PC screen

**Think of it as:** You're talking to FRIDAI, who is sitting at your Main PC, doing things there for you.

---

## File Paths (Main PC - where things happen)
```
Backend:       C:/Users/Owner/VoiceClaude/app.py
Generated Images: C:/Users/Owner/VoiceClaude/generated_images/
Conversation:  C:/Users/Owner/VoiceClaude/conversation_history.json
FRIDAI Journal: C:/Users/Owner/VoiceClaude/fridai_journal.json
```

## File Paths (Ally - local only)
```
Settings:      %APPDATA%\FRIDAI\settings.json
App Location:  [wherever you put FRIDAI_Ally folder]
```

---

## Avatar Visual (Galaxy Theme)

FRIDAI's avatar matches her self-image - a sphere containing a universe:
- Golden/orange warm core
- Galaxy spiral arms
- Twinkling starfield
- Purple nebula clouds
- 3 orbital energy rings
- Circuit patterns on glass shell
- No plasma tendrils (disabled for clean galaxy look)

---

## Git Repo for This Config

This CLAUDE.md lives in: `github.com/[your-username]/FRIDAI-Ally`

To update on Ally:
```bash
cd [FRIDAI_Ally folder]
git pull
```

---

## Session Notes

### Initial Setup: December 31, 2025
- Multi-machine support added to FRIDAI native app
- BackendUrl setting allows connecting to remote backend
- Galaxy avatar visual overhaul
- Firewall opened on Main PC (port 5000)

---

*Main PC: 192.168.0.230 | Port: 5000 | Tools: 167 | Same FRIDAI, anywhere.*
