// Aldecaldos Gang Profile Generator
// Nomad clan focused on family, freedom, and the open road

public class KdspAldecaldosProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "ALDECALDOS";
        profile.gangName = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-U0");
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T0");
        
        // Clan/family structure
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T2"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T4"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T5"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T6"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T7"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T8"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 30 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T9"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T10"); }
            else if roll <= 60 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T11"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
            else if roll <= 80 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T13"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T14"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T15"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T16"); }
        }
        
        // Specializations - working roles, not criminal
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T17"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T18"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T19"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T20"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T21"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T22"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T23"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T24"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T25"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T26"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T27"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T28"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T29"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T30"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S1"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T31"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T32"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T33"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T34"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 30);
        profile.bodyCount = RandRange(seed + 400, 0, 20); // Aldecaldos defend, don't hunt
        profile.arrestCount = RandRange(seed + 500, 0, 3);
        
        // Clan-specific
        profile.convoyRuns = RandRange(seed + 350, 20, 500);
        
        // Loyalty
        profile.loyaltyRating = KdspAldecaldosProfile.GetLoyalty(seed + 600);
        
        // Style
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 70 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S2"));
        }
        if RandRange(seed + 710, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T35"));
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S3"));
        }
        if RandRange(seed + 730, 1, 100) <= 55 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S4"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S5"));
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S6"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S7"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S8"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S9"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S18"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S19"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S20"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S21"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S28"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-V0"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-V1"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-V2"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T39"); }
        return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T40");
    }
}
