// Psychological Assessment Generation System
public class PsychProfileManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String, criminalRecord: ref<CriminalRecordData>, cyberware: ref<CyberwareRegistryData>) -> ref<PsychProfileData> {
        return PsychProfileManager.GenerateCoherent(seed, archetype, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> ref<PsychProfileData> {
        let profile: ref<PsychProfileData> = new PsychProfileData();
        let density = KiroshiSettings.GetDataDensity();

        // Threat assessment - always shown
        profile.threatLevel = PsychProfileManager.CalculateThreatLevelCoherent(seed, archetype, coherence);
        profile.threatColor = PsychProfileManager.GetThreatColor(profile.threatLevel);
        profile.threatDescription = PsychProfileManager.GetThreatDescription(profile.threatLevel, archetype);

        // Combat assessment - only on medium/high
        if density >= 2 {
            profile.combatTraining = PsychProfileManager.AssessCombatTrainingCoherent(seed + 100, archetype, coherence);
            profile.armedLikelihood = PsychProfileManager.AssessArmedLikelihoodCoherent(seed + 110, archetype, coherence);
            profile.approachRecommendation = PsychProfileManager.GetApproachRecommendation(profile.threatLevel, profile.armedLikelihood);
        }

        // Personality traits - limited by density
        let traitCount = RandRange(seed + 200, 2, 5);
        traitCount = KiroshiSettings.GetMaxListItems(traitCount);
        
        let i = 0;
        while i < traitCount {
            ArrayPush(profile.personalityTraits, PsychProfileManager.GeneratePersonalityTraitCoherent(seed + 210 + (i * 31), archetype, coherence));
            i += 1;
        }

        // Behavioral flags - limited by density
        let flagCount = RandRange(seed + 300, 0, 3);
        if IsDefined(coherence) && (coherence.hasViolentPast || coherence.hasSubstanceIssues || coherence.hasTrauma) {
            flagCount += 1; // More flags for troubled individuals
        }
        flagCount = KiroshiSettings.GetMaxListItems(flagCount);
        
        i = 0;
        while i < flagCount {
            ArrayPush(profile.behavioralFlags, PsychProfileManager.GenerateBehavioralFlagCoherent(seed + 310 + (i * 37), archetype, coherence));
            i += 1;
        }

        // Addictions - USE COHERENCE for consistency
        if IsDefined(coherence) && coherence.hasSubstanceIssues {
            profile.hasAddictions = true;
            // Generate addiction matching the substance type
            ArrayPush(profile.addictions, PsychProfileManager.GenerateAddictionFromSubstance(seed + 420, coherence.substanceType));
            // Maybe add secondary addiction - only on high density
            if density >= 3 && RandRange(seed + 421, 1, 100) <= 30 {
                ArrayPush(profile.addictions, PsychProfileManager.GenerateAddiction(seed + 422, archetype));
            }
        } else {
            profile.hasAddictions = PsychProfileManager.HasAddictions(seed + 400, archetype);
            if profile.hasAddictions {
                let addictionCount = RandRange(seed + 410, 1, 3);
                addictionCount = KiroshiSettings.GetMaxListItems(addictionCount);
                i = 0;
                while i < addictionCount {
                    ArrayPush(profile.addictions, PsychProfileManager.GenerateAddiction(seed + 420 + (i * 43), archetype));
                    i += 1;
                }
            }
        }

        // Trauma history - USE COHERENCE for consistency
        if IsDefined(coherence) && coherence.hasTrauma {
            // Generate trauma matching the type
            ArrayPush(profile.traumaEvents, PsychProfileManager.GenerateTraumaFromType(seed + 520, coherence.traumaType));
            // Maybe add secondary trauma - only on high density
            if density >= 3 && RandRange(seed + 521, 1, 100) <= 40 {
                ArrayPush(profile.traumaEvents, PsychProfileManager.GenerateTraumaEvent(seed + 522, archetype));
            }
        } else {
            let traumaChance = PsychProfileManager.GetTraumaChance(archetype);
            if RandRange(seed + 500, 1, 100) <= traumaChance {
                let traumaCount = RandRange(seed + 510, 1, 3);
                traumaCount = KiroshiSettings.GetMaxListItems(traumaCount);
                i = 0;
                while i < traumaCount {
                    ArrayPush(profile.traumaEvents, PsychProfileManager.GenerateTraumaEvent(seed + 520 + (i * 47), archetype));
                    i += 1;
                }
            }
        }

        // Psychological evaluation
        profile.psychEvaluation = PsychProfileManager.GeneratePsychEvaluationCoherent(seed + 600, archetype, coherence);
        profile.lastEvalDate = PsychProfileManager.GenerateLastEvalDate(seed + 610, archetype);

        // Stability assessment - influenced by coherence
        profile.stabilityScore = PsychProfileManager.CalculateStabilityScoreCoherent(profile, coherence);
        profile.stabilityRating = PsychProfileManager.GetStabilityRating(profile.stabilityScore);

        // Known vendettas - more likely with violent past
        if PsychProfileManager.HasVendettaCoherent(seed + 700, archetype, coherence) {
            profile.hasVendetta = true;
            profile.vendettaTarget = PsychProfileManager.GenerateVendettaTarget(seed + 710, archetype);
        }

        // Ideology / beliefs
        profile.ideologyFlags = PsychProfileManager.GenerateIdeologyFlags(seed + 800, archetype);

        // Risk factors
        profile.riskFactors = PsychProfileManager.GenerateRiskFactorsCoherent(seed + 900, archetype, coherence);

        // Recommendation
        profile.handlingRecommendation = PsychProfileManager.GenerateHandlingRecommendation(profile);

        return profile;
    }

    // Threat level influenced by violent past
    private static func CalculateThreatLevelCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let base = PsychProfileManager.CalculateThreatLevelBase(seed, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { base += RandRange(seed + 5, 15, 30); }
            if Equals(coherence.lifeTheme, "CRIMINAL") { base += RandRange(seed + 6, 10, 20); }
            if coherence.hasSubstanceIssues { base += RandRange(seed + 7, 5, 15); } // Unpredictability
        }
        
        if base > 100 { base = 100; }
        return base;
    }

    // Combat training influenced by violent history
    private static func AssessCombatTrainingCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
        if IsDefined(coherence) && coherence.hasViolentPast {
            if Equals(coherence.violenceType, "gang") {
                let training: array<String>;
                ArrayPush(training, "Street combat experienced");
                ArrayPush(training, "Gang warfare veteran");
                ArrayPush(training, "Self-taught fighter");
                return training[RandRange(seed, 0, ArraySize(training) - 1)];
            }
        }
        return PsychProfileManager.AssessCombatTraining(seed, archetype);
    }

    // Armed likelihood influenced by violence
    private static func AssessArmedLikelihoodCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
        if IsDefined(coherence) && coherence.hasViolentPast {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "HIGH"; }
            if roll <= 80 { return "MODERATE"; }
            return "LOW";
        }
        return PsychProfileManager.AssessArmedLikelihood(seed, archetype, null);
    }

    // Personality traits influenced by life theme
    private static func GeneratePersonalityTraitCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
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
        return PsychProfileManager.GeneratePersonalityTrait(seed, archetype);
    }

    // Behavioral flags coherent with issues
    private static func GenerateBehavioralFlagCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
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
        return PsychProfileManager.GenerateBehavioralFlag(seed, archetype);
    }

    // Generate addiction matching substance type
    private static func GenerateAddictionFromSubstance(seed: Int32, substanceType: String) -> String {
        if Equals(substanceType, "alcohol") || Equals(substanceType, "synthetic alcohol") {
            return "Alcohol dependency";
        }
        if StrContains(StrLower(substanceType), "synth-coke") {
            return "Stimulant addiction (synth-coke)";
        }
        if StrContains(StrLower(substanceType), "black lace") {
            return "Combat drug dependency (Black Lace)";
        }
        if StrContains(StrLower(substanceType), "glitter") {
            return "Glitter addiction";
        }
        if StrContains(StrLower(substanceType), "stim") {
            return "Stimulant dependency";
        }
        return "Substance use disorder (" + substanceType + ")";
    }

    // Generate trauma matching type
    private static func GenerateTraumaFromType(seed: Int32, traumaType: String) -> String {
        let year = RandRange(seed, 2060, 2076);
        
        if Equals(traumaType, "violence") {
            let traumas: array<String>;
            ArrayPush(traumas, "Violent assault survivor");
            ArrayPush(traumas, "Witnessed murder");
            ArrayPush(traumas, "Shooting victim");
            ArrayPush(traumas, "Gang violence trauma");
            ArrayPush(traumas, "Home invasion survivor");
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "accident") {
            let traumas: array<String>;
            ArrayPush(traumas, "Major vehicle accident");
            ArrayPush(traumas, "Industrial accident survivor");
            ArrayPush(traumas, "Building collapse survivor");
            ArrayPush(traumas, "Cyberware malfunction trauma");
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "loss") {
            let traumas: array<String>;
            ArrayPush(traumas, "Lost family member to violence");
            ArrayPush(traumas, "Death of close friend");
            ArrayPush(traumas, "Lost child");
            ArrayPush(traumas, "Partner death");
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "war") {
            let traumas: array<String>;
            ArrayPush(traumas, "Corporate war veteran");
            ArrayPush(traumas, "Unification War survivor");
            ArrayPush(traumas, "Combat PTSD");
            ArrayPush(traumas, "War zone displacement");
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        if Equals(traumaType, "abandonment") {
            let traumas: array<String>;
            ArrayPush(traumas, "Childhood abandonment");
            ArrayPush(traumas, "Foster system survivor");
            ArrayPush(traumas, "Parental rejection");
            return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)] + " (" + IntToString(year) + ")";
        }
        
        return "Unspecified trauma event (" + IntToString(year) + ")";
    }

    // Psych evaluation coherent with issues
    private static func GeneratePsychEvaluationCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
        if IsDefined(coherence) {
            if coherence.hasSubstanceIssues && coherence.hasTrauma {
                return "Dual diagnosis - substance use disorder with PTSD. High risk.";
            }
            if coherence.hasSubstanceIssues {
                return "Substance use disorder identified. Treatment recommended.";
            }
            if coherence.hasTrauma {
                return "Trauma-related symptoms present. Therapy recommended.";
            }
            if coherence.hasViolentPast && Equals(coherence.lifeTheme, "FALLING") {
                return "High-risk profile. History of violence, current decline. Monitor closely.";
            }
            if Equals(coherence.lifeTheme, "FALLING") {
                return "Deteriorating mental state. Intervention may be needed.";
            }
        }
        return PsychProfileManager.GeneratePsychEvaluation(seed, archetype, null);
    }

    // Stability score influenced by coherence
    private static func CalculateStabilityScoreCoherent(profile: ref<PsychProfileData>, coherence: ref<CoherenceProfile>) -> Int32 {
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
    private static func HasVendettaCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Bool {
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
    private static func GenerateRiskFactorsCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> array<String> {
        let factors: array<String>;
        
        if IsDefined(coherence) {
            if coherence.hasSubstanceIssues {
                ArrayPush(factors, "Active substance abuse");
            }
            if coherence.hasViolentPast {
                ArrayPush(factors, "History of violence");
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
            ArrayPush(possibleFactors, "Unstable living situation");
            ArrayPush(possibleFactors, "Limited support network");
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

    private static func CalculateThreatLevel(seed: Int32, archetype: String, criminal: ref<CriminalRecordData>, cyberware: ref<CyberwareRegistryData>) -> Int32 {
        let base = PsychProfileManager.CalculateThreatLevelBase(seed, archetype);

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
            if i == 0 { return "Corporate Self-Defense Training"; }
            if i == 1 { return "Executive Protection Awareness"; }
            if i == 2 { return "None Detected"; }
            if i == 3 { return "Private Security Training"; }
            if i == 4 { return "Firearms Certification (Concealed)"; }
            if i == 5 { return "Krav Maga (Executive Program)"; }
            if i == 6 { return "Arasaka Personal Defense Course"; }
            if i == 7 { return "Militech Executive Combat Course"; }
            if i == 8 { return "Minimal - Relies on security"; }
            return "Former Military (Officer)";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "None Detected"; }
            if i == 1 { return "Basic Self-Defense"; }
            if i == 2 { return "Corporate Security Basics"; }
            if i == 3 { return "Minimal"; }
            if i == 4 { return "Unknown"; }
            if i == 5 { return "Firearms Familiarization"; }
            if i == 6 { return "Workplace Safety Training"; }
            return "Former Security (Low-level)";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Street Combat (Experienced)"; }
            if i == 1 { return "Gang Warfare Training"; }
            if i == 2 { return "Military Training (Suspected)"; }
            if i == 3 { return "Melee Combat Specialist"; }
            if i == 4 { return "Firearms Training (Informal)"; }
            if i == 5 { return "Close Quarters Combat"; }
            if i == 6 { return "Street Fighting (Veteran)"; }
            if i == 7 { return "Drive-by Tactics"; }
            if i == 8 { return "Knife Fighting"; }
            if i == 9 { return "Self-Taught Combat"; }
            if i == 10 { return "Prison Fighting Skills"; }
            if i == 11 { return "Former Military (Enlisted)"; }
            if i == 12 { return "Cyberware Combat Integration"; }
            if i == 13 { return "Pack Tactics Training"; }
            return "Enforcer Training (Internal)";
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Wilderness Survival"; }
            if i == 1 { return "Vehicle Combat Training"; }
            if i == 2 { return "Firearms Proficiency"; }
            if i == 3 { return "Pack Defense Tactics"; }
            if i == 4 { return "Convoy Security Training"; }
            if i == 5 { return "Ambush Tactics"; }
            if i == 6 { return "Long-Range Marksmanship"; }
            if i == 7 { return "Badlands Survival Combat"; }
            if i == 8 { return "Mechanical Combat (Improvised)"; }
            if i == 9 { return "Clan Defense Training"; }
            if i == 10 { return "Border Skirmish Experience"; }
            return "Raider Combat Experience";
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Street Fighting (Basic)"; }
            if i == 1 { return "None Detected"; }
            if i == 2 { return "Self-Defense (Informal)"; }
            if i == 3 { return "Knife Skills (Basic)"; }
            if i == 4 { return "Firearms (Untrained)"; }
            if i == 5 { return "Brawling Experience"; }
            if i == 6 { return "Prison Defense Skills"; }
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
        if i == 4 { return "Gym/Fitness Training Only"; }
        if i == 5 { return "Martial Arts (Hobbyist)"; }
        if i == 6 { return "Boxing (Amateur)"; }
        if i == 7 { return "Firearms Owner (Range Only)"; }
        if i == 8 { return "Former Military (Support Role)"; }
        if i == 9 { return "Security Guard (Former)"; }
        if i == 10 { return "Sports Combat (MMA Fan)"; }
        if i == 11 { return "Self-Defense Class (Completed)"; }
        if i == 12 { return "No Formal Training"; }
        if i == 13 { return "Childhood Martial Arts"; }
        return "Online Combat Tutorials Only";
    }

    private static func AssessArmedLikelihood(seed: Int32, archetype: String, criminal: ref<CriminalRecordData>) -> String {
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
                if i == 0 { return "Prone to violence when threatened"; }
                if i == 1 { return "Territorial"; }
                if i == 2 { return "Distrustful of outsiders"; }
                if i == 3 { return "Quick to anger"; }
                if i == 4 { return "Ruthless"; }
                if i == 5 { return "Street-hardened"; }
                if i == 6 { return "Vengeful"; }
                if i == 7 { return "Aggressive posturing"; }
                if i == 8 { return "Pack mentality"; }
                if i == 9 { return "Confrontational"; }
                if i == 10 { return "Intimidating presence"; }
                if i == 11 { return "Defensive of crew"; }
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
                if i == 9 { return "Diplomatic when needed"; }
                if i == 10 { return "Guarded with information"; }
                if i == 11 { return "Results-oriented"; }
                if i == 12 { return "Calm under pressure"; }
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
                if i == 2 { return "Fixated on substances"; }
                if i == 3 { return "Paranoid tendencies"; }
                if i == 4 { return "Emotionally volatile"; }
                if i == 5 { return "Manipulative when using"; }
                if i == 6 { return "Withdrawn"; }
                if i == 7 { return "Erratic mood swings"; }
                if i == 8 { return "Short attention span"; }
                if i == 9 { return "Deceitful about use"; }
                if i == 10 { return "Prone to panic"; }
                return "Self-destructive patterns";
            }
        }
        if Equals(archetype, "NOMAD") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                // Nomad-specific traits (12)
                let i = RandRange(seed, 0, 11);
                if i == 0 { return "Clan-loyal"; }
                if i == 1 { return "Self-reliant"; }
                if i == 2 { return "Distrustful of corpos"; }
                if i == 3 { return "Freedom-seeking"; }
                if i == 4 { return "Resourceful"; }
                if i == 5 { return "Protective of family"; }
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
        if i == 22 { return "Calm under pressure"; }
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
        if i == 40 { return "Prone to violence when threatened"; }
        if i == 41 { return "Impulsive"; }
        if i == 42 { return "Distrustful of authority"; }
        if i == 43 { return "Paranoid tendencies"; }
        if i == 44 { return "Risk-taking behavior"; }
        if i == 45 { return "Difficulty with authority"; }
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
        if i == 0 { return "History of violent outbursts"; }
        if i == 1 { return "Known to carry concealed weapons"; }
        if i == 2 { return "Previous resistance to arrest"; }
        if i == 3 { return "Known to use violence preemptively"; }
        if i == 4 { return "Domestic violence history"; }
        if i == 5 { return "Bar fight incidents"; }
        if i == 6 { return "Road rage incidents"; }
        if i == 7 { return "Assault charges (past)"; }
        if i == 8 { return "Threats against authority"; }
        if i == 9 { return "Intimidation tactics"; }
        
        // Criminal associations (10-19)
        if i == 10 { return "Gang-related activities suspected"; }
        if i == 11 { return "Possible underground connections"; }
        if i == 12 { return "Associates with known criminals"; }
        if i == 13 { return "Possible information broker"; }
        if i == 14 { return "Fixer network connections"; }
        if i == 15 { return "Black market involvement"; }
        if i == 16 { return "Smuggling suspicion"; }
        if i == 17 { return "Fence for stolen goods"; }
        if i == 18 { return "Money laundering indicators"; }
        if i == 19 { return "Illegal gambling involvement"; }
        
        // Behavioral patterns (20-29)
        if i == 20 { return "Erratic behavior reported"; }
        if i == 21 { return "Known to flee when confronted"; }
        if i == 22 { return "Substance abuse affects judgment"; }
        if i == 23 { return "Financial desperation noted"; }
        if i == 24 { return "History of fraud"; }
        if i == 25 { return "Compulsive lying pattern"; }
        if i == 26 { return "Stalking behavior history"; }
        if i == 27 { return "Harassment complaints"; }
        if i == 28 { return "Boundary violation issues"; }
        if i == 29 { return "Impulse control disorder"; }
        
        // Psychological flags (30-39)
        if i == 30 { return "Protective of specific individuals"; }
        if i == 31 { return "Anti-corporate sentiment"; }
        if i == 32 { return "Anti-authority sentiment"; }
        if i == 33 { return "Paranoid ideation"; }
        if i == 34 { return "Conspiracy beliefs"; }
        if i == 35 { return "Depressive indicators"; }
        if i == 36 { return "Anxiety disorder suspected"; }
        if i == 37 { return "Mood disorder indicators"; }
        if i == 38 { return "Personality disorder traits"; }
        if i == 39 { return "Dissociative episodes"; }
        
        // Risk indicators (40-44)
        if i == 40 { return "Self-harm history"; }
        if i == 41 { return "Suicidal ideation (past)"; }
        if i == 42 { return "Crisis intervention history"; }
        if i == 43 { return "Involuntary commitment (past)"; }
        return "Cyberpsychosis early warning";
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
            if i == 0 { return "Black Lace (Severe)"; }
            if i == 1 { return "Synth-Cocaine (Heavy use)"; }
            if i == 2 { return "Glitter (Compulsive)"; }
            if i == 3 { return "Dorph (Dependency)"; }
            if i == 4 { return "S-Keef (Daily use)"; }
            if i == 5 { return "Bounce (Stimulant)"; }
            if i == 6 { return "Spike (Combat drug)"; }
            if i == 7 { return "Smash (Rage inducer)"; }
            if i == 8 { return "Blue Glass (Hallucinogen)"; }
            if i == 9 { return "Synthcoke + Alcohol combo"; }
            if i == 10 { return "Multiple substances (Poly-drug)"; }
            if i == 11 { return "IV drug use"; }
            if i == 12 { return "Bootleg pharmaceuticals"; }
            if i == 13 { return "Unknown street drug"; }
            return "XBD Addiction (Extreme)";
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            // Corporate-appropriate addictions (12)
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Work (Corporate Burnout)"; }
            if i == 1 { return "Alcohol (Functioning)"; }
            if i == 2 { return "Alcohol (Hidden problem)"; }
            if i == 3 { return "Prescription stimulants"; }
            if i == 4 { return "Sleeping pills (Dependency)"; }
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
            if i == 0 { return "Black Lace (Combat prep)"; }
            if i == 1 { return "Smash (Violence enhancer)"; }
            if i == 2 { return "Alcohol (Heavy)"; }
            if i == 3 { return "S-Keef (Social use)"; }
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
        if i == 2 { return "Alcohol (Binge pattern)"; }
        if i == 3 { return "Alcohol (Daily use)"; }
        if i == 4 { return "Alcohol (In recovery)"; }
        if i == 5 { return "Alcohol + Other substances"; }
        
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
        if i == 19 { return "Designer drugs (Various)"; }
        
        // Prescription (20-26)
        if i == 20 { return "Prescription Medication Misuse"; }
        if i == 21 { return "Sedatives (Self-Medicating)"; }
        if i == 22 { return "Stimulants (Prescription)"; }
        if i == 23 { return "Painkillers (Dependency)"; }
        if i == 24 { return "Anti-anxiety meds (Abuse)"; }
        if i == 25 { return "Sleeping aids (Dependency)"; }
        if i == 26 { return "Mood stabilizers (Overuse)"; }
        
        // Behavioral (27-37)
        if i == 27 { return "Braindance (Compulsive)"; }
        if i == 28 { return "Braindance (XBD - Illegal)"; }
        if i == 29 { return "Gambling"; }
        if i == 30 { return "Gambling (Severe)"; }
        if i == 31 { return "Cyberware (Chrome Addiction)"; }
        if i == 32 { return "Sex/Pornography"; }
        if i == 33 { return "Shopping (Compulsive)"; }
        if i == 34 { return "Gaming (Excessive)"; }
        if i == 35 { return "Social media"; }
        if i == 36 { return "Food (Compulsive eating)"; }
        if i == 37 { return "Exercise (Compulsive)"; }
        
        // Other (38-44)
        if i == 38 { return "Caffeine (Extreme)"; }
        if i == 39 { return "Sugar (Compulsive)"; }
        if i == 40 { return "Adrenaline (Thrill-seeking)"; }
        if i == 41 { return "Attention/Validation"; }
        if i == 42 { return "Control (Behavioral)"; }
        if i == 43 { return "Self-harm (Pattern)"; }
        return "Multiple addictions (Co-occurring)";
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
            if i == 0 { return "Gang initiation violence (" + IntToString(year) + ")"; }
            if i == 1 { return "Lost crew members to rivals (" + IntToString(year) + ")"; }
            if i == 2 { return "Drive-by survivor (" + IntToString(year) + ")"; }
            if i == 3 { return "Incarceration trauma (" + IntToString(year) + ")"; }
            if i == 4 { return "Betrayed by gang member (" + IntToString(year) + ")"; }
            if i == 5 { return "Witnessed execution (" + IntToString(year) + ")"; }
            if i == 6 { return "Tortured by rivals (" + IntToString(year) + ")"; }
            if i == 7 { return "Police brutality victim (" + IntToString(year) + ")"; }
            if i == 8 { return "Lost sibling to streets (" + IntToString(year) + ")"; }
            return "Forced to commit violence (" + IntToString(year) + ")";
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            if RandRange(seed + 50, 1, 100) <= 50 {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Corporate betrayal (" + IntToString(year) + ")"; }
                if i == 1 { return "Hostile takeover survivor (" + IntToString(year) + ")"; }
                if i == 2 { return "Workplace violence incident (" + IntToString(year) + ")"; }
                if i == 3 { return "Career destruction event (" + IntToString(year) + ")"; }
                if i == 4 { return "Witnessed colleague's breakdown (" + IntToString(year) + ")"; }
                if i == 5 { return "Corporate espionage victim (" + IntToString(year) + ")"; }
                if i == 6 { return "Blackmail victim (" + IntToString(year) + ")"; }
                return "Burnout/breakdown (" + IntToString(year) + ")";
            }
        }
        
        if Equals(archetype, "NOMAD") && RandRange(seed + 50, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "Clan massacre survivor (" + IntToString(year) + ")"; }
            if i == 1 { return "Badlands ambush (" + IntToString(year) + ")"; }
            if i == 2 { return "Lost family in desert (" + IntToString(year) + ")"; }
            if i == 3 { return "Raider attack survivor (" + IntToString(year) + ")"; }
            if i == 4 { return "Exile from clan (" + IntToString(year) + ")"; }
            if i == 5 { return "Vehicle accident (severe) (" + IntToString(year) + ")"; }
            if i == 6 { return "Corporate land seizure (" + IntToString(year) + ")"; }
            return "Lost entire convoy (" + IntToString(year) + ")";
        }
        
        // General trauma pool (50)
        let i = RandRange(seed, 0, 49);
        
        // Violence traumas (0-14)
        if i == 0 { return "Witnessed violent death (" + IntToString(year) + ")"; }
        if i == 1 { return "Victim of violent crime (" + IntToString(year) + ")"; }
        if i == 2 { return "Gang-related violence (" + IntToString(year) + ")"; }
        if i == 3 { return "Combat trauma (" + IntToString(year) + ")"; }
        if i == 4 { return "Near-death experience (" + IntToString(year) + ")"; }
        if i == 5 { return "Shooting victim (" + IntToString(year) + ")"; }
        if i == 6 { return "Stabbing victim (" + IntToString(year) + ")"; }
        if i == 7 { return "Assault survivor (" + IntToString(year) + ")"; }
        if i == 8 { return "Kidnapping survivor (" + IntToString(year) + ")"; }
        if i == 9 { return "Hostage situation (" + IntToString(year) + ")"; }
        if i == 10 { return "Torture survivor (" + IntToString(year) + ")"; }
        if i == 11 { return "Home invasion (" + IntToString(year) + ")"; }
        if i == 12 { return "Mugging (violent) (" + IntToString(year) + ")"; }
        if i == 13 { return "Carjacking victim (" + IntToString(year) + ")"; }
        if i == 14 { return "Cyberpsycho encounter (" + IntToString(year) + ")"; }
        
        // Loss traumas (15-24)
        if i == 15 { return "Loss of family member (" + IntToString(year) + ")"; }
        if i == 16 { return "Loss of child (" + IntToString(year) + ")"; }
        if i == 17 { return "Loss of spouse/partner (" + IntToString(year) + ")"; }
        if i == 18 { return "Loss of parent (" + IntToString(year) + ")"; }
        if i == 19 { return "Loss of sibling (" + IntToString(year) + ")"; }
        if i == 20 { return "Loss of close friend (" + IntToString(year) + ")"; }
        if i == 21 { return "Multiple losses (" + IntToString(year) + ")"; }
        if i == 22 { return "Miscarriage/Stillbirth (" + IntToString(year) + ")"; }
        if i == 23 { return "Pet death (significant) (" + IntToString(year) + ")"; }
        if i == 24 { return "Sudden unexpected death (" + IntToString(year) + ")"; }
        
        // Childhood/Development (25-32)
        if i == 25 { return "Childhood abuse (" + IntToString(year) + ")"; }
        if i == 26 { return "Childhood neglect (" + IntToString(year) + ")"; }
        if i == 27 { return "Parental abandonment (" + IntToString(year) + ")"; }
        if i == 28 { return "Foster system trauma (" + IntToString(year) + ")"; }
        if i == 29 { return "Bullying (severe) (" + IntToString(year) + ")"; }
        if i == 30 { return "Witnessed domestic violence (" + IntToString(year) + ")"; }
        if i == 31 { return "Early life poverty (" + IntToString(year) + ")"; }
        if i == 32 { return "Parentification (" + IntToString(year) + ")"; }
        
        // Accidents/Disasters (33-40)
        if i == 33 { return "Major vehicle accident (" + IntToString(year) + ")"; }
        if i == 34 { return "Industrial accident (" + IntToString(year) + ")"; }
        if i == 35 { return "Building collapse (" + IntToString(year) + ")"; }
        if i == 36 { return "Fire survivor (" + IntToString(year) + ")"; }
        if i == 37 { return "Natural disaster (" + IntToString(year) + ")"; }
        if i == 38 { return "Cyberware malfunction trauma (" + IntToString(year) + ")"; }
        if i == 39 { return "Medical emergency (" + IntToString(year) + ")"; }
        if i == 40 { return "Near-drowning (" + IntToString(year) + ")"; }
        
        // Other (41-49)
        if i == 41 { return "Imprisonment (" + IntToString(year) + ")"; }
        if i == 42 { return "Refugee displacement (" + IntToString(year) + ")"; }
        if i == 43 { return "Abusive relationship (" + IntToString(year) + ")"; }
        if i == 44 { return "Sexual trauma (" + IntToString(year) + ")"; }
        if i == 45 { return "Medical trauma (" + IntToString(year) + ")"; }
        if i == 46 { return "Addiction-related trauma (" + IntToString(year) + ")"; }
        if i == 47 { return "Prolonged homelessness (" + IntToString(year) + ")"; }
        if i == 48 { return "Identity theft/destruction (" + IntToString(year) + ")"; }
        return "Cyberpsychosis episode (witnessed) (" + IntToString(year) + ")";
    }

    private static func GeneratePsychEvaluation(seed: Int32, archetype: String, profile: ref<PsychProfileData>) -> String {
        if profile.threatLevel >= 70 {
            return "HIGH RISK - Professional intervention recommended. Subject displays multiple concerning indicators.";
        }
        if profile.threatLevel >= 50 {
            return "MODERATE RISK - Monitoring advised. Potential for escalation under stress.";
        }
        if ArraySize(profile.addictions) > 0 {
            return "AT RISK - Addiction issues noted. Behavior may be unpredictable.";
        }
        if ArraySize(profile.traumaEvents) > 1 {
            return "ELEVATED CONCERN - Multiple trauma indicators. Therapeutic support recommended.";
        }
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            return "STABLE - Within normal parameters for socioeconomic group.";
        }
        return "STABLE - No immediate concerns. Routine monitoring sufficient.";
    }

    private static func GenerateLastEvalDate(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            return IntToString(RandRange(seed, 2075, 2077)) + " (Corporate Mandatory)";
        }
        if RandRange(seed, 1, 100) <= 30 {
            return IntToString(RandRange(seed, 2070, 2076));
        }
        return "NO EVALUATION ON FILE";
    }

    private static func CalculateStabilityScore(profile: ref<PsychProfileData>, cyberware: ref<CyberwareRegistryData>) -> Int32 {
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

    private static func HasVendetta(seed: Int32, archetype: String, criminal: ref<CriminalRecordData>) -> Bool {
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
            if i == 9 { return "Rival Gang Member (Specific)"; }
            if i == 10 { return "Former Gang Leader"; }
            if i == 11 { return "Snitch Within Gang"; }
            if i == 12 { return "NCPD Gang Unit"; }
            if i == 13 { return "Dealer Who Cheated Them"; }
            return "Ex-Partner (Gang Related)";
        }
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            // Corporate targets (10)
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "ARASAKA CORPORATION"; }
            if i == 1 { return "MILITECH"; }
            if i == 2 { return "Former Employer"; }
            if i == 3 { return "Rival Executive"; }
            if i == 4 { return "Board Member (Specific)"; }
            if i == 5 { return "Former Business Partner"; }
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
            if i == 3 { return "NCPD Border Patrol"; }
            if i == 4 { return "WRAITHS (Raider Clan)"; }
            if i == 5 { return "Corporate Land Grabbers"; }
            if i == 6 { return "Clan Elder (Exiled By)"; }
            if i == 7 { return "Biotechnica"; }
            if i == 8 { return "Former Clan Member (Traitor)"; }
            return "Night City Officials";
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
        if i == 9 { return "Corporate Entity (Unspecified)"; }
        
        // Law Enforcement (10-14)
        if i == 10 { return "NCPD"; }
        if i == 11 { return "NCPD Officer (Specific)"; }
        if i == 12 { return "MAXTAC"; }
        if i == 13 { return "Night City Courts"; }
        if i == 14 { return "Prison System"; }
        
        // Gangs (15-22)
        if i == 15 { return "TYGER CLAWS"; }
        if i == 16 { return "MAELSTROM"; }
        if i == 17 { return "VALENTINOS"; }
        if i == 18 { return "6TH STREET"; }
        if i == 19 { return "ANIMALS"; }
        if i == 20 { return "VOODOO BOYS"; }
        if i == 21 { return "SCAVENGERS"; }
        if i == 22 { return "Local Gang (Unspecified)"; }
        
        // Personal (23-34)
        if i == 23 { return "Unknown Individual"; }
        if i == 24 { return "Family Member (Estranged)"; }
        if i == 25 { return "Ex-Spouse/Partner"; }
        if i == 26 { return "Former Friend"; }
        if i == 27 { return "Neighbor"; }
        if i == 28 { return "Landlord/Property Owner"; }
        if i == 29 { return "Loan Shark"; }
        if i == 30 { return "Ripperdoc (Botched Job)"; }
        if i == 31 { return "Fixer (Betrayal)"; }
        if i == 32 { return "Medical System"; }
        if i == 33 { return "Parent/Guardian"; }
        return "The System (General)";
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
                else if j == 1 { ArrayPush(flags, "Free Market Absolutist"); }
                else if j == 2 { ArrayPush(flags, "Meritocracy Believer"); }
                else if j == 3 { ArrayPush(flags, "Corporate Loyalist"); }
                else if j == 4 { ArrayPush(flags, "Techno-Optimist"); }
                else if j == 5 { ArrayPush(flags, "Status Quo Defender"); }
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
                else if j == 3 { ArrayPush(flags, "Street Code Adherent"); }
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
                if j == 0 { ArrayPush(flags, "Nomad Clan First"); }
                else if j == 1 { ArrayPush(flags, "Freedom Absolutist"); }
                else if j == 2 { ArrayPush(flags, "Anti-Corporate"); }
                else if j == 3 { ArrayPush(flags, "Self-Reliance Philosophy"); }
                else if j == 4 { ArrayPush(flags, "Family/Clan Loyalty"); }
                else if j == 5 { ArrayPush(flags, "Distrust of Cities"); }
                else if j == 6 { ArrayPush(flags, "Environmental Concern"); }
                else if j == 7 { ArrayPush(flags, "Traditional Values"); }
                else if j == 8 { ArrayPush(flags, "Libertarian"); }
                else { ArrayPush(flags, "Road Culture Adherent"); }
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
            else if j == 14 { ArrayPush(flags, "AI Rights Advocate"); }
            
            // Social (15-24)
            else if j == 15 { ArrayPush(flags, "Gang Loyalist"); }
            else if j == 16 { ArrayPush(flags, "Nomad Clan First"); }
            else if j == 17 { ArrayPush(flags, "Religious (Specific Sect)"); }
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
            else if j == 28 { ArrayPush(flags, "Cult Member (Suspected)"); }
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

    private static func GenerateRiskFactors(seed: Int32, archetype: String, profile: ref<PsychProfileData>) -> array<String> {
        let factors: array<String>;

        if profile.threatLevel >= 60 {
            ArrayPush(factors, "High threat profile");
        }
        if profile.hasAddictions {
            ArrayPush(factors, "Active addiction issues");
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

    private static func GenerateHandlingRecommendation(profile: ref<PsychProfileData>) -> String {
        if profile.threatLevel >= 80 {
            return "EXTREME CAUTION. MaxTac referral may be warranted. Do not engage without significant backup.";
        }
        if profile.threatLevel >= 60 {
            return "HIGH CAUTION. Armed backup recommended. De-escalation training useful.";
        }
        if profile.threatLevel >= 40 {
            return "STANDARD CAUTION. Follow routine protocols. Be prepared for potential resistance.";
        }
        if profile.stabilityScore < 40 {
            return "PSYCHOLOGICAL SENSITIVITY. Avoid confrontational approach. Crisis intervention training recommended.";
        }
        return "ROUTINE. Standard engagement protocols sufficient.";
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
            return "Prone to mood swings";
        }
        if stabilityScore >= 20 {
            return "Erratic behavior patterns";
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
            if i == 6 { return "Charming but ruthless"; }
            if i == 7 { return "Networking constantly"; }
            if i == 8 { return "Stressed but composed"; }
            if i == 9 { return "Competitive to a fault"; }
            if i == 10 { return "Image-obsessed"; }
            if i == 11 { return "Distrustful of subordinates"; }
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
            if i == 5 { return "Exhausted but persistent"; }
            if i == 6 { return "Dreaming of promotion"; }
            if i == 7 { return "Resigned to fate"; }
            if i == 8 { return "Passive-aggressive"; }
            if i == 9 { return "Clock-watching"; }
            if i == 10 { return "Secretly resentful"; }
            if i == 11 { return "Living for weekends"; }
            if i == 12 { return "Anxious about job security"; }
            if i == 13 { return "Going through the motions"; }
            return "Burned out but functional";
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
            if i == 11 { return "Appearance over substance"; }
            if i == 12 { return "Influencer aspirant"; }
            if i == 13 { return "Debt-funded lifestyle"; }
            return "Living beyond means";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Territorial"; }
            if i == 1 { return "Loyalty to crew"; }
            if i == 2 { return "Distrustful of outsiders"; }
            if i == 3 { return "Street-smart"; }
            if i == 4 { return "Confrontational"; }
            if i == 5 { return "Hair-trigger temper"; }
            if i == 6 { return "Proud of reputation"; }
            if i == 7 { return "Vengeful"; }
            if i == 8 { return "Protective of family"; }
            if i == 9 { return "Honor-bound"; }
            if i == 10 { return "Ruthless when necessary"; }
            if i == 11 { return "Ambitious within gang"; }
            if i == 12 { return "Tired of the life"; }
            if i == 13 { return "Ride or die mentality"; }
            return "Survivor mentality";
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Clan-oriented"; }
            if i == 1 { return "Self-reliant"; }
            if i == 2 { return "Distrustful of corpos"; }
            if i == 3 { return "Freedom-seeking"; }
            if i == 4 { return "Resourceful"; }
            if i == 5 { return "Wanderlust"; }
            if i == 6 { return "Fiercely independent"; }
            if i == 7 { return "Protective of family"; }
            if i == 8 { return "Road-hardened"; }
            if i == 9 { return "Suspicious of cities"; }
            if i == 10 { return "Traditional values"; }
            if i == 11 { return "Practical mindset"; }
            if i == 12 { return "Tight-knit loyalty"; }
            if i == 13 { return "Adaptable survivor"; }
            return "Open road philosophy";
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Opportunistic"; }
            if i == 1 { return "Survival-focused"; }
            if i == 2 { return "Cynical outlook"; }
            if i == 3 { return "Adaptable"; }
            if i == 4 { return "Street-wise"; }
            if i == 5 { return "Hustler mentality"; }
            if i == 6 { return "Quick to exploit"; }
            if i == 7 { return "Distrustful"; }
            if i == 8 { return "Bitter but resilient"; }
            if i == 9 { return "Day-to-day survivor"; }
            if i == 10 { return "Small-time schemer"; }
            if i == 11 { return "Looking for angle"; }
            if i == 12 { return "Worn down by life"; }
            if i == 13 { return "Pragmatic pessimist"; }
            return "Whatever it takes";
        }
        
        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Fixation on next fix"; }
            if i == 1 { return "Unpredictable"; }
            if i == 2 { return "Desperate"; }
            if i == 3 { return "Withdrawn"; }
            if i == 4 { return "Paranoid tendencies"; }
            if i == 5 { return "Erratic mood swings"; }
            if i == 6 { return "Manipulative when using"; }
            if i == 7 { return "Charming when sober"; }
            if i == 8 { return "Shame-filled"; }
            if i == 9 { return "Denial of problem"; }
            if i == 10 { return "Fleeting moments of clarity"; }
            if i == 11 { return "Self-destructive"; }
            if i == 12 { return "Burned all bridges"; }
            if i == 13 { return "Wants help but can't ask"; }
            return "Lost in addiction";
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Survival-focused"; }
            if i == 1 { return "Withdrawn from society"; }
            if i == 2 { return "Distrustful"; }
            if i == 3 { return "Day-to-day existence"; }
            if i == 4 { return "Resigned outlook"; }
            if i == 5 { return "Invisible to society"; }
            if i == 6 { return "Unexpectedly wise"; }
            if i == 7 { return "Mentally fragile"; }
            if i == 8 { return "Former professional"; }
            if i == 9 { return "Proud despite circumstances"; }
            if i == 10 { return "Helpful to other homeless"; }
            if i == 11 { return "Talks to self"; }
            if i == 12 { return "Haunted by past"; }
            if i == 13 { return "One bad break away"; }
            return "Clinging to dignity";
        }
        
        // CIVVIE and default (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Average citizen"; }
        if i == 1 { return "Keeps to themselves"; }
        if i == 2 { return "Family-oriented"; }
        if i == 3 { return "Work-focused"; }
        if i == 4 { return "Community-minded"; }
        if i == 5 { return "Cautious optimist"; }
        if i == 6 { return "Apolitical"; }
        if i == 7 { return "Private individual"; }
        if i == 8 { return "Friendly neighbor"; }
        if i == 9 { return "Hardworking"; }
        if i == 10 { return "Quietly struggling"; }
        if i == 11 { return "Hoping for better"; }
        if i == 12 { return "Tired but trying"; }
        if i == 13 { return "Simple pleasures"; }
        if i == 14 { return "Mind their own business"; }
        if i == 15 { return "Salt of the earth"; }
        if i == 16 { return "Getting by"; }
        if i == 17 { return "Worried about future"; }
        if i == 18 { return "Content with little"; }
        return "Just trying to survive";
    }
}

public class PsychProfileData {
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
