// Wraiths Gang Profile Generator
// Raffen Shiv raiders terrorizing the Badlands highways

public class KdspWraithsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "WRAITHS";
        profile.gangName = "Wraiths";
        profile.headerLabel = "WRAITHS RAFFEN SHIV FILE";
        
        // Raider hierarchy
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "War Chief"; profile.rankMeaning = "Leader"; }
            else if roll <= 70 { profile.rank = "Road Captain"; profile.rankMeaning = "Lieutenant"; }
            else if roll <= 90 { profile.rank = "Raider Lord"; profile.rankMeaning = "Senior"; }
            else { profile.rank = "Blood Speaker"; profile.rankMeaning = "Advisor"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Prospect"; profile.rankMeaning = "New Blood"; }
            else if roll <= 70 { profile.rank = "Raider"; profile.rankMeaning = "Full Member"; }
            else if roll <= 90 { profile.rank = "Outrider"; profile.rankMeaning = "Scout"; }
            else { profile.rank = "Wrecker"; profile.rankMeaning = "Specialist"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Highway Robbery");
        ArrayPush(specs, "Vehicle Combat");
        ArrayPush(specs, "Convoy Raiding");
        ArrayPush(specs, "Kidnapping");
        ArrayPush(specs, "Smuggling");
        ArrayPush(specs, "Chop Shop");
        ArrayPush(specs, "Camp Defense");
        ArrayPush(specs, "Torture/Interrogation");
        ArrayPush(specs, "Scout/Recon");
        ArrayPush(specs, "Slaving Operations");
        ArrayPush(specs, "Ambush Coordination");
        ArrayPush(specs, "Vehicle Modification");
        ArrayPush(specs, "Wasteland Navigation");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S0"));
        ArrayPush(specs, "Trap/IED Placement");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Highway I-9");
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S1"));
        ArrayPush(territories, "Badlands East");
        ArrayPush(territories, "Border Crossings");
        ArrayPush(territories, "Abandoned Towns");
        ArrayPush(territories, "Raider Camps");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 15);
        profile.bodyCount = RandRange(seed + 400, 5, 80);
        profile.arrestCount = RandRange(seed + 500, 0, 2); // Hard to arrest in Badlands
        
        // Raids - unique to Wraiths
        profile.successfulRaids = RandRange(seed + 350, 10, 200);
        
        // Loyalty
        profile.loyaltyRating = KdspWraithsProfile.GetLoyalty(seed + 600);
        
        // Marks
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 80 {
            ArrayPush(marks, "Ritual scarification");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, "Trophy trophies");
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S2"));
        }
        if RandRange(seed + 730, 1, 100) <= 55 {
            ArrayPush(marks, "Sun-weathered skin");
        }
        if RandRange(seed + 740, 1, 100) <= 40 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S3"));
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S4"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S5"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S6"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S7"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S8"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S9"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S16"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S17"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S18"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S19"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S20"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S21"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S26"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "FRESH MEAT"; }
        if roll <= 30 { return "RAIDER"; }
        if roll <= 60 { return "BLOODED"; }
        if roll <= 85 { return "WAR-PROVEN"; }
        return "DEATH RIDER";
    }
}
