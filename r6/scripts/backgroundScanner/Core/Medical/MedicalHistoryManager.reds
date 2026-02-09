// Medical History Generation System
public class MedicalHistoryManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String, age: Int32) -> ref<MedicalHistoryData> {
        return MedicalHistoryManager.GenerateCoherent(seed, archetype, age, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, age: Int32, coherence: ref<CoherenceProfile>) -> ref<MedicalHistoryData> {
        let medical: ref<MedicalHistoryData> = new MedicalHistoryData();
        let density = KiroshiSettings.GetDataDensity();

        // Basic info - always shown
        medical.bloodType = MedicalHistoryManager.GenerateBloodType(seed);
        medical.age = age;
        medical.biologicalAge = MedicalHistoryManager.CalculateBiologicalAgeCoherent(seed + 10, age, archetype, coherence);
        
        // Physical stats - only on medium/high
        if density >= 2 {
            medical.height = MedicalHistoryManager.GenerateHeight(seed + 20, archetype);
            medical.weight = MedicalHistoryManager.GenerateWeight(seed + 30, archetype);
        }

        // Conditions - limited by density
        let conditionCount = MedicalHistoryManager.GetConditionCountCoherent(seed + 100, archetype, age, coherence);
        conditionCount = KiroshiSettings.GetMaxListItems(conditionCount);
        
        let i = 0;
        while i < conditionCount {
            ArrayPush(medical.chronicConditions, MedicalHistoryManager.GenerateConditionCoherent(seed + 110 + (i * 17), archetype, coherence));
            i += 1;
        }

        // Add substance-related conditions if coherence indicates
        if IsDefined(coherence) && coherence.hasSubstanceIssues && RandRange(seed + 150, 1, 100) <= 70 {
            ArrayPush(medical.chronicConditions, MedicalHistoryManager.GenerateSubstanceCondition(seed + 151, coherence.substanceType));
        }

        // Allergies - only on medium/high density
        if density >= 2 && RandRange(seed + 200, 1, 100) <= 35 {
            let allergyCount = RandRange(seed + 210, 1, 4);
            allergyCount = KiroshiSettings.GetMaxListItems(allergyCount);
            i = 0;
            while i < allergyCount {
                ArrayPush(medical.allergies, MedicalHistoryManager.GenerateAllergy(seed + 220 + (i * 13)));
                i += 1;
            }
        }

        // Organ replacements - limited by density
        let organChance = MedicalHistoryManager.GetOrganReplacementChance(archetype, age);
        if RandRange(seed + 300, 1, 100) <= organChance {
            let organCount = RandRange(seed + 310, 1, 3);
            organCount = KiroshiSettings.GetMaxListItems(organCount);
            i = 0;
            while i < organCount {
                ArrayPush(medical.organReplacements, MedicalHistoryManager.GenerateOrganReplacement(seed + 320 + (i * 19)));
                i += 1;
            }
        }

        // Medical visits - only on medium/high
        if density >= 2 {
            medical.lastCheckup = MedicalHistoryManager.GenerateLastCheckup(seed + 400, archetype);
            medical.ripperdocVisits = MedicalHistoryManager.GenerateRipperdocVisits(seed + 410, archetype);
            medical.emergencyVisits = MedicalHistoryManager.GenerateEmergencyVisitsCoherent(seed + 420, archetype, coherence);
        }

        // Donor status - only on high density
        if density >= 3 {
            medical.donorStatus = MedicalHistoryManager.GenerateDonorStatus(seed + 500, archetype);
            medical.organDonorCard = RandRange(seed + 510, 1, 100) <= 30;
        }

        // Medications - limited by density
        let medCount = MedicalHistoryManager.GetMedicationCount(seed + 600, archetype, ArraySize(medical.chronicConditions));
        medCount = KiroshiSettings.GetMaxListItems(medCount);
        i = 0;
        while i < medCount {
            ArrayPush(medical.currentMedications, MedicalHistoryManager.GenerateMedication(seed + 610 + (i * 23), archetype));
            i += 1;
        }

        // Injuries - limited by density
        let injuryCount = MedicalHistoryManager.GetInjuryCountCoherent(seed + 700, archetype, coherence);
        injuryCount = KiroshiSettings.GetMaxListItems(injuryCount);
        i = 0;
        while i < injuryCount {
            ArrayPush(medical.pastInjuries, MedicalHistoryManager.GenerateInjuryCoherent(seed + 710 + (i * 29), coherence));
            i += 1;
        }

        // Vaccinations - only on high density
        if density >= 3 {
            medical.vaccinationStatus = MedicalHistoryManager.GenerateVaccinationStatus(seed + 800, archetype);
        }

        // Mental health - always shown (important)
        medical.mentalHealthFlag = MedicalHistoryManager.HasMentalHealthFlagCoherent(seed + 900, archetype, coherence);

        // Genetic markers - only on high density
        if density >= 3 && RandRange(seed + 1000, 1, 100) <= 25 {
            ArrayPush(medical.geneticMarkers, MedicalHistoryManager.GenerateGeneticMarker(seed + 1010));
            if RandRange(seed + 1020, 1, 100) <= 30 {
                ArrayPush(medical.geneticMarkers, MedicalHistoryManager.GenerateGeneticMarker(seed + 1030));
            }
        }

        // Overall health rating
        medical.healthRating = MedicalHistoryManager.CalculateHealthRating(medical, archetype);

        return medical;
    }

    // Biological age affected by substance abuse and trauma
    private static func CalculateBiologicalAgeCoherent(seed: Int32, chronoAge: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let bioAge = MedicalHistoryManager.CalculateBiologicalAge(seed, chronoAge, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasSubstanceIssues { bioAge += RandRange(seed + 5, 3, 8); }
            if Equals(coherence.lifeTheme, "FALLING") { bioAge += RandRange(seed + 6, 2, 5); }
            if coherence.hasChronicHealth { bioAge += RandRange(seed + 7, 1, 4); }
        }
        
        if bioAge > 120 { bioAge = 120; }
        return bioAge;
    }

    // Condition count influenced by coherence
    private static func GetConditionCountCoherent(seed: Int32, archetype: String, age: Int32, coherence: ref<CoherenceProfile>) -> Int32 {
        let base = MedicalHistoryManager.GetConditionCount(seed, archetype, age);
        
        if IsDefined(coherence) {
            if coherence.hasChronicHealth { base += 1; }
            if coherence.hasSubstanceIssues { base += 1; }
            if Equals(coherence.lifeTheme, "FALLING") { base += 1; }
        }
        
        if base > 6 { base = 6; }
        return base;
    }

    // Generate condition that matches coherence
    private static func GenerateConditionCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
        // 40% chance to generate coherence-matching condition
        if IsDefined(coherence) && RandRange(seed + 50, 1, 100) <= 40 {
            if coherence.hasSubstanceIssues {
                return MedicalHistoryManager.GenerateSubstanceCondition(seed, coherence.substanceType);
            }
        }
        
        return MedicalHistoryManager.GenerateCondition(seed, archetype);
    }

    // Substance-specific medical conditions
    private static func GenerateSubstanceCondition(seed: Int32, substanceType: String) -> String {
        if Equals(substanceType, "alcohol") || Equals(substanceType, "synthetic alcohol") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Liver damage (alcohol-related)"; }
            if i == 1 { return "Cirrhosis - early stage"; }
            if i == 2 { return "Alcohol-induced neuropathy"; }
            if i == 3 { return "Chronic gastritis"; }
            if i == 4 { return "Alcoholic cardiomyopathy"; }
            if i == 5 { return "Wernicke-Korsakoff syndrome (early)"; }
            if i == 6 { return "Pancreatitis (alcohol-induced)"; }
            if i == 7 { return "Esophageal varices"; }
            if i == 8 { return "Alcohol-induced dementia"; }
            return "Fatty liver disease";
        }
        
        if StrContains(StrLower(substanceType), "synth-coke") || StrContains(StrLower(substanceType), "stim") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Cardiac arrhythmia (stimulant abuse)"; }
            if i == 1 { return "Nasal septum damage"; }
            if i == 2 { return "Chronic hypertension"; }
            if i == 3 { return "Stimulant-induced anxiety disorder"; }
            if i == 4 { return "Stimulant psychosis (recurring)"; }
            if i == 5 { return "Cardiovascular strain"; }
            if i == 6 { return "Chronic insomnia"; }
            if i == 7 { return "Bruxism (teeth grinding)"; }
            if i == 8 { return "Malnutrition (appetite suppression)"; }
            return "Dopamine receptor damage";
        }
        
        if StrContains(StrLower(substanceType), "black lace") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Neurotransmitter imbalance"; }
            if i == 1 { return "Chronic pain syndrome"; }
            if i == 2 { return "Rage disorder (substance-induced)"; }
            if i == 3 { return "Adrenal fatigue"; }
            if i == 4 { return "Combat addiction"; }
            if i == 5 { return "Pain receptor damage"; }
            if i == 6 { return "Impulse control disorder"; }
            if i == 7 { return "Aggression syndrome"; }
            if i == 8 { return "Endocrine system damage"; }
            return "Violence-induced PTSD";
        }
        
        if StrContains(StrLower(substanceType), "glitter") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "Serotonin syndrome (mild)"; }
            if i == 1 { return "Memory fragmentation"; }
            if i == 2 { return "Emotional dysregulation"; }
            if i == 3 { return "Hyperthermia episodes"; }
            if i == 4 { return "Jaw tension (chronic)"; }
            return "Dehydration damage";
        }
        
        if StrContains(StrLower(substanceType), "smash") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "Muscle tissue damage"; }
            if i == 1 { return "Testosterone imbalance"; }
            if i == 2 { return "Heart enlargement"; }
            if i == 3 { return "Liver stress"; }
            if i == 4 { return "Aggression disorder"; }
            return "Joint deterioration";
        }
        
        if StrContains(StrLower(substanceType), "spike") || StrContains(StrLower(substanceType), "dorph") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "Opioid dependency"; }
            if i == 1 { return "Respiratory depression risk"; }
            if i == 2 { return "Chronic constipation"; }
            if i == 3 { return "Hormonal imbalance"; }
            if i == 4 { return "Immune suppression"; }
            if i == 5 { return "Overdose scarring (organs)"; }
            if i == 6 { return "Needle site infections"; }
            return "Chronic sedation effects";
        }
        
        // Generic substance condition
        let i = RandRange(seed, 0, 11);
        if i == 0 { return "Substance use disorder"; }
        if i == 1 { return "Liver enzyme abnormalities"; }
        if i == 2 { return "Chronic fatigue (substance-related)"; }
        if i == 3 { return "Immune system compromise"; }
        if i == 4 { return "Nutritional deficiencies"; }
        if i == 5 { return "Sleep cycle disruption"; }
        if i == 6 { return "Cognitive impairment"; }
        if i == 7 { return "Mood instability"; }
        if i == 8 { return "Withdrawal syndrome (chronic)"; }
        if i == 9 { return "Polydrug complications"; }
        if i == 10 { return "Vascular damage"; }
        return "Neurological deterioration";
    }

    // Emergency visits affected by violence/trauma
    private static func GenerateEmergencyVisitsCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let base = MedicalHistoryManager.GenerateEmergencyVisits(seed, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { base += RandRange(seed + 5, 1, 3); }
            if coherence.hasTrauma && Equals(coherence.traumaType, "accident") { base += RandRange(seed + 6, 1, 2); }
        }
        
        return base;
    }

    // Injury count influenced by violence
    private static func GetInjuryCountCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let base = MedicalHistoryManager.GetInjuryCount(seed, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { base += RandRange(seed + 5, 1, 3); }
            if coherence.hasTrauma && Equals(coherence.traumaType, "violence") { base += 1; }
            if coherence.hasTrauma && Equals(coherence.traumaType, "accident") { base += 2; }
        }
        
        if base > 8 { base = 8; }
        return base;
    }

    // Injury type matches violence type
    private static func GenerateInjuryCoherent(seed: Int32, coherence: ref<CoherenceProfile>) -> String {
        let year = RandRange(seed + 1000, 2065, 2077);
        
        if IsDefined(coherence) && coherence.hasViolentPast && RandRange(seed + 50, 1, 100) <= 60 {
            if Equals(coherence.violenceType, "gang") {
                let i = RandRange(seed, 0, 11);
                if i == 0 { return "Gunshot wound (healed) - " + IntToString(year); }
                if i == 1 { return "Stab wound - gang altercation - " + IntToString(year); }
                if i == 2 { return "Blunt force trauma - gang violence - " + IntToString(year); }
                if i == 3 { return "Multiple lacerations - knife fight - " + IntToString(year); }
                if i == 4 { return "Machete wound (healed) - " + IntToString(year); }
                if i == 5 { return "Baseball bat injuries - " + IntToString(year); }
                if i == 6 { return "Drive-by shooting injuries - " + IntToString(year); }
                if i == 7 { return "Crowbar assault wounds - " + IntToString(year); }
                if i == 8 { return "Curb stomp injuries (facial) - " + IntToString(year); }
                if i == 9 { return "Brass knuckle trauma - " + IntToString(year); }
                if i == 10 { return "Chain whip lacerations - " + IntToString(year); }
                return "Execution attempt survival - " + IntToString(year);
            }
            if Equals(coherence.violenceType, "domestic") {
                let i = RandRange(seed, 0, 8);
                if i == 0 { return "Contusions - domestic incident - " + IntToString(year); }
                if i == 1 { return "Fracture (set) - fall/assault - " + IntToString(year); }
                if i == 2 { return "Soft tissue injuries - " + IntToString(year); }
                if i == 3 { return "Defensive wounds (forearms) - " + IntToString(year); }
                if i == 4 { return "Strangulation marks (healed) - " + IntToString(year); }
                if i == 5 { return "Burns (domestic) - " + IntToString(year); }
                if i == 6 { return "Pushed down stairs - " + IntToString(year); }
                if i == 7 { return "Blunt object trauma - " + IntToString(year); }
                return "Multiple old fractures - " + IntToString(year);
            }
            if Equals(coherence.violenceType, "bar fight") {
                let i = RandRange(seed, 0, 9);
                if i == 0 { return "Broken nose (set) - " + IntToString(year); }
                if i == 1 { return "Facial lacerations - brawl - " + IntToString(year); }
                if i == 2 { return "Concussion - fight - " + IntToString(year); }
                if i == 3 { return "Hand fractures - fight - " + IntToString(year); }
                if i == 4 { return "Broken bottle wounds - " + IntToString(year); }
                if i == 5 { return "Teeth knocked out - " + IntToString(year); }
                if i == 6 { return "Eye socket damage - " + IntToString(year); }
                if i == 7 { return "Rib fractures - kicked - " + IntToString(year); }
                if i == 8 { return "Pool cue injuries - " + IntToString(year); }
                return "Bar stool trauma - " + IntToString(year);
            }
            if Equals(coherence.violenceType, "street") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Mugging injuries - " + IntToString(year); }
                if i == 1 { return "Random assault wounds - " + IntToString(year); }
                if i == 2 { return "Robbery violence - " + IntToString(year); }
                if i == 3 { return "Carjacking injuries - " + IntToString(year); }
                if i == 4 { return "Wrong place wrong time - " + IntToString(year); }
                if i == 5 { return "Bystander shooting - " + IntToString(year); }
                if i == 6 { return "Drug deal gone wrong - " + IntToString(year); }
                return "Street racing crash - " + IntToString(year);
            }
        }
        
        if IsDefined(coherence) && coherence.hasTrauma && Equals(coherence.traumaType, "accident") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Vehicular accident injuries - " + IntToString(year); }
            if i == 1 { return "Industrial accident - " + IntToString(year); }
            if i == 2 { return "Fall injuries - serious - " + IntToString(year); }
            if i == 3 { return "Multiple fractures - accident - " + IntToString(year); }
            if i == 4 { return "Motorcycle crash - " + IntToString(year); }
            if i == 5 { return "Construction site accident - " + IntToString(year); }
            if i == 6 { return "AV crash injuries - " + IntToString(year); }
            if i == 7 { return "Chemical spill exposure - " + IntToString(year); }
            if i == 8 { return "Machinery accident - " + IntToString(year); }
            if i == 9 { return "Explosion injuries - " + IntToString(year); }
            if i == 10 { return "Structural collapse - " + IntToString(year); }
            return "Train/Metro accident - " + IntToString(year);
        }
        
        return MedicalHistoryManager.GenerateInjury(seed);
    }

    // Mental health flag influenced by trauma
    private static func HasMentalHealthFlagCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Bool {
        let chance: Int32;
        
        if Equals(archetype, "JUNKIE") { chance = 80; }
        else if Equals(archetype, "HOMELESS") { chance = 60; }
        else if Equals(archetype, "GANGER") { chance = 50; }
        else if Equals(archetype, "LOWLIFE") { chance = 40; }
        else if Equals(archetype, "CORPO_DRONE") { chance = 45; }
        else if Equals(archetype, "CORPO_MANAGER") { chance = 35; }
        else { chance = 30; }

        // Coherence modifiers
        if IsDefined(coherence) {
            if coherence.hasTrauma { chance += 25; }
            if coherence.hasSubstanceIssues { chance += 15; }
            if Equals(coherence.lifeTheme, "FALLING") { chance += 20; }
        }

        if chance > 95 { chance = 95; }
        return RandRange(seed, 1, 100) <= chance;
    }

    private static func GenerateBloodType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        
        // Common types - weighted by real distribution
        // O+ (37%)
        if i >= 0 && i <= 8 { return "O+"; }
        // A+ (36%)
        if i >= 9 && i <= 16 { return "A+"; }
        // B+ (9%)
        if i == 17 || i == 18 { return "B+"; }
        // AB+ (3%)
        if i == 19 { return "AB+"; }
        // O- (7%)
        if i == 20 { return "O-"; }
        // A- (6%)
        if i == 21 { return "A-"; }
        // B- (1%)
        if i == 22 { return "B-"; }
        // AB- (1%)
        if i == 23 { return "AB-"; }
        // Night City additions
        return "SYNTHETIC";
    }

    private static func CalculateBiologicalAge(seed: Int32, chronoAge: Int32, archetype: String) -> Int32 {
        let modifier: Int32 = 0;

        // Wealthy people age better
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            modifier = RandRange(seed, -10, -2);
        } else if Equals(archetype, "CORPO_DRONE") {
            modifier = RandRange(seed, -5, 3);
        } else if Equals(archetype, "JUNKIE") {
            modifier = RandRange(seed, 5, 20);
        } else if Equals(archetype, "HOMELESS") {
            modifier = RandRange(seed, 3, 15);
        } else if Equals(archetype, "GANGER") {
            modifier = RandRange(seed, 0, 10);
        } else {
            modifier = RandRange(seed, -3, 8);
        }

        let bioAge = chronoAge + modifier;
        if bioAge < 18 { bioAge = 18; }
        if bioAge > 120 { bioAge = 120; }
        
        return bioAge;
    }

    private static func GenerateHeight(seed: Int32, archetype: String) -> String {
        let heightCm: Int32;
        
        // Base height with some variance
        heightCm = RandRange(seed, 155, 195);
        
        let feet = heightCm / 30;
        let inches = (heightCm % 30) / 2;
        
        return IntToString(heightCm) + " cm (" + IntToString(feet) + "'" + IntToString(inches) + "\")";
    }

    private static func GenerateWeight(seed: Int32, archetype: String) -> String {
        let weightKg: Int32;

        if Equals(archetype, "GANGER") {
            // Gangers tend to be more muscular or average
            weightKg = RandRange(seed, 70, 110);
        } else if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            // Underweight
            weightKg = RandRange(seed, 45, 75);
        } else if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            // Healthy range
            weightKg = RandRange(seed, 60, 90);
        } else {
            weightKg = RandRange(seed, 55, 100);
        }

        let lbs = Cast<Int32>(Cast<Float>(weightKg) * 2.2);
        return IntToString(weightKg) + " kg (" + IntToString(lbs) + " lbs)";
    }

    private static func GetConditionCount(seed: Int32, archetype: String, age: Int32) -> Int32 {
        let base: Int32 = 0;

        // Age affects condition count
        if age >= 60 { base = 2; }
        else if age >= 45 { base = 1; }

        // Archetype modifiers
        if Equals(archetype, "JUNKIE") { base += 2; }
        else if Equals(archetype, "HOMELESS") { base += 1; }
        else if Equals(archetype, "GANGER") { base += 1; }
        else if Equals(archetype, "CORPO_MANAGER") { base -= 1; }

        // Random additional
        base += RandRange(seed, 0, 2);
        
        if base < 0 { base = 0; }
        if base > 5 { base = 5; }
        
        return base;
    }

    private static func GenerateCondition(seed: Int32, archetype: String) -> String {
        // Archetype-specific conditions (20% chance)
        if RandRange(seed + 999, 1, 100) <= 20 {
            if Equals(archetype, "JUNKIE") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Substance Dependency - Active"; }
                if i == 1 { return "Hepatic Damage"; }
                if i == 2 { return "Neurochemical Imbalance"; }
                if i == 3 { return "Malnutrition"; }
                if i == 4 { return "Track Marks (Infected)"; }
                if i == 5 { return "Overdose History"; }
                if i == 6 { return "Kidney Failure (Early Stage)"; }
                return "Withdrawal Syndrome - Chronic";
            }
            if Equals(archetype, "GANGER") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Healed Stab Wounds"; }
                if i == 1 { return "Bullet Fragment Retention"; }
                if i == 2 { return "Combat Injuries (Multiple)"; }
                if i == 3 { return "Cauliflower Ear"; }
                if i == 4 { return "Facial Scarring (Extensive)"; }
                if i == 5 { return "Nerve Damage (Combat)"; }
                if i == 6 { return "Hearing Loss (Gunfire)"; }
                return "Chronic Pain (Gang Violence)";
            }
            if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Carpal Tunnel Syndrome"; }
                if i == 1 { return "Stress-Related Hypertension"; }
                if i == 2 { return "Burnout Syndrome"; }
                if i == 3 { return "Eye Strain (Chronic)"; }
                if i == 4 { return "Tension Headaches"; }
                if i == 5 { return "Insomnia (Work-Related)"; }
                if i == 6 { return "Gastric Ulcers (Stress)"; }
                return "Executive Fatigue Syndrome";
            }
            if Equals(archetype, "HOMELESS") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Exposure Injuries"; }
                if i == 1 { return "Malnutrition"; }
                if i == 2 { return "Untreated Infections"; }
                if i == 3 { return "Parasitic Infection"; }
                if i == 4 { return "Frostbite Scarring"; }
                if i == 5 { return "Skin Conditions (Untreated)"; }
                if i == 6 { return "Dental Decay (Severe)"; }
                return "Chronic Dehydration";
            }
            if Equals(archetype, "NOMAD") {
                let i = RandRange(seed, 0, 5);
                if i == 0 { return "Radiation Exposure (Badlands)"; }
                if i == 1 { return "Dust Lung"; }
                if i == 2 { return "Sun Damage (Chronic)"; }
                if i == 3 { return "Dehydration History"; }
                if i == 4 { return "Vehicle Crash Injuries (Old)"; }
                return "Desert Fever (Recovered)";
            }
        }

        // General conditions (80 total)
        let i = RandRange(seed, 0, 79);
        
        // Common conditions (0-19)
        if i == 0 { return "Hypertension"; }
        if i == 1 { return "Type 2 Diabetes"; }
        if i == 2 { return "Chronic Back Pain"; }
        if i == 3 { return "Asthma"; }
        if i == 4 { return "Arthritis"; }
        if i == 5 { return "Anxiety Disorder"; }
        if i == 6 { return "Depression"; }
        if i == 7 { return "Migraines"; }
        if i == 8 { return "Sleep Disorder"; }
        if i == 9 { return "Respiratory Issues (Smog-Related)"; }
        if i == 10 { return "High Cholesterol"; }
        if i == 11 { return "Acid Reflux"; }
        if i == 12 { return "Irritable Bowel Syndrome"; }
        if i == 13 { return "Chronic Fatigue"; }
        if i == 14 { return "Allergic Rhinitis"; }
        if i == 15 { return "Eczema"; }
        if i == 16 { return "Psoriasis"; }
        if i == 17 { return "Hypothyroidism"; }
        if i == 18 { return "Hyperthyroidism"; }
        if i == 19 { return "Anemia"; }
        
        // Night City specific (20-39)
        if i == 20 { return "Cyberware Rejection Syndrome"; }
        if i == 21 { return "Neural Degradation (Mild)"; }
        if i == 22 { return "Synthetic Organ Maintenance"; }
        if i == 23 { return "Radiation Exposure Effects"; }
        if i == 24 { return "Combat-Related PTSD"; }
        if i == 25 { return "Braindance Dependency"; }
        if i == 26 { return "Chronic Pain (Bullet Wound)"; }
        if i == 27 { return "Toxin Accumulation"; }
        if i == 28 { return "Cyberpsychosis (Early Warning)"; }
        if i == 29 { return "Chrome Allergy"; }
        if i == 30 { return "Neural Port Infection (Recurring)"; }
        if i == 31 { return "Phantom Limb Syndrome"; }
        if i == 32 { return "Sensory Overload Disorder"; }
        if i == 33 { return "Memory Fragmentation"; }
        if i == 34 { return "Interface Headaches"; }
        if i == 35 { return "Biomon Dependency"; }
        if i == 36 { return "Reflex Booster Burnout"; }
        if i == 37 { return "Kerenzikov Tremors"; }
        if i == 38 { return "Sandevistan Strain"; }
        if i == 39 { return "Optical Implant Migraines"; }
        
        // Mental health (40-49)
        if i == 40 { return "Generalized Anxiety Disorder"; }
        if i == 41 { return "Major Depressive Disorder"; }
        if i == 42 { return "Bipolar Disorder"; }
        if i == 43 { return "PTSD"; }
        if i == 44 { return "Panic Disorder"; }
        if i == 45 { return "Social Anxiety"; }
        if i == 46 { return "OCD"; }
        if i == 47 { return "ADHD"; }
        if i == 48 { return "Insomnia (Chronic)"; }
        if i == 49 { return "Dissociative Episodes"; }
        
        // Cardiovascular (50-54)
        if i == 50 { return "Coronary Artery Disease"; }
        if i == 51 { return "Heart Arrhythmia"; }
        if i == 52 { return "Heart Murmur"; }
        if i == 53 { return "Varicose Veins"; }
        if i == 54 { return "Deep Vein Thrombosis History"; }
        
        // Respiratory (55-59)
        if i == 55 { return "COPD"; }
        if i == 56 { return "Chronic Bronchitis"; }
        if i == 57 { return "Emphysema"; }
        if i == 58 { return "Pneumonia (Recurring)"; }
        if i == 59 { return "Lung Scarring (Pollution)"; }
        
        // Digestive (60-64)
        if i == 60 { return "Crohn's Disease"; }
        if i == 61 { return "Ulcerative Colitis"; }
        if i == 62 { return "Gastric Ulcers"; }
        if i == 63 { return "Liver Cirrhosis (Early)"; }
        if i == 64 { return "Fatty Liver Disease"; }
        
        // Neurological (65-69)
        if i == 65 { return "Epilepsy"; }
        if i == 66 { return "Peripheral Neuropathy"; }
        if i == 67 { return "Carpal Tunnel"; }
        if i == 68 { return "Sciatica"; }
        if i == 69 { return "Vertigo (Chronic)"; }
        
        // Autoimmune/Other (70-79)
        if i == 70 { return "Lupus"; }
        if i == 71 { return "Rheumatoid Arthritis"; }
        if i == 72 { return "Fibromyalgia"; }
        if i == 73 { return "Chronic Kidney Disease"; }
        if i == 74 { return "Gout"; }
        if i == 75 { return "Osteoporosis"; }
        if i == 76 { return "Tinnitus"; }
        if i == 77 { return "Glaucoma"; }
        if i == 78 { return "Cataracts (Early)"; }
        return "Chronic Sinusitis";
    }

    private static func GenerateAllergy(seed: Int32) -> String {
        let i = RandRange(seed, 0, 34);
        
        // Common allergies (0-9)
        if i == 0 { return "Penicillin"; }
        if i == 1 { return "Shellfish"; }
        if i == 2 { return "Peanuts"; }
        if i == 3 { return "Latex"; }
        if i == 4 { return "Sulfa Drugs"; }
        if i == 5 { return "Aspirin"; }
        if i == 6 { return "Ibuprofen"; }
        if i == 7 { return "Eggs"; }
        if i == 8 { return "Milk Products"; }
        if i == 9 { return "Wheat/Gluten"; }
        
        // Night City specific (10-24)
        if i == 10 { return "Synthetic Proteins"; }
        if i == 11 { return "Titanium Compounds"; }
        if i == 12 { return "Biofoam"; }
        if i == 13 { return "Neural Interface Gel"; }
        if i == 14 { return "Specific Nanobots"; }
        if i == 15 { return "Anesthetic (Type C)"; }
        if i == 16 { return "Kibble Additives"; }
        if i == 17 { return "Soy Derivatives"; }
        if i == 18 { return "Synthetic Blood Components"; }
        if i == 19 { return "Cyberware Coolant"; }
        if i == 20 { return "Chrome Polish Compounds"; }
        if i == 21 { return "Neural Suppressants"; }
        if i == 22 { return "Biotech Adhesives"; }
        if i == 23 { return "Recycled Water Treatment"; }
        if i == 24 { return "SCOP Protein Mix"; }
        
        // Medical/Drug allergies (25-34)
        if i == 25 { return "Morphine Derivatives"; }
        if i == 26 { return "Contrast Dye"; }
        if i == 27 { return "Anesthesia (General)"; }
        if i == 28 { return "Immunosuppressants"; }
        if i == 29 { return "Antivirals (Common)"; }
        if i == 30 { return "Synthetic Hormones"; }
        if i == 31 { return "Stimulant Medications"; }
        if i == 32 { return "Sedatives (Class B)"; }
        if i == 33 { return "Anti-Rejection Meds"; }
        return "Nanobot Repair Fluid";
    }

    private static func GetOrganReplacementChance(archetype: String, age: Int32) -> Int32 {
        let base: Int32 = 10;

        // Age affects likelihood
        if age >= 60 { base += 30; }
        else if age >= 45 { base += 15; }
        else if age >= 30 { base += 5; }

        // Archetype modifiers
        if Equals(archetype, "GANGER") { base += 25; }
        else if Equals(archetype, "JUNKIE") { base += 20; }
        else if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") { base += 15; } // Can afford it

        return base;
    }

    private static func GenerateOrganReplacement(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        
        // Major organs (0-11)
        if i == 0 { return "Synthetic Liver (Biotechnica)"; }
        if i == 1 { return "Synthetic Kidney (Left)"; }
        if i == 2 { return "Synthetic Kidney (Right)"; }
        if i == 3 { return "Synthetic Heart"; }
        if i == 4 { return "Synthetic Lung (Left)"; }
        if i == 5 { return "Synthetic Lung (Right)"; }
        if i == 6 { return "Cloned Liver"; }
        if i == 7 { return "Cloned Kidney"; }
        if i == 8 { return "Artificial Eye (Non-Kiroshi)"; }
        if i == 9 { return "Synthetic Pancreas"; }
        if i == 10 { return "Bioengineered Stomach"; }
        if i == 11 { return "Vat-Grown Skin Grafts"; }
        
        // Additional organs (12-19)
        if i == 12 { return "Synthetic Spleen"; }
        if i == 13 { return "Artificial Bladder"; }
        if i == 14 { return "Bioprinted Intestinal Section"; }
        if i == 15 { return "Synthetic Thyroid"; }
        if i == 16 { return "Cloned Corneas"; }
        if i == 17 { return "Artificial Larynx"; }
        if i == 18 { return "Synthetic Adrenal Glands"; }
        if i == 19 { return "Bioengineered Bone Marrow"; }
        
        // Specialized replacements (20-29)
        if i == 20 { return "Synthetic Heart Valve"; }
        if i == 21 { return "Artificial Blood Vessels"; }
        if i == 22 { return "Cloned Liver (Partial)"; }
        if i == 23 { return "3D-Printed Trachea"; }
        if i == 24 { return "Biotech Ear Reconstruction"; }
        if i == 25 { return "Synthetic Esophagus"; }
        if i == 26 { return "Lab-Grown Cartilage (Multiple)"; }
        if i == 27 { return "Artificial Bile Duct"; }
        if i == 28 { return "Bioprinted Skin (Face)"; }
        return "Vat-Grown Muscle Tissue";
    }

    private static func GenerateLastCheckup(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "< 3 months ago (Corporate Mandatory)"; }
        if Equals(archetype, "CORPO_DRONE") { return "< 6 months ago (Corporate Mandatory)"; }
        if Equals(archetype, "YUPPIE") { return IntToString(RandRange(seed, 2, 8)) + " months ago"; }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") { return "Unknown / Never"; }

        let months = RandRange(seed, 6, 48);
        if months >= 24 { return IntToString(months / 12) + "+ years ago"; }
        return IntToString(months) + " months ago";
    }

    private static func GenerateRipperdocVisits(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 5, 15); }
        if Equals(archetype, "GANGER") { return RandRange(seed, 3, 12); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 2); }
        return RandRange(seed, 1, 8);
    }

    private static func GenerateEmergencyVisits(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return RandRange(seed, 2, 10); }
        if Equals(archetype, "LOWLIFE") { return RandRange(seed, 1, 5); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 4); }
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 0, 2); }
        return RandRange(seed, 0, 3);
    }

    private static func GenerateDonorStatus(seed: Int32, archetype: String) -> String {
        let statuses: array<String>;
        
        ArrayPush(statuses, "Universal Donor");
        ArrayPush(statuses, "Compatible Donor");
        ArrayPush(statuses, "Limited Compatibility");
        ArrayPush(statuses, "Incompatible (Medical Issues)");
        ArrayPush(statuses, "Organ Harvest Consent on File");
        ArrayPush(statuses, "Corporate Organ Reserve (Contracted)");
        ArrayPush(statuses, "No Consent Given");
        ArrayPush(statuses, "Synthetic Organs - N/A");

        if Equals(archetype, "CORPO_DRONE") && RandRange(seed + 5, 1, 100) <= 30 {
            return statuses[5]; // Corporate organ reserve
        }

        return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
    }

    private static func GetMedicationCount(seed: Int32, archetype: String, conditionCount: Int32) -> Int32 {
        let base = conditionCount;
        
        if Equals(archetype, "JUNKIE") { base += RandRange(seed, 1, 3); }
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            // Better access to medication
            base += RandRange(seed, 0, 2);
        }
        
        return base;
    }

    private static func GenerateMedication(seed: Int32, archetype: String) -> String {
        // Archetype-specific medications (25% chance)
        if RandRange(seed + 999, 1, 100) <= 25 {
            if Equals(archetype, "JUNKIE") {
                let i = RandRange(seed, 0, 5);
                if i == 0 { return "Addiction Treatment (Non-compliant)"; }
                if i == 1 { return "Naloxone (Self-Administered)"; }
                if i == 2 { return "Liver Support Supplements"; }
                if i == 3 { return "Methadone (Prescription)"; }
                if i == 4 { return "Anti-Craving Implant Meds"; }
                return "Vitamin Injections (Deficiency)";
            }
            if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
                let i = RandRange(seed, 0, 5);
                if i == 0 { return "Executive Focus (Prescription)"; }
                if i == 1 { return "CorpoCalm (Anti-Anxiety)"; }
                if i == 2 { return "SleepCycle Regulator"; }
                if i == 3 { return "StressShield (Cortisol Blocker)"; }
                if i == 4 { return "NeuroSharp (Cognitive)"; }
                return "UlcerGuard (Preventive)";
            }
            if Equals(archetype, "GANGER") {
                let i = RandRange(seed, 0, 3);
                if i == 0 { return "Combat Stim Recovery"; }
                if i == 1 { return "Trauma Response Meds"; }
                if i == 2 { return "Scarring Treatment"; }
                return "Pain Management (Heavy Duty)";
            }
        }

        // General medications (50 total)
        let i = RandRange(seed, 0, 49);
        
        // Cyberware/NC specific (0-14)
        if i == 0 { return "SynthBlood Stabilizers"; }
        if i == 1 { return "NeuroBalance (Generic)"; }
        if i == 2 { return "Immunosuppressants (Cyberware)"; }
        if i == 3 { return "Anti-Rejection Meds"; }
        if i == 4 { return "Cognitive Enhancers"; }
        if i == 5 { return "Cyberware Maintenance Supplements"; }
        if i == 6 { return "Neural Stabilizers"; }
        if i == 7 { return "Chrome Compatibility Boosters"; }
        if i == 8 { return "Implant Anti-Inflammatory"; }
        if i == 9 { return "Biomonitor Calibration Meds"; }
        if i == 10 { return "Reflex Enhancer Support"; }
        if i == 11 { return "Optical Implant Drops"; }
        if i == 12 { return "Synthetic Organ Nutrients"; }
        if i == 13 { return "Nanobot Replenishment"; }
        if i == 14 { return "Cyberpsychosis Preventive"; }
        
        // Cardiovascular (15-19)
        if i == 15 { return "HeartGuard"; }
        if i == 16 { return "Blood Pressure Meds"; }
        if i == 17 { return "Cholesterol Blockers"; }
        if i == 18 { return "Blood Thinners"; }
        if i == 19 { return "Heart Rhythm Stabilizers"; }
        
        // Pain/Inflammation (20-24)
        if i == 20 { return "PainAway"; }
        if i == 21 { return "Anti-Inflammatory (Chronic)"; }
        if i == 22 { return "Nerve Pain Blockers"; }
        if i == 23 { return "Joint Support Formula"; }
        if i == 24 { return "Muscle Relaxants"; }
        
        // Mental health (25-34)
        if i == 25 { return "Mood Stabilizers"; }
        if i == 26 { return "Antidepressants (SSRI)"; }
        if i == 27 { return "Anti-Anxiety (Daily)"; }
        if i == 28 { return "PTSD Management"; }
        if i == 29 { return "Bipolar Medication"; }
        if i == 30 { return "ADHD Medication"; }
        if i == 31 { return "SleepEZ"; }
        if i == 32 { return "Nightmare Suppressants"; }
        if i == 33 { return "Panic Attack Prevention"; }
        if i == 34 { return "Stress Hormone Regulators"; }
        
        // Metabolic/Endocrine (35-39)
        if i == 35 { return "Metabolic Boosters"; }
        if i == 36 { return "Diabetes Management System"; }
        if i == 37 { return "Thyroid Regulators"; }
        if i == 38 { return "Hormone Replacement"; }
        if i == 39 { return "Appetite Suppressants"; }
        
        // Respiratory/Other (40-49)
        if i == 40 { return "Respiratory Therapy Inhaler"; }
        if i == 41 { return "Asthma Controller"; }
        if i == 42 { return "Allergy Blockers"; }
        if i == 43 { return "Bone Density Treatment"; }
        if i == 44 { return "Immune System Boosters"; }
        if i == 45 { return "Digestive Enzymes"; }
        if i == 46 { return "Acid Reflux Control"; }
        if i == 47 { return "Kidney Function Support"; }
        if i == 48 { return "Liver Detox Formula"; }
        return "Vitamin Deficiency Supplements";
    }

    private static func GetInjuryCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return RandRange(seed, 2, 7); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 1, 4); }
        if Equals(archetype, "LOWLIFE") { return RandRange(seed, 0, 3); }
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 0, 1); }
        return RandRange(seed, 0, 2);
    }

    private static func GenerateInjury(seed: Int32) -> String {
        let year = RandRange(seed + 500, 2060, 2077);
        let i = RandRange(seed, 0, 39);
        
        // Violent injuries (0-14)
        if i == 0 { return "Gunshot wound (healed) - " + IntToString(year); }
        if i == 1 { return "Stab wound - " + IntToString(year); }
        if i == 2 { return "Assault injuries - " + IntToString(year); }
        if i == 3 { return "Blunt force trauma - " + IntToString(year); }
        if i == 4 { return "Multiple lacerations - " + IntToString(year); }
        if i == 5 { return "Broken jaw (healed) - " + IntToString(year); }
        if i == 6 { return "Fractured skull - " + IntToString(year); }
        if i == 7 { return "Bullet fragment retention - " + IntToString(year); }
        if i == 8 { return "Knife wound (torso) - " + IntToString(year); }
        if i == 9 { return "Shrapnel injuries - " + IntToString(year); }
        if i == 10 { return "Strangling trauma - " + IntToString(year); }
        if i == 11 { return "Broken ribs (multiple) - " + IntToString(year); }
        if i == 12 { return "Defensive wounds (arms) - " + IntToString(year); }
        if i == 13 { return "Orbital fracture - " + IntToString(year); }
        if i == 14 { return "Ruptured eardrum (combat) - " + IntToString(year); }
        
        // Accidents (15-24)
        if i == 15 { return "Vehicular accident injuries - " + IntToString(year); }
        if i == 16 { return "Industrial accident - " + IntToString(year); }
        if i == 17 { return "Fall injuries - " + IntToString(year); }
        if i == 18 { return "Burns (2nd degree) - " + IntToString(year); }
        if i == 19 { return "Burns (3rd degree) - " + IntToString(year); }
        if i == 20 { return "Chemical exposure - " + IntToString(year); }
        if i == 21 { return "Electrical shock injuries - " + IntToString(year); }
        if i == 22 { return "Crush injuries - " + IntToString(year); }
        if i == 23 { return "Motorcycle crash - " + IntToString(year); }
        if i == 24 { return "Workplace accident - " + IntToString(year); }
        
        // Fractures/Orthopedic (25-34)
        if i == 25 { return "Broken arm (set) - " + IntToString(year); }
        if i == 26 { return "Broken leg (set) - " + IntToString(year); }
        if i == 27 { return "Concussion - " + IntToString(year); }
        if i == 28 { return "Spinal injury (recovered) - " + IntToString(year); }
        if i == 29 { return "Dislocated shoulder - " + IntToString(year); }
        if i == 30 { return "Torn ACL (repaired) - " + IntToString(year); }
        if i == 31 { return "Broken collarbone - " + IntToString(year); }
        if i == 32 { return "Fractured wrist - " + IntToString(year); }
        if i == 33 { return "Ankle fracture - " + IntToString(year); }
        if i == 34 { return "Herniated disc - " + IntToString(year); }
        
        // Cyberware-related (35-39)
        if i == 35 { return "Cyberware malfunction injury - " + IntToString(year); }
        if i == 36 { return "Implant rejection trauma - " + IntToString(year); }
        if i == 37 { return "Neural port damage - " + IntToString(year); }
        if i == 38 { return "Reflex booster burnout - " + IntToString(year); }
        return "Chrome installation complications - " + IntToString(year);
    }

    private static func GenerateVaccinationStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            return "CURRENT (Corporate Mandatory)";
        }
        if Equals(archetype, "YUPPIE") { return "CURRENT"; }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 20 { return "CURRENT (City Program)"; }
            if roll <= 50 { return "OUTDATED"; }
            return "UNKNOWN";
        }

        let roll = RandRange(seed, 1, 100);
        if roll <= 40 { return "CURRENT"; }
        if roll <= 70 { return "OUTDATED"; }
        return "PARTIAL";
    }

    private static func HasMentalHealthFlag(seed: Int32, archetype: String) -> Bool {
        let chance: Int32;
        
        if Equals(archetype, "JUNKIE") { chance = 80; }
        else if Equals(archetype, "HOMELESS") { chance = 60; }
        else if Equals(archetype, "GANGER") { chance = 50; }
        else if Equals(archetype, "LOWLIFE") { chance = 40; }
        else if Equals(archetype, "CORPO_DRONE") { chance = 45; }
        else if Equals(archetype, "CORPO_MANAGER") { chance = 35; }
        else { chance = 30; }

        return RandRange(seed, 1, 100) <= chance;
    }

    private static func GenerateGeneticMarker(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        
        // Disease risk markers (0-11)
        if i == 0 { return "Elevated cancer risk (BRCA variant)"; }
        if i == 1 { return "Heart disease predisposition"; }
        if i == 2 { return "Alzheimer's risk marker"; }
        if i == 3 { return "Diabetes Type 1 susceptibility"; }
        if i == 4 { return "Huntington's carrier"; }
        if i == 5 { return "Cystic fibrosis carrier"; }
        if i == 6 { return "Parkinson's risk markers"; }
        if i == 7 { return "Multiple sclerosis susceptibility"; }
        if i == 8 { return "Schizophrenia risk factors"; }
        if i == 9 { return "Autoimmune disorder predisposition"; }
        if i == 10 { return "Colon cancer genetic markers"; }
        if i == 11 { return "Breast cancer genetic risk"; }
        
        // Cyberware compatibility (12-17)
        if i == 12 { return "Enhanced cyberware compatibility"; }
        if i == 13 { return "Reduced cyberware compatibility"; }
        if i == 14 { return "Neural interface optimization"; }
        if i == 15 { return "Cyberpsychosis resistance markers"; }
        if i == 16 { return "Cyberpsychosis susceptibility"; }
        if i == 17 { return "Rapid chrome rejection risk"; }
        
        // Aging/Longevity (18-21)
        if i == 18 { return "Longevity markers (positive)"; }
        if i == 19 { return "Accelerated aging markers"; }
        if i == 20 { return "Telomere stability (above average)"; }
        if i == 21 { return "Premature aging risk"; }
        
        // Physical traits (22-25)
        if i == 22 { return "Enhanced muscle development"; }
        if i == 23 { return "Above average bone density"; }
        if i == 24 { return "Fast metabolism markers"; }
        if i == 25 { return "Slow metabolism markers"; }
        
        // Other genetic findings (26-29)
        if i == 26 { return "Genetic modification detected"; }
        if i == 27 { return "Unknown genetic anomaly"; }
        if i == 28 { return "Chimeric DNA markers"; }
        return "Possible gene therapy modifications";
    }

    private static func CalculateHealthRating(medical: ref<MedicalHistoryData>, archetype: String) -> String {
        let score = 100;

        // Deductions
        score -= ArraySize(medical.chronicConditions) * 10;
        score -= ArraySize(medical.allergies) * 2;
        score -= ArraySize(medical.organReplacements) * 5;
        score -= ArraySize(medical.pastInjuries) * 3;
        
        if medical.mentalHealthFlag { score -= 10; }
        
        // Archetype modifiers
        if Equals(archetype, "JUNKIE") { score -= 25; }
        else if Equals(archetype, "HOMELESS") { score -= 20; }
        else if Equals(archetype, "GANGER") { score -= 10; }
        else if Equals(archetype, "CORPO_MANAGER") { score += 10; }

        if score >= 90 { return "EXCELLENT"; }
        if score >= 75 { return "GOOD"; }
        if score >= 60 { return "FAIR"; }
        if score >= 40 { return "POOR"; }
        if score >= 20 { return "CRITICAL"; }
        return "TERMINAL";
    }
}

public class MedicalHistoryData {
    public let bloodType: String;
    public let age: Int32;
    public let biologicalAge: Int32;
    public let height: String;
    public let weight: String;
    public let chronicConditions: array<String>;
    public let allergies: array<String>;
    public let organReplacements: array<String>;
    public let lastCheckup: String;
    public let ripperdocVisits: Int32;
    public let emergencyVisits: Int32;
    public let donorStatus: String;
    public let organDonorCard: Bool;
    public let currentMedications: array<String>;
    public let pastInjuries: array<String>;
    public let vaccinationStatus: String;
    public let mentalHealthFlag: Bool;
    public let geneticMarkers: array<String>;
    public let healthRating: String;
}
