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
            let conditions: array<String>;
            ArrayPush(conditions, "Liver damage (alcohol-related)");
            ArrayPush(conditions, "Cirrhosis - early stage");
            ArrayPush(conditions, "Alcohol-induced neuropathy");
            ArrayPush(conditions, "Chronic gastritis");
            return conditions[RandRange(seed, 0, ArraySize(conditions) - 1)];
        }
        
        if StrContains(StrLower(substanceType), "synth-coke") || StrContains(StrLower(substanceType), "stim") {
            let conditions: array<String>;
            ArrayPush(conditions, "Cardiac arrhythmia (stimulant abuse)");
            ArrayPush(conditions, "Nasal septum damage");
            ArrayPush(conditions, "Chronic hypertension");
            ArrayPush(conditions, "Stimulant-induced anxiety disorder");
            return conditions[RandRange(seed, 0, ArraySize(conditions) - 1)];
        }
        
        if StrContains(StrLower(substanceType), "black lace") {
            let conditions: array<String>;
            ArrayPush(conditions, "Neurotransmitter imbalance");
            ArrayPush(conditions, "Chronic pain syndrome");
            ArrayPush(conditions, "Rage disorder (substance-induced)");
            ArrayPush(conditions, "Adrenal fatigue");
            return conditions[RandRange(seed, 0, ArraySize(conditions) - 1)];
        }
        
        // Generic substance condition
        let conditions: array<String>;
        ArrayPush(conditions, "Substance use disorder");
        ArrayPush(conditions, "Liver enzyme abnormalities");
        ArrayPush(conditions, "Chronic fatigue (substance-related)");
        ArrayPush(conditions, "Immune system compromise");
        return conditions[RandRange(seed, 0, ArraySize(conditions) - 1)];
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
                let injuries: array<String>;
                ArrayPush(injuries, "Gunshot wound (healed)");
                ArrayPush(injuries, "Stab wound - gang altercation");
                ArrayPush(injuries, "Blunt force trauma - gang violence");
                ArrayPush(injuries, "Multiple lacerations - knife fight");
                return injuries[RandRange(seed, 0, ArraySize(injuries) - 1)] + " - " + IntToString(year);
            }
            if Equals(coherence.violenceType, "domestic") {
                let injuries: array<String>;
                ArrayPush(injuries, "Contusions - domestic incident");
                ArrayPush(injuries, "Fracture (set) - fall/assault");
                ArrayPush(injuries, "Soft tissue injuries");
                return injuries[RandRange(seed, 0, ArraySize(injuries) - 1)] + " - " + IntToString(year);
            }
            if Equals(coherence.violenceType, "bar fight") {
                let injuries: array<String>;
                ArrayPush(injuries, "Broken nose (set)");
                ArrayPush(injuries, "Facial lacerations - brawl");
                ArrayPush(injuries, "Concussion - fight");
                ArrayPush(injuries, "Hand fractures - fight");
                return injuries[RandRange(seed, 0, ArraySize(injuries) - 1)] + " - " + IntToString(year);
            }
        }
        
        if IsDefined(coherence) && coherence.hasTrauma && Equals(coherence.traumaType, "accident") {
            let injuries: array<String>;
            ArrayPush(injuries, "Vehicular accident injuries");
            ArrayPush(injuries, "Industrial accident");
            ArrayPush(injuries, "Fall injuries - serious");
            ArrayPush(injuries, "Multiple fractures - accident");
            return injuries[RandRange(seed, 0, ArraySize(injuries) - 1)] + " - " + IntToString(year);
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
        let types: array<String>;
        // Realistic distribution
        ArrayPush(types, "O+");  // 37%
        ArrayPush(types, "O+");
        ArrayPush(types, "O+");
        ArrayPush(types, "O+");
        ArrayPush(types, "A+");  // 36%
        ArrayPush(types, "A+");
        ArrayPush(types, "A+");
        ArrayPush(types, "A+");
        ArrayPush(types, "B+");  // 9%
        ArrayPush(types, "AB+"); // 3%
        ArrayPush(types, "O-");  // 7%
        ArrayPush(types, "A-");  // 6%
        ArrayPush(types, "B-");  // 1%
        ArrayPush(types, "AB-"); // 1%
        ArrayPush(types, "SYNTHETIC"); // Cyberpunk addition
        
        return types[RandRange(seed, 0, ArraySize(types) - 1)];
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
        let conditions: array<String>;

        // Common conditions
        ArrayPush(conditions, "Hypertension");
        ArrayPush(conditions, "Type 2 Diabetes");
        ArrayPush(conditions, "Chronic Back Pain");
        ArrayPush(conditions, "Asthma");
        ArrayPush(conditions, "Arthritis");
        ArrayPush(conditions, "Anxiety Disorder");
        ArrayPush(conditions, "Depression");
        ArrayPush(conditions, "Migraines");
        ArrayPush(conditions, "Sleep Disorder");
        ArrayPush(conditions, "Respiratory Issues (Smog-Related)");
        
        // Night City specific
        ArrayPush(conditions, "Cyberware Rejection Syndrome");
        ArrayPush(conditions, "Neural Degradation (Mild)");
        ArrayPush(conditions, "Synthetic Organ Maintenance");
        ArrayPush(conditions, "Radiation Exposure Effects");
        ArrayPush(conditions, "Combat-Related PTSD");
        ArrayPush(conditions, "Braindance Dependency");
        ArrayPush(conditions, "Chronic Pain (Bullet Wound)");
        ArrayPush(conditions, "Toxin Accumulation");
        
        // Archetype-specific conditions
        if Equals(archetype, "JUNKIE") {
            ArrayPush(conditions, "Substance Dependency - Active");
            ArrayPush(conditions, "Hepatic Damage");
            ArrayPush(conditions, "Neurochemical Imbalance");
            ArrayPush(conditions, "Malnutrition");
        }
        if Equals(archetype, "GANGER") {
            ArrayPush(conditions, "Healed Stab Wounds");
            ArrayPush(conditions, "Bullet Fragment Retention");
            ArrayPush(conditions, "Combat Injuries (Multiple)");
        }
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            ArrayPush(conditions, "Carpal Tunnel Syndrome");
            ArrayPush(conditions, "Stress-Related Hypertension");
            ArrayPush(conditions, "Burnout Syndrome");
        }

        return conditions[RandRange(seed, 0, ArraySize(conditions) - 1)];
    }

    private static func GenerateAllergy(seed: Int32) -> String {
        let allergies: array<String>;
        
        ArrayPush(allergies, "Penicillin");
        ArrayPush(allergies, "Shellfish");
        ArrayPush(allergies, "Peanuts");
        ArrayPush(allergies, "Latex");
        ArrayPush(allergies, "Synthetic Proteins");
        ArrayPush(allergies, "Titanium Compounds");
        ArrayPush(allergies, "Biofoam");
        ArrayPush(allergies, "Neural Interface Gel");
        ArrayPush(allergies, "Specific Nanobots");
        ArrayPush(allergies, "Anesthetic (Type C)");
        ArrayPush(allergies, "Kibble Additives");
        ArrayPush(allergies, "Soy Derivatives");

        return allergies[RandRange(seed, 0, ArraySize(allergies) - 1)];
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
        let organs: array<String>;
        
        ArrayPush(organs, "Synthetic Liver (Biotechnica)");
        ArrayPush(organs, "Synthetic Kidney (Left)");
        ArrayPush(organs, "Synthetic Kidney (Right)");
        ArrayPush(organs, "Synthetic Heart");
        ArrayPush(organs, "Synthetic Lung (Left)");
        ArrayPush(organs, "Synthetic Lung (Right)");
        ArrayPush(organs, "Cloned Liver");
        ArrayPush(organs, "Cloned Kidney");
        ArrayPush(organs, "Artificial Eye (Non-Kiroshi)");
        ArrayPush(organs, "Synthetic Pancreas");
        ArrayPush(organs, "Bioengineered Stomach");
        ArrayPush(organs, "Vat-Grown Skin Grafts");

        return organs[RandRange(seed, 0, ArraySize(organs) - 1)];
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
        let medications: array<String>;

        ArrayPush(medications, "SynthBlood Stabilizers");
        ArrayPush(medications, "NeuroBalance (Generic)");
        ArrayPush(medications, "HeartGuard");
        ArrayPush(medications, "PainAway");
        ArrayPush(medications, "Immunosupressants (Cyberware)");
        ArrayPush(medications, "SleepEZ");
        ArrayPush(medications, "Metabolic Boosters");
        ArrayPush(medications, "Blood Pressure Meds");
        ArrayPush(medications, "Diabetes Management System");
        ArrayPush(medications, "Anti-Rejection Meds");
        ArrayPush(medications, "Respiratory Therapy Inhaler");
        ArrayPush(medications, "Mood Stabilizers");
        ArrayPush(medications, "Cognitive Enhancers");
        ArrayPush(medications, "Bone Density Treatment");
        
        if Equals(archetype, "JUNKIE") {
            ArrayPush(medications, "Addiction Treatment (Non-compliant)");
            ArrayPush(medications, "Naloxone (Self-Administered)");
            ArrayPush(medications, "Liver Support Supplements");
        }

        return medications[RandRange(seed, 0, ArraySize(medications) - 1)];
    }

    private static func GetInjuryCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return RandRange(seed, 2, 7); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 1, 4); }
        if Equals(archetype, "LOWLIFE") { return RandRange(seed, 0, 3); }
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 0, 1); }
        return RandRange(seed, 0, 2);
    }

    private static func GenerateInjury(seed: Int32) -> String {
        let injuries: array<String>;

        ArrayPush(injuries, "Gunshot wound (healed) - " + IntToString(RandRange(seed, 2065, 2076)));
        ArrayPush(injuries, "Stab wound - " + IntToString(RandRange(seed, 2068, 2076)));
        ArrayPush(injuries, "Broken arm (set) - " + IntToString(RandRange(seed, 2060, 2075)));
        ArrayPush(injuries, "Broken leg (set) - " + IntToString(RandRange(seed, 2060, 2075)));
        ArrayPush(injuries, "Concussion - " + IntToString(RandRange(seed, 2070, 2077)));
        ArrayPush(injuries, "Burns (2nd degree) - " + IntToString(RandRange(seed, 2065, 2076)));
        ArrayPush(injuries, "Vehicular accident injuries - " + IntToString(RandRange(seed, 2065, 2076)));
        ArrayPush(injuries, "Industrial accident - " + IntToString(RandRange(seed, 2068, 2076)));
        ArrayPush(injuries, "Chemical exposure - " + IntToString(RandRange(seed, 2070, 2077)));
        ArrayPush(injuries, "Cyberware malfunction injury - " + IntToString(RandRange(seed, 2072, 2077)));
        ArrayPush(injuries, "Assault injuries - " + IntToString(RandRange(seed, 2070, 2077)));
        ArrayPush(injuries, "Fall injuries - " + IntToString(RandRange(seed, 2068, 2076)));

        return injuries[RandRange(seed, 0, ArraySize(injuries) - 1)];
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
        let markers: array<String>;

        ArrayPush(markers, "Elevated cancer risk (BRCA variant)");
        ArrayPush(markers, "Heart disease predisposition");
        ArrayPush(markers, "Alzheimer's risk marker");
        ArrayPush(markers, "Diabetes Type 1 susceptibility");
        ArrayPush(markers, "Huntington's carrier");
        ArrayPush(markers, "Cystic fibrosis carrier");
        ArrayPush(markers, "Enhanced cyberware compatibility");
        ArrayPush(markers, "Reduced cyberware compatibility");
        ArrayPush(markers, "Longevity markers (positive)");
        ArrayPush(markers, "Accelerated aging markers");
        ArrayPush(markers, "Enhanced muscle development");
        ArrayPush(markers, "Genetic modification detected");

        return markers[RandRange(seed, 0, ArraySize(markers) - 1)];
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
