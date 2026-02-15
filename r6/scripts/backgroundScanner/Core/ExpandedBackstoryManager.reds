// Expanded Backstory Manager
// Main orchestrator that ties together all expanded NPC generation systems

public class KdspExpandedBackstoryManager {

    // Main entry point - generates complete expanded NPC data
    public static func GenerateExpandedProfile(npc: wref<NPCPuppet>) -> ref<KdspExpandedNPCData> {
        let data: ref<KdspExpandedNPCData> = new KdspExpandedNPCData();

        // Get seed from entity for deterministic generation
        let seed = KdspExpandedBackstoryManager.GetSeedFromEntity(npc);

        // Get NPC appearance info
        let appearanceName = NameToString(npc.GetCurrentAppearanceName());
        let gender = KdspExpandedBackstoryManager.DetermineGender(npc);

        // Determine archetype
        data.archetype = KdspExpandedBackstoryManager.DetermineArchetype(appearanceName);

        // Detect gang affiliation from appearance
        let gangAffiliation = KdspGangManager.DetectGangAffiliation(appearanceName, "");

        // Generate age (needed for medical)
        let age = KdspExpandedBackstoryManager.GenerateAge(seed, data.archetype);

        // Check for rare NPC (1 in 1000)
        let isRare = KdspRareNPCManager.ShouldBeRareNPC(seed + 9999);
        if isRare {
            data.rareData = KdspRareNPCManager.Generate(seed + 10000, data.archetype);
        } else {
            data.rareData = new KdspRareNPCData();
            data.rareData.isRare = false;
        }

        // Generate all subsystems
        // Criminal Record
        data.criminalRecord = KdspCriminalRecordManager.Generate(seed + 1000, data.archetype, gangAffiliation);

        // Cyberware Registry
        let wealthEstimate = KdspExpandedBackstoryManager.EstimateWealth(data.archetype);
        data.cyberwareRegistry = KdspCyberwareRegistryManager.Generate(seed + 2000, data.archetype, wealthEstimate);

        // Financial Profile
        data.financialProfile = KdspFinancialProfileManager.Generate(seed + 3000, data.archetype);

        // Medical History
        data.medicalHistory = KdspMedicalHistoryManager.Generate(seed + 4000, data.archetype, age);

        // Psychological Profile (depends on criminal and cyberware)
        data.psychProfile = KdspPsychProfileManager.Generate(seed + 5000, data.archetype, data.criminalRecord, data.cyberwareRegistry);

        // Gang Profile (if affiliated)
        if !Equals(gangAffiliation, "NONE") {
            data.gangProfile = KdspGangManager.GenerateGangProfile(seed + 6000, gangAffiliation);
        } else {
            data.gangProfile = new KdspGangProfileData();
            data.gangProfile.gangAffiliation = "NONE";
        }

        // Detect ethnicity for name generation
        let ethnicity = KdspEthnicityDetector.GetEthnicityFromAppearance(appearanceName, gangAffiliation);
        if Equals(ethnicity, KdspNPCEthnicity.Mixed) {
            ethnicity = KdspEthnicityDetector.GetRandomEthnicity(seed + 888);
        }

        // Relationships
        data.relationships = KdspRelationshipsManager.Generate(seed + 7000, data.archetype, gangAffiliation, ethnicity);

        // District Profile
        let district = KdspCrowdDistrictManager.DetectDistrictFromAppearance(appearanceName);
        if Equals(district, "UNKNOWN") {
            district = "WATSON";
        }
        data.districtProfile = KdspCrowdDistrictManager.GenerateDistrictProfile(seed + 8000, district, data.archetype);

        // Store additional metadata
        data.seed = seed;
        data.gender = gender;
        data.age = age;
        data.appearanceName = appearanceName;

        return data;
    }

    // Generate data for a specific database view
    public static func GenerateDatabaseView(data: ref<KdspExpandedNPCData>, databaseType: String) -> ref<KdspDatabaseViewData> {
        return KdspDatabaseSourceManager.GenerateDatabaseView(data.seed, databaseType, data);
    }

    // Get a quick threat summary (for UI display)
    public static func GetQuickThreatSummary(data: ref<KdspExpandedNPCData>) -> ref<KdspThreatSummaryData> {
        let summary: ref<KdspThreatSummaryData> = new KdspThreatSummaryData();

        summary.threatLevel = data.psychProfile.threatLevel;
        summary.threatColor = data.psychProfile.threatColor;
        summary.armedStatus = data.psychProfile.armedLikelihood;
        summary.combatTraining = data.psychProfile.combatTraining;
        summary.cyberpsychosisRisk = data.cyberwareRegistry.cyberpsychosisRisk;
        summary.approachRecommendation = data.psychProfile.approachRecommendation;

        // Special flags
        if data.rareData.isRare {
            summary.hasSpecialFlag = true;
            summary.specialFlag = data.rareData.displayFlag;
            summary.specialFlagColor = data.rareData.flagColor;
        }

        if !Equals(data.criminalRecord.warrantStatus, "NONE") {
            summary.hasWarrant = true;
            summary.warrantType = data.criminalRecord.warrantStatus;
        }

        if !Equals(data.gangProfile.gangAffiliation, "NONE") && !Equals(data.gangProfile.gangAffiliation, "") {
            summary.hasGangAffiliation = true;
            summary.gangName = data.gangProfile.gangName;
            summary.gangRank = data.gangProfile.memberRank;
        }

        return summary;
    }

    // Helper functions
    private static func GetSeedFromEntity(npc: wref<NPCPuppet>) -> Int32 {
        let entityID = npc.GetEntityID();
        let hash = EntityID.GetHash(entityID);
        return RandRange(Cast(hash), 0, 2147483647);
    }

    private static func DetermineGender(npc: wref<NPCPuppet>) -> String {
        let resolvedBodyType = NameToString(npc.GetBodyType());
        if Equals(resolvedBodyType, "ManBig") || Equals(resolvedBodyType, "ManAverage") || Equals(resolvedBodyType, "ManFat") {
            return "MALE";
        }
        return "FEMALE";
    }

    private static func DetermineArchetype(appearanceName: String) -> String {
        if StrContains(appearanceName, "corporat_ma") || StrContains(appearanceName, "corpo_ma") {
            return "CORPO_MANAGER";
        }
        if StrContains(appearanceName, "corporat_wa") || StrContains(appearanceName, "corpo_wa") || StrContains(appearanceName, "corpo") {
            return "CORPO_DRONE";
        }
        if StrContains(appearanceName, "homeless") || StrContains(appearanceName, "beggar") {
            return "HOMELESS";
        }
        if StrContains(appearanceName, "nomad") || StrContains(appearanceName, "badlands") {
            return "NOMAD";
        }
        if StrContains(appearanceName, "gang") || StrContains(appearanceName, "tyger") || 
           StrContains(appearanceName, "maelstrom") || StrContains(appearanceName, "valentino") ||
           StrContains(appearanceName, "6th") || StrContains(appearanceName, "animal") ||
           StrContains(appearanceName, "voodoo") || StrContains(appearanceName, "scav") {
            return "GANGER";
        }
        if StrContains(appearanceName, "junkie") || StrContains(appearanceName, "addict") {
            return "JUNKIE";
        }
        if StrContains(appearanceName, "rich") || StrContains(appearanceName, "fancy") || StrContains(appearanceName, "luxury") {
            return "YUPPIE";
        }
        if StrContains(appearanceName, "poor") || StrContains(appearanceName, "lowlife") || StrContains(appearanceName, "thug") {
            return "LOWLIFE";
        }
        return "CIVVIE";
    }

    private static func GenerateAge(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 35, 60); }
        if Equals(archetype, "CORPO_DRONE") { return RandRange(seed, 22, 45); }
        if Equals(archetype, "YUPPIE") { return RandRange(seed, 25, 45); }
        if Equals(archetype, "GANGER") { return RandRange(seed, 18, 35); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 25, 65); }
        if Equals(archetype, "JUNKIE") { return RandRange(seed, 20, 50); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 20, 50); }
        return RandRange(seed, 20, 55);
    }

    private static func EstimateWealth(archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return 85; }
        if Equals(archetype, "YUPPIE") { return 70; }
        if Equals(archetype, "CORPO_DRONE") { return 55; }
        if Equals(archetype, "CIVVIE") { return 40; }
        if Equals(archetype, "NOMAD") { return 30; }
        if Equals(archetype, "GANGER") { return 25; }
        if Equals(archetype, "LOWLIFE") { return 15; }
        if Equals(archetype, "JUNKIE") { return 10; }
        if Equals(archetype, "HOMELESS") { return 5; }
        return 35;
    }

    public static func GetAvailableDatabases() -> array<String> {
        return KdspDatabaseSourceManager.GetAvailableDatabases();
    }
}

public class KdspExpandedNPCData {
    public let seed: Int32;
    public let gender: String;
    public let age: Int32;
    public let archetype: String;
    public let appearanceName: String;
    public let criminalRecord: ref<KdspCriminalRecordData>;
    public let cyberwareRegistry: ref<KdspCyberwareRegistryData>;
    public let financialProfile: ref<KdspFinancialProfileData>;
    public let medicalHistory: ref<KdspMedicalHistoryData>;
    public let psychProfile: ref<KdspPsychProfileData>;
    public let gangProfile: ref<KdspGangProfileData>;
    public let relationships: ref<KdspRelationshipsData>;
    public let districtProfile: ref<KdspDistrictProfileData>;
    public let rareData: ref<KdspRareNPCData>;
}

public class KdspThreatSummaryData {
    public let threatLevel: Int32;
    public let threatColor: String;
    public let armedStatus: String;
    public let combatTraining: String;
    public let cyberpsychosisRisk: Int32;
    public let approachRecommendation: String;
    public let hasSpecialFlag: Bool;
    public let specialFlag: String;
    public let specialFlagColor: String;
    public let hasWarrant: Bool;
    public let warrantType: String;
    public let hasGangAffiliation: Bool;
    public let gangName: String;
    public let gangRank: String;
}
