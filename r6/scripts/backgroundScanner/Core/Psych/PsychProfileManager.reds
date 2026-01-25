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
        if threatLevel >= 80 { return "EXTREME DANGER - ARMED RESPONSE RECOMMENDED"; }
        if threatLevel >= 60 { return "HIGH THREAT - APPROACH WITH CAUTION"; }
        if threatLevel >= 40 { return "MODERATE THREAT - STANDARD PRECAUTIONS"; }
        if threatLevel >= 20 { return "LOW THREAT - ROUTINE ENGAGEMENT"; }
        return "MINIMAL THREAT - STANDARD APPROACH";
    }

    private static func AssessCombatTraining(seed: Int32, archetype: String) -> String {
        let trainings: array<String>;

        if Equals(archetype, "CORPO_MANAGER") {
            ArrayPush(trainings, "Corporate Self-Defense Training");
            ArrayPush(trainings, "Executive Protection Awareness");
            ArrayPush(trainings, "None Detected");
        } else if Equals(archetype, "GANGER") {
            ArrayPush(trainings, "Street Combat (Experienced)");
            ArrayPush(trainings, "Gang Warfare Training");
            ArrayPush(trainings, "Military Training (Suspected)");
            ArrayPush(trainings, "Melee Combat Specialist");
            ArrayPush(trainings, "Firearms Training (Informal)");
        } else if Equals(archetype, "NOMAD") {
            ArrayPush(trainings, "Wilderness Survival");
            ArrayPush(trainings, "Vehicle Combat Training");
            ArrayPush(trainings, "Firearms Proficiency");
            ArrayPush(trainings, "Pack Defense Tactics");
        } else {
            ArrayPush(trainings, "None Detected");
            ArrayPush(trainings, "Basic Self-Defense");
            ArrayPush(trainings, "Minimal");
            ArrayPush(trainings, "Unknown");
        }

        return trainings[RandRange(seed, 0, ArraySize(trainings) - 1)];
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
        let traits: array<String>;

        // Neutral traits
        ArrayPush(traits, "Introverted");
        ArrayPush(traits, "Extroverted");
        ArrayPush(traits, "Analytical");
        ArrayPush(traits, "Creative");
        ArrayPush(traits, "Pragmatic");
        ArrayPush(traits, "Idealistic");
        ArrayPush(traits, "Reserved");
        ArrayPush(traits, "Outspoken");

        // Positive traits
        ArrayPush(traits, "Loyal");
        ArrayPush(traits, "Resourceful");
        ArrayPush(traits, "Calm under pressure");
        ArrayPush(traits, "Protective");
        ArrayPush(traits, "Adaptable");

        // Negative traits
        ArrayPush(traits, "Prone to violence when threatened");
        ArrayPush(traits, "Impulsive");
        ArrayPush(traits, "Distrustful of authority");
        ArrayPush(traits, "Paranoid tendencies");
        ArrayPush(traits, "Risk-taking behavior");
        ArrayPush(traits, "Difficulty with authority");
        ArrayPush(traits, "Emotionally volatile");
        ArrayPush(traits, "Manipulative");
        ArrayPush(traits, "Antisocial tendencies");

        // Archetype-weighted selection
        if Equals(archetype, "GANGER") {
            if RandRange(seed + 5, 1, 100) <= 60 {
                return traits[RandRange(seed, 13, ArraySize(traits) - 1)]; // Lean negative
            }
        }
        if Equals(archetype, "CORPO_MANAGER") {
            if RandRange(seed + 5, 1, 100) <= 40 {
                return traits[RandRange(seed, 8, 12)]; // Lean positive
            }
        }

        return traits[RandRange(seed, 0, ArraySize(traits) - 1)];
    }

    private static func GenerateBehavioralFlag(seed: Int32, archetype: String) -> String {
        let flags: array<String>;

        ArrayPush(flags, "History of violent outbursts");
        ArrayPush(flags, "Known to carry concealed weapons");
        ArrayPush(flags, "Previous resistance to arrest");
        ArrayPush(flags, "Gang-related activities suspected");
        ArrayPush(flags, "Possible underground connections");
        ArrayPush(flags, "Financial desperation noted");
        ArrayPush(flags, "Erratic behavior reported");
        ArrayPush(flags, "Known to flee when confronted");
        ArrayPush(flags, "Associates with known criminals");
        ArrayPush(flags, "Possible information broker");
        ArrayPush(flags, "History of fraud");
        ArrayPush(flags, "Substance abuse affects judgment");
        ArrayPush(flags, "Protective of specific individuals");
        ArrayPush(flags, "Anti-corporate sentiment");
        ArrayPush(flags, "Known to use violence preemptively");

        return flags[RandRange(seed, 0, ArraySize(flags) - 1)];
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
        let addictions: array<String>;

        ArrayPush(addictions, "Alcohol (Moderate)");
        ArrayPush(addictions, "Alcohol (Severe)");
        ArrayPush(addictions, "Tobacco/Nicotine");
        ArrayPush(addictions, "Synth-Cocaine (Black Lace)");
        ArrayPush(addictions, "Glitter");
        ArrayPush(addictions, "Dorph");
        ArrayPush(addictions, "S-Keef");
        ArrayPush(addictions, "Braindance (Compulsive)");
        ArrayPush(addictions, "Braindance (XBD - Illegal)");
        ArrayPush(addictions, "Gambling");
        ArrayPush(addictions, "Cyberware (Chrome Addiction)");
        ArrayPush(addictions, "Work (Corporate Burnout)");
        ArrayPush(addictions, "Stimulants (Various)");
        ArrayPush(addictions, "Sedatives (Self-Medicating)");
        ArrayPush(addictions, "Prescription Medication Misuse");

        if Equals(archetype, "JUNKIE") {
            return addictions[RandRange(seed, 3, 8)]; // Harder substances
        }
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                return addictions[RandRange(seed, 0, 2)]; // Alcohol/tobacco
            }
            return addictions[11]; // Work addiction
        }

        return addictions[RandRange(seed, 0, ArraySize(addictions) - 1)];
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
        let traumas: array<String>;

        ArrayPush(traumas, "Witnessed violent death");
        ArrayPush(traumas, "Childhood abuse");
        ArrayPush(traumas, "Combat trauma");
        ArrayPush(traumas, "Loss of family member");
        ArrayPush(traumas, "Near-death experience");
        ArrayPush(traumas, "Victim of violent crime");
        ArrayPush(traumas, "Gang-related violence");
        ArrayPush(traumas, "Corporate betrayal");
        ArrayPush(traumas, "Cyberpsychosis episode (witnessed)");
        ArrayPush(traumas, "Prolonged homelessness");
        ArrayPush(traumas, "Abusive relationship");
        ArrayPush(traumas, "Refugee displacement");
        ArrayPush(traumas, "Medical trauma");
        ArrayPush(traumas, "Imprisonment");
        ArrayPush(traumas, "Natural disaster survivor");
        ArrayPush(traumas, "Addiction-related trauma");

        return traumas[RandRange(seed, 0, ArraySize(traumas) - 1)];
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
        if score >= 80 { return "STABLE"; }
        if score >= 60 { return "MOSTLY STABLE"; }
        if score >= 40 { return "UNSTABLE"; }
        if score >= 20 { return "HIGHLY UNSTABLE"; }
        return "CRITICAL - INTERVENTION NEEDED";
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
        let targets: array<String>;

        ArrayPush(targets, "ARASAKA CORPORATION");
        ArrayPush(targets, "MILITECH");
        ArrayPush(targets, "NCPD");
        ArrayPush(targets, "TYGER CLAWS");
        ArrayPush(targets, "MAELSTROM");
        ArrayPush(targets, "VALENTINOS");
        ArrayPush(targets, "6TH STREET");
        ArrayPush(targets, "ANIMALS");
        ArrayPush(targets, "VOODOO BOYS");
        ArrayPush(targets, "Unknown Individual");
        ArrayPush(targets, "Former Employer");
        ArrayPush(targets, "Family Member (Estranged)");
        ArrayPush(targets, "TRAUMA TEAM");

        return targets[RandRange(seed, 0, ArraySize(targets) - 1)];
    }

    private static func GenerateIdeologyFlags(seed: Int32, archetype: String) -> array<String> {
        let flags: array<String>;
        let ideology: array<String>;

        ArrayPush(ideology, "Anti-Corporate");
        ArrayPush(ideology, "Pro-Corporate");
        ArrayPush(ideology, "Anarchist Sympathizer");
        ArrayPush(ideology, "Nationalist (NUSA)");
        ArrayPush(ideology, "Transhumanist");
        ArrayPush(ideology, "Bioconservative");
        ArrayPush(ideology, "Gang Loyalist");
        ArrayPush(ideology, "Nomad Clan First");
        ArrayPush(ideology, "Religious (Specific Sect)");
        ArrayPush(ideology, "Apolitical");
        ArrayPush(ideology, "Survivalist");
        ArrayPush(ideology, "Revolutionary");

        // 0-2 ideology flags
        let count = RandRange(seed, 0, 2);
        let i = 0;
        while i < count {
            ArrayPush(flags, ideology[RandRange(seed + (i * 19), 0, ArraySize(ideology) - 1)]);
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
        let dispositions: array<String>;
        
        if Equals(archetype, "CORPO_MANAGER") {
            ArrayPush(dispositions, "Ambitious, calculating");
            ArrayPush(dispositions, "Professional demeanor");
            ArrayPush(dispositions, "Status-conscious");
            ArrayPush(dispositions, "Guarded, political");
            ArrayPush(dispositions, "Results-driven");
        } else if Equals(archetype, "CORPO_DRONE") {
            ArrayPush(dispositions, "Compliant, risk-averse");
            ArrayPush(dispositions, "Routine-oriented");
            ArrayPush(dispositions, "Quietly ambitious");
            ArrayPush(dispositions, "Stressed, overworked");
            ArrayPush(dispositions, "Corporate loyalist");
        } else if Equals(archetype, "YUPPIE") {
            ArrayPush(dispositions, "Image-conscious");
            ArrayPush(dispositions, "Trend-follower");
            ArrayPush(dispositions, "Socially active");
            ArrayPush(dispositions, "Materialistic");
            ArrayPush(dispositions, "Upwardly mobile");
        } else if Equals(archetype, "GANGER") {
            ArrayPush(dispositions, "Territorial");
            ArrayPush(dispositions, "Loyalty to crew");
            ArrayPush(dispositions, "Distrustful of outsiders");
            ArrayPush(dispositions, "Street-smart");
            ArrayPush(dispositions, "Confrontational");
        } else if Equals(archetype, "NOMAD") {
            ArrayPush(dispositions, "Clan-oriented");
            ArrayPush(dispositions, "Self-reliant");
            ArrayPush(dispositions, "Distrustful of corpos");
            ArrayPush(dispositions, "Freedom-seeking");
            ArrayPush(dispositions, "Resourceful");
        } else if Equals(archetype, "LOWLIFE") {
            ArrayPush(dispositions, "Opportunistic");
            ArrayPush(dispositions, "Survival-focused");
            ArrayPush(dispositions, "Cynical outlook");
            ArrayPush(dispositions, "Adaptable");
            ArrayPush(dispositions, "Street-wise");
        } else if Equals(archetype, "JUNKIE") {
            ArrayPush(dispositions, "Fixation on next fix");
            ArrayPush(dispositions, "Unpredictable");
            ArrayPush(dispositions, "Desperate");
            ArrayPush(dispositions, "Withdrawn");
            ArrayPush(dispositions, "Paranoid tendencies");
        } else if Equals(archetype, "HOMELESS") {
            ArrayPush(dispositions, "Survival-focused");
            ArrayPush(dispositions, "Withdrawn from society");
            ArrayPush(dispositions, "Distrustful");
            ArrayPush(dispositions, "Day-to-day existence");
            ArrayPush(dispositions, "Resigned outlook");
        } else {
            // CIVVIE and default
            ArrayPush(dispositions, "Average citizen");
            ArrayPush(dispositions, "Keeps to themselves");
            ArrayPush(dispositions, "Family-oriented");
            ArrayPush(dispositions, "Work-focused");
            ArrayPush(dispositions, "Community-minded");
            ArrayPush(dispositions, "Cautious optimist");
            ArrayPush(dispositions, "Apolitical");
            ArrayPush(dispositions, "Private individual");
        }
        
        return dispositions[RandRange(seed, 0, ArraySize(dispositions) - 1)];
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
