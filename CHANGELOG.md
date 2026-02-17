# Changelog

All notable changes to **Kiroshi Deep Scan Protocol** are documented here.

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
