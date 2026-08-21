// Tyger Claws Gang Profile Generator
// Yakuza-style organization with Arasaka ties

public class KdspTygerClawsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "TYGER_CLAWS";
        profile.gangName = GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation");
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T0");
        
        // Yakuza-style ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U0"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U3"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T1"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U2"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T2"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T3"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T4"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T5"); }
            else if roll <= 80 { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T6"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-CriminalRecord-U1"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T1"); }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T2"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T7"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T7"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T10"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T4"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T3"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T15"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T16"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T17"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T18"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T19"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T20"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-T40"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T21"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 15);
        profile.bodyCount = KdspTygerClawsProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 5);
        
        // Loyalty
        profile.loyaltyRating = KdspTygerClawsProfile.GetLoyalty(seed + 600);
        
        // Tattoos - Tyger Claws have luminous tattoos
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 85 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S1"));
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S2"));
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S3"));
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S4"));
        }
        if RandRange(seed + 740, 1, 100) <= 30 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S5"));
        }
        if RandRange(seed + 750, 1, 100) <= 35 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S6"));
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S7"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S8"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S9"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S18"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S19"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S20"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S21"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-S28"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        // Status
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U3")) || Equals(rank, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U2")) { return RandRange(seed, 15, 50); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U0")) { return RandRange(seed, 10, 35); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-U1")) { return RandRange(seed, 5, 20); }
        return RandRange(seed, 0, 12);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-V0"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-V1"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-V2"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-GangManager-T38"); }
        return GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T25");
    }
}
