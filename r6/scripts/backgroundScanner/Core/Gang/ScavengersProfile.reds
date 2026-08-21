// Scavengers Gang Profile Generator
// Organ harvesters and chrome thieves operating in cells

public class KdspScavengersProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "SCAVENGERS";
        profile.gangName = GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-Affiliation");
        profile.headerLabel = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T0");
        
        // Cell structure
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T1"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T2"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T3"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T4"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T193"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-GangProfileGen-T3"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T5"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T6"); }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T7"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T8"); }
            else if roll <= 70 { profile.rank = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T9"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T10"); }
            else if roll <= 90 { profile.rank = GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T106"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T11"); }
            else { profile.rank = GetLocalizedTextByKey(n"Kdsp-GangManager-T34"); profile.rankMeaning = GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T12"); }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C46"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S0"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T18"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T15"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T16"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T17"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T18"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T19"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T20"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T21"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T22"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory - Scavs operate everywhere
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T23"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S2"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-T42"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T24"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T25"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T26"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats - Scavs are prolific
        profile.yearsActive = RandRange(seed + 300, 1, 8);
        profile.bodyCount = RandRange(seed + 400, 10, 100); // Scavs kill a lot
        profile.arrestCount = RandRange(seed + 500, 0, 3);
        
        // Harvests - unique to Scavs
        profile.organsHarvested = RandRange(seed + 350, 20, 500);
        
        // Loyalty - Scavs are mercenary
        profile.loyaltyRating = KdspScavengersProfile.GetLoyalty(seed + 600);
        
        // Marks
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T27"));
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T28"));
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S3"));
        }
        if RandRange(seed + 730, 1, 100) <= 45 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S4"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S5"));
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S6"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S7"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S8"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S9"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S10"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S18"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S19"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S20"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S21"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S28"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 20 { return GetLocalizedTextByKey(n"Kdsp-ScavengersProf-V0"); }
        if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-ScavengersProf-V1"); }
        if roll <= 80 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-V2"); }
        return GetLocalizedTextByKey(n"Kdsp-ScavengersProf-V2");
    }
}
