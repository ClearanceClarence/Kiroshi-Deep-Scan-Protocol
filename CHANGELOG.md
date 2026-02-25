# Changelog

All notable changes to **Kiroshi Deep Scan Protocol** are documented here.

---

## [2.1]

### Gender Deduplication

- Removed 1,619 duplicate _M() text functions across 7 text files
- Renamed 1,618 _F() functions to gender-neutral base names (LOST_JOB_F → LOST_JOB)
- Introduced pronoun placeholder system: %he%, %his%, %him%, %hers%, %himself%, %waiter% (+ capitalized variants)
- Added gender parameter to FillReplacements() for runtime pronoun resolution
- Added single-argument LPE() overload for gender-neutral text entries
- Fixed VTGRN_LAB using _F() for both male and female variants
- Fixed duplicate LIVED_6TH_ST entry in TextHousing
- Removed 1,930 lines of code (33,882 → 31,952 total .reds lines)

### Translation Support

- Added TRANSLATION_GUIDE.html for community translators
- File-by-file breakdown with real code examples from the codebase
- Documents all placeholder tokens and gender handling
- Instructions for adding custom language tokens (verb conjugation, grammatical case)
- Decision flowchart for identifying translatable vs code-only strings
- Difficulty ratings and common mistakes with consequences
- Translations published as separate standalone mods — no permission needed

---


## [2.0]

### Scanner Glitches

- Added scanner glitch system — rare chance that a scan is fully corrupted with garbled data, redacted records, or error messages
- 8 distinct corruption types: hardware malfunction, database corruption, NetWatch interference, ghost identity, cyberpsychosis warning, classified record, memory overflow, signal jamming
- Default: 1 in 200 chance per scan, configurable 1–500
- Added Scanner Glitches toggle under Generation settings (default: On)
- Added Scanner Glitch Chance slider under Generation settings
- Fixed glitch field variety — replaced additive seed offsets with prime multiplier offsets across 14 fields to prevent multiple fields displaying identical corruption text

### Trauma Team Profiles

- Trauma Team members no longer receive generic civilian backstories — dedicated military-grade content from 8 generators: background (12 variants), early life (10 variants), recent activity (12 variants), service record, cyberware, financial, medical, threat assessment
- Criminal Record replaced by TTI Service Record, Cyberware shows military-grade implant profile, Financial shows TTI employee data, Medical shows combat readiness, Psych/Threat shows tactical assessment, Vehicle/NET/Relationships withheld for operational security
- Removed `trauma_team` from the NPC skip list that was blocking all Trauma Team scans
- Added `trauma` to shouldGenerate fallback check so Trauma Team members pass through the gate

### Personal Quirks

- Added personal quirk system — 200 surveillance-state data entries across 7 categories appended to Psych Profile: Illicit Affairs (35), Phobias (30), Embarrassing Habits (30), Conspiracy Beliefs (25), Weird Legal Flags (25), Secret Double Lives (25), Mundane Absurd (30)
- 35% trigger chance at Data Density ≥ 2, 15% chance of a second quirk at Data Density ≥ 3

### Vehicle Registration

- Added Vehicle Registration section — procedurally generated vehicle ownership with make/model, registration status, and license plate
- Color-coded by status: red for stolen, yellow for suspended/expired, blue for clean

### NET Profile

- Added NET Profile section — network alias, browsing activity, darknet presence, flagged connections
- Highlighted in amber for flagged activity and red for active darknet presence
- Expanded NET alias pool from 10 inline entries to 300 aliases across 10 style categories: Hacker Handles (30), Gamer Tags (30), Edgerunner (30), Corpo Leak (30), Street Slang (30), Netrunner (30), Weeb (30), Paranoid (30), Pretentious (30), Number Crunch (30) — many include procedural number suffixes

### Section Toggles

- Added 12 section visibility toggles under new "Sections" settings category (all default: On): Background, Early Life, Recent Activity, Psych Profile, Criminal Record, Gang Affiliation, Cyberware, Financial, Medical, Relationships, Vehicle Registration, NET Profile
- Toggles gate visibility at the UI level — data still generates normally, toggling back on shows content immediately without rescanning

### Text Content Expansion

- Expanded TextAdulthood from 108 to 478 entries across 37 categories including Fixers/Merc Life, Corp-Specific Events, District-Specific Events, Substance Abuse, Combat Arena/Sports, Scams/Con Artistry, and more
- Expanded TextChildhood with gang childhood involvement, street survival, identity theft, protection rackets
- Expanded TextJobs with promoter, actor, stunt performer, influencer, and other Night City occupations
- Expanded TextHousing with Grand Imperial Mall, Coastview, West Wind Estate, Dogtown, and more
- Expanded TextUpbringing with new family structure and childhood background entries
- Expanded TextCorpos with Arasaka Bank, Secure Your Soul, Braindance Inc., Jinguji, MegaBuilding Corp, Night City Housing Authority, Steel Horizon Construction
- Expanded TextLifepaths with gang-adjacent upbringing entries for Animals, Voodoo Boys, Moxes, Scavengers
- Wired all new text entries into the lifepath event system with event wrappers, weighted pool entries, and lifepath-specific weighting
- Fixed 360 missing event wrappers and pool entries that left text content unreachable in-game
- Fixed 12 cross-module name collisions between text files
- Removed duplicate function definitions across all text modules
- Total lifepath events: 1,717 (up from 699)

### Unique NPCs (+9)

- Added Cynthia Najarro (mq040_wife — Pepe's wife, Raymond Chandler Evening quest)
- Added Shady Ripperdoc (mq040_ripperdoc — former licensed practitioner, license revoked)
- Added Pepe Najarro (elcoyote_barman — El Coyote Cojo bartender, Kirk Sawyer debt, Valentinos-adjacent)
- Added Miguel "Gizmo" Rodriguez (mq_hey_rey_06_outpost_miniboss — Valentinos leader, NCPD priority target)
- Added Nina Kraviz (wbr_hil_ripdoc_01 — Charter Hill ripperdoc, real-world DJ cameo as Bara Nova)
- Added Zen Master (mq014_master — classification UNKNOWN DATABASE INCONCLUSIVE, every field returns anomalous data)
- Added Leon Rinder entry with full cyberpsychosis/Regina Jones treatment path (Gig: The Man Who Killed Jason Foreman)
- Total unique NPC entries: 225

### Bug Fixes

- Fixed Arasaka corpo manager archetype detection — female corpo managers were matching "corpo" before "corpo_ma", classifying them as CORPO_DRONE instead of CORPO_MANAGER
- Added DetectCorpoAffiliation() — reads corporation name from NPC appearance strings and overrides financial employer and backstory text placeholders so Arasaka employees no longer show random corps
- Added corpo archetype protection floors for FALLING coherence themes — credit score, wealth, income, and employment no longer drop to poverty levels for employed corporate managers
- Reduced FALLING theme probability for corpo managers from 20% to 10%
- Extended corpo financial protections to YUPPIE archetype
- Added body-type specific medical conditions for obese NPCs (hypertension, diabetes, sleep apnea, cardiovascular strain, joint deterioration)
- Added body-type specific medical conditions for freak/heavily modified NPCs (implant rejection syndrome, immune compromise, body dysmorphia, nerve damage)
- Added medical condition deduplication
- Fixed sex worker / joytoy NPCs not generating scan data — expanded gate to check for "prostitute", "sexworker", and "joytoy"
- Expanded sex worker detection in BackstoryManager to include "prostitute" and "joytoy" so the coherence block triggers correctly
- Fixed service NPCs not generating scan data — added "ripperdoc", "service_", "barman", "bartender" appearance checks
- Fixed minor quest NPCs not generating scan data — added ".mq0" pattern matching
- Fixed side quest NPCs not generating scan data — added ".sq0" pattern matching
- Fixed Phantom Liberty story sequence NPCs not generating scan data — added ".sts_" pattern matching
- Fixed corpo civilian NPCs not generating scan data — added "corporat" appearance check and "corpoman"/"corpowoman" record ID checks
- Fixed vendor/shopkeeper NPCs not generating scan data — added "vendor" and "foodshop" checks
- Added robot/android/mech skip — prevents scan attempts on non-human entities
- Fixed compilation error: SetPsychProfile method does not exist on KdspUniqueNPCBackstory
- Fixed compilation error: checkRecordLower unresolved reference in corpo civilian gate

### Code Cleanup & Refactoring

- Stripped all historical version references from comments for clean v2.0 base
- Removed dead HOMELESS_MOD parameter from lifepath event pool functions
- Refactored BackstoryManager from 2,093 to 1,334 lines (36% reduction) by extracting 7 generator modules: ChildBackstoryGenerator, NCPDProfileGenerator, TraumaTeamGenerator, PersonalQuirkGenerator, VehicleRegistration, NetProfileGenerator, NetAliases
- Total mod settings: 24
- Total source files: 86

---


## [1.8.1]

### Cross-System Coherence Fixes

Three fixes addressing feedback where independently generated systems produced contradictory data on the same NPC.

- **Marriage ↔ Relationships:** If an NPC's significant events include "Is married" or "Got married", the Relationships section now forces status to "Married" and guarantees a spouse entry in the family list — no more married NPCs with "It's Complicated" and no spouse listed
- **Grudge Holder ↔ Enemies:** If the Psych Profile flags an NPC as a grudge-holder (hasVendetta), the Relationships section now guarantees at least one enemy — grudge holders with zero enemies was an obvious contradiction
- **Rejected Implants ↔ Medical & Cyberware:** If the Cyberware Registry shows rejected implants, the Medical section now adds an implant rejection condition (5 variants: rejection syndrome, tissue necrosis risk, synthetic organ rejection, inflammatory response, scheduled removal) and health rating downgrades to POOR minimum — cyberware status also elevates (rejection stress adds 15–30% to cyberpsychosis risk with rejection-specific status labels)
- **Sex Worker Appearance ↔ Criminal & Medical:** NPCs with "sexworker" in their appearance name now get 2 sex work specific arrests (solicitation, unlicensed joytoy work, vice code violations) replacing generic criminal records, with NCPD vice classification and 2 known clients in relationships — NPCs with "sexworker_poor" additionally receive 2 STIs on their medical record, health downgraded to POOR, and criminal status upgraded to REPEAT OFFENDER

### Narrative Coherence — Always On

- Removed Narrative Coherence toggle from Mod Settings — coherence is now always active
- There is no reason for NPC data to contradict itself; independent generation produced obvious inconsistencies (married with no spouse, grudge-holder with no enemies, rejected implants with good health)
- `CoherenceEnabled()` now always returns true, BackstoryManager always generates a coherence profile
- Setting removed from the Generation category in Mod Settings Menu

### New Setting — Compact Relationships

- Added **Compact Relationships** toggle under Display settings (default: On)
- **On (default):** Status, 2 family, 2 associates, enemies (reason only)
- **Off:** Full version with emergency contact, up to 4 family, 3 associates, professional contacts, enemies with threat level, romantic history, network size

### Technical

- Seed version incremented to 4 — all NPCs will regenerate fresh data on next game load
- All cross-checks run in BackstoryManager after individual systems generate, before UI strings are built — no changes to individual manager files
- Cross-check seeds use 9100–9540 offset range to avoid collisions with existing generation

---

## [1.8.0]

### Phantom Liberty Gig NPCs (+20 Unique Entries)

- Added Dogtown Saints: Nika Yankovich (Scavenger, Gaspar's twin sister), Odell Blanco (Haven Clinic pastor), Anthony Anderson (ripperdoc held hostage)
- Added Prototype in the Scraper: Hasan Demir (former Zetatech techie with prototype ocular implant)
- Added Waiting for Dodger: Bill Mitchel, Charles Wilson, Carl Robinson
- Added The Man Who Killed Jason Foreman: Briana Dolson
- Added Spy in the Jungle: Steven Santos, Ana Friedman, Boris Ribakov, Katya Karelina
- Added Talent Academy: Baird, Tommie Walker, Fiona Vargas, David Walker
- Added Heaviest of Hearts: Michael Maldonado, Georgina Zembinsky
- Added Roads to Redemption: Nele Springer
- Total unique NPC entries: 204

### New Systems

- Added Night City ID numbers (NC######) to financial records — homeless NPCs show UNREGISTERED or REVOKED, nomads show CLAN ID ONLY or NO NC REGISTRATION
- Added RhD blood type notation to medical records replacing basic blood types (e.g. A RhD+, O RhD−, AB RhD+)
- Added Trauma Team coverage tier indicator to medical summary line (TT: PLATINUM / GOLD / SILVER / NONE)
- Added Trauma Team as selectable database source with full coverage file: tier, response priority, payment status, cyberware compatibility, chronic conditions, emergency contact, response history — non-clients show CASH ON DELIVERY

### Display

- Added Compact Mode setting with four levels (Off / Tight / Tighter / Tightest) that progressively reduces spacing between scanner sections for compatibility with other scanner mods
- Added Debug Mode under Developer settings showing raw TweakDB ID and appearance name in scanner output for bug reporting
- Cleaned up all Mod Settings entries — renamed categories (Display Options → Display, Generation Mode → Generation, Content Options → Content), removed redundant "Enable" prefixes from toggle names, rewrote all descriptions for consistency

### Fixes

- Fixed financial profile generation for poor archetypes where homeless and junkie NPCs could generate corporate-level salaries — income and employment now properly override to match archetype
- Fixed Trauma Team coverage tiers to use only canonical Cyberpunk 2077 tiers (Silver / Gold / Platinum) instead of invented names
- Fixed Trauma Team database view display logic where selecting Trauma Team source on non-clients failed because detection only checked for exact "NONE" instead of handling EXPIRED and LAPSED variants
- Fixed compilation errors caused by duplicate function definitions when adding new gig NPC entries

---

## [1.7.2.1]

- Removed Phantom Liberty spoilers from President Myers entry

---

## [1.7.2]

### Phantom Liberty Expansion (+20 Unique NPCs)

- Added Longshore Stacks vendors: Leon Watson (weapons), Costin Lahovary (ripperdoc), Ronald "Typhoon" Malone (junk), Susanna Mack (meds/ex-Trauma Team)
- Added EBM Petrochem Stadium vendors: Sophia Dupont (weapons emporium), David Walker (clothing), Herold Lowe (black market arms), Sammy Taylor (netrunner supplies), Saki Seo (meds), Eron Acedo (ripperdoc)
- Added Stadium easter egg NPCs: Marcin Iwiński and Michał Kiciński (junk vendors / CD Projekt founders cameo)
- Added No Easy Way Out quest characters: Angelica Whelan (Animals pack alpha), Damir Kovac (ripperdoc), Aaron Waines (boxer), William Correy (opponent boxer)
- Added Treating Symptoms gig characters: Alan Noël (undercover NetWatch agent), Kyle Araujo (BARGHEST courier)

### Fixes

- Fixed Judy Alvarez showing blank entry due to overly-strict detection pattern failing on simple TweakDBID "Character.Judy"
- Fixed Alena "Alex" Xenakis entry — corrected from wrong "BARGHEST - INTELLIGENCE" to proper "FIA - DEEP COVER OPERATIVE" with full lore-accurate backstory
- Rewrote all Phantom Liberty detection patterns to use actual TweakDBIDs from in-game testing instead of name-based matching
- Most PL vendor TweakDBIDs use role-based IDs (e.g. "cz_stadium_gunsmith_01") rather than character names, requiring exact ID matching

---

## [1.7.1]

- Renamed all 104 classes, structs, and enums with `Kdsp` prefix to prevent naming conflicts with other mods

---

## [1.7.0]

### Gang System Overhaul

- Reorganized gang profile system into 11 modular files for easier maintenance and expansion
- Added dedicated profile generators for each gang: Tyger Claws, Maelstrom, Valentinos, 6th Street, Animals, Voodoo Boys, Moxes, Scavengers, Wraiths, Aldecaldos, and Barghest
- Created shared GangProfileUtils.reds with utility functions and GangProfileData class
- Removed redundant rank display from gang profiles since the game's scanner already shows NPC rank
- Each gang now generates unique backstories, territories, and gang-appropriate statistics
- Doubled gang profile content across all 10 gangs: backstories expanded from 6 to 12, recent activities from 5 to 10, specializations from 10 to 15, and distinguishing marks from 3-4 to 6-7 per gang

### Rare NPC Expansion

- Tripled rare NPC classifications from 30 to 90, adding 60 new hidden status flags including Braindance Addict, Night Corp Subject, Soulkiller Survivor, Blackwall Touched, Peralez Protocol, Delamain Glitch, Reaper Contract, Cyberpsycho Recovered, MaxTac Washout, Orbital Returnee, and 50 more

### Unique NPCs

- Expanded President Rosalind Myers unique entry with detailed backstory covering her Militech CEO tenure, Unification War, and Space Force One crash
- Expanded Johnny Silverhand entry with military background, Alt Cunningham history, and Arasaka Tower assault details

### Bug Fixes

- Fixed Myers detection pattern to match Character.myers TweakDBID
- Fixed Barghest soldier detection to recognize kurtz_army appearance patterns used by Hansen's forces

---

## [1.6.1]

### Name Generation Expansion

- Expanded name generation system from 1,172 to 3,900 unique name entries
- Restructured names into 13 modular ethnicity files for easier maintenance
- 100 male first names per ethnicity (up from 25-35)
- 100 female first names per ethnicity (up from 25-35)
- 100 last names per ethnicity (up from 20-30)
- 260K+ possible full name combinations (up from 18.5K)
- 120 street aliases for gang associates

### Bug Fixes

- Fixed River Ward detection incorrectly triggering on "driver" NPCs (El Capitan's Driver)
- Fixed Saul Bright detection incorrectly triggering on "assault" NPCs (MaxTac Operator - Assault)
- Added guardrails to prevent future substring collision issues in unique NPC matching
- Added child NPC detection to prevent inappropriate content generation for minors
- Fixed missing GetStreetAlias function after name system refactor

---

## [1.6.0]

### Unique NPC Entries (+32)

- Added 32 new hand-crafted unique NPC backstories bringing total from 48 to 80+
- Added Phantom Liberty characters: Solomon Reed (FIA deep cover), Songbird (Blackwall-damaged netrunner), Kurt Hansen (Barghest PMC leader), President Rosalind Myers, Alex (Barghest intelligence)
- Added gang leaders: Jotaro Shobo and Hiromi Sato (Tyger Claws), Gustavo Orta and Jose Luis (Valentinos), Sasquatch (Animals), Nash (Wraiths), Anton Kolos (Scavengers)
- Added Brick entry under Maelstrom as former leader overthrown by Royce
- Added celebrities: Lizzy Wizzy (full chrome musician), Blue Moon (Us Cracks), Ozob Bozo (grenade-nose fighter), Joshua Stephenson (death row/crucifixion BD)
- Added media personalities: Gillean Jordan (N54 News), Max Jones (independent), Cassius Ryder (investigative journalist)
- Added vendors and ripperdocs: Wilson (2nd Amendment), Charles Bucks (Kabuki), Coach Fred (boxing trainer)
- Added Afterlife characters: Nix (resident netrunner), Crispin Weyland (Squama)
- Added unique characters: Brendan (sentient vending machine), Skippy (sentient smart pistol), Barry (NCPD officer)
- Added corporate security entries: Graham Mayfield (Arasaka), Militech Commander, Hanako bodyguards, generic Arasaka security

### Life Events Expansion

- Expanded total unique life events from 617 to 698 (81 new events added)
- Added 31 new childhood events covering skills, backgrounds, and formative experiences
- Added 8 new housing location events including amusement park, catacomb, chem zone, houseboat, radiation zone, stadium, wind farm
- Added 40 new adulthood events covering career changes, trauma, relationships, health, fortune, and hardship

### Special Classifications Expansion

- Expanded special NPC classifications from 10 to 30 unique types
- Added intelligence asset classifications: FIA informants, corporate moles, sleeper agents
- Added criminal elite classifications: fixer assets, syndicate accountants, black market specialists, data brokers
- Added high-value target classifications: witness protection, corporate defectors, multi-faction bounties
- Added medical flag classifications: dormant cyberpsychos, experimental subjects, clone subjects
- Added legend classifications: retired mercs, former gang leaders, underground celebrities

### Bug Fixes

- Fixed corporate employee scanning — Arasaka, Militech, and Kang Tao employees now properly generate backstories
- Changed military skip filter to only block specific combat units (arasaka_soldier, arasaka_ninja, militech_soldier) instead of all corporate NPCs
- Fixed family surname matching — ExtractLastName now uses GetTweakDBFullDisplayName to match scanner display name
- Added generic name filtering to prevent surname extraction from placeholder names (Citizen, Enemy, etc.)
- Fixed Barghest NPC detection — Kurt Hansen entry now requires both "kurt" AND "hansen" in ID instead of either
- Fixed Solomon Reed detection to prevent false matches on generic "reed" NPCs
- Fixed President Myers detection to require "president" qualifier
- Fixed Alex detection to exclude "alexander" variants
- Fixed Ozob function call to use proper class prefix (UniqueNPCEntries.OzobBozo)
- Removed 134 duplicate function definitions across Text files (TextAdulthood, TextHousing, TextJobs, TextUpbringing, TextChildhood)
- Integrated all 698 backstory events into weighted generation pools — no orphaned events
- All event wrapper functions now properly connected to UpbringingEvents, HomeEvents, ChildhoodEvents, JobEvents, and AdultEvents pools

---

## [1.5.3]

### Relationship System Restoration

- Rewrote NameGenerator to use index-based selection instead of ArrayPush arrays, eliminating all stack allocation from name generation
- Added NamePool class that pre-builds name arrays on the heap once per scan, shared across all relationship generation functions
- Restored full relationship generation: 3-8 associates for gang members, 1-4 for civilians (up from 1-2 max in v1.5.2)
- Restored full family tree generation: 0-5 family members including parents, siblings, grandparents, children, spouse (up from 0-1 max)
- Restored enemy generation: 1-3 enemies with threat levels for gangers/lowlifes (up from 1 max)
- Added professional contacts generation: 1-3 contacts for corpo and ganger archetypes (Fixer, Arms Dealer, Ripperdoc, etc.)

### Name Improvements

- Family members now share the scanned NPC's actual last name instead of a random generated surname
- Blood relatives (parents, siblings, grandparents, children) always share the family surname
- Spouses now share family name 80% of the time (up from 50%)
- Total name pool: 1,172 unique name parts generating 18,550+ possible full name combinations across 13 ethnicities

### Display

- Added romantic history display at high data density
- Added enemy threat level display alongside reason for enmity
- Added professional contacts display at high data density
- Gang members now generate relationship data (removed restriction that skipped them)

---

## [1.5.2]

### Critical Fix

- Fixed stack overflow crash affecting all NPCs caused by RelationshipsManager.Generate()
- Identified root cause: deep call chains through NameGenerator creating excessive stack usage from large local arrays
- Rewrote relationships generation to use simplified inline name pools instead of ethnicity-matched NameGenerator calls
- Reduced associate generation from 3-8 to 1-2 per NPC to minimize function call depth
- Reduced family member generation from full tree to 0-1 per NPC
- Retained all relationship data types: associates, family, enemies, emergency contacts, dependents, relationship status
- Retained alias generation, relationship types, and status tracking
- Combat NPC appearance safeguard kept as additional protection layer

---

## [1.5.1.1]

- Same as 1.5.1
- Rebuilt from clean v1.5 base with only the combat NPC safeguard added

---

## [1.5.1]

### Critical Fix — Stack Overflow Crashes

- Fixed stack overflow crash when scanning Militech ranger NPCs (ranger2_ranged2_ajax, ranger2_ranged2_omaha variants)
- Fixed stack overflow crash when scanning Arasaka corporate security and combat NPCs
- Fixed stack overflow crash when scanning Kang Tao corporate combat NPCs
- Fixed stack overflow crash when scanning Trauma Team emergency response units
- Fixed stack overflow crash when scanning NetWatch operatives
- Fixed stack overflow crash when scanning MaxTac cyberpsycho response units
- Identified root cause: RelationshipsManager.Generate() triggers infinite recursion on certain NPC data configurations
- Added appearance-based safeguard checking for militech, arasaka, kang_tao, trauma_team, ranger, netwatch, max_tac, maxtac patterns
- Corporate and military combat NPCs now display vanilla scanner information instead of procedural backstories
- Safeguard executes after unique NPC check — hand-crafted entries for Takemura, Meredith Stout, Oda, etc. still display correctly
- Bug was pre-existing in v1.4.2 but only manifested when scanning specific combat NPC variants

---

## [1.5.0]

### Unique NPC System

- Named story NPCs (Johnny, Takemura, Panam, Judy, fixers, quest characters, etc.) no longer show generated backstories that conflict with their canonical lore
- 48 unique characters now have hand-crafted lore-accurate database entries pulled from Night City's classified systems
- Character data dynamically updates based on story progression (Jackie, T-Bug, Saburo, Dex, Evelyn, Rhyne show DECEASED status after relevant quests)

### New Unique Entries

- Added Mickey (El Capitan's driver/associate) as unique NPC with proper entry
- Added Emmerick Bronson (Afterlife bouncer) as unique NPC
- Added Crispin "Squama" Weyland (Rogue's bodyguard) as unique NPC
- Expanded entries for El Capitan, Meredith Stout, Claire Russell, and Rogue Amendiares with full lore details
- Nibbles now has a unique entry including a classified incident involving NCPD and MaxTac deployment due to database corruption

### Bug Fixes

- Fixed crash when scanning Arasaka snipers near Japantown/Northside highway
- Fixed El Capitan's driver incorrectly displaying El Capitan's profile data
- Improved pattern matching to prevent generic NPCs from incorrectly matching unique character entries
- Added display name fallback detection for unique NPCs whose record IDs don't contain their name

---

## [1.4.2]

- Named story NPCs no longer show generated backstories that conflict with their canonical lore
- Backstory generation now properly limited to crowd NPCs, generic gang members, and NCPD officers using the game's native NPC classification
- Added seed version system — mod updates can now force all NPCs to regenerate fresh backstories on next game load
- Scanner UI now properly clears when scanning excluded NPCs instead of showing stale data from previous scans
- Improved code efficiency by replacing manual name-matching filter with native game checks (IsCrowd, IsCharacterGanger, IsCharacterPolice)

---

## [1.4.0]

### Settings

- Added Data Density setting — controls information volume per scan (High/Medium/Low)
- Added Header Font Size setting — adjustable range 14-28, default 20
- Added Text Font Size setting — adjustable range 18-34, default 26
- Added Narrative Coherence setting — links NPC data into believable interconnected stories
- Added Special NPC Rarity setting — Common (1:250), Rare (1:750), Mythic (1:2000)

### Loading Sequence

- Added immersive loading sequence with 100+ unique database connection messages
- Added variable loading line count based on Data Density setting
- Added error/warning messages with recovery during loading sequence

### Narrative Coherence System

- Added Life Theme system for coherent NPCs (Stable, Struggling, Climbing, Falling, Criminal, Corporate)
- Added shared flag propagation — substance issues, violent past, trauma, and debt affect multiple databases
- Added coherent criminal records — charges match life circumstances and flagged behaviors
- Added coherent medical history — conditions reflect substance abuse, violence, and lifestyle
- Added coherent financial profiles — debt reasons and credit scores match life theme
- Added coherent psych profiles — addictions, trauma, and personality tied to life circumstances
- Added coherent cyberware — quality and legality matches economic situation and life theme
- Added cyberpsychosis risk scaling with substance abuse

---

## [1.3.1]

- NCPD officers now display cyberware registry data
- NCPD officers display pronouns when setting is enabled
- Officers no longer show irrelevant civilian data (criminal records, financial status, medical history, relationships, psych profile)

---

## [1.3.0]

### NCPD Improvements

- Police officers now use their actual in-game names when available
- Improved detection of generic names (Beat Cop, Patrol Officer, Detective, Sergeant, etc.) and generates proper names

### Mod Settings Menu

- Added Diverse Relationships option — same-sex partnerships, polyamory, chosen family
- Added Body Modification Records option — gender-affirming cyberware in medical records
- Added Display Pronouns option — shows pronouns including they/them and neopronouns

---

## [1.2.0]

### Smart Gang Filtering

- Gang members show only relevant data: Background, Early Life, Recent Activity, Psych Profile, Criminal Record, Gang Affiliation
- Financial, Medical, Cyberware, and Relationships sections hidden for gang-affiliated NPCs
- Gang encounters display focused information without irrelevant civilian clutter
- Improved section spacing and visual hierarchy for different NPC types

---

## [1.1.0]

### Relationships System

- Added Relationships Database — status, dependents, emergency contact, known associates, known enemies, family members, social network size
- Gender-accurate names — female NPCs get female names, male NPCs get male names
- Blood relatives (siblings, parents, children) now share last names
- Expanded name pool — 150+ multicultural names (American, Hispanic, Japanese, Chinese, Korean, Slavic)
- Street aliases — shady associates use handles like "Razor", "Ghost", "Chrome", "Venom"
- Relationships section with pink/red color coding, enemies highlighted in red

---

## [1.0.0]

- Initial release