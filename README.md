# Kiroshi Deep Scan Protocol

![Cyberpunk 2077](https://img.shields.io/badge/Cyberpunk%202077-FFD700?style=flat-square)
![Version](https://img.shields.io/badge/version-1.3.1-5ef6e1?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

A Cyberpunk 2077 mod that extends the scanner system to display procedurally generated NPC data.

## Overview

This mod hooks into the game's scanner UI to inject additional data panels for crowd NPCs, gang members, and NCPD officers. All data is procedurally generated using a seed derived from each NPC's entity ID, ensuring consistent results across game sessions.

## Project Structure

```
r6/scripts/backgroundScanner/
├── Core/
│   ├── BackstoryManager.reds      # Main generation orchestrator
│   ├── BackstoryUI.reds           # UI data struct
│   ├── NameGenerator.reds         # Culturally diverse name generation
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
│   └── KiroshiSettings.reds       # Mod Settings Menu integration
├── UI/
│   ├── NetWatchDBReport.reds      # Custom UI widget
│   └── ScannerBackstorySystem.reds
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

## Optional Features

Three features are disabled by default and require Mod Settings Menu:

| Setting | Description |
|---------|-------------|
| `enableDiverseRelationships` | Same-sex partnerships, polyamory, chosen family |
| `enableBodyModRecords` | Gender-affirming cyberware (~20% of NPCs) |
| `enablePronounDisplay` | Pronoun field (85% standard, 10% they/them, 5% neo) |

Settings are accessed via `KiroshiSettings` static helper:
```swift
if KiroshiSettings.DiverseRelationshipsEnabled() {
    // Generate diverse content
}
```

## Credits

- **Reki72** — Original [Kiroshi Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/1654)
- **psiberx** — Codeware
- **jackhumbert** — Mod Settings Menu

## License

MIT
