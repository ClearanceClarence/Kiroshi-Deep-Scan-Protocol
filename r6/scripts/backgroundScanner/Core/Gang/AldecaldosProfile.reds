// Aldecaldos Gang Profile Generator
// Nomad clan focused on family, freedom, and the open road

public class KdspAldecaldosProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "ALDECALDOS";
        profile.gangName = "Aldecaldos";
        profile.headerLabel = "ALDECALDOS CLAN RECORD";
        
        // Clan/family structure
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Elder"; profile.rankMeaning = "Council Member"; }
            else if roll <= 70 { profile.rank = "Road Boss"; profile.rankMeaning = "Convoy Leader"; }
            else if roll <= 90 { profile.rank = "Camp Chief"; profile.rankMeaning = "Site Leader"; }
            else { profile.rank = "Clan Voice"; profile.rankMeaning = "Spokesperson"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 30 { profile.rank = "New Blood"; profile.rankMeaning = "Recent Join"; }
            else if roll <= 60 { profile.rank = "Familia"; profile.rankMeaning = "Full Member"; }
            else if roll <= 80 { profile.rank = "Born Aldecaldo"; profile.rankMeaning = "Birthright"; }
            else { profile.rank = "Trusted"; profile.rankMeaning = "Proven"; }
        }
        
        // Specializations - working roles, not criminal
        let specs: array<String>;
        ArrayPush(specs, "Mechanic");
        ArrayPush(specs, "Driver/Pilot");
        ArrayPush(specs, "Scout/Pathfinder");
        ArrayPush(specs, "Camp Security");
        ArrayPush(specs, "Trade Negotiator");
        ArrayPush(specs, "Smuggling Runs");
        ArrayPush(specs, "Medical Support");
        ArrayPush(specs, "Tech Specialist");
        ArrayPush(specs, "Convoy Defense");
        ArrayPush(specs, "Supply Management");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S0"));
        ArrayPush(specs, "Animal Husbandry");
        ArrayPush(specs, "Water Purification");
        ArrayPush(specs, "Communications/Radio");
        ArrayPush(specs, "Youth Training");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-S1"));
        ArrayPush(territories, "Trade Routes");
        ArrayPush(territories, "Solar Farm");
        ArrayPush(territories, "Badlands Highways");
        ArrayPush(territories, "Border Crossings");
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
            ArrayPush(marks, "Road-worn appearance");
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
        if roll <= 10 { return "NEWCOMER"; }
        if roll <= 30 { return "ACCEPTED"; }
        if roll <= 60 { return "FAMILIA"; }
        if roll <= 85 { return "TRUSTED KIN"; }
        return "BLOOD OF ALDECALDO";
    }
}
