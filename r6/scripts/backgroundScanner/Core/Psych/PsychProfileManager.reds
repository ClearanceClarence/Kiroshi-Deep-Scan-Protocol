// Psychological Assessment Generation System
public class KdspPsychProfileManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String, criminalRecord: ref<KdspCriminalRecordData>, cyberware: ref<KdspCyberwareRegistryData>) -> ref<KdspPsychProfileData> {
        return KdspPsychProfileManager.GenerateCoherent(seed, archetype, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> ref<KdspPsychProfileData> {
        let profile: ref<KdspPsychProfileData> = new KdspPsychProfileData();
        let density = KdspSettings.GetDataDensity();

        // Threat assessment - always shown
        profile.threatLevel = KdspPsychProfileManager.CalculateThreatLevelCoherent(seed, archetype, coherence);
        profile.threatColor = KdspPsychProfileManager.GetThreatColor(profile.threatLevel);
        profile.threatDescription = KdspPsychProfileManager.GetThreatDescription(profile.threatLevel, archetype);

        // Combat assessment - only on medium/high
        if density >= 2 {
            profile.combatTraining = KdspPsychProfileManager.AssessCombatTrainingCoherent(seed + 100, archetype, coherence);
            profile.armedLikelihood = KdspPsychProfileManager.AssessArmedLikelihoodCoherent(seed + 110, archetype, coherence);
            profile.approachRecommendation = KdspPsychProfileManager.GetApproachRecommendation(profile.threatLevel, profile.armedLikelihood);
        }

        // Personality traits - limited by density
        let traitCount = RandRange(seed + 200, 2, 5);
        traitCount = KdspSettings.GetMaxListItems(traitCount);
        
        let i = 0;
        while i < traitCount {
            ArrayPush(profile.personalityTraits, KdspPsychProfileManager.GeneratePersonalityTraitCoherent(seed + 210 + (i * 31), archetype, coherence));
            i += 1;
        }

        // Behavioral flags - limited by density
        let flagCount = RandRange(seed + 300, 0, 3);
        if IsDefined(coherence) && (coherence.hasViolentPast || coherence.hasSubstanceIssues || coherence.hasTrauma) {
            flagCount += 1; // More flags for troubled individuals
        }
        flagCount = KdspSettings.GetMaxListItems(flagCount);
        
        i = 0;
        while i < flagCount {
            ArrayPush(profile.behavioralFlags, KdspPsychProfileManager.GenerateBehavioralFlagCoherent(seed + 310 + (i * 37), archetype, coherence));
            i += 1;
        }

        // Addictions - USE COHERENCE for consistency
        if IsDefined(coherence) && coherence.hasSubstanceIssues {
            profile.hasAddictions = true;
            // Generate addiction matching the substance type
            ArrayPush(profile.addictions, KdspPsychProfileManager.GenerateAddictionFromSubstance(seed + 420, coherence.substanceType));
            // Maybe add secondary addiction - only on high density
            if density >= 3 && RandRange(seed + 421, 1, 100) <= 30 {
                ArrayPush(profile.addictions, KdspPsychProfileManager.GenerateAddiction(seed + 422, archetype));
            }
        } else {
            profile.hasAddictions = KdspPsychProfileManager.HasAddictions(seed + 400, archetype);
            if profile.hasAddictions {
                let addictionCount = RandRange(seed + 410, 1, 3);
                addictionCount = KdspSettings.GetMaxListItems(addictionCount);
                i = 0;
                while i < addictionCount {
                    ArrayPush(profile.addictions, KdspPsychProfileManager.GenerateAddiction(seed + 420 + (i * 43), archetype));
                    i += 1;
                }
            }
        }

        // Trauma history - USE COHERENCE for consistency
        if IsDefined(coherence) && coherence.hasTrauma {
            // Generate trauma matching the type
            ArrayPush(profile.traumaEvents, KdspPsychProfileManager.GenerateTraumaFromType(seed + 520, coherence.traumaType));
            // Maybe add secondary trauma - only on high density
            if density >= 3 && RandRange(seed + 521, 1, 100) <= 40 {
                ArrayPush(profile.traumaEvents, KdspPsychProfileManager.GenerateTraumaEvent(seed + 522, archetype));
            }
        } else {
            let traumaChance = KdspPsychProfileManager.GetTraumaChance(archetype);
            if RandRange(seed + 500, 1, 100) <= traumaChance {
                let traumaCount = RandRange(seed + 510, 1, 3);
                traumaCount = KdspSettings.GetMaxListItems(traumaCount);
                i = 0;
                while i < traumaCount {
                    ArrayPush(profile.traumaEvents, KdspPsychProfileManager.GenerateTraumaEvent(seed + 520 + (i * 47), archetype));
                    i += 1;
                }
            }
        }

        // Psychological evaluation
        profile.psychEvaluation = KdspPsychProfileManager.GeneratePsychEvaluationCoherent(seed + 600, archetype, coherence);
        profile.lastEvalDate = KdspPsychProfileManager.GenerateLastEvalDate(seed + 610, archetype);

        // Stability assessment - influenced by coherence
        profile.stabilityScore = KdspPsychProfileManager.CalculateStabilityScoreCoherent(profile, coherence);
        profile.stabilityRating = KdspPsychProfileManager.GetStabilityRating(profile.stabilityScore);

        // Known vendettas - more likely with violent past
        if KdspPsychProfileManager.HasVendettaCoherent(seed + 700, archetype, coherence) {
            profile.hasVendetta = true;
            profile.vendettaTarget = KdspPsychProfileManager.GenerateVendettaTarget(seed + 710, archetype);
        }

        // Ideology / beliefs
        profile.ideologyFlags = KdspPsychProfileManager.GenerateIdeologyFlags(seed + 800, archetype);

        // Risk factors
        profile.riskFactors = KdspPsychProfileManager.GenerateRiskFactorsCoherent(seed + 900, archetype, coherence);

        // Recommendation
        profile.handlingRecommendation = KdspPsychProfileManager.GenerateHandlingRecommendation(profile);

        return profile;
    }

    // Threat level influenced by violent past
    private static func CalculateThreatLevelCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let base = KdspPsychProfileManager.CalculateThreatLevelBase(seed, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { base += RandRange(seed + 5, 15, 30); }
            if Equals(coherence.lifeTheme, "CRIMINAL") { base += RandRange(seed + 6, 10, 20); }
            if coherence.hasSubstanceIssues { base += RandRange(seed + 7, 5, 15); } // Unpredictability
        }
        
        if base > 100 { base = 100; }
        return base;
    }

    // Combat training influenced by violent history
    private static func AssessCombatTrainingCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && coherence.hasViolentPast {
            if Equals(coherence.violenceType, "gang") {
                let training: array<String>;
                ArrayPush(training, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S0"));
                ArrayPush(training, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S1"));
                ArrayPush(training, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T0"));
                return training[RandRange(seed, 0, ArraySize(training) - 1)];
            }
        }
        return KdspPsychProfileManager.AssessCombatTraining(seed, archetype);
    }

    // Armed likelihood influenced by violence
    private static func AssessArmedLikelihoodCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && coherence.hasViolentPast {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "HIGH"; }
            if roll <= 80 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V10"); }
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V11");
        }
        return KdspPsychProfileManager.AssessArmedLikelihood(seed, archetype, null);
    }

    // Personality traits influenced by life theme
    private static func GeneratePersonalityTraitCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && RandRange(seed + 50, 1, 100) <= 40 {
            if Equals(coherence.lifeTheme, "FALLING") {
                let traits: array<String>;
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T1"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T2"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T3"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T4"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T5"));
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
            if Equals(coherence.lifeTheme, "STRUGGLING") {
                let traits: array<String>;
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T6"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T7"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T8"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T9"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T10"));
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
            if Equals(coherence.lifeTheme, "CLIMBING") {
                let traits: array<String>;
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T11"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T12"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T13"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T14"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T15"));
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
            if coherence.hasTrauma {
                let traits: array<String>;
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T16"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T17"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T18"));
                ArrayPush(traits, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T19"));
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
        }
        return KdspPsychProfileManager.GeneratePersonalityTrait(seed, archetype);
    }

    // Behavioral flags coherent with issues
    private static func GenerateBehavioralFlagCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && RandRange(seed + 50, 1, 100) <= 50 {
            if coherence.hasViolentPast {
                let flags: array<String>;
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T20"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T21"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T22"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V0"));
                return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
            }
            if coherence.hasSubstanceIssues {
                let flags: array<String>;
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T24"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T25"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V1"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T27"));
                return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
            }
            if coherence.hasTrauma {
                let flags: array<String>;
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T28"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T29"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T30"));
                ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T31"));
                return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
            }
        }
        return KdspPsychProfileManager.GenerateBehavioralFlag(seed, archetype);
    }

    // Generate addiction matching substance type
    private static func GenerateAddictionFromSubstance(seed: Int32, substanceType: String) -> String {
        if Equals(substanceType, "alcohol") || Equals(substanceType, GetLocalizedTextByKey(n"Kdsp-Shared-C14")) {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T32");
        }
        if StrContains(StrLower(substanceType), StrLower(GetLocalizedTextByKey(n"Kdsp-CoherenceManag-U1"))) {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S2");
        }
        if StrContains(StrLower(substanceType), StrLower(GetLocalizedTextByKey(n"Kdsp-CoherenceManag-U2"))) {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S3");
        }
        if StrContains(StrLower(substanceType), "glitter") {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T33");
        }
        if StrContains(StrLower(substanceType), "stim") {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T34");
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S4") + substanceType + ")";
    }

    // Generate trauma matching type
    private static func GenerateTraumaFromType(seed: Int32, traumaType: String) -> String {
        let year = RandRange(seed, 2060, 2076);
        
        if Equals(traumaType, "violence") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S5"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T35"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T36"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S6"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S7"));
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "accident") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S8"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S9"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S10"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S11"));
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "loss") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S12"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S13"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T37"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T38"));
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "war") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S14"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S15"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T39"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S16"));
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "abandonment") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T40"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S17"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T41"));
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S18") + IntToString(year) + ")";
    }

    // Psych evaluation coherent with issues
    private static func GeneratePsychEvaluationCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) {
            if coherence.hasSubstanceIssues && coherence.hasTrauma {
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S19");
            }
            if coherence.hasSubstanceIssues {
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S20");
            }
            if coherence.hasTrauma {
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S21");
            }
            if coherence.hasViolentPast && Equals(coherence.lifeTheme, "FALLING") {
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S22");
            }
            if Equals(coherence.lifeTheme, "FALLING") {
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S23");
            }
        }
        return KdspPsychProfileManager.GeneratePsychEvaluation(seed, archetype, null);
    }

    // Stability score influenced by coherence
    private static func CalculateStabilityScoreCoherent(profile: ref<KdspPsychProfileData>, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let score = 70; // Base score
        
        // Deductions from profile
        score -= ArraySize(profile.traumaEvents) * 8;
        score -= ArraySize(profile.behavioralFlags) * 5;
        if profile.hasAddictions { score -= 15; }
        if profile.hasVendetta { score -= 10; }
        
        // Coherence deductions
        if IsDefined(coherence) {
            if coherence.hasTrauma { score -= 10; }
            if coherence.hasViolentPast { score -= 8; }
            if coherence.hasSubstanceIssues { score -= 12; }
            if Equals(coherence.lifeTheme, "FALLING") { score -= 15; }
            if Equals(coherence.lifeTheme, "STRUGGLING") { score -= 8; }
            if Equals(coherence.lifeTheme, "STABLE") { score += 10; }
        }
        
        if score < 0 { score = 0; }
        if score > 100 { score = 100; }
        return score;
    }

    // Vendetta more likely with violent past
    private static func HasVendettaCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Bool {
        let chance = 15;
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { chance += 20; }
            if coherence.hasTrauma && Equals(coherence.traumaType, "loss") { chance += 25; }
            if Equals(coherence.lifeTheme, "CRIMINAL") { chance += 15; }
        }
        
        if Equals(archetype, "GANGER") { chance += 30; }
        
        return RandRange(seed, 1, 100) <= chance;
    }

    // Risk factors coherent with issues
    private static func GenerateRiskFactorsCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> array<String> {
        let factors: array<String>;
        
        if IsDefined(coherence) {
            if coherence.hasSubstanceIssues {
                ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S24"));
            }
            if coherence.hasViolentPast {
                ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S25"));
            }
            if coherence.hasTrauma {
                ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T42"));
            }
            if Equals(coherence.lifeTheme, "FALLING") {
                ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-Shared-C58"));
                ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T43"));
            }
            if coherence.isInDebt {
                ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T44"));
            }
        }
        
        // Add some random factors
        if ArraySize(factors) < 2 {
            let possibleFactors: array<String>;
            ArrayPush(possibleFactors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S26"));
            ArrayPush(possibleFactors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S27"));
            ArrayPush(possibleFactors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T45"));
            ArrayPush(possibleFactors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T46"));
            
            let count = RandRange(seed, 1, 3);
            let i = 0;
            while i < count && ArraySize(factors) < 4 {
                ArrayPush(factors, possibleFactors[RandRange(seed + i, 0, ArraySize(possibleFactors) - 1)]);
                i += 1;
            }
        }
        
        return factors;
    }

    // Base threat level from archetype only
    private static func CalculateThreatLevelBase(seed: Int32, archetype: String) -> Int32 {
        let base = 10; // Lower base

        // Archetype modifiers - civilians should be low threat
        if Equals(archetype, "GANGER") { base += 35; }
        else if Equals(archetype, "LOWLIFE") { base += 15; }
        else if Equals(archetype, "NOMAD") { base += 10; }
        else if Equals(archetype, "JUNKIE") { base += 5; }
        else if Equals(archetype, "CORPO_MANAGER") { base -= 5; }
        else if Equals(archetype, "CORPO_DRONE") { base -= 5; }
        else if Equals(archetype, "YUPPIE") { base -= 5; }
        else if Equals(archetype, "CIVVIE") { base -= 5; }
        else { base -= 3; } // Default civilians are not threats

        // Add small random variance
        base += RandRange(seed, -5, 10);
        
        if base < 0 { base = 0; }
        if base > 100 { base = 100; }
        return base;
    }

    private static func CalculateThreatLevel(seed: Int32, archetype: String, criminal: ref<KdspCriminalRecordData>, cyberware: ref<KdspCyberwareRegistryData>) -> Int32 {
        let base = KdspPsychProfileManager.CalculateThreatLevelBase(seed, archetype);

        // Criminal record - reduced impact
        if IsDefined(criminal) && criminal.hasRecord {
            base += ArraySize(criminal.arrests) * 2;
            if !Equals(criminal.warrantStatus, "NONE") && !Equals(criminal.warrantStatus, "CLEARED") { 
                if StrContains(criminal.warrantStatus, "VIOLENT") { base += 15; }
                else { base += 8; }
            }
            if StrContains(criminal.ncpdClassification, "HIGH") { base += 15; }
            else if StrContains(criminal.ncpdClassification, "ELEVATED") { base += 8; }
        }

        // Cyberware - only combat implants matter
        if IsDefined(cyberware) {
            let i = 0;
            while i < ArraySize(cyberware.implants) {
                let implant = cyberware.implants[i];
                if StrContains(implant.name, "Mantis") || StrContains(implant.name, "Gorilla") ||
                   StrContains(implant.name, "Projectile") || StrContains(implant.name, "Monowire") {
                    base += 10;
                }
                if StrContains(implant.name, "Sandevistan") || StrContains(implant.name, "Kerenzikov") {
                    base += 5;
                }
                if StrContains(implant.name, "Berserk") { base += 15; }
                i += 1;
            }

            // Cyberpsychosis risk - only high risk matters
            if cyberware.cyberpsychosisRisk >= 70 { base += 20; }
            else if cyberware.cyberpsychosisRisk >= 50 { base += 10; }
        }

        // Balanced randomness
        base += RandRange(seed, -8, 8);

        if base < 0 { base = 0; }
        if base > 100 { base = 100; }

        return base;
    }

    private static func GetThreatColor(threatLevel: Int32) -> String {
        if threatLevel >= 80 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V2"); }
        if threatLevel >= 60 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V14"); }
        if threatLevel >= 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V2"); }
        if threatLevel >= 20 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V0"); }
        return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V16");
    }

    private static func GetThreatDescription(threatLevel: Int32, archetype: String) -> String {
        if threatLevel >= 90 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T48"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T49"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T50"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T51");
        }
        if threatLevel >= 80 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T52"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T53"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T54"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T55");
        }
        if threatLevel >= 60 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T56"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T57"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T58"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T59");
        }
        if threatLevel >= 40 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T60"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T61"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T62"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T63");
        }
        if threatLevel >= 20 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T64"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T65"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T66"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T67");
        }
        let i = RandRange(threatLevel, 0, 3);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T68"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T69"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T70"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T71");
    }

    private static func AssessCombatTraining(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S28"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S29"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T72"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S30"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S31"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S32"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S33"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S34"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S35"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S36");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T72"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T73"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S37"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T74"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T75"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S38"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S39");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S40"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S41"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S42"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S43"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S44"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S45"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S46"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T76"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T77"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T78"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S47"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S48"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S49"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S50"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S51");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T79"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S52"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T80"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S53"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S54"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T81"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T82"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S55"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S56"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S57"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S58"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S59");
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S60"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T72"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T83"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S61"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T84"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T85"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S62"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T86"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T87"); }
            return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14");
        }
        
        // General/Civilian (15)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T72"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T73"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T74"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S63"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S64"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T88"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S65"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S66"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S67"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S68"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S69"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S70"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S71"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S72");
    }

    private static func AssessArmedLikelihood(seed: Int32, archetype: String, criminal: ref<KdspCriminalRecordData>) -> String {
        let likelihood: Int32 = 30;

        if Equals(archetype, "GANGER") { likelihood = 90; }
        else if Equals(archetype, "NOMAD") { likelihood = 75; }
        else if Equals(archetype, "LOWLIFE") { likelihood = 60; }
        else if Equals(archetype, "CORPO_MANAGER") { likelihood = 20; }
        else if Equals(archetype, "YUPPIE") { likelihood = 35; }
        else if Equals(archetype, "HOMELESS") { likelihood = 40; }

        if criminal.hasRecord {
            if StrContains(criminal.warrantStatus, "VIOLENT") { likelihood += 30; }
            let i = 0;
            while i < ArraySize(criminal.arrests) {
                if StrContains(criminal.arrests[i], "weapon") { likelihood += 15; }
                i += 1;
            }
        }

        if likelihood >= 90 { return GetLocalizedTextByKey(n"Kdsp-Shared-C59"); }
        if likelihood >= 70 { return GetLocalizedTextByKey(n"Kdsp-Shared-C60"); }
        if likelihood >= 50 { return "LIKELY"; }
        if likelihood >= 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V3"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V4");
    }

    private static func GetApproachRecommendation(threatLevel: Int32, armedLikelihood: String) -> String {
        if threatLevel >= 80 || Equals(armedLikelihood, GetLocalizedTextByKey(n"Kdsp-Shared-C59")) {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T91");
        }
        if threatLevel >= 60 || Equals(armedLikelihood, GetLocalizedTextByKey(n"Kdsp-Shared-C60")) {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T92");
        }
        if threatLevel >= 40 || Equals(armedLikelihood, "LIKELY") {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T93");
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T94");
    }

    private static func GeneratePersonalityTrait(seed: Int32, archetype: String) -> String {
        // Archetype-weighted selection
        if Equals(archetype, "GANGER") {
            if RandRange(seed + 5, 1, 100) <= 60 {
                // Gang-specific negative traits (15)
                let i = RandRange(seed, 0, 14);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S73"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T95"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S51"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S74"); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T96"); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T97"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T98"); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T99"); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T100"); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T101"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T102"); }
                if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S75"); }
                if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T103"); }
                if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T104"); }
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T105");
            }
        }
        if Equals(archetype, "CORPO_MANAGER") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                // Corpo-specific traits (15)
                let i = RandRange(seed, 0, 14);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T106"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T107"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T108"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T109"); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T110"); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T111"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T112"); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T14"); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T113"); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S76"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S77"); }
                if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T114"); }
                if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S78"); }
                if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T115"); }
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T116");
            }
        }
        if Equals(archetype, "JUNKIE") {
            if RandRange(seed + 5, 1, 100) <= 70 {
                // Junkie-specific traits (12)
                let i = RandRange(seed, 0, 11);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T6"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T117"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S79"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T118"); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T119"); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S80"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T18"); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S81"); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S82"); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S83"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S84"); }
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T120");
            }
        }
        if Equals(archetype, "NOMAD") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                // Nomad-specific traits (12)
                let i = RandRange(seed, 0, 11);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T121"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T122"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S85"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T123"); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T124"); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S86"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T125"); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T126"); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T127"); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T128"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T129"); }
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T130");
            }
        }
        
        // General traits pool (60)
        let i = RandRange(seed, 0, 59);
        
        // Neutral traits (0-19)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T131"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T132"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T133"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T134"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T135"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T136"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T137"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T138"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T139"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T140"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T141"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T142"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T143"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T144"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T13"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T145"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T146"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T147"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T148"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T149"); }
        
        // Positive traits (20-39)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T150"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T124"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S78"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T151"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T152"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T153"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T154"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T155"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T156"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T8"); }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T157"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T158"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T159"); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T160"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T161"); }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T162"); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T163"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T164"); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T165"); }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T166"); }
        
        // Negative traits (40-59)
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S73"); }
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T103"); }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S87"); }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T118"); }
        if i == 44 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T104"); }
        if i == 45 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S88"); }
        if i == 46 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T119"); }
        if i == 47 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T167"); }
        if i == 48 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T105"); }
        if i == 49 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T168"); }
        if i == 50 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T169"); }
        if i == 51 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T170"); }
        if i == 52 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T171"); }
        if i == 53 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T172"); }
        if i == 54 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T173"); }
        if i == 55 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T174"); }
        if i == 56 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T5"); }
        if i == 57 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T175"); }
        if i == 58 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T176"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T10");
    }

    private static func GenerateBehavioralFlag(seed: Int32, archetype: String) -> String {
        // Archetype-specific flags
        if Equals(archetype, "GANGER") && RandRange(seed + 50, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T177"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T178"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T179"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T180"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T181"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T182"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T183"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T184"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T185"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T186");
        }
        
        if Equals(archetype, "CORPO_MANAGER") && RandRange(seed + 50, 1, 100) <= 40 {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T187"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T188"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T189"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T190"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T191"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T192"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T193"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T194");
        }
        
        // General flags pool (45)
        let i = RandRange(seed, 0, 44);
        
        // Violence-related (0-9)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S89"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S90"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S91"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S92"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S93"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S94"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S95"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S96"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S97"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T195"); }
        
        // Criminal associations (10-19)
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S98"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S99"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S100"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S101"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S102"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S103"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T196"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S104"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S105"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S106"); }
        
        // Behavioral patterns (20-29)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S107"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S108"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S109"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S110"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S111"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S112"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S113"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T197"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S114"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S14"); }
        
        // Psychological flags (30-39)
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S115"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T198"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T199"); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T200"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T201"); }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T202"); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S116"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S117"); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S118"); }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T203"); }
        
        // Risk indicators (40-44)
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T204"); }
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S119"); }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S120"); }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S121"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S122");
    }

    private static func HasAddictions(seed: Int32, archetype: String) -> Bool {
        let chance: Int32;

        if Equals(archetype, "JUNKIE") { chance = 100; }
        else if Equals(archetype, "HOMELESS") { chance = 50; }
        else if Equals(archetype, "GANGER") { chance = 40; }
        else if Equals(archetype, "LOWLIFE") { chance = 35; }
        else if Equals(archetype, "CORPO_DRONE") { chance = 25; }
        else if Equals(archetype, "CORPO_MANAGER") { chance = 20; }
        else { chance = 20; }

        return RandRange(seed, 1, 100) <= chance;
    }

    private static func GenerateAddiction(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "JUNKIE") {
            // Hard substances for junkies (15)
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S123"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S124"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T205"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T206"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S125"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T207"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S126"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S127"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S128"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S129"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S130"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S131"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T208"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S132"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S133");
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            // Corporate-appropriate addictions (12)
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S134"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T209"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S135"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T210"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S136"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T211"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T212"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T213"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T214"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T215"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T216"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T217");
        }
        
        if Equals(archetype, "GANGER") {
            // Gang-related substances (10)
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S137"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S138"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T218"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S139"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T219"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T220"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T221"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T222"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T223"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T224");
        }
        
        // General addictions pool (45)
        let i = RandRange(seed, 0, 44);
        
        // Alcohol (0-5)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T225"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T226"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S140"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S141"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S142"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S143"); }
        
        // Tobacco/Nicotine (6-8)
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T227"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T228"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T229"); }
        
        // Street drugs (9-19)
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T230"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CoherenceManag-T16"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CoherenceManag-T17"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T231"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T232"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T233"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T234"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T278"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T235"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T236"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S144"); }
        
        // Prescription (20-26)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S145"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T237"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T238"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T239"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S146"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S147"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S148"); }
        
        // Behavioral (27-37)
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T240"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S149"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T241"); }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T242"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S150"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T243"); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T215"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T244"); }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T245"); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S151"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T246"); }
        
        // Other (38-44)
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T212"); }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T247"); }
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T248"); }
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T249"); }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T250"); }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T251"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S152");
    }

    private static func GetTraumaChance(archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return 75; }
        if Equals(archetype, "NOMAD") { return 60; }
        if Equals(archetype, "HOMELESS") { return 70; }
        if Equals(archetype, "JUNKIE") { return 80; }
        if Equals(archetype, "LOWLIFE") { return 55; }
        if Equals(archetype, "CORPO_DRONE") { return 40; }
        return 35;
    }

    private static func GenerateTraumaEvent(seed: Int32, archetype: String) -> String {
        let year = RandRange(seed + 100, 2055, 2076);
        
        // Archetype-specific traumas
        if Equals(archetype, "GANGER") && RandRange(seed + 50, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S153") + IntToString(year) + ")"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S154") + IntToString(year) + ")"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S155") + IntToString(year) + ")"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S156") + IntToString(year) + ")"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S157") + IntToString(year) + ")"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S158") + IntToString(year) + ")"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S159") + IntToString(year) + ")"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S160") + IntToString(year) + ")"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S161") + IntToString(year) + ")"; }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S162") + IntToString(year) + ")";
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            if RandRange(seed + 50, 1, 100) <= 50 {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S163") + IntToString(year) + ")"; }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S164") + IntToString(year) + ")"; }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S165") + IntToString(year) + ")"; }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S166") + IntToString(year) + ")"; }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S167") + IntToString(year) + ")"; }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S168") + IntToString(year) + ")"; }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S169") + IntToString(year) + ")"; }
                return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T252") + IntToString(year) + ")";
            }
        }
        
        if Equals(archetype, "NOMAD") && RandRange(seed + 50, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S170") + IntToString(year) + ")"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S171") + IntToString(year) + ")"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S172") + IntToString(year) + ")"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S173") + IntToString(year) + ")"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S174") + IntToString(year) + ")"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S175") + IntToString(year) + ")"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S176") + IntToString(year) + ")"; }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S177") + IntToString(year) + ")";
        }
        
        // General trauma pool (50)
        let i = RandRange(seed, 0, 49);
        
        // Violence traumas (0-14)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S178") + IntToString(year) + ")"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S179") + IntToString(year) + ")"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S180") + IntToString(year) + ")"; }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S181") + IntToString(year) + ")"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S182") + IntToString(year) + ")"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S183") + IntToString(year) + ")"; }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S184") + IntToString(year) + ")"; }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S185") + IntToString(year) + ")"; }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S186") + IntToString(year) + ")"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S187") + IntToString(year) + ")"; }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S188") + IntToString(year) + ")"; }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S81") + IntToString(year) + ")"; }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S189") + IntToString(year) + ")"; }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S190") + IntToString(year) + ")"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S191") + IntToString(year) + ")"; }
        
        // Loss traumas (15-24)
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S192") + IntToString(year) + ")"; }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S193") + IntToString(year) + ")"; }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S194") + IntToString(year) + ")"; }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S195") + IntToString(year) + ")"; }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S196") + IntToString(year) + ")"; }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S197") + IntToString(year) + ")"; }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S198") + IntToString(year) + ")"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T253") + IntToString(year) + ")"; }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S199") + IntToString(year) + ")"; }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S200") + IntToString(year) + ")"; }
        
        // Childhood/Development (25-32)
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S201") + IntToString(year) + ")"; }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S202") + IntToString(year) + ")"; }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S203") + IntToString(year) + ")"; }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S204") + IntToString(year) + ")"; }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S205") + IntToString(year) + ")"; }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S206") + IntToString(year) + ")"; }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S207") + IntToString(year) + ")"; }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T254") + IntToString(year) + ")"; }
        
        // Accidents/Disasters (33-40)
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S208") + IntToString(year) + ")"; }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S209") + IntToString(year) + ")"; }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S210") + IntToString(year) + ")"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S211") + IntToString(year) + ")"; }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S212") + IntToString(year) + ")"; }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S213") + IntToString(year) + ")"; }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S214") + IntToString(year) + ")"; }
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T255") + IntToString(year) + ")"; }
        
        // Other (41-49)
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T256") + IntToString(year) + ")"; }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S215") + IntToString(year) + ")"; }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S216") + IntToString(year) + ")"; }
        if i == 44 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S217") + IntToString(year) + ")"; }
        if i == 45 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S218") + IntToString(year) + ")"; }
        if i == 46 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S219") + IntToString(year) + ")"; }
        if i == 47 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S220") + IntToString(year) + ")"; }
        if i == 48 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S221") + IntToString(year) + ")"; }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S222") + IntToString(year) + ")";
    }

    private static func GeneratePsychEvaluation(seed: Int32, archetype: String, profile: ref<KdspPsychProfileData>) -> String {
        if profile.threatLevel >= 70 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S223");
        }
        if profile.threatLevel >= 50 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S224");
        }
        if ArraySize(profile.addictions) > 0 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S225");
        }
        if ArraySize(profile.traumaEvents) > 1 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S226");
        }
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S227");
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S228");
    }

    private static func GenerateLastEvalDate(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            return IntToString(RandRange(seed, 2075, 2077)) + GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S229");
        }
        if RandRange(seed, 1, 100) <= 30 {
            return IntToString(RandRange(seed, 2070, 2076));
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T257");
    }

    private static func CalculateStabilityScore(profile: ref<KdspPsychProfileData>, cyberware: ref<KdspCyberwareRegistryData>) -> Int32 {
        let score = 80;

        // Deductions
        if profile.hasAddictions { score -= ArraySize(profile.addictions) * 8; }
        score -= ArraySize(profile.traumaEvents) * 7;
        score -= ArraySize(profile.behavioralFlags) * 5;
        
        // Cyberpsychosis risk
        score -= cyberware.cyberpsychosisRisk / 3;

        // Threat level correlation
        score -= profile.threatLevel / 4;

        // Vendetta deduction
        if profile.hasVendetta { score -= 15; }

        if score < 0 { score = 0; }
        if score > 100 { score = 100; }

        return score;
    }

    private static func GetStabilityRating(score: Int32) -> String {
        if score >= 90 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T258"); }
        if score >= 80 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T259"); }
        if score >= 70 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T260"); }
        if score >= 60 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T261"); }
        if score >= 50 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T262"); }
        if score >= 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T263"); }
        if score >= 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T264"); }
        if score >= 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T265"); }
        if score >= 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T266"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T267");
    }

    private static func HasVendetta(seed: Int32, archetype: String, criminal: ref<KdspCriminalRecordData>) -> Bool {
        let chance: Int32 = 10;

        if Equals(archetype, "GANGER") { chance = 35; }
        else if Equals(archetype, "NOMAD") { chance = 25; }
        else if Equals(archetype, "LOWLIFE") { chance = 20; }

        if criminal.hasRecord && ArraySize(criminal.arrests) > 3 { chance += 15; }

        return RandRange(seed, 1, 100) <= chance;
    }

    private static func GenerateVendettaTarget(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "GANGER") {
            // Gang-specific targets (15)
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T268"); }
            if i == 1 { return "MAELSTROM"; }
            if i == 2 { return "VALENTINOS"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T269"); }
            if i == 4 { return "ANIMALS"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T270"); }
            if i == 6 { return "SCAVENGERS"; }
            if i == 7 { return "WRAITHS"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V5"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S230"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S231"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S232"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S233"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S234"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S235");
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            // Corporate targets (10)
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T272"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V6"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T274"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T275"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S236"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S237"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T276"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T277"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T278"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T279");
        }
        
        if Equals(archetype, "NOMAD") {
            // Nomad targets (10)
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V6"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T272"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T280"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S238"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S239"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S240"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S241"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-Corpo-BIOTECHNICA"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S242"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S243");
        }
        
        // General targets (35)
        let i = RandRange(seed, 0, 34);
        
        // Corporations (0-9)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T272"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V6"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T281"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V7"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V8"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T284"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V9"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T274"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T286"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S244"); }
        
        // Law Enforcement (10-14)
        if i == 10 { return "NCPD"; }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S245"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-V10"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S246"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T288"); }
        
        // Gangs (15-22)
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T268"); }
        if i == 16 { return "MAELSTROM"; }
        if i == 17 { return "VALENTINOS"; }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T269"); }
        if i == 19 { return "ANIMALS"; }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T270"); }
        if i == 21 { return "SCAVENGERS"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S247"); }
        
        // Personal (23-34)
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T289"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S248"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T290"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T291"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T292"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T293"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T294"); }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S249"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T295"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T296"); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T297"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S250");
    }

    private static func GenerateIdeologyFlags(seed: Int32, archetype: String) -> array<String> {
        let flags: array<String>;
        
        // Archetype-influenced ideology selection
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let count = RandRange(seed, 0, 2);
            let i = 0;
            while i < count {
                let j = RandRange(seed + (i * 19), 0, 9);
                if j == 0 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T298")); }
                else if j == 1 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S251")); }
                else if j == 2 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T299")); }
                else if j == 3 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T300")); }
                else if j == 4 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T301")); }
                else if j == 5 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S252")); }
                else if j == 6 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T302")); }
                else if j == 7 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T303")); }
                else if j == 8 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T304")); }
                else { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T305")); }
                i += 1;
            }
            return flags;
        }
        
        if Equals(archetype, "GANGER") {
            let count = RandRange(seed, 0, 2);
            let i = 0;
            while i < count {
                let j = RandRange(seed + (i * 19), 0, 9);
                if j == 0 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T306")); }
                else if j == 1 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T307")); }
                else if j == 2 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T308")); }
                else if j == 3 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S253")); }
                else if j == 4 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T309")); }
                else if j == 5 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T310")); }
                else if j == 6 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T311")); }
                else if j == 7 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T312")); }
                else if j == 8 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T313")); }
                else { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T314")); }
                i += 1;
            }
            return flags;
        }
        
        if Equals(archetype, "NOMAD") {
            let count = RandRange(seed, 0, 2);
            let i = 0;
            while i < count {
                let j = RandRange(seed + (i * 19), 0, 9);
                if j == 0 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S254")); }
                else if j == 1 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T315")); }
                else if j == 2 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T307")); }
                else if j == 3 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T316")); }
                else if j == 4 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T317")); }
                else if j == 5 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S255")); }
                else if j == 6 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T318")); }
                else if j == 7 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T319")); }
                else if j == 8 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T320")); }
                else { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S256")); }
                i += 1;
            }
            return flags;
        }

        // General ideology pool (35)
        let count = RandRange(seed, 0, 2);
        let i = 0;
        while i < count {
            let j = RandRange(seed + (i * 19), 0, 34);
            
            // Political (0-9)
            if j == 0 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T307")); }
            else if j == 1 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T298")); }
            else if j == 2 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T314")); }
            else if j == 3 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T321")); }
            else if j == 4 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T311")); }
            else if j == 5 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T322")); }
            else if j == 6 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T320")); }
            else if j == 7 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T323")); }
            else if j == 8 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T324")); }
            else if j == 9 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T325")); }
            
            // Technology (10-14)
            else if j == 10 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T304")); }
            else if j == 11 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T326")); }
            else if j == 12 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T301")); }
            else if j == 13 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T327")); }
            else if j == 14 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S257")); }
            
            // Social (15-24)
            else if j == 15 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T306")); }
            else if j == 16 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S254")); }
            else if j == 17 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S258")); }
            else if j == 18 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T328")); }
            else if j == 19 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T313")); }
            else if j == 20 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T329")); }
            else if j == 21 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T330")); }
            else if j == 22 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T331")); }
            else if j == 23 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T332")); }
            else if j == 24 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T333")); }
            
            // Fringe (25-34)
            else if j == 25 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T334")); }
            else if j == 26 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T335")); }
            else if j == 27 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T336")); }
            else if j == 28 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S259")); }
            else if j == 29 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T337")); }
            else if j == 30 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T338")); }
            else if j == 31 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T312")); }
            else if j == 32 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T339")); }
            else if j == 33 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T340")); }
            else { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T341")); }
            
            i += 1;
        }

        return flags;
    }

    private static func GenerateRiskFactors(seed: Int32, archetype: String, profile: ref<KdspPsychProfileData>) -> array<String> {
        let factors: array<String>;

        if profile.threatLevel >= 60 {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S260"));
        }
        if profile.hasAddictions {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S261"));
        }
        if ArraySize(profile.traumaEvents) > 0 {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T42"));
        }
        if profile.hasVendetta {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T342"));
        }
        if StrContains(profile.armedLikelihood, "LIKELY") || StrContains(profile.armedLikelihood, "CERTAIN") {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-Shared-C62"));
        }
        if Equals(archetype, "GANGER") {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-Shared-C61"));
        }
        if profile.stabilityScore < 40 {
            ArrayPush(factors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T343"));
        }

        return factors;
    }

    private static func GenerateHandlingRecommendation(profile: ref<KdspPsychProfileData>) -> String {
        if profile.threatLevel >= 80 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S262");
        }
        if profile.threatLevel >= 60 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S263");
        }
        if profile.threatLevel >= 40 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S264");
        }
        if profile.stabilityScore < 40 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S265");
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S266");
    }

    // Get temperament based on stability - how the person generally behaves
    public static func GetTemperament(stabilityScore: Int32, threatLevel: Int32) -> String {
        if stabilityScore >= 80 {
            if threatLevel < 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T344"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T345");
        }
        if stabilityScore >= 60 {
            if threatLevel < 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T346"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T347");
        }
        if stabilityScore >= 40 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S267");
        }
        if stabilityScore >= 20 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S268");
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T348");
    }
    
    // Get disposition - general personality/outlook
    public static func GetDisposition(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T349"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T350"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T108"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T351"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T352"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T353"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S269"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T354"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S270"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S271"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T355"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S272"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T356"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T357"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T358");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T359"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T360"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T361"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T362"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T363"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S273"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S274"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S275"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T172"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T364"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T365"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S276"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S277"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S278"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S279");
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T113"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T366"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T367"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T368"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T369"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T370"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T371"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T372"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T373"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T374"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T375"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S280"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T376"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T377"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S281");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T95"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S282"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S51"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T378"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T101"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T379"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S283"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T98"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S86"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T380"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S284"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S285"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S286"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S287"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T381");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T382"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T122"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S85"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T123"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T124"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T126"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T383"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S86"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T129"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S288"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T384"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T125"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T385"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T386"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S289");
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T15"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T387"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T388"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T152"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T389"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T390"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S290"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T19"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S291"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T391"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T392"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S292"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S293"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T393"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S294");
        }
        
        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S295"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T117"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T6"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T18"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T118"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S81"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S80"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S296"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T394"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S297"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S298"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T4"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S299"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S300"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S301");
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T387"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S302"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T19"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T395"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T396"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S303"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T397"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T398"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T399"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S304"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S305"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S306"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S307"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S308"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S309");
        }
        
        // CIVVIE and default (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T400"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S310"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T401"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T402"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T130"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T403"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T328"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T404"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T405"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T406"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T407"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S311"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S312"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T408"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S313"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S314"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T409"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S315"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S316"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S317");
    }
}

public class KdspPsychProfileData {
    public let threatLevel: Int32;
    public let threatColor: String;
    public let threatDescription: String;
    public let combatTraining: String;
    public let armedLikelihood: String;
    public let approachRecommendation: String;
    public let personalityTraits: array<String>;
    public let behavioralFlags: array<String>;
    public let hasAddictions: Bool;
    public let addictions: array<String>;
    public let traumaEvents: array<String>;
    public let psychEvaluation: String;
    public let lastEvalDate: String;
    public let stabilityScore: Int32;
    public let stabilityRating: String;
    public let hasVendetta: Bool;
    public let vendettaTarget: String;
    public let ideologyFlags: array<String>;
    public let riskFactors: array<String>;
    public let handlingRecommendation: String;
}
