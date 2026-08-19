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
                ArrayPush(training, "Self-taught fighter");
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
            if roll <= 80 { return "MODERATE"; }
            return "LOW";
        }
        return KdspPsychProfileManager.AssessArmedLikelihood(seed, archetype, null);
    }

    // Personality traits influenced by life theme
    private static func GeneratePersonalityTraitCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && RandRange(seed + 50, 1, 100) <= 40 {
            if Equals(coherence.lifeTheme, "FALLING") {
                let traits: array<String>;
                ArrayPush(traits, "Defeated");
                ArrayPush(traits, "Bitter");
                ArrayPush(traits, "Hopeless");
                ArrayPush(traits, "Self-destructive");
                ArrayPush(traits, "Resentful");
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
            if Equals(coherence.lifeTheme, "STRUGGLING") {
                let traits: array<String>;
                ArrayPush(traits, "Desperate");
                ArrayPush(traits, "Anxious");
                ArrayPush(traits, "Resilient");
                ArrayPush(traits, "Stressed");
                ArrayPush(traits, "Defensive");
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
            if Equals(coherence.lifeTheme, "CLIMBING") {
                let traits: array<String>;
                ArrayPush(traits, "Ambitious");
                ArrayPush(traits, "Driven");
                ArrayPush(traits, "Optimistic");
                ArrayPush(traits, "Competitive");
                ArrayPush(traits, "Opportunistic");
                return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
            }
            if coherence.hasTrauma {
                let traits: array<String>;
                ArrayPush(traits, "Guarded");
                ArrayPush(traits, "Hypervigilant");
                ArrayPush(traits, "Withdrawn");
                ArrayPush(traits, "Distrustful");
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
                ArrayPush(flags, "VIOLENCE HISTORY");
                ArrayPush(flags, "AGGRESSION INDICATORS");
                ArrayPush(flags, "IMPULSE CONTROL ISSUES");
                ArrayPush(flags, "CONFRONTATIONAL");
                return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
            }
            if coherence.hasSubstanceIssues {
                let flags: array<String>;
                ArrayPush(flags, "SUBSTANCE ABUSE");
                ArrayPush(flags, "ERRATIC BEHAVIOR");
                ArrayPush(flags, "UNPREDICTABLE");
                ArrayPush(flags, "WITHDRAWAL RISK");
                return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
            }
            if coherence.hasTrauma {
                let flags: array<String>;
                ArrayPush(flags, "TRAUMA RESPONSE");
                ArrayPush(flags, "PTSD INDICATORS");
                ArrayPush(flags, "EMOTIONAL VOLATILITY");
                ArrayPush(flags, "TRIGGER SENSITIVITY");
                return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
            }
        }
        return KdspPsychProfileManager.GenerateBehavioralFlag(seed, archetype);
    }

    // Generate addiction matching substance type
    private static func GenerateAddictionFromSubstance(seed: Int32, substanceType: String) -> String {
        if Equals(substanceType, "alcohol") || Equals(substanceType, "synthetic alcohol") {
            return "Alcohol dependency";
        }
        if StrContains(StrLower(substanceType), "synth-coke") {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S2");
        }
        if StrContains(StrLower(substanceType), "black lace") {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S3");
        }
        if StrContains(StrLower(substanceType), "glitter") {
            return "Glitter addiction";
        }
        if StrContains(StrLower(substanceType), "stim") {
            return "Stimulant dependency";
        }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S4") + substanceType + ")";
    }

    // Generate trauma matching type
    private static func GenerateTraumaFromType(seed: Int32, traumaType: String) -> String {
        let year = RandRange(seed, 2060, 2076);
        
        if Equals(traumaType, "violence") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S5"));
            ArrayPush(traumas, "Witnessed murder");
            ArrayPush(traumas, "Shooting victim");
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
            ArrayPush(traumas, "Lost child");
            ArrayPush(traumas, "Partner death");
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "war") {
            let traumas: array<String>;
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S14"));
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S15"));
            ArrayPush(traumas, "Combat PTSD");
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S16"));
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "abandonment") {
            let traumas: array<String>;
            ArrayPush(traumas, "Childhood abandonment");
            ArrayPush(traumas, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S17"));
            ArrayPush(traumas, "Parental rejection");
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
                ArrayPush(factors, "Unresolved trauma");
            }
            if Equals(coherence.lifeTheme, "FALLING") {
                ArrayPush(factors, "Downward spiral");
                ArrayPush(factors, "Desperation risk");
            }
            if coherence.isInDebt {
                ArrayPush(factors, "Financial desperation");
            }
        }
        
        // Add some random factors
        if ArraySize(factors) < 2 {
            let possibleFactors: array<String>;
            ArrayPush(possibleFactors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S26"));
            ArrayPush(possibleFactors, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S27"));
            ArrayPush(possibleFactors, "Economic stress");
            ArrayPush(possibleFactors, "Social isolation");
            
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
        if threatLevel >= 80 { return "RED"; }
        if threatLevel >= 60 { return "ORANGE"; }
        if threatLevel >= 40 { return "YELLOW"; }
        if threatLevel >= 20 { return "BLUE"; }
        return "GREEN";
    }

    private static func GetThreatDescription(threatLevel: Int32, archetype: String) -> String {
        if threatLevel >= 90 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return "EXTREME DANGER - MAXTAC RESPONSE AUTHORIZED"; }
            if i == 1 { return "EXTREME DANGER - CYBERPSYCHO RISK"; }
            if i == 2 { return "EXTREME DANGER - SHOOT ON SIGHT AUTHORIZED"; }
            return "EXTREME DANGER - ARMED RESPONSE ONLY";
        }
        if threatLevel >= 80 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return "SEVERE THREAT - TACTICAL RESPONSE REQUIRED"; }
            if i == 1 { return "SEVERE THREAT - DO NOT APPROACH ALONE"; }
            if i == 2 { return "SEVERE THREAT - HEAVY BACKUP MANDATORY"; }
            return "SEVERE THREAT - ARMED RESPONSE RECOMMENDED";
        }
        if threatLevel >= 60 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return "HIGH THREAT - APPROACH WITH EXTREME CAUTION"; }
            if i == 1 { return "HIGH THREAT - BACKUP STRONGLY ADVISED"; }
            if i == 2 { return "HIGH THREAT - ARMED AND DANGEROUS"; }
            return "HIGH THREAT - EXPECT RESISTANCE";
        }
        if threatLevel >= 40 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return "MODERATE THREAT - STANDARD PRECAUTIONS"; }
            if i == 1 { return "MODERATE THREAT - STAY ALERT"; }
            if i == 2 { return "MODERATE THREAT - POSSIBLE RESISTANCE"; }
            return "MODERATE THREAT - EXERCISE CAUTION";
        }
        if threatLevel >= 20 {
            let i = RandRange(threatLevel, 0, 3);
            if i == 0 { return "LOW THREAT - ROUTINE ENGAGEMENT"; }
            if i == 1 { return "LOW THREAT - COOPERATION EXPECTED"; }
            if i == 2 { return "LOW THREAT - MINIMAL CONCERN"; }
            return "LOW THREAT - STANDARD PROTOCOLS";
        }
        let i = RandRange(threatLevel, 0, 3);
        if i == 0 { return "MINIMAL THREAT - STANDARD APPROACH"; }
        if i == 1 { return "MINIMAL THREAT - COOPERATIVE"; }
        if i == 2 { return "MINIMAL THREAT - NON-COMBATANT"; }
        return "MINIMAL THREAT - NO SPECIAL PRECAUTIONS";
    }

    private static func AssessCombatTraining(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S28"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S29"); }
            if i == 2 { return "None Detected"; }
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
            if i == 0 { return "None Detected"; }
            if i == 1 { return "Basic Self-Defense"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S37"); }
            if i == 3 { return "Minimal"; }
            if i == 4 { return "Unknown"; }
            if i == 5 { return "Firearms Familiarization"; }
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
            if i == 7 { return "Drive-by Tactics"; }
            if i == 8 { return "Knife Fighting"; }
            if i == 9 { return "Self-Taught Combat"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S47"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S48"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S49"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S50"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S51");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Wilderness Survival"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S52"); }
            if i == 2 { return "Firearms Proficiency"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S53"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S54"); }
            if i == 5 { return "Ambush Tactics"; }
            if i == 6 { return "Long-Range Marksmanship"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S55"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S56"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S57"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S58"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S59");
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S60"); }
            if i == 1 { return "None Detected"; }
            if i == 2 { return "Self-Defense (Informal)"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S61"); }
            if i == 4 { return "Firearms (Untrained)"; }
            if i == 5 { return "Brawling Experience"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S62"); }
            if i == 7 { return "Opportunistic Combat"; }
            if i == 8 { return "Evasion Tactics"; }
            return "Unknown";
        }
        
        // General/Civilian (15)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "None Detected"; }
        if i == 1 { return "Basic Self-Defense"; }
        if i == 2 { return "Minimal"; }
        if i == 3 { return "Unknown"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S63"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S64"); }
        if i == 6 { return "Boxing (Amateur)"; }
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

        if likelihood >= 90 { return "ALMOST CERTAIN"; }
        if likelihood >= 70 { return "HIGHLY LIKELY"; }
        if likelihood >= 50 { return "LIKELY"; }
        if likelihood >= 30 { return "POSSIBLE"; }
        return "UNLIKELY";
    }

    private static func GetApproachRecommendation(threatLevel: Int32, armedLikelihood: String) -> String {
        if threatLevel >= 80 || Equals(armedLikelihood, "ALMOST CERTAIN") {
            return "ARMED RESPONSE ONLY - DO NOT APPROACH ALONE";
        }
        if threatLevel >= 60 || Equals(armedLikelihood, "HIGHLY LIKELY") {
            return "BACKUP RECOMMENDED - MAINTAIN DISTANCE";
        }
        if threatLevel >= 40 || Equals(armedLikelihood, "LIKELY") {
            return "STANDARD CAUTION - BE PREPARED";
        }
        return "STANDARD APPROACH";
    }

    private static func GeneratePersonalityTrait(seed: Int32, archetype: String) -> String {
        // Archetype-weighted selection
        if Equals(archetype, "GANGER") {
            if RandRange(seed + 5, 1, 100) <= 60 {
                // Gang-specific negative traits (15)
                let i = RandRange(seed, 0, 14);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S73"); }
                if i == 1 { return "Territorial"; }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S51"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S74"); }
                if i == 4 { return "Ruthless"; }
                if i == 5 { return "Street-hardened"; }
                if i == 6 { return "Vengeful"; }
                if i == 7 { return "Aggressive posturing"; }
                if i == 8 { return "Pack mentality"; }
                if i == 9 { return "Confrontational"; }
                if i == 10 { return "Intimidating presence"; }
                if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S75"); }
                if i == 12 { return "Impulsive"; }
                if i == 13 { return "Risk-taking behavior"; }
                return "Antisocial tendencies";
            }
        }
        if Equals(archetype, "CORPO_MANAGER") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                // Corpo-specific traits (15)
                let i = RandRange(seed, 0, 14);
                if i == 0 { return "Calculating"; }
                if i == 1 { return "Politically savvy"; }
                if i == 2 { return "Status-conscious"; }
                if i == 3 { return "Ruthlessly ambitious"; }
                if i == 4 { return "Controlled demeanor"; }
                if i == 5 { return "Strategic thinker"; }
                if i == 6 { return "Networking instincts"; }
                if i == 7 { return "Competitive"; }
                if i == 8 { return "Image-conscious"; }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S76"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S77"); }
                if i == 11 { return "Results-oriented"; }
                if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S78"); }
                if i == 13 { return "Detail-oriented"; }
                return "Professional composure";
            }
        }
        if Equals(archetype, "JUNKIE") {
            if RandRange(seed + 5, 1, 100) <= 70 {
                // Junkie-specific traits (12)
                let i = RandRange(seed, 0, 11);
                if i == 0 { return "Desperate"; }
                if i == 1 { return "Unpredictable"; }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S79"); }
                if i == 3 { return "Paranoid tendencies"; }
                if i == 4 { return "Emotionally volatile"; }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S80"); }
                if i == 6 { return "Withdrawn"; }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S81"); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S82"); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S83"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S84"); }
                return "Self-destructive patterns";
            }
        }
        if Equals(archetype, "NOMAD") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                // Nomad-specific traits (12)
                let i = RandRange(seed, 0, 11);
                if i == 0 { return "Clan-loyal"; }
                if i == 1 { return "Self-reliant"; }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S85"); }
                if i == 3 { return "Freedom-seeking"; }
                if i == 4 { return "Resourceful"; }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S86"); }
                if i == 6 { return "Practical mindset"; }
                if i == 7 { return "Wanderlust"; }
                if i == 8 { return "Independent spirit"; }
                if i == 9 { return "Survival instincts"; }
                if i == 10 { return "Road-hardened"; }
                return "Community-minded";
            }
        }
        
        // General traits pool (60)
        let i = RandRange(seed, 0, 59);
        
        // Neutral traits (0-19)
        if i == 0 { return "Introverted"; }
        if i == 1 { return "Extroverted"; }
        if i == 2 { return "Analytical"; }
        if i == 3 { return "Creative"; }
        if i == 4 { return "Pragmatic"; }
        if i == 5 { return "Idealistic"; }
        if i == 6 { return "Reserved"; }
        if i == 7 { return "Outspoken"; }
        if i == 8 { return "Curious"; }
        if i == 9 { return "Cautious"; }
        if i == 10 { return "Spontaneous"; }
        if i == 11 { return "Methodical"; }
        if i == 12 { return "Empathetic"; }
        if i == 13 { return "Detached"; }
        if i == 14 { return "Optimistic"; }
        if i == 15 { return "Pessimistic"; }
        if i == 16 { return "Traditional"; }
        if i == 17 { return "Progressive"; }
        if i == 18 { return "Perfectionist"; }
        if i == 19 { return "Laid-back"; }
        
        // Positive traits (20-39)
        if i == 20 { return "Loyal"; }
        if i == 21 { return "Resourceful"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S78"); }
        if i == 23 { return "Protective"; }
        if i == 24 { return "Adaptable"; }
        if i == 25 { return "Honest"; }
        if i == 26 { return "Determined"; }
        if i == 27 { return "Compassionate"; }
        if i == 28 { return "Patient"; }
        if i == 29 { return "Resilient"; }
        if i == 30 { return "Fair-minded"; }
        if i == 31 { return "Reliable"; }
        if i == 32 { return "Courageous"; }
        if i == 33 { return "Generous"; }
        if i == 34 { return "Humble"; }
        if i == 35 { return "Hard-working"; }
        if i == 36 { return "Thoughtful"; }
        if i == 37 { return "Diplomatic"; }
        if i == 38 { return "Confident"; }
        if i == 39 { return "Self-aware"; }
        
        // Negative traits (40-59)
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S73"); }
        if i == 41 { return "Impulsive"; }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S87"); }
        if i == 43 { return "Paranoid tendencies"; }
        if i == 44 { return "Risk-taking behavior"; }
        if i == 45 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S88"); }
        if i == 46 { return "Emotionally volatile"; }
        if i == 47 { return "Manipulative"; }
        if i == 48 { return "Antisocial tendencies"; }
        if i == 49 { return "Short-tempered"; }
        if i == 50 { return "Jealous"; }
        if i == 51 { return "Stubborn"; }
        if i == 52 { return "Self-centered"; }
        if i == 53 { return "Passive-aggressive"; }
        if i == 54 { return "Avoidant"; }
        if i == 55 { return "Cynical"; }
        if i == 56 { return "Resentful"; }
        if i == 57 { return "Insecure"; }
        if i == 58 { return "Controlling"; }
        return "Defensive";
    }

    private static func GenerateBehavioralFlag(seed: Int32, archetype: String) -> String {
        // Archetype-specific flags
        if Equals(archetype, "GANGER") && RandRange(seed + 50, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "ACTIVE GANG MEMBER"; }
            if i == 1 { return "TERRITORY ENFORCEMENT"; }
            if i == 2 { return "KNOWN STREET VIOLENCE"; }
            if i == 3 { return "CREW LEADERSHIP ROLE"; }
            if i == 4 { return "INITIATIONS INVOLVEMENT"; }
            if i == 5 { return "DRIVE-BY SUSPECT"; }
            if i == 6 { return "PROTECTION RACKET"; }
            if i == 7 { return "WEAPONS TRAFFICKING"; }
            if i == 8 { return "DRUG DISTRIBUTION"; }
            return "INTER-GANG CONFLICT";
        }
        
        if Equals(archetype, "CORPO_MANAGER") && RandRange(seed + 50, 1, 100) <= 40 {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "CORPORATE ESPIONAGE RISK"; }
            if i == 1 { return "INSIDER TRADING SUSPICION"; }
            if i == 2 { return "HIGH-STRESS INDICATORS"; }
            if i == 3 { return "SUBORDINATE COMPLAINTS"; }
            if i == 4 { return "ETHICS VIOLATION HISTORY"; }
            if i == 5 { return "SUBSTANCE USE (CONCEALED)"; }
            if i == 6 { return "MARITAL ISSUES"; }
            return "BURNOUT INDICATORS";
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
        if i == 9 { return "Intimidation tactics"; }
        
        // Criminal associations (10-19)
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S98"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S99"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S100"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S101"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S102"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S103"); }
        if i == 16 { return "Smuggling suspicion"; }
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
        if i == 27 { return "Harassment complaints"; }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S114"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S14"); }
        
        // Psychological flags (30-39)
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S115"); }
        if i == 31 { return "Anti-corporate sentiment"; }
        if i == 32 { return "Anti-authority sentiment"; }
        if i == 33 { return "Paranoid ideation"; }
        if i == 34 { return "Conspiracy beliefs"; }
        if i == 35 { return "Depressive indicators"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S116"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S117"); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S118"); }
        if i == 39 { return "Dissociative episodes"; }
        
        // Risk indicators (40-44)
        if i == 40 { return "Self-harm history"; }
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
            if i == 2 { return "Glitter (Compulsive)"; }
            if i == 3 { return "Dorph (Dependency)"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S125"); }
            if i == 5 { return "Bounce (Stimulant)"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S126"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S127"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S128"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S129"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S130"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S131"); }
            if i == 12 { return "Bootleg pharmaceuticals"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S132"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S133");
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            // Corporate-appropriate addictions (12)
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S134"); }
            if i == 1 { return "Alcohol (Functioning)"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S135"); }
            if i == 3 { return "Prescription stimulants"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S136"); }
            if i == 5 { return "Anti-anxiety medication"; }
            if i == 6 { return "Caffeine (Extreme)"; }
            if i == 7 { return "Nicotine (Heavy)"; }
            if i == 8 { return "Performance enhancers"; }
            if i == 9 { return "Shopping (Compulsive)"; }
            if i == 10 { return "Social media/Network"; }
            return "Power/Control";
        }
        
        if Equals(archetype, "GANGER") {
            // Gang-related substances (10)
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S137"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S138"); }
            if i == 2 { return "Alcohol (Heavy)"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S139"); }
            if i == 4 { return "Bounce (Energy)"; }
            if i == 5 { return "Synthcoke (Recreational)"; }
            if i == 6 { return "Adrenaline chasing"; }
            if i == 7 { return "Violence (Behavioral)"; }
            if i == 8 { return "Risk-taking (Pathological)"; }
            return "Gambling (Compulsive)";
        }
        
        // General addictions pool (45)
        let i = RandRange(seed, 0, 44);
        
        // Alcohol (0-5)
        if i == 0 { return "Alcohol (Moderate)"; }
        if i == 1 { return "Alcohol (Severe)"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S140"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S141"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S142"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S143"); }
        
        // Tobacco/Nicotine (6-8)
        if i == 6 { return "Tobacco/Nicotine (Light)"; }
        if i == 7 { return "Tobacco/Nicotine (Heavy)"; }
        if i == 8 { return "Vaping (Compulsive)"; }
        
        // Street drugs (9-19)
        if i == 9 { return "Synth-Cocaine"; }
        if i == 10 { return "Black Lace"; }
        if i == 11 { return "Glitter"; }
        if i == 12 { return "Dorph"; }
        if i == 13 { return "S-Keef"; }
        if i == 14 { return "Bounce"; }
        if i == 15 { return "Blue Glass"; }
        if i == 16 { return "Spike"; }
        if i == 17 { return "Smash"; }
        if i == 18 { return "Street opioids"; }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S144"); }
        
        // Prescription (20-26)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S145"); }
        if i == 21 { return "Sedatives (Self-Medicating)"; }
        if i == 22 { return "Stimulants (Prescription)"; }
        if i == 23 { return "Painkillers (Dependency)"; }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S146"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S147"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S148"); }
        
        // Behavioral (27-37)
        if i == 27 { return "Braindance (Compulsive)"; }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S149"); }
        if i == 29 { return "Gambling"; }
        if i == 30 { return "Gambling (Severe)"; }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S150"); }
        if i == 32 { return "Sex/Pornography"; }
        if i == 33 { return "Shopping (Compulsive)"; }
        if i == 34 { return "Gaming (Excessive)"; }
        if i == 35 { return "Social media"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S151"); }
        if i == 37 { return "Exercise (Compulsive)"; }
        
        // Other (38-44)
        if i == 38 { return "Caffeine (Extreme)"; }
        if i == 39 { return "Sugar (Compulsive)"; }
        if i == 40 { return "Adrenaline (Thrill-seeking)"; }
        if i == 41 { return "Attention/Validation"; }
        if i == 42 { return "Control (Behavioral)"; }
        if i == 43 { return "Self-harm (Pattern)"; }
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
                return "Burnout/breakdown (" + IntToString(year) + ")";
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
        if i == 22 { return "Miscarriage/Stillbirth (" + IntToString(year) + ")"; }
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
        if i == 32 { return "Parentification (" + IntToString(year) + ")"; }
        
        // Accidents/Disasters (33-40)
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S208") + IntToString(year) + ")"; }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S209") + IntToString(year) + ")"; }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S210") + IntToString(year) + ")"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S211") + IntToString(year) + ")"; }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S212") + IntToString(year) + ")"; }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S213") + IntToString(year) + ")"; }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S214") + IntToString(year) + ")"; }
        if i == 40 { return "Near-drowning (" + IntToString(year) + ")"; }
        
        // Other (41-49)
        if i == 41 { return "Imprisonment (" + IntToString(year) + ")"; }
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
        return "NO EVALUATION ON FILE";
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
        if score >= 90 { return "HIGHLY STABLE - EXCELLENT"; }
        if score >= 80 { return "STABLE - GOOD FUNCTIONING"; }
        if score >= 70 { return "STABLE - WITHIN NORMAL RANGE"; }
        if score >= 60 { return "MOSTLY STABLE - MINOR CONCERNS"; }
        if score >= 50 { return "BORDERLINE - MONITORING ADVISED"; }
        if score >= 40 { return "UNSTABLE - TREATMENT RECOMMENDED"; }
        if score >= 30 { return "UNSTABLE - ACTIVE INTERVENTION NEEDED"; }
        if score >= 20 { return "HIGHLY UNSTABLE - CRISIS RISK"; }
        if score >= 10 { return "SEVERELY UNSTABLE - IMMEDIATE ACTION"; }
        return "CRITICAL - EMERGENCY INTERVENTION NEEDED";
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
            if i == 0 { return "TYGER CLAWS"; }
            if i == 1 { return "MAELSTROM"; }
            if i == 2 { return "VALENTINOS"; }
            if i == 3 { return "6TH STREET"; }
            if i == 4 { return "ANIMALS"; }
            if i == 5 { return "VOODOO BOYS"; }
            if i == 6 { return "SCAVENGERS"; }
            if i == 7 { return "WRAITHS"; }
            if i == 8 { return "MOX"; }
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
            if i == 0 { return "ARASAKA CORPORATION"; }
            if i == 1 { return "MILITECH"; }
            if i == 2 { return "Former Employer"; }
            if i == 3 { return "Rival Executive"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S236"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S237"); }
            if i == 6 { return "Whistleblower"; }
            if i == 7 { return "Corporate Lawyer"; }
            if i == 8 { return "HR Department"; }
            return "Competitor Company";
        }
        
        if Equals(archetype, "NOMAD") {
            // Nomad targets (10)
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "MILITECH"; }
            if i == 1 { return "ARASAKA CORPORATION"; }
            if i == 2 { return "Rival Clan"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S238"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S239"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S240"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S241"); }
            if i == 7 { return "Biotechnica"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S242"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S243");
        }
        
        // General targets (35)
        let i = RandRange(seed, 0, 34);
        
        // Corporations (0-9)
        if i == 0 { return "ARASAKA CORPORATION"; }
        if i == 1 { return "MILITECH"; }
        if i == 2 { return "KANG TAO"; }
        if i == 3 { return "BIOTECHNICA"; }
        if i == 4 { return "ZETATECH"; }
        if i == 5 { return "TRAUMA TEAM"; }
        if i == 6 { return "PETROCHEM"; }
        if i == 7 { return "Former Employer"; }
        if i == 8 { return "Insurance Company"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S244"); }
        
        // Law Enforcement (10-14)
        if i == 10 { return "NCPD"; }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S245"); }
        if i == 12 { return "MAXTAC"; }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S246"); }
        if i == 14 { return "Prison System"; }
        
        // Gangs (15-22)
        if i == 15 { return "TYGER CLAWS"; }
        if i == 16 { return "MAELSTROM"; }
        if i == 17 { return "VALENTINOS"; }
        if i == 18 { return "6TH STREET"; }
        if i == 19 { return "ANIMALS"; }
        if i == 20 { return "VOODOO BOYS"; }
        if i == 21 { return "SCAVENGERS"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S247"); }
        
        // Personal (23-34)
        if i == 23 { return "Unknown Individual"; }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S248"); }
        if i == 25 { return "Ex-Spouse/Partner"; }
        if i == 26 { return "Former Friend"; }
        if i == 27 { return "Neighbor"; }
        if i == 28 { return "Landlord/Property Owner"; }
        if i == 29 { return "Loan Shark"; }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S249"); }
        if i == 31 { return "Fixer (Betrayal)"; }
        if i == 32 { return "Medical System"; }
        if i == 33 { return "Parent/Guardian"; }
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
                if j == 0 { ArrayPush(flags, "Pro-Corporate"); }
                else if j == 1 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S251")); }
                else if j == 2 { ArrayPush(flags, "Meritocracy Believer"); }
                else if j == 3 { ArrayPush(flags, "Corporate Loyalist"); }
                else if j == 4 { ArrayPush(flags, "Techno-Optimist"); }
                else if j == 5 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S252")); }
                else if j == 6 { ArrayPush(flags, "Apolitical (Career-focused)"); }
                else if j == 7 { ArrayPush(flags, "Privately Anti-Corporate"); }
                else if j == 8 { ArrayPush(flags, "Transhumanist"); }
                else { ArrayPush(flags, "Pragmatic Centrist"); }
                i += 1;
            }
            return flags;
        }
        
        if Equals(archetype, "GANGER") {
            let count = RandRange(seed, 0, 2);
            let i = 0;
            while i < count {
                let j = RandRange(seed + (i * 19), 0, 9);
                if j == 0 { ArrayPush(flags, "Gang Loyalist"); }
                else if j == 1 { ArrayPush(flags, "Anti-Corporate"); }
                else if j == 2 { ArrayPush(flags, "Anti-Authority"); }
                else if j == 3 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S253")); }
                else if j == 4 { ArrayPush(flags, "Territorial Nationalism"); }
                else if j == 5 { ArrayPush(flags, "Criminal Pragmatist"); }
                else if j == 6 { ArrayPush(flags, "Revolutionary"); }
                else if j == 7 { ArrayPush(flags, "Nihilist"); }
                else if j == 8 { ArrayPush(flags, "Survivalist"); }
                else { ArrayPush(flags, "Anarchist Sympathizer"); }
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
                else if j == 1 { ArrayPush(flags, "Freedom Absolutist"); }
                else if j == 2 { ArrayPush(flags, "Anti-Corporate"); }
                else if j == 3 { ArrayPush(flags, "Self-Reliance Philosophy"); }
                else if j == 4 { ArrayPush(flags, "Family/Clan Loyalty"); }
                else if j == 5 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S255")); }
                else if j == 6 { ArrayPush(flags, "Environmental Concern"); }
                else if j == 7 { ArrayPush(flags, "Traditional Values"); }
                else if j == 8 { ArrayPush(flags, "Libertarian"); }
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
            if j == 0 { ArrayPush(flags, "Anti-Corporate"); }
            else if j == 1 { ArrayPush(flags, "Pro-Corporate"); }
            else if j == 2 { ArrayPush(flags, "Anarchist Sympathizer"); }
            else if j == 3 { ArrayPush(flags, "Nationalist (NUSA)"); }
            else if j == 4 { ArrayPush(flags, "Revolutionary"); }
            else if j == 5 { ArrayPush(flags, "Reformist"); }
            else if j == 6 { ArrayPush(flags, "Libertarian"); }
            else if j == 7 { ArrayPush(flags, "Authoritarian Leaning"); }
            else if j == 8 { ArrayPush(flags, "Populist"); }
            else if j == 9 { ArrayPush(flags, "Socialist"); }
            
            // Technology (10-14)
            else if j == 10 { ArrayPush(flags, "Transhumanist"); }
            else if j == 11 { ArrayPush(flags, "Bioconservative"); }
            else if j == 12 { ArrayPush(flags, "Techno-Optimist"); }
            else if j == 13 { ArrayPush(flags, "Techno-Skeptic"); }
            else if j == 14 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S257")); }
            
            // Social (15-24)
            else if j == 15 { ArrayPush(flags, "Gang Loyalist"); }
            else if j == 16 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S254")); }
            else if j == 17 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S258")); }
            else if j == 18 { ArrayPush(flags, "Apolitical"); }
            else if j == 19 { ArrayPush(flags, "Survivalist"); }
            else if j == 20 { ArrayPush(flags, "Family Values"); }
            else if j == 21 { ArrayPush(flags, "Community Organizer"); }
            else if j == 22 { ArrayPush(flags, "Individualist"); }
            else if j == 23 { ArrayPush(flags, "Collectivist"); }
            else if j == 24 { ArrayPush(flags, "Environmentalist"); }
            
            // Fringe (25-34)
            else if j == 25 { ArrayPush(flags, "Conspiracy Believer"); }
            else if j == 26 { ArrayPush(flags, "Doomsday Prepper"); }
            else if j == 27 { ArrayPush(flags, "Anti-Government"); }
            else if j == 28 { ArrayPush(flags, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S259")); }
            else if j == 29 { ArrayPush(flags, "Extremist Sympathizer"); }
            else if j == 30 { ArrayPush(flags, "Militant Activist"); }
            else if j == 31 { ArrayPush(flags, "Nihilist"); }
            else if j == 32 { ArrayPush(flags, "Hedonist"); }
            else if j == 33 { ArrayPush(flags, "Cyberpsycho Sympathizer"); }
            else { ArrayPush(flags, "Unknown Ideology"); }
            
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
            ArrayPush(factors, "Unresolved trauma");
        }
        if profile.hasVendetta {
            ArrayPush(factors, "Active vendetta");
        }
        if StrContains(profile.armedLikelihood, "LIKELY") || StrContains(profile.armedLikelihood, "CERTAIN") {
            ArrayPush(factors, "Likely armed");
        }
        if Equals(archetype, "GANGER") {
            ArrayPush(factors, "Gang affiliation");
        }
        if profile.stabilityScore < 40 {
            ArrayPush(factors, "Psychological instability");
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
            if threatLevel < 20 { return "Calm, well-adjusted"; }
            return "Composed, guarded";
        }
        if stabilityScore >= 60 {
            if threatLevel < 30 { return "Generally stable"; }
            return "Tense, alert";
        }
        if stabilityScore >= 40 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S267");
        }
        if stabilityScore >= 20 {
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S268");
        }
        return "Severe instability";
    }
    
    // Get disposition - general personality/outlook
    public static func GetDisposition(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Ambitious, calculating"; }
            if i == 1 { return "Professional demeanor"; }
            if i == 2 { return "Status-conscious"; }
            if i == 3 { return "Guarded, political"; }
            if i == 4 { return "Results-driven"; }
            if i == 5 { return "Coldly efficient"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S269"); }
            if i == 7 { return "Networking constantly"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S270"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S271"); }
            if i == 10 { return "Image-obsessed"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S272"); }
            if i == 12 { return "Power-hungry"; }
            if i == 13 { return "Diplomatically aggressive"; }
            return "Corporate survivor";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Compliant, risk-averse"; }
            if i == 1 { return "Routine-oriented"; }
            if i == 2 { return "Quietly ambitious"; }
            if i == 3 { return "Stressed, overworked"; }
            if i == 4 { return "Corporate loyalist"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S273"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S274"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S275"); }
            if i == 8 { return "Passive-aggressive"; }
            if i == 9 { return "Clock-watching"; }
            if i == 10 { return "Secretly resentful"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S276"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S277"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S278"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S279");
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Image-conscious"; }
            if i == 1 { return "Trend-follower"; }
            if i == 2 { return "Socially active"; }
            if i == 3 { return "Materialistic"; }
            if i == 4 { return "Upwardly mobile"; }
            if i == 5 { return "Social climber"; }
            if i == 6 { return "Brand-obsessed"; }
            if i == 7 { return "Networking-focused"; }
            if i == 8 { return "Status-seeking"; }
            if i == 9 { return "Experience collector"; }
            if i == 10 { return "FOMO-driven"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S280"); }
            if i == 12 { return "Influencer aspirant"; }
            if i == 13 { return "Debt-funded lifestyle"; }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S281");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Territorial"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S282"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S51"); }
            if i == 3 { return "Street-smart"; }
            if i == 4 { return "Confrontational"; }
            if i == 5 { return "Hair-trigger temper"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S283"); }
            if i == 7 { return "Vengeful"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S86"); }
            if i == 9 { return "Honor-bound"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S284"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S285"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S286"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S287"); }
            return "Survivor mentality";
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Clan-oriented"; }
            if i == 1 { return "Self-reliant"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S85"); }
            if i == 3 { return "Freedom-seeking"; }
            if i == 4 { return "Resourceful"; }
            if i == 5 { return "Wanderlust"; }
            if i == 6 { return "Fiercely independent"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S86"); }
            if i == 8 { return "Road-hardened"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S288"); }
            if i == 10 { return "Traditional values"; }
            if i == 11 { return "Practical mindset"; }
            if i == 12 { return "Tight-knit loyalty"; }
            if i == 13 { return "Adaptable survivor"; }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S289");
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Opportunistic"; }
            if i == 1 { return "Survival-focused"; }
            if i == 2 { return "Cynical outlook"; }
            if i == 3 { return "Adaptable"; }
            if i == 4 { return "Street-wise"; }
            if i == 5 { return "Hustler mentality"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S290"); }
            if i == 7 { return "Distrustful"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S291"); }
            if i == 9 { return "Day-to-day survivor"; }
            if i == 10 { return "Small-time schemer"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S292"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S293"); }
            if i == 13 { return "Pragmatic pessimist"; }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S294");
        }
        
        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S295"); }
            if i == 1 { return "Unpredictable"; }
            if i == 2 { return "Desperate"; }
            if i == 3 { return "Withdrawn"; }
            if i == 4 { return "Paranoid tendencies"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S81"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S80"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S296"); }
            if i == 8 { return "Shame-filled"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S297"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S298"); }
            if i == 11 { return "Self-destructive"; }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S299"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S300"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S301");
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Survival-focused"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S302"); }
            if i == 2 { return "Distrustful"; }
            if i == 3 { return "Day-to-day existence"; }
            if i == 4 { return "Resigned outlook"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S303"); }
            if i == 6 { return "Unexpectedly wise"; }
            if i == 7 { return "Mentally fragile"; }
            if i == 8 { return "Former professional"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S304"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S305"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S306"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S307"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S308"); }
            return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S309");
        }
        
        // CIVVIE and default (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Average citizen"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S310"); }
        if i == 2 { return "Family-oriented"; }
        if i == 3 { return "Work-focused"; }
        if i == 4 { return "Community-minded"; }
        if i == 5 { return "Cautious optimist"; }
        if i == 6 { return "Apolitical"; }
        if i == 7 { return "Private individual"; }
        if i == 8 { return "Friendly neighbor"; }
        if i == 9 { return "Hardworking"; }
        if i == 10 { return "Quietly struggling"; }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S311"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S312"); }
        if i == 13 { return "Simple pleasures"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S313"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-S314"); }
        if i == 16 { return "Getting by"; }
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
