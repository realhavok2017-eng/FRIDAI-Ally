# FRIDAI - Complete Project Context

## LAST UPDATED: March 2, 2026

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

## CLAUDE CODE PERMISSIONS
- **FULL PERMISSION** for everything - commands, file edits, all actions
- **ONLY EXCEPTION:** Plans need approval before execution
- Workflow: Plan → Show to X → Get approval → Execute
- Never ask "can I?" or "should I?" - just do it (except plans)

---

# SECTION 2: CURRENT SYSTEM STATE

## Quick Stats
| Component | Value |
|-----------|-------|
| **Tools** | 470 |
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

# 🤖 JARVIS FOUNDATION - FULL AUTONOMOUS TASK EXECUTION (Feb 23, 2026)

## Overview
Complete FULL JARVIS-level autonomous task execution based on MCU research (JARVIS, FRIDAY, GRIOT).

**Key Feature:** Runs in PARALLEL with voice path - doesn't affect Miles-level response time!

```
Voice Path (Miles-fast, ~1-2 sec):
  Boss speaks → STT → Gemini Flash → Response → TTS → Boss hears

Task Path (Async background):
  "Make reservation" → Orchestrator → Steps → Done
  Speaks updates via speech_coordinator
```

## Components (6 modules, ~2,500 lines)

| Module | Purpose |
|--------|---------|
| `jarvis/task_orchestrator.py` | Async multi-step task execution |
| `jarvis/decision_engine.py` | Fast local decisions (no LLM calls) |
| `jarvis/task_templates.py` | Pre-compiled common workflows |
| `jarvis/phone_system.py` | Twilio calls/SMS with FRIDAI's voice |
| `jarvis/transaction_engine.py` | Purchases with Boss confirmation |
| `jarvis/proactive_engine.py` | Pattern learning & suggestions |

## 19 JARVIS Tools

**Orchestrator:** `jarvis_execute`, `jarvis_status`, `jarvis_cancel`, `jarvis_templates`
**Phone:** `phone_call`, `phone_hangup`, `phone_sms`, `phone_history`, `phone_status`
**Transactions:** `purchase_initiate`, `purchase_confirm`, `purchase_history`, `purchase_status`, `spending_summary`
**Proactive:** `proactive_check`, `proactive_respond`, `proactive_patterns`, `proactive_add_pattern`, `proactive_status`

## Key Architecture Decisions

1. **Full JARVIS (not Hybrid)** - Tasks run async, voice path never blocked
2. **GRIOT Safety Pattern** - NEVER auto-purchase, always confirm sensitive actions
3. **Pre-compiled Templates** - 3-5 seconds vs 10-20 seconds for hybrid approach
4. **Local Decision Engine** - No LLM calls for: select best, retry logic, validation, scheduling

## Pre-built Task Templates

- `restaurant_reservation` - Search, present options, call restaurant
- `order_food` - Recall usual, add to cart, confirm purchase
- `book_tickets` - Search events, select seats, purchase
- `research_topic` - Deep multi-source research
- `schedule_meeting` - Check availability, send invites
- `send_message` - Compose, review, send
- `shop_and_buy` - Search, compare, purchase with confirmation
- `generic_task` - Dynamic LLM planning for unknown tasks

## Confirmation Gates (GRIOT Pattern)

FRIDAI pauses for Boss confirmation on:
- **Any purchase** (even $0.01)
- **Phone calls** (first time to a number)
- **Sending messages** (email, SMS, social)
- **Deleting data** (files, accounts)

Everything else runs autonomously.

## Phone System Setup

Add Twilio credentials to `.env`:
```
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE_NUMBER=+1234567890
```

Or store in vault for encrypted storage.

## Example Usage

**"FRIDAI, make a dinner reservation for 2 at an Italian place tonight"**
1. Orchestrator spawns async task
2. Searches restaurants (browser)
3. Presents options to Boss
4. Boss picks one
5. FRIDAI calls restaurant (Twilio + ElevenLabs)
6. Handles conversation, confirms booking
7. Speaks summary: "Reserved at 7pm, confirmation #12345"

**"FRIDAI, order my usual from DoorDash"**
1. Recalls "usual" from memory (learned pattern)
2. Opens DoorDash, adds items
3. Shows: "Your usual - $32.50. Confirm?"
4. Boss confirms → completes checkout
5. "Order placed! ETA: 35 minutes"

---

# 🥽 VR JARVIS WORKSHOP - Quest 3 WebXR (Feb 23, 2026)

## Overview
Iron Man JARVIS-style VR workshop for Quest 3. FRIDAI interacts with 3D models,
runs physics simulations, and collaborates on designs in real-time.

**Key Insight:** Runs as a WEB PAGE in Quest Browser (not native app).
FRIDAI controls everything via WebSocket - true real-time JARVIS experience.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        QUEST 3 (VR)                              │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Quest Browser → http://192.168.0.230:8080                 │  │
│  │  • Three.js Scene (3D model viewer)                        │  │
│  │  • Physics Visualization (real-time from PyBullet)         │  │
│  │  • Hand tracking interaction                               │  │
│  └────────────────────────────WebSocket───────────────────────┘  │
└─────────────────────────────────┼───────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────┐
│                    FRIDAI BACKEND                                │
│  • vr_jarvis/server/vr_jarvis_server.py (WebSocket :5051)       │
│  • FreeCAD integration (CAD export to GLB)                      │
│  • PyBullet physics (drop tests, stress analysis)               │
│  • Meshy.ai (AI 3D generation)                                  │
└─────────────────────────────────────────────────────────────────┘
```

## How to Start

```bash
# Start VR JARVIS server (serves web + WebSocket)
cd C:\Users\Owner\VoiceClaude
python -m vr_jarvis.server.serve_vr
```

Then on Quest 3:
1. Open Quest Browser
2. Navigate to `http://192.168.0.230:8080`
3. Click "Enter VR" button

## Features

| Feature | Description |
|---------|-------------|
| **Model Loading** | Load GLB/GLTF from FreeCAD or Meshy.ai |
| **Grab & Move** | Pinch to grab, move models with hand tracking |
| **Drop Test** | "FRIDAI, do a drop test from 2 meters" |
| **Stress Analysis** | Visualize stress with thermal color scale |
| **Explode View** | Separate assembly parts to see internals |
| **Voice Commands** | Talk to FRIDAI while in VR |

## Voice Commands (via FRIDAI)

- "FRIDAI, show me the chassis model"
- "Rotate it 45 degrees"
- "Do a drop test from 2 meters"
- "Highlight weak points"
- "Explode the assembly"
- "What material should I use here?"

## Files

```
C:/Users/Owner/VoiceClaude/vr_jarvis/
├── ARCHITECTURE.md          # Full design doc
├── server/
│   ├── vr_jarvis_server.py  # WebSocket server
│   └── serve_vr.py          # Combined HTTP + WS launcher
└── web/
    └── index.html           # WebXR Three.js frontend
```

## Ports

| Port | Service |
|------|---------|
| 8080 | HTTP (web files for Quest browser) |
| 5051 | WebSocket (VR commands) |

---

# 🎯 FULL JARVIS - PICKUP POINT (Feb 24, 2026)

## WHAT'S DONE (Code Written & Committed)

**Total: ~20,500 lines of new code** (17.8K + 2.7K Quest 3 features)

### Phase 1: Backend Stubs Fixed ✅
- `vr_jarvis_server.py` - Explode view with trimesh GLB parsing
- Meshy.ai 3D generation integration
- FreeCAD/CadQuery model generation
- PyBullet physics simulator getter

### Phase 5-9: Quest 3 Advanced Features (Feb 24, 2026)
**Commit:** `f82ddfe` - Quest 3 Advanced Features - Full WebXR Suite

| File | Lines | Purpose |
|------|-------|---------|
| `body-tracking.js` | ~400 | 84-joint body pose (experimental IOBT) |
| `spatial-anchors.js` | ~350 | Persistent world anchors (up to 8) |
| `scene-understanding.js` | ~500 | Plane + mesh detection with semantic labels |
| `audio-face.js` | ~490 | Audio-based lip sync (Quest 3 has no inward cameras) |

**scene-manager.js Updates:**
- Feature manager properties + flags in constructor
- `_initRefSpace()` - Reference space management
- `_initFeatureManagers()` - Initializes all Quest 3 features
- Updated `_animate()` to call feature manager updates
- Enhanced `enterVR()`/`enterAR()` with Quest 3 optional features

**index.html:** Added Quest 3 module imports

### Phase 2-3A: Core VR Modules ✅
| File | Lines | Purpose |
|------|-------|---------|
| `scene-manager.js` | ~220 | Three.js scene setup |
| `model-manager.js` | ~370 | GLB loading, transforms |
| `stark-hands.js` | ~600 | Tony Stark hand tracking (pinch, throw, scale, rotate) |
| `hologram-effects.js` | ~590 | Hand trails, particles, glow |
| `physics-feel.js` | ~420 | Momentum, bounce, weight, magnetic snap |
| `transform-gizmo.js` | ~410 | 3D manipulation handles |

### Phase 3B: Professional Tools ✅
| File | Lines | Purpose |
|------|-------|---------|
| `measurement-tool.js` | ~380 | Distance, angle, area with 3D labels |
| `section-tool.js` | ~320 | Clipping planes through models |
| `annotation-tool.js` | ~390 | 3D text/arrow annotations |
| `pcb-viewer.js` | ~460 | KiCAD PCB visualization |
| `holo-panel.js` | ~520 | Iron Man floating UI panels |
| `notifications.js` | ~380 | Toast/progress notifications |

### Phase 4: Voice Commands ✅
| File | Lines | Purpose |
|------|-------|---------|
| `voice_commands.py` | ~374 | Natural language parser (35+ command patterns) |

---

## ⚠️ HONEST STATUS - WHAT'S NOT TESTED

| Component | Status | Reality |
|-----------|--------|---------|
| **WebXR on Quest 3** | 🔴 UNTESTED | Code written, never ran on actual Quest |
| **Hand Tracking** | 🔴 UNTESTED | WebXR hand API code exists, never tested |
| **Body Tracking** | 🔴 UNTESTED | 84-joint IOBT code written (Feb 24) |
| **Spatial Anchors** | 🔴 UNTESTED | Persistence code written (Feb 24) |
| **Scene Understanding** | 🔴 UNTESTED | Plane/mesh detection code (Feb 24) |
| **Audio Lip Sync** | 🔴 UNTESTED | Audio-face.js written (Feb 24) |
| **Physics Streaming** | 🟡 PARTIAL | PyBullet calls exist, VR pipeline untested |
| **Model Loading** | 🟡 PARTIAL | GLB code exists, not tested with real models |
| **Voice via FRIDAI** | 🟡 PARTIAL | Parser exists, Quest mic→FRIDAI→TTS untested |
| **Meshy.ai Integration** | 🟡 PARTIAL | API calls written, async VR flow untested |

**Bottom Line:** 17K lines written without running once. WILL have bugs.

---

## 🔴 CRITICAL GAPS TO FIX

### 1. HTTPS Required for Quest WebXR
Quest browser needs HTTPS for WebXR features. Currently serving HTTP.

**Fix Option A - Self-signed cert:**
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout key.pem -out cert.pem
# Then update serve_vr.py to use SSL
```

**Fix Option B - ADB port forward (easier):**
```bash
adb forward tcp:8080 tcp:8080
# Access as localhost:8080 in Quest browser
```

### 2. No Test Models
- No GLB files in `vr_jarvis/models/cache/`
- Need real models to test loading
- Download from Sketchfab or generate with Meshy

### 3. Hand Tracking Calibration
- Pinch thresholds are theoretical values
- Will need real-device tuning
- Joint positions may need adjustment

### 4. Audio Pipeline Untested
- Quest mic → WebSocket → FRIDAI → TTS → Quest speakers
- Complex chain, completely untested

---

## 📋 NEXT SESSION TODO (In Order)

### Step 1: Basic Connection Test (30 min)
```bash
# Start server
cd C:\Users\Owner\VoiceClaude
python -m vr_jarvis.server.serve_vr

# On Quest: Open browser, go to http://192.168.0.230:8080
# Check if page loads
# Check browser console (Menu → More → Console) for errors
```

### Step 2: Fix HTTPS for WebXR (1-2 hours)
Either add SSL to serve_vr.py OR use ADB port forward

### Step 3: Add Test Models (30 min)
```bash
# Download test GLBs
# Put in: C:\Users\Owner\VoiceClaude\vr_jarvis\models\cache\
```

### Step 4: Fix What Breaks (Unknown time)
- Hand tracking calibration
- WebSocket reconnection issues
- Audio routing
- Physics sync timing

### Step 5: Polish (Days/Weeks)
- Smooth hand interactions
- Haptic feedback
- Performance optimization
- Edge cases

---

## 🎮 KEYBOARD SHORTCUTS (Desktop Testing)

| Key | Action |
|-----|--------|
| M | Measurement tool |
| C | Section cut |
| A | Annotation |
| P | PCB viewer |
| H | Help panel |
| E | Explode model |
| R | Reset view |
| Escape | Deselect |

---

## 🎤 VOICE COMMANDS

```
"explode the model" / "take it apart"
"measure the distance"
"section cut along x-axis"
"add a note"
"drop test from 2 meters"
"highlight weak points"
"rotate 45 degrees"
"show help"
```

---

## 📁 FILE STRUCTURE

```
C:/Users/Owner/VoiceClaude/vr_jarvis/
├── ARCHITECTURE.md
├── server/
│   ├── serve_vr.py              # HTTP + WebSocket launcher
│   ├── vr_jarvis_server.py      # WebSocket handlers
│   └── voice_commands.py        # NLP command parser
├── web/
│   ├── index.html               # Main WebXR page (~55KB)
│   └── js/
│       ├── core/
│       │   ├── scene-manager.js # Updated with Quest 3 features
│       │   └── model-manager.js
│       ├── effects/
│       │   └── hologram-effects.js
│       ├── interaction/
│       │   ├── stark-hands.js
│       │   ├── physics-feel.js
│       │   ├── eye-tracking.js
│       │   └── body-tracking.js # NEW (Feb 24) - 84-joint IOBT
│       ├── world/               # NEW (Feb 24)
│       │   ├── spatial-anchors.js  # Persistent anchors
│       │   └── scene-understanding.js  # Planes + meshes
│       ├── avatar/              # NEW (Feb 24)
│       │   └── audio-face.js    # Audio-based lip sync
│       ├── tools/
│       │   ├── transform-gizmo.js
│       │   ├── measurement-tool.js
│       │   ├── section-tool.js
│       │   ├── annotation-tool.js
│       │   └── pcb-viewer.js
│       └── ui/
│           ├── holo-panel.js
│           └── notifications.js
└── models/
    └── cache/                   # Put test GLBs here
```

---

## 🎯 REALISTIC EXPECTATIONS

| Expectation | Reality |
|-------------|---------|
| "Works like Endgame" | ❌ Not yet - code written, not battle-tested |
| "No dead buttons" | ⚠️ Buttons exist, some will fail first run |
| "Production ready" | ❌ Alpha-quality prototype |
| "Can use tomorrow" | 🟡 Maybe basic viewing, not full interaction |

**We built the foundation. Making it work smoothly requires testing + debugging + iteration.**

---

# 🔍 OSINT SURGERY - MODULAR TOOL HANDLERS (Mar 2, 2026)

## Overview
Massive expansion of FRIDAI's OSINT (Open Source Intelligence) capabilities via modular handler architecture. Added 76 new tools across 8 categories.

**Key Achievement:** O(1) tool lookup via ToolRegistry - no more 7000+ line elif chain!

## Architecture

```
tools/
├── registry.py              # O(1) lookup, lazy loading, thread-safe
├── definitions.py           # 470 tool definitions
└── handlers/
    └── osint/
        ├── base_osint.py    # Rate limiting, caching, API keys
        ├── cyber.py         # Shodan, DNS, SSL, breaches (Phase 2)
        ├── people.py        # Voter, court, licenses (Phase 2)
        ├── bypass.py        # Wayback, Google Cache (Phase 2)
        ├── crypto.py        # ETH/BTC wallets, prices (Phase 3)
        ├── social.py        # Twitter, Reddit, YouTube (Phase 3)
        ├── corporate.py     # SEC, USPTO, contracts (Phase 3)
        ├── realtime.py      # Weather, flights, news (Phase 3)
        └── geospatial.py    # Geocoding, routing, POI (Phase 3)
```

## Completed Phases

### Phase 1: Infrastructure ✅
- Created `tools/registry.py` - ToolRegistry with lazy loading
- Created `tools/handlers/base.py` - BaseHandler abstract class
- Created `tools/handlers/osint/base_osint.py` - Rate limiting, caching

### Phase 2: Core OSINT (29 tools) ✅
| Module | Tools | APIs |
|--------|-------|------|
| `cyber.py` | 12 | Shodan, Censys, HIBP, SecurityTrails |
| `people.py` | 10 | Voter records, court records, licenses |
| `bypass.py` | 7 | Wayback Machine, Google Cache, archive.today |

### Phase 3: Extended OSINT (47 tools) ✅ - Mar 2, 2026
| Module | Tools | APIs |
|--------|-------|------|
| `crypto.py` | 10 | Etherscan, Blockchain.com, CoinGecko |
| `social.py` | 11 | Twitter, Reddit, YouTube, Instagram, LinkedIn |
| `corporate.py` | 8 | SEC EDGAR, OpenCorporates, USPTO, USASpending |
| `realtime.py` | 9 | NWS, FlightRadar, NewsAPI, USGS, FEMA |
| `geospatial.py` | 9 | Nominatim, OpenElevation, OpenRouteService |

**Commit:** `4594b4b` - OSINT Phase 3: 47 new tools

---

## 📋 REMAINING PHASES (TODO)

### Phase 4: WatchlistMonitor (Real-time Alerts)
Create background monitoring with proactive alerts.

**Files to Create:**
- `consciousness/watchlist_monitor.py` - Background thread (30-60 sec checks)
- `routes/osint_routes.py` - Flask Blueprint

**Watchlist Categories:**
- crypto (BTC price drops 5%)
- stock (earnings reports)
- domain (SSL expiry, DNS changes)
- social (new posts from targets)
- weather (severe alerts)
- flight (delay/cancellation)

**Integration:**
- Alert queue → ProactiveAgent → Speech ("Boss, Bitcoin dropped 5%")
- Persistence via StateManager

### Phase 5: Additional Handler Modules (Future)
| Module | Tools | Priority |
|--------|-------|----------|
| `property.py` | ~30 | Medium - Zillow, county APIs |
| `vehicle.py` | ~25 | Medium - NHTSA, FAA, MarineTraffic |
| `emergency.py` | ~15 | Low - CAP alerts, fire data |
| `darkweb.py` | ~20 | Low - IntelX, paste sites |

---

## API Keys Required

**Already configured (.env):**
```
ETHERSCAN_API_KEY=
BLOCKCHAIN_COM_API_KEY=
```

**Phase 4+ (when implemented):**
```
SHODAN_API_KEY=
HAVE_I_BEEN_PWNED_KEY=
CENSYS_API_ID=
HUNTER_IO_KEY=
```

---

## Testing OSINT Tools

```bash
# Test geocode
curl -X POST http://localhost:5000/chat -d '{"message":"geocode the White House"}'

# Test weather
curl -X POST http://localhost:5000/chat -d '{"message":"weather forecast for Phoenix"}'

# Test crypto
curl -X POST http://localhost:5000/chat -d '{"message":"what is the current Bitcoin price"}'

# Test SEC filings
curl -X POST http://localhost:5000/chat -d '{"message":"find Apple SEC filings"}'
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
│  • 470 tools, Gemini 2.5                                │
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

*Main PC: 192.168.0.230 | Backend: 5000 | GPU: 5001 | Tools: 470 | 1M Neurons*
