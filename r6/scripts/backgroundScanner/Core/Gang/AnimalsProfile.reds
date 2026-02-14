// Animals Gang Profile Generator
// Strength-obsessed pack with underground fighting culture

public class AnimalsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
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
        ArrayPush(specs, "Muscle for Hire");
        ArrayPush(specs, "Underground Fighting");
        ArrayPush(specs, "Security Detail");
        ArrayPush(specs, "Intimidation Ops");
        ArrayPush(specs, "Steroid Distribution");
        ArrayPush(specs, "Training/Sparring");
        ArrayPush(specs, "Debt Collection");
        ArrayPush(specs, "Club Bouncer");
        ArrayPush(specs, "Fight Pit Champion");
        ArrayPush(specs, "Juice Brewing");
        ArrayPush(specs, "Cage Match Promoter");
        ArrayPush(specs, "Body Disposal");
        ArrayPush(specs, "Convoy Escort");
        ArrayPush(specs, "Street Brawl Enforcer");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Grand Imperial Mall");
        ArrayPush(territories, "Pacifica Gym District");
        ArrayPush(territories, "West Wind Estate");
        ArrayPush(territories, "Underground Pits");
        ArrayPush(territories, "Coastview Corners");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 12);
        profile.bodyCount = AnimalsProfile.GetBodyCount(seed + 400, profile.rank) + RandRange(seed + 410, 0, 15);
        profile.arrestCount = RandRange(seed + 500, 0, 6);
        
        // Fight record - unique to Animals
        profile.fightWins = RandRange(seed + 350, 5, 100);
        profile.fightLosses = RandRange(seed + 360, 0, 20);
        
        // Loyalty
        profile.loyaltyRating = AnimalsProfile.GetLoyalty(seed + 600);
        
        // Physical markers
        let marks: array<String>;
        ArrayPush(marks, "Extreme muscle mass");
        if RandRange(seed + 700, 1, 100) <= 80 {
            ArrayPush(marks, "Steroid scarring");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, "Fighting scars");
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, "Animal brand tattoo");
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(marks, "Broken nose (multiple times)");
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, "Cauliflower ears");
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, "Gorilla Arms implants");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Weak once. The juice changed everything. Pack made a beast out of nothing. Strength is all that matters now.");
        ArrayPush(backstories, "Former athlete - career ended by injury. Animals showed how to become stronger than ever. Beyond human limits.");
        ArrayPush(backstories, "Grew up in Pacifica. Only the strong survive. Earned place in the pack through blood and broken bones.");
        ArrayPush(backstories, "Was prey once. Someone else's victim. Never again. The pack protects its own, and destroys everything else.");
        ArrayPush(backstories, "Fighting is the only language that matters. Found family in the pits. Win or die - simple philosophy.");
        ArrayPush(backstories, "Bouncer turned soldier. Security work pays, but the real rush is in the ring. Pack respects winners.");
        ArrayPush(backstories, "Got hooked on the juice working construction. When the site closed, the pack was the only place left.");
        ArrayPush(backstories, "Underground boxing circuit burned out. Animals offered real fights - no refs, no rules, no limits.");
        ArrayPush(backstories, "Sasquatch personally tested during initiation. Survived three rounds. Most don't last one.");
        ArrayPush(backstories, "Corpo gym rat who got bored lifting for vanity. Animals lift for war. Real purpose behind the iron.");
        ArrayPush(backstories, "Pacifica kid who watched VDBs hide behind screens. Wanted to solve problems with fists, not code.");
        ArrayPush(backstories, "Spent two years in a NUSA prison. Came out bigger than when going in. Pack recognized the hunger.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Working security at the Grand Imperial Mall. Nobody causes trouble twice.");
        ArrayPush(activities, "Training for upcoming pit fight. Victory or death - either way, glory.");
        ArrayPush(activities, "Muscle contract in Pacifica. Client wanted intimidation. Delivered.");
        ArrayPush(activities, "Juice distribution run. Keeping the pack supplied with the good stuff.");
        ArrayPush(activities, "Collecting debts. Most people pay when they see us coming. Smart.");
        ArrayPush(activities, "Cage match tonight in West Wind. Betting pool is already deep.");
        ArrayPush(activities, "Escorting a fixer through VDB territory. They looked but didn't touch.");
        ArrayPush(activities, "New juice formula testing. Volunteer batch. Results are promising.");
        ArrayPush(activities, "Clearing squatters from a building the pack wants. Didn't take long.");
        ArrayPush(activities, "Recruitment tryouts. Line of wannabes outside the gym. Most won't last.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
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
