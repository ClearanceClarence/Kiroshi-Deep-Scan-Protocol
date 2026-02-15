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
        ArrayPush(specs, "Fuel Depot Raids");
        ArrayPush(specs, "Trap/IED Placement");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Highway I-9");
        ArrayPush(territories, "Fuel Station Network");
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
            ArrayPush(marks, "Wraith skull brand");
        }
        if RandRange(seed + 730, 1, 100) <= 55 {
            ArrayPush(marks, "Sun-weathered skin");
        }
        if RandRange(seed + 740, 1, 100) <= 40 {
            ArrayPush(marks, "Road rash scarring");
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, "Teeth filed to points");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Born in the wastes. Civilization is a lie the corps tell. Out here, only strength matters.");
        ArrayPush(backstories, "Former nomad who got a taste for blood. Clan kicked out. Wraiths welcomed.");
        ArrayPush(backstories, "Escaped from somewhere bad. Found freedom on the highway. Take what you need, burn the rest.");
        ArrayPush(backstories, "NUSA deserter. Military training serves a better purpose now - raiding convoys.");
        ArrayPush(backstories, "Grew up in the camps. Raiding is life. The soft city folk are just prey.");
        ArrayPush(backstories, "Lost everything to corps. Found purpose in making them bleed, one convoy at a time.");
        ArrayPush(backstories, "Aldecaldos exile. Broke the clan code. Only Raffen Shiv take in the truly damned.");
        ArrayPush(backstories, "Survived a Wraith raid as a kid. Figured the winning side was the right side. Joined the pack.");
        ArrayPush(backstories, "Ran a fuel station in the Badlands. Wraiths taxed it dry. Joined because fighting them was suicide.");
        ArrayPush(backstories, "Prison transport got ambushed by Wraiths. They opened the cage and offered a choice. Easy decision.");
        ArrayPush(backstories, "Mechanic who keeps the war rigs running. They don't raid without working wheels. That makes this role essential.");
        ArrayPush(backstories, "Crossed the border alone on foot. Wraiths found the body count left behind. Impressed enough to recruit.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Convoy interception on I-9. Good haul, no survivors.");
        ArrayPush(activities, "Camp fortification. NCPD getting bold lately.");
        ArrayPush(activities, "Hostage situation. Ransom negotiations ongoing.");
        ArrayPush(activities, "Vehicle raid. Need more wheels for the pack.");
        ArrayPush(activities, "Scouting nomad routes. Fresh targets incoming.");
        ArrayPush(activities, "Fuel depot seizure. Controlling supply means controlling the Badlands.");
        ArrayPush(activities, "Setting spike strips on Highway 9. Corpo transport expected at dawn.");
        ArrayPush(activities, "Stripping a captured Militech AV for parts. Worth a fortune.");
        ArrayPush(activities, "Raiding an abandoned settlement. Supplies and potential recruits.");
        ArrayPush(activities, "War rig maintenance. The fleet needs to be ready for the next big score.");
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
