// Maelstrom Gang Profile Generator
// Chrome cult obsessed with cybernetic transcendence

public class KdspMaelstromProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "MAELSTROM";
        profile.gangName = "Maelstrom";
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T0");
        
        // Chrome cult ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "heavy");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C53"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T1"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C56"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-Shared-C12"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C55"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-GangProfileGen-T2"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C54"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T2"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { profile.rank = GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T5"); }
            else if roll <= 80 { profile.rank = GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T4"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T5"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T24"); }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C42"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T27"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T6"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T7"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T10"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C52"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-S2"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-S17"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T14"));
        ArrayPush(territories, "Totentanz");
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T15"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T16"));
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
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C54")) || Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C55")) { return RandRange(seed, 15, 40); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C56")) || Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C53")) { return RandRange(seed, 10, 30); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T17"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T18"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T19"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T20"); }
        return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T21");
    }
}
