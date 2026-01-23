// District-Aware Generation System
public class CrowdDistrictManager {

    public static func GetCurrentDistrict(position: Vector4) -> String {
        // This would ideally use game's district detection
        // For now, we'll use a simplified approach based on coordinates
        // In practice, you'd hook into the game's district system
        
        // Placeholder - returns random district weighted by common areas
        return "WATSON";
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

    public static func GenerateDistrictProfile(seed: Int32, district: String, archetype: String) -> ref<DistrictProfileData> {
        let profile: ref<DistrictProfileData> = new DistrictProfileData();

        profile.currentDistrict = district;
        profile.districtName = CrowdDistrictManager.GetDistrictFullName(district);
        profile.districtDescription = CrowdDistrictManager.GetDistrictDescription(district);
        
        // How long they've been in the district
        profile.residencyLength = CrowdDistrictManager.GenerateResidencyLength(seed, district, archetype);
        
        // Standing in district
        profile.localStanding = CrowdDistrictManager.GenerateLocalStanding(seed + 100, district, archetype);
        
        // District-specific connections
        profile.localConnections = CrowdDistrictManager.GenerateLocalConnections(seed + 200, district, archetype);
        
        // District-weighted backstory elements
        profile.districtBackstoryElements = CrowdDistrictManager.GenerateDistrictBackstory(seed + 300, district, archetype);
        
        // Local threats/concerns
        profile.localThreats = CrowdDistrictManager.GetDistrictThreats(district);
        
        // Dominant faction
        profile.dominantFaction = CrowdDistrictManager.GetDominantFaction(district);

        return profile;
    }

    private static func GetDistrictFullName(district: String) -> String {
        if Equals(district, "WATSON") { return "Watson"; }
        if Equals(district, "WESTBROOK") { return "Westbrook"; }
        if Equals(district, "PACIFICA") { return "Pacifica"; }
        if Equals(district, "HEYWOOD") { return "Heywood"; }
        if Equals(district, "SANTO_DOMINGO") { return "Santo Domingo"; }
        if Equals(district, "CITY_CENTER") { return "City Center"; }
        if Equals(district, "BADLANDS") { return "Badlands"; }
        return "Night City";
    }

    private static func GetDistrictDescription(district: String) -> String {
        if Equals(district, "WATSON") {
            return "Former corporate zone, now a melting pot of immigrants and struggling businesses. Home to Kabuki, Little China, and Northside Industrial.";
        }
        if Equals(district, "WESTBROOK") {
            return "Upscale district featuring Japantown's neon-lit streets, the luxurious North Oak, and Charter Hill's corporate elite.";
        }
        if Equals(district, "PACIFICA") {
            return "Abandoned by corporations after the Unification War. Now a lawless zone controlled by Voodoo Boys and Animals.";
        }
        if Equals(district, "HEYWOOD") {
            return "The largest district, ranging from Valentino-controlled Vista del Rey to the affluent Glen. Strong Latino cultural presence.";
        }
        if Equals(district, "SANTO_DOMINGO") {
            return "Industrial heartland of Night City. Working-class neighborhoods surrounded by factories and power plants.";
        }
        if Equals(district, "CITY_CENTER") {
            return "Corporate downtown. Gleaming towers house megacorp headquarters. Heavy security presence.";
        }
        if Equals(district, "BADLANDS") {
            return "Desert wasteland outside city limits. Nomad territory dotted with abandoned towns and corporate facilities.";
        }
        return "Night City metropolitan area.";
    }

    private static func GenerateResidencyLength(seed: Int32, district: String, archetype: String) -> String {
        let years = RandRange(seed, 1, 30);

        if Equals(archetype, "NOMAD") {
            return "Transient - " + IntToString(RandRange(seed, 1, 12)) + " months";
        }
        if Equals(archetype, "HOMELESS") {
            return IntToString(RandRange(seed, 1, 5)) + " years (various locations)";
        }

        // Pacifica has fewer long-term residents
        if Equals(district, "PACIFICA") && years > 10 {
            years = RandRange(seed, 1, 10);
        }

        if years >= 20 { return "Lifelong resident (" + IntToString(years) + "+ years)"; }
        if years >= 10 { return "Long-term resident (" + IntToString(years) + " years)"; }
        if years >= 5 { return "Established resident (" + IntToString(years) + " years)"; }
        if years >= 2 { return "Recent arrival (" + IntToString(years) + " years)"; }
        return "New to area (" + IntToString(RandRange(seed, 1, 18)) + " months)";
    }

    private static func GenerateLocalStanding(seed: Int32, district: String, archetype: String) -> String {
        let standings: array<String>;

        ArrayPush(standings, "Well-respected local");
        ArrayPush(standings, "Known in community");
        ArrayPush(standings, "Average standing");
        ArrayPush(standings, "Newcomer");
        ArrayPush(standings, "Outsider");
        ArrayPush(standings, "Troublemaker");
        ArrayPush(standings, "Feared");
        ArrayPush(standings, "Avoided");

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
            if RandRange(seed, 1, 100) <= 40 { ArrayPush(connections, "Knows local fixers in Kabuki"); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, "Regular at Tom's Diner"); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, "Connection to Mox through Lizzie's"); }
            if RandRange(seed + 30, 1, 100) <= 35 { ArrayPush(connections, "Knows someone at Misty's Esoterica"); }
        }
        else if Equals(district, "WESTBROOK") {
            if RandRange(seed, 1, 100) <= 30 { ArrayPush(connections, "Frequents Japantown clubs"); }
            if RandRange(seed + 10, 1, 100) <= 20 { ArrayPush(connections, "Connection to Clouds"); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, "Knows Tyger Claw members"); }
        }
        else if Equals(district, "PACIFICA") {
            if RandRange(seed, 1, 100) <= 40 { ArrayPush(connections, "Survival network with other residents"); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, "Knows Voodoo Boys contacts"); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, "Connection to Haitian community"); }
        }
        else if Equals(district, "HEYWOOD") {
            if RandRange(seed, 1, 100) <= 40 { ArrayPush(connections, "Family ties in the neighborhood"); }
            if RandRange(seed + 10, 1, 100) <= 35 { ArrayPush(connections, "Regular at El Coyote Cojo"); }
            if RandRange(seed + 20, 1, 100) <= 30 { ArrayPush(connections, "Knows Valentino members"); }
        }
        else if Equals(district, "SANTO_DOMINGO") {
            if RandRange(seed, 1, 100) <= 45 { ArrayPush(connections, "Factory worker connections"); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, "Knows 6th Street members"); }
            if RandRange(seed + 20, 1, 100) <= 25 { ArrayPush(connections, "Union contacts"); }
        }
        else if Equals(district, "CITY_CENTER") {
            if RandRange(seed, 1, 100) <= 30 { ArrayPush(connections, "Corporate networking contacts"); }
            if RandRange(seed + 10, 1, 100) <= 20 { ArrayPush(connections, "Security personnel connections"); }
        }
        else if Equals(district, "BADLANDS") {
            if RandRange(seed, 1, 100) <= 50 { ArrayPush(connections, "Nomad clan contacts"); }
            if RandRange(seed + 10, 1, 100) <= 30 { ArrayPush(connections, "Knows smuggling routes"); }
        }

        if ArraySize(connections) == 0 {
            ArrayPush(connections, "Limited local connections");
        }

        return connections;
    }

    private static func GenerateDistrictBackstory(seed: Int32, district: String, archetype: String) -> array<String> {
        let elements: array<String>;

        if Equals(district, "WATSON") {
            ArrayPush(elements, "Arrived during the post-Arasaka exodus");
            ArrayPush(elements, "Remembers when Watson was corporate territory");
            ArrayPush(elements, "Survived multiple gang turf changes");
            ArrayPush(elements, "Immigrant background, came through Watson docks");
            ArrayPush(elements, "Lost family in the Arasaka bombing aftermath");
        }
        else if Equals(district, "WESTBROOK") {
            ArrayPush(elements, "Connected to Japantown's entertainment industry");
            ArrayPush(elements, "Witnessed Tyger Claw expansion firsthand");
            ArrayPush(elements, "Has history with the braindance underground");
            ArrayPush(elements, "Former service worker in North Oak estates");
            ArrayPush(elements, "Involved in Japantown's grey economy");
        }
        else if Equals(district, "PACIFICA") {
            ArrayPush(elements, "Haitian diaspora background");
            ArrayPush(elements, "Survived corporate abandonment of the district");
            ArrayPush(elements, "Witnessed the failed resort project collapse");
            ArrayPush(elements, "Has adapted to lawless existence");
            ArrayPush(elements, "Remembers when Pacifica had hope");
            ArrayPush(elements, "Distrustful of outsiders");
        }
        else if Equals(district, "HEYWOOD") {
            ArrayPush(elements, "Multi-generational Heywood family");
            ArrayPush(elements, "Strong Catholic/Santa Muerte faith");
            ArrayPush(elements, "Witnessed Valentino rise to power");
            ArrayPush(elements, "Lost someone to gang violence");
            ArrayPush(elements, "Community-oriented upbringing");
        }
        else if Equals(district, "SANTO_DOMINGO") {
            ArrayPush(elements, "Factory worker family background");
            ArrayPush(elements, "Suffered from industrial accidents/pollution");
            ArrayPush(elements, "Participated in labor disputes");
            ArrayPush(elements, "Former Militech or Petrochem employee");
            ArrayPush(elements, "Witnessed 6th Street's community takeover");
        }
        else if Equals(district, "CITY_CENTER") {
            ArrayPush(elements, "Corporate family background");
            ArrayPush(elements, "Sanitized personal history");
            ArrayPush(elements, "Lives in corporate bubble");
            ArrayPush(elements, "Rarely ventures to other districts");
            ArrayPush(elements, "Security clearance holder");
        }
        else if Equals(district, "BADLANDS") {
            ArrayPush(elements, "Nomad clan heritage");
            ArrayPush(elements, "Survived Nomad wars");
            ArrayPush(elements, "Witnessed Biotechnica experiments");
            ArrayPush(elements, "Escaped Night City for the desert");
            ArrayPush(elements, "Smuggler background");
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
            ArrayPush(threats, "Maelstrom activity");
            ArrayPush(threats, "Scavenger presence");
            ArrayPush(threats, "Tyger Claws expansion");
        }
        else if Equals(district, "WESTBROOK") {
            ArrayPush(threats, "Tyger Claws dominance");
            ArrayPush(threats, "Organized crime");
        }
        else if Equals(district, "PACIFICA") {
            ArrayPush(threats, "Complete lawlessness");
            ArrayPush(threats, "Voodoo Boys territorial control");
            ArrayPush(threats, "Animals aggression");
            ArrayPush(threats, "No emergency services");
        }
        else if Equals(district, "HEYWOOD") {
            ArrayPush(threats, "Valentinos territory disputes");
            ArrayPush(threats, "Gang violence");
        }
        else if Equals(district, "SANTO_DOMINGO") {
            ArrayPush(threats, "6th Street vigilantism");
            ArrayPush(threats, "Industrial hazards");
        }
        else if Equals(district, "CITY_CENTER") {
            ArrayPush(threats, "Corporate surveillance");
            ArrayPush(threats, "Heavy security");
        }
        else if Equals(district, "BADLANDS") {
            ArrayPush(threats, "Wraith attacks");
            ArrayPush(threats, "Raffen Shiv");
            ArrayPush(threats, "Environmental hazards");
        }

        return threats;
    }

    private static func GetDominantFaction(district: String) -> String {
        if Equals(district, "WATSON") { return "Contested (Maelstrom/Tyger Claws/Moxes)"; }
        if Equals(district, "WESTBROOK") { return "Tyger Claws"; }
        if Equals(district, "PACIFICA") { return "Voodoo Boys / Animals"; }
        if Equals(district, "HEYWOOD") { return "Valentinos"; }
        if Equals(district, "SANTO_DOMINGO") { return "6th Street"; }
        if Equals(district, "CITY_CENTER") { return "Corporate Security"; }
        if Equals(district, "BADLANDS") { return "Nomad Clans / Wraiths"; }
        return "Contested";
    }

    // District-based archetype weight modifiers
    public static func GetArchetypeWeightsForDistrict(district: String) -> ref<DistrictArchetypeWeights> {
        let weights: ref<DistrictArchetypeWeights> = new DistrictArchetypeWeights();

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

public class DistrictProfileData {
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

public class DistrictArchetypeWeights {
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
