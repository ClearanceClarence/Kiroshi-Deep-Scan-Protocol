// Valentinos Gang Profile Generator
// Family-oriented Heywood gang with Santa Muerte devotion

public class KdspValentinosProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "VALENTINOS";
        profile.gangName = "Valentinos";
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T0");
        
        // Family-style ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Capitan"; profile.rankMeaning = "Captain"; }
            else if roll <= 70 { profile.rank = "Teniente"; profile.rankMeaning = "Lieutenant"; }
            else if roll <= 90 { profile.rank = "Veterano"; profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-GangProfileGen-T2"); }
            else { profile.rank = "Consejero"; profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T1"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T2"); profile.rankMeaning = "Soldier"; }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T54"); profile.rankMeaning = "Brother"; }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T105"); }
            else { profile.rank = "Sicario"; profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T4"); }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T3"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T5"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T6"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T7"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T15"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T10"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T2"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S1"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T13"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T14"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-S15"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T15"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T16"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 20);
        profile.bodyCount = KdspValentinosProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 8);
        
        // Loyalty
        profile.loyaltyRating = KdspValentinosProfile.GetLoyalty(seed + 600);
        
        // Tattoos - Valentinos have religious imagery
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 90 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S8"));
        }
        if RandRange(seed + 710, 1, 100) <= 70 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S9"));
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S2"));
        }
        if RandRange(seed + 730, 1, 100) <= 40 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T17"));
        }
        if RandRange(seed + 740, 1, 100) <= 55 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S3"));
        }
        if RandRange(seed + 750, 1, 100) <= 35 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S4"));
        }
        if RandRange(seed + 760, 1, 100) <= 30 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S5"));
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S6"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S7"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S8"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S9"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S17"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S18"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S19"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S20"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S21"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-S27"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Consejero") || Equals(rank, "Capitan") { return RandRange(seed, 15, 45); }
        if Equals(rank, "Teniente") || Equals(rank, "Veterano") { return RandRange(seed, 8, 25); }
        if Equals(rank, "Sicario") { return RandRange(seed, 10, 40); }
        return RandRange(seed, 0, 12);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T18"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T37"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T38"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T19"); }
        return GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T20");
    }
}
