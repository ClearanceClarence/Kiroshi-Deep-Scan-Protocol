# Kiroshi Deep Scan Protocol

![Cyberpunk 2077](https://img.shields.io/badge/Cyberpunk%202077-FFD700?style=flat-square)
![Version](https://img.shields.io/badge/version-1.5-5ef6e1?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

A Cyberpunk 2077 mod that extends the scanner system to display procedurally generated NPC data.

## Overview

This mod hooks into the game's scanner UI to inject additional data panels for crowd NPCs, gang members, and NCPD officers. All data is procedurally generated using a seed derived from each NPC's entity ID, ensuring consistent results across game sessions.

## What's New in v1.5

### Unique NPC System

Hand-crafted lore-accurate backstories for named story characters. When scanning unique NPCs like Takemura, Panam, or Judy, you'll see custom-written intel instead of procedurally generated data.

**Features:**
- TweakDB-based character detection
- Custom classification banners (e.g., "ARASAKA COUNTERINTEL")
- Lore-accurate backgrounds, affiliations, and threat assessments
- Extensible entry system for easy additions

**Supported Characters:** Takemura (example included). More entries coming soon.

### Expanded Lifepath System

Massively expanded lifepath generation with **617 unique life events** across multiple categories:

| Category | Events | Examples |
|----------|--------|----------|
| Upbringing | ~150 | Family structure, parental occupations, childhood trauma, wealth backgrounds, special origins |
| Housing | ~80 | Megabuilding apartments, combat zone squats, nomad camps, corpo housing |
| Childhood | ~160 | Education paths, street life, gang involvement, skills development |
| Jobs | ~160 | Criminal careers, merc roles, tech positions, service work, corpo jobs |
| Adulthood | ~70 | Relationships, gang involvement, mentorship, near-death experiences |

**New Upbringing Events:**
- Family structures: only child, twins, triplets, step-families, blended families
- Parental occupations: NCPD, doctors, teachers, gang leaders, joytoys, dealers
- Childhood trauma: witnessed deaths, home invasions, kidnapping, fires
- Wealth backgrounds: born rich, trust funds, corporate debt, lost wealth
- Special origins: lab-born, clones, cult escapees, refugees, immigrants

**New Job Events:**
- Criminal: assassins, car thieves, burglars, identity thieves, loan sharks, bookies
- Merc/Combat: extraction specialists, wheelman, snipers, demolitions, infiltrators
- Tech: hackers, daemon coders, ICE breakers, data miners, cyberware developers
- Service: cooks, taxi drivers, couriers, bouncers, doormen, morticians
- Corpo: lawyers, marketing, consultants, recruiters, trainers

**New Adulthood Events:**
- Relationships: heartbreak, romantic partners
- Gang: joined gang as adult, left gang life
- Mentorship: found a mentor, became a mentor
- Near-death: flatlined and resuscitated, coma, near-death experiences

All events include appropriate stat modifiers (Body, Reflex, Tech, Int, Cool, Wealth) and lifepath-specific weighting (CORPO_MOD, NOMAD_MOD, GANGER_MOD, HOMELESS_MOD, JUNKIE_MOD).

### v1.4 Features

**Narrative Coherence System** — Optional system that links all NPC data into believable, interconnected stories. NPCs are assigned a Life Theme that influences all generated data:

| Theme | Description |
|-------|-------------|
| STABLE | Comfortable life, steady job, minimal issues |
| STRUGGLING | Making ends meet, mounting pressures |
| CLIMBING | On the rise, ambitious, improving circumstances |
| FALLING | Things getting worse, spiraling problems |
| CRIMINAL | Life outside the law, gang ties, illegal income |
| CORPORATE | Corp lifestyle, clean records, financial security |

**Flag Propagation**: Shared flags propagate across all databases:
- Substance abuse → liver damage in medical, addiction in psych, drug charges in criminal
- Violent past → assault charges, combat injuries, aggression markers
- Financial struggles → matching debt reasons, poor credit, stress-related conditions
- Criminal lifestyle → illegal cyberware, gang connections, warrant flags

**Additional Features:**
- Data Density Setting — High (full), Medium (condensed), or Low (minimal)
- Font Size Settings — Configurable header (14-28) and text (18-34) sizes
- Special NPC Rarity — Common (1:250), Rare (1:750), Mythic (1:2000)
- Loading Sequence Animation — 100+ unique database connection messages

## Project Structure

```
r6/scripts/backgroundScanner/
├── Core/
│   ├── BackstoryManager.reds          # Main generation orchestrator
│   ├── BackstoryUI.reds               # UI data struct
│   ├── NameGenerator.reds             # Culturally diverse name generation
│   ├── Coherence/
│   │   └── CoherenceManager.reds      # Narrative coherence system
│   ├── Criminal/
│   │   └── CriminalRecordManager.reds
│   ├── Cyberware/
│   │   └── CyberwareRegistryManager.reds
│   ├── District/
│   │   └── CrowdDistrictManager.reds
│   ├── Financial/
│   │   └── FinancialProfileManager.reds
│   ├── Gang/
│   │   └── GangManager.reds
│   ├── LifePath/
│   │   ├── LifePath.reds              # Core lifepath class
│   │   ├── LifePathEvent.reds         # Event class with stat modifiers
│   │   ├── LifePathEvents.reds        # 617 event definitions & pools
│   │   └── LifePathPossibilities.reds # Event selection logic
│   ├── Medical/
│   │   └── MedicalHistoryManager.reds
│   ├── NCPD/
│   │   └── NCPDNameGenerator.reds
│   ├── Psych/
│   │   └── PsychProfileManager.reds
│   ├── Rare/
│   │   └── RareNPCManager.reds
│   ├── Relationships/
│   │   └── RelationshipsManager.reds
│   └── Unique/
│       ├── UniqueNPCData.reds         # Data structure for unique NPCs
│       ├── UniqueNPCManager.reds      # Detection & lookup system
│       └── UniqueNPCEntries.reds      # Hand-crafted character entries
├── Overrides/
│   ├── ScannerNPCBodyGameController.reds  # Scanner UI injection
│   └── NPCPuppet.reds                      # TweakDB name retrieval
├── Settings/
│   └── KiroshiSettings.reds               # Mod Settings Menu integration
├── Text/
│   ├── TextAdulthood.reds             # 239 adulthood text entries
│   ├── TextBackgrounds.reds           # 79 background entries
│   ├── TextChildhood.reds             # 162 childhood entries
│   ├── TextCore.reds                  # Core text utilities
│   ├── TextCorpos.reds                # 106 corporation names
│   ├── TextHousing.reds               # 149 housing entries
│   ├── TextJobs.reds                  # 158 job entries
│   ├── TextLifepaths.reds             # 94 lifepath entries
│   └── TextUpbringing.reds            # 151 upbringing entries
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

### Lifepath Event System
```swift
public class CrowdScannerEvents {
    public static func BORN_RICH() -> ref<LifePathEvent> { 
        return LPE(TextUpbringing.BORN_RICH_F(), TextUpbringing.BORN_RICH_M())
            .SetWealthMod(30); 
    }
    
    public static func JOB_ASSASSIN() -> ref<LifePathEvent> { 
        return LPE(TextJobs.JOB_ASSASSIN_F(), TextJobs.JOB_ASSASSIN_M())
            .SetReflexMod(15)
            .SetCoolMod(15); 
    }
}
```
Events are defined as static methods returning `LifePathEvent` objects with gender-specific text and stat modifiers.

### Weighted Event Pools
```swift
PushWeightedLifeEvent(events, CrowdScannerEvents.BORN_RICH(), POS_OUTCOME_WGT / 3 + CORPO_MOD);
PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_ASSASSIN(), NEG_OUTCOME_WGT / 2 + GANGER_MOD);
```
Events are weighted by outcome type (positive/neutral/negative) and archetype modifiers (corpo, nomad, ganger, homeless, junkie).

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

## Dependencies

- [redscript](https://github.com/jac3km4/redscript) — Script compiler
- [Codeware](https://github.com/psiberx/cp2077-codeware) — UI framework (`inkCustomController`)
- [Mod Settings Menu](https://github.com/jackhumbert/mod_settings) — Runtime settings

## Incompatible Mods

- [Lifepath Bonuses and Gang-Corp Traits](https://www.nexusmods.com/cyberpunk2077/mods/2217) — Conflicts with scanner override systems
- [Kiroshi Opticals - Crowd Scanner Expansion](https://www.nexusmods.com/cyberpunk2077/mods/13470) — Uses same scanner hooks
- [Kiroshi Opticals NetWatch Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/23664) — Duplicate functionality

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

## FAQ

**Q: Why does someone show as "NCPD HIGH PRIORITY TARGET" but the base game shows no criminal record?**

A: The Kiroshi Deep Scan Protocol pulls from multiple database sources beyond standard NCPD public records - including NetWatch surveillance data, corporate security flags, black market bounty boards, and cross-referenced immigration databases. V's scanner has access to information that NCPD either doesn't have, hasn't made public, or has been paid to suppress. Night City runs on secrets and bribes - the "official" record is rarely the complete picture.

**Q: My cat has a criminal record for starting a drug war.**

A: Nibbles and other registered animals now have proper database entries in v1.5. The procedural generator no longer applies to entities with unique NPC records.
