# Kiroshi Deep Scan Protocol — Translation Guide v2.1

> **You are creating a standalone version of the mod for your language.**
> You will publish it as a separate mod on Nexus Mods. It does not need to support English.


## The One Rule

Every quoted string `"like this"` falls into one of two categories:

**TRANSLATE** — Text the player sees in the scanner UI.
```
"Lost %his% job. "                              ← Player reads this
"Alcohol dependency"                             ← Player reads this
"FLAG: Two active relationships"                 ← Player reads this
```

**DO NOT TRANSLATE** — Internal code identifiers that the game logic compares against.
```
"CORPO_MANAGER"                                  ← Code checks this value
"FALLING"                                        ← Code checks this value
"tyger"                                          ← Code checks game data
```

### How to tell them apart

Ask: **"Does this string appear inside `Equals()`, `StrContains()`, or get compared with `==`?"**

- **YES → DO NOT TRANSLATE.** It's a code identifier.
- **NO, it's inside `return "..."` or `ArrayPush(array, "...")` → Probably TRANSLATE.** 

When in doubt, **look at the surrounding code.** If the string is being *returned to display*, translate it. If the string is being *tested against*, don't.


---


## File Reference

### ✅ TRANSLATE — Text Files (Text/)

These are the easiest files. Every line is a display string. Translate all of them.

**REAL EXAMPLE — TextAdulthood.reds:**
```swift
// ✅ TRANSLATE the text inside quotes
// ❌ DO NOT change the function name, class name, or trailing space

public static func LOST_GAMBLE() -> String { return "Lost €$%eddies% Eurodollars gambling. "; }
//                 ^^^^^^^^^^^                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                 NEVER CHANGE                      TRANSLATE THIS (keep %eddies% token)

public static func LOST_JOB() -> String { return "Lost %his% job. "; }
//                                                ^^^^^^^^^^^^^^^^
//                                                TRANSLATE (keep %his% token)

public static func HEIST() -> String { return "Participated in a high-profile heist. "; }
//                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                                            TRANSLATE
```

**Russian example:**
```swift
public static func LOST_GAMBLE() -> String { return "Проиграл €$%eddies% евродолларов. "; }
public static func LOST_JOB() -> String { return "Потеря%verb_l% работу. "; }
public static func HEIST() -> String { return "Участвова%verb_l% в ограблении. "; }
```

**Files:**

| File | Entries | Content |
|---|---|---|
| TextAdulthood.reds | 478 | Adult life events |
| TextChildhood.reds | 280 | Childhood events |
| TextUpbringing.reds | 235 | Family and upbringing |
| TextJobs.reds | 207 | Employment history |
| TextBackgrounds.reds | 166 | Personality traits, professions |
| TextHousing.reds | 158 | Living situations |
| TextLifepaths.reds | 94 | Lifepath-specific backstories |
| TextCore.reds | 4 | Core text templates |
| TextCorpos.reds | 99 | Corporation names — keep as-is unless your game localizes them |

> **IMPORTANT:** Every entry ends with `. "` (period, space, closing quote). Keep this pattern. Entries get concatenated together at runtime.


---


### ✅ TRANSLATE — Generator Files (Core/)

These files mix code logic with display text. This is where most mistakes happen. **Go line by line.**

**REAL EXAMPLE — PsychProfileManager.reds (DANGEROUS FILE):**
```swift
// ❌ DO NOT TRANSLATE — this is a comparison, the code checks this value
if Equals(coherence.lifeTheme, "CRIMINAL") { base += RandRange(seed + 6, 10, 20); }
//                               ^^^^^^^^
//                               CODE IDENTIFIER — NEVER TOUCH

// ✅ TRANSLATE — this is a return value the player sees
if roll <= 50 { return "HIGH"; }
//                      ^^^^
//                      TRANSLATE (player sees this label)

// ✅ TRANSLATE — player reads this in the scanner
return "Alcohol dependency";
//      ^^^^^^^^^^^^^^^^^^^
//      TRANSLATE

// ✅ TRANSLATE — player reads this
return "Stimulant addiction (synth-coke)";
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//      TRANSLATE (keep "synth-coke" if your game keeps it in English)
```

**REAL EXAMPLE — CriminalRecordManager.reds (DANGEROUS FILE):**
```swift
// ❌ DO NOT TRANSLATE — code comparisons
if Equals(archetype, "CORPO_MANAGER") { chance = 5; }
if Equals(archetype, "GANGER") { chance = 95; }
if Equals(coherence.lifeTheme, "FALLING") { chance += 15; }
//                               ^^^^^^^
//                               ALL CODE IDENTIFIERS — NEVER TOUCH

// ✅ TRANSLATE — player sees these labels
if roll <= 40 { return "VIOLENT OFFENDER"; }
if roll <= 60 { return "FELONY RECORD"; }
if roll <= 75 { return "REPEAT OFFENDER"; }
//                      ^^^^^^^^^^^^^^^^
//                      TRANSLATE THESE
```

**REAL EXAMPLE — FinancialProfileManager.reds (DANGEROUS FILE):**
```swift
// ❌ DO NOT TRANSLATE — code identifier used in logic
if Equals(coherence.debtReason, "medical bills") { base = RandRange(seed, 10000, 150000); }
if Equals(coherence.debtReason, "cyberware loans") { base = RandRange(seed, 5000, 80000); }
//                                ^^^^^^^^^^^^^^
//                                CODE IDENTIFIERS — set in CoherenceManager, matched here

// ✅ TRANSLATE — player sees these
if score >= 800 { return "EXCEPTIONAL"; }
if score >= 750 { return "EXCELLENT"; }
return "Corporate employee";
//      ^^^^^^^^^^^^^^^^^^^^
//      TRANSLATE
```

**REAL EXAMPLE — GangManager.reds (VERY DANGEROUS FILE):**
```swift
// ❌ DO NOT TRANSLATE — these match game appearance data
if StrContains(appearanceName, "tyger") { return "TYGER_CLAWS"; }
if StrContains(appearanceName, "maelstrom") { return "MAELSTROM"; }
//                              ^^^^^^^^^^            ^^^^^^^^^^
//                              GAME DATA             CODE IDENTIFIER
//                              NEVER TOUCH           NEVER TOUCH

// ✅ TRANSLATE — this converts the code identifier to a display name
if Equals(affiliation, "TYGER_CLAWS") { return "Tyger Claws"; }
//                      ^^^^^^^^^^^^            ^^^^^^^^^^^^
//                      CODE ID (NO)            DISPLAY NAME (YES — translate if your game does)
```

**REAL EXAMPLE — BackstoryManager.reds:**
```swift
// ✅ TRANSLATE — player reads these medical conditions
ArrayPush(medical.chronicConditions, "Implant rejection syndrome - active immunosuppressant therapy");
ArrayPush(medical.chronicConditions, "Chronic implant rejection - tissue necrosis risk");
//                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                                    TRANSLATE

// ❌ DO NOT TRANSLATE — code comparisons
if Equals(medical.healthRating, "EXCELLENT") || Equals(medical.healthRating, "GOOD") {
//                               ^^^^^^^^^                                    ^^^^
//                               CODE IDENTIFIERS — NEVER TOUCH
```

> **⚠️ KEY INSIGHT:** The same word can appear as both a code identifier AND a display value. `"EXCELLENT"` might be compared in one place (`Equals(x, "EXCELLENT")`) and returned in another (`return "EXCELLENT"`). Only translate the `return` version if both exist. When in doubt: if changing this string would break a comparison somewhere else, don't change it. Search the file for the string first.


**REAL EXAMPLE — DatabaseSourceManager.reds:**
```swift
// ✅ TRANSLATE — player reads these threat assessments
if score >= 70 { return "HIGH THREAT"; }
if score >= 40 { return "MODERATE THREAT"; }
return "MINIMAL";

// ✅ TRANSLATE — player reads these recommendations
return "MONITOR CLOSELY. Consider preemptive neutralization if threat escalates.";
return "Low priority. Maintain passive surveillance. No resources allocated.";
```

**REAL EXAMPLE — ScannerGlitch.reds:**
```swift
// ⚠️ JUDGMENT CALL — these are deliberate corruption/glitch text
if r == 0 { return "NC??????"; }            // Keep as-is (glitch characters)
if r == 2 { return "ERR_NULL_REF"; }        // Keep as-is (tech error code)
if r == 6 { return "RECORD_EXPUNGED"; }     // Translate if you want, keep English for flavor
if r == 7 { return "██████████"; }          // Keep as-is (redacted blocks)
```


**Full list of generator files to translate:**

| File | Content | Difficulty |
|---|---|---|
| Psych/PsychProfileManager.reds | Psych profiles, addictions | ⚠️ Hard — many code identifiers mixed in |
| Financial/FinancialProfileManager.reds | Credit, income, employment | ⚠️ Hard — same issue |
| Criminal/CriminalRecordManager.reds | Criminal records, charges | ⚠️ Hard — same issue |
| Medical/MedicalHistoryManager.reds | Medical conditions | Medium |
| Cyberware/CyberwareRegistryManager.reds | Cyberware names | Medium |
| Relationships/RelationshipsManager.reds | Relationship text | Medium |
| Quirks/PersonalQuirkGenerator.reds | Personal quirks | Easy — all display text |
| NET/NetAliases.reds | NET handles | Optional — internet names work in any language |
| NET/NetProfileGenerator.reds | NET activity text | Easy |
| DatabaseSourceManager.reds | Threat labels, recommendations | Medium |
| Gang/GangManager.reds | Gang display names | ⚠️ Hard — identifiers + display names |
| Gang/*Profile.reds (11 files) | Gang backstories | Medium |
| Barghest/BarghestProfileManager.reds | Barghest profiles | Medium |
| Child/ChildBackstoryGenerator.reds | Child NPC text | Easy |
| District/CrowdDistrictManager.reds | District descriptions | Medium |
| BackstoryManager.reds | Core backstory text | ⚠️ Hard — lots of mixed code |
| ScannerGlitch.reds | Glitch/corruption | Optional — flavor text |
| Rare/RareNPCManager.reds | Rare NPC encounters | Easy — mostly display text |
| NCPD/NCPDProfileGenerator.reds | NCPD reports | Medium |
| NCPD/NCPDNameGenerator.reds | Badge names | Easy |
| Vehicle/VehicleRegistration.reds | Vehicle data | Medium |


---


### ✅ TRANSLATE — Unique NPCs (Core/Unique/UniqueNPCEntries.reds)

225 hand-written NPCs. This is the largest single file (~1,900 strings). Translate the narrative text only.

**REAL EXAMPLE — Takemura:**
```swift
// ❌ DO NOT TRANSLATE — NPC detection logic
if StrContains(id, "takemura") { return KdspUniqueNPCEntries.Takemura(); }
//                  ^^^^^^^^^
//                  GAME DATA — NEVER TOUCH

// ❌ DO NOT TRANSLATE — function/method names
return KdspUniqueNPCBackstory.Create("takemura").SetClassification("ARASAKA - DISAVOWED")
//                                    ^^^^^^^^^
//                                    CODE ID — NEVER TOUCH

// ✅ TRANSLATE — all the .Set___() string arguments are display text
    .SetBackground("Born Chiba-11, Tokyo. Father worked in kitchen. Selected by Arasaka military as child.")
    .SetEarlyLife("Rose to special forces. Graduated top of Arasaka Academy.")
    .SetSignificantEvents("DISAVOWED following Saburo's death at Konpeki Plaza.")
    .SetAffiliation("Arasaka (Former) | Status: KILL ON SIGHT")
    .SetCriminalRecord("Arasaka Corporate: MOST WANTED")
    .SetCyberwareStatus("Cyberoptics (Custom) | Subdermal Armor | Kerenzikov")
    .SetFinancialStatus("Accounts FROZEN | Operating with minimal resources")
    .SetMedicalStatus("No corporate support | Field status: ACTIVE")
    .SetThreatAssessment("EXTREME (95/100) | TIER-1 SOLO")
    .SetRelationships("Saburo (Deceased) | Hanako (Contact) | Oda (Estranged)")
    .SetNotes("High-priority target. Possesses classified intel. Will not surrender.")
//             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//             ALL OF THESE → TRANSLATE
```

> **TIP:** Character names (Takemura, Saburo, Hanako, Oda) are proper nouns — keep them as-is. Translate everything around them.


---


### ✅ TRANSLATE — Settings (Settings/KiroshiSettings.reds)

Only translate `displayName` and `description` values. There are ~24 settings.

**REAL EXAMPLE:**
```swift
// ❌ DO NOT TRANSLATE — these are system identifiers
@runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
//                                   ^^^^^^^^^^^^^^^^^^
//                                   MOD NAME — KEEP (or translate if you rename the mod)

@runtimeProperty("ModSettings.category", "Display")
//                                        ^^^^^^^^^
//                                        CATEGORY ID — DO NOT TRANSLATE

// ✅ TRANSLATE — player sees these in the settings menu
@runtimeProperty("ModSettings.displayName", "Data Density")
//                                           ^^^^^^^^^^^^
//                                           TRANSLATE

@runtimeProperty("ModSettings.description", "Amount of information shown per scan.")
//                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                                           TRANSLATE
```

> **⚠️ WARNING:** `"ModSettings.category"` values like `"Display"`, `"Generation"`, `"Content"` are category identifiers. DO NOT translate them — the Mod Settings Menu uses them as keys. If you translate `"Display"` to `"Отображение"`, the settings will break.


---


### ✅ TRANSLATE — UI Files (UI/)

**ScannerLoadingText.reds** — Loading animation text:
```swift
// ✅ TRANSLATE — player reads these during scan loading
ArrayPush(lines, "Initializing Kiroshi Deep Scan Protocol...");
ArrayPush(lines, "Accessing NCPD criminal database...");
ArrayPush(lines, "Querying Night City Medical Registry...");
```

**ScannerBackstorySystem.reds** — Section headers:
```swift
// ✅ TRANSLATE — these are the section header labels
header.SetText("Deep Scan Protocol");
footerText.SetText("Kiroshi Optics // Deep Scan Protocol v2.0");
```

**NetWatchDBReport.reds** — Alert/section labels:
```swift
// ✅ TRANSLATE — section labels player sees
this.CreateAlertSection(root, "CLASSIFIED INDIVIDUAL", ...)
this.CreateAlertSection(root, "NCPD PERSONNEL FILE", ...)
this.CreateDataSection(root, "Background", ...)
this.CreateDataSection(root, "Criminal Record", ...)
this.CreateDataSection(root, "Psych Profile", ...)
this.CreateDataSection(root, "Gang Affiliation", ...)
//                            ^^^^^^^^^^^^^^^^^
//                            TRANSLATE ALL SECTION NAMES

// ❌ DO NOT TRANSLATE — widget identifier names
n"background_value"
n"criminal_value"
n"KdspNetWatchDBReport"
//  ^^^^^^^^^^^^^^^^^^^^
//  INTERNAL NAMES — NEVER TOUCH
```

> **Rule for `n"..."` strings:** The `n` prefix means it's a CName (code name). **NEVER translate these.**


---


### ❌ DO NOT TRANSLATE

| Files | Why |
|---|---|
| `Core/Names/*.reds` (13 files) | Proper names — universal |
| `Core/Coherence/CoherenceManager.reds` | Pure code identifiers (`"FALLING"`, `"corpo"`, `"gambling"`, etc.). These are internal values that other files compare against. Translating them breaks everything. |
| `Core/LifePath/LifePathEvent.reds` | Code structure only |
| `Core/LifePath/LifePathEvents.reds` | Function calls only — no display text |
| `Core/LifePath/LifePath.reds` | Code logic |
| `Core/LifePath/LifePathPossibilities.reds` | Weights and archetype logic |
| `Core/CrowdArchetype.reds` | Code constants |
| `Core/CrowdAssociation.reds` | Code constants |
| `Core/CrowdEntity.reds` | Data structure |
| `Core/CrowdGender.reds` | Gender detection |
| `Core/CrowdTrait.reds` | Data structure |
| `Core/CrowdTraits.reds` | Code constants |
| `Core/CrowdWealth.reds` | Code constants |
| `Core/EthnicityDetector.reds` | Appearance string matching |
| `Core/NameGenerator.reds` | Name assembly logic |
| `Core/ExpandedBackstoryManager.reds` | Code logic with identifiers |
| `Core/Unique/UniqueNPCData.reds` | Data class structure |
| `Core/Unique/UniqueNPCManager.reds` | Lookup logic |
| `Core/BackstoryUI.reds` | UI data structure |
| `Core/BackstoryUIExpanded.reds` | UI data structure |
| `Overrides/*.reds` | Game hooks — no display text |
| `Util/*.reds` | Math/string utilities |


---


## Placeholder Tokens — KEEP EXACTLY AS-IS

Tokens look like `%this%`. They get replaced with generated values at runtime. Keep them in your translated text and move them to fit your grammar.

### Dynamic Tokens

| Token | Becomes | Example |
|---|---|---|
| `%corp%` | Random corporation name | `"Fired from %corp% after the merger. "` |
| `%eddies%` | Random number (100–10,000) | `"Owes %eddies% eddies to a fixer. "` |
| `%years%` | Random number (2–10) | `"Served %years% years in prison. "` |
| `%year%` | Random year (2020–2050) | `"Arrived in Night City in %year%. "` |
| `%young_age%` | Random age (10–16) | `"Left home at age %young_age%. "` |

### Gender Tokens

| Token | Male → | Female → | Use |
|---|---|---|---|
| `%he%` | he | she | Subject: `"%he% ran away"` |
| `%He%` | He | She | Start of sentence: `"%He% ran away"` |
| `%his%` | his | her | Possessive: `"Lost %his% job"` |
| `%His%` | His | Her | Start of sentence |
| `%him%` | him | her | Object: `"told %him%"` |
| `%Him%` | Him | Her | Start of sentence |
| `%hers%` | his | hers | Possessive pronoun: `"it was %hers%"` |
| `%himself%` | himself | herself | Reflexive: `"got %himself% killed"` |
| `%waiter%` | waiter | waitress | Gendered noun |

Capitalized variants (`%He%`, `%His%`, `%Him%`) are for the start of sentences.


---


## Adding Custom Tokens for Your Language

English pronouns are simple. Your language may need more. You can add custom tokens.

### Where to add them

Open `Core/BackstoryManager.reds` and find the `FillReplacements` function. Add your tokens in the same pattern:

```swift
// EXISTING — English pronoun handling
if Equals(gender, "female") {
    if(StrContains(ret, "%he%")) { ret = ReplaceFirst(ret, "%he%", "she"); };
    // ... existing tokens ...

    // YOUR CUSTOM TOKENS — add here
    if(StrContains(ret, "%verb_l%")) { ret = ReplaceFirst(ret, "%verb_l%", "ла"); };
    if(StrContains(ret, "%verb_a%")) { ret = ReplaceFirst(ret, "%verb_a%", "а"); };
} else {
    if(StrContains(ret, "%he%")) { ret = ReplaceFirst(ret, "%he%", "he"); };
    // ... existing tokens ...

    // YOUR CUSTOM TOKENS — male forms
    if(StrContains(ret, "%verb_l%")) { ret = ReplaceFirst(ret, "%verb_l%", "л"); };
    if(StrContains(ret, "%verb_a%")) { ret = ReplaceFirst(ret, "%verb_a%", ""); };
};
```

### Language-specific examples

**Russian** — verb endings change by gender:
```swift
// Token: %verb_l% → "л" (male) / "ла" (female)
public static func LOST_JOB() -> String { return "Потеря%verb_l% работу. "; }
// Male:   "Потерял работу."
// Female: "Потеряла работу."
```

**Polish** — similar verb conjugation:
```swift
// Token: %verb_l% → "ł" (male) / "ła" (female)
public static func LOST_JOB() -> String { return "Straci%verb_l% pracę. "; }
// Male:   "Stracił pracę."
// Female: "Straciła pracę."
```

**German** — possessives change with grammatical case:
```swift
// Add: %sein_nom% → sein/ihr, %sein_acc% → seinen/ihren, etc.
```

**Turkish, Hungarian, Finnish** — no grammatical gender:
You can remove the pronoun tokens entirely and write naturally. Lucky you.

### Fallback: Dual entries

If your language has too many gendered forms for tokens to work, you can use the old system. The two-argument `LPE()` constructor still exists:

```swift
// In the text file — make separate _F and _M functions:
public static func LOST_JOB_F() -> String { return "Потеряла работу. "; }
public static func LOST_JOB_M() -> String { return "Потерял работу. "; }

// In LifePathEvents.reds — use the two-argument LPE:
LPE(KdspTextAdulthood.LOST_JOB_F(), KdspTextAdulthood.LOST_JOB_M())
```


---


## Common Mistakes

### ❌ Translating a code identifier
```swift
// WRONG — you translated "FALLING" which is a code identifier
if Equals(coherence.lifeTheme, "ПАДЕНИЕ") { ... }

// RIGHT — leave it as "FALLING"
if Equals(coherence.lifeTheme, "FALLING") { ... }
```
**Result if wrong:** The comparison never matches. NPCs lose their life themes. Backstories become incoherent.

### ❌ Changing a function name
```swift
// WRONG
public static func ПОТЕРЯЛ_РАБОТУ() -> String { return "Потерял работу. "; }

// RIGHT — function name stays English
public static func LOST_JOB() -> String { return "Потерял работу. "; }
```
**Result if wrong:** REDscript compilation error. Mod won't load. Every file that calls `LOST_JOB()` will break.

### ❌ Removing a placeholder token
```swift
// WRONG — removed %eddies%
public static func LOST_GAMBLE() -> String { return "Проиграл деньги. "; }

// RIGHT — keep the token, put it where it fits
public static func LOST_GAMBLE() -> String { return "Проиграл €$%eddies% евродолларов. "; }
```
**Result if wrong:** No number appears in the text. Not a crash, but looks wrong.

### ❌ Removing the trailing space
```swift
// WRONG — no space before closing quote
public static func HEIST() -> String { return "Участвовал в ограблении."; }

// RIGHT — keep the trailing space
public static func HEIST() -> String { return "Участвовал в ограблении. "; }
```
**Result if wrong:** Text runs together: `"Участвовал в ограблении.Попал в тюрьму."` instead of `"Участвовал в ограблении. Попал в тюрьму."`

### ❌ Translating an n"..." CName
```swift
// WRONG
loadLine.SetName(n"загрузка_линия");

// RIGHT — never touch n"..." strings
loadLine.SetName(n"load_line");
```
**Result if wrong:** UI elements can't be found. Scanner display breaks.

### ❌ Translating a ModSettings.category value
```swift
// WRONG
@runtimeProperty("ModSettings.category", "Отображение")

// RIGHT
@runtimeProperty("ModSettings.category", "Display")
```
**Result if wrong:** Settings won't group correctly in the Mod Settings menu.

### ❌ Using unescaped quotes inside a string
```swift
// WRONG — the quote breaks the string
return "Сказал "привет" соседу. ";

// RIGHT — escape inner quotes
return "Сказал \"привет\" соседу. ";
```
**Result if wrong:** REDscript compilation error. Mod won't load.


---


## Quick Decision Flowchart

```
Is it inside Equals(), StrContains(), or compared with ==?
  YES → DO NOT TRANSLATE
  NO ↓

Does it start with n"..."?
  YES → DO NOT TRANSLATE (CName)
  NO ↓

Is it a @runtimeProperty key like "ModSettings.mod" or "ModSettings.category"?
  YES → DO NOT TRANSLATE
  NO ↓

Is it a @runtimeProperty "displayName" or "description" value?
  YES → TRANSLATE
  NO ↓

Is it inside return "..." or ArrayPush(array, "...")?
  YES → TRANSLATE (this is display text)
  NO ↓

Is it inside .SetBackground(), .SetEarlyLife(), or other .Set___() calls?
  YES → TRANSLATE (unique NPC narrative text)
  NO ↓

Is it a function/class/variable name?
  YES → DO NOT TRANSLATE
  NO → Ask the mod author
```


---


## Testing

1. Drop the translated mod into `Cyberpunk 2077/r6/scripts/backgroundScanner/`
2. Launch the game
3. If REDscript fails, check: `Cyberpunk 2077/r6/logs/redscript_rCURRENT.log`

**Common compile errors:**
- `unexpected token` → Missing closing `"` or unescaped quote inside a string
- `function not found` → You renamed a function
- `class not found` → You renamed a class

**In-game checks:**
- Scan 10+ NPCs across different types (civilians, gangers, corpos)
- Check that %tokens% resolve (no raw `%his%` visible in text)
- Check that section headers display correctly
- Check Settings menu shows translated labels
- Check loading text animation is in your language


---


## Summary Checklist

- [ ] Text/*.reds — All 1,721 entries translated
- [ ] Generator files — Display strings translated, code identifiers untouched
- [ ] UniqueNPCEntries.reds — 225 NPC backstories translated
- [ ] Settings — displayName and description values translated
- [ ] UI files — Loading text, section headers, footer translated
- [ ] Custom gender tokens added (if your language needs them)
- [ ] All %tokens% preserved in translated text
- [ ] All function names unchanged
- [ ] All trailing spaces preserved (`. "`)
- [ ] No unescaped quotes in strings
- [ ] Compiles without errors
- [ ] Tested in-game with multiple NPC types
