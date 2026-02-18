<p align="center">
  <img src="/branding/readme_logo.svg" alt="Kiroshi Deep Scan Protocol" width="600">
</p>

<p align="center">
  <strong>Every NPC is a person. Your Kiroshi proves it.</strong>
</p>

<p align="center">
  <a href="#installation"><img src="https://img.shields.io/badge/Cyberpunk_2077-v2.x-FFD700?style=for-the-badge" alt="Cyberpunk 2077"></a>
  <img src="https://img.shields.io/badge/version-1.8.0-5ef6e1?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/redscript-mod-ed1d53?style=for-the-badge" alt="RedScript">
  <img src="https://img.shields.io/badge/license-MIT-3da4e0?style=for-the-badge" alt="License">
</p>

<p align="center">
  <a href="#installation">Install</a> · <a href="#configuration">Configure</a> · <a href="#faq">FAQ</a> · <a href="#bug-reports">Bug Reports</a> · <a href="CHANGELOG.md">Changelog</a>
</p>

---

Deep Scan Protocol hooks your Kiroshi optics into every major database in Night City. Scan any civilian and pull their NCPD criminal records, cyberware registry, bank records, medical history, psychological profile, and personal relationships. Scan gang members for affiliation data. Scan NCPD officers for personnel files. Scan unique characters for hand-written lore-accurate dossiers.

All data is **deterministically generated** from each NPC's entity ID — the same NPC always produces identical results across sessions.

<br>

## 📊 By the Numbers

<table>
<tr>
<td align="center"><h3>204</h3><sub>Unique NPCs</sub></td>
<td align="center"><h3>699</h3><sub>Life Events</sub></td>
<td align="center"><h3>90</h3><sub>Special Classifications</sub></td>
<td align="center"><h3>260K+</h3><sub>Name Combinations</sub></td>
</tr>
<tr>
<td align="center"><h3>11</h3><sub>Gang Profiles</sub></td>
<td align="center"><h3>13</h3><sub>Ethnicities</sub></td>
<td align="center"><h3>3,900</h3><sub>Name Entries</sub></td>
<td align="center"><h3>8</h3><sub>Database Sources</sub></td>
</tr>
</table>

<br>

## 🗄️ Database Access

When you scan an NPC, Deep Scan Protocol queries these sources:

| Database | What You Get |
|:--|:--|
| **NCPD Criminal Database** | Arrests, charges, convictions, warrant status, threat classification |
| **NC Financial Registry** | Credit rating, NC ID, income, debt, employment, assets |
| **Trauma Team Records** | Coverage tier, response priority, payment status, medical file |
| **NetWatch Psych Index** | Temperament, behavioral flags, violence risk, loyalty markers |
| **Cyberware Registry** | Implant inventory, psychosis risk, illegal modifications |
| **Social Network Analysis** | Family, associates, enemies, professional contacts |
| **Gang Intelligence** | Affiliation, rank, territory, loyalty assessment |
| **NCPD Personnel System** | Badge number, rank, unit, service record |

Different NPC types get contextually filtered data — gang members won't show bank records, NCPD officers have sealed criminal files, and children display a protected status message only.

<br>

## 🎯 Unique NPC Database

204 named characters have hand-written, lore-accurate backstories that completely override procedural generation. These entries feature custom classifications, detailed backgrounds, threat assessments, and — for key story characters — dynamic quest states that update as you progress.

<details>
<summary><b>Arasaka Corporation</b> — 10 entries</summary>
<br>

| Character | Classification |
|:--|:--|
| Saburo Arasaka | ARASAKA - EMPEROR · Dynamic state after The Heist |
| Yorinobu Arasaka | ARASAKA - HEIR · Patricide flagged post-Heist |
| Hanako Arasaka | ARASAKA - PRINCESS · Protected diplomatic status |
| Goro Takemura | ARASAKA - DISAVOWED · State changes based on quest |
| Sandayu Oda | ARASAKA - PERSONAL SECURITY |
| Adam Smasher | ARASAKA - MILITARY ASSET · Full cyborg combat platform |
| Anders Hellman | ARASAKA - RESEARCH · Relic program lead |
| Graham Mayfield | ARASAKA - SECURITY |
| Hanako Bodyguards | ARASAKA - PERSONAL SECURITY |
| Arasaka Security | ARASAKA - SECURITY |

</details>

<details>
<summary><b>Militech</b> — 3 entries</summary>
<br>

| Character | Classification |
|:--|:--|
| Meredith Stout | MILITECH - COUNTERINTELLIGENCE |
| Weldon Holt | MILITECH - EXECUTIVE |
| Militech Commander | MILITECH - FIELD OPERATIONS |

</details>

<details>
<summary><b>Fixers</b> — 9 entries</summary>
<br>

| Character | Territory |
|:--|:--|
| Rogue Amendiares | Afterlife · Legend |
| Dexter DeShawn | Watson · Dynamic state |
| Wakako Okada | Westbrook · Information broker |
| Regina Jones | Watson · NCPD connections |
| Sebastian "Padre" Ibarra | Heywood · Valentinos ties |
| Dakota Smith | Badlands · Nomad specialist |
| Dino Dinovic | Santo Domingo |
| Mr. Hands | Pacifica / Dogtown |
| El Capitan | Santo Domingo · Vehicle specialist |

</details>

<details>
<summary><b>Afterlife & Legends</b> — 8 entries</summary>
<br>

| Character | Classification |
|:--|:--|
| Jackie Welles | MERC - PARTNER · Dynamic state after The Heist |
| T-Bug | MERC - NETRUNNER · Dynamic state |
| Johnny Silverhand | ENGRAM - TERRORIST · Rockerboy legend |
| Kerry Eurodyne | CIVILIAN - CELEBRITY · Samurai guitarist |
| Alt Cunningham | NETRUNNER - BEYOND BLACKWALL |
| Claire Russell | CIVILIAN - BARTENDER |
| Crispin Weyland | MERC - AFTERLIFE · "Squama" |
| Nix | NETRUNNER - AFTERLIFE |

</details>

<details>
<summary><b>Gang Leadership</b> — 14 entries</summary>
<br>

**Maelstrom:** Royce (Leader), Dum Dum (Lieutenant), Brick (Former leader, imprisoned)

**Tyger Claws:** Jotaro Shobo (Lieutenant), Hiromi Sato (Operations)

**Valentinos:** Gustavo Orta (Leadership), Jose Luis (Enforcer), Octavio Ruiz (Associate)

**Voodoo Boys:** Brigitte (Maman), Placide (Enforcer)

**Other:** Sasquatch / Animals, Nash / Wraiths, Anton Kolos / Scavengers

</details>

<details>
<summary><b>Mox, Clouds & Aldecaldos</b> — 7 entries</summary>
<br>

| Character | Classification |
|:--|:--|
| Judy Alvarez | TECHNICIAN - MOX · BD editor |
| Evelyn Parker | CIVILIAN - DOLL · Dynamic state |
| Maiko Maeda | CLOUDS - MANAGEMENT |
| Woodman | CLOUDS - SECURITY |
| Panam Palmer | ALDECALDO - DRIVER |
| Saul Bright | ALDECALDO - LEADER |
| Mitch Anderson | ALDECALDO - MECHANIC |

</details>

<details>
<summary><b>Ripperdocs, NCPD, NetWatch & Media</b> — 16 entries</summary>
<br>

**Ripperdocs:** Viktor Vektor, Fingers, Charles Bucks, Misty Olszewski

**NCPD & Politics:** River Ward, Jefferson Peralez, Lucius Rhyne, Barry

**NetWatch:** Bryce Mosley

**Media:** Lizzy Wizzy, Blue Moon, Ozob Bozo, Joshua Stephenson, Gillean Jordan, Max Jones, Cassius Ryder

**Vendors:** Wilson, Coach Fred

</details>

<details>
<summary><b>Phantom Liberty — Main Cast</b> — 5 entries</summary>
<br>

| Character | Classification |
|:--|:--|
| Solomon Reed | FIA - DEEP COVER · Legendary sleeper agent |
| Songbird (So Mi) | FIA - NETRUNNER · Blackwall-damaged, Relic bearer |
| Kurt Hansen | BARGHEST - LEADER · PMC warlord |
| Rosalind Myers | NUSA - PRESIDENT · Former Militech CEO |
| Alena "Alex" Xenakis | FIA - DEEP COVER OPERATIVE · The Moth bar cover |

</details>

<details>
<summary><b>Phantom Liberty — Dogtown NPCs</b> — 16 entries</summary>
<br>

**Longshore Stacks:** Leon Watson (Weapons), Costin Lahovary (Ripperdoc), Ronald "Typhoon" Malone (Junk), Susanna Mack (Ex-Trauma Team)

**EBM Petrochem Stadium:** Sophia Dupont (Weapons), David Walker (Clothing), Herold Lowe (Black Market Arms), Sammy Taylor (Netrunner Supplies), Saki Seo (Medical), Eron Acedo (Ripperdoc), Marcin Iwiński (Easter egg), Michał Kiciński (Easter egg)

**No Easy Way Out:** Angelica Whelan, Damir Kovac, Aaron Waines, William Correy

</details>

<details>
<summary><b>Phantom Liberty — Gigs</b> — 22 entries 🆕</summary>
<br>

| Gig | Characters |
|:--|:--|
| **Dogtown Saints** | Nika Yankovich, Odell Blanco, Anthony Anderson |
| **Prototype in the Scraper** | Hasan Demir |
| **Waiting for Dodger** | Bill Mitchel, Charles Wilson, Carl Robinson |
| **The Man Who Killed Jason Foreman** | Briana Dolson |
| **Spy in the Jungle** | Steven Santos, Ana Friedman, Boris Ribakov, Katya Karelina |
| **Talent Academy** | Baird, Tommie Walker, Fiona Vargas, David Walker |
| **Heaviest of Hearts** | Michael Maldonado, Georgina Zembinsky |
| **Roads to Redemption** | Nele Springer |
| **Treating Symptoms** | Alan Noël |
| **Other** | Kyle Araujo |

</details>

<details>
<summary><b>Other Notable Characters</b> — 5 entries</summary>
<br>

Delamain (AI taxi), Mama Welles (Jackie's mother), Nibbles (V's cat), Brendan (Sentient vending machine), Skippy (Sentient pistol)

</details>

<details>
<summary><b>Dynamic Quest States</b></summary>
<br>

These entries update based on game progression:

| Character | Trigger | What Changes |
|:--|:--|:--|
| Takemura | The Heist | Disavowed status, manhunt data |
| Jackie Welles | The Heist | Entry reflects fate |
| T-Bug | The Heist | Status updated |
| Evelyn Parker | Automatic Love | Reflects storyline events |
| Dexter DeShawn | The Heist | Dynamic state |
| Saburo Arasaka | The Heist | Death recorded |
| Lucius Rhyne | Dream On | Status changes |

</details>

<br>

## 🎲 Procedural Generation

Every non-unique NPC gets a full procedural profile built from their entity ID. Here's what powers it.

### Life Events

699 unique events build procedural backstories. Each carries gender-specific text, stat modifiers, and lifepath weighting.

| Category | ~Count | Examples |
|:--|:--|:--|
| Upbringing | 115 | Family structure, parental jobs, wealth level, orphan status |
| Housing | 97 | Megabuilding units, combat zone squats, nomad camps |
| Childhood | 178 | Education, street skills, gang youth, talents, trauma |
| Jobs | 103 | Criminal careers, merc work, tech, service, corpo |
| Adulthood | 213 | Relationships, violence, health crises, legal troubles |

### Criminal Records

Status (Clean → Most Wanted), specific charges with dates, convictions, warrant status, NCPD classification, and corporate security alerts.

### Financial Profile

NC ID number, credit score + tier, estimated wealth, debt (amount, holder, status), property/residence, employment, income, recent purchases, tax status, Trauma Team coverage, bank affiliation. Poor archetypes properly generate coherent low income instead of random values.

### Medical History

Blood type (RhD notation), chronic conditions, injury history, cyberware complications, substance issues, mental health flags, Trauma Team coverage tier on summary line.

### Cyberware Registry

Total implant count, category breakdown (Neural / Optical / Skeletal / Dermal / Circulatory), psychosis risk percentage, illegal modifications, registry compliance status.

### Psychological Profile

Temperament, behavioral flags, violence risk score (0–100), loyalty index, notable traits.

### Gang Profiles

11 complete gang profile systems (all 10 NC gangs + Barghest). Each with gang-specific ranks, specializations, territories, loyalty systems, 12+ unique backstories, and gang-appropriate statistics.

<br>

## 👻 Special Classifications

90 hidden NPC types that appear at configurable odds (default 1 in 750). Citizens look completely normal until you scan them.

<details>
<summary><b>Intelligence Assets</b> — 10 types</summary>
<br>

SLEEPER_AGENT · DOUBLE_AGENT · UNDERCOVER_COP · GANG_INFILTRATOR · FIXER_ASSET · DATA_COURIER · NCPD_INFORMANT · DRAGON_COURIER · DARK_NET_LEGEND · SMUGGLER_TUNNEL_OPERATOR

</details>

<details>
<summary><b>Corporate</b> — 9 types</summary>
<br>

CORPO_WHISTLEBLOWER · CORPO_DEFECTOR · CORPO_HEIR_HIDING · CORPO_ASSET_FROZEN · CORPO_INTERN_TRAPPED · CORPO_DEBT_SLAVE · INDENTURED_CORPO · BLACKMAIL_VICTIM · PROXY_VOTER

</details>

<details>
<summary><b>High-Value Targets</b> — 9 types</summary>
<br>

WITNESS_PROTECTION · WITNESS · HUNTED · MAXTAC_TARGET · ACTIVE_BOUNTY · REAPER_CONTRACT · DEBT_COLLECTION · ORGAN_MARKED · MISSING_PERSON

</details>

<details>
<summary><b>Medical & Biological</b> — 13 types</summary>
<br>

PRE_CYBERPSYCHO · CYBERPSYCHO_RECOVERED · CLONE_SUBJECT · EXPERIMENTAL_SUBJECT · ENGRAM_CANDIDATE · RELIC_COMPATIBLE · TRAUMA_TEAM_MARKED · IMMUNE_ANOMALY · GENETIC_CHIMERA · BIOPLAGUE_CARRIER · RADIATION_EXPOSURE · FLATLINE_REVIVED · CONTAMINATED_SCOP

</details>

<details>
<summary><b>Neural & Cyberware</b> — 9 types</summary>
<br>

NEURAL_DIVERGENT · UNREGISTERED_CHROME · INFECTED_FIRMWARE · IMPLANT_BOMB · DOLL_CHIP_SLEEPER · MEMORY_WIPED · SIGNAL_CARRIER · BLACK_ICE_SURVIVOR · BRAINDANCE_ADDICT

</details>

<details>
<summary><b>AI & Digital</b> — 10 types</summary>
<br>

AI_CONTACT · AI_PUPPET · BLACKWALL_TOUCHED · DELAMAIN_GLITCH · GHOST_IN_MACHINE · PERSONALITY_FRAGMENT · SOUL_SPLIT · SOULKILLER_SURVIVOR · ARASAKA_ENGRAM_ECHO · TECHNO_NECRO

</details>

<details>
<summary><b>Covert Programs</b> — 5 types</summary>
<br>

NIGHT_CORP_SUBJECT · PERALEZ_PROTOCOL · DREAMTECH_VICTIM · SYNTHETIC_SLEEPER · DEEP_FAKE_IDENTITY

</details>

<details>
<summary><b>Underground</b> — 6 types</summary>
<br>

HIDDEN_NETRUNNER · RETIRED_LEGEND · LEGACY_CHARACTER · ILLEGAL_BD_PRODUCER · WETWORK_RETIRED · MAXTAC_WASHOUT

</details>

<details>
<summary><b>Outcasts & Survivors</b> — 10 types</summary>
<br>

GHOST · MILITARY_AWOL · NOMAD_EXILE · CULT_ESCAPEE · COMBAT_ZONE_SURVIVOR · GHOST_TOWN_SURVIVOR · FERAL_ZONE_BORN · CHILD_SOLDIER_GROWN · CARGO_STOWAWAY · SCOP_FARMER_REFUGEE

</details>

<details>
<summary><b>Identity & Anomalous</b> — 9 types</summary>
<br>

IDENTITY_STOLEN · BURIED_PAST · ILLEGAL_PROCREATION · CHRONO_DISPLACED · ORBITAL_RETURNEE · POLITICAL_DISSIDENT · PRECOG_SUBJECT · TIME_ANOMALY · ARASAKA_BLOODLINE

</details>

<br>

## 🔗 Relationship Networks

Every NPC gets a procedurally generated social network.

| Type | Count | Details |
|:--|:--|:--|
| **Family** | 0–5 | Blood relatives share the NPC's actual displayed surname |
| **Associates** | 1–8 | Friends, coworkers, contacts with relationship context |
| **Enemies** | 0–3 | Named with reason, threat level, and affiliation |
| **Professional** | 0–3 | Fixers, ripperdocs, dealers |

Spouses share the family name 80% of the time. If you scan "Arina Lukina," her grandfather becomes "Hector Lukina" — not a random name.

<br>

## 🌐 Name Generation

260,000+ unique full names across 13 culturally appropriate ethnic groups, matched to NPC appearance. Zero array allocation at runtime — fully index-based.

| Ethnicity | File |
|:--|:--|
| American · African American · Hispanic | `AmericanNames.reds` · `AfricanAmericanNames.reds` · `HispanicNames.reds` |
| Japanese · Chinese · Korean | `JapaneseNames.reds` · `ChineseNames.reds` · `KoreanNames.reds` |
| Slavic · Indian · Middle Eastern | `SlavicNames.reds` · `IndianNames.reds` · `MiddleEasternNames.reds` |
| African · Haitian · SE Asian · European | `AfricanNames.reds` · `HaitianNames.reds` · `SoutheastAsianNames.reds` · `EuropeanNames.reds` |

Each ethnicity: 100 male + 100 female + 100 last = 20,000 combinations. Plus 120 street aliases for gang associates.

<br>

## 🧬 Narrative Coherence

Optional system that assigns each NPC a life theme and ensures every data point tells one consistent story.

| Theme | What It Means |
|:--|:--|
| **STABLE** | Good credit, clean record, healthy, steady job |
| **STRUGGLING** | Mounting debt, stress conditions, minor crimes |
| **CLIMBING** | Improving finances, career advancement, ambition |
| **FALLING** | Worsening health, legal troubles, spiraling debt |
| **CRIMINAL** | Extensive record, gang ties, illegal income, street injuries |
| **CORPORATE** | Clean records, corpo medical, good credit, corpo housing |

When enabled, flags propagate across systems — a SUBSTANCE_ABUSE flag generates drug charges in criminal, liver damage in medical, addiction markers in psych, and debt-from-habit in financial. Everything connects.

<br>

## ⚙️ Configuration

All settings: **Mod Settings Menu → Kiroshi Deep Scan**

### Display

| Setting | Range | Default |
|:--|:--|:--|
| Data Density | Low / Medium / High | High |
| Header Font Size | 14–28 | 20 |
| Text Font Size | 18–34 | 26 |
| Compact Mode | Off / Tight / Tighter / Tightest | Off |

### Generation

| Setting | Options | Default |
|:--|:--|:--|
| Narrative Coherence | On / Off | Off |
| Special NPC Rarity | Common (1:250) / Rare (1:750) / Mythic (1:2000) | Rare |

### Content

| Setting | Default | Description |
|:--|:--|:--|
| Diverse Relationships | Off | Same-sex partnerships, polyamory, chosen family |
| Body Modification Records | Off | Gender-affirming cyberware in medical records |
| Pronouns | Off | Pronoun display in scan data |

### Developer

| Setting | Default | Description |
|:--|:--|:--|
| Debug Mode | Off | Shows TweakDB ID and appearance name in scanner |

<br>

## 📦 Installation

### Requirements

| Dependency | Purpose |
|:--|:--|
| [redscript](https://github.com/jac3km4/redscript) | Script compilation |
| [Codeware](https://github.com/psiberx/cp2077-codeware) | UI framework |
| [Mod Settings Menu](https://github.com/jackhumbert/mod_settings) | Settings interface |

### Install

**Via Mod Manager:** Click "Mod Manager Download" on Nexus. Done.

**Manual:** Extract to game directory, merge when prompted:

```
Cyberpunk 2077/r6/scripts/backgroundScanner/
```

### Verify

Check for errors in:

```
Cyberpunk 2077/r6/logs/redscript_rCURRENT.log
```

<br>

## 🔧 Compatibility

### ❌ Incompatible

| Mod | Reason |
|:--|:--|
| [Lifepath Bonuses and Gang-Corp Traits](https://www.nexusmods.com/cyberpunk2077/mods/2217) | Scanner override conflicts |
| [Kiroshi Opticals - Crowd Scanner Expansion](https://www.nexusmods.com/cyberpunk2077/mods/13470) | Duplicate scanner hooks |
| [Kiroshi Opticals NetWatch Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/23664) | Same functionality |

**Remove any existing Kiroshi scanner mods before installing.**

### ✅ Compatible

Phantom Liberty (full support), all gameplay mods that don't modify the scanner, visual/graphics mods, UI mods that don't touch the scanner panel.

<br>

## ❓ FAQ

<details>
<summary><b>Nothing appears for certain NPCs (corporate employees, monks, vendors)</b></summary>
<br>
The mod generates data for NPCs flagged as crowd, gang, or NCPD. Some types aren't classified as "crowd" by the game engine. Named characters with unique entries always display regardless.
</details>

<details>
<summary><b>Why does an NPC show "HIGH PRIORITY TARGET" when the game shows nothing?</b></summary>
<br>
Deep Scan accesses databases beyond NCPD public records — NetWatch surveillance, corporate security, black market bounty boards, immigration systems. V's Kiroshi sees what NCPD either doesn't have, hasn't made public, or has been paid to suppress.
</details>

<details>
<summary><b>Family members share the NPC's last name — intentional?</b></summary>
<br>
Yes. Blood relatives extract the scanned NPC's actual displayed surname. Scan "Arina Lukina" and her grandfather will be "Hector Lukina." Spouses share the name 80% of the time.
</details>

<details>
<summary><b>How do I find Special Classification NPCs?</b></summary>
<br>
Keep scanning. Default is 1 in 750. Lower to 1 in 250 (Common) in settings for faster discovery. There are 90 types.
</details>

<details>
<summary><b>Why don't soldiers / MaxTac / Trauma Team show backstories?</b></summary>
<br>
Military combat NPCs display vanilla scanner info to prevent crashes from malformed NPC data during certain missions. Regular corporate employees show full procedural data.
</details>

<details>
<summary><b>Does this work with Phantom Liberty?</b></summary>
<br>
Full support. 43 unique hand-crafted Dogtown entries including Solomon Reed, Songbird, Kurt Hansen, President Myers, all stadium and Longshore Stacks vendors, No Easy Way Out characters, and 20 gig NPCs.
</details>

<details>
<summary><b>What does Narrative Coherence do?</b></summary>
<br>
Assigns a life theme (Stable, Struggling, Criminal, etc.) and ensures all data tells one story. A "Falling" NPC has declining credit, substance issues, recent termination, lapsed Trauma Team coverage, and growing debt — not random disconnected data.
</details>

<details>
<summary><b>What's the NC ID number?</b></summary>
<br>
A unique Night City citizen registration number (NC######) that appears in financial records. Homeless NPCs show UNREGISTERED or REVOKED. Nomads show CLAN ID ONLY.
</details>

<details>
<summary><b>What does TT: SILVER mean on the medical line?</b></summary>
<br>
That's the NPC's Trauma Team coverage tier. PLATINUM = full priority response. GOLD = fast response. SILVER = standard response. NONE = no coverage. Select "Trauma Team" as the database source for the full file.
</details>

<details>
<summary><b>Scanner panel too tall / overlaps with other mods</b></summary>
<br>
Go to Mod Settings → Kiroshi Deep Scan → Display → Compact Mode. Set to Tight, Tighter, or Tightest to reduce spacing between sections.
</details>

<details>
<summary><b>Nibbles has a database entry?</b></summary>
<br>
Yes. No more cats with drug trafficking charges.
</details>

<br>

## 🐛 Bug Reports

### Compilation Errors

Include your redscript log:
```
Cyberpunk 2077/r6/logs/redscript_rCURRENT.log
```

### Crash When Scanning Specific NPC

Look at the NPC in CET console and run:
```lua
print(Game.GetTargetingSystem():GetLookAtObject(GetPlayer(), false, false):GetRecord():GetID())
```

### NPC Not Detected Correctly

```lua
print(Game.GetTargetingSystem():GetLookAtObject(GetPlayer(), false, false):GetCurrentAppearanceName())
```

Or enable **Debug Mode** in Mod Settings → Developer, scan the NPC, and screenshot.

<br>

## 🏗️ Technical Architecture

<details>
<summary><b>Namespace & Determinism</b></summary>
<br>

All classes use the `Kdsp` prefix (e.g. `KdspRareNPCData`, `KdspNamePool`, `KdspGangManager`).

Every NPC generates identical data across sessions via entity ID hashing:

```swift
let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
let seed = RandRange(entityIDHash, 0, 2147483647);

// All systems use offsets from base seed
let criminalSeed = seed + 1000;
let medicalSeed = seed + 2000;
let financialSeed = seed + 3000;
```

Name generation is fully index-based (no array allocation at runtime) to prevent stack overflow.

</details>

<details>
<summary><b>NPC Detection</b></summary>
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
<summary><b>Project Structure</b></summary>
<br>

```
r6/scripts/backgroundScanner/
├── Core/
│   ├── BackstoryManager.reds              # Main generation orchestrator
│   ├── BackstoryUI.reds                   # UI data structures
│   ├── BackstoryUIExpanded.reds           # Extended UI structures
│   ├── NameGenerator.reds                 # Ethnicity routing + 120 aliases
│   ├── EthnicityDetector.reds             # Appearance-based ethnicity
│   ├── DatabaseSourceManager.reds         # Data source attribution
│   ├── ExpandedBackstoryManager.reds      # Extended generation logic
│   ├── CrowdArchetype.reds               # NPC archetype classification
│   ├── CrowdAssociation.reds             # Association types
│   ├── CrowdEntity.reds                  # Entity handling
│   ├── CrowdGender.reds                  # Gender detection
│   ├── CrowdTrait.reds                   # Individual traits
│   ├── CrowdTraits.reds                  # Trait collections
│   ├── CrowdWealth.reds                  # Wealth indicators
│   ├── ScannerBackstory.reds             # Scanner data structure
│   │
│   ├── Names/                            # 13 ethnicity files (300 names each)
│   ├── Barghest/                         # Barghest militia profiles
│   ├── Coherence/                        # Narrative coherence system
│   ├── Criminal/                         # Criminal record generation
│   ├── Cyberware/                        # Cyberware registry
│   ├── District/                         # District-based generation
│   ├── Financial/                        # Financial profiles + NC ID
│   ├── Gang/                             # 11 modular gang profiles
│   ├── LifePath/                         # 699 event definitions
│   ├── Medical/                          # Medical records + blood types
│   ├── NCPD/                             # NCPD personnel files
│   ├── Psych/                            # Psychological profiles
│   ├── Rare/                             # 90 special classifications
│   ├── Relationships/                    # KdspNamePool & social networks
│   └── Unique/                           # 204 character entries
│
├── Overrides/
│   ├── ScannerNPCBodyGameController.reds # Scanner UI injection
│   ├── NPCPuppet.reds                   # Scanner chunk compilation
│   └── UI_ScannerModulesDef.reds        # UI module definitions
│
├── Settings/
│   └── KiroshiSettings.reds             # Mod Settings integration
│
├── Text/                                 # ~3,300 lines of content
│   ├── TextAdulthood.reds · TextBackgrounds.reds · TextChildhood.reds
│   ├── TextCore.reds · TextCorpos.reds · TextHousing.reds
│   ├── TextJobs.reds · TextLifepaths.reds · TextUpbringing.reds
│
├── UI/
│   ├── NetWatchDBReport.reds            # Database report widget
│   ├── ScannerBackstorySystem.reds      # Main UI controller
│   └── ScannerLoadingText.reds          # Loading sequence
│
└── Util/
    ├── ArrayUtils.reds · Random.reds · String.reds
```

</details>

<br>

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for full version history.

<br>

## 🙏 Credits

| | |
|:--|:--|
| **Reki72** | Original [Kiroshi Crowd Scanner](https://www.nexusmods.com/cyberpunk2077/mods/1654) |
| **psiberx** | Codeware framework |
| **jackhumbert** | Mod Settings Menu |
| **NPC Nameplates** | TweakDB reference documentation |

<br>

## 📄 License

MIT — See [LICENSE](LICENSE) for details.

---

<p align="center">
  <b>KIROSHI DEEP SCAN PROTOCOL v1.8.0</b><br>
  <sub>Every NPC is a person.</sub>
</p>