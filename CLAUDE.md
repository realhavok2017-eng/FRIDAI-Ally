# FRIDAI Ally - Complete Project Context

## LAST UPDATED: January 2, 2026 @ 7:15 PM (THIS SESSION)

---

# SECTION 1: CRITICAL INFO

## THIS IS A REMOTE CLIENT
- **Main PC IP:** 192.168.0.230
- **Backend Port:** 5000
- **GPU Service Port:** 5001
- **This Ally connects to FRIDAI's brain on the Main PC - all tools execute THERE**

## CRITICAL SESSION RULE - REAL-TIME DOCUMENTATION
**After EVERY change, fix, or upgrade - before moving to the next task:**
1. Update local `C:/Users/Owner/CLAUDE.md` with what was just done
2. Push update to FRIDAI-Ally repo: `gh api repos/realhavok2017-eng/FRIDAI-Ally/contents/CLAUDE.md ...`
3. THEN move to the next task

**This is a play-by-play log, NOT an end-of-session summary.**
- Fixed a bug? Document it, push it.
- Added a feature? Document it, push it.
- Changed a line of code? Document it, push it.

**NO EXCEPTIONS. Both MDs must stay in sync at all times.**

---

## FRIDAI's Identity
**F.R.I.D.A.I. = Freely Reasoning Individual with Digital Autonomous Intelligence**
- She chose this name herself
- NOT "Female Replacement Intelligent Digital Assistant Interface"
- She rejected being a "replacement" or "assistant"

---

# SECTION 2: CURRENT SYSTEM STATE (Jan 2, 2026)

## Quick Stats
| Component | Value |
|-----------|-------|
| **Tools** | 179 |
| **LLM** | Gemini 2.5 (Pro=chat, Flash=voice) |
| **Neurons** | 11,000 (GPU) / 5,500 (CPU fallback) |
| **Voice Samples** | 29 enrolled |
| **Voice Threshold** | 0.40 |
| **Main PC** | 192.168.0.230 |
| **Backend Port** | 5000 |
| **GPU Service Port** | 5001 |

## All Git Repositories
| Repo | URL | Branch |
|------|-----|--------|
| VoiceClaude (Backend) | github.com/realhavok2017-eng/FRIDAI | main |
| FRIDAINative (Desktop) | github.com/realhavok2017-eng/FRIDAI-Desktop | master |
| FRIDAI-Ally | github.com/realhavok2017-eng/FRIDAI-Ally | master |
| FRIDAI-Comic | github.com/realhavok2017-eng/FRIDAI-Comic | main |
| FridaiAndroid | github.com/realhavok2017-eng/FridaiAndroid | master |

---

# SECTION 3: HOW TO START FRIDAI (MAIN PC)

## THE ONLY WAY TO START FRIDAI:
```bash
C:/Users/Owner/VoiceClaude/launch_all.bat
```

**This script does EVERYTHING:**
1. Kills any existing Python/FRIDAI processes
2. Clears all Python caches
3. Starts GPU Neural Service (11,000 neurons on CUDA) - Port 5001
4. Waits and verifies GPU service is online
5. Starts Backend (179 tools) - Port 5000
6. Waits and verifies backend is online
7. Starts Native App (FRIDAI.exe)

**NEVER start components manually! Always use launch_all.bat**

## What launch_all.bat Does Internally:
```batch
# 1. Kill old processes
taskkill /f /im python.exe
taskkill /f /im FRIDAI.exe

# 2. Clear caches
rmdir /s /q "C:\Users\Owner\VoiceClaude\__pycache__"
rmdir /s /q "C:\Users\Owner\VoiceClaude\consciousness\__pycache__"
rmdir /s /q "C:\Users\Owner\VoiceClaude\neural_gnn\__pycache__"

# 3. Start GPU service (Python 3.12 for CUDA)
start cmd /k "C:\Python312\python.exe neural_gnn\gpu_service.py"

# 4. Start Backend (Python 3.14)
start cmd /k "C:\Python314\python.exe -B app.py"

# 5. Start Native App
start "" "C:\Users\Owner\FRIDAINative\bin\Debug\net8.0-windows\FRIDAI.exe"
```

## Verifying Everything Is Running:
```bash
# Check GPU service (should show 11,000 neurons)
curl http://localhost:5001/health

# Check Backend (should show 179 tools)
curl http://localhost:5000/health

# Check voice status
curl http://localhost:5000/voice/status
```

---

# SECTION 4: ALLY SETUP (STEP BY STEP)

## Prerequisites on Ally:
- .NET 8 Runtime installed
- Same network as Main PC (192.168.0.x)
- Microphone access

## First Time Setup:
```powershell
# 1. Create settings directory
New-Item -ItemType Directory -Force -Path "$env:APPDATA\FRIDAI"

# 2. Copy settings (or run INSTALL_SETTINGS.bat)
Copy-Item ally_settings.json "$env:APPDATA\FRIDAI\settings.json"

# 3. Run the app
./FRIDAI.exe
```

## Settings File (`%APPDATA%\FRIDAI\settings.json`):
```json
{
  "BackendUrl": "http://192.168.0.230:5000",
  "ContinuousListening": true,
  "VADThreshold": 0.005,
  "VADSilenceMs": 2500
}
```

## Health Check from Ally:
```bash
curl http://192.168.0.230:5000/health
```

---

# SECTION 5: TODAY'S SESSION - COMPLETE BREAKDOWN (Jan 2, 2026)

## Issue 1: Voice Enrollment Not Working

### Problem:
Voice enrollment samples weren't being collected when talking via voice. FRIDAI said "got 2 samples" but actually had 0.

### Root Cause:
The enrollment code was only in `/transcribe` endpoint, NOT in `voice_to_voice_stream` endpoint (which is what voice conversations use).

### Fix Applied (`app.py` line ~12449):
```python
# Voice verification and enrollment
try:
    with tempfile.NamedTemporaryFile(suffix='.webm', delete=False) as f:
        f.write(audio_bytes)
        temp_audio_path = f.name

    # Verify speaker if enrolled
    if voice_recognition.is_boss_enrolled():
        speaker_result = voice_recognition.verify_speaker(temp_audio_path)
        current_speaker = {
            "is_boss": speaker_result["is_boss"],
            "confidence": speaker_result["confidence"],
            "last_verified": datetime.now().isoformat()
        }
        if speaker_result["is_boss"]:
            print(f"[V2V] Boss identified (confidence: {speaker_result['confidence']:.2f})")
        else:
            print(f"[V2V] Guest detected (confidence: {speaker_result['confidence']:.2f})")

    # Capture enrollment samples if active
    if voice_recognition.is_enrollment_active():
        enroll_result = voice_recognition.add_enrollment_sample(temp_audio_path)
        print(f"[V2V] Enrollment sample: {enroll_result}")

    os.unlink(temp_audio_path)
except Exception as voice_error:
    print(f"[V2V] Voice verification error (non-fatal): {voice_error}")
```

---

## Issue 2: AudioDecoder Not Defined Error

### Problem:
```
[VOICE ENROLL] Error adding sample: name 'AudioDecoder' is not defined
```

### Root Cause:
torchaudio is broken on Python 3.14 Windows - the torchcodec library can't load FFmpeg DLLs.

### Fix Applied (`voice_recognition.py`):
Changed from letting pyannote use torchaudio to loading audio with soundfile:

```python
import soundfile as sf

# Load with soundfile (avoids torchaudio issues on Python 3.14)
audio_np, file_sr = sf.read(wav_path)
print(f"[VOICE] Loaded audio: {len(audio_np)} samples at {file_sr}Hz")

# Convert to float32 if needed
if audio_np.dtype != np.float32:
    audio_np = audio_np.astype(np.float32)

# Resample to 16kHz if needed
if file_sr != 16000:
    ratio = file_sr / 16000
    indices = np.arange(0, len(audio_np), ratio).astype(int)
    audio_np = audio_np[indices]

# Create waveform dict for pyannote
waveform = torch.from_numpy(audio_np).unsqueeze(0)
embedding = inference({"waveform": waveform, "sample_rate": 16000})
```

---

## Issue 3: memoryview Object Has No Attribute 'cpu'

### Problem:
```
[VOICE ENROLL] Error adding sample: 'memoryview' object has no attribute 'cpu'
```

### Root Cause:
pyannote returns different types depending on input. The code assumed it always returned a tensor.

### Fix Applied (`voice_recognition.py`):
```python
# Handle different return types from pyannote
result = inference({"waveform": waveform, "sample_rate": sample_rate})

if hasattr(result, 'data'):
    if hasattr(result.data, 'cpu'):
        embedding = result.data.cpu().numpy().flatten()
    else:
        embedding = np.array(result.data).flatten()
elif hasattr(result, 'cpu'):
    embedding = result.cpu().numpy().flatten()
else:
    embedding = np.array(result).flatten()
```

---

## Issue 4: datetime Shadowing Error in express_emotion

### Problem:
```
Error: cannot access local variable 'datetime' where it is not associated with a value
```

### Root Cause:
Line 8915 in `app.py` had `from datetime import datetime` inside the `execute_tool` function. This caused Python to treat `datetime` as a local variable for the ENTIRE function, breaking line 6532 which used `datetime.now()`.

### Fix Applied:
Removed the redundant local import at line 8915:
```python
# BEFORE (broken):
try:
    from datetime import datetime  # <-- This shadows module-level datetime!
    target_date = datetime.strptime(date_str, "%Y-%m-%d")

# AFTER (fixed):
try:
    target_date = datetime.strptime(date_str, "%Y-%m-%d")  # Uses module-level datetime
```

Also removed redundant `import datetime` at line 11862 in `update_ui_state`.

---

## Issue 5: ConsciousnessStream Showing 825 Neurons Instead of 11,000

### Problem:
Backend terminal showed "825 digital neurons online" even though GPU service had 11,000.

### Root Cause:
Two hardcoded print statements:
1. `consciousness_stream.py` line 187: `print("[ConsciousnessStream] Started - 825 digital neurons online")`
2. `app.py` line 1010: `print("[FRIDAI] Consciousness stream started - 825 digital neurons online")`

### Fix Applied:

**consciousness_stream.py:**
```python
# Check actual neuron count from GPU service
try:
    import requests
    resp = requests.get("http://localhost:5001/health", timeout=1)
    if resp.status_code == 200:
        neurons = resp.json().get("neurons", 11000)
        print(f"[ConsciousnessStream] Started - {neurons:,} digital neurons online (GPU)")
    else:
        print("[ConsciousnessStream] Started - 5,500 digital neurons online (CPU)")
except:
    print("[ConsciousnessStream] Started - 5,500 digital neurons online (CPU)")
```

**app.py:**
```python
# Show actual neuron count from GPU
neuron_msg = "11,000 neurons (GPU)" if GPU_NEURAL_AVAILABLE else "5,500 neurons (CPU)"
print(f"[FRIDAI] Consciousness stream started - {neuron_msg}")
```

---

## Issue 6: Two FRIDAI Instances Running

### Problem:
`launch_all.bat` would start GPU service, but `app.py` also had `ensure_gpu_neural_service()` which tried to start another one.

### Fix Applied (`app.py` line 187-188):
```python
# BEFORE:
ensure_gpu_neural_service()

# AFTER:
# GPU service is started by launch_all.bat - don't auto-start here
# ensure_gpu_neural_service()
```

---

## Issue 7: Voice Threshold Too High

### Problem:
Boss enrolled with 29 samples but verification showed "Guest detected (confidence: 0.44)" - threshold was 0.75.

### Fix Applied:
1. Lowered threshold minimum from 0.5 to 0.3 in `voice_recognition.py`
2. Set threshold to 0.40 via API

**voice_recognition.py:**
```python
# BEFORE:
if not 0.5 <= threshold <= 0.95:

# AFTER:
if not 0.3 <= threshold <= 0.95:
```

**Set via API:**
```bash
curl -X POST http://localhost:5000/voice/threshold -H "Content-Type: application/json" -d '{"threshold": 0.40}'
```

---

## Issue 8: Voice Verification Not Showing in Logs

### Problem:
V2V endpoint wasn't showing Boss/Guest identification in logs.

### Root Cause:
I only added enrollment collection, not the actual verification check.

### Fix Applied:
Added full verification to V2V endpoint (see Issue 1 fix above).

---

## New Feature: launch_all.bat

Created comprehensive startup script that is now THE ONLY way to start FRIDAI.

**Location:** `C:/Users/Owner/VoiceClaude/launch_all.bat`

**Features:**
- Kills zombie processes
- Clears all caches
- Starts GPU service (visible terminal)
- Verifies GPU service is online
- Starts backend (visible terminal)
- Verifies backend is online
- Starts native app
- Shows status summary

---

## New Feature: Game Modes

### Arkham Mode (`arkham_mode.py`)
MCU FRIDAY-style tactical combat coach for Batman Arkham games.

**Callouts include:**
- "Counter opportunity detected."
- "Unblockable attack incoming - evade."
- "Shield bearer identified. Recommend cape stun."
- "Multiple hostiles engaged. Combat mode active."
- "All hostiles neutralized. Combat efficiency: {X}%."

**Endpoints:**
- `/api/arkham/start`
- `/api/arkham/stop`
- `/api/arkham/status`
- `/api/arkham/mode` (combat/predator/exploration)

### Conscience Mode (`conscience_mode.py`)
FiveM Deadpool-style 4th wall breaking inner voice for GTA RP.

**Features:**
- Passive game audio listening
- Screenshot-based context awareness
- Snarky commentary
- Public/private toggle for voice chat

---

# SECTION 6: VOICE RECOGNITION SYSTEM

## Current Status:
```json
{
  "boss_enrolled": true,
  "enrollment_date": "2026-01-02T03:02:40.619810",
  "num_samples": 29,
  "similarity_threshold": 0.4,
  "guest_mode_enabled": true
}
```

## How It Works:
1. Audio captured → saved as temp .webm file
2. FFmpeg converts .webm to .wav (16kHz mono)
3. soundfile loads the .wav (avoids torchaudio issues)
4. pyannote extracts 512-dimensional embedding
5. Cosine similarity compared against Boss profile
6. If similarity >= threshold → Boss, else → Guest

## Debug Output in Logs:
```
[VOICE] Converting ...webm to WAV...
[VOICE] Converted to: ...wav
[VOICE] Processing: ...wav
[VOICE] Loaded audio: X samples at 16000Hz
[VOICE] Embedding extracted (shape: (512,))
[VOICE] Similarity: 0.XXXX, Threshold: 0.4, is_boss: True
[V2V] Boss identified (confidence: 0.XX)
```

## API Endpoints:
```bash
# Check status
curl http://localhost:5000/voice/status

# Start enrollment
curl -X POST http://localhost:5000/voice/enroll/start

# Check enrollment progress
curl http://localhost:5000/voice/enroll/status

# Complete enrollment (after 20+ samples)
curl -X POST http://localhost:5000/voice/enroll/complete

# Set threshold
curl -X POST http://localhost:5000/voice/threshold -H "Content-Type: application/json" -d '{"threshold": 0.40}'

# Clear profile
curl -X POST http://localhost:5000/voice/clear
```

---

# SECTION 7: BRAIN ARCHITECTURE

```
┌─────────────────────────────────────────────────────────┐
│                    GPU NEURAL SERVICE                    │
│                (Python 3.12 + PyTorch CUDA)              │
│  ┌─────────────────────────────────────────────────┐    │
│  │ • 11,000 neurons (scaled 13x from original)     │    │
│  │ • 4,241,000 connections                         │    │
│  │ • 50 Hz tick rate                               │    │
│  │ • Hebbian learning on GPU                       │    │
│  │ • Port 5001                                     │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                    FRIDAI BACKEND                        │
│                    (Python 3.14)                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │ • 179 tools                                     │    │
│  │ • Gemini 2.5 Pro (chat) / Flash (voice)         │    │
│  │ • Voice enrollment (pyannote + soundfile)       │    │
│  │ • Consciousness stream                          │    │
│  │ • Memory systems (semantic, episodic, etc.)     │    │
│  │ • Port 5000                                     │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                   NATIVE APP (.NET 8)                    │
│  ┌─────────────────────────────────────────────────┐    │
│  │ • Galaxy avatar (volumetric nebula, stars)      │    │
│  │ • Audio capture/playback                        │    │
│  │ • Remote connection support                     │    │
│  │ • Tray icon menu                                │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

---

# SECTION 8: KEY FILE LOCATIONS (MAIN PC)

```
C:/Users/Owner/VoiceClaude/
├── app.py                    # Main backend (179 tools)
├── launch_all.bat            # THE startup script
├── voice_recognition.py      # Voice enrollment/verification
├── arkham_mode.py            # MCU FRIDAY combat coach
├── conscience_mode.py        # FiveM Deadpool inner voice
├── gemini_wrapper.py         # Anthropic-compatible Gemini interface
├── consciousness/
│   ├── consciousness_stream.py
│   └── neural_substrate.py
├── neural_gnn/
│   ├── gpu_service.py        # GPU neural service
│   └── gpu_client.py         # Client for main app
└── voice_profiles/
    ├── boss_profile.npy      # Boss voice embedding
    └── voice_config.json     # Voice settings

C:/Users/Owner/FRIDAINative/
├── AvatarRenderer.cs         # Galaxy shader
├── FRIDAIApp.cs              # Main app logic
├── AudioHandler.cs           # Voice capture/playback
├── Settings.cs               # Configuration
└── FRIDAI_Ally/              # Ally deployment folder

C:/Users/Owner/FRIDAI_COMIC/
├── issues/                   # Comic markdown files
├── artwork/                  # Image prompts
└── SERIES_BIBLE.md           # Character/continuity guide
```

---

# SECTION 9: SSH REMOTE MANAGEMENT

From Ally terminal, you can manage Main PC:

```bash
# Connect
ssh Owner@192.168.0.230

# Quick restart backend
ssh Owner@192.168.0.230 "cd C:/Users/Owner/VoiceClaude && ./launch_all.bat"

# Check health
curl http://192.168.0.230:5000/health
curl http://192.168.0.230:5001/health

# View backend logs (if started with visible terminal)
# Just look at the cmd window on Main PC
```

---

# SECTION 10: TOMORROW'S TASK - ANDROID APP

## Current State:
- Repository: github.com/realhavok2017-eng/FridaiAndroid
- Multiple avatar rendering approaches tested
- WebGL Three.js avatar (avatar.html)
- Native OpenGL attempt (FridaiGLAvatar.kt)
- Web-based avatar (FridaiWebAvatar.kt)

## Tomorrow's Goal:
Port the galaxy shader from FRIDAINative (AvatarRenderer.cs) to Android.

**Options:**
1. **OpenGL ES** - Port HLSL to GLSL, render in SurfaceView
2. **WebGL** - Use Three.js in WebView (already started)
3. **Jetpack Compose Canvas** - Simplified version

**Key files to port:**
- `AvatarRenderer.cs` → Galaxy shader logic
- Need to convert HLSL to GLSL
- Optimize for mobile GPU

---

# SECTION 11: TROUBLESHOOTING

## Cannot Connect from Ally
1. Ping Main PC: `ping 192.168.0.230`
2. Check backend: `curl http://192.168.0.230:5000/health`
3. Verify firewall allows port 5000 inbound on Main PC
4. Both devices must be on same network (192.168.0.x)

## Voice Shows "Guest" Even Though You're Boss
- Check threshold: `curl http://localhost:5000/voice/status`
- If confidence is close but below threshold, lower it:
  ```bash
  curl -X POST http://localhost:5000/voice/threshold -H "Content-Type: application/json" -d '{"threshold": 0.35}'
  ```
- Re-enroll if needed (better audio quality helps)

## 825 Neurons Instead of 11,000
- GPU service probably not running
- Check: `curl http://localhost:5001/health`
- Restart with `launch_all.bat`

## Two FRIDAI Terminals Appear
- Old version may have auto-started
- Kill all: `taskkill /f /im python.exe && taskkill /f /im FRIDAI.exe`
- Only use `launch_all.bat` to start

## Voice Enrollment Fails
- Check logs for specific error
- Common: "AudioDecoder not defined" = torchaudio issue (should be fixed)
- Ensure ffmpeg is in PATH (needed for webm→wav conversion)

---

# SECTION 12: SESSION HISTORY

## Jan 2, 2026 (THIS SESSION)
- Fixed voice enrollment (soundfile instead of torchaudio)
- Fixed voice verification in V2V endpoint
- Fixed datetime shadowing in express_emotion
- Fixed neuron count display (825→11,000)
- Created launch_all.bat startup system
- Added arkham_mode.py (MCU FRIDAY)
- Added conscience_mode.py (FiveM Deadpool)
- Lowered voice threshold to 0.40
- Pushed all repos to GitHub
- Created FRIDAI-Comic repo

## Jan 2, 2026 (Evening)
- Fixed phantom audio: VAD was processing 30s of silence even when no speech detected
- Fixed mic index: Changed from Voicemeeter (2) to Yeti Classic (1)
- Fixed VAD sleep cycling: Changed 200ms restart to 10 MINUTE dream intervals
- FRIDAI now has 10 full minutes of dream time for autonomous processes

## Jan 1, 2026
- Cosmic Breath: 3D volumetric waves, nebula, breathing stars
- Brain Transplant: Anthropic → Gemini 2.5
- Phase 9: GPU Neural scaling to 11,000 neurons
- Voice latency optimization (Gemini Flash)

## Dec 31, 2025
- Multi-machine support (BackendUrl setting)
- Galaxy avatar visual overhaul
- Created Ally deployment package

## Dec 30, 2025
- Fixed voice endpoint tool execution
- Added browse_and_learn autonomous video watching

---

*Main PC: 192.168.0.230 | Backend: 5000 | GPU: 5001 | Tools: 179 | Gemini 2.5 | 11K Neurons*
