// Animals Gang Profile Generator
// Strength-obsessed pack with underground fighting culture

public class KdspAnimalsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "ANIMALS";
        profile.gangName = "Animals";
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T0");
        
        // Pack hierarchy
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "heavy");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Alpha"; profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T1"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C38"); profile.rankMeaning = "Lieutenant"; }
            else if roll <= 90 { profile.rank = "Beast"; profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T2"); }
            else { profile.rank = "Apex"; profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T3"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T4"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T5"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T6"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T7"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T8"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T9"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T10"); }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C37"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T43"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T15"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T16"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T17"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S2"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T18"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T19"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S3"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S4"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S5"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S6"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T20"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T21"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 12);
        profile.bodyCount = KdspAnimalsProfile.GetBodyCount(seed + 400, profile.rank) + RandRange(seed + 410, 0, 15);
        profile.arrestCount = RandRange(seed + 500, 0, 6);
        
        // Fight record - unique to Animals
        profile.fightWins = RandRange(seed + 350, 5, 100);
        profile.fightLosses = RandRange(seed + 360, 0, 20);
        
        // Loyalty
        profile.loyaltyRating = KdspAnimalsProfile.GetLoyalty(seed + 600);
        
        // Physical markers
        let marks: array<String>;
        ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S7"));
        if RandRange(seed + 700, 1, 100) <= 80 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T22"));
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T23"));
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S8"));
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S9"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T24"));
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S10"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S18"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S19"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S20"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S21"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S22"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S30"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S31"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S32"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Alpha") || Equals(rank, "Apex") { return RandRange(seed, 20, 60); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C38")) || Equals(rank, "Beast") { return RandRange(seed, 10, 35); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T25"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T26"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T49"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T27"); }
        return GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T28");
    }
}
