# Kiroshi Deep Scan Protocol — Translation Guide v3.0

**The translation model changed completely in v3.0.** If you translated v2.x: your work is still usable (the strings are the same), but the delivery method is new — and dramatically better for you.

---

## The old way vs. the new way

**v2.x:** You forked the entire mod, translated strings inside 90+ source files, and republished the whole thing as a standalone mod. Every KDSP update meant re-doing your fork.

**v3.0:** You ship **one file**. The mod looks up every display string by a stable key through [Codeware's localization system](https://github.com/psiberx/cp2077-codeware/wiki#localization). Your file maps those keys to your language. The game's language setting picks your translation automatically.

What this means for you:
- **No forking.** Your translation is a tiny companion mod, installed alongside KDSP.
- **Updates don't break you.** When KDSP v3.1 adds strings, your file keeps working — new untranslated keys fall back to English until you add them.
- **One install, every language.** Users install KDSP + your language file. Done.

---

## How to create a translation

### 1. Get the key list

Every translatable string lives in `Strings/English.reds` inside the mod — **7,914 keys**. The whole localization system lives in the `Strings/` folder: the English package and the language provider. This file is your master document. Each line looks like:

```swift
this.Text("Kdsp-Job-JOB_LOCAL_FIXER", "Started doing jobs for a local fixer. ");
```

The first argument is the key (never touch it). The second is the English text (translate it).

### 2. Create your language mod

Two small files, or one combined file — your choice. Example for French:

```swift
// KDSP_French.reds
module KiroshiDeepScan_French
import Codeware.Localization.*

public class LocalizationProvider extends ModLocalizationProvider {
    public func GetPackage(language: CName) -> ref<ModLocalizationPackage> {
        return Equals(language, n"fr-fr") ? new LocalizationPackage() : null;
    }
}

public class LocalizationPackage extends ModLocalizationPackage {
    protected func DefineTexts() -> Void {
        this.Text("Kdsp-Job-JOB_LOCAL_FIXER", "A commencé à bosser pour un fixer du coin. ");
        this.Text("Kdsp-Bolo-0", "BOLO : Personne d'intérêt — enquête pour homicide à Watson");
        // ... every key you translate
    }
}
```

Ship it as `yourfile.reds` → `r6/scripts/KDSP_French/`. That's the whole mod.

**Language codes:** `pl-pl`, `fr-fr`, `de-de`, `es-es`, `it-it`, `pt-br`, `ru-ru`, `zh-cn`, `zh-tw`, `ja-jp`, `ko-kr`, `ar-ar`, `cz-cz`, `hu-hu`, `tr-tr`, `th-th` — the game's standard set.

**Large files:** With 4,000+ entries, split `DefineTexts` into sub-functions like the English package does (`this.DefineTexts0(); this.DefineTexts1();` calling private functions of ~400 entries each). Copy the structure of `English.reds` exactly and replace the strings.

### 3. Test in game

Set the game language to yours, load a save, scan an NPC. Untranslated keys show English (fallback) — that's expected and harmless.

---

## Translation rules (unchanged from v2.x)

The rules about WHAT to translate carry over — they now apply to the values in your package:

**✅ TRANSLATE:** narrative text, life events, BOLO notices (after the prefix), loading lines, medical/criminal/employment descriptions, relationship contexts, unique NPC backstories.

**⚠️ PRESERVE INSIDE STRINGS:**
- Tokens: `%he%`, `%his%`, `%him%`, `%year%`, `%young_age%`, `%corp%` — the engine substitutes these after your string is retrieved. Keep them exactly as written, positioned where your grammar needs them.
- Glitch codes and glyphs: `ERR_NULL_REF`, `██████`, `[CORRUPTED]`, `⊕`, `NC-` prefixes — these are diegetic machine output. Keys like `Kdsp-Glitch-*` are translatable in principle, but codes should usually stay identical; translate only the human-readable fragments around them.
- Dynamic-value halves: strings ending mid-sentence (e.g. `"ALERT: 87% facial match — missing person report #NC-"`) have a number appended in code. Keep your sentence structure compatible with the value landing there.
- BOLO prefixes (`BOLO:`, `ALERT:`, `NOTICE:`): **now safely translatable** — v3.0 replaced the English-text detection with an internal flag, so the red highlight works in every language.

**❌ NEVER in your package:** don't invent new keys, don't change key spelling or case — a mismatched key silently falls back to English.

---

## Key naming map

| Key prefix | Content | Count |
|---|---|---|
| Kdsp-Adult-* | Adulthood life events | 518 |
| Kdsp-Bg-* | Background descriptions | 166 |
| Kdsp-Child-* | Childhood events | 280 |
| Kdsp-Core-* | Core strings | 4 |
| Kdsp-Corpo-* | Corporate events | 99 |
| Kdsp-Home-* | Housing events | 197 |
| Kdsp-Job-* | Job events | 237 |
| Kdsp-Lp-* | Lifepath strings | 94 |
| Kdsp-Upb-* | Upbringing events | 255 |
| Kdsp-Bolo-* | BOLO notices (index = roll number) | 72 |
| Kdsp-ConnCtx-* / Kdsp-ConnInj-* | Connection contexts | 62 |
| Kdsp-Load\<Pool\>-* | Scanner loading lines by pool | 168 |
| Kdsp-Npc-\<Name\>-\<Field\>[-n] | Unique NPC entries (suffix -1, -2 = quest-state variants) | 1,786 |
| Kdsp-Glitch-\<Func\>-* | Scanner glitch output | 114 |
| Kdsp-UI-* | Scanner section headers | 15 |
| Kdsp-\<FileTag\>-S* | Generator-assembled fragments (criminal, medical, financial, psych, NCPD, gang, NET, rare classifications, labels and separators) | ~3,850 |

**Still English by design:** name pools (`Core/Names/` — transliterate there directly if needed), the version footer, and ALL-CAPS machine values (`ACTIVE`, `FLAGGED`, `CASH ON DELIVERY`, classification codes like `SLEEPER AGENT`). The all-caps values are diegetic database output and are also used internally by the generation logic — they intentionally stay identical across languages, the way error codes do.

---

## Migrating a v2.x translation

Your translated strings map 1:1 — the content didn't change, only the location. Open your translated fork's `Text/` files side-by-side with `Localization/English.reds`, match each English original to its key, and paste your translation into your package. Function names became key suffixes (`JOB_LOCAL_FIXER` → `Kdsp-Job-JOB_LOCAL_FIXER`), so most of the mapping is mechanical.

---

## Checklist before release

- [ ] Every key copied verbatim from English.reds (no typos, no case changes)
- [ ] Tokens (%he%, %year%, ...) present in your strings where the English had them
- [ ] Dynamic-value strings end where the appended number belongs in your grammar
- [ ] Glitch codes and NC- ID formats preserved
- [ ] Tested in game with your language selected — scanned a civilian, a gang member, a unique NPC
- [ ] Untranslated keys verified to fall back to English without errors
- [ ] Mod page credits Codeware as a requirement (it already is one for KDSP)

Questions → KDSP Nexus page comments or GitHub issues.
