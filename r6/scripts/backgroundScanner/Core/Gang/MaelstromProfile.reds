// Maelstrom Gang Profile Generator
// Chrome cult obsessed with cybernetic transcendence

public class KdspMaelstromProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "MAELSTROM";
        profile.gangName = "Maelstrom";
        profile.headerLabel = "MAELSTROM COLLECTIVE RECORD";
        
        // Chrome cult ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "heavy");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Chrome Priest"; profile.rankMeaning = "Senior Member"; }
            else if roll <= 70 { profile.rank = "Borg Lieutenant"; profile.rankMeaning = "Squad Leader"; }
            else if roll <= 90 { profile.rank = "Iron Father"; profile.rankMeaning = "Veteran"; }
            else { profile.rank = "Tech Shaman"; profile.rankMeaning = "Ripperdoc"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { profile.rank = "Chrome Initiate"; profile.rankMeaning = "New Member"; }
            else if roll <= 80 { profile.rank = "Iron Brother"; profile.rankMeaning = "Full Member"; }
            else { profile.rank = "Circuit Runner"; profile.rankMeaning = "Tech Specialist"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Cyberware Installation");
        ArrayPush(specs, "Heavy Weapons");
        ArrayPush(specs, "Organ Acquisition");
        ArrayPush(specs, "Chrome Maintenance");
        ArrayPush(specs, "Kidnapping Ops");
        ArrayPush(specs, "Territory Defense");
        ArrayPush(specs, "Scrap Salvage");
        ArrayPush(specs, "Arms Dealing");
        ArrayPush(specs, "Intimidation");
        ArrayPush(specs, "Borg Conversion");
        ArrayPush(specs, "ICE Cracking");
        ArrayPush(specs, "Flathead Deployment");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S2"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-S17"));
        ArrayPush(territories, "Northside Industrial");
        ArrayPush(territories, "Totentanz");
        ArrayPush(territories, "Watson Docks");
        ArrayPush(territories, "Underground Labs");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 10);
        profile.bodyCount = KdspMaelstromProfile.GetBodyCount(seed + 400, profile.rank) + RandRange(seed + 410, 5, 20);
        profile.arrestCount = RandRange(seed + 500, 0, 3);
        
        // Chrome percentage - unique to Maelstrom
        profile.chromePercentage = RandRange(seed + 550, 40, 95);
        
        // Loyalty
        profile.loyaltyRating = KdspMaelstromProfile.GetLoyalty(seed + 600);
        
        // Marks - Maelstrom prefer chrome to ink
        let marks: array<String>;
        ArrayPush(marks, IntToString(profile.chromePercentage) + GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S3"));
        if RandRange(seed + 700, 1, 100) <= 70 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S4"));
        }
        if RandRange(seed + 710, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S5"));
        }
        if RandRange(seed + 720, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S6"));
        }
        if RandRange(seed + 730, 1, 100) <= 45 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S7"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S8"));
        }
        if RandRange(seed + 750, 1, 100) <= 25 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S9"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S18"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S19"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S20"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S21"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S30"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S31"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Tech Shaman") || Equals(rank, "Iron Father") { return RandRange(seed, 15, 40); }
        if Equals(rank, "Borg Lieutenant") || Equals(rank, "Chrome Priest") { return RandRange(seed, 10, 30); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "FLESH-BOUND"; }
        if roll <= 30 { return "CONVERTING"; }
        if roll <= 60 { return "CHROME-BLESSED"; }
        if roll <= 85 { return "TRANSCENDING"; }
        return "FULLY INTEGRATED";
    }
}
