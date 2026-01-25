# Kiroshi Deep Scan Protocol

![Cyberpunk 2077](https://img.shields.io/badge/Cyberpunk%202077-FFD700?style=flat-square)
![Version](https://img.shields.io/badge/version-1.4-5ef6e1?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

A Cyberpunk 2077 mod that extends the scanner system to display procedurally generated NPC data.

## Overview

This mod hooks into the game's scanner UI to inject additional data panels for crowd NPCs, gang members, and NCPD officers. All data is procedurally generated using a seed derived from each NPC's entity ID, ensuring consistent results across game sessions.

## What's New in v1.4

### Narrative Coherence System

Optional system that links all NPC data into believable, interconnected stories. When enabled, NPCs are assigned a **Life Theme** that influences all generated data:

| Theme | Description |
|-------|-------------|
| STABLE | Comfortable life, steady job, minimal issues |
| STRUGGLING | Making ends meet, mounting pressures |
| CLIMBING | On the rise, ambitious, improving circumstances |
| FALLING | Things getting worse, spiraling problems |
| CRIMINAL | Life outside the law, gang ties, illegal income |
| CORPORATE | Corp lifestyle, clean records, financial security |

**Flag Propagation**: Shared flags (substance abuse, violent past, trauma, debt) propagate across all databases:
- Substance abuse → liver damage in medical, addiction in psych, drug charges in criminal
- Violent past → assault charges, combat injuries, aggression markers
- Financial struggles → matching debt reasons, poor credit, stress-related conditions
- Criminal lifestyle → illegal cyberware, gang connections, warrant flags

### Additional v1.4 Features

- **Data Density Setting** — High (full), Medium (condensed), or Low (minimal)
- **Font Size Settings** — Configurable header (14-28) and text (18-34) sizes
- **Special NPC Rarity** — Common (1:250), Rare (1:750), Mythic (1:2000)
- **Loading Sequence Animation** — 100+ unique database connection messages

## Project Structure

```
r6/scripts/backgroundScanner/
├── Core/
│   ├── BackstoryManager.reds          # Main generation orchestrator
│   ├── BackstoryUI.reds               # UI data struct
│   ├── NameGenerator.reds             # Culturally diverse name generation
│   ├── Criminal/
│   │   └── CriminalRecordManager.reds
│   ├── Cyberware/
│   │   └── CyberwareRegistryManager.reds
│   ├── Financial/
│   │   └── FinancialProfileManager.reds
│   ├── Gang/
│   │   └── GangManager.reds
│   ├── LifePath/
│   │   ├── LifePath.reds
│   │   ├── LifePathEvents.reds
│   │   └── LifePathPossibilities.reds
│   ├── Medical/
│   │   └── MedicalHistoryManager.reds
│   ├── NCPD/
│   │   └── NCPDNameGenerator.reds
│   ├── Psych/
│   │   └── PsychProfileManager.reds
│   ├── Rare/
│   │   └── RareNPCManager.reds
│   └── Relationships/
│       └── RelationshipsManager.reds
├── Overrides/
│   ├── ScannerNPCBodyGameController.reds  # Scanner UI injection
│   └── NPCPuppet.reds                      # TweakDB name retrieval
├── Settings/
│   └── KiroshiSettings.reds               # Mod Settings Menu integration
├── UI/
│   ├── NetWatchDBReport.reds              # Custom UI widget
│   └── ScannerBackstorySystem.reds        # Loading sequence & display
└── Util/
    ├── Random.reds
    ├── String.reds
    └── ArrayUtils.reds
```

## How It Works

### Seed-Based Generation
```swift
let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
let seed = RandRange(entityIDHash, 0, 2147483647);
```
Each NPC's entity ID is hashed to create a deterministic seed. All generated data uses offsets from this seed, ensuring the same NPC always produces identical results.

### Coherence Generation
```swift
if KiroshiSettings.CoherenceEnabled() {
    let lifeTheme = CoherenceManager.AssignLifeTheme(seed);
    let flags = CoherenceManager.GenerateSharedFlags(seed, lifeTheme);
    // Flags propagate to all generators
}
```
When coherence is enabled, a life theme and shared flags are generated first, then passed to each manager to ensure consistent, interconnected data.

### NPC Detection
- **Gang members**: Detected via appearance name patterns (e.g., `tyger`, `maelstrom`, `valentinos`)
- **NCPD officers**: Detected via `IsPrevention()`, `IsCharacterPolice()`, or appearance name
- **Children**: Detected via appearance name patterns (`child`, `kid`)

### Data Filtering
Different NPC types receive filtered data:
- **Civilians**: Full data (criminal, financial, medical, cyberware, relationships)
- **Gang members**: Criminal record, gang affiliation, psych profile only
- **NCPD officers**: Personnel file, cyberware, cop-specific backstory
- **Children**: Restricted/protected data only

### Dynamic Font Updates
```swift
public func UpdateFontSizes() {
    let headerSize = KiroshiSettings.GetHeaderFontSize();
    let textSize = KiroshiSettings.GetTextFontSize();
    // Updates all section widgets
}
```
Font sizes update dynamically when settings change, applied on each new scan.

## Settings

All settings accessible via Mod Settings Menu → Kiroshi Deep Scan:

### Display Options
| Setting | Range | Default | Description |
|---------|-------|---------|-------------|
| Data Density | 1-3 | 3 (High) | Information volume per scan |
| Header Font Size | 14-28 | 20 | Section header size |
| Text Font Size | 18-34 | 26 | Body text size |

### Generation Mode
| Setting | Options | Default | Description |
|---------|---------|---------|-------------|
| Narrative Coherence | On/Off | Off | Links data into consistent stories |
| Special NPC Rarity | Common/Rare/Mythic | Rare | Frequency of flagged NPCs |

### Content Options
| Setting | Default | Description |
|---------|---------|-------------|
| Diverse Relationships | Off | Same-sex partnerships, polyamory, chosen family |
| Body Modification Records | Off | Gender-affirming cyberware (~20% of NPCs) |
| Display Pronouns | Off | Pronoun field (85% standard, 10% they/them, 5% neo) |

Settings accessed via `KiroshiSettings` static helper:
```swift
if KiroshiSettings.CoherenceEnabled() {
    // Generate coherent data
}

let density = KiroshiSettings.GetDataDensity(); // 1, 2, or 3
let rarity = KiroshiSettings.GetSpecialNPCRarity(); // 250, 750, or 2000
```

## Dependencies

- [redscript](https://github.com/jac3km4/redscript) — Script compiler
- [Codeware](https://github.com/psiberx/cp2077-codeware) — UI framework (`inkCustomController`)
- [Mod Settings Menu](https://github.com/jackhumbert/mod_settings) — Runtime settings

## Building

No build step required. The game compiles `.reds` files on startup.

Install by copying `r6/` to your game directory:
```
Cyberpunk 2077/r6/scripts/backgroundScanner/
```

## Credits

- **Reki72** — Original [Kiroshi Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/1654)
- **psiberx** — Codeware
- **jackhumbert** — Mod Settings Menu

## License

MIT
