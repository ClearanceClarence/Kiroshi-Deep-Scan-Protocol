// Wraiths Gang Profile Generator
// Raffen Shiv raiders terrorizing the Badlands highways

public class KdspWraithsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "WRAITHS";
        profile.gangName = GetLocalizedTextByKey(n"Kdsp-GangManager-U1");
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T0");
        
        // Raider hierarchy
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T2"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U3"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T4"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-GangProfileGen-T3"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T5"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T1"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T105"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T9"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T6"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T12"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T268"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T12"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T7"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T5"); }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C51"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T9"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T6"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-U25"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T10"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T11"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T12"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T15"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T24"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T16"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T17"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T18"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S1"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T19"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T34"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T20"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T21"));
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
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T22"));
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T23"));
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-S2"));
        }
        if RandRange(seed + 730, 1, 100) <= 55 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T24"));
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
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T25"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-WraithsProfile-V0"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-WraithsProfile-V1"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T28"); }
        return GetLocalizedTextByKey(n"Kdsp-WraithsProfile-T29");
    }
}
