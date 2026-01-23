// Psychological Assessment Generation System
public class PsychProfileManager {

    public static func Generate(seed: Int32, archetype: String, criminalRecord: ref<CriminalRecordData>, cyberware: ref<CyberwareRegistryData>) -> ref<PsychProfileData> {
        let profile: ref<PsychProfileData> = new PsychProfileData();

        // Threat assessment
        profile.threatLevel = PsychProfileManager.CalculateThreatLevel(seed, archetype, criminalRecord, cyberware);
        profile.threatColor = PsychProfileManager.GetThreatColor(profile.threatLevel);
        profile.threatDescription = PsychProfileManager.GetThreatDescription(profile.threatLevel, archetype);

        // Combat assessment
        profile.combatTraining = PsychProfileManager.AssessCombatTraining(seed + 100, archetype);
        profile.armedLikelihood = PsychProfileManager.AssessArmedLikelihood(seed + 110, archetype, criminalRecord);
        profile.approachRecommendation = PsychProfileManager.GetApproachRecommendation(profile.threatLevel, profile.armedLikelihood);

        // Personality traits
        let traitCount = RandRange(seed + 200, 2, 5);
        let i = 0;
        while i < traitCount {
            ArrayPush(profile.personalityTraits, PsychProfileManager.GeneratePersonalityTrait(seed + 210 + (i * 31), archetype));
            i += 1;
        }

        // Behavioral flags
        let flagCount = RandRange(seed + 300, 0, 3);
        i = 0;
        while i < flagCount {
            ArrayPush(profile.behavioralFlags, PsychProfileManager.GenerateBehavioralFlag(seed + 310 + (i * 37), archetype));
            i += 1;
        }

        // Addictions
        profile.hasAddictions = PsychProfileManager.HasAddictions(seed + 400, archetype);
        if profile.hasAddictions {
            let addictionCount = RandRange(seed + 410, 1, 3);
            i = 0;
            while i < addictionCount {
                ArrayPush(profile.addictions, PsychProfileManager.GenerateAddiction(seed + 420 + (i * 43), archetype));
                i += 1;
            }
        }

        // Trauma history
        let traumaChance = PsychProfileManager.GetTraumaChance(archetype);
        if RandRange(seed + 500, 1, 100) <= traumaChance {
            let traumaCount = RandRange(seed + 510, 1, 3);
            i = 0;
            while i < traumaCount {
                ArrayPush(profile.traumaEvents, PsychProfileManager.GenerateTraumaEvent(seed + 520 + (i * 47), archetype));
                i += 1;
            }
        }

        // Psychological evaluation
        profile.psychEvaluation = PsychProfileManager.GeneratePsychEvaluation(seed + 600, archetype, profile);
        profile.lastEvalDate = PsychProfileManager.GenerateLastEvalDate(seed + 610, archetype);

        // Stability assessment
        profile.stabilityScore = PsychProfileManager.CalculateStabilityScore(profile, cyberware);
        profile.stabilityRating = PsychProfileManager.GetStabilityRating(profile.stabilityScore);

        // Known vendettas
        if PsychProfileManager.HasVendetta(seed + 700, archetype, criminalRecord) {
            profile.hasVendetta = true;
            profile.vendettaTarget = PsychProfileManager.GenerateVendettaTarget(seed + 710, archetype);
        }

        // Ideology / beliefs
        profile.ideologyFlags = PsychProfileManager.GenerateIdeologyFlags(seed + 800, archetype);

        // Risk factors
        profile.riskFactors = PsychProfileManager.GenerateRiskFactors(seed + 900, archetype, profile);

        // Recommendation
        profile.handlingRecommendation = PsychProfileManager.GenerateHandlingRecommendation(profile);

        return profile;
    }

    private static func CalculateThreatLevel(seed: Int32, archetype: String, criminal: ref<CriminalRecordData>, cyberware: ref<CyberwareRegistryData>) -> Int32 {
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

        // Criminal record - reduced impact
        if criminal.hasRecord {
            base += ArraySize(criminal.arrests) * 2;
            if !Equals(criminal.warrantStatus, "NONE") && !Equals(criminal.warrantStatus, "CLEARED") { 
                if StrContains(criminal.warrantStatus, "VIOLENT") { base += 15; }
                else { base += 8; }
            }
            if StrContains(criminal.ncpdClassification, "HIGH") { base += 15; }
            else if StrContains(criminal.ncpdClassification, "ELEVATED") { base += 8; }
        }

        // Cyberware - only combat implants matter
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
