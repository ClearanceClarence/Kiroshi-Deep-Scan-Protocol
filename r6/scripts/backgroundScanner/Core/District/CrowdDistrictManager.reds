// District-Aware Generation System
public class KdspCrowdDistrictManager {

    public static func GetCurrentDistrict(position: Vector4) -> String {
        // Approximate district bounding regions in world space, checked in
        // priority order. Anything outside the city grid is BADLANDS.
        let x: Float = position.X;
        let y: Float = position.Y;

        // Pacifica / Dogtown — far southwest
        if x < -800.0 && y < -1400.0 {
            if x > -1900.0 && y < -2400.0 {
                return "DOGTOWN";
            };
            return "PACIFICA";
        };

        // City Center — western central
        if x < -250.0 && x > -2000.0 && y > -1100.0 && y < 900.0 {
            return "CITY_CENTER";
        };

        // Heywood — south central
        if x > -1100.0 && x < 900.0 && y < 0.0 && y > -2400.0 {
            return "HEYWOOD";
        };

        // Santo Domingo — southeast
        if x > 700.0 && y < -400.0 {
            return "SANTO_DOMINGO";
        };

        // Westbrook — east (Japantown, Charter Hill, North Oak)
        if x > 400.0 && y > -500.0 && y < 3200.0 {
            return "WESTBROOK";
        };

        // Watson — north
        if y > 700.0 && x > -1700.0 && x < 1300.0 {
            return "WATSON";
        };

        // Inside rough city bounds but unmatched — generic
        if x > -2600.0 && x < 3600.0 && y > -4600.0 && y < 4600.0 {
            return "UNKNOWN";
        };

        return "BADLANDS";
    }

    public static func DetectDistrictFromAppearance(appearanceName: String) -> String {
        // Some NPCs have district hints in their appearance names
        if StrContains(appearanceName, "japantown") || StrContains(appearanceName, "westbrook") {
            return "WESTBROOK";
        }
        if StrContains(appearanceName, "pacifica") {
            return "PACIFICA";
        }
        if StrContains(appearanceName, "heywood") {
            return "HEYWOOD";
        }
        if StrContains(appearanceName, "watson") || StrContains(appearanceName, "kabuki") {
            return "WATSON";
        }
        if StrContains(appearanceName, "santo") || StrContains(appearanceName, "arroyo") {
            return "SANTO_DOMINGO";
        }
        if StrContains(appearanceName, "city_center") || StrContains(appearanceName, "downtown") {
            return "CITY_CENTER";
        }
        if StrContains(appearanceName, "badlands") {
            return "BADLANDS";
        }
        
        return "UNKNOWN";
    }

    public static func GenerateDistrictProfile(seed: Int32, district: String, archetype: String) -> ref<KdspDistrictProfileData> {
        let profile: ref<KdspDistrictProfileData> = new KdspDistrictProfileData();

        profile.currentDistrict = district;
        profile.districtName = KdspCrowdDistrictManager.GetDistrictFullName(district);
        profile.districtDescription = KdspCrowdDistrictManager.GetDistrictDescription(district);
        
        // How long they've been in the district
        profile.residencyLength = KdspCrowdDistrictManager.GenerateResidencyLength(seed, district, archetype);
        
        // Standing in district
        profile.localStanding = KdspCrowdDistrictManager.GenerateLocalStanding(seed + 100, district, archetype);
        
        // District-specific connections
        profile.localConnections = KdspCrowdDistrictManager.GenerateLocalConnections(seed + 200, district, archetype);
        
        // District-weighted backstory elements
        profile.districtBackstoryElements = KdspCrowdDistrictManager.GenerateDistrictBackstory(seed + 300, district, archetype);
        
        // Local threats/concerns
        profile.localThreats = KdspCrowdDistrictManager.GetDistrictThreats(district);
        
        // Dominant faction
        profile.dominantFaction = KdspCrowdDistrictManager.GetDominantFaction(district);

        return profile;
    }

    private static func GetDistrictFullName(district: String) -> String {
        if Equals(district, "WATSON") { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T26"); }
        if Equals(district, "WESTBROOK") { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T27"); }
        if Equals(district, "PACIFICA") { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T30"); }
        if Equals(district, "HEYWOOD") { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T29"); }
        if Equals(district, "SANTO_DOMINGO") { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T31"); }
        if Equals(district, "CITY_CENTER") { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T28"); }
        if Equals(district, "BADLANDS") { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T40"); }
        return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T33");
    }

    private static func GetDistrictDescription(district: String) -> String {
        if Equals(district, "WATSON") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S0");
        }
        if Equals(district, "WESTBROOK") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S1");
        }
        if Equals(district, "PACIFICA") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S2");
        }
        if Equals(district, "HEYWOOD") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S3");
        }
        if Equals(district, "SANTO_DOMINGO") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S4");
        }
        if Equals(district, "CITY_CENTER") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S5");
        }
        if Equals(district, "BADLANDS") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S6");
        }
        return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S7");
    }

    private static func GenerateResidencyLength(seed: Int32, district: String, archetype: String) -> String {
        let years = RandRange(seed, 1, 30);

        if Equals(archetype, "NOMAD") {
            return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S8") + IntToString(RandRange(seed, 1, 12)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101");
        }
        if Equals(archetype, "HOMELESS") {
            return IntToString(RandRange(seed, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S9");
        }

        // Pacifica has fewer long-term residents
        if Equals(district, "PACIFICA") && years > 10 {
            years = RandRange(seed, 1, 10);
        }

        if years >= 20 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S10") + IntToString(years) + GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T0"); }
        if years >= 10 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S11") + IntToString(years) + GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T1"); }
        if years >= 5 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S12") + IntToString(years) + GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T1"); }
        if years >= 2 { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S13") + IntToString(years) + GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T1"); }
        return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S14") + IntToString(RandRange(seed, 1, 18)) + GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T2");
    }

    private static func GenerateLocalStanding(seed: Int32, district: String, archetype: String) -> String {
        let standings: array<String>;

        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T3"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S15"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T4"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T5"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T6"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T7"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T8"));
        ArrayPush(standings, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T9"));

        // Weight based on archetype
        if Equals(archetype, "CORPO_MANAGER") {
            if Equals(district, "CITY_CENTER") || Equals(district, "WESTBROOK") {
                return standings[RandRange(seed, 0, 2)]; // Better standing in corpo areas
            }
            return standings[RandRange(seed, 3, 5)]; // Outsider elsewhere
        }
        if Equals(archetype, "GANGER") {
            if RandRange(seed, 1, 100) <= 60 {
                return standings[RandRange(seed, 5, 7)]; // Feared or avoided
            }
        }
        if Equals(archetype, "HOMELESS") {
            return standings[RandRange(seed, 4, 7)];
        }

        return standings[RandRange(seed, 0, ArraySize(standings) - 1)];
    }

    private static func GenerateLocalConnections(seed: Int32, district: String, archetype: String) -> array<String> {
        let connections: array<String>;

        if Equals(district, "WATSON") {
            if RandRange(seed, 1, 100) <= 40 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S16")); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S17")); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S18")); }
            if RandRange(seed + 30, 1, 100) <= 35 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S19")); }
        }
        else if Equals(district, "WESTBROOK") {
            if RandRange(seed, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S20")); }
            if RandRange(seed + 10, 1, 100) <= 20 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S21")); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S22")); }
        }
        else if Equals(district, "PACIFICA") {
            if RandRange(seed, 1, 100) <= 40 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S23")); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S24")); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S25")); }
        }
        else if Equals(district, "HEYWOOD") {
            if RandRange(seed, 1, 100) <= 40 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S26")); }
            if RandRange(seed + 10, 1, 100) <= 35 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S27")); }
            if RandRange(seed + 20, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S28")); }
        }
        else if Equals(district, "SANTO_DOMINGO") {
            if RandRange(seed, 1, 100) <= 45 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S29")); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S30")); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T10")); }
        }
        else if Equals(district, "CITY_CENTER") {
            if RandRange(seed, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S31")); }
            if RandRange(seed + 10, 1, 100) <= 20 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S32")); }
        }
        else if Equals(district, "BADLANDS") {
            if RandRange(seed, 1, 100) <= 50 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S33")); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S34")); }
        }

        if ArraySize(connections) == 0 {
            ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S35"));
        }

        return connections;
    }

    private static func GenerateDistrictBackstory(seed: Int32, district: String, archetype: String) -> array<String> {
        let elements: array<String>;

        if Equals(district, "WATSON") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S36"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S37"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S38"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S39"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S40"));
        }
        else if Equals(district, "WESTBROOK") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S41"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S42"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S43"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S44"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S45"));
        }
        else if Equals(district, "PACIFICA") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S46"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S47"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S48"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S49"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S50"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S51"));
        }
        else if Equals(district, "HEYWOOD") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S52"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S53"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S54"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S55"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T11"));
        }
        else if Equals(district, "SANTO_DOMINGO") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S56"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S57"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S58"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S59"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S60"));
        }
        else if Equals(district, "CITY_CENTER") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S61"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S62"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S63"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S64"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S65"));
        }
        else if Equals(district, "BADLANDS") {
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S66"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S67"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S68"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S69"));
            ArrayPush(elements, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T12"));
        }

        // Select 1-2 relevant elements
        let selected: array<String>;
        if ArraySize(elements) > 0 {
            ArrayPush(selected, elements[RandRange(seed, 0, ArraySize(elements) - 1)]);
            if RandRange(seed + 50, 1, 100) <= 40 && ArraySize(elements) > 1 {
                let second = elements[RandRange(seed + 60, 0, ArraySize(elements) - 1)];
                if !Equals(second, selected[0]) {
                    ArrayPush(selected, second);
                }
            }
        }

        return selected;
    }

    private static func GetDistrictThreats(district: String) -> array<String> {
        let threats: array<String>;

        if Equals(district, "WATSON") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-Shared-C36"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T13"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S70"));
        }
        else if Equals(district, "WESTBROOK") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S71"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T14"));
        }
        else if Equals(district, "PACIFICA") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-Shared-C32"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S72"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T15"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S73"));
        }
        else if Equals(district, "HEYWOOD") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S74"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T16"));
        }
        else if Equals(district, "SANTO_DOMINGO") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-S75"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T17"));
        }
        else if Equals(district, "CITY_CENTER") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-Shared-C34"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T18"));
        }
        else if Equals(district, "BADLANDS") {
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-Shared-C35"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T19"));
            ArrayPush(threats, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T20"));
        }

        return threats;
    }

    private static func GetDominantFaction(district: String) -> String {
        if Equals(district, "WATSON") { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U9"); }
        if Equals(district, "WESTBROOK") { return GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation"); }
        if Equals(district, "PACIFICA") { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U10"); }
        if Equals(district, "HEYWOOD") { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U11"); }
        if Equals(district, "SANTO_DOMINGO") { return GetLocalizedTextByKey(n"Kdsp-Shared-C33"); }
        if Equals(district, "CITY_CENTER") { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U12"); }
        if Equals(district, "BADLANDS") { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U13"); }
        return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-T21");
    }

    // District-based archetype weight modifiers
    public static func GetArchetypeWeightsForDistrict(district: String) -> ref<KdspDistrictArchetypeWeights> {
        let weights: ref<KdspDistrictArchetypeWeights> = new KdspDistrictArchetypeWeights();

        if Equals(district, "CITY_CENTER") {
            weights.corpoManagerWeight = 30;
            weights.corpoDroneWeight = 40;
            weights.yuppieWeight = 20;
            weights.civvieWeight = 8;
            weights.homelessWeight = 1;
            weights.gangerWeight = 1;
        }
        else if Equals(district, "PACIFICA") {
            weights.corpoManagerWeight = 1;
            weights.corpoDroneWeight = 2;
            weights.yuppieWeight = 1;
            weights.civvieWeight = 20;
            weights.homelessWeight = 25;
            weights.gangerWeight = 35;
            weights.lowlifeWeight = 16;
        }
        else if Equals(district, "HEYWOOD") {
            weights.corpoManagerWeight = 5;
            weights.corpoDroneWeight = 10;
            weights.yuppieWeight = 15;
            weights.civvieWeight = 35;
            weights.gangerWeight = 25;
            weights.lowlifeWeight = 10;
        }
        else if Equals(district, "WESTBROOK") {
            weights.corpoManagerWeight = 15;
            weights.corpoDroneWeight = 20;
            weights.yuppieWeight = 25;
            weights.civvieWeight = 25;
            weights.gangerWeight = 10;
            weights.lowlifeWeight = 5;
        }
        else {
            // Default balanced weights
            weights.corpoManagerWeight = 5;
            weights.corpoDroneWeight = 15;
            weights.yuppieWeight = 10;
            weights.civvieWeight = 40;
            weights.homelessWeight = 5;
            weights.gangerWeight = 15;
            weights.lowlifeWeight = 10;
        }

        return weights;
    }
}

public class KdspDistrictProfileData {
    public let currentDistrict: String;
    public let districtName: String;
    public let districtDescription: String;
    public let residencyLength: String;
    public let localStanding: String;
    public let localConnections: array<String>;
    public let districtBackstoryElements: array<String>;
    public let localThreats: array<String>;
    public let dominantFaction: String;
}

public class KdspDistrictArchetypeWeights {
    public let corpoManagerWeight: Int32;
    public let corpoDroneWeight: Int32;
    public let yuppieWeight: Int32;
    public let civvieWeight: Int32;
    public let homelessWeight: Int32;
    public let gangerWeight: Int32;
    public let lowlifeWeight: Int32;
    public let junkieWeight: Int32;
    public let nomadWeight: Int32;
}
