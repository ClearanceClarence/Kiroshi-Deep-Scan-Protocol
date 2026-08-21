// Moxes Gang Profile Generator
// Protective collective defending sex workers and marginalized people

public class KdspMoxesProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "MOXES";
        profile.gangName = GetLocalizedTextByKey(n"Kdsp-Shared-C40");
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T0");
        
        // Collective structure - less hierarchical
        let roll = RandRange(seed, 1, 100);
        if roll <= 30 { profile.rank = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U0"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
        else if roll <= 50 { profile.rank = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
        else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T2"); }
        else if roll <= 85 { profile.rank = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T8"); }
        else if roll <= 95 { profile.rank = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-GangProfileGen-T2"); }
        else { profile.rank = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T4"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T5"); }
        profile.rankMeaning = "";
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T6"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T7"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T20"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T10"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T23"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T15"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T16"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-Shared-C45"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S2"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S3"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T17"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 10);
        profile.bodyCount = RandRange(seed + 400, 0, 15); // Moxes defend, don't hunt
        profile.arrestCount = RandRange(seed + 500, 0, 4);
        
        // People protected - unique to Moxes
        profile.peopleProtected = RandRange(seed + 350, 5, 100);
        
        // Loyalty
        profile.loyaltyRating = KdspMoxesProfile.GetLoyalty(seed + 600);
        
        // Style
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 80 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S4"));
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S5"));
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S6"));
        }
        if RandRange(seed + 730, 1, 100) <= 45 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S7"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T18"));
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S8"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S9"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S18"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S19"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S20"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S21"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-S30"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-MoxesProfile-V0"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-V2"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-MoxesProfile-V1"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-V4"); }
        return GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T21");
    }
}
