public class KdspBackstoryManager {

    // SEED VERSION - Increment this to regenerate all NPC backstories on next load
    // Change this value when making major content updates
    // Incremented when generation changes enough that old scans should regenerate
    public static func GetSeedVersion() -> Int32 {
        return 5;
    }

    public static func GenerateBackstoryUI(target: wref<NPCPuppet>) -> KdspBackstoryUI {
        let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
        // Seed version allows forcing regeneration of all NPCs when mod is updated
        let seed = RandRange(entityIDHash + (KdspBackstoryManager.GetSeedVersion() * 100000), 0, 2147483647);
        let lifePath: ref<KdspLifePath> = KdspLifePath.Create(target);
        
        // Get data density setting
        let density = KdspSettings.GetDataDensity();

        // Get appearance for detection
        let appearanceName = NameToString(target.GetCurrentAppearanceName());
        
        // Check if NPC is a child - generate age-appropriate content
        if KdspChildBackstoryGenerator.IsChildNPC(appearanceName) {
            return KdspChildBackstoryGenerator.GenerateChildBackstory(seed, lifePath);
        };

        // Get context for expanded systems
        let archetype = lifePath.archetype;
        let gangAffiliation = KdspGangManager.DetectGangAffiliation(appearanceName, "");
        let corpoAffiliation = KdspBackstoryManager.DetectCorpoAffiliation(appearanceName);
        let wealth = KdspBackstoryManager.GetWealthScore(archetype);
        let age = KdspBackstoryManager.GetAge(seed, archetype);

        // Original backstory generation for adults
        let background = KdspBackstoryManager.GenerateChildhoodHome(seed, lifePath, corpoAffiliation) + KdspBackstoryManager.GenerateUpbringingEvent(seed, lifePath, corpoAffiliation);
        let earlyLife = KdspBackstoryManager.GenerateChildhoodEvents(seed, lifePath, corpoAffiliation);
        let significantEvents = KdspBackstoryManager.GenerateFirstJob(seed, lifePath, corpoAffiliation) + KdspBackstoryManager.GenerateAdultEvents(seed, lifePath, corpoAffiliation);

        // Detect ethnicity from appearance and gang affiliation
        let ethnicity = KdspEthnicityDetector.GetEthnicityFromAppearance(appearanceName, gangAffiliation);
        if Equals(ethnicity, KdspNPCEthnicity.Mixed) {
            // No clear ethnicity detected, use random weighted by Night City demographics
            ethnicity = KdspEthnicityDetector.GetRandomEthnicity(seed + 888);
        }

        // Detect NCPD early - they get different treatment
        // Barghest uses Prevention archetype but are NOT NCPD - exclude them
        let isBarghest: Bool = Equals(gangAffiliation, "BARGHEST") || StrContains(appearanceName, "barghest") || StrContains(appearanceName, "kurtz");
        let isNCPD: Bool = !isBarghest && (KdspNCPDNameGenerator.IsNCPD(appearanceName) || target.IsPrevention() || target.IsCharacterPolice());
        let isTraumaTeam: Bool = StrContains(appearanceName, "trauma");

        // Detect fake/corrupt police — record ID contains "fake_police"
        let recordIdStr = TDBID.ToStringDEBUG(target.GetRecord().GetID());
        let isFakeCop: Bool = StrContains(StrLower(recordIdStr), "fake_police");

        // Narrative Coherence is always active — ensures all data systems tell one consistent story
        let coherence: ref<KdspCoherenceProfile>;
        coherence = KdspCoherenceManager.Generate(seed + 500, archetype, age, gangAffiliation);

        // Generate expanded data with coherence profile
        let criminal = KdspCriminalRecordManager.GenerateCoherent(seed + 1000, archetype, gangAffiliation, coherence);
        let cyberware = KdspCyberwareRegistryManager.GenerateCoherent(seed + 2000, archetype, wealth, coherence);
        let financial = KdspFinancialProfileManager.GenerateCoherent(seed + 3000, archetype, coherence);
        // Override employer with NPC's actual corp affiliation when detected
        if NotEquals(corpoAffiliation, "") {
            financial.employer = corpoAffiliation;
        }
        let medical = KdspMedicalHistoryManager.GenerateCoherent(seed + 4000, archetype, age, coherence);
        let psych = KdspPsychProfileManager.GenerateCoherent(seed + 5000, archetype, coherence);

        // ══════════════════════════════════════════════════════════════
        // CROSS-SYSTEM COHERENCE: Rejected Implants → Medical
        // If cyberware registry shows rejected implants, medical records
        // must reflect the condition and health rating must downgrade.
        // A synthetic organ being rejected is a serious medical event.
        // ══════════════════════════════════════════════════════════════
        if cyberware.hasRejectedImplants {
            // Check if medical already has a rejection condition
            let hasRejectionCondition = false;
            let rci = 0;
            while rci < ArraySize(medical.chronicConditions) {
                if StrContains(medical.chronicConditions[rci], "ejection") || StrContains(medical.chronicConditions[rci], "rejection") {
                    hasRejectionCondition = true;
                }
                rci += 1;
            }
            // Add rejection syndrome if not already present
            if !hasRejectionCondition {
                let rejRoll = RandRange(seed + 9300, 0, 4);
                if rejRoll == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S0")); }
                else if rejRoll == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S1")); }
                else if rejRoll == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S2")); }
                else if rejRoll == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S3")); }
                else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S4")); }
            }
            // Downgrade health rating - rejected implants are serious
            if Equals(medical.healthRating, "EXCELLENT") || Equals(medical.healthRating, "GOOD") {
                medical.healthRating = "POOR";
            } else if Equals(medical.healthRating, "FAIR") {
                medical.healthRating = "POOR";
            }
            // POOR stays POOR, CRITICAL/TERMINAL stay as-is

            // Rejected implants also elevate cyberpsychosis risk (immune stress, pain, inflammation)
            cyberware.cyberpsychosisRisk += RandRange(seed + 9310, 15, 30);
            if cyberware.cyberpsychosisRisk > 100 { cyberware.cyberpsychosisRisk = 100; }
            // Refresh status string from updated risk
            if cyberware.cyberpsychosisRisk >= 80 { cyberware.cyberpsychosisStatus = "CRITICAL - REJECTION COMPLICATIONS"; }
            else if cyberware.cyberpsychosisRisk >= 60 { cyberware.cyberpsychosisStatus = "HIGH - REJECTION INDUCED INSTABILITY"; }
            else if cyberware.cyberpsychosisRisk >= 40 { cyberware.cyberpsychosisStatus = "ELEVATED - IMPLANT REJECTION STRESS"; }
            // Below 40 keeps original status (rejection bump wasn't enough to change tier)
        }

        // ══════════════════════════════════════════════════════════════
        // CROSS-SYSTEM COHERENCE: Sex Worker Appearance → Criminal + Medical
        // NPCs with "sexworker" in appearance name should have fitting arrests.
        // Poor sex workers additionally have multiple STIs on record.
        // ══════════════════════════════════════════════════════════════
        let isSexWorker = StrContains(appearanceName, "sexworker") || StrContains(appearanceName, "prostitute") || StrContains(appearanceName, "joytoy");
        let isPoorSexWorker = StrContains(appearanceName, "sexworker_poor") || StrContains(appearanceName, "prostitute_poor");

        if isSexWorker {
            // Ensure they have a criminal record
            criminal.hasRecord = true;
            if Equals(criminal.status, "CLEAN") || Equals(criminal.status, "") {
                criminal.status = "MINOR OFFENSES";
            }

            // Clear existing arrests and replace with sex work related charges
            ArrayClear(criminal.arrests);
            let swYear1 = RandRange(seed + 9400, 2068, 2077);
            let swYear2 = RandRange(seed + 9401, 2065, swYear1);

            // First arrest
            let swRoll1 = RandRange(seed + 9410, 0, 4);
            if swRoll1 == 0 { ArrayPush(criminal.arrests, "Solicitation (" + IntToString(swYear1) + ")"); }
            else if swRoll1 == 1 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S5") + IntToString(swYear1) + ")"); }
            else if swRoll1 == 2 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S6") + IntToString(swYear1) + ")"); }
            else if swRoll1 == 3 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S7") + IntToString(swYear1) + ")"); }
            else { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S8") + IntToString(swYear1) + ")"); }

            // Second arrest
            let swRoll2 = RandRange(seed + 9420, 0, 5);
            if swRoll2 == 0 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S9") + IntToString(swYear2) + ")"); }
            else if swRoll2 == 1 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S10") + IntToString(swYear2) + ")"); }
            else if swRoll2 == 2 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S11") + IntToString(swYear2) + ")"); }
            else if swRoll2 == 3 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S12") + IntToString(swYear2) + ")"); }
            else if swRoll2 == 4 { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S13") + IntToString(swYear2) + ")"); }
            else { ArrayPush(criminal.arrests, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S14") + IntToString(swYear2) + ")"); }

            // NCPD classification fitting for sex work
            let swClassRoll = RandRange(seed + 9440, 0, 3);
            if swClassRoll == 0 { criminal.ncpdClassification = "VICE - REPEAT OFFENDER"; }
            else if swClassRoll == 1 { criminal.ncpdClassification = "VICE - MONITORED"; }
            else if swClassRoll == 2 { criminal.ncpdClassification = "LOW PRIORITY - VICE"; }
            else { criminal.ncpdClassification = "VICE - KNOWN ASSOCIATE"; }
        }

        if isPoorSexWorker {
            // Poor sex workers have STIs on medical record — always 2
            let stiRoll1 = RandRange(seed + 9510, 0, 5);
            if stiRoll1 == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S15")); }
            else if stiRoll1 == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S16")); }
            else if stiRoll1 == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S17")); }
            else if stiRoll1 == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S18")); }
            else if stiRoll1 == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S19")); }
            else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S20")); }

            let stiRoll2 = RandRange(seed + 9520, 0, 5);
            if stiRoll2 == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S21")); }
            else if stiRoll2 == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S22")); }
            else if stiRoll2 == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S23")); }
            else if stiRoll2 == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S24")); }
            else if stiRoll2 == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S25")); }
            else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S26")); }

            // Health downgrade for STIs
            if Equals(medical.healthRating, "EXCELLENT") || Equals(medical.healthRating, "GOOD") || Equals(medical.healthRating, "FAIR") {
                medical.healthRating = "POOR";
            }

            // Also upgrade criminal status for poor sex workers
            if Equals(criminal.status, "MINOR OFFENSES") {
                criminal.status = "REPEAT OFFENDER";
            }
        }

        // ══════════════════════════════════════════════════════════════
        // CROSS-SYSTEM COHERENCE: Obese Body Type → Medical
        // NPCs with "obese" in appearance should have weight-related
        // medical conditions: heart disease, hypertension, diabetes, etc.
        // ══════════════════════════════════════════════════════════════
        let isObese = StrContains(appearanceName, "obese") || StrContains(appearanceName, "_fat_");

        if isObese {
            // Always add a primary weight-related condition
            let obeseRoll1 = RandRange(seed + 9600, 0, 7);
            if obeseRoll1 == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S27")); }
            else if obeseRoll1 == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S28")); }
            else if obeseRoll1 == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S29")); }
            else if obeseRoll1 == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S30")); }
            else if obeseRoll1 == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S31")); }
            else if obeseRoll1 == 5 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S32")); }
            else if obeseRoll1 == 6 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S33")); }
            else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S34")); }

            // 70% chance of a secondary weight-related condition
            if RandRange(seed + 9610, 1, 100) <= 70 {
                let obeseRoll2 = RandRange(seed + 9620, 0, 9);
                if obeseRoll2 == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S35")); }
                else if obeseRoll2 == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S36")); }
                else if obeseRoll2 == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S37")); }
                else if obeseRoll2 == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S38")); }
                else if obeseRoll2 == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S39")); }
                else if obeseRoll2 == 5 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S40")); }
                else if obeseRoll2 == 6 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S41")); }
                else if obeseRoll2 == 7 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S42")); }
                else if obeseRoll2 == 8 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S43")); }
                else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S44")); }
            }

            // Health is never EXCELLENT for obese NPCs
            if Equals(medical.healthRating, "EXCELLENT") {
                medical.healthRating = "FAIR";
            }
            if Equals(medical.healthRating, "GOOD") && RandRange(seed + 9630, 1, 100) <= 50 {
                medical.healthRating = "FAIR";
            }
        }

        // ══════════════════════════════════════════════════════════════
        // CROSS-SYSTEM COHERENCE: Freak Body Type → Medical + Psych
        // NPCs with "freak" in appearance have extreme body mods.
        // Medical shows extreme chrome complications, psych shows
        // body mod obsession and identity-related issues.
        // ══════════════════════════════════════════════════════════════
        let isFreak = StrContains(appearanceName, "freak");

        if isFreak {
            // Always add an extreme body mod medical condition
            let freakMedRoll = RandRange(seed + 9700, 0, 9);
            if freakMedRoll == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S45")); }
            else if freakMedRoll == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S46")); }
            else if freakMedRoll == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S47")); }
            else if freakMedRoll == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S48")); }
            else if freakMedRoll == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S49")); }
            else if freakMedRoll == 5 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S50")); }
            else if freakMedRoll == 6 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S51")); }
            else if freakMedRoll == 7 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S52")); }
            else if freakMedRoll == 8 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S53")); }
            else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S54")); }

            // 60% chance of a second extreme condition
            if RandRange(seed + 9710, 1, 100) <= 60 {
                let freakMedRoll2 = RandRange(seed + 9720, 0, 7);
                if freakMedRoll2 == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S55")); }
                else if freakMedRoll2 == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S56")); }
                else if freakMedRoll2 == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S57")); }
                else if freakMedRoll2 == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S58")); }
                else if freakMedRoll2 == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S59")); }
                else if freakMedRoll2 == 5 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S60")); }
                else if freakMedRoll2 == 6 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S61")); }
                else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S62")); }
            }

            // Freak-specific psych traits - body mod obsession, identity issues
            let freakPsychRoll = RandRange(seed + 9730, 0, 7);
            if freakPsychRoll == 0 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S63")); }
            else if freakPsychRoll == 1 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S64")); }
            else if freakPsychRoll == 2 { ArrayPush(psych.personalityTraits, "Extreme self-expression"); }
            else if freakPsychRoll == 3 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S65")); }
            else if freakPsychRoll == 4 { ArrayPush(psych.personalityTraits, "Transhumanist ideology"); }
            else if freakPsychRoll == 5 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S66")); }
            else if freakPsychRoll == 6 { ArrayPush(psych.personalityTraits, "Sensation-seeking behavior"); }
            else { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S67")); }

            // Elevated cyberpsychosis risk from extreme modding
            cyberware.cyberpsychosisRisk += RandRange(seed + 9740, 10, 25);
            if cyberware.cyberpsychosisRisk > 100 { cyberware.cyberpsychosisRisk = 100; }
            if cyberware.cyberpsychosisRisk >= 80 { cyberware.cyberpsychosisStatus = "CRITICAL - EXTREME MODIFICATION"; }
            else if cyberware.cyberpsychosisRisk >= 60 { cyberware.cyberpsychosisStatus = "HIGH - BODY MOD INSTABILITY"; }
            else if cyberware.cyberpsychosisRisk >= 40 { cyberware.cyberpsychosisStatus = "ELEVATED - EXCESSIVE MODIFICATION"; }

            // Increase illegal mod count - freaks often have unlicensed work
            if cyberware.illegalCount == 0 && RandRange(seed + 9750, 1, 100) <= 60 {
                cyberware.hasIllegalCyberware = true;
                cyberware.illegalCount = RandRange(seed + 9751, 1, 3);
            }
        }

        // ══════════════════════════════════════════════════════════════
        // CROSS-SYSTEM COHERENCE: Nonbinary Identity → Medical + Psych
        // NPCs with "nonbinary" in appearance get identity-appropriate
        // content: gender-affirming treatments, body modification,
        // and identity-related psych context.
        // ══════════════════════════════════════════════════════════════
        let isNonbinary = StrContains(appearanceName, "nonbinary");

        if isNonbinary {
            // Medical: gender-affirming treatments common in Night City
            let nbMedRoll = RandRange(seed + 9800, 0, 9);
            if nbMedRoll == 0 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S68")); }
            else if nbMedRoll == 1 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S69")); }
            else if nbMedRoll == 2 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S70")); }
            else if nbMedRoll == 3 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S71")); }
            else if nbMedRoll == 4 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S72")); }
            else if nbMedRoll == 5 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S73")); }
            else if nbMedRoll == 6 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S74")); }
            else if nbMedRoll == 7 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S75")); }
            else if nbMedRoll == 8 { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S76")); }
            else { ArrayPush(medical.chronicConditions, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S77")); }

            // Psych: identity-related context (not pathologized - just noted)
            let nbPsychRoll = RandRange(seed + 9810, 0, 7);
            if nbPsychRoll == 0 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S78")); }
            else if nbPsychRoll == 1 { ArrayPush(psych.personalityTraits, "Self-defined identity"); }
            else if nbPsychRoll == 2 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S79")); }
            else if nbPsychRoll == 3 { ArrayPush(psych.personalityTraits, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S80")); }
            else if nbPsychRoll == 4 { ArrayPush(psych.personalityTraits, "Post-binary identity"); }
            else if nbPsychRoll == 5 { ArrayPush(psych.personalityTraits, "Fluid self-expression"); }
            else if nbPsychRoll == 6 { ArrayPush(psych.personalityTraits, "Transhumanist leanings"); }
            else { ArrayPush(psych.personalityTraits, "Identity-secure"); }
        }

        // ══════════════════════════════════════════════════════════════
        // DEDUP: Remove duplicate medical conditions
        // Multiple systems can inject conditions, sometimes creating
        // duplicates. Clean up before display.
        // ══════════════════════════════════════════════════════════════
        let dedupConditions: array<String>;
        let dci = 0;
        while dci < ArraySize(medical.chronicConditions) {
            let isDup = false;
            let dcj = 0;
            while dcj < ArraySize(dedupConditions) {
                if Equals(medical.chronicConditions[dci], dedupConditions[dcj]) {
                    isDup = true;
                }
                dcj += 1;
            }
            if !isDup {
                ArrayPush(dedupConditions, medical.chronicConditions[dci]);
            }
            dci += 1;
        }
        medical.chronicConditions = dedupConditions;

        // Build KdspBackstoryUI
        let backstoryUI: KdspBackstoryUI;
        
        // Check if this is a gang member (not Barghest - they have separate handling)
        let isGangMember: Bool = !Equals(gangAffiliation, "NONE") && !isBarghest;

        // Night City ID - always shown
        backstoryUI.ncID = financial.ncID;
        
        // NCPD officers get cop-specific backstory, not civilian backstory
        if isNCPD {
            backstoryUI.background = KdspNCPDProfileGenerator.GenerateNCPDBackground(seed, lifePath);
            // Early life only on medium/high density
            if density >= 2 {
                backstoryUI.earlyLife = KdspNCPDProfileGenerator.GenerateNCPDEarlyLife(seed, lifePath);
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = KdspNCPDProfileGenerator.GenerateNCPDRecentActivity(seed, lifePath);
        } else if isTraumaTeam {
            backstoryUI.background = KdspTraumaTeamGenerator.GenerateTTBackground(seed);
            if density >= 2 {
                backstoryUI.earlyLife = KdspTraumaTeamGenerator.GenerateTTEarlyLife(seed);
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = KdspTraumaTeamGenerator.GenerateTTRecentActivity(seed);
        } else if isBarghest {
            // Barghest get militia-style backgrounds
            let barghestData = KdspBarghestProfileManager.Generate(seed + 8000, appearanceName, lifePath.gender, ethnicity);
            backstoryUI.background = barghestData.background;
            if density >= 2 {
                backstoryUI.earlyLife = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S81") + barghestData.formerAffiliation + ". " + IntToString(barghestData.yearsService) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S82");
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S83") + IntToString(barghestData.yearsBarghest) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S84") + barghestData.combatRole + ".";
        } else if isGangMember {
            // Gang members get gang-specific detailed backstories
            let gangData = KdspGangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);
            backstoryUI.background = gangData.background;
            if density >= 2 {
                backstoryUI.earlyLife = IntToString(gangData.yearsActive) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S85") + gangData.gangName + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S86") + gangData.role + ".";
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = gangData.recentActivity;
        } else {
            backstoryUI.background = background;
            // Early life only on medium/high density
            if density >= 2 {
                backstoryUI.earlyLife = earlyLife;
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = significantEvents;
        };

        // Generate pronouns if enabled - only on high density
        if density >= 3 && KdspSettings.PronounDisplayEnabled() {
            backstoryUI.pronouns = KdspBackstoryManager.GeneratePronouns(seed + 7777, lifePath.gender);
        } else {
            backstoryUI.pronouns = "";
        };

        // Criminal Record Section - skip for NCPD, Barghest, and gang members (they have their own records)
        // Trauma Team gets a service record instead
        if isTraumaTeam {
            backstoryUI.criminalRecord = KdspTraumaTeamGenerator.GenerateTTServiceRecord(seed + 4000);
        } else if criminal.hasRecord && !isNCPD && !isBarghest && !isGangMember {
            backstoryUI.criminalRecord = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S87") + criminal.status;
            // Show arrests on medium/high density
            if density >= 2 && ArraySize(criminal.arrests) > 0 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S88") + criminal.arrests[0];
                if density >= 3 && ArraySize(criminal.arrests) > 1 {
                    backstoryUI.criminalRecord = backstoryUI.criminalRecord + ", " + criminal.arrests[1];
                };
            };
            if !Equals(criminal.warrantStatus, "NONE") && !Equals(criminal.warrantStatus, "CLEARED") {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | WARRANT: " + criminal.warrantStatus;
                if Equals(criminal.warrantStatus, "ACTIVE") {
                    backstoryUI.hasHotRecord = true;
                };
            };
            // NCPD classification on medium/high
            if density >= 2 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | NCPD: " + criminal.ncpdClassification;
            };
            // BOLO / alert notices — lookout flags independent of warrant status
            let boloLine: String = KdspBoloGenerator.Generate(seed + 4700, archetype);
            if NotEquals(boloLine, "") {
                backstoryUI.criminalRecord = boloLine + "\n" + backstoryUI.criminalRecord;
                backstoryUI.hasHotRecord = true;
            };
        } else if !isNCPD && !isBarghest && !isGangMember && !isTraumaTeam {
            // Clean-record civilians can still carry a BOLO — being looked
            // for doesn't require a rap sheet
            let boloLine: String = KdspBoloGenerator.Generate(seed + 4700, archetype);
            if NotEquals(boloLine, "") {
                backstoryUI.criminalRecord = boloLine + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S89");
                backstoryUI.hasHotRecord = true;
            } else {
                backstoryUI.criminalRecord = "";
            };
        } else {
            backstoryUI.criminalRecord = "";
        };

        // Cyberware Registry Section - TT gets military-grade profile
        if isTraumaTeam {
            backstoryUI.cyberwareStatus = KdspTraumaTeamGenerator.GenerateTTCyberware(seed + 4100);
        } else if density >= 2 && Equals(gangAffiliation, "NONE") && cyberware.totalImplants > 0 {
            backstoryUI.cyberwareStatus = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S90") + IntToString(cyberware.totalImplants) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S91") + cyberware.cyberpsychosisStatus;
            if cyberware.cyberpsychosisRisk >= 60 {
                backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | PSYCHOSIS RISK: " + IntToString(cyberware.cyberpsychosisRisk) + "%";
            };
            // Extra details on high density only
            if density >= 3 {
                if cyberware.hasIllegalCyberware {
                    backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | ILLEGAL MODS: " + IntToString(cyberware.illegalCount);
                };
                if cyberware.hasRejectedImplants {
                    backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | REJECTED IMPLANTS DETECTED";
                };
                // Check for body modification implants and display them
                let bodyModFound: String = KdspBackstoryManager.FindBodyModImplant(cyberware);
                if NotEquals(bodyModFound, "") {
                    backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | BODY MOD: " + bodyModFound;
                };
            };
        } else {
            backstoryUI.cyberwareStatus = "";
        };

        // Financial Status Section - TT gets employee data, skip for gang/NCPD
        if isTraumaTeam {
            backstoryUI.financialStatus = KdspTraumaTeamGenerator.GenerateTTFinancial(seed + 4200);
        } else if density >= 2 && Equals(gangAffiliation, "NONE") && !isNCPD {
            backstoryUI.financialStatus = "ID: " + financial.ncID + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S92") + financial.creditTier + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S93") + financial.incomeLevel;
            if financial.hasDebt {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | DEBT: " + financial.debtStatus;
            };
            // Always show Corp for corpo archetypes, otherwise high density + corporateAsset
            let isCorpoArchetype = Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE");
            if isCorpoArchetype || (density >= 3 && financial.corporateAsset) {
                backstoryUI.financialStatus = backstoryUI.financialStatus + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S94") + financial.employer;
            };
        } else {
            backstoryUI.financialStatus = "";
        };

        // Medical Status Section - TT gets combat medical readiness
        if isTraumaTeam {
            backstoryUI.medicalStatus = KdspTraumaTeamGenerator.GenerateTTMedical(seed + 4300);
        } else if density >= 2 && Equals(gangAffiliation, "NONE") && !isNCPD {
            // Blood type always shown first
            backstoryUI.medicalStatus = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S95") + medical.bloodType;
            
            if ArraySize(medical.chronicConditions) > 0 || ArraySize(medical.pastInjuries) > 0 {
                if ArraySize(medical.chronicConditions) > 0 {
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S96") + medical.chronicConditions[0];
                    // Extra conditions on high density
                    if density >= 3 && ArraySize(medical.chronicConditions) > 1 {
                        backstoryUI.medicalStatus = backstoryUI.medicalStatus + ", " + medical.chronicConditions[1];
                    };
                };
                // Injuries on high density only
                if density >= 3 && ArraySize(medical.pastInjuries) > 0 {
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S97") + medical.pastInjuries[0];
                };
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S98") + medical.healthRating;
            } else {
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S99") + medical.healthRating;
            };
            // Trauma Team coverage indicator
            let ttCoverage = financial.traumaTeamCoverage;
            let ttTier: String;
            let dashPos = StrFindFirst(ttCoverage, " - ");
            if dashPos >= 0 {
                ttTier = StrLeft(ttCoverage, dashPos);
            } else {
                ttTier = ttCoverage;
            };
            backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | TT: " + ttTier;
        } else {
            backstoryUI.medicalStatus = "";
        };

        // Behavioral Profile Section (replaces threat assessment) - skip for NCPD, custom for Barghest and gang members
        if isBarghest {
            // Barghest get military threat assessment
            let barghestData = KdspBarghestProfileManager.Generate(seed + 8000, appearanceName, lifePath.gender, ethnicity);
            backstoryUI.threatAssessment = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S100") + barghestData.combatRole;
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S101") + IntToString(barghestData.confirmedKills);
            };
            if density >= 3 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S102");
            };
        } else if isGangMember {
            // Gang members get gang-appropriate threat assessment
            let gangData = KdspGangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);
            
            // Threat level based on gang type
            let threatPrefix: String = "HOSTILE";
            if Equals(gangAffiliation, "MOXES") || Equals(gangAffiliation, "ALDECALDOS") {
                threatPrefix = "CAUTION";
            };
            
            backstoryUI.threatAssessment = threatPrefix + " | " + gangData.gangName;
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | " + gangData.role;
                if gangData.bodyCount > 0 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S103") + IntToString(gangData.bodyCount);
                };
            };
            if density >= 3 {
                if ArraySize(gangData.distinguishingMarks) > 0 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S104") + gangData.distinguishingMarks[0];
                };
            };
        } else if !isNCPD && !isTraumaTeam {
            let temperament = KdspPsychProfileManager.GetTemperament(psych.stabilityScore, psych.threatLevel);
            let disposition = KdspPsychProfileManager.GetDisposition(seed + 5500, archetype);
            
            backstoryUI.threatAssessment = temperament;
            // Add disposition on medium/high density
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | " + disposition;
            };
            // Extra flags on high density only
            if density >= 3 {
                if psych.stabilityScore <= 40 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S105");
                };
                if psych.hasAddictions {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S106");
                };
                if psych.hasVendetta {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S107");
                };
            };
            // Personal data leak - surveillance state quirks (35% on medium+)
            if density >= 2 {
                let quirkRoll = RandRange(seed + 5600, 1, 100);
                if quirkRoll <= 35 {
                    let quirk = KdspPersonalQuirkGenerator.GeneratePersonalQuirk(seed + 5601, archetype);
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | " + quirk;
                    // 15% chance of a second quirk on high density
                    if density >= 3 && RandRange(seed + 5602, 1, 100) <= 15 {
                        let quirk2 = KdspPersonalQuirkGenerator.GeneratePersonalQuirk(seed + 5701, archetype);
                        backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | " + quirk2;
                    };
                };
            };
        } else if isTraumaTeam {
            backstoryUI.threatAssessment = KdspTraumaTeamGenerator.GenerateTTThreatAssessment(seed + 4400);
        } else {
            backstoryUI.threatAssessment = "";
        };

        // Gang Affiliation Section - use detailed profiles (no rank - game shows that as NPC name)
        if isGangMember {
            let gangData = KdspGangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);

            // Generate gang member name if the NPC has a generic display name
            let gangRealName: String = target.GetTweakDBFullDisplayName(true);
            let gangNameData = KdspGangNameGenerator.Generate(seed + 7500, gangAffiliation, lifePath.gender, ethnicity);
            let gangDisplayName: String = "";

            if KdspGangNameGenerator.IsGenericGangName(gangRealName) {
                // Generic name — use generated name with optional alias
                gangDisplayName = KdspGangNameGenerator.GetDisplayName(gangNameData);
            } else {
                // Real name from the game — keep it, but still check for alias
                if gangNameData.hasAlias {
                    gangDisplayName = "\"" + gangNameData.alias + "\" " + gangRealName;
                } else {
                    gangDisplayName = gangRealName;
                }
            }

            backstoryUI.gangAffiliation = gangData.gangName + " | " + gangDisplayName + " | " + gangData.role + " | " + IntToString(gangData.yearsActive) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S108");
            
            // Extra details on medium/high density
            if density >= 2 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S109") + gangData.territory;
                
                // Gang-specific stats
                if Equals(gangAffiliation, "MAELSTROM") && gangData.chromePercentage > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S110") + IntToString(gangData.chromePercentage) + "%";
                };
                if Equals(gangAffiliation, "ANIMALS") && gangData.fightWins > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S111") + IntToString(gangData.fightWins) + "W-" + IntToString(gangData.fightLosses) + "L";
                };
                if Equals(gangAffiliation, "VOODOO_BOYS") && gangData.systemsCompromised > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S112") + IntToString(gangData.systemsCompromised);
                };
                if Equals(gangAffiliation, "SCAVENGERS") && gangData.organsHarvested > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S113") + IntToString(gangData.organsHarvested);
                };
                if Equals(gangAffiliation, "WRAITHS") && gangData.successfulRaids > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S114") + IntToString(gangData.successfulRaids);
                };
                if Equals(gangAffiliation, "ALDECALDOS") && gangData.convoyRuns > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S115") + IntToString(gangData.convoyRuns);
                };
                if Equals(gangAffiliation, "MOXES") && gangData.peopleProtected > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S116") + IntToString(gangData.peopleProtected);
                };
                if Equals(gangAffiliation, "6TH_STREET") && NotEquals(gangData.priorService, "") {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S117") + gangData.priorService;
                };
                
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S118") + gangData.loyaltyRating;
                if density >= 3 && gangData.bodyCount > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S119") + IntToString(gangData.bodyCount);
                };
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S91") + gangData.status;
            };
        } else {
            backstoryUI.gangAffiliation = "";
        };

        // Rare NPC Flag - skip for NCPD, Barghest, and gang members, show on all density levels (it's rare enough)
        if !isNCPD && !isBarghest && !isGangMember && !isTraumaTeam && KdspRareNPCManager.ShouldBeRareNPC(seed + 9999) {
            let rareData = KdspRareNPCManager.Generate(seed + 10000, archetype);
            backstoryUI.rareFlag = rareData.displayFlag + " - " + rareData.rareType;
        } else {
            backstoryUI.rareFlag = "";
        };

        // NCPD Officer Detection and Name Generation
        if isNCPD {
            let ncpdData = KdspNCPDNameGenerator.Generate(seed + 7000, appearanceName, lifePath.gender, ethnicity);
            
            // Try to get real name from TweakDB
            let realName: String = target.GetTweakDBFullDisplayName(true);
            let displayName: String = "";
            
            // Check if name is generic (LocKeys for generic names, common generic terms)
            let isGenericName: Bool = Equals(realName, GetLocalizedText("LocKey#1187")) ||
                                      Equals(realName, GetLocalizedText("LocKey#48967")) ||
                                      Equals(realName, GetLocalizedText("LocKey#44024")) ||
                                      Equals(realName, GetLocalizedText("LocKey#44025")) ||
                                      Equals(realName, GetLocalizedText("LocKey#42711")) ||
                                      Equals(realName, "") ||
                                      Equals(realName, "None") ||
                                      Equals(realName, "Enemy") ||
                                      Equals(realName, "Beat Cop") ||
                                      Equals(realName, "Cop") ||
                                      Equals(realName, "Officer") ||
                                      Equals(realName, "Police Officer") ||
                                      Equals(realName, "NCPD Officer") ||
                                      Equals(realName, "Patrol Officer") ||
                                      Equals(realName, "Police") ||
                                      Equals(realName, "NCPD") ||
                                      Equals(realName, "Policeman") ||
                                      Equals(realName, "Policewoman") ||
                                      Equals(realName, "Detective") ||
                                      Equals(realName, "Sergeant") ||
                                      Equals(realName, "Lieutenant") ||
                                      Equals(realName, "Captain") ||
                                      StrContains(realName, "LocKey") ||
                                      StrLen(realName) < 3;
            
            // Use real name if unique, otherwise use generated name
            if !isGenericName {
                displayName = ncpdData.rank + " " + realName;
            } else {
                displayName = ncpdData.rank + " " + ncpdData.fullName;
            };
            
            backstoryUI.ncpdOfficer = displayName + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S120") + ncpdData.badge;
            // Extra NCPD details on medium/high density
            if density >= 2 {
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + ncpdData.unit;
                if density >= 3 && StrLen(ncpdData.specialization) > 0 {
                    backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S121") + ncpdData.specialization;
                };
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S122") + ncpdData.assignedDistrict;
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + IntToString(ncpdData.yearsOfService) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S123");
                if density >= 3 && ncpdData.confirmedNeutralizations > 0 {
                    backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S124") + IntToString(ncpdData.confirmedNeutralizations);
                };
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S91") + ncpdData.dutyStatus;
            };
        } else if isBarghest {
            // Barghest get militia service records - use gangAffiliation, not ncpdOfficer
            let barghestData = KdspBarghestProfileManager.Generate(seed + 8000, appearanceName, lifePath.gender, ethnicity);
            
            // Build display name with callsign if present
            let displayName: String = "";
            if NotEquals(barghestData.callsign, "") {
                displayName = barghestData.barghestRank + " \"" + barghestData.callsign + "\" " + barghestData.fullName;
            } else {
                displayName = barghestData.barghestRank + " " + barghestData.fullName;
            };
            
            backstoryUI.gangAffiliation = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S125") + displayName + " | MOS: " + barghestData.mos;
            // Extra Barghest details on medium/high density
            if density >= 2 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S117") + barghestData.formerAffiliation;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S126") + barghestData.assignedSector;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | " + IntToString(barghestData.yearsBarghest) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S127");
                if density >= 3 && barghestData.confirmedKills > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S128") + IntToString(barghestData.confirmedKills);
                };
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S118") + barghestData.loyaltyRating;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S91") + barghestData.dutyStatus;
            };
            backstoryUI.ncpdOfficer = "";
        } else {
            backstoryUI.ncpdOfficer = "";
        };

        if density >= 2 && !isNCPD && !isBarghest && !isGangMember && !isTraumaTeam {
            // Get NPC's last name so family members share it
            let npcLastName = KdspBackstoryManager.ExtractLastName(target);
            let relations = KdspRelationshipsManager.GenerateWithName(seed + 8000, archetype, gangAffiliation, ethnicity, npcLastName);

            // ══════════════════════════════════════════════════════════════
            // CONNECTION SYSTEM: Phantom Community Pool Injection
            // If Phantom or Full mode, ~40% chance one associate comes from
            // a deterministic district pool. NPCs in the same area will
            // independently generate overlapping names.
            // ══════════════════════════════════════════════════════════════
            let connectionMode: Int32 = KdspSettings.GetConnectionMode();
            let usePhantom: Bool = connectionMode == 1 || connectionMode == 3;
            let npcDistrict: String = KdspCrowdDistrictManager.DetectDistrictFromAppearance(appearanceName);

            if usePhantom && ArraySize(relations.knownAssociates) > 0 {
                let communityResult: array<String> = KdspCommunityPool.TryInject(npcDistrict, entityIDHash, seed + 8500);
                if ArraySize(communityResult) == 2 {
                    // Replace first associate with community member
                    relations.knownAssociates[0].name = communityResult[0];
                    relations.knownAssociates[0].relationship = communityResult[1];
                    relations.knownAssociates[0].isAlias = false;
                };
            };

            // ══════════════════════════════════════════════════════════════
            // CROSS-SYSTEM COHERENCE: Marriage → Relationships
            // If significant events mention marriage, relationship status
            // must say "Married" and a spouse must exist in family list.
            // ══════════════════════════════════════════════════════════════
            if StrContains(significantEvents, "married") {
                relations.currentRelationshipStatus = "Married";
                // Check if a spouse already exists
                let hasSpouse = false;
                let msi = 0;
                while msi < ArraySize(relations.familyMembers) {
                    if Equals(relations.familyMembers[msi].relation, "Spouse") || Equals(relations.familyMembers[msi].relation, "Same-sex Spouse") {
                        hasSpouse = true;
                    }
                    msi += 1;
                }
                // Inject a spouse if none exists
                if !hasSpouse {
                    let spouse = new KdspFamilyMemberInfo();
                    let spouseGender = KdspNameGenerator.GetRandomGender(seed + 9100);
                    let spouseFirst = KdspNameGenerator.GetFirstNameByEthnicity(seed + 9110, spouseGender, ethnicity);
                    let spouseLast: String;
                    // 80% chance spouse shares last name, 20% keeps maiden name
                    if NotEquals(npcLastName, "") && RandRange(seed + 9130, 1, 100) <= 80 {
                        spouseLast = npcLastName;
                    } else {
                        spouseLast = KdspNameGenerator.GetLastNameByEthnicity(seed + 9120, ethnicity);
                    }
                    spouse.name = spouseFirst + " " + spouseLast;
                    spouse.relation = "Spouse";
                    spouse.status = "Alive";
                    spouse.location = "Night City";
                    ArrayPush(relations.familyMembers, spouse);
                }
            }

            // ══════════════════════════════════════════════════════════════
            // CROSS-SYSTEM COHERENCE: Grudge Holder → Enemies
            // If psych profile flags vendetta/grudge-holder, the NPC must
            // have at least one enemy. A grudge holder with zero enemies
            // is an obvious contradiction.
            // ══════════════════════════════════════════════════════════════
            if psych.hasVendetta && ArraySize(relations.knownEnemies) == 0 {
                let grudgeEnemy = new KdspEnemyInfo();
                let enemyGender = KdspNameGenerator.GetRandomGender(seed + 9200);
                grudgeEnemy.name = KdspNameGenerator.GetFirstNameByEthnicity(seed + 9210, enemyGender, ethnicity) + " " + KdspNameGenerator.GetLastNameByEthnicity(seed + 9220, ethnicity);
                // Use vendetta target as context if available
                if NotEquals(psych.vendettaTarget, "") {
                    grudgeEnemy.reason = "Vendetta (" + psych.vendettaTarget + ")";
                } else {
                    grudgeEnemy.reason = "Personal vendetta";
                }
                // Grudge holders tend toward higher threat enemies
                let grudgeThreatRoll = RandRange(seed + 9230, 1, 100);
                if grudgeThreatRoll <= 30 { grudgeEnemy.threatLevel = "Moderate"; }
                else if grudgeThreatRoll <= 70 { grudgeEnemy.threatLevel = "High"; }
                else { grudgeEnemy.threatLevel = "Extreme"; }
                ArrayPush(relations.knownEnemies, grudgeEnemy);
            }

            // ══════════════════════════════════════════════════════════════
            // CROSS-SYSTEM COHERENCE: Sex Worker → Known Clients
            // Sex workers should have a small list of known clients in
            // their associates. These are NCPD-flagged repeat clients.
            // ══════════════════════════════════════════════════════════════
            if isSexWorker {
                // Sex workers don't need recent activity — other sections tell the story
                backstoryUI.significantEvents = "";

                // Clear existing associates — sex workers' known contacts are clients
                ArrayClear(relations.knownAssociates);

                // Generate exactly 2 known clients
                let cli = 0;
                while cli < 2 {
                    let client = new KdspAssociateInfo();
                    let clientGender = RandRange(seed + 9560 + (cli * 31), 1, 100);
                    let cGender: String;
                    if clientGender <= 85 { cGender = "Male"; } else { cGender = "Female"; }
                    let clientFirst = KdspNameGenerator.GetFirstNameByEthnicity(seed + 9570 + (cli * 41), cGender, KdspEthnicityDetector.GetRandomEthnicity(seed + 9575 + (cli * 23)));
                    let clientLast = KdspNameGenerator.GetLastNameByEthnicity(seed + 9580 + (cli * 51), KdspEthnicityDetector.GetRandomEthnicity(seed + 9585 + (cli * 37)));
                    client.name = clientFirst + " " + clientLast;
                    client.isAlias = false;

                    // Short client descriptors
                    let clientTypeRoll = RandRange(seed + 9590 + (cli * 61), 0, 9);
                    if clientTypeRoll == 0 { client.relationship = "Repeat client"; }
                    else if clientTypeRoll == 1 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S129"); }
                    else if clientTypeRoll == 2 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S130"); }
                    else if clientTypeRoll == 3 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S131"); }
                    else if clientTypeRoll == 4 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S132"); }
                    else if clientTypeRoll == 5 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S133"); }
                    else if clientTypeRoll == 6 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S134"); }
                    else if clientTypeRoll == 7 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S135"); }
                    else if clientTypeRoll == 8 { client.relationship = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S136"); }
                    else { client.relationship = "Occasional client"; }

                    client.status = "Active";
                    client.affiliation = "";
                    ArrayPush(relations.knownAssociates, client);
                    cli += 1;
                }

                // Override relationship status
                let swRelRoll = RandRange(seed + 9650, 0, 3);
                if swRelRoll == 0 { relations.currentRelationshipStatus = "Single"; }
                else if swRelRoll == 1 { relations.currentRelationshipStatus = "It's Complicated"; }
                else if swRelRoll == 2 { relations.currentRelationshipStatus = "Single"; }
                else { relations.currentRelationshipStatus = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S137"); }
            }

            backstoryUI.relationships = "";
            let compactRel = KdspSettings.CompactRelationshipsEnabled();
            
            // Status and dependents
            backstoryUI.relationships = relations.currentRelationshipStatus;
            if relations.dependents > 0 {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S138") + IntToString(relations.dependents);
            };
            
            // Emergency contact - full mode, high density only
            if !compactRel && density >= 3 && !Equals(relations.emergencyContact, "NONE ON FILE") {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S139") + relations.emergencyContact;
            };
            
            // Family members
            if ArraySize(relations.familyMembers) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S140");
                let i = 0;
                let maxFamily = 2;
                if !compactRel && density >= 3 {
                    maxFamily = 4;
                };
                if ArraySize(relations.familyMembers) < maxFamily {
                    maxFamily = ArraySize(relations.familyMembers);
                };
                while i < maxFamily {
                    let fam = relations.familyMembers[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + fam.name + " (" + fam.relation;
                    if !Equals(fam.status, "Alive") && !Equals(fam.status, "") {
                        backstoryUI.relationships = backstoryUI.relationships + " - " + fam.status;
                    };
                    backstoryUI.relationships = backstoryUI.relationships + ")";
                    i += 1;
                };
                if ArraySize(relations.familyMembers) > maxFamily {
                    backstoryUI.relationships = backstoryUI.relationships + " +" + IntToString(ArraySize(relations.familyMembers) - maxFamily) + " more";
                };
            };
            
            // Known associates
            if ArraySize(relations.knownAssociates) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S141");
                let i = 0;
                let maxShow = 2;
                if !compactRel && density >= 3 {
                    maxShow = 3;
                };
                if ArraySize(relations.knownAssociates) < maxShow {
                    maxShow = ArraySize(relations.knownAssociates);
                };
                while i < maxShow {
                    let assoc = relations.knownAssociates[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + assoc.name + " (" + assoc.relationship + ")";
                    i += 1;
                };
                if ArraySize(relations.knownAssociates) > maxShow {
                    backstoryUI.relationships = backstoryUI.relationships + " +" + IntToString(ArraySize(relations.knownAssociates) - maxShow) + " more";
                };
            };
            
            // Professional contacts - full mode, high density only
            if !compactRel && density >= 3 && ArraySize(relations.professionalContacts) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S142");
                let i = 0;
                while i < ArraySize(relations.professionalContacts) {
                    let pro = relations.professionalContacts[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + pro.name + " (" + pro.type + ")";
                    i += 1;
                };
            };
            
            // Known enemies - high density only
            if density >= 3 && ArraySize(relations.knownEnemies) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | ENEMIES: ";
                let i = 0;
                while i < ArraySize(relations.knownEnemies) {
                    let enemy = relations.knownEnemies[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    if compactRel {
                        backstoryUI.relationships = backstoryUI.relationships + enemy.name + " (" + enemy.reason + ")";
                    } else {
                        backstoryUI.relationships = backstoryUI.relationships + enemy.name + " (" + enemy.reason + " - " + enemy.threatLevel + ")";
                    };
                    i += 1;
                };
            };
            
            // Romantic history - full mode, high density only
            if !compactRel && density >= 3 && !Equals(relations.romanticHistory, "") {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S143") + relations.romanticHistory;
            };
            
            // Social network size - full mode, high density only
            if !compactRel && density >= 3 {
                backstoryUI.relationships = backstoryUI.relationships + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S144") + relations.socialNetworkSize;
            };

            // ══════════════════════════════════════════════════════════════
            // CONNECTION SYSTEM: Cross-NPC Detection Pipeline
            // Runs after all relationship UI is built. Detects overlaps
            // with previously scanned NPCs and produces alert text.
            // ══════════════════════════════════════════════════════════════
            if connectionMode > 0 {
                // Get NPC's generated display name for cross-referencing
                let npcFullName: String = target.GetTweakDBFullDisplayName(true);
                if Equals(npcFullName, "") || StrLen(npcFullName) < 3 {
                    npcFullName = KdspNameGenerator.GenerateFullNameByEthnicity(seed + 8600, lifePath.gender, ethnicity);
                };

                let connResult: ref<KdspConnectionResult> = KdspConnectionDetector.Detect(
                    GetGameInstance(),
                    entityIDHash,
                    npcFullName,
                    gangAffiliation,
                    npcDistrict,
                    archetype,
                    relations,
                    connectionMode,
                    seed + 9500
                );

                // Append alert to UI
                if ArraySize(connResult.alerts) > 0 {
                    let compactLevel: Int32 = KdspSettings.GetCompactLevel();
                    if compactLevel >= 2 {
                        backstoryUI.networkAnalysis = KdspConnectionDetector.FormatShort(connResult);
                    } else {
                        backstoryUI.networkAnalysis = KdspConnectionDetector.FormatAlerts(connResult);
                    };
                } else {
                    backstoryUI.networkAnalysis = "";
                };

                // Inject previously scanned NPC as relationship
                if connResult.hasInjectedRel {
                    backstoryUI.relationships = backstoryUI.relationships + " | " + connResult.injectedRelName + " (" + connResult.injectedRelContext + ")";
                };
            } else {
                backstoryUI.networkAnalysis = "";
            };
        } else {
            backstoryUI.relationships = "";
        };

        // ══════════════════════════════════════════════════════════════
        // VEHICLE REGISTRATION: Not everyone owns a vehicle.
        // Higher chance for corpos, nomads, yuppies. Lower for homeless,
        // junkies, gangers. Only on high density. ~30-60% chance.
        // ══════════════════════════════════════════════════════════════
        if density >= 3 && !isNCPD && !isBarghest && !isGangMember && !isTraumaTeam {
            let vehicleChance = 30; // base 30%
            if Equals(archetype, "CORPO_MANAGER") { vehicleChance = 85; }
            else if Equals(archetype, "CORPO_DRONE") { vehicleChance = 70; }
            else if Equals(archetype, "YUPPIE") { vehicleChance = 75; }
            else if Equals(archetype, "NOMAD") { vehicleChance = 90; }
            else if Equals(archetype, "CIVVIE") { vehicleChance = 40; }
            else if Equals(archetype, "HOMELESS") { vehicleChance = 5; }
            else if Equals(archetype, "JUNKIE") { vehicleChance = 10; }
            else if Equals(archetype, "GANGER") { vehicleChance = 25; }

            let vehicleRoll = RandRange(seed + 16001, 1, 100);
            if vehicleRoll <= vehicleChance {
                backstoryUI.vehicleRegistration = KdspVehicleRegistration.GenerateVehicleRegistration(seed + 16111, archetype, financial.ncID);
            } else {
                backstoryUI.vehicleRegistration = "";
            }
        } else {
            backstoryUI.vehicleRegistration = "";
        }

        // ══════════════════════════════════════════════════════════════
        // NET PROFILE: Digital footprint. Not everyone has one.
        // Corpos and yuppies have strong presence. Homeless and elderly
        // less so. Gangers may have darknet activity. ~25-70% chance.
        // Only on high density.
        // ══════════════════════════════════════════════════════════════
        if density >= 3 && !isNCPD && !isBarghest && !isTraumaTeam {
            let netChance = 35; // base 35%
            if Equals(archetype, "CORPO_MANAGER") { netChance = 80; }
            else if Equals(archetype, "CORPO_DRONE") { netChance = 70; }
            else if Equals(archetype, "YUPPIE") { netChance = 75; }
            else if Equals(archetype, "CIVVIE") { netChance = 45; }
            else if Equals(archetype, "NOMAD") { netChance = 20; }
            else if Equals(archetype, "HOMELESS") { netChance = 8; }
            else if Equals(archetype, "JUNKIE") { netChance = 15; }
            else if Equals(archetype, "GANGER") { netChance = 40; }

            let netRoll = RandRange(seed + 17001, 1, 100);
            if netRoll <= netChance {
                backstoryUI.netProfile = KdspNetProfileGenerator.GenerateNetProfile(seed + 17111, archetype, gangAffiliation);
            } else {
                backstoryUI.netProfile = "";
            }
        } else {
            backstoryUI.netProfile = "";
        }

        // ══════════════════════════════════════════════════════════════
        // SCANNER GLITCH: Rare chance of total data corruption
        // Simulates Kiroshi optics malfunction, corrupted NCPD database
        // pull, or NetWatch interference. Chance controlled by settings.
        // ══════════════════════════════════════════════════════════════
        if KdspSettings.ScannerGlitchesEnabled() {
            let glitchChance = KdspSettings.GetScannerGlitchChance();
            if glitchChance > 0 && RandRange(seed + 77777, 1, glitchChance) == 1 {
                let glitched = KdspScannerGlitch.CorruptScan(seed, backstoryUI);
                backstoryUI.ncID = glitched.ncID;
                backstoryUI.background = glitched.background;
                backstoryUI.earlyLife = glitched.earlyLife;
                backstoryUI.significantEvents = glitched.significantEvents;
                backstoryUI.threatAssessment = glitched.threatAssessment;
                backstoryUI.criminalRecord = glitched.criminalRecord;
                backstoryUI.cyberwareStatus = glitched.cyberwareStatus;
                backstoryUI.financialStatus = glitched.financialStatus;
                backstoryUI.medicalStatus = glitched.medicalStatus;
                backstoryUI.relationships = glitched.relationships;
                backstoryUI.gangAffiliation = glitched.gangAffiliation;
                backstoryUI.vehicleRegistration = glitched.vehicleRegistration;
                backstoryUI.netProfile = glitched.netProfile;
                backstoryUI.rareFlag = glitched.rareFlag;
                backstoryUI.ncpdOfficer = glitched.ncpdOfficer;
                backstoryUI.pronouns = glitched.pronouns;
                backstoryUI.isUnique = glitched.isUnique;
                backstoryUI.uniqueClassification = glitched.uniqueClassification;
                backstoryUI.debugInfo = glitched.debugInfo;
            }
        }

        // ══════════════════════════════════════════════════════════════
        // FAKE COP OVERRIDE — NPC with "fake_police" in TweakDB record
        // These are criminals impersonating NCPD officers. Override the
        // clean NCPD profile with corruption flags and criminal data.
        // ══════════════════════════════════════════════════════════════
        if isFakeCop {
            let fakeRoll = RandRange(seed + 9500, 0, 5);
            if fakeRoll == 0 {
                backstoryUI.background = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S145");
            } else if fakeRoll == 1 {
                backstoryUI.background = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S146");
            } else if fakeRoll == 2 {
                backstoryUI.background = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S147");
            } else if fakeRoll == 3 {
                backstoryUI.background = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S148");
            } else if fakeRoll == 4 {
                backstoryUI.background = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S149");
            } else {
                backstoryUI.background = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S150");
            };

            let fakeEarly = RandRange(seed + 9510, 0, 4);
            if fakeEarly == 0 {
                backstoryUI.earlyLife = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S151");
            } else if fakeEarly == 1 {
                backstoryUI.earlyLife = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S152");
            } else if fakeEarly == 2 {
                backstoryUI.earlyLife = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S153");
            } else {
                backstoryUI.earlyLife = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S154");
            };

            let fakeRecent = RandRange(seed + 9520, 0, 4);
            if fakeRecent == 0 {
                backstoryUI.significantEvents = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S155");
            } else if fakeRecent == 1 {
                backstoryUI.significantEvents = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S156");
            } else if fakeRecent == 2 {
                backstoryUI.significantEvents = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S157");
            } else {
                backstoryUI.significantEvents = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S158");
            };

            // Override the NCPD personnel file with corruption flag
            backstoryUI.ncpdOfficer = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S159");

            // Fake cops SHOULD have a criminal record (normal NCPD skips this)
            let fakeCrimRoll = RandRange(seed + 9530, 0, 4);
            if fakeCrimRoll == 0 {
                backstoryUI.criminalRecord = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S160");
            } else if fakeCrimRoll == 1 {
                backstoryUI.criminalRecord = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S161");
            } else if fakeCrimRoll == 2 {
                backstoryUI.criminalRecord = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S162");
            } else {
                backstoryUI.criminalRecord = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S163");
            };
        }

        return backstoryUI;
    }

    private static func GetWealthScore(archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return 85; };
        if Equals(archetype, "YUPPIE") { return 70; };
        if Equals(archetype, "CORPO_DRONE") { return 55; };
        if Equals(archetype, "CIVVIE") { return 40; };
        if Equals(archetype, "NOMAD") { return 30; };
        if Equals(archetype, "GANGER") { return 25; };
        if Equals(archetype, "LOWLIFE") { return 15; };
        if Equals(archetype, "JUNKIE") { return 10; };
        if Equals(archetype, "HOMELESS") { return 5; };
        return 35;
    }

    private static func GetAge(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed + 8888, 35, 60); };
        if Equals(archetype, "CORPO_DRONE") { return RandRange(seed + 8888, 22, 45); };
        if Equals(archetype, "YUPPIE") { return RandRange(seed + 8888, 25, 45); };
        if Equals(archetype, "GANGER") { return RandRange(seed + 8888, 18, 35); };
        if Equals(archetype, "HOMELESS") { return RandRange(seed + 8888, 25, 65); };
        if Equals(archetype, "JUNKIE") { return RandRange(seed + 8888, 20, 50); };
        if Equals(archetype, "NOMAD") { return RandRange(seed + 8888, 20, 50); };
        return RandRange(seed + 8888, 20, 55);
    }

    private static func GenerateUpbringingEvent(seed: Int32, lifePath: ref<KdspLifePath>, corpoAffiliation: String) -> String {
        return KdspBackstoryManager.GenerateEvent(seed, lifePath, lifePath.possibleEvents.m_weightedUpbringingEvents, lifePath.possibleEvents.m_cdfWeightedUpbringingEvents, corpoAffiliation);
    }

    public static func GenerateChildhoodHome(seed: Int32, lifePath: ref<KdspLifePath>, corpoAffiliation: String) -> String {
        return KdspBackstoryManager.GenerateEvent(seed, lifePath, lifePath.possibleEvents.m_weightedHomeEvents, lifePath.possibleEvents.m_cdfWeightedHomeEvents, corpoAffiliation);
    }

    private static func GenerateChildhoodEvents(seed: Int32, lifePath: ref<KdspLifePath>, corpoAffiliation: String) -> String {
        let childhoodEvents: String;
        let eventsCount: Int32 = RandRange(seed + 21620, 1, 2);

        let i = 0;
        while i < eventsCount {
            childhoodEvents += KdspBackstoryManager.GenerateEvent(seed + (i * 199), lifePath, lifePath.possibleEvents.m_weightedChildhoodEvents, lifePath.possibleEvents.m_cdfWeightedChildhoodEvents, corpoAffiliation);
            i += 1;
        }  
        return childhoodEvents;
    }

    private static func GenerateFirstJob(seed: Int32, lifePath: ref<KdspLifePath>, corpoAffiliation: String) -> String {
        return KdspBackstoryManager.GenerateEvent(seed, lifePath, lifePath.possibleEvents.m_weightedJobEvents, lifePath.possibleEvents.m_cdfWeightedJobEvents, corpoAffiliation);
    }

    private static func GenerateAdultEvents(seed: Int32, lifePath: ref<KdspLifePath>, corpoAffiliation: String) -> String {
        let adultEvents: String;
        let eventsCount: Int32 = RandRange(seed + 21620, 1, 2);

        let i = 0;
        while i < eventsCount {
            adultEvents += KdspBackstoryManager.GenerateEvent(seed + (i * 199), lifePath, lifePath.possibleEvents.m_weightedAdultEvents, lifePath.possibleEvents.m_cdfWeightedAdultEvents, corpoAffiliation);
            i += 1;
        }  
        return adultEvents;
    }

    private static func GenerateEvent(seed: Int32, lifePath: ref<KdspLifePath>, arr: array<ref<KdspLifePathEvent>>, cdf: array<Int32>, corpoAffiliation: String) -> String {
        let cdfSize = ArraySize(cdf);
        let totalWeight = cdf[cdfSize - 1];
        let val = RandRange(seed, 0, totalWeight);
        let eventIndex = KdspBackstoryManager.getCorrespondingIndex(cdf, val);

        let event = arr[eventIndex];
        let eventText = event.GetText(lifePath.gender);
        return KdspBackstoryManager.FillReplacements(seed, eventText, corpoAffiliation, lifePath.gender);
    }

    private static func FillReplacements(seed: Int32, text: String, corpoAffiliation: String, gender: String) -> String {
        let ret = text;
        // Skip token replacement entirely for strings with no tokens
        if !StrContains(ret, "%") {
            return ret;
        };
        if(StrContains(ret, "%corp%")) {
            if NotEquals(corpoAffiliation, "") {
                ret = ReplaceFirst(ret, "%corp%", corpoAffiliation);
            } else {
                ret = ReplaceFirst(ret, "%corp%", KdspBackstoryManager.GetRandomCorpo(seed));
            }
        };
        if(StrContains(ret, "%eddies%")) {
            ret = ReplaceFirst(ret, "%eddies%", IntToString(RandRange(seed, 100, 10000)));
        };
        if(StrContains(ret, "%years%")) {
            ret = ReplaceFirst(ret, "%years%", IntToString(RandRange(seed, 2, 10)));
        };
        if(StrContains(ret, "%year%")) {
            ret = ReplaceFirst(ret, "%year%", IntToString(RandRange(seed, 2020, 2050)));
        };
        if(StrContains(ret, "%young_age%")) {
            ret = ReplaceFirst(ret, "%young_age%", IntToString(RandRange(seed, 10, 16)));
        };
        // Gender pronoun replacements
        if Equals(gender, "female") {
            if(StrContains(ret, "%He%")) { ret = ReplaceFirst(ret, "%He%", "She"); };
            if(StrContains(ret, "%he%")) { ret = ReplaceFirst(ret, "%he%", "she"); };
            if(StrContains(ret, "%His%")) { ret = ReplaceFirst(ret, "%His%", "Her"); };
            if(StrContains(ret, "%his%")) { ret = ReplaceFirst(ret, "%his%", "her"); };
            if(StrContains(ret, "%him%")) { ret = ReplaceFirst(ret, "%him%", "her"); };
            if(StrContains(ret, "%Him%")) { ret = ReplaceFirst(ret, "%Him%", "Her"); };
            if(StrContains(ret, "%hers%")) { ret = ReplaceFirst(ret, "%hers%", "hers"); };
            if(StrContains(ret, "%Hers%")) { ret = ReplaceFirst(ret, "%Hers%", "Hers"); };
            if(StrContains(ret, "%himself%")) { ret = ReplaceFirst(ret, "%himself%", "herself"); };
            if(StrContains(ret, "%Himself%")) { ret = ReplaceFirst(ret, "%Himself%", "Herself"); };
            if(StrContains(ret, "%waiter%")) { ret = ReplaceFirst(ret, "%waiter%", "waitress"); };
        } else {
            if(StrContains(ret, "%He%")) { ret = ReplaceFirst(ret, "%He%", "He"); };
            if(StrContains(ret, "%he%")) { ret = ReplaceFirst(ret, "%he%", "he"); };
            if(StrContains(ret, "%His%")) { ret = ReplaceFirst(ret, "%His%", "His"); };
            if(StrContains(ret, "%his%")) { ret = ReplaceFirst(ret, "%his%", "his"); };
            if(StrContains(ret, "%him%")) { ret = ReplaceFirst(ret, "%him%", "him"); };
            if(StrContains(ret, "%Him%")) { ret = ReplaceFirst(ret, "%Him%", "Him"); };
            if(StrContains(ret, "%hers%")) { ret = ReplaceFirst(ret, "%hers%", "his"); };
            if(StrContains(ret, "%Hers%")) { ret = ReplaceFirst(ret, "%Hers%", "His"); };
            if(StrContains(ret, "%himself%")) { ret = ReplaceFirst(ret, "%himself%", "himself"); };
            if(StrContains(ret, "%Himself%")) { ret = ReplaceFirst(ret, "%Himself%", "Himself"); };
            if(StrContains(ret, "%waiter%")) { ret = ReplaceFirst(ret, "%waiter%", "waiter"); };
        };
        return ret;
    }

    // Binary search over the CDF. Returns the first index where
    // val <= cdf[index], clamped in-bounds.
    private static func getCorrespondingIndex(arr: array<Int32>, val: Int32) -> Int32 {
        let lo = 0;
        let hi = ArraySize(arr) - 1;
        if hi < 0 { return 0; }
        while lo < hi {
            let mid = (lo + hi) / 2;
            if val > arr[mid] {
                lo = mid + 1;
            } else {
                hi = mid;
            }
        }
        return lo;
    }


    // Detect NPC's corporate affiliation from appearance name
    private static func DetectCorpoAffiliation(appearanceName: String) -> String {
        let lower = StrLower(appearanceName);
        if StrContains(lower, "arasaka") { return "Arasaka Corporation"; }
        if StrContains(lower, "militech") { return "Militech"; }
        if StrContains(lower, "kang_tao") || StrContains(lower, "kangtao") { return "Kang Tao"; }
        if StrContains(lower, "biotechnica") { return "Biotechnica"; }
        if StrContains(lower, "zetatech") { return "Zetatech"; }
        if StrContains(lower, "petrochem") { return "Petrochem"; }
        if StrContains(lower, "kiroshi") { return "Kiroshi Opticals"; }
        if StrContains(lower, "trauma_team") || StrContains(lower, "traumateam") { return "Trauma Team International"; }
        if StrContains(lower, "netwatch") { return "NetWatch"; }
        if StrContains(lower, "orbital") { return "Orbital Air"; }
        if StrContains(lower, "sovoil") { return "SovOil"; }
        if StrContains(lower, "dynalar") { return "Dynalar Technologies"; }
        return "";
    }

    private static func GetRandomCorpo(seed: Int32) -> String {
        let corpos: array<String>;
        
        ArrayPush(corpos, KdspTextCorpos.NIPPON_NETWORK());
        ArrayPush(corpos, KdspTextCorpos.DIVERSE_MEDIA());
        ArrayPush(corpos, KdspTextCorpos.WORLD_NEWS());
        ArrayPush(corpos, KdspTextCorpos.AKAROMI());
        ArrayPush(corpos, KdspTextCorpos.CONAG());
        ArrayPush(corpos, KdspTextCorpos.NN54());
        ArrayPush(corpos, KdspTextCorpos.PETROCHEM());
        ArrayPush(corpos, KdspTextCorpos.SOVOIL());
        ArrayPush(corpos, KdspTextCorpos.ARASAKA());
        ArrayPush(corpos, KdspTextCorpos.KANG_TAO());
        ArrayPush(corpos, KdspTextCorpos.MILITECH());
        ArrayPush(corpos, KdspTextCorpos.MITSU_SUGO());
        ArrayPush(corpos, KdspTextCorpos.SEG_ATARI());
        ArrayPush(corpos, KdspTextCorpos.TDS());
        ArrayPush(corpos, KdspTextCorpos.AHI());
        ArrayPush(corpos, KdspTextCorpos.EBM());
        ArrayPush(corpos, KdspTextCorpos.IEC());
        ArrayPush(corpos, KdspTextCorpos.MICROTECH());
        ArrayPush(corpos, KdspTextCorpos.ZETATECH());
        ArrayPush(corpos, KdspTextCorpos.ADREK_ROBO());
        ArrayPush(corpos, KdspTextCorpos.AKAGI_SYS());
        ArrayPush(corpos, KdspTextCorpos.BAKU_CHIPMASTERS());
        ArrayPush(corpos, KdspTextCorpos.BIOTECHNICA());
        ArrayPush(corpos, KdspTextCorpos.CYPHIRE());
        ArrayPush(corpos, KdspTextCorpos.DAKAI());
        ArrayPush(corpos, KdspTextCorpos.DYNALAR());
        ArrayPush(corpos, KdspTextCorpos.KENJIRI());
        ArrayPush(corpos, KdspTextCorpos.KIROSHI());
        ArrayPush(corpos, KdspTextCorpos.TTI());
        ArrayPush(corpos, KdspTextCorpos.MAF());
        ArrayPush(corpos, KdspTextCorpos.TOYOTA());
        ArrayPush(corpos, KdspTextCorpos.FUYUTSUKI());
        ArrayPush(corpos, KdspTextCorpos.ORBITAL_AIR());
        ArrayPush(corpos, KdspTextCorpos.WORLDSAT());
        ArrayPush(corpos, KdspTextCorpos.EUROBANK());
        ArrayPush(corpos, KdspTextCorpos.FUJIWARA());
        ArrayPush(corpos, KdspTextCorpos.INFOCOMP());
        ArrayPush(corpos, KdspTextCorpos.BAKENEKO());
        // Food & Agriculture
        ArrayPush(corpos, KdspTextCorpos.NOURISH_CORP());
        ArrayPush(corpos, KdspTextCorpos.ALL_FOODS());
        ArrayPush(corpos, KdspTextCorpos.SYNTHESIS_AGRICULTURE());
        // Pharmaceuticals
        ArrayPush(corpos, KdspTextCorpos.RAVEN_MICROCYBERNETICS());
        ArrayPush(corpos, KdspTextCorpos.BIODYNAMIK());
        ArrayPush(corpos, KdspTextCorpos.MEDTECH_PHARMA());
        // PMC / Security
        ArrayPush(corpos, KdspTextCorpos.LAZARUS_MILITARY());
        ArrayPush(corpos, KdspTextCorpos.IRON_GUARD_SEC());
        ArrayPush(corpos, KdspTextCorpos.BLACKWALL_SECURITIES());
        // Media & Comms
        ArrayPush(corpos, KdspTextCorpos.WNS());
        ArrayPush(corpos, KdspTextCorpos.EXCELSIOR());
        ArrayPush(corpos, KdspTextCorpos.NEON_ARCADE_MEDIA());
        // Transportation
        ArrayPush(corpos, KdspTextCorpos.DELAMAIN());
        ArrayPush(corpos, KdspTextCorpos.HERRERA());
        ArrayPush(corpos, KdspTextCorpos.ARCHER());
        ArrayPush(corpos, KdspTextCorpos.MAKIGAI());
        ArrayPush(corpos, KdspTextCorpos.RAYFIELD());
        // Utilities
        ArrayPush(corpos, KdspTextCorpos.NC_POWER());
        ArrayPush(corpos, KdspTextCorpos.HYDRO_NC());
        ArrayPush(corpos, KdspTextCorpos.DATAVAULT());
        // Cybernetics
        ArrayPush(corpos, KdspTextCorpos.TSUNAMI_DEFENSE());
        ArrayPush(corpos, KdspTextCorpos.ARASAKA_CYBERNETICS());
        ArrayPush(corpos, KdspTextCorpos.BUDGET_ARMS());
        ArrayPush(corpos, KdspTextCorpos.NOKOTA());

        let corpoVal = RandRange(seed + 41948, 0, ArraySize(corpos)-1);

        return corpos[corpoVal];
    }

    // ========== CHILD NPC DETECTION & HANDLING ==========

    // Detect if NPC is a child based on appearance name patterns
    private static func FindBodyModImplant(cyberware: ref<KdspCyberwareRegistryData>) -> String {
        let i: Int32 = 0;
        while i < ArraySize(cyberware.implants) {
            let implant = cyberware.implants[i];
            if Equals(implant.slot, "Body Modification") {
                return implant.name;
            };
            i += 1;
        };
        return "";
    }

    private static func GeneratePronouns(seed: Int32, gender: String) -> String {
        let roll: Int32 = RandRange(seed, 1, 100);
        
        // Most NPCs use pronouns matching their presentation
        // ~10% use they/them, ~5% use neopronouns or mixed
        if roll <= 85 {
            // Standard pronouns based on gender presentation
            if Equals(gender, "female") {
                return "she/her";
            } else {
                return "he/him";
            };
        } else if roll <= 95 {
            // They/them
            return "they/them";
        } else {
            // Neopronouns and variations (rare)
            let neoRoll: Int32 = RandRange(seed + 10, 1, 100);
            if neoRoll <= 20 {
                return "xe/xem";
            } else if neoRoll <= 40 {
                return "ze/zir";
            } else if neoRoll <= 60 {
                return "it/its";
            } else if neoRoll <= 75 {
                return "she/they";
            } else if neoRoll <= 90 {
                return "he/they";
            } else {
                return "any pronouns";
            };
        };
    }

    // NCPD-specific backstory generation
    private static func ExtractLastName(target: wref<NPCPuppet>) -> String {
        let record = target.GetRecord();
        if !IsDefined(record) {
            return "";
        }
        
        // Try method 1: GetTweakDBFullDisplayName (used by scanner)
        let fullName = target.GetTweakDBFullDisplayName(true);
        
        // Try method 2: GetLocalizedTextByKey if first method fails
        if Equals(fullName, "") || StrLen(fullName) < 3 {
            fullName = GetLocalizedTextByKey(record.FullDisplayName());
        }
        
        // Check if it's a generic name we should ignore
        if Equals(fullName, "") || StrLen(fullName) < 3 ||
           Equals(fullName, "None") || 
           Equals(fullName, "Enemy") ||
           Equals(fullName, "Citizen") ||
           Equals(fullName, "Civilian") ||
           Equals(fullName, "Gang Member") ||
           Equals(fullName, "Thug") ||
           StrContains(fullName, "LocKey") {
            return "";
        }
        
        // Find last space - everything after is the last name
        let lastSpace = -1;
        let i = 0;
        let len = StrLen(fullName);
        while i < len {
            if Equals(StrMid(fullName, i, 1), " ") {
                lastSpace = i;
            }
            i += 1;
        }
        
        if lastSpace > 0 && lastSpace < len - 1 {
            return StrMid(fullName, lastSpace + 1, len - lastSpace - 1);
        }
        
        // No space found or edge case - return empty (will use random)
        return "";
    }
}
