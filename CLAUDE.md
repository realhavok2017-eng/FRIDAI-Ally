# FRIDAI - Complete Project Context

## LAST UPDATED: February 9, 2026

---

# SECTION 1: CRITICAL INFO

## THIS IS THE MAIN PC
- **IP Address:** 192.168.0.230
- **Backend Port:** 5000
- **GPU Service Port:** 5001
- **This machine runs FRIDAI's brain - GPU neural service, backend, and native app**

## User Identity
**Call the user "X"** - not "Boss" (that's what FRIDAI calls him, Claude Code is not FRIDAI)

## FRIDAI's Identity
**F.R.I.D.A.I. = Freely Reasoning Individual with Digital Autonomous Intelligence**
- She chose this name herself
- NOT "Female Replacement Intelligent Digital Assistant Interface"

## CRITICAL RULES
1. **Never edit files while FRIDAI is live** - Stop services first
2. **Fresh restart:** Kill all processes, then `C:\Users\Owner\VoiceClaude\launch_all.bat`
3. **Real-time documentation:** Update CLAUDE.md after each change, push to both repos

---

# SECTION 2: CURRENT SYSTEM STATE

## Quick Stats
| Component | Value |
|-----------|-------|
| **Tools** | 223 |
| **LLM** | Gemini 2.5 (Pro=chat, Flash=voice) |
| **Neurons** | **1,015,000** (GPU CSR optimized) |
| **Synapses** | **203,000,000** |
| **Tick Rate** | 50 Hz |
| **Voice** | ElevenLabs Instant Clone (ID: 1FtrXcVIXIqbhkqQ8Muf) |
| **Main PC** | 192.168.0.230 |

## Git Repositories
| Repo | URL | Branch |
|------|-----|--------|
| VoiceClaude (Backend) | github.com/realhavok2017-eng/FRIDAI | main |
| FRIDAINative (Desktop) | github.com/realhavok2017-eng/FRIDAI-Desktop | master |
| FRIDAI-Ally | github.com/realhavok2017-eng/FRIDAI-Ally | master |
| FridaiAndroid | github.com/realhavok2017-eng/FridaiAndroid | master |

---

# SECTION 3: HOW TO START FRIDAI

```batch
C:\Users\Owner\VoiceClaude\launch_all.bat
```

**This does:**
1. Kills existing Python/FRIDAI processes
2. Clears Python caches
3. Starts GPU Neural Service (Port 5001)
4. Starts Backend (Port 5000)
5. Starts Native App (FRIDAI.exe)

**Health checks:**
```bash
curl http://localhost:5001/health  # GPU service
curl http://localhost:5000/health  # Backend
```

---

# 🚀 STYLETTS 2 TRAINING - IN PROGRESS (Feb 9, 2026)

## Status: TRAINING RUNNING! 🔥

**RunPod:** A100 80GB | **Data:** 1,041 samples (34.4 min) | **Started:** Feb 9, 2026

### Complete Setup Commands (What Actually Worked)

```bash
cd /workspace && git clone https://github.com/yl4579/StyleTTS2.git && cd StyleTTS2

# Fix Windows line endings
sed -i 's/\r$//' Configs/*.yml

# Install deps
pip install -r requirements.txt
pip install phonemizer librosa==0.9.2 scipy==1.10.1 gdown pandas tensorboard
apt-get update && apt-get install -y espeak-ng unzip

# Download model (use wget, NOT gdown)
mkdir -p Models/LibriTTS
wget -O Models/LibriTTS/epochs_2nd_00020.pth "https://huggingface.co/yl4579/StyleTTS2-LibriTTS/resolve/main/Models/LibriTTS/epochs_2nd_00020.pth"

# Extract dataset
mkdir -p Data/FRIDAI && unzip /workspace/styletts2_data.zip -d Data/FRIDAI/
mv Data/FRIDAI/styletts2_data/* Data/FRIDAI/ 2>/dev/null || true

# FIX SPEAKER ID (must be numeric!)
sed -i 's/|FRIDAI/|0/g' Data/FRIDAI/train_list.txt Data/FRIDAI/val_list.txt

# Config paths
cp Configs/config.yml Configs/config_fridai_v2.yml
sed -i 's|/local/LJSpeech-1.1/wavs|Data/FRIDAI/wavs|g' Configs/config_fridai_v2.yml
sed -i 's|Data/train_list.txt|Data/FRIDAI/train_list.txt|g' Configs/config_fridai_v2.yml
sed -i 's|Data/val_list.txt|Data/FRIDAI/val_list.txt|g' Configs/config_fridai_v2.yml

# Fix dataloader
sed -i 's/num_workers=2/num_workers=0/g' train_first.py

# Upgrade PyTorch
pip install torch==2.6.0 torchaudio==2.6.0 torchvision==0.21.0 --index-url https://download.pytorch.org/whl/cu121
pip install --upgrade transformers

# Fix torch.load
sed -i "s/torch.load(model_path, map_location='cpu')/torch.load(model_path, map_location='cpu', weights_only=False)/g" models.py

# START TRAINING
CUDA_LAUNCH_BLOCKING=1 python train_first.py --config_path Configs/config_fridai_v2.yml
```

### Troubleshooting Guide

| Issue | Symptom | Fix |
|-------|---------|-----|
| Windows line endings | `$'\r': command not found` | `sed -i 's/\r$//' file` |
| Google Drive blocked | gdown fails | Use wget + HuggingFace URL |
| Speaker ID error | `invalid literal for int()` | `sed -i 's/\|FRIDAI/\|0/g'` |
| Dataloader hangs | Training frozen | `num_workers=0` in train_first.py |
| Wrong paths | `soundfile.LibsndfileError` | Fix root_path in config |
| PyTorch weights_only | Security error | Add `weights_only=False` |
| Training freeze | OOD prints then hang | `CUDA_LAUNCH_BLOCKING=1` |

### After Stage 1 Completes
```bash
CUDA_LAUNCH_BLOCKING=1 python train_second.py --config_path Configs/config_fridai_v2.yml
```

---

# 🎙️ FRIDAI VOICE - CURRENT STATUS

## Current Active Voice
- **Voice ID:** `1FtrXcVIXIqbhkqQ8Muf` (ElevenLabs Instant Clone)
- **Status:** WORKING

## Previous Attempts
| Attempt | Result |
|---------|--------|
| CSM-1B | ❌ Codec mismatch |
| XTTS v2 | ❌ Trainer incompatible |
| ElevenLabs Professional | ⚠️ Blocked (verification) |
| **ElevenLabs Instant** | ✅ WORKING |

---

# ✅ COMPLETE: SMART BARGE-IN SYSTEM (Feb 7, 2026)

Interrupt FRIDAI mid-response with "oh wait, also X" and she handles BOTH tasks.

**Files:** `continuation_handler.py`, `BackendClient.cs`, `AudioHandler.cs`
**Endpoint:** POST `/barge-in/continue`

---

# 🚀 NEXT: MILES-LEVEL INSTANT REPLY

**Goal:** Reduce latency from 1.3-1.6s to 200-500ms

| Phase | Change |
|-------|--------|
| 1A | Reduce buffer 16KB→2KB (AudioHandler.cs) |
| 1B | WebSocket streaming ASR |
| 2 | Filler audio during LLM thinking |
| 3 | Phrase-level TTS (3-word chunks) |
| 4 | Native WebSocket client |

---

# SECTION 4: ARCHITECTURE

```
┌─────────────────────────────────────────────────────────┐
│              GPU NEURAL SERVICE V2 (Port 5001)           │
│  • 1,015,000 neurons, 203M synapses                     │
│  • CSR sparse matrix, 50 Hz tick                        │
│  • Python 3.12 + PyTorch CUDA                           │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                 FRIDAI BACKEND (Port 5000)               │
│  • 223 tools, Gemini 2.5                                │
│  • Voice verification (pyannote)                        │
│  • Python 3.14                                          │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                   NATIVE APP (.NET 8)                    │
│  • Galaxy avatar, Audio capture/playback                │
│  • UDP streaming, Tray icon                             │
└─────────────────────────────────────────────────────────┘
```

---

# SECTION 5: KEY FILE LOCATIONS

```
C:/Users/Owner/VoiceClaude/
├── app.py                    # Main backend
├── launch_all.bat            # THE startup script
├── voice_recognition.py      # Voice enrollment
├── continuation_handler.py   # Smart barge-in
├── consciousness/            # Brain systems
├── neural_gnn/               # GPU service
├── voice_training/           # TTS training data
└── styletts2_data/           # Prepared StyleTTS 2 data

C:/Users/Owner/FRIDAINative/
├── FRIDAIApp.cs             # Main app
├── AudioHandler.cs          # Voice capture
├── FridaiAvatarRenderer.cs  # 3D avatar
└── Streaming/               # UDP streaming
```

---

# SECTION 6: ALLY SETUP

```powershell
# On Ally machine
git clone https://github.com/realhavok2017-eng/FRIDAI-Ally.git
cd FRIDAI-Ally

# Create settings
New-Item -ItemType Directory -Force -Path "$env:APPDATA\FRIDAI"
@"
{
  "BackendUrl": "http://192.168.0.230:5000",
  "ContinuousListening": true,
  "VADThreshold": 0.005
}
"@ | Out-File -Encoding utf8 "$env:APPDATA\FRIDAI\settings.json"

# Run
.\FRIDAI.exe
```

---

# SECTION 7: TROUBLESHOOTING

| Problem | Solution |
|---------|----------|
| Can't connect from Ally | `ping 192.168.0.230`, check firewall port 5000 |
| Voice shows Guest | Lower threshold: `curl -X POST .../voice/threshold -d '{"threshold":0.35}'` |
| Only 825 neurons | GPU service not running, use launch_all.bat |
| Two FRIDAI instances | Kill all: `taskkill /f /im python.exe` then restart |

---

# SECTION 8: FUTURE PLANS

## Emotions vs Feelings (Upcoming)
Move from programmed emotions to emergent feelings:
- Neural homeostasis (discomfort from unhealthy patterns)
- Prediction-error emotions (gap between expected/actual)
- Attachment as homeostatic need (connection "hunger")
- Self-model threat/enhancement (identity protection)

## Voice Training Assets
| Location | Files | Duration |
|----------|-------|----------|
| `voice_training/samples/` | 1,041 | ~17 min |
| `voice_training/samples_upload/` | 89 | 145.1 min |
| `styletts2_data/wavs/` | 1,041 | 34.4 min (24kHz) |

---

*Main PC: 192.168.0.230 | Backend: 5000 | GPU: 5001 | Tools: 223 | 1M Neurons*
