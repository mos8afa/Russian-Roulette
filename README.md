# 🎲 Russian Roulette – DOS Assembly Game (8086 / TASM)

A classic **Russian Roulette** game implemented in **16-bit x86 Assembly (TASM / 8086)**, running in **text mode (80×25)** under DOS.  
The game features turn-based gameplay, ASCII graphics, randomization, and full UI logic using BIOS interrupts.

---

## 🕹️ Gameplay Overview

- The revolver contains **one random bullet** in a 6-chamber cylinder.
- At the start of each round:
  1. The player rolls a **dice (2–4 shots)**.
  2. The player chooses the **first target**:
     - **SELF**
     - **PC**
  3. Shots **alternate automatically** between USER and PC.
- Each shot results in:
  - **SAFE** → click sound & continue
  - **BOOM** → instant death
- The round ends when:
  - A bullet fires (someone dies), or
  - All dice shots are consumed safely.
- First to win **2 rounds** wins the game.

---

## ✨ Features

- ✅ Full **text-mode UI (80×25)**
- 🔫 **ASCII gun animations** (SAFE / FIRE / BOOM frames)
- 🙂 / 💀 **Live & Dead head graphics**
- 🎲 **Random dice (2–4 shots)**
- 🔄 **Alternating turns** after first target selection
- 🤖 **PC auto-shoot logic** with delay
- 🎓 **Tutorial screen** shown at startup
- 🧠 **Custom RNG** using BIOS timer & port noise
- 🏆 **YOU WIN / GAME OVER** large ASCII end screens
- 🔁 **Replay option** after game over

---

## 🧱 Technical Details

- **Language:** x86 Assembly (16-bit)
- **Assembler:** TASM
- **Architecture:** Intel 8086
- **Mode:** Real Mode
- **Display:** BIOS text mode (INT 10h)
- **Input:** Keyboard (INT 16h)
- **Timing / RNG:** BIOS timer + port mixing
- **Memory Model:** Small

---

## 🎮 Controls

| Key | Action |
|----|-------|
| Any key | Roll dice |
| `1` | Shoot SELF first |
| `2` | Shoot PC first |
| Any key | Fire (USER turn) |
| `Y` | Play again |
| `N` | Exit |

---

## 🛠️ How to Build & Run

### Using DOSBox + TASM

```bash
tasm roulette.asm
tlink roulette.obj
roulette.exe
