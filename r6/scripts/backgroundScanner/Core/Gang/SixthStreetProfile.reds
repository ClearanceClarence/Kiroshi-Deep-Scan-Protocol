// 6th Street Gang Profile Generator
// Military veterans turned community defenders

public class KdspSixthStreetProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "6TH_STREET";
        profile.gangName = GetLocalizedTextByKey(n"Kdsp-Shared-C33");
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T0");
        
        // Military-style ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "veteran");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C57"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T1"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-Shared-C9"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-Shared-C12"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U2"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T2"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-U0"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T3"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T22"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T9"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T23"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T4"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U4"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T5"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T6"); }
        }
        
        // Specializations - military focus
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T7"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T16"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C52"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T10"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-U1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T38"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T35"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T14"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T15"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T16"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S0"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-S18"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T17"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S1"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 25);
        profile.bodyCount = KdspSixthStreetProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 4);
        
        // Military service - unique to 6th Street
        let services: array<String>;
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S2"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S3"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S4"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S5"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S6"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S7"));
        profile.priorService = services[RandRange(seed + 350, 0, ArraySize(services) - 1)];
        
        // Loyalty
        profile.loyaltyRating = KdspSixthStreetProfile.GetLoyalty(seed + 600);
        
        // Tattoos - American/military imagery
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 90 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S10"));
        }
        if RandRange(seed + 710, 1, 100) <= 70 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S11"));
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S8"));
        }
        if RandRange(seed + 730, 1, 100) <= 30 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S9"));
        }
        if RandRange(seed + 740, 1, 100) <= 45 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S10"));
        }
        if RandRange(seed + 750, 1, 100) <= 35 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S11"));
        }
        if RandRange(seed + 760, 1, 100) <= 25 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S12"));
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S18"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S19"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S20"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S21"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S22"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S23"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S24"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S30"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S31"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S32"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S33"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S34"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-U0")) || Equals(rank, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U2")) { return RandRange(seed, 15, 50); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C57")) || Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C9")) { return RandRange(seed, 8, 30); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-V0"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-V1"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-V2"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-MoxesProfile-V1"); }
        return GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T21");
    }
}
