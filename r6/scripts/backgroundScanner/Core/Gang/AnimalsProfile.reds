// Animals Gang Profile Generator
// Strength-obsessed pack with underground fighting culture

public class KdspAnimalsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "ANIMALS";
        profile.gangName = "Animals";
        profile.headerLabel = "ANIMALS PACK RECORD";
        
        // Pack hierarchy
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "heavy");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Alpha"; profile.rankMeaning = "Pack Leader"; }
            else if roll <= 70 { profile.rank = "Pack Enforcer"; profile.rankMeaning = "Lieutenant"; }
            else if roll <= 90 { profile.rank = "Beast"; profile.rankMeaning = "Heavy"; }
            else { profile.rank = "Apex"; profile.rankMeaning = "Champion"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Pup"; profile.rankMeaning = "New Member"; }
            else if roll <= 70 { profile.rank = "Pack Brother"; profile.rankMeaning = "Full Member"; }
            else if roll <= 90 { profile.rank = "Hunter"; profile.rankMeaning = "Active Fighter"; }
            else { profile.rank = "Juicer"; profile.rankMeaning = "Chem Specialist"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Close Combat");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S0"));
        ArrayPush(specs, "Underground Fighting");
        ArrayPush(specs, "Security Detail");
        ArrayPush(specs, "Intimidation Ops");
        ArrayPush(specs, "Steroid Distribution");
        ArrayPush(specs, "Training/Sparring");
        ArrayPush(specs, "Debt Collection");
        ArrayPush(specs, "Club Bouncer");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S1"));
        ArrayPush(specs, "Juice Brewing");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S2"));
        ArrayPush(specs, "Body Disposal");
        ArrayPush(specs, "Convoy Escort");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S3"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S4"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S5"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S6"));
        ArrayPush(territories, "Underground Pits");
        ArrayPush(territories, "Coastview Corners");
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
            ArrayPush(marks, "Steroid scarring");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, "Fighting scars");
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S8"));
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S9"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, "Cauliflower ears");
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
        if Equals(rank, "Pack Enforcer") || Equals(rank, "Beast") { return RandRange(seed, 10, 35); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "OMEGA"; }
        if roll <= 30 { return "PACK MEMBER"; }
        if roll <= 60 { return "TRUSTED"; }
        if roll <= 85 { return "INNER CIRCLE"; }
        return "BLOOD PACK";
    }
}
