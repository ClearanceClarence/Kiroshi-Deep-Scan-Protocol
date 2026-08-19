// Medical History Generation System
public class KdspMedicalHistoryManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String, age: Int32) -> ref<KdspMedicalHistoryData> {
        return KdspMedicalHistoryManager.GenerateCoherent(seed, archetype, age, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, age: Int32, coherence: ref<KdspCoherenceProfile>) -> ref<KdspMedicalHistoryData> {
        let medical: ref<KdspMedicalHistoryData> = new KdspMedicalHistoryData();
        let density = KdspSettings.GetDataDensity();

        // Basic info - always shown
        medical.bloodType = KdspMedicalHistoryManager.GenerateBloodType(seed);
        medical.age = age;
        medical.biologicalAge = KdspMedicalHistoryManager.CalculateBiologicalAgeCoherent(seed + 10, age, archetype, coherence);
        
        // Physical stats - only on medium/high
        if density >= 2 {
            medical.height = KdspMedicalHistoryManager.GenerateHeight(seed + 20, archetype);
            medical.weight = KdspMedicalHistoryManager.GenerateWeight(seed + 30, archetype);
        }

        // Conditions - limited by density
        let conditionCount = KdspMedicalHistoryManager.GetConditionCountCoherent(seed + 100, archetype, age, coherence);
        conditionCount = KdspSettings.GetMaxListItems(conditionCount);
        
        let i = 0;
        while i < conditionCount {
            ArrayPush(medical.chronicConditions, KdspMedicalHistoryManager.GenerateConditionCoherent(seed + 110 + (i * 17), archetype, coherence));
            i += 1;
        }

        // Add substance-related conditions if coherence indicates
        if IsDefined(coherence) && coherence.hasSubstanceIssues && RandRange(seed + 150, 1, 100) <= 70 {
            ArrayPush(medical.chronicConditions, KdspMedicalHistoryManager.GenerateSubstanceCondition(seed + 151, coherence.substanceType));
        }

        // Allergies - only on medium/high density
        if density >= 2 && RandRange(seed + 200, 1, 100) <= 35 {
            let allergyCount = RandRange(seed + 210, 1, 4);
            allergyCount = KdspSettings.GetMaxListItems(allergyCount);
            i = 0;
            while i < allergyCount {
                ArrayPush(medical.allergies, KdspMedicalHistoryManager.GenerateAllergy(seed + 220 + (i * 13)));
                i += 1;
            }
        }

        // Organ replacements - limited by density
        let organChance = KdspMedicalHistoryManager.GetOrganReplacementChance(archetype, age);
        if RandRange(seed + 300, 1, 100) <= organChance {
            let organCount = RandRange(seed + 310, 1, 3);
            organCount = KdspSettings.GetMaxListItems(organCount);
            i = 0;
            while i < organCount {
                ArrayPush(medical.organReplacements, KdspMedicalHistoryManager.GenerateOrganReplacement(seed + 320 + (i * 19)));
                i += 1;
            }
        }

        // Medical visits - only on medium/high
        if density >= 2 {
            medical.lastCheckup = KdspMedicalHistoryManager.GenerateLastCheckup(seed + 400, archetype);
            medical.ripperdocVisits = KdspMedicalHistoryManager.GenerateRipperdocVisits(seed + 410, archetype);
            medical.emergencyVisits = KdspMedicalHistoryManager.GenerateEmergencyVisitsCoherent(seed + 420, archetype, coherence);
        }

        // Donor status - only on high density
        if density >= 3 {
            medical.donorStatus = KdspMedicalHistoryManager.GenerateDonorStatus(seed + 500, archetype);
            medical.organDonorCard = RandRange(seed + 510, 1, 100) <= 30;
        }

        // Medications - limited by density
        let medCount = KdspMedicalHistoryManager.GetMedicationCount(seed + 600, archetype, ArraySize(medical.chronicConditions));
        medCount = KdspSettings.GetMaxListItems(medCount);
        i = 0;
        while i < medCount {
            ArrayPush(medical.currentMedications, KdspMedicalHistoryManager.GenerateMedication(seed + 610 + (i * 23), archetype));
            i += 1;
        }

        // Injuries - limited by density
        let injuryCount = KdspMedicalHistoryManager.GetInjuryCountCoherent(seed + 700, archetype, coherence);
        injuryCount = KdspSettings.GetMaxListItems(injuryCount);
        i = 0;
        while i < injuryCount {
            ArrayPush(medical.pastInjuries, KdspMedicalHistoryManager.GenerateInjuryCoherent(seed + 710 + (i * 29), coherence));
            i += 1;
        }

        // Vaccinations - only on high density
        if density >= 3 {
            medical.vaccinationStatus = KdspMedicalHistoryManager.GenerateVaccinationStatus(seed + 800, archetype);
        }

        // Mental health - always shown (important)
        medical.mentalHealthFlag = KdspMedicalHistoryManager.HasMentalHealthFlagCoherent(seed + 900, archetype, coherence);

        // Genetic markers - only on high density
        if density >= 3 && RandRange(seed + 1000, 1, 100) <= 25 {
            ArrayPush(medical.geneticMarkers, KdspMedicalHistoryManager.GenerateGeneticMarker(seed + 1010));
            if RandRange(seed + 1020, 1, 100) <= 30 {
                ArrayPush(medical.geneticMarkers, KdspMedicalHistoryManager.GenerateGeneticMarker(seed + 1030));
            }
        }

        // Overall health rating
        medical.healthRating = KdspMedicalHistoryManager.CalculateHealthRating(medical, archetype);

        return medical;
    }

    // Biological age affected by substance abuse and trauma
    private static func CalculateBiologicalAgeCoherent(seed: Int32, chronoAge: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let bioAge = KdspMedicalHistoryManager.CalculateBiologicalAge(seed, chronoAge, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasSubstanceIssues { bioAge += RandRange(seed + 5, 3, 8); }
            if Equals(coherence.lifeTheme, "FALLING") { bioAge += RandRange(seed + 6, 2, 5); }
            if coherence.hasChronicHealth { bioAge += RandRange(seed + 7, 1, 4); }
        }
        
        if bioAge > 120 { bioAge = 120; }
        return bioAge;
    }

    // Condition count influenced by coherence
    private static func GetConditionCountCoherent(seed: Int32, archetype: String, age: Int32, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let base = KdspMedicalHistoryManager.GetConditionCount(seed, archetype, age);
        
        if IsDefined(coherence) {
            if coherence.hasChronicHealth { base += 1; }
            if coherence.hasSubstanceIssues { base += 1; }
            if Equals(coherence.lifeTheme, "FALLING") { base += 1; }
        }
        
        if base > 6 { base = 6; }
        return base;
    }

    // Generate condition that matches coherence
    private static func GenerateConditionCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        // 40% chance to generate coherence-matching condition
        if IsDefined(coherence) && RandRange(seed + 50, 1, 100) <= 40 {
            if coherence.hasSubstanceIssues {
                return KdspMedicalHistoryManager.GenerateSubstanceCondition(seed, coherence.substanceType);
            }
        }
        
        return KdspMedicalHistoryManager.GenerateCondition(seed, archetype);
    }

    // Substance-specific medical conditions
    private static func GenerateSubstanceCondition(seed: Int32, substanceType: String) -> String {
        if Equals(substanceType, "alcohol") || Equals(substanceType, "synthetic alcohol") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S0"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S1"); }
            if i == 2 { return "Alcohol-induced neuropathy"; }
            if i == 3 { return "Chronic gastritis"; }
            if i == 4 { return "Alcoholic cardiomyopathy"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S2"); }
            if i == 6 { return "Pancreatitis (alcohol-induced)"; }
            if i == 7 { return "Esophageal varices"; }
            if i == 8 { return "Alcohol-induced dementia"; }
            return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S3");
        }
        
        if StrContains(StrLower(substanceType), "synth-coke") || StrContains(StrLower(substanceType), "stim") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S4"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S5"); }
            if i == 2 { return "Chronic hypertension"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S6"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S7"); }
            if i == 5 { return "Cardiovascular strain"; }
            if i == 6 { return "Chronic insomnia"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S8"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S9"); }
            return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S10");
        }
        
        if StrContains(StrLower(substanceType), "black lace") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Neurotransmitter imbalance"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S11"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S12"); }
            if i == 3 { return "Adrenal fatigue"; }
            if i == 4 { return "Combat addiction"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S13"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S14"); }
            if i == 7 { return "Aggression syndrome"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S15"); }
            return "Violence-induced PTSD";
        }
        
        if StrContains(StrLower(substanceType), "glitter") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S16"); }
            if i == 1 { return "Memory fragmentation"; }
            if i == 2 { return "Emotional dysregulation"; }
            if i == 3 { return "Hyperthermia episodes"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S17"); }
            return "Dehydration damage";
        }
        
        if StrContains(StrLower(substanceType), "smash") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S18"); }
            if i == 1 { return "Testosterone imbalance"; }
            if i == 2 { return "Heart enlargement"; }
            if i == 3 { return "Liver stress"; }
            if i == 4 { return "Aggression disorder"; }
            return "Joint deterioration";
        }
        
        if StrContains(StrLower(substanceType), "spike") || StrContains(StrLower(substanceType), "dorph") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "Opioid dependency"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S19"); }
            if i == 2 { return "Chronic constipation"; }
            if i == 3 { return "Hormonal imbalance"; }
            if i == 4 { return "Immune suppression"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S20"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S21"); }
            return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S22");
        }
        
        // Generic substance condition
        let i = RandRange(seed, 0, 11);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S23"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S24"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S25"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S26"); }
        if i == 4 { return "Nutritional deficiencies"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S27"); }
        if i == 6 { return "Cognitive impairment"; }
        if i == 7 { return "Mood instability"; }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S28"); }
        if i == 9 { return "Polydrug complications"; }
        if i == 10 { return "Vascular damage"; }
        return "Neurological deterioration";
    }

    // Emergency visits affected by violence/trauma
    private static func GenerateEmergencyVisitsCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let base = KdspMedicalHistoryManager.GenerateEmergencyVisits(seed, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { base += RandRange(seed + 5, 1, 3); }
            if coherence.hasTrauma && Equals(coherence.traumaType, "accident") { base += RandRange(seed + 6, 1, 2); }
        }
        
        return base;
    }

    // Injury count influenced by violence
    private static func GetInjuryCountCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let base = KdspMedicalHistoryManager.GetInjuryCount(seed, archetype);
        
        if IsDefined(coherence) {
            if coherence.hasViolentPast { base += RandRange(seed + 5, 1, 3); }
            if coherence.hasTrauma && Equals(coherence.traumaType, "violence") { base += 1; }
            if coherence.hasTrauma && Equals(coherence.traumaType, "accident") { base += 2; }
        }
        
        if base > 8 { base = 8; }
        return base;
    }

    // Injury type matches violence type
    private static func GenerateInjuryCoherent(seed: Int32, coherence: ref<KdspCoherenceProfile>) -> String {
        let year = RandRange(seed + 1000, 2065, 2077);
        
        if IsDefined(coherence) && coherence.hasViolentPast && RandRange(seed + 50, 1, 100) <= 60 {
            if Equals(coherence.violenceType, "gang") {
                let i = RandRange(seed, 0, 11);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S29") + IntToString(year); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S30") + IntToString(year); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S31") + IntToString(year); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S32") + IntToString(year); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S33") + IntToString(year); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S34") + IntToString(year); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S35") + IntToString(year); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S36") + IntToString(year); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S37") + IntToString(year); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S38") + IntToString(year); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S39") + IntToString(year); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S40") + IntToString(year);
            }
            if Equals(coherence.violenceType, "domestic") {
                let i = RandRange(seed, 0, 8);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S41") + IntToString(year); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S42") + IntToString(year); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S43") + IntToString(year); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S44") + IntToString(year); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S45") + IntToString(year); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S46") + IntToString(year); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S47") + IntToString(year); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S48") + IntToString(year); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S49") + IntToString(year);
            }
            if Equals(coherence.violenceType, "bar fight") {
                let i = RandRange(seed, 0, 9);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S50") + IntToString(year); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S51") + IntToString(year); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S52") + IntToString(year); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S53") + IntToString(year); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S54") + IntToString(year); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S55") + IntToString(year); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S56") + IntToString(year); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S57") + IntToString(year); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S58") + IntToString(year); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S59") + IntToString(year);
            }
            if Equals(coherence.violenceType, "street") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S60") + IntToString(year); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S61") + IntToString(year); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S62") + IntToString(year); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S63") + IntToString(year); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S64") + IntToString(year); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S65") + IntToString(year); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S66") + IntToString(year); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S67") + IntToString(year);
            }
        }
        
        if IsDefined(coherence) && coherence.hasTrauma && Equals(coherence.traumaType, "accident") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S68") + IntToString(year); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S69") + IntToString(year); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S70") + IntToString(year); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S71") + IntToString(year); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S72") + IntToString(year); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S73") + IntToString(year); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S74") + IntToString(year); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S75") + IntToString(year); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S76") + IntToString(year); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S77") + IntToString(year); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S78") + IntToString(year); }
            return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S79") + IntToString(year);
        }
        
        return KdspMedicalHistoryManager.GenerateInjury(seed);
    }

    // Mental health flag influenced by trauma
    private static func HasMentalHealthFlagCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Bool {
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
        if i >= 0 && i <= 8 { return "O RhD+"; }
        // A+ (36%)
        if i >= 9 && i <= 16 { return "A RhD+"; }
        // B+ (9%)
        if i == 17 || i == 18 { return "B RhD+"; }
        // AB+ (3%)
        if i == 19 { return "AB RhD+"; }
        // O- (7%)
        if i == 20 { return "O RhD-"; }
        // A- (6%)
        if i == 21 { return "A RhD-"; }
        // B- (1%)
        if i == 22 { return "B RhD-"; }
        // AB- (1%)
        if i == 23 { return "AB RhD-"; }
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
        
        return IntToString(heightCm) + GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S80") + IntToString(feet) + "'" + IntToString(inches) + "\")";
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
        return IntToString(weightKg) + GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S81") + IntToString(lbs) + " lbs)";
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
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S82"); }
                if i == 1 { return "Hepatic Damage"; }
                if i == 2 { return "Neurochemical Imbalance"; }
                if i == 3 { return "Malnutrition"; }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S83"); }
                if i == 5 { return "Overdose History"; }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S84"); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S85");
            }
            if Equals(archetype, "GANGER") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S86"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S87"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S88"); }
                if i == 3 { return "Cauliflower Ear"; }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S89"); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S90"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S91"); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S92");
            }
            if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S93"); }
                if i == 1 { return "Stress-Related Hypertension"; }
                if i == 2 { return "Burnout Syndrome"; }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S94"); }
                if i == 4 { return "Tension Headaches"; }
                if i == 5 { return "Insomnia (Work-Related)"; }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S95"); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S96");
            }
            if Equals(archetype, "HOMELESS") {
                let i = RandRange(seed, 0, 7);
                if i == 0 { return "Exposure Injuries"; }
                if i == 1 { return "Malnutrition"; }
                if i == 2 { return "Untreated Infections"; }
                if i == 3 { return "Parasitic Infection"; }
                if i == 4 { return "Frostbite Scarring"; }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S97"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S98"); }
                return "Chronic Dehydration";
            }
            if Equals(archetype, "NOMAD") {
                let i = RandRange(seed, 0, 5);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S99"); }
                if i == 1 { return "Dust Lung"; }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S100"); }
                if i == 3 { return "Dehydration History"; }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S101"); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S102");
            }
        }

        // General conditions (80 total)
        let i = RandRange(seed, 0, 79);
        
        // Common conditions (0-19)
        if i == 0 { return "Hypertension"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S103"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S104"); }
        if i == 3 { return "Asthma"; }
        if i == 4 { return "Arthritis"; }
        if i == 5 { return "Anxiety Disorder"; }
        if i == 6 { return "Depression"; }
        if i == 7 { return "Migraines"; }
        if i == 8 { return "Sleep Disorder"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S105"); }
        if i == 10 { return "High Cholesterol"; }
        if i == 11 { return "Acid Reflux"; }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S106"); }
        if i == 13 { return "Chronic Fatigue"; }
        if i == 14 { return "Allergic Rhinitis"; }
        if i == 15 { return "Eczema"; }
        if i == 16 { return "Psoriasis"; }
        if i == 17 { return "Hypothyroidism"; }
        if i == 18 { return "Hyperthyroidism"; }
        if i == 19 { return "Anemia"; }
        
        // Night City specific (20-39)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S107"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S108"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S109"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S110"); }
        if i == 24 { return "Combat-Related PTSD"; }
        if i == 25 { return "Braindance Dependency"; }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S111"); }
        if i == 27 { return "Toxin Accumulation"; }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S112"); }
        if i == 29 { return "Chrome Allergy"; }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S113"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S114"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S115"); }
        if i == 33 { return "Memory Fragmentation"; }
        if i == 34 { return "Interface Headaches"; }
        if i == 35 { return "Biomon Dependency"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S116"); }
        if i == 37 { return "Kerenzikov Tremors"; }
        if i == 38 { return "Sandevistan Strain"; }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S117"); }
        
        // Mental health (40-49)
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S118"); }
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S119"); }
        if i == 42 { return "Bipolar Disorder"; }
        if i == 43 { return "PTSD"; }
        if i == 44 { return "Panic Disorder"; }
        if i == 45 { return "Social Anxiety"; }
        if i == 46 { return "OCD"; }
        if i == 47 { return "ADHD"; }
        if i == 48 { return "Insomnia (Chronic)"; }
        if i == 49 { return "Dissociative Episodes"; }
        
        // Cardiovascular (50-54)
        if i == 50 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S120"); }
        if i == 51 { return "Heart Arrhythmia"; }
        if i == 52 { return "Heart Murmur"; }
        if i == 53 { return "Varicose Veins"; }
        if i == 54 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S121"); }
        
        // Respiratory (55-59)
        if i == 55 { return "COPD"; }
        if i == 56 { return "Chronic Bronchitis"; }
        if i == 57 { return "Emphysema"; }
        if i == 58 { return "Pneumonia (Recurring)"; }
        if i == 59 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S122"); }
        
        // Digestive (60-64)
        if i == 60 { return "Crohn's Disease"; }
        if i == 61 { return "Ulcerative Colitis"; }
        if i == 62 { return "Gastric Ulcers"; }
        if i == 63 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S123"); }
        if i == 64 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S124"); }
        
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
        if i == 73 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S125"); }
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
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S126"); }
        if i == 14 { return "Specific Nanobots"; }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S127"); }
        if i == 16 { return "Kibble Additives"; }
        if i == 17 { return "Soy Derivatives"; }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S128"); }
        if i == 19 { return "Cyberware Coolant"; }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S129"); }
        if i == 21 { return "Neural Suppressants"; }
        if i == 22 { return "Biotech Adhesives"; }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S130"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S131"); }
        
        // Medical/Drug allergies (25-34)
        if i == 25 { return "Morphine Derivatives"; }
        if i == 26 { return "Contrast Dye"; }
        if i == 27 { return "Anesthesia (General)"; }
        if i == 28 { return "Immunosuppressants"; }
        if i == 29 { return "Antivirals (Common)"; }
        if i == 30 { return "Synthetic Hormones"; }
        if i == 31 { return "Stimulant Medications"; }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S132"); }
        if i == 33 { return "Anti-Rejection Meds"; }
        return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S133");
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
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S134"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S135"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S136"); }
        if i == 3 { return "Synthetic Heart"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S137"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S138"); }
        if i == 6 { return "Cloned Liver"; }
        if i == 7 { return "Cloned Kidney"; }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S139"); }
        if i == 9 { return "Synthetic Pancreas"; }
        if i == 10 { return "Bioengineered Stomach"; }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S140"); }
        
        // Additional organs (12-19)
        if i == 12 { return "Synthetic Spleen"; }
        if i == 13 { return "Artificial Bladder"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S141"); }
        if i == 15 { return "Synthetic Thyroid"; }
        if i == 16 { return "Cloned Corneas"; }
        if i == 17 { return "Artificial Larynx"; }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S142"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S143"); }
        
        // Specialized replacements (20-29)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S144"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S145"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S146"); }
        if i == 23 { return "3D-Printed Trachea"; }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S147"); }
        if i == 25 { return "Synthetic Esophagus"; }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S148"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S149"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S150"); }
        return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S151");
    }

    private static func GenerateLastCheckup(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "< 3 months ago (Corporate Mandatory)"; }
        if Equals(archetype, "CORPO_DRONE") { return "< 6 months ago (Corporate Mandatory)"; }
        if Equals(archetype, "YUPPIE") { return IntToString(RandRange(seed, 2, 8)) + " months ago"; }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") { return "Unknown / Never"; }

        let months = RandRange(seed, 6, 48);
        if months >= 24 { return IntToString(months / 12) + GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S152"); }
        return IntToString(months) + GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S155");
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
        ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S153"));
        ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S154"));
        ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S155"));
        ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S156"));
        ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S157"));

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
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S158"); }
                if i == 1 { return "Naloxone (Self-Administered)"; }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S159"); }
                if i == 3 { return "Methadone (Prescription)"; }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S160"); }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S161");
            }
            if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
                let i = RandRange(seed, 0, 5);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S162"); }
                if i == 1 { return "CorpoCalm (Anti-Anxiety)"; }
                if i == 2 { return "SleepCycle Regulator"; }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S163"); }
                if i == 4 { return "NeuroSharp (Cognitive)"; }
                return "UlcerGuard (Preventive)";
            }
            if Equals(archetype, "GANGER") {
                let i = RandRange(seed, 0, 3);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S164"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S165"); }
                if i == 2 { return "Scarring Treatment"; }
                return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S166");
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
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S167"); }
        if i == 6 { return "Neural Stabilizers"; }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S168"); }
        if i == 8 { return "Implant Anti-Inflammatory"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S169"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S170"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S171"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S172"); }
        if i == 13 { return "Nanobot Replenishment"; }
        if i == 14 { return "Cyberpsychosis Preventive"; }
        
        // Cardiovascular (15-19)
        if i == 15 { return "HeartGuard"; }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S173"); }
        if i == 17 { return "Cholesterol Blockers"; }
        if i == 18 { return "Blood Thinners"; }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S174"); }
        
        // Pain/Inflammation (20-24)
        if i == 20 { return "PainAway"; }
        if i == 21 { return "Anti-Inflammatory (Chronic)"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S175"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S176"); }
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
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S177"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S178"); }
        
        // Metabolic/Endocrine (35-39)
        if i == 35 { return "Metabolic Boosters"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S179"); }
        if i == 37 { return "Thyroid Regulators"; }
        if i == 38 { return "Hormone Replacement"; }
        if i == 39 { return "Appetite Suppressants"; }
        
        // Respiratory/Other (40-49)
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S180"); }
        if i == 41 { return "Asthma Controller"; }
        if i == 42 { return "Allergy Blockers"; }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S181"); }
        if i == 44 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S182"); }
        if i == 45 { return "Digestive Enzymes"; }
        if i == 46 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S183"); }
        if i == 47 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S184"); }
        if i == 48 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S185"); }
        return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S186");
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
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S29") + IntToString(year); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S187") + IntToString(year); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S188") + IntToString(year); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S189") + IntToString(year); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S190") + IntToString(year); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S191") + IntToString(year); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S192") + IntToString(year); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S193") + IntToString(year); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S194") + IntToString(year); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S195") + IntToString(year); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S196") + IntToString(year); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S197") + IntToString(year); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S198") + IntToString(year); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S199") + IntToString(year); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S200") + IntToString(year); }
        
        // Accidents (15-24)
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S68") + IntToString(year); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S69") + IntToString(year); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S201") + IntToString(year); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S202") + IntToString(year); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S203") + IntToString(year); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S204") + IntToString(year); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S205") + IntToString(year); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S206") + IntToString(year); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S72") + IntToString(year); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S207") + IntToString(year); }
        
        // Fractures/Orthopedic (25-34)
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S208") + IntToString(year); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S209") + IntToString(year); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S210") + IntToString(year); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S211") + IntToString(year); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S212") + IntToString(year); }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S213") + IntToString(year); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S214") + IntToString(year); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S215") + IntToString(year); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S216") + IntToString(year); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S217") + IntToString(year); }
        
        // Cyberware-related (35-39)
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S218") + IntToString(year); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S219") + IntToString(year); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S220") + IntToString(year); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S221") + IntToString(year); }
        return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S222") + IntToString(year);
    }

    private static func GenerateVaccinationStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S223");
        }
        if Equals(archetype, "YUPPIE") { return "CURRENT"; }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 20 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S224"); }
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
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S225"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S226"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S227"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S228"); }
        if i == 4 { return "Huntington's carrier"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S229"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S230"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S231"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S232"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S233"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S234"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S235"); }
        
        // Cyberware compatibility (12-17)
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S236"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S237"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S238"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S239"); }
        if i == 16 { return "Cyberpsychosis susceptibility"; }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S240"); }
        
        // Aging/Longevity (18-21)
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S241"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S242"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S243"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S244"); }
        
        // Physical traits (22-25)
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S245"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S246"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S247"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S248"); }
        
        // Other genetic findings (26-29)
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S249"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S250"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S251"); }
        return GetLocalizedTextByKey(n"Kdsp-MedicalHistory-S252");
    }

    private static func CalculateHealthRating(medical: ref<KdspMedicalHistoryData>, archetype: String) -> String {
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

public class KdspMedicalHistoryData {
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
