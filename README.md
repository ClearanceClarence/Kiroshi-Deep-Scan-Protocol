# Kiroshi Deep Scan Protocol

![Cyberpunk 2077](https://img.shields.io/badge/Cyberpunk%202077-FFD700?style=flat-square)
![Version](https://img.shields.io/badge/version-1.6.1-5ef6e1?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

> *Every stranger has a story. Your Kiroshi can read them all.*

A comprehensive scanner overhaul for Cyberpunk 2077 that procedurally generates detailed backstories, criminal records, relationships, and database entries for every NPC in Night City.

---

## Table of Contents

- [Overview](#overview)
- [Features at a Glance](#features-at-a-glance)
- [Unique NPC Database](#unique-npc-database)
- [Procedural Generation Systems](#procedural-generation-systems)
- [Special Classifications](#special-classifications)
- [Relationship Networks](#relationship-networks)
- [Name Generation System](#name-generation-system)
- [Narrative Coherence](#narrative-coherence)
- [Technical Architecture](#technical-architecture)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Configuration](#configuration)
- [Installation](#installation)
- [Compatibility](#compatibility)
- [FAQ](#faq)
- [Bug Reports](#bug-reports)
- [Credits](#credits)

---

## Overview

Deep Scan Protocol hooks your Kiroshi optics into every major database in Night City. Scan any civilian and pull their NCPD criminal records, cyberware registry, bank records, medical history, psychological profile, and personal relationships. Scan gang members to access their affiliation data. Scan NCPD officers to access their personnel files.

All data is deterministically generated from each NPC's entity ID, ensuring consistent results across game sessions. The same NPC will always produce identical information no matter when you scan them.

### Database Access

When scanning NPCs, Deep Scan Protocol queries:

| Database | Information Retrieved |
|----------|----------------------|
| **NCPD Criminal Database** | Arrests, charges, convictions, warrant status, threat classification |
| **Night City Financial Registry** | Credit rating, income bracket, debt status, asset flags |
| **Trauma Team Medical Records** | Chronic conditions, injury history, cyberware complications |
| **NetWatch Psychological Index** | Temperament, behavioral flags, violence risk, loyalty markers |
| **Cyberware Registration System** | Implant inventory, psychosis risk, illegal modifications |
| **Social Network Analysis** | Family connections, known associates, enemies, professional contacts |
| **Gang Intelligence Division** | Affiliation, rank, territory, loyalty assessment |
| **NCPD Personnel System** | Badge number, rank, unit assignment, service record |

---

## Features at a Glance

| Feature | Count | Description |
|---------|-------|-------------|
| **Unique NPC Entries** | 82 | Hand-crafted lore-accurate backstories for named characters |
| **Life Events** | 698 | Procedural backstory building blocks with stat modifiers |
| **Special Classifications** | 30 | Hidden status flags for rare NPCs |
| **Name Combinations** | 260,000+ | Unique full names across all ethnicities |
| **Name Entries** | 3,900 | Individual names (100 male + 100 female + 100 last per ethnicity) |
| **Street Aliases** | 120 | Gang associate nicknames |
| **Ethnicities** | 13 | Culturally appropriate name generation |
| **Text Entries** | 3,312 | Lines of lore-accurate content |
| **Relationship Types** | 4 | Family, associates, enemies, professional contacts |

### Smart Data Filtering

Different NPC types receive contextually appropriate data:

| NPC Type | Displayed Data | Hidden Data |
|----------|----------------|-------------|
| **Civilians** | Criminal, financial, medical, cyberware, psych, relationships | None |
| **Gang Members** | Criminal, gang affiliation, psych, relationships | Financial, medical |
| **NCPD Officers** | Personnel file, badge, rank, unit, cyberware | Criminal (sealed) |
| **Children** | Protected status message | Criminal, financial, medical |
| **Unique NPCs** | Hand-crafted custom intel | Procedural data |

---

## Unique NPC Database

82 named characters have hand-written, lore-accurate backstories that completely override procedural generation. These entries feature custom classifications, detailed backgrounds, threat assessments, and dynamic quest states.

### Arasaka Corporation

| Character | Classification | Description |
|-----------|----------------|-------------|
| Saburo Arasaka | ARASAKA - EMPEROR | Founder and CEO. Dynamic state changes after The Heist |
| Yorinobu Arasaka | ARASAKA - HEIR | Rebel son. Patricide flagged post-Heist |
| Hanako Arasaka | ARASAKA - PRINCESS | Protected diplomatic status |
| Goro Takemura | ARASAKA - DISAVOWED | Former bodyguard. State changes based on quest progression |
| Sandayu Oda | ARASAKA - PERSONAL SECURITY | Hanako's primary protection detail |
| Adam Smasher | ARASAKA - MILITARY ASSET | Full cyborg combat platform |
| Anders Hellman | ARASAKA - RESEARCH | Relic program lead scientist |
| Graham Mayfield | ARASAKA - SECURITY | Corporate security operative |
| Hanako Bodyguards | ARASAKA - PERSONAL SECURITY | Elite protection detail |
| Arasaka Security | ARASAKA - SECURITY | Standard corporate operatives |

### Militech

| Character | Classification |
|-----------|----------------|
| Meredith Stout | MILITECH - COUNTERINTELLIGENCE |
| Weldon Holt | MILITECH - EXECUTIVE |
| Militech Commander | MILITECH - FIELD OPERATIONS |

### Fixers

| Character | Territory | Specialty |
|-----------|-----------|-----------|
| Rogue Amendiares | Afterlife | Legend. Queen of the Afterlife |
| Dexter DeShawn | Watson | High-profile jobs. Dynamic state |
| Wakako Okada | Westbrook | Information broker |
| Regina Jones | Watson | Street-level, NCPD connections |
| Sebastian "Padre" Ibarra | Heywood | Valentinos ties, family values |
| Dakota Smith | Badlands | Nomad specialist |
| Dino Dinovic | Santo Domingo | Industrial work |
| Mr. Hands | Pacifica / Dogtown | Phantom Liberty content |
| El Capitan | Santo Domingo | Vehicle specialist |

### Afterlife Regulars

| Character | Classification | Notes |
|-----------|----------------|-------|
| Jackie Welles | MERC - PARTNER | V's partner. Dynamic state after The Heist |
| T-Bug | MERC - NETRUNNER | Elite netrunner. Dynamic state |
| Johnny Silverhand | ENGRAM - TERRORIST | Digital ghost. Rockerboy legend |
| Kerry Eurodyne | CIVILIAN - CELEBRITY | Samurai guitarist |
| Alt Cunningham | NETRUNNER - BEYOND BLACKWALL | First Soulkiller victim |
| Claire Russell | CIVILIAN - BARTENDER | Afterlife bartender, racer |
| Crispin Weyland | MERC - AFTERLIFE | Known as Squama |
| Nix | NETRUNNER - AFTERLIFE | Resident paranoid netrunner |

### Gang Leadership

#### Maelstrom
| Character | Role |
|-----------|------|
| Royce | Current leader. Took over from Brick |
| Dum Dum | Lieutenant. Chrome enthusiast |
| Brick | Former leader. Overthrown by Royce, imprisoned |

#### Tyger Claws
| Character | Role |
|-----------|------|
| Jotaro Shobo | Lieutenant |
| Hiromi Sato | Operations manager |

#### Valentinos
| Character | Role |
|-----------|------|
| Gustavo Orta | Leadership |
| Jose Luis | Enforcer |
| Octavio Ruiz | Associate |

#### Voodoo Boys
| Character | Role |
|-----------|------|
| Brigitte | Maman. Spiritual leader |
| Placide | Enforcer. Field operations |

#### Other Gangs
| Character | Gang | Role |
|-----------|------|------|
| Sasquatch | Animals | Leader. Extreme cyberware |
| Nash | Wraiths | Leader. Badlands operations |
| Anton Kolos | Scavengers | Cell leader |

### Mox & Clouds

| Character | Classification | Notes |
|-----------|----------------|-------|
| Judy Alvarez | MOX - TECHIE | BD editor. Evelyn's friend |
| Evelyn Parker | CIVILIAN - DOLL | Dynamic state based on quest |
| Maiko Maeda | CLOUDS - MANAGEMENT | Ambitious. Corp connections |
| Woodman | CLOUDS - SECURITY | Tyger Claws enforcer |

### Aldecaldos

| Character | Role |
|-----------|------|
| Panam Palmer | Clan member. Expert driver |
| Saul Bright | Clan leader |
| Mitch Anderson | Mechanic. Scorpion's friend |

### Ripperdocs & Medical

| Character | Location | Specialty |
|-----------|----------|-----------|
| Viktor Vektor | Little China | V's primary ripper. Ex-boxer |
| Fingers | Jig-Jig Street | Questionable ethics |
| Charles Bucks | Kabuki | Budget operations |
| Misty Olszewski | Misty's Esoterica | Spiritual advisor. Jackie's partner |

### NCPD & Politics

| Character | Role | Notes |
|-----------|------|-------|
| River Ward | Detective | Good cop. Family man |
| Jefferson Peralez | Politician | Mayoral candidate |
| Lucius Rhyne | Mayor | Dynamic state based on story |
| Barry | Officer | Suicide crisis storyline |

### NetWatch

| Character | Role |
|-----------|------|
| Bryce Mosley | Agent. Pacifica operations |

### Media & Entertainment

| Character | Profession | Notes |
|-----------|------------|-------|
| Lizzy Wizzy | Musician | Full-body chrome conversion |
| Blue Moon | Musician | Us Cracks band member |
| Ozob Bozo | Fighter | Grenade-nose implant |
| Joshua Stephenson | Death Row | Crucifixion BD subject |
| Gillean Jordan | Journalist | N54 News anchor |
| Max Jones | Journalist | Independent media |
| Cassius Ryder | Journalist | Investigative reporter |

### Vendors & Services

| Character | Business |
|-----------|----------|
| Wilson | 2nd Amendment weapon shop |
| Coach Fred | Boxing trainer, Arroyo |

### Phantom Liberty Characters

| Character | Classification | Notes |
|-----------|----------------|-------|
| Solomon Reed | FIA - DEEP COVER | Legendary sleeper agent |
| Songbird (So Mi) | FIA - NETRUNNER | Blackwall-damaged. Relic bearer |
| Kurt Hansen | BARGHEST - LEADER | PMC warlord. Controls Dogtown |
| Rosalind Myers | NUSA - PRESIDENT | NUSA head of state |
| Alex | BARGHEST - INTELLIGENCE | Hansen's information specialist |

### Other Notable Characters

| Character | Description |
|-----------|-------------|
| Delamain | AI taxi service. Multiple personalities |
| Mama Welles | Jackie's mother. El Coyote Cojo owner |
| Nibbles | V's cat. Proper database entry |
| Brendan | Sentient vending machine. Japantown |
| Skippy | Sentient smart pistol |

### Dynamic Quest States

These characters have entries that update based on game progression:

| Character | Trigger | Change |
|-----------|---------|--------|
| Takemura | The Heist | Shows disavowed status, manhunt data |
| Jackie Welles | The Heist | Entry reflects fate |
| T-Bug | The Heist | Status updated |
| Evelyn Parker | Automatic Love | Reflects storyline events |
| Dexter DeShawn | The Heist | Dynamic state |
| Saburo Arasaka | The Heist | Death recorded |
| Lucius Rhyne | Dream On | Status changes |

---

## Procedural Generation Systems

### Lifepath Events

698 unique events build procedural backstories. Each event includes gender-specific text, stat modifiers, and lifepath weighting.

| Category | Count | Examples |
|----------|-------|----------|
| **Upbringing** | ~115 | Family structure, parental jobs, wealth level, childhood trauma, orphan status |
| **Housing** | ~97 | Megabuilding units, combat zone squats, nomad camps, corpo housing, gang territory |
| **Childhood** | ~178 | Education, street skills, gang youth, disabilities, talents, trauma, hobbies |
| **Jobs** | ~103 | Criminal careers, merc work, tech positions, service industry, corpo jobs |
| **Adulthood** | ~213 | Relationships, violence, health crises, career changes, legal troubles, achievements |

#### Event Structure

Each event carries metadata:

```
Event: BORN_RICH
├── Female Text: "Born into wealth. Never wanted for anything."
├── Male Text: "Born into wealth. Never wanted for anything."
├── Wealth Modifier: +30
├── Lifepath Weight: Corpo (high), Street Kid (low), Nomad (low)
└── Associated Flags: PRIVILEGED, CORPORATE_TIES
```

### Criminal Record System

| Field | Description |
|-------|-------------|
| Status | Clean / Minor Record / Criminal / Wanted / Incarcerated |
| Arrests | List of specific charges with dates |
| Convictions | Convicted charges and sentencing |
| Warrant Status | None / Active / Federal / Corporate |
| NCPD Classification | Petty Criminal / Known Offender / High Priority / Most Wanted |
| Corporate Flags | Arasaka / Militech / Kang Tao security alerts |

### Cyberware Registry

| Field | Range | Description |
|-------|-------|-------------|
| Total Implants | 0-15 | Number of registered modifications |
| Categories | Neural / Optical / Skeletal / Dermal / Circulatory | Implant breakdown |
| Psychosis Risk | 0-100% | Cyberpsychosis probability |
| Illegal Mods | 0-5 | Unlicensed/black market implants |
| Registry Status | Compliant / Overdue / Non-Compliant / Flagged | Legal standing |

### Financial Profile

| Field | Options |
|-------|---------|
| Credit Rating | AAA / AA / A / B / C / D / Default |
| Income Bracket | Destitute / Poverty / Working / Middle / Upper / Elite |
| Debt Status | None / Minor / Significant / Severe / Crushing |
| Asset Flags | Property / Vehicle / Business / Investments |
| Corporate Ties | Employment history, severance, litigation |

### Medical History

| Category | Examples |
|----------|----------|
| Chronic Conditions | Cyberware rejection, neural degradation, organ failure |
| Injuries | Combat wounds, industrial accidents, vehicle trauma |
| Cyberware Complications | Rejection syndrome, phantom limb, signal interference |
| Substance Issues | Combat stim dependency, alcohol, recreational drugs |
| Mental Health | PTSD, anxiety, depression, cyberpsychosis markers |

### Psychological Profile

| Field | Description |
|-------|-------------|
| Temperament | Stable / Volatile / Aggressive / Withdrawn / Calculating |
| Behavioral Flags | Violence markers, addiction indicators, manipulation susceptibility |
| Risk Score | 0-100 violence probability |
| Loyalty Index | Corporate / Gang / Family / Self loyalty priorities |
| Notable Traits | Leadership, paranoia, impulsivity, discipline |

---

## Special Classifications

30 rare NPC types appear at configurable odds (default 1:750). These citizens appear completely normal until scanned, revealing hidden status flags.

### Intelligence Assets

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| SLEEPER_AGENT | Deep cover operative awaiting activation orders | EXTREME |
| DOUBLE_AGENT | Working multiple factions simultaneously | EXTREME |
| UNDERCOVER_COP | NCPD officer embedded in criminal organization | HIGH |
| GANG_INFILTRATOR | Law enforcement asset inside gang structure | HIGH |
| FIXER_ASSET | Confidential informant on fixer payroll | MODERATE |
| DATA_COURIER | Carries sensitive data in cranial storage | HIGH |

### Corporate Refugees

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| CORPO_WHISTLEBLOWER | Leaked corporate secrets, hunted by former employer | EXTREME |
| CORPO_DEFECTOR | Fled corporation with sensitive data or technology | EXTREME |
| BLACKMAIL_VICTIM | Being leveraged by unknown party, unpredictable | MODERATE |

### High-Value Targets

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| WITNESS_PROTECTION | Federal protection program, new identity | HIGH |
| WITNESS | Saw something they shouldn't have, marked | HIGH |
| HUNTED | Multiple factions actively seeking termination | EXTREME |
| MAXTAC_TARGET | On MaxTac priority elimination list | EXTREME |
| DEBT_COLLECTION | Marked by corporate debt collectors | MODERATE |
| ORGAN_MARKED | Flagged by scavenger organ harvesting networks | HIGH |

### Medical Anomalies

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| PRE_CYBERPSYCHO | Showing early cyberpsychosis markers, unstable | EXTREME |
| CLONE_SUBJECT | Product of illegal cloning operation | HIGH |
| EXPERIMENTAL_SUBJECT | Survived corporate medical experimentation | HIGH |
| ENGRAM_CANDIDATE | Flagged for Soulkiller compatibility | HIGH |
| RELIC_COMPATIBLE | Rare biology compatible with Relic technology | EXTREME |
| TRAUMA_TEAM_MARKED | Platinum coverage or marked for priority extraction | MODERATE |

### Underground

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| HIDDEN_NETRUNNER | Elite netrunner operating in civilian disguise | EXTREME |
| RETIRED_LEGEND | Former legendary merc/operative, still dangerous | HIGH |
| LEGACY_CHARACTER | Connected to major historical events | MODERATE |

### Outcasts

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| GHOST | Officially dead, living completely off-grid | HIGH |
| MILITARY_AWOL | Deserter from NUSA or corporate military | HIGH |
| NOMAD_EXILE | Cast out from their clan, no backup | MODERATE |
| CULT_ESCAPEE | Fled from dangerous organization | MODERATE |

### Anomalous

| Classification | Description | Danger Level |
|----------------|-------------|--------------|
| AI_CONTACT | In communication with rogue AI beyond Blackwall | EXTREME |
| TIME_ANOMALY | Temporal displacement markers detected | UNKNOWN |

---

## Relationship Networks

Full relationship generation creates believable social networks for every NPC.

### Relationship Types

| Type | Count | Description |
|------|-------|-------------|
| **Family Members** | 0-5 | Blood relatives and spouse |
| **Known Associates** | 1-8 | Friends, coworkers, contacts |
| **Known Enemies** | 0-3 | With reasons and threat levels |
| **Professional Contacts** | 0-3 | Fixers, ripperdocs, dealers |

### Family Generation

| Relation | Gender | Name Inheritance |
|----------|--------|------------------|
| Father | Male | Shares family surname |
| Mother | Female | Shares family surname |
| Brother | Male | Shares family surname |
| Sister | Female | Shares family surname |
| Grandfather | Male | Shares family surname |
| Grandmother | Female | Shares family surname |
| Spouse | Variable | 80% shares surname |
| Child | Variable | Shares family surname |

**Realistic Surnames:** Blood relatives extract and share the scanned NPC's actual displayed surname. If scanning "Arina Lukina", her grandfather becomes "Hector Lukina" rather than a random name.

### Family Status

| Status | Description |
|--------|-------------|
| Alive | Living, location tracked |
| Deceased | Death recorded |
| Estranged | No contact |
| Missing | Whereabouts unknown |
| Unknown | No data available |

### Associate Types

| Category | Examples |
|----------|----------|
| **Personal** | Childhood friend, neighbor, ex-partner, roommate |
| **Professional** | Coworker, business partner, mentor, client |
| **Criminal** | Fellow gang member, fence, smuggling partner |
| **Services** | Fixer contact, dealer, ripperdoc, bartender |

### Enemy Generation

| Field | Description |
|-------|-------------|
| Name | Generated enemy identifier |
| Reason | Betrayal, debt, territory, romantic, business |
| Threat Level | Low / Moderate / High / Extreme |
| Affiliation | Gang, corpo, independent |

---

## Name Generation System

Stack-safe index-based generation with modular ethnicity files. Zero array allocation during runtime.

### Name Pool Statistics

| Category | Count | Description |
|----------|-------|-------------|
| Male First Names | 1,300 | 100 per ethnicity × 13 ethnicities |
| Female First Names | 1,300 | 100 per ethnicity × 13 ethnicities |
| Last Names | 1,300 | 100 per ethnicity × 13 ethnicities |
| Street Aliases | 120 | "Razor", "Ghost", "Chrome", etc. |
| **Total Name Entries** | **3,900** | Individual names in database |
| **Total Combinations** | **260,000+** | Unique full name possibilities |

### Name Combinations per Ethnicity

Each ethnicity provides 20,000 unique full name combinations:
- Male names: 100 first × 100 last = 10,000 combinations
- Female names: 100 first × 100 last = 10,000 combinations
- Total per ethnicity: 20,000 combinations
- 13 ethnicities × 20,000 = **260,000 total combinations**

### Supported Ethnicities

| Ethnicity | Cultural Background | File |
|-----------|---------------------|------|
| American | General American names | `AmericanNames.reds` |
| African American | African American community | `AfricanAmericanNames.reds` |
| Hispanic | Latin American heritage | `HispanicNames.reds` |
| Japanese | Japanese names with proper structure | `JapaneseNames.reds` |
| Chinese | Chinese names (family name first internally) | `ChineseNames.reds` |
| Korean | Korean naming conventions | `KoreanNames.reds` |
| Slavic | Eastern European names | `SlavicNames.reds` |
| Indian | South Asian subcontinent | `IndianNames.reds` |
| Middle Eastern | Arabic, Persian, Turkish names | `MiddleEasternNames.reds` |
| African | Various African regional names | `AfricanNames.reds` |
| Haitian | Haitian Creole influenced | `HaitianNames.reds` |
| Southeast Asian | Vietnamese, Thai, Filipino names | `SoutheastAsianNames.reds` |
| European | Western European variety | `EuropeanNames.reds` |

### Ethnicity Detection

Names are matched to NPC appearance for consistency:

```
Appearance String Analysis:
├── "asian" → Japanese / Chinese / Korean (weighted random)
├── "african" → African / African American
├── "latino" → Hispanic
├── "eastern" → Slavic / Middle Eastern
└── Default → Weighted by Night City demographics
```

---

## Narrative Coherence

Optional system that links all generated data into believable, interconnected stories.

### Life Themes

When enabled, NPCs are assigned a core narrative theme that influences all generated data:

| Theme | Description | Effects |
|-------|-------------|---------|
| STABLE | Comfortable life, steady employment | Good credit, clean record, healthy |
| STRUGGLING | Making ends meet, mounting pressure | Debt, stress conditions, minor crimes |
| CLIMBING | On the rise, ambitious trajectory | Improving finances, career advancement |
| FALLING | Downward spiral, accumulating problems | Worsening health, legal troubles, debt |
| CRIMINAL | Life outside the law | Extensive record, gang ties, illegal income |
| CORPORATE | Corp lifestyle, system player | Clean records, good credit, corpo medical |

### Flag Propagation

Shared flags propagate across all database systems:

| Flag | Criminal | Medical | Psych | Financial |
|------|----------|---------|-------|-----------|
| SUBSTANCE_ABUSE | Drug charges | Liver damage | Addiction markers | Debt from habit |
| VIOLENT_HISTORY | Assault charges | Combat injuries | Aggression flags | Legal fees |
| FINANCIAL_CRISIS | Fraud/theft | Stress conditions | Anxiety markers | Bad credit, debt |
| CORPO_BURNOUT | White collar crime | Ulcers, insomnia | Depression | Severance issues |
| GANG_AFFILIATED | Gang charges | Street injuries | Loyalty markers | Cash economy |

---

## Technical Architecture

### Seed-Based Determinism

Every NPC generates identical data across sessions:

```swift
let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
let seed = RandRange(entityIDHash, 0, 2147483647);

// All systems use offsets from base seed
let criminalSeed = seed + 1000;
let medicalSeed = seed + 2000;
let financialSeed = seed + 3000;
// etc.
```

### Stack-Safe Name Generation

Index-based selection prevents stack overflow:

```swift
private static func GetMaleAmericanNames(seed: Int32) -> String {
    let i = RandRange(seed, 0, 34);
    if i == 0 { return "Marcus"; }
    if i == 1 { return "James"; }
    if i == 2 { return "Michael"; }
    // ... indexed selection continues
    return "Scott";
}
```

### NamePool System

Relationships build a shared pool once per scan on the heap:

```swift
public class NamePool {
    public let maleFirstNames: array<String>;
    public let femaleFirstNames: array<String>;
    public let lastNames: array<String>;
    public let aliases: array<String>;

    public static func Build(seed: Int32, ethnicity: NPCEthnicity) -> ref<NamePool> {
        let pool = new NamePool();
        // Pre-generate 20 male, 20 female, 20 last, 15 aliases
        // All relationship functions index into this shared pool
        return pool;
    }
}
```

### Family Name Extraction

Blood relatives share actual NPC surnames:

```swift
private static func ExtractLastName(target: wref<NPCPuppet>) -> String {
    // Try scanner display name first
    let fullName = target.GetTweakDBFullDisplayName(true);
    
    // Fallback to localized record
    if Equals(fullName, "") {
        fullName = GetLocalizedTextByKey(record.FullDisplayName());
    }
    
    // Parse "Arina Lukina" → "Lukina"
    // Find last space, extract remainder
    return parsedLastName;
}
```

### NPC Type Detection

```swift
// Gang detection via appearance patterns
if StrContains(appearanceName, "tyger") { gang = "TYGER_CLAWS"; }
if StrContains(appearanceName, "maelstrom") { gang = "MAELSTROM"; }
if StrContains(appearanceName, "valentino") { gang = "VALENTINOS"; }

// NCPD detection
let isNCPD = target.IsPrevention() || 
             target.IsCharacterPolice() || 
             StrContains(appearanceName, "ncpd");

// Unique NPC detection via TweakDB
if StrContains(recordId, "takemura") { return UniqueNPCEntries.Takemura(); }
```

---

## Project Structure

```
r6/scripts/backgroundScanner/
├── Core/
│   ├── BackstoryManager.reds              # Main generation orchestrator
│   ├── BackstoryUI.reds                   # UI data structures
│   ├── BackstoryUIExpanded.reds           # Extended UI structures
│   ├── NameGenerator.reds                 # Ethnicity routing + 120 street aliases
│   ├── EthnicityDetector.reds             # Appearance-based ethnicity
│   ├── DatabaseSourceManager.reds         # Data source attribution
│   ├── ExpandedBackstoryManager.reds      # Extended generation logic
│   ├── CrowdArchetype.reds                # NPC archetype classification
│   ├── CrowdAssociation.reds              # Association types
│   ├── CrowdEntity.reds                   # Entity handling
│   ├── CrowdGender.reds                   # Gender detection
│   ├── CrowdTrait.reds                    # Individual traits
│   ├── CrowdTraits.reds                   # Trait collections
│   ├── CrowdWealth.reds                   # Wealth indicators
│   ├── ScannerBackstory.reds              # Scanner data structure
│   │
│   ├── Names/                             # Modular name system (v1.6.1)
│   │   ├── AmericanNames.reds             # 100 male + 100 female + 100 last
│   │   ├── AfricanAmericanNames.reds      # 100 male + 100 female + 100 last
│   │   ├── HispanicNames.reds             # 100 male + 100 female + 100 last
│   │   ├── JapaneseNames.reds             # 100 male + 100 female + 100 last
│   │   ├── ChineseNames.reds              # 100 male + 100 female + 100 last
│   │   ├── KoreanNames.reds               # 100 male + 100 female + 100 last
│   │   ├── SlavicNames.reds               # 100 male + 100 female + 100 last
│   │   ├── IndianNames.reds               # 100 male + 100 female + 100 last
│   │   ├── MiddleEasternNames.reds        # 100 male + 100 female + 100 last
│   │   ├── AfricanNames.reds              # 100 male + 100 female + 100 last
│   │   ├── HaitianNames.reds              # 100 male + 100 female + 100 last
│   │   ├── SoutheastAsianNames.reds       # 100 male + 100 female + 100 last
│   │   └── EuropeanNames.reds             # 100 male + 100 female + 100 last
│   │
│   ├── Coherence/
│   │   └── CoherenceManager.reds          # Narrative coherence system
│   │
│   ├── Criminal/
│   │   └── CriminalRecordManager.reds     # Criminal record generation
│   │
│   ├── Cyberware/
│   │   └── CyberwareRegistryManager.reds  # Cyberware registry
│   │
│   ├── District/
│   │   └── CrowdDistrictManager.reds      # District-based generation
│   │
│   ├── Financial/
│   │   └── FinancialProfileManager.reds   # Financial data
│   │
│   ├── Gang/
│   │   └── GangManager.reds               # Gang affiliation system
│   │
│   ├── LifePath/
│   │   ├── LifePath.reds                  # Core lifepath class
│   │   ├── LifePathEvent.reds             # Event with stat modifiers
│   │   ├── LifePathEvents.reds            # 698 event definitions
│   │   └── LifePathPossibilities.reds     # Weighted event selection
│   │
│   ├── Medical/
│   │   └── MedicalHistoryManager.reds     # Medical records
│   │
│   ├── NCPD/
│   │   └── NCPDNameGenerator.reds         # NCPD personnel files
│   │
│   ├── Psych/
│   │   └── PsychProfileManager.reds       # Psychological profiles
│   │
│   ├── Rare/
│   │   └── RareNPCManager.reds            # 30 special classifications
│   │
│   ├── Relationships/
│   │   └── RelationshipsManager.reds      # NamePool & relationships
│   │
│   └── Unique/
│       ├── UniqueNPCData.reds             # Unique NPC data structure
│       ├── UniqueNPCManager.reds          # Detection & lookup
│       └── UniqueNPCEntries.reds          # 82 character entries
│
├── Overrides/
│   ├── ScannerNPCBodyGameController.reds  # Scanner UI injection
│   ├── NPCPuppet.reds                     # Scanner chunk compilation
│   └── UI_ScannerModulesDef.reds          # UI module definitions
│
├── Settings/
│   └── KiroshiSettings.reds               # Mod Settings Menu integration
│
├── Text/
│   ├── TextAdulthood.reds                 # 654 lines - Adult events
│   ├── TextBackgrounds.reds               # 471 lines - Backgrounds
│   ├── TextChildhood.reds                 # 528 lines - Childhood events
│   ├── TextCore.reds                      # Core text utilities
│   ├── TextCorpos.reds                    # 106 corporation names
│   ├── TextHousing.reds                   # 305 lines - Housing types
│   ├── TextJobs.reds                      # 414 lines - Occupations
│   ├── TextLifepaths.reds                 # 321 lines - Lifepath events
│   └── TextUpbringing.reds                # 488 lines - Upbringing
│
├── UI/
│   ├── NetWatchDBReport.reds              # Database report widget
│   ├── ScannerBackstorySystem.reds        # Main UI controller
│   └── ScannerLoadingText.reds            # Loading sequence
│
└── Util/
    ├── ArrayUtils.reds                    # Array helpers
    ├── Random.reds                        # RNG utilities
    └── String.reds                        # String manipulation
```

---

## Configuration

All settings accessible via **Mod Settings Menu → Kiroshi Deep Scan**

### Display Options

| Setting | Range | Default | Description |
|---------|-------|---------|-------------|
| Data Density | Low / Medium / High | High | Information volume per scan |
| Header Font Size | 14-28 | 20 | Section header text size |
| Text Font Size | 18-34 | 26 | Body text size |

### Generation Mode

| Setting | Options | Default | Description |
|---------|---------|---------|-------------|
| Narrative Coherence | On / Off | Off | Link all data into consistent stories |
| Special NPC Rarity | Common / Rare / Mythic | Rare | Flagged NPC frequency |

**Rarity Values:**
- Common: 1 in 250 NPCs
- Rare: 1 in 750 NPCs
- Mythic: 1 in 2000 NPCs

### Content Options

| Setting | Default | Description |
|---------|---------|-------------|
| Diverse Relationships | Off | Same-sex partnerships, polyamory, chosen family |
| Body Modification Records | Off | Gender-affirming cyberware in medical (~20% of NPCs) |
| Display Pronouns | Off | Shows pronouns (85% standard, 10% they/them, 5% neo) |

---

## Installation

### Requirements

| Dependency | Purpose |
|------------|---------|
| [redscript](https://github.com/jac3km4/redscript) | Script compilation |
| [Codeware](https://github.com/psiberx/cp2077-codeware) | UI framework (inkCustomController) |
| [Mod Settings Menu](https://github.com/jackhumbert/mod_settings) | Runtime settings interface |

### Install Methods

**Vortex / Mod Manager:**
Click "Mod Manager Download" on Nexus and install through your preferred manager.

**Manual Installation:**
Extract archive to game directory, merge when prompted:

```
Cyberpunk 2077/
└── r6/
    └── scripts/
        └── backgroundScanner/
            ├── Core/
            ├── Overrides/
            ├── Settings/
            ├── Text/
            ├── UI/
            └── Util/
```

### Verify Installation

Check for compilation errors:
```
Cyberpunk 2077/r6/logs/redscript_rCURRENT.log
```

---

## Compatibility

### Incompatible Mods

| Mod | Conflict Reason |
|-----|-----------------|
| [Lifepath Bonuses and Gang-Corp Traits](https://www.nexusmods.com/cyberpunk2077/mods/2217) | Scanner override conflicts |
| [Kiroshi Opticals - Crowd Scanner Expansion](https://www.nexusmods.com/cyberpunk2077/mods/13470) | Duplicate scanner hooks |
| [Kiroshi Opticals NetWatch Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/23664) | Same functionality |

**Important:** This mod is a **standalone replacement**. Remove any existing Kiroshi scanner mods before installation.

### Compatible

- Phantom Liberty DLC (full support with unique entries)
- All gameplay mods that don't modify scanner systems
- Visual/graphics mods
- UI mods (unless they modify scanner specifically)

---

## FAQ

**Q: Nothing appears when I scan certain NPCs (like corporate employees or monks)**

A: The mod generates data for NPCs flagged as crowd, gang members, or NCPD. Some NPC types (corporate employees, monks, vendors) aren't classified as "crowd" by the game. Named characters with unique entries always display custom data regardless of classification.

**Q: Why does an NPC show "HIGH PRIORITY TARGET" but the base game shows no criminal record?**

A: Deep Scan Protocol accesses databases beyond NCPD public records — NetWatch surveillance, corporate security databases, black market bounty boards, and immigration systems. V's Kiroshi accesses information that NCPD either doesn't have, hasn't made public, or has been paid to suppress. Night City runs on secrets and bribes.

**Q: Family members have the same last name as the NPC I scanned. Is that intentional?**

A: Yes. Blood relatives (parents, siblings, grandparents, children) now extract and share the scanned NPC's actual displayed surname. If you scan "Arina Lukina", her grandfather will be "Hector Lukina" — not a randomly generated name. Spouses share the family name 80% of the time.

**Q: How do I find Special Classification NPCs?**

A: Keep scanning. Default rarity is 1 in 750. You can lower this to 1 in 250 (Common) in Mod Settings for more frequent encounters. There are 30 different classifications ranging from sleeper agents to pre-cyberpsychos.

**Q: Why don't Militech soldiers and Arasaka ninjas show backstories?**

A: Military combat NPCs (soldiers, ninjas, mechs, MaxTac, Trauma Team) display vanilla scanner info. This prevents crashes from malformed NPC data that can occur during certain missions. Regular corporate employees show full procedural data.

**Q: Does this work with Phantom Liberty?**

A: Yes. Version 1.6 includes unique hand-crafted entries for Solomon Reed, Songbird, Kurt Hansen, President Myers, and Alex. Dogtown NPCs generate procedural backstories normally.

**Q: What does Narrative Coherence actually do?**

A: When enabled, it assigns each NPC a life theme (Stable, Struggling, Criminal, etc.) and ensures all generated data tells one consistent story. A "Criminal" themed NPC will have gang ties, extensive arrest history, street injuries, and cash-based finances — not random disconnected data.

**Q: My cat Nibbles has a normal database entry now?**

A: Yes. Nibbles and other special entities now have proper unique entries that override procedural generation. No more cats with drug trafficking charges.

---

## Bug Reports

### For Compilation Errors

Include your redscript log file:
```
Cyberpunk 2077/r6/logs/redscript_rCURRENT.log
```

### For Crashes When Scanning Specific NPC

Open CET console, look at the NPC, and run:
```lua
print(Game.GetTargetingSystem():GetLookAtObject(GetPlayer(), false, false):GetRecord():GetID())
```

This prints the NPC's TweakDBID for identification.

### For Incorrect Data Display

Note the NPC type, location, and what appeared wrong. Screenshots help.

---

## Credits

| Contributor | Contribution |
|-------------|--------------|
| **Reki72** | Original [Kiroshi Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/1654) |
| **psiberx** | Codeware framework |
| **jackhumbert** | Mod Settings Menu |
| **NPC Nameplates** | TweakDB reference documentation |

---

## License

MIT License — See LICENSE file for full details.

---

<p align="center">
<b>KIROSHI DEEP SCAN PROTOCOL v1.6.1</b><br>
<i>Every secret. Revealed.</i>
</p>