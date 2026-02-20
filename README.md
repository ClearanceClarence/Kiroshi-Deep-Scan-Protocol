<p align="center">
  <img src="/branding/readme_logo.svg" alt="Kiroshi Deep Scan Protocol" width="95%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/CYBERPUNK_2077-v2.31-FFD700?style=for-the-badge&labelColor=1a1a2e" alt="Cyberpunk 2077">
  <img src="https://img.shields.io/badge/BUILD-1.8.1-5ef6e1?style=for-the-badge&labelColor=1a1a2e" alt="Version">
  <img src="https://img.shields.io/badge/REDSCRIPT-MOD-ed1d53?style=for-the-badge&labelColor=1a1a2e" alt="RedScript">
  <img src="https://img.shields.io/badge/LICENSE-MIT-3da4e0?style=for-the-badge&labelColor=1a1a2e" alt="License">
</p>

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  KIROSHI OPTICS v1.8.1 — DEEP SCAN PROTOCOL                                  ║
║  STATUS: ONLINE ■ DATABASES: 8 CONNECTED ■ CLASSIFIED ACCESS: GRANTED        ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

<p align="center">
  Hook your Kiroshi optics into every major database in Night City.<br>
  Scan any NPC — pull criminal records, cyberware registries, financials,<br>
  medical history, psych profiles, and personal relationships.<br>
  <b>Every NPC is a person. Your Kiroshi proves it.</b>
</p>

<br>

```
┌─── NAVIGATION ───────────────────────────────────────────────────────────────┐
│                                                                              │
│  ▸ Overview .................. What this mod does                            │
│  ▸ Database Access .......... 8 queryable data sources                       │
│  ▸ Unique NPC Database ...... 216 hand-written character files               │
│  ▸ Procedural Generation .... Systems that build NPC lives                   │
│  ▸ Special Classifications .. 90 hidden NPC types                            │
│  ▸ Relationships ............ Social network generation                      │
│  ▸ Name Generation .......... 260K+ culturally matched names                 │
│  ▸ Narrative Coherence ...... Life theme system                              │
│  ▸ Configuration ............ Mod settings breakdown                         │
│  ▸ Installation ............. Requirements + setup                           │
│  ▸ Compatibility ............ Known conflicts                                │
│  ▸ FAQ ...................... Common questions                               │
│  ▸ Bug Reports .............. How to report issues                           │
│  ▸ Technical Architecture ... Code structure + internals                     │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

<br>

## █▓▒░ OVERVIEW

Deep Scan Protocol hooks your Kiroshi optics into every major database in Night City. Scan any civilian and pull their NCPD criminal records, cyberware registry, bank records, medical history, psychological profile, and personal relationships. Scan gang members for affiliation intel. Scan NCPD officers for personnel files. Scan named characters for hand-written, lore-accurate classified dossiers.

All data is **deterministically generated** from each NPC's entity ID — the same NPC always produces identical results across sessions. No two citizens share a profile.

<table>
<tr>
<td align="center"><h3>216</h3><sub>UNIQUE NPCs</sub></td>
<td align="center"><h3>699</h3><sub>LIFE EVENTS</sub></td>
<td align="center"><h3>90</h3><sub>CLASSIFICATIONS</sub></td>
<td align="center"><h3>260K+</h3><sub>NAME COMBOS</sub></td>
</tr>
<tr>
<td align="center"><h3>11</h3><sub>GANG PROFILES</sub></td>
<td align="center"><h3>13</h3><sub>ETHNICITIES</sub></td>
<td align="center"><h3>3,900</h3><sub>NAME ENTRIES</sub></td>
<td align="center"><h3>8</h3><sub>DATA SOURCES</sub></td>
</tr>
</table>

<br>

> **`216 UNIQUE NPCs`** · **`TOTAL COVERAGE: BASE GAME + PHANTOM LIBERTY`**

<br>

## █▓▒░ DATABASE ACCESS

```
┌─── CONNECTED SOURCES ────────────────────────────────────────────────────────┐
│                                                                              │
│  [01]  NCPD CRIMINAL DATABASE                                                │
│        Arrests, charges, convictions, warrant status, threat classification  │
│                                                                              │
│  [02]  NC FINANCIAL REGISTRY                                                 │
│        Credit rating, NC ID, income, debt, employment, assets                │
│                                                                              │
│  [03]  TRAUMA TEAM RECORDS                                                   │
│        Coverage tier, response priority, payment status, medical file        │
│                                                                              │
│  [04]  NETWATCH PSYCHOLOGICAL INDEX                                          │
│        Temperament, behavioral flags, violence risk, loyalty markers         │
│                                                                              │
│  [05]  CYBERWARE REGISTRATION SYSTEM                                         │
│        Implant inventory, psychosis risk, illegal modifications              │
│                                                                              │
│  [06]  SOCIAL NETWORK ANALYSIS                                               │
│        Family, associates, enemies, professional contacts                    │
│                                                                              │
│  [07]  GANG INTELLIGENCE DIVISION                                            │
│        Affiliation, rank, territory, loyalty assessment                      │
│                                                                              │
│  [08]  NCPD PERSONNEL SYSTEM                                                 │
│        Badge number, rank, unit assignment, service record                   │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

> **Smart Filtering:** Gang members won't show bank records. NCPD officers have sealed criminal files. Children display a protected status message only. Military combat NPCs show vanilla scanner data to prevent crashes.

<br>

## █▓▒░ UNIQUE NPC DATABASE

216 named characters have hand-written, lore-accurate backstories that completely override procedural generation. Custom classifications, detailed backgrounds, threat assessments, and dynamic quest states that update as you play.

<details>
<summary><b>▸ ARASAKA CORPORATION</b> — 10 entries</summary>

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ARASAKA CORPORATION — CLASSIFIED PERSONNEL FILES                            ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

| Character | Classification | Notes |
|:--|:--|:--|
| Saburo Arasaka | ARASAKA - EMPEROR | Dynamic state after The Heist |
| Yorinobu Arasaka | ARASAKA - HEIR | Patricide flagged post-Heist |
| Hanako Arasaka | ARASAKA - PRINCESS | Protected diplomatic status |
| Goro Takemura | ARASAKA - DISAVOWED | State changes on quest progress |
| Sandayu Oda | ARASAKA - PERSONAL SECURITY | Hanako's protection detail |
| Adam Smasher | ARASAKA - MILITARY ASSET | Full cyborg combat platform |
| Anders Hellman | ARASAKA - RESEARCH | Relic program lead |
| Graham Mayfield | ARASAKA - SECURITY | Corporate operative |
| Hanako Bodyguards | ARASAKA - PERSONAL SECURITY | Elite protection detail |
| Arasaka Security | ARASAKA - SECURITY | Standard operatives |

</details>

<details>
<summary><b>▸ MILITECH</b> — 3 entries</summary>

| Character | Classification |
|:--|:--|
| Meredith Stout | MILITECH - COUNTERINTELLIGENCE |
| Weldon Holt | MILITECH - EXECUTIVE |
| Militech Commander | MILITECH - FIELD OPERATIONS |

</details>

<details>
<summary><b>▸ FIXERS</b> — 9 entries</summary>

| Character | Territory | Notes |
|:--|:--|:--|
| Rogue Amendiares | Afterlife | Legend. Queen of the Afterlife |
| Dexter DeShawn | Watson | High-profile jobs. Dynamic state |
| Wakako Okada | Westbrook | Information broker |
| Regina Jones | Watson | NCPD connections |
| Sebastian "Padre" Ibarra | Heywood | Valentinos ties |
| Dakota Smith | Badlands | Nomad specialist |
| Dino Dinovic | Santo Domingo | Industrial work |
| Mr. Hands | Pacifica / Dogtown | Phantom Liberty content |
| El Capitan | Santo Domingo | Vehicle specialist |

</details>

<details>
<summary><b>▸ AFTERLIFE & LEGENDS</b> — 8 entries</summary>

| Character | Classification | Notes |
|:--|:--|:--|
| Jackie Welles | MERC - PARTNER | Dynamic state after The Heist |
| T-Bug | MERC - NETRUNNER | Dynamic state |
| Johnny Silverhand | ENGRAM - TERRORIST | Rockerboy legend |
| Kerry Eurodyne | CIVILIAN - CELEBRITY | Samurai guitarist |
| Alt Cunningham | NETRUNNER - BEYOND BLACKWALL | First Soulkiller victim |
| Claire Russell | CIVILIAN - BARTENDER | Afterlife bartender, racer |
| Crispin Weyland | MERC - AFTERLIFE | Known as Squama |
| Nix | NETRUNNER - AFTERLIFE | Resident paranoid netrunner |

</details>

<details>
<summary><b>▸ GANG LEADERSHIP</b> — 14 entries</summary>

**Maelstrom:** Royce (Leader), Dum Dum (Lieutenant), Brick (Former leader — imprisoned)

**Tyger Claws:** Jotaro Shobo (Lieutenant), Hiromi Sato (Operations)

**Valentinos:** Gustavo Orta (Leadership), Jose Luis (Enforcer), Octavio Ruiz (Associate)

**Voodoo Boys:** Brigitte (Maman), Placide (Enforcer)

**Animals:** Sasquatch (Leader) · **Wraiths:** Nash (Leader) · **Scavengers:** Anton Kolos (Cell leader)

</details>

<details>
<summary><b>▸ MOX, CLOUDS & ALDECALDOS</b> — 7 entries</summary>

| Character | Classification | Notes |
|:--|:--|:--|
| Judy Alvarez | TECHNICIAN - MOX | BD editor, Evelyn's friend |
| Evelyn Parker | CIVILIAN - DOLL | Dynamic state based on quest |
| Maiko Maeda | CLOUDS - MANAGEMENT | Ambitious, corp connections |
| Woodman | CLOUDS - SECURITY | Tyger Claws enforcer |
| Panam Palmer | ALDECALDO - DRIVER | Expert driver |
| Saul Bright | ALDECALDO - LEADER | Clan leader |
| Mitch Anderson | ALDECALDO - MECHANIC | Scorpion's friend |

</details>

<details>
<summary><b>▸ RIPPERDOCS, NCPD, NETWATCH & MEDIA</b> — 18 entries</summary>

**Ripperdocs:** Viktor Vektor (Little China), Fingers (Jig-Jig Street), Charles Bucks (Kabuki), Misty Olszewski (Esoterica)

**NCPD & Politics:** River Ward (Detective), Jefferson Peralez (Politician), Lucius Rhyne (Mayor — dynamic), Barry (Officer)

**NetWatch:** Bryce Mosley (Pacifica operations)

**Media:** Lizzy Wizzy, Blue Moon, Ozob Bozo, Joshua Stephenson, Gillean Jordan, Max Jones, Cassius Ryder

**Vendors:** Wilson (2nd Amendment), Coach Fred (Boxing)

</details>

<details>
<summary><b>▸ PHANTOM LIBERTY — MAIN CAST</b> — 5 entries</summary>

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  FIA / NUSA — TOP SECRET PERSONNEL FILES                                     ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

| Character | Classification | Notes |
|:--|:--|:--|
| Solomon Reed | FIA - DEEP COVER | Legendary sleeper agent |
| Songbird (So Mi) | FIA - NETRUNNER | Blackwall-damaged, Relic bearer |
| Kurt Hansen | BARGHEST - LEADER | PMC warlord, controls Dogtown |
| Rosalind Myers | NUSA - PRESIDENT | Former Militech CEO |
| Alena "Alex" Xenakis | FIA - DEEP COVER OPERATIVE | The Moth bar cover |

</details>

<details>
<summary><b>▸ PHANTOM LIBERTY — DOGTOWN NPCs</b> — 16 entries</summary>

**Longshore Stacks:** Leon Watson (Weapons), Costin Lahovary (Ripperdoc), Ronald "Typhoon" Malone (Junk), Susanna Mack (Ex-Trauma Team)

**EBM Petrochem Stadium:** Sophia Dupont (Weapons), David Walker (Clothing), Herold Lowe (Black Market Arms), Sammy Taylor (Netrunner Supplies), Saki Seo (Medical), Eron Acedo (Ripperdoc), Marcin Iwiński (Easter egg), Michał Kiciński (Easter egg)

**No Easy Way Out:** Angelica Whelan, Damir Kovac, Aaron Waines, William Correy

</details>

<details>
<summary><b>▸ PHANTOM LIBERTY — GIGS</b> — 22 entries</summary>

```
╔══════════════════════════════════════════════════════════════════════════════╗
║   DOGTOWN GIG PERSONNEL                                                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

| Gig | Characters |
|:--|:--|
| **Dogtown Saints** | Nika Yankovich · Odell Blanco · Anthony Anderson |
| **Prototype in the Scraper** | Hasan Demir |
| **Waiting for Dodger** | Bill Mitchel · Charles Wilson · Carl Robinson |
| **The Man Who Killed Jason Foreman** | Briana Dolson |
| **Spy in the Jungle** | Steven Santos · Ana Friedman · Boris Ribakov · Katya Karelina |
| **Talent Academy** | Baird · Tommie Walker · Fiona Vargas · David Walker |
| **Heaviest of Hearts** | Michael Maldonado · Georgina Zembinsky |
| **Roads to Redemption** | Nele Springer |
| **Treating Symptoms** | Alan Noël |
| **Other** | Kyle Araujo |

</details>

<details>
<summary><b>▸ OTHER NOTABLE CHARACTERS</b> — 5 entries</summary>

Delamain (AI taxi) · Mama Welles (Jackie's mother) · Nibbles (V's cat) · Brendan (Sentient vending machine) · Skippy (Sentient pistol)

</details>

<details>
<summary><b>▸ DYNAMIC QUEST STATES</b></summary>

These entries update based on game progression:

| Character | Trigger | Change |
|:--|:--|:--|
| Takemura | The Heist | Disavowed status, manhunt data |
| Jackie Welles | The Heist | Entry reflects fate |
| T-Bug | The Heist | Status updated |
| Evelyn Parker | Automatic Love | Reflects storyline |
| Dexter DeShawn | The Heist | Dynamic state |
| Saburo Arasaka | The Heist | Death recorded |
| Lucius Rhyne | Dream On | Status changes |

</details>

<br>

## █▓▒░ PROCEDURAL GENERATION

Every non-unique NPC gets a full procedural profile built from their entity ID.

### ░ Life Events

699 unique events build procedural backstories. Each carries gender-specific text, stat modifiers, and lifepath weighting.

| Category | Count | Examples |
|:--|:--|:--|
| **Upbringing** | ~115 | Family structure, parental jobs, wealth level, orphan status |
| **Housing** | ~97 | Megabuilding units, combat zone squats, nomad camps |
| **Childhood** | ~178 | Education, street skills, gang youth, talents, trauma |
| **Jobs** | ~103 | Criminal careers, merc work, tech, service, corpo |
| **Adulthood** | ~213 | Relationships, violence, health crises, legal troubles |

### ░ Criminal Records

Status (Clean → Most Wanted), specific charges with dates, convictions, warrant status, NCPD classification, and corporate security alerts.

### ░ Financial Profile

NC ID number (NC######), credit score + tier, estimated wealth, debt (amount, holder, status), property/residence, employment, income, recent purchases, tax status, Trauma Team coverage, bank affiliation. Poor archetypes properly generate coherent low income.

### ░ Medical History

Blood type with RhD notation (e.g. A RhD+, O RhD−), chronic conditions, injury history, cyberware complications, substance issues, mental health flags. Trauma Team coverage tier shown on summary line.

### ░ Cyberware Registry

Total implant count, category breakdown (Neural / Optical / Skeletal / Dermal / Circulatory), psychosis risk percentage, illegal modifications, registry compliance status.

### ░ Psychological Profile

Temperament, behavioral flags, violence risk score (0–100), loyalty index, notable traits.

### ░ Gang Profiles

11 complete gang profile systems (all 10 NC gangs + Barghest). Gang-specific ranks, specializations, territories, loyalty systems, 12+ unique backstories each, and gang-appropriate statistics.

<br>

## █▓▒░ SPECIAL CLASSIFICATIONS

90 hidden NPC types. Configurable odds (default 1 in 750). Citizens look completely normal until scanned.

```
┌─── CLASSIFICATION INDEX ─────────────────────────────────────────────────────┐
│                                                                              │
│  INTELLIGENCE ···· 10 types    CORPORATE ········· 9 types                   │
│  HIGH-VALUE ······  9 types    MEDICAL/BIO ······ 13 types                   │
│  NEURAL/CYBER ····  9 types    AI/DIGITAL ······· 10 types                   │
│  COVERT ··········  5 types    UNDERGROUND ·······  6 types                  │
│  OUTCASTS ········ 10 types    IDENTITY/ANOMALY ··  9 types                  │
│                                                              TOTAL: 90       │
└──────────────────────────────────────────────────────────────────────────────┘
```

<details>
<summary><b>▸ INTELLIGENCE ASSETS</b> — 10 types</summary>
<br>

`SLEEPER_AGENT` · `DOUBLE_AGENT` · `UNDERCOVER_COP` · `GANG_INFILTRATOR` · `FIXER_ASSET` · `DATA_COURIER` · `NCPD_INFORMANT` · `DRAGON_COURIER` · `DARK_NET_LEGEND` · `SMUGGLER_TUNNEL_OPERATOR`

</details>

<details>
<summary><b>▸ CORPORATE</b> — 9 types</summary>
<br>

`CORPO_WHISTLEBLOWER` · `CORPO_DEFECTOR` · `CORPO_HEIR_HIDING` · `CORPO_ASSET_FROZEN` · `CORPO_INTERN_TRAPPED` · `CORPO_DEBT_SLAVE` · `INDENTURED_CORPO` · `BLACKMAIL_VICTIM` · `PROXY_VOTER`

</details>

<details>
<summary><b>▸ HIGH-VALUE TARGETS</b> — 9 types</summary>
<br>

`WITNESS_PROTECTION` · `WITNESS` · `HUNTED` · `MAXTAC_TARGET` · `ACTIVE_BOUNTY` · `REAPER_CONTRACT` · `DEBT_COLLECTION` · `ORGAN_MARKED` · `MISSING_PERSON`

</details>

<details>
<summary><b>▸ MEDICAL & BIOLOGICAL</b> — 13 types</summary>
<br>

`PRE_CYBERPSYCHO` · `CYBERPSYCHO_RECOVERED` · `CLONE_SUBJECT` · `EXPERIMENTAL_SUBJECT` · `ENGRAM_CANDIDATE` · `RELIC_COMPATIBLE` · `TRAUMA_TEAM_MARKED` · `IMMUNE_ANOMALY` · `GENETIC_CHIMERA` · `BIOPLAGUE_CARRIER` · `RADIATION_EXPOSURE` · `FLATLINE_REVIVED` · `CONTAMINATED_SCOP`

</details>

<details>
<summary><b>▸ NEURAL & CYBERWARE</b> — 9 types</summary>
<br>

`NEURAL_DIVERGENT` · `UNREGISTERED_CHROME` · `INFECTED_FIRMWARE` · `IMPLANT_BOMB` · `DOLL_CHIP_SLEEPER` · `MEMORY_WIPED` · `SIGNAL_CARRIER` · `BLACK_ICE_SURVIVOR` · `BRAINDANCE_ADDICT`

</details>

<details>
<summary><b>▸ AI & DIGITAL</b> — 10 types</summary>
<br>

`AI_CONTACT` · `AI_PUPPET` · `BLACKWALL_TOUCHED` · `DELAMAIN_GLITCH` · `GHOST_IN_MACHINE` · `PERSONALITY_FRAGMENT` · `SOUL_SPLIT` · `SOULKILLER_SURVIVOR` · `ARASAKA_ENGRAM_ECHO` · `TECHNO_NECRO`

</details>

<details>
<summary><b>▸ COVERT PROGRAMS</b> — 5 types</summary>
<br>

`NIGHT_CORP_SUBJECT` · `PERALEZ_PROTOCOL` · `DREAMTECH_VICTIM` · `SYNTHETIC_SLEEPER` · `DEEP_FAKE_IDENTITY`

</details>

<details>
<summary><b>▸ UNDERGROUND</b> — 6 types</summary>
<br>

`HIDDEN_NETRUNNER` · `RETIRED_LEGEND` · `LEGACY_CHARACTER` · `ILLEGAL_BD_PRODUCER` · `WETWORK_RETIRED` · `MAXTAC_WASHOUT`

</details>

<details>
<summary><b>▸ OUTCASTS & SURVIVORS</b> — 10 types</summary>
<br>

`GHOST` · `MILITARY_AWOL` · `NOMAD_EXILE` · `CULT_ESCAPEE` · `COMBAT_ZONE_SURVIVOR` · `GHOST_TOWN_SURVIVOR` · `FERAL_ZONE_BORN` · `CHILD_SOLDIER_GROWN` · `CARGO_STOWAWAY` · `SCOP_FARMER_REFUGEE`

</details>

<details>
<summary><b>▸ IDENTITY & ANOMALOUS</b> — 9 types</summary>
<br>

`IDENTITY_STOLEN` · `BURIED_PAST` · `ILLEGAL_PROCREATION` · `CHRONO_DISPLACED` · `ORBITAL_RETURNEE` · `POLITICAL_DISSIDENT` · `PRECOG_SUBJECT` · `TIME_ANOMALY` · `ARASAKA_BLOODLINE`

</details>

<br>

## █▓▒░ RELATIONSHIPS

Every NPC gets a procedurally generated social network.

```
┌─── RELATIONSHIP TYPES ───────────────────────────────────────────────────────┐
│                                                                              │
│  FAMILY ········· 0–5 members    Blood relatives share actual NPC surname    │
│  ASSOCIATES ····· 1–8 contacts   Friends, coworkers, relationship context    │
│  ENEMIES ········ 0–3 hostiles   Named with reason, threat level, faction    │
│  PROFESSIONAL ··· 0–3 contacts   Fixers, ripperdocs, dealers                 │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

> Spouses share the family name 80% of the time. Scan "Arina Lukina" and her grandfather becomes "Hector Lukina" — not a random name.

<br>

## █▓▒░ NAME GENERATION

260,000+ unique full names across 13 culturally appropriate ethnic groups matched to NPC appearance. Zero array allocation at runtime — fully index-based for stack safety.

| Group | Ethnicities | Per Ethnicity |
|:--|:--|:--|
| **Americas** | American · African American · Hispanic | 100M + 100F + 100L |
| **East Asia** | Japanese · Chinese · Korean | 100M + 100F + 100L |
| **Central** | Slavic · Indian · Middle Eastern | 100M + 100F + 100L |
| **Other** | African · Haitian · Southeast Asian · European | 100M + 100F + 100L |

> **20,000 combinations per ethnicity × 13 = 260,000+ unique names.** Plus 120 street aliases for gang associates.

<br>

## █▓▒░ NARRATIVE COHERENCE

Always active. Every NPC is assigned a life theme that ensures all data tells one consistent story.

| Theme | Criminal | Medical | Financial | Psych |
|:--|:--|:--|:--|:--|
| **STABLE** | Clean record | Healthy | Good credit, steady job | Stable |
| **STRUGGLING** | Minor crimes | Stress conditions | Mounting debt | Anxiety |
| **CLIMBING** | Clean/minor | Healthy | Improving | Ambitious |
| **FALLING** | Growing record | Declining | Spiraling debt | Depression |
| **CRIMINAL** | Extensive | Street injuries | Illegal income | Aggression |
| **CORPORATE** | White collar | Corpo medical | Good credit | Calculated |

> Flags propagate across systems — `SUBSTANCE_ABUSE` generates drug charges in criminal, liver damage in medical, addiction markers in psych, and debt-from-habit in financial. Cross-system checks ensure married NPCs always have a spouse listed, grudge-holders always have enemies, and rejected implants always affect medical records. Everything connects.

<br>

## █▓▒░ CONFIGURATION

All settings: **Mod Settings Menu → Kiroshi Deep Scan**

### ░ Display

| Setting | Range | Default |
|:--|:--|:--|
| Data Density | Low / Medium / High | High |
| Header Font Size | 14–28 | 20 |
| Text Font Size | 18–34 | 26 |
| Compact Mode | Off / Tight / Tighter / Tightest | Off |
| Compact Relationships | On / Off | On |

### ░ Generation

| Setting | Options | Default |
|:--|:--|:--|
| Special NPC Rarity | Common (1:250) / Rare (1:750) / Mythic (1:2000) | Rare |

### ░ Content

| Setting | Default | Description |
|:--|:--|:--|
| Diverse Relationships | Off | Same-sex partnerships, polyamory, chosen family |
| Body Modification Records | Off | Gender-affirming cyberware in medical records |
| Pronouns | Off | Pronoun display in scan data |

### ░ Developer

| Setting | Default | Description |
|:--|:--|:--|
| Debug Mode | Off | Shows TweakDB ID + appearance name in scanner |

<br>

## █▓▒░ INSTALLATION

### ░ Requirements

| Dependency | Purpose |
|:--|:--|
| [redscript](https://github.com/jac3km4/redscript) | Script compilation |
| [Codeware](https://github.com/psiberx/cp2077-codeware) | UI framework |
| [Mod Settings Menu](https://github.com/jackhumbert/mod_settings) | Settings interface |

### ░ Install

**Via Mod Manager:** Click "Mod Manager Download" on Nexus. Done.

**Manual:** Extract to game directory, merge when prompted:

```
Cyberpunk 2077/r6/scripts/backgroundScanner/
```

### ░ Verify

Check for compilation errors in:

```
Cyberpunk 2077/r6/logs/redscript_rCURRENT.log
```

<br>

## █▓▒░ COMPATIBILITY

### ❌ Incompatible

| Mod | Reason |
|:--|:--|
| [Lifepath Bonuses and Gang-Corp Traits](https://www.nexusmods.com/cyberpunk2077/mods/2217) | Scanner override conflicts |
| [Kiroshi Opticals - Crowd Scanner Expansion](https://www.nexusmods.com/cyberpunk2077/mods/13470) | Duplicate scanner hooks |
| [Kiroshi Opticals NetWatch Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/23664) | Same functionality |

> **Remove any existing Kiroshi scanner mods before installing.** This mod is a standalone replacement.

### ✅ Compatible

Phantom Liberty (full support) · All gameplay mods not touching the scanner · Visual/graphics mods · UI mods that don't modify the scanner panel

<br>

## █▓▒░ FAQ

<details>
<summary><b>▸ Nothing appears for certain NPCs (corporate employees, monks, vendors)</b></summary>
<br>
The mod generates data for NPCs flagged as crowd, gang, or NCPD. Some types aren't classified as "crowd" by the game engine. Named characters with unique entries always display regardless.
</details>

<details>
<summary><b>▸ Why does an NPC show "HIGH PRIORITY TARGET" when the game shows nothing?</b></summary>
<br>
Deep Scan accesses databases beyond NCPD public records — NetWatch surveillance, corporate security, black market bounty boards, immigration systems. V's Kiroshi sees what NCPD either doesn't have, hasn't made public, or has been paid to suppress.
</details>

<details>
<summary><b>▸ Family members share the NPC's last name — intentional?</b></summary>
<br>
Yes. Blood relatives extract the scanned NPC's actual displayed surname. Scan "Arina Lukina" and her grandfather becomes "Hector Lukina." Spouses share the name 80% of the time.
</details>

<details>
<summary><b>▸ How do I find Special Classification NPCs?</b></summary>
<br>
Keep scanning. Default is 1 in 750. Lower to 1 in 250 (Common) in settings. There are 90 types to discover.
</details>

<details>
<summary><b>▸ Why don't soldiers / MaxTac / Trauma Team show backstories?</b></summary>
<br>
Military combat NPCs display vanilla scanner info to prevent crashes from malformed NPC data during certain missions. Regular corporate employees show full procedural data.
</details>

<details>
<summary><b>▸ Does this work with Phantom Liberty?</b></summary>
<br>
Full support. 43 unique hand-crafted Dogtown entries including Solomon Reed, Songbird, Kurt Hansen, President Myers, all stadium and Longshore Stacks vendors, No Easy Way Out characters, and 20 gig NPCs.
</details>

<details>
<summary><b>▸ How does Narrative Coherence work?</b></summary>
<br>
Every NPC is assigned a life theme (Stable, Struggling, Criminal, etc.) and all data systems reference it. A "Falling" NPC has declining credit, substance issues, recent termination, lapsed Trauma Team coverage, and growing debt — not random disconnected data. This is always active.
</details>

<details>
<summary><b>▸ What's the NC ID number?</b></summary>
<br>
A Night City citizen registration number (NC######) in financial records. Homeless NPCs show UNREGISTERED or REVOKED. Nomads show CLAN ID ONLY.
</details>

<details>
<summary><b>▸ What does TT: SILVER mean on the medical line?</b></summary>
<br>
Trauma Team coverage tier. PLATINUM = full priority. GOLD = fast response. SILVER = standard. NONE = no coverage. Select "Trauma Team" as database source for the full file.
</details>

<details>
<summary><b>▸ Scanner panel too tall / overlaps other mods</b></summary>
<br>
Mod Settings → Kiroshi Deep Scan → Display → Compact Mode. Set to Tight, Tighter, or Tightest.
</details>

<details>
<summary><b>▸ Nibbles has a database entry?</b></summary>
<br>
Yes. No more cats with drug trafficking charges.
</details>

<br>

## █▓▒░ BUG REPORTS

### ░ Compilation Errors

Include your redscript log:

```
Cyberpunk 2077/r6/logs/redscript_rCURRENT.log
```

### ░ Crash When Scanning Specific NPC

Look at the NPC in CET console and run:

```lua
print(Game.GetTargetingSystem():GetLookAtObject(GetPlayer(), false, false):GetRecord():GetID())
```

### ░ NPC Not Detected Correctly

```lua
print(Game.GetTargetingSystem():GetLookAtObject(GetPlayer(), false, false):GetCurrentAppearanceName())
```

Or enable **Debug Mode** in Mod Settings → Developer, scan the NPC, and screenshot.

<br>

## █▓▒░ TECHNICAL ARCHITECTURE

<details>
<summary><b>▸ NAMESPACE & DETERMINISM</b></summary>
<br>

All classes use the `Kdsp` prefix (e.g. `KdspRareNPCData`, `KdspNamePool`, `KdspGangManager`).

Every NPC generates identical data across sessions via entity ID hashing:

```swift
let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
let seed = RandRange(entityIDHash, 0, 2147483647);

let criminalSeed = seed + 1000;
let medicalSeed = seed + 2000;
let financialSeed = seed + 3000;
```

Name generation is fully index-based — no array allocation at runtime — to prevent stack overflow.

</details>

<details>
<summary><b>▸ NPC DETECTION</b></summary>
<br>

```swift
// Gang detection via appearance patterns
if StrContains(appearanceName, "tyger") { gang = "TYGER_CLAWS"; }
if StrContains(appearanceName, "maelstrom") { gang = "MAELSTROM"; }

// NCPD detection
let isNCPD = target.IsPrevention() ||
             target.IsCharacterPolice() ||
             StrContains(appearanceName, "ncpd");

// Unique NPC detection via TweakDB
if StrContains(recordId, "takemura") { return KdspUniqueNPCEntries.Takemura(); }
```

</details>

<details>
<summary><b>▸ PROJECT STRUCTURE</b></summary>
<br>

```
r6/scripts/backgroundScanner/
│
├── Core/
│   ├── BackstoryManager.reds              Main generation orchestrator
│   ├── BackstoryUI.reds                   UI data structures
│   ├── BackstoryUIExpanded.reds           Extended UI structures
│   ├── NameGenerator.reds                 Ethnicity routing + 120 aliases
│   ├── EthnicityDetector.reds             Appearance-based ethnicity
│   ├── DatabaseSourceManager.reds         Data source attribution
│   ├── ExpandedBackstoryManager.reds      Extended generation logic
│   ├── CrowdArchetype.reds               NPC archetype classification
│   ├── CrowdAssociation / Entity / Gender / Trait / Traits / Wealth .reds
│   ├── ScannerBackstory.reds              Scanner data structure
│   │
│   ├── Names/                             13 ethnicity files × 300 names
│   ├── Barghest/                          Barghest militia profiles
│   ├── Coherence/                         Narrative coherence system
│   ├── Criminal/                          Criminal record generation
│   ├── Cyberware/                         Cyberware registry
│   ├── District/                          District-based generation
│   ├── Financial/                         Financial profiles + NC ID
│   ├── Gang/                              11 modular gang profiles
│   ├── LifePath/                          699 event definitions
│   ├── Medical/                           Medical records + blood types
│   ├── NCPD/                              NCPD personnel files
│   ├── Psych/                             Psychological profiles
│   ├── Rare/                              90 special classifications
│   ├── Relationships/                     KdspNamePool + social networks
│   └── Unique/                            216 character entries
│
├── Overrides/
│   ├── ScannerNPCBodyGameController.reds  Scanner UI injection
│   ├── NPCPuppet.reds                    Scanner chunk compilation
│   └── UI_ScannerModulesDef.reds         UI module definitions
│
├── Settings/
│   └── KiroshiSettings.reds              Mod Settings integration
│
├── Text/                                  ~3,300 lines of content
│   └── TextAdulthood / Backgrounds / Childhood / Core /
│       Corpos / Housing / Jobs / Lifepaths / Upbringing .reds
│
├── UI/
│   ├── NetWatchDBReport.reds             Database report widget
│   ├── ScannerBackstorySystem.reds       Main UI controller
│   └── ScannerLoadingText.reds           Loading sequence
│
└── Util/
    └── ArrayUtils / Random / String .reds
```

</details>

<br>

## █▓▒░ CHANGELOG

See [CHANGELOG.md](CHANGELOG.md) for full version history.

<br>

## █▓▒░ CREDITS

| | |
|:--|:--|
| **Reki72** | Original [Kiroshi Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/1654) |
| **psiberx** | Codeware framework |
| **jackhumbert** | Mod Settings Menu |
| **NPC Nameplates** | TweakDB reference documentation |

<br>

## █▓▒░ LICENSE

MIT — See [LICENSE](LICENSE) for details.

---

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║           KIROSHI DEEP SCAN PROTOCOL v1.8.1                                  ║
║           DATABASES: 8 ■ UNIQUE NPCs: 216 ■ CLASSIFICATIONS: 90              ║
║                                                                              ║
║           Every NPC is a person.                                             ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```
