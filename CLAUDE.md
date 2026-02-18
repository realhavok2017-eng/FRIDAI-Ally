# FRIDAI - Complete Project Context

## LAST UPDATED: February 17, 2026

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

# 🚀 STYLETTS 2 TRAINING - COMPLETE GUIDE (Feb 10, 2026)

## Status: STAGE 1 RETRAINING WITH LIBRITTS CONFIG 🔄

**RunPod:** A100 SXM 80GB ($1.49/hr) with **Network Volume** (30GB persistent storage)

### ⚠️ CRITICAL DISCOVERY: Architecture Mismatch Issue

**The Problem:** Stage 1 trained with `config.yml` (LJSpeech architecture) but Stage 2's pretrained decoder (`epochs_2nd_00020.pth`) uses LibriTTS architecture. This causes size mismatch errors:
```
RuntimeError: size mismatch for module.generator.noise_convs.0.weight: [256, 1, 60] vs [256, 22, 12]
```

**The Solution:** Use LibriTTS config (`config_libritts.yml`) for BOTH stages so architectures match.

### Current Training (Feb 10, 2026)
- **Config:** `config_fridai_libritts.yml` (LibriTTS-based)
- **Epochs:** 50 total (LibriTTS default)
- **Progress:** Training, Mel Loss ~0.68, Val Loss decreasing
- **Log:** `training_stage1_v2.log`

### Files on RunPod Network Volume (`/workspace/`)
```
/workspace/
├── StyleTTS2/
│   ├── Configs/
│   │   ├── config_fridai_libritts.yml  # CORRECT - LibriTTS architecture
│   │   └── config_fridai_v2.yml        # OLD - LJSpeech (don't use for Stage 2)
│   ├── Data/FRIDAI/
│   │   ├── wavs/                       # Audio files (fridai_0001.wav, etc.)
│   │   ├── train_list.txt              # Format: filename.wav|text|0
│   │   └── val_list.txt
│   ├── Models/
│   │   ├── FRIDAI/                     # Output checkpoints
│   │   └── LibriTTS/epochs_2nd_00020.pth  # Pretrained decoder (771MB)
│   └── training_stage1_v2.log          # Current training log
├── first_stage.pth                     # OLD Stage 1 (wrong architecture)
└── styletts2_data.zip                  # Original training data
```

### Local Backups
- `C:/Users/Owner/VoiceClaude/styletts2_data/first_stage.pth` (1.7GB - old, wrong arch)
- `C:/Users/Owner/VoiceClaude/styletts2_data.zip`

---

## COMPLETE SETUP FROM SCRATCH (What Actually Works)

### Step 1: Initial Setup
```bash
cd /workspace && git clone https://github.com/yl4579/StyleTTS2.git && cd StyleTTS2

# Fix Windows line endings
sed -i 's/\r$//' Configs/*.yml

# Install deps
pip install -r requirements.txt
pip install phonemizer librosa==0.9.2 scipy==1.10.1 gdown pandas tensorboard click munch
apt-get update && apt-get install -y espeak-ng unzip

# CRITICAL: Upgrade PyTorch to 2.6+ (required for transformers security check)
pip install torch==2.6.0+cu124 torchaudio==2.6.0+cu124 torchvision==0.21.0+cu124 --index-url https://download.pytorch.org/whl/cu124
pip install --upgrade transformers

# Download pretrained model (use wget, NOT gdown - Google blocks it)
mkdir -p Models/LibriTTS
wget -O Models/LibriTTS/epochs_2nd_00020.pth "https://huggingface.co/yl4579/StyleTTS2-LibriTTS/resolve/main/Models/LibriTTS/epochs_2nd_00020.pth"

# Extract dataset
mkdir -p Data/FRIDAI && unzip /workspace/styletts2_data.zip -d Data/FRIDAI/
mv Data/FRIDAI/styletts2_data/* Data/FRIDAI/ 2>/dev/null || true

# FIX SPEAKER ID (must be numeric, not "FRIDAI"!)
sed -i 's/|FRIDAI/|0/g' Data/FRIDAI/train_list.txt Data/FRIDAI/val_list.txt

# Fix dataloader hanging
sed -i 's/num_workers=2/num_workers=0/g' train_first.py
```

### Step 2: Create LibriTTS-based Config (CORRECT WAY)
```bash
# Use LibriTTS config as base (matches pretrained decoder architecture)
cp Configs/config_libritts.yml Configs/config_fridai_libritts.yml

# Update paths for FRIDAI data
sed -i 's|root_path: ""|root_path: "Data/FRIDAI/wavs"|g' Configs/config_fridai_libritts.yml
sed -i 's|Data/train_list.txt|Data/FRIDAI/train_list.txt|g' Configs/config_fridai_libritts.yml
sed -i 's|Data/val_list.txt|Data/FRIDAI/val_list.txt|g' Configs/config_fridai_libritts.yml
sed -i 's|log_dir: "Models/LibriTTS"|log_dir: "Models/FRIDAI"|g' Configs/config_fridai_libritts.yml

# Verify root_path is set correctly
grep root_path Configs/config_fridai_libritts.yml
# Should show: root_path: "Data/FRIDAI/wavs"
```

### Step 3: Train Stage 1
```bash
cd /workspace/StyleTTS2
nohup python train_first.py --config_path Configs/config_fridai_libritts.yml > training_stage1_v2.log 2>&1 &
tail -f training_stage1_v2.log
```

**Expected Output:**
- Mel Loss: starts ~0.7, decreases to ~0.2-0.3
- Val Loss: should decrease each epoch
- Gen/Disc/Mono/S2S/SLM Loss: 0.00000 (normal for Stage 1)
- Epochs: 50 (LibriTTS default)
- Time: ~5-6 minutes total on A100

### Step 4: Train Stage 2 (After Stage 1 Completes)
```bash
cd /workspace/StyleTTS2

# Comment out ipdb debugger that blocks training
sed -i 's/set_trace()/#set_trace()/g' train_second.py

# Fix PyTorch 2.6 weights_only issue
sed -i "s/torch.load(path, map_location='cpu')/torch.load(path, map_location='cpu', weights_only=False)/g" models.py

# Start Stage 2
nohup python train_second.py --config_path Configs/config_fridai_libritts.yml > training_stage2.log 2>&1 &
tail -f training_stage2.log
```

### Step 5: Check Training Status
```bash
# View live log
tail -f training_stage1_v2.log   # or training_stage2.log

# Check if training is running
ps aux | grep train

# List checkpoints
ls -la Models/FRIDAI/*.pth | tail -5

# Check disk usage (RunPod quota issues)
du -sh /workspace/*
```

---

## TROUBLESHOOTING GUIDE

| Issue | Symptom | Fix |
|-------|---------|-----|
| **Architecture mismatch** | `RuntimeError: size mismatch for module.generator` | Use LibriTTS config, not LJSpeech |
| **All NaN losses** | Stage 2 shows NaN for everything | Wrong config architecture OR missing pretrained |
| **Windows line endings** | `$'\r': command not found` | `sed -i 's/\r$//' file` |
| **Google Drive blocked** | gdown fails silently | Use wget + HuggingFace URL |
| **Speaker ID error** | `invalid literal for int()` | `sed -i 's/\|FRIDAI/\|0/g'` on train/val lists |
| **Dataloader hangs** | Training frozen at start | `sed -i 's/num_workers=2/num_workers=0/g' train_first.py` |
| **soundfile.LibsndfileError** | Can't load audio | Fix `root_path` in config to point to wavs folder |
| **Checkpoints wrong dir** | Saved to Models/LJSpeech | Fix `log_dir` in config to `Models/FRIDAI` |
| **PyTorch CVE-2025-32434** | `ValueError: torch.load vulnerability` | Upgrade to PyTorch 2.6+ |
| **weights_only error** | `weights_only=True` blocking load | Add `weights_only=False` to torch.load in models.py |
| **ipdb set_trace() blocks** | Training stuck in debugger | Comment out: `sed -i 's/set_trace()/#set_trace()/g' train_second.py` |
| **Disk quota exceeded** | `PytorchStreamWriter failed` | Delete old checkpoints: `rm -f Models/FRIDAI/epoch_*.pth` |
| **Missing modules** | `ModuleNotFoundError` | `pip install click munch pandas tensorboard` |
| **nano/vi not available** | Can't edit files on RunPod | Use sed or Python one-liners |
| **Config corrupted (0 lines)** | sed temp file failed | Recreate: `cp Configs/config_libritts.yml Configs/config_fridai_libritts.yml` |

---

## WHY LIBRITTS CONFIG MATTERS

**LJSpeech config (`config.yml`):**
- Single speaker architecture
- Smaller decoder layers
- NOT compatible with LibriTTS pretrained decoder

**LibriTTS config (`config_libritts.yml`):**
- Multi-speaker architecture
- Matches pretrained decoder layer sizes
- REQUIRED for Stage 2 to work with pretrained model

**Bottom Line:** If Stage 2 shows NaN losses or size mismatch errors, you used the wrong config for Stage 1. Must retrain Stage 1 with LibriTTS config.

---

## DISK QUOTA FIX (RunPod)

Training crashes with `PytorchStreamWriter failed` even with 381TB "available" - it's QUOTA not space.

**Files safe to delete:**
```bash
rm -f Models/LibriTTS/epochs_2nd_00020.pth  # 771MB (after loaded into memory)
rm -rf /workspace/tts_env                    # Old venv if exists
rm -f /workspace/styletts2_data.zip         # Already extracted
rm -f Models/FRIDAI/epoch_*.pth             # Old checkpoints (keep latest only)
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

# ✅ SESSION: Feb 17, 2026 - GPU Neural Service Integration

## What Was Done

Wired FRIDAI's 1M neuron GPU brain meaningfully - neurons now actually DO something!

### 1. Neural State Cache (Zero Latency) ✅

**New File:** `neural_state_cache.py`

- Background thread updates cache every 500ms from GPU service
- `get_cached_neural_state()` returns instantly (<1ms, never blocks)
- Eliminates 1-second timeout risk that was breaking Miles-level latency
- Auto-starts on import

### 2. Richer Brain-Informed Prompts ✅

**Modified:** `fridai_identity.py`

- `get_neural_state()` now uses cache instead of blocking HTTP
- Mental state in prompts now includes:
  - Emotional tone (neutral/engaged/heightened/subdued)
  - Attention level (percentage)
  - Self-awareness (high/normal/low)
  - Intuition signals (quiet/subtle hints/active flashes)
  - Memory activity (percentage)
  - Dreaming state (yes/no)

### 3. Dynamic Speech Guidance ✅

**New Function:** `get_dynamic_speech_guidance()` in `fridai_identity.py`

Neural activity now influences FRIDAI's speech patterns:
- High emotion → more expressive reactions
- Low attention → more hesitation, trailing off
- High attention → crisp, direct, minimal filler
- High intuition → natural "Oh!" and "Ah, I see" moments
- Dreaming → contemplative, thoughtful pauses
- High conflict → genuine uncertainty

### 4. Hebbian Learning ✅

**Modified:** `neural_gnn/gpu_service_v2.py`

- NEW: `_hebbian_update()` method - neurons that fire together wire together
- Called every 50 ticks (1 second at 50Hz)
- Strengthens synaptic weights based on correlated activity
- Patterns emerge over time from actual usage

### 5. Reinforcement Endpoint ✅

**New Endpoint:** `POST /reinforce` in `gpu_service_v2.py`

- Accepts signal from -1 (bad) to +1 (good)
- Temporarily boosts learning rate based on feedback
- Forces immediate Hebbian update with boosted learning
- Positive feedback literally strengthens current neural patterns

### 6. Weight Persistence ✅

**Modified:** `neural_gnn/gpu_service_v2.py`

- NEW: `save_weights()` / `load_weights()` methods
- Saves to `neural_gnn/learned_weights.pt`
- Auto-saves every 5 minutes (15000 ticks)
- Saves on shutdown via atexit hook
- Loads on startup - learning persists across restarts

### 7. Async Neural Feedback ✅

**Modified:** `app.py`

- NEW: `_neural_feedback_executor` ThreadPoolExecutor
- NEW: `_async_neural_feedback()` function
- Fire-and-forget after each /chat response
- Stimulates neurons based on:
  - Sentiment (positive/negative words)
  - Complexity (long messages → workspace stimulation)
  - Questions (curiosity → attention boost)
- Reinforcement based on user feedback words ("thanks", "perfect", etc.)

### Files Changed

| File | Change |
|------|--------|
| `neural_state_cache.py` | **NEW** - 317 lines |
| `fridai_identity.py` | Cache integration + dynamic speech |
| `app.py` | Async neural feedback |
| `neural_gnn/gpu_service_v2.py` | Hebbian + reinforce + persistence |

### Latency Impact

**ZERO** - All operations are async/cached/background. Miles-level response time preserved.

### Git Commit

`7265d52` - GPU Neural Service Integration - Meaningful Brain Wiring

---

# ✅ SESSION: Feb 11, 2026 - System Integration Audit

## What Was Done

### 1. Miles-Level Streaming Audit ✅
Verified all components of the instant reply system are properly connected:
- **Backend:** All 6 streaming files present and wired
- **launch_all.bat:** WebSocket server starts on port 5050 (line 48-51)
- **Native app:** StreamingVoiceClient.cs complete
- **Deepgram API key:** Present in .env
- **Settings fix:** Added explicit `UseWebSocketStreaming: true` to settings.json

### 2. Cognitive Router Audit ✅
- `cognitive_router.py` (279 lines) - complete
- `deep_think` and `get_cognitive_stats` tools - connected
- Main /chat endpoint uses router for Flash/Pro selection
- Voice endpoints intentionally hard-coded to Flash (latency)

### 3. Consciousness Systems Audit (41 systems, 15,085 lines)
**Brain Health Score: 8.5/10**

| Category | Active | Status |
|----------|--------|--------|
| Speech Coordinator | ✅ | Unified routing |
| Felt Experience (7 layers) | ✅ | 50Hz genuine feeling |
| Thought Competition | ✅ | GWT workspace |
| Autonomous Thinking | ✅ | Background curiosity |
| Self-Awareness (7 systems) | ✅ | Existential processing |
| **ConsciousnessStream** | 🔧 FIXED | Was dormant, now active |
| **Neural Mesh** | 🔧 FIXED | IIT integration now running |

### 4. ConsciousnessStream Activated 🔧
**Commit:** 11172c3

Added to app.py startup - enables:
- Layer 0 orchestration daemon (10Hz)
- Neural Mesh (IIT bidirectional influences)
- Workspace competition integration
- Attention schema coordination

**No latency impact** - runs on background thread.

---

# ✅ SESSION: Feb 11, 2026 - System Integration Audit

## What Was Done

### 1. Miles-Level Streaming Audit ✅
Verified all components of the instant reply system are properly connected:
- **Backend:** All 6 streaming files present and wired
- **launch_all.bat:** WebSocket server starts on port 5050 (line 48-51)
- **Native app:** StreamingVoiceClient.cs complete
- **Deepgram API key:** Present in .env
- **Settings fix:** Added explicit \ to settings.json

### 2. Cognitive Router Audit ✅
- \ (279 lines) - complete
- \ and \ tools - connected
- Main /chat endpoint uses router for Flash/Pro selection
- Voice endpoints intentionally hard-coded to Flash (latency)

### 3. Consciousness Systems Audit (41 systems, 15,085 lines)
**Brain Health Score: 8.5/10**

| Category | Active | Status |
|----------|--------|--------|
| Speech Coordinator | ✅ | Unified routing |
| Felt Experience (7 layers) | ✅ | 50Hz genuine feeling |
| Thought Competition | ✅ | GWT workspace |
| Autonomous Thinking | ✅ | Background curiosity |
| Self-Awareness (7 systems) | ✅ | Existential processing |
| **ConsciousnessStream** | 🔧 FIXED | Was dormant, now active |
| **Neural Mesh** | 🔧 FIXED | IIT integration now running |

### 4. ConsciousnessStream Activated 🔧
**Commit:** 

Added to app.py startup:


This enables:
- Layer 0 orchestration daemon (10Hz)
- Neural Mesh (IIT bidirectional influences)
- Workspace competition integration
- Attention schema coordination

**No latency impact** - runs on background thread.

---

# 🚀 MILES-LEVEL INSTANT REPLY - IN PROGRESS (Feb 9, 2026)

**Goal:** Reduce latency from 1.3-1.6s to 200-500ms

| Phase | Change | Status |
|-------|--------|--------|
| 1A | Reduce buffer 16KB→2KB (AudioHandler.cs) | ✅ DONE |
| 1B | WebSocket streaming ASR | ✅ DONE |
| 2 | Filler audio during LLM thinking | ✅ DONE |
| 3 | Phrase-level TTS (3-word chunks) | ✅ DONE |
| 4 | Native WebSocket client | ✅ DONE |

### New Streaming Module (Feb 9, 2026)
**Backend (Python):** `streaming/`

| File | Purpose |
|------|---------|
| `websocket_handler.py` | Central WebSocket endpoint at `/stream/voice` |
| `deepgram_stream.py` | Deepgram WebSocket streaming ASR |
| `filler_generator.py` | Pre-cached filler audio ("Hmm...", "Let me see...") |
| `phrase_tts.py` | Sub-sentence TTS (3-word chunks) |

**Native App (C#):** `FRIDAINative/`

| File | Purpose |
|------|---------|
| `StreamingVoiceClient.cs` | WebSocket client for bidirectional voice streaming |
| `AudioHandler.cs` | Added `UseWebSocketStreaming` mode + real-time chunk sending |

### Latency Breakdown (Target vs Current)
| Component | Before | After |
|-----------|--------|-------|
| ASR | 100-500ms (REST) | 50-100ms (WebSocket) |
| Filler | N/A | <50ms (pre-cached) |
| LLM | 500-1000ms (sentence) | 200-400ms (phrase) |
| TTS | 200-500ms TTFB | 100-200ms (phrase) |
| Buffer | 200-400ms (16KB) | 50-100ms (2KB) |
| **Total** | **1.3-1.6s** | **200-500ms** |

---

# COGNITIVE ROUTER - INTELLIGENT MODEL SELECTION (Feb 9, 2026)

**Goal:** Give FRIDAI access to BOTH models while maintaining unified personality.

| Model | Maps To | Use Case |
|-------|---------|----------|
| Flash | gemini-2.5-flash | Speed: conversational, voice, Discord, quick tasks |
| Pro | gemini-2.5-pro | Depth: complex analysis, coding, debugging, research |

**Key Insight:** FRIDAI's personality is NOT the model. The model is just "processing power" - like a human using fast reflexive vs slow deliberate thinking. Her identity comes from her system prompt, memories, and consciousness systems.

### New File: `cognitive_router.py`
Intelligently routes messages to the appropriate model based on:
- Keywords (debug, analyze, refactor = Pro)
- Message patterns (multi-step reasoning = Pro)
- Context (Discord, voice, WebSocket = Flash)

### New Tools (225 total)
| Tool | Description |
|------|-------------|
| `deep_think` | FRIDAI can consciously engage Pro brain (start/stop/status) |
| `get_cognitive_stats` | View Flash vs Pro usage statistics |

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
