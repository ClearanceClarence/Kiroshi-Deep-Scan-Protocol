public class KdspBackstoryManager {

    // SEED VERSION - Increment this to regenerate all NPC backstories on next load
    // Change this value when making major content updates
    // Incremented for cross-system coherence fixes
    public static func GetSeedVersion() -> Int32 {
        return 4;
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
                if rejRoll == 0 { ArrayPush(medical.chronicConditions, "Implant rejection syndrome - active immunosuppressant therapy"); }
                else if rejRoll == 1 { ArrayPush(medical.chronicConditions, "Chronic implant rejection - tissue necrosis risk"); }
                else if rejRoll == 2 { ArrayPush(medical.chronicConditions, "Synthetic organ rejection - requires daily immunosuppressants"); }
                else if rejRoll == 3 { ArrayPush(medical.chronicConditions, "Cyberware rejection - inflammatory response ongoing"); }
                else { ArrayPush(medical.chronicConditions, "Implant incompatibility - scheduled for removal"); }
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
            else if swRoll1 == 1 { ArrayPush(criminal.arrests, "Unlicensed sex work (" + IntToString(swYear1) + ")"); }
            else if swRoll1 == 2 { ArrayPush(criminal.arrests, "Solicitation - vice sweep (" + IntToString(swYear1) + ")"); }
            else if swRoll1 == 3 { ArrayPush(criminal.arrests, "Prostitution - unlicensed (" + IntToString(swYear1) + ")"); }
            else { ArrayPush(criminal.arrests, "Solicitation - NCPD vice op (" + IntToString(swYear1) + ")"); }

            // Second arrest
            let swRoll2 = RandRange(seed + 9420, 0, 5);
            if swRoll2 == 0 { ArrayPush(criminal.arrests, "Loitering to solicit (" + IntToString(swYear2) + ")"); }
            else if swRoll2 == 1 { ArrayPush(criminal.arrests, "Public indecency (" + IntToString(swYear2) + ")"); }
            else if swRoll2 == 2 { ArrayPush(criminal.arrests, "No joytoy license (" + IntToString(swYear2) + ")"); }
            else if swRoll2 == 3 { ArrayPush(criminal.arrests, "Curfew violation - vice (" + IntToString(swYear2) + ")"); }
            else if swRoll2 == 4 { ArrayPush(criminal.arrests, "Solicitation - repeat (" + IntToString(swYear2) + ")"); }
            else { ArrayPush(criminal.arrests, "Vice code violation (" + IntToString(swYear2) + ")"); }

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
            if stiRoll1 == 0 { ArrayPush(medical.chronicConditions, "Gonorrhea - resistant strain"); }
            else if stiRoll1 == 1 { ArrayPush(medical.chronicConditions, "Chlamydia - recurrent"); }
            else if stiRoll1 == 2 { ArrayPush(medical.chronicConditions, "HPV - high risk strain"); }
            else if stiRoll1 == 3 { ArrayPush(medical.chronicConditions, "Herpes simplex - chronic"); }
            else if stiRoll1 == 4 { ArrayPush(medical.chronicConditions, "Syphilis - partially treated"); }
            else { ArrayPush(medical.chronicConditions, "Gonorrhea - recurrent"); }

            let stiRoll2 = RandRange(seed + 9520, 0, 5);
            if stiRoll2 == 0 { ArrayPush(medical.chronicConditions, "HIV-7 positive - managed"); }
            else if stiRoll2 == 1 { ArrayPush(medical.chronicConditions, "Hepatitis C - chronic"); }
            else if stiRoll2 == 2 { ArrayPush(medical.chronicConditions, "Trichomoniasis - persistent"); }
            else if stiRoll2 == 3 { ArrayPush(medical.chronicConditions, "Syphilis - latent stage"); }
            else if stiRoll2 == 4 { ArrayPush(medical.chronicConditions, "Hepatitis B - carrier"); }
            else { ArrayPush(medical.chronicConditions, "HPV - lesions present"); }

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
            if obeseRoll1 == 0 { ArrayPush(medical.chronicConditions, "Hypertension - Stage 2"); }
            else if obeseRoll1 == 1 { ArrayPush(medical.chronicConditions, "Type 2 Diabetes - insulin managed"); }
            else if obeseRoll1 == 2 { ArrayPush(medical.chronicConditions, "Coronary artery disease - stent placed"); }
            else if obeseRoll1 == 3 { ArrayPush(medical.chronicConditions, "Congestive heart failure - early stage"); }
            else if obeseRoll1 == 4 { ArrayPush(medical.chronicConditions, "Hypertension - medication resistant"); }
            else if obeseRoll1 == 5 { ArrayPush(medical.chronicConditions, "Type 2 Diabetes - poorly controlled"); }
            else if obeseRoll1 == 6 { ArrayPush(medical.chronicConditions, "Atherosclerosis - advanced plaque buildup"); }
            else { ArrayPush(medical.chronicConditions, "Chronic heart arrhythmia"); }

            // 70% chance of a secondary weight-related condition
            if RandRange(seed + 9610, 1, 100) <= 70 {
                let obeseRoll2 = RandRange(seed + 9620, 0, 9);
                if obeseRoll2 == 0 { ArrayPush(medical.chronicConditions, "Sleep apnea - severe, uses CPAP"); }
                else if obeseRoll2 == 1 { ArrayPush(medical.chronicConditions, "High cholesterol - statin therapy"); }
                else if obeseRoll2 == 2 { ArrayPush(medical.chronicConditions, "Fatty liver disease - non-alcoholic"); }
                else if obeseRoll2 == 3 { ArrayPush(medical.chronicConditions, "Chronic knee pain - weight-related"); }
                else if obeseRoll2 == 4 { ArrayPush(medical.chronicConditions, "Gout - recurring flare-ups"); }
                else if obeseRoll2 == 5 { ArrayPush(medical.chronicConditions, "Peripheral edema - lower extremities"); }
                else if obeseRoll2 == 6 { ArrayPush(medical.chronicConditions, "Elevated blood pressure - pre-hypertensive"); }
                else if obeseRoll2 == 7 { ArrayPush(medical.chronicConditions, "Gastroesophageal reflux - chronic"); }
                else if obeseRoll2 == 8 { ArrayPush(medical.chronicConditions, "Plantar fasciitis - bilateral"); }
                else { ArrayPush(medical.chronicConditions, "Insulin resistance - pre-diabetic"); }
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
            if freakMedRoll == 0 { ArrayPush(medical.chronicConditions, "Extreme subdermal implant scarring - chronic inflammation"); }
            else if freakMedRoll == 1 { ArrayPush(medical.chronicConditions, "Full-body tattoo ink toxicity - liver strain"); }
            else if freakMedRoll == 2 { ArrayPush(medical.chronicConditions, "Voluntary limb replacement complications - phantom pain"); }
            else if freakMedRoll == 3 { ArrayPush(medical.chronicConditions, "Experimental hormone therapy - unlicensed"); }
            else if freakMedRoll == 4 { ArrayPush(medical.chronicConditions, "Subdermal plate infection - recurring"); }
            else if freakMedRoll == 5 { ArrayPush(medical.chronicConditions, "Nerve splicing side effects - chronic tremors"); }
            else if freakMedRoll == 6 { ArrayPush(medical.chronicConditions, "Excessive chrome - immune system compromised"); }
            else if freakMedRoll == 7 { ArrayPush(medical.chronicConditions, "Black-market biosculpting - tissue degradation"); }
            else if freakMedRoll == 8 { ArrayPush(medical.chronicConditions, "Skeletal restructuring - chronic bone pain"); }
            else { ArrayPush(medical.chronicConditions, "Sensory mod overload syndrome - migraines"); }

            // 60% chance of a second extreme condition
            if RandRange(seed + 9710, 1, 100) <= 60 {
                let freakMedRoll2 = RandRange(seed + 9720, 0, 7);
                if freakMedRoll2 == 0 { ArrayPush(medical.chronicConditions, "Autoimmune response to foreign materials"); }
                else if freakMedRoll2 == 1 { ArrayPush(medical.chronicConditions, "Synthetic skin graft rejection - patchy necrosis"); }
                else if freakMedRoll2 == 2 { ArrayPush(medical.chronicConditions, "Optic nerve damage from cosmetic eye mods"); }
                else if freakMedRoll2 == 3 { ArrayPush(medical.chronicConditions, "Chronic pain from voluntary bone lengthening"); }
                else if freakMedRoll2 == 4 { ArrayPush(medical.chronicConditions, "Blood contamination from unlicensed chrome"); }
                else if freakMedRoll2 == 5 { ArrayPush(medical.chronicConditions, "Organ displacement from torso restructuring"); }
                else if freakMedRoll2 == 6 { ArrayPush(medical.chronicConditions, "Tooth replacement infection - jawbone erosion"); }
                else { ArrayPush(medical.chronicConditions, "Dermal pigment implant leakage"); }
            }

            // Freak-specific psych traits - body mod obsession, identity issues
            let freakPsychRoll = RandRange(seed + 9730, 0, 7);
            if freakPsychRoll == 0 { ArrayPush(psych.personalityTraits, "Body modification obsession"); }
            else if freakPsychRoll == 1 { ArrayPush(psych.personalityTraits, "Identity through chrome"); }
            else if freakPsychRoll == 2 { ArrayPush(psych.personalityTraits, "Extreme self-expression"); }
            else if freakPsychRoll == 3 { ArrayPush(psych.personalityTraits, "Rejects baseline humanity"); }
            else if freakPsychRoll == 4 { ArrayPush(psych.personalityTraits, "Transhumanist ideology"); }
            else if freakPsychRoll == 5 { ArrayPush(psych.personalityTraits, "Pain tolerance - abnormally high"); }
            else if freakPsychRoll == 6 { ArrayPush(psych.personalityTraits, "Sensation-seeking behavior"); }
            else { ArrayPush(psych.personalityTraits, "Body dysmorphia - perpetual modification"); }

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
            if nbMedRoll == 0 { ArrayPush(medical.chronicConditions, "Hormone replacement therapy - monitored"); }
            else if nbMedRoll == 1 { ArrayPush(medical.chronicConditions, "Biosculpting recovery - ongoing maintenance"); }
            else if nbMedRoll == 2 { ArrayPush(medical.chronicConditions, "Gender-affirming cyberware integration - stable"); }
            else if nbMedRoll == 3 { ArrayPush(medical.chronicConditions, "Hormone implant - quarterly replacement"); }
            else if nbMedRoll == 4 { ArrayPush(medical.chronicConditions, "Body modification therapy - endocrine monitoring"); }
            else if nbMedRoll == 5 { ArrayPush(medical.chronicConditions, "Synthetic hormone regulator - implanted"); }
            else if nbMedRoll == 6 { ArrayPush(medical.chronicConditions, "Vocal cord modification - healed"); }
            else if nbMedRoll == 7 { ArrayPush(medical.chronicConditions, "Biosculpting suite - full integration"); }
            else if nbMedRoll == 8 { ArrayPush(medical.chronicConditions, "Gender-neutral hormone baseline - maintained"); }
            else { ArrayPush(medical.chronicConditions, "Body reconfiguration therapy - complete"); }

            // Psych: identity-related context (not pathologized - just noted)
            let nbPsychRoll = RandRange(seed + 9810, 0, 7);
            if nbPsychRoll == 0 { ArrayPush(psych.personalityTraits, "Strong sense of identity"); }
            else if nbPsychRoll == 1 { ArrayPush(psych.personalityTraits, "Self-defined identity"); }
            else if nbPsychRoll == 2 { ArrayPush(psych.personalityTraits, "Body autonomy advocate"); }
            else if nbPsychRoll == 3 { ArrayPush(psych.personalityTraits, "Gender non-conforming - self-assured"); }
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
                backstoryUI.earlyLife = "Prior service: " + barghestData.formerAffiliation + ". " + IntToString(barghestData.yearsService) + " years military experience.";
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = "Joined Barghest " + IntToString(barghestData.yearsBarghest) + " years ago. Combat role: " + barghestData.combatRole + ".";
        } else if isGangMember {
            // Gang members get gang-specific detailed backstories
            let gangData = KdspGangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);
            backstoryUI.background = gangData.background;
            if density >= 2 {
                backstoryUI.earlyLife = IntToString(gangData.yearsActive) + " years with " + gangData.gangName + ". Role: " + gangData.role + ".";
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
            backstoryUI.criminalRecord = "Status: " + criminal.status;
            // Show arrests on medium/high density
            if density >= 2 && ArraySize(criminal.arrests) > 0 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | Arrests: " + criminal.arrests[0];
                if density >= 3 && ArraySize(criminal.arrests) > 1 {
                    backstoryUI.criminalRecord = backstoryUI.criminalRecord + ", " + criminal.arrests[1];
                };
            };
            if !Equals(criminal.warrantStatus, "NONE") && !Equals(criminal.warrantStatus, "CLEARED") {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | WARRANT: " + criminal.warrantStatus;
            };
            // NCPD classification on medium/high
            if density >= 2 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | NCPD: " + criminal.ncpdClassification;
            };
        } else {
            backstoryUI.criminalRecord = "";
        };

        // Cyberware Registry Section - TT gets military-grade profile
        if isTraumaTeam {
            backstoryUI.cyberwareStatus = KdspTraumaTeamGenerator.GenerateTTCyberware(seed + 4100);
        } else if density >= 2 && Equals(gangAffiliation, "NONE") && cyberware.totalImplants > 0 {
            backstoryUI.cyberwareStatus = "Implants: " + IntToString(cyberware.totalImplants) + " | Status: " + cyberware.cyberpsychosisStatus;
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
            backstoryUI.financialStatus = "ID: " + financial.ncID + " | Credit Rating: " + financial.creditTier + " | Income: " + financial.incomeLevel;
            if financial.hasDebt {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | DEBT: " + financial.debtStatus;
            };
            // Always show Corp for corpo archetypes, otherwise high density + corporateAsset
            let isCorpoArchetype = Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE");
            if isCorpoArchetype || (density >= 3 && financial.corporateAsset) {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | Corp: " + financial.employer;
            };
        } else {
            backstoryUI.financialStatus = "";
        };

        // Medical Status Section - TT gets combat medical readiness
        if isTraumaTeam {
            backstoryUI.medicalStatus = KdspTraumaTeamGenerator.GenerateTTMedical(seed + 4300);
        } else if density >= 2 && Equals(gangAffiliation, "NONE") && !isNCPD {
            // Blood type always shown first
            backstoryUI.medicalStatus = "Blood: " + medical.bloodType;
            
            if ArraySize(medical.chronicConditions) > 0 || ArraySize(medical.pastInjuries) > 0 {
                if ArraySize(medical.chronicConditions) > 0 {
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Conditions: " + medical.chronicConditions[0];
                    // Extra conditions on high density
                    if density >= 3 && ArraySize(medical.chronicConditions) > 1 {
                        backstoryUI.medicalStatus = backstoryUI.medicalStatus + ", " + medical.chronicConditions[1];
                    };
                };
                // Injuries on high density only
                if density >= 3 && ArraySize(medical.pastInjuries) > 0 {
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Injuries: " + medical.pastInjuries[0];
                };
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Health: " + medical.healthRating;
            } else {
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | No significant conditions | Health: " + medical.healthRating;
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
            backstoryUI.threatAssessment = "HOSTILE | Military trained | " + barghestData.combatRole;
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Confirmed kills: " + IntToString(barghestData.confirmedKills);
            };
            if density >= 3 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Hansen loyalist";
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
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Bodies: " + IntToString(gangData.bodyCount);
                };
            };
            if density >= 3 {
                if ArraySize(gangData.distinguishingMarks) > 0 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Marks: " + gangData.distinguishingMarks[0];
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
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Unstable";
                };
                if psych.hasAddictions {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Substance issues";
                };
                if psych.hasVendetta {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Grudge-holder";
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
            backstoryUI.gangAffiliation = gangData.gangName + " | " + gangData.role + " | " + IntToString(gangData.yearsActive) + " yrs active";
            
            // Extra details on medium/high density
            if density >= 2 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Territory: " + gangData.territory;
                
                // Gang-specific stats
                if Equals(gangAffiliation, "MAELSTROM") && gangData.chromePercentage > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Chrome: " + IntToString(gangData.chromePercentage) + "%";
                };
                if Equals(gangAffiliation, "ANIMALS") && gangData.fightWins > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Fight Record: " + IntToString(gangData.fightWins) + "W-" + IntToString(gangData.fightLosses) + "L";
                };
                if Equals(gangAffiliation, "VOODOO_BOYS") && gangData.systemsCompromised > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Systems Hit: " + IntToString(gangData.systemsCompromised);
                };
                if Equals(gangAffiliation, "SCAVENGERS") && gangData.organsHarvested > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Harvests: " + IntToString(gangData.organsHarvested);
                };
                if Equals(gangAffiliation, "WRAITHS") && gangData.successfulRaids > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Raids: " + IntToString(gangData.successfulRaids);
                };
                if Equals(gangAffiliation, "ALDECALDOS") && gangData.convoyRuns > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Convoy Runs: " + IntToString(gangData.convoyRuns);
                };
                if Equals(gangAffiliation, "MOXES") && gangData.peopleProtected > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Protected: " + IntToString(gangData.peopleProtected);
                };
                if Equals(gangAffiliation, "6TH_STREET") && NotEquals(gangData.priorService, "") {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Prior: " + gangData.priorService;
                };
                
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Loyalty: " + gangData.loyaltyRating;
                if density >= 3 && gangData.bodyCount > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Body Count: " + IntToString(gangData.bodyCount);
                };
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Status: " + gangData.status;
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
            
            backstoryUI.ncpdOfficer = displayName + " | Badge: " + ncpdData.badge;
            // Extra NCPD details on medium/high density
            if density >= 2 {
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + ncpdData.unit;
                if density >= 3 && StrLen(ncpdData.specialization) > 0 {
                    backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Spec: " + ncpdData.specialization;
                };
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | District: " + ncpdData.assignedDistrict;
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + IntToString(ncpdData.yearsOfService) + " yrs service";
                if density >= 3 && ncpdData.confirmedNeutralizations > 0 {
                    backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Neutralizations: " + IntToString(ncpdData.confirmedNeutralizations);
                };
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Status: " + ncpdData.dutyStatus;
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
            
            backstoryUI.gangAffiliation = "Barghest Militia | " + displayName + " | MOS: " + barghestData.mos;
            // Extra Barghest details on medium/high density
            if density >= 2 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Prior: " + barghestData.formerAffiliation;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Sector: " + barghestData.assignedSector;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | " + IntToString(barghestData.yearsBarghest) + " yrs Barghest";
                if density >= 3 && barghestData.confirmedKills > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Confirmed: " + IntToString(barghestData.confirmedKills);
                };
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Loyalty: " + barghestData.loyaltyRating;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Status: " + barghestData.dutyStatus;
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
                    else if clientTypeRoll == 1 { client.relationship = "Regular - flagged"; }
                    else if clientTypeRoll == 2 { client.relationship = "Client - NCPD flagged"; }
                    else if clientTypeRoll == 3 { client.relationship = "Client - corpo"; }
                    else if clientTypeRoll == 4 { client.relationship = "Repeat - violent"; }
                    else if clientTypeRoll == 5 { client.relationship = "Client - surveilled"; }
                    else if clientTypeRoll == 6 { client.relationship = "Client - warrant"; }
                    else if clientTypeRoll == 7 { client.relationship = "Regular - married"; }
                    else if clientTypeRoll == 8 { client.relationship = "Client - via fixer"; }
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
                else { relations.currentRelationshipStatus = "In a relationship"; }
            }

            backstoryUI.relationships = "";
            let compactRel = KdspSettings.CompactRelationshipsEnabled();
            
            // Status and dependents
            backstoryUI.relationships = relations.currentRelationshipStatus;
            if relations.dependents > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Dependents: " + IntToString(relations.dependents);
            };
            
            // Emergency contact - full mode, high density only
            if !compactRel && density >= 3 && !Equals(relations.emergencyContact, "NONE ON FILE") {
                backstoryUI.relationships = backstoryUI.relationships + " | Emergency: " + relations.emergencyContact;
            };
            
            // Family members
            if ArraySize(relations.familyMembers) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Family: ";
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
                backstoryUI.relationships = backstoryUI.relationships + " | Associates: ";
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
                backstoryUI.relationships = backstoryUI.relationships + " | Contacts: ";
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
                backstoryUI.relationships = backstoryUI.relationships + " | History: " + relations.romanticHistory;
            };
            
            // Social network size - full mode, high density only
            if !compactRel && density >= 3 {
                backstoryUI.relationships = backstoryUI.relationships + " | Network: " + relations.socialNetworkSize;
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
        return KdspBackstoryManager.FillReplacements(seed, eventText, corpoAffiliation);
    }

    private static func FillReplacements(seed: Int32, text: String, corpoAffiliation: String) -> String {
        let ret = text;
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
        return ret;
    }

    private static func getCorrespondingIndex(arr: array<Int32>, val: Int32) -> Int32 {
        let acc = 0;
        let i = 0;
        while val > arr[i] {
            i += 1;
        }
        return i;
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
