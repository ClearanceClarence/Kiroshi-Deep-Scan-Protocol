// Maelstrom Gang Profile Generator
// Chrome cult obsessed with cybernetic transcendence

public class MaelstromProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
        profile.gangAffiliation = "MAELSTROM";
        profile.gangName = "Maelstrom";
        profile.headerLabel = "MAELSTROM COLLECTIVE RECORD";
        
        // Chrome cult ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "heavy");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Chrome Priest"; profile.rankMeaning = "Senior Member"; }
            else if roll <= 70 { profile.rank = "Borg Lieutenant"; profile.rankMeaning = "Squad Leader"; }
            else if roll <= 90 { profile.rank = "Iron Father"; profile.rankMeaning = "Veteran"; }
            else { profile.rank = "Tech Shaman"; profile.rankMeaning = "Ripperdoc"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { profile.rank = "Chrome Initiate"; profile.rankMeaning = "New Member"; }
            else if roll <= 80 { profile.rank = "Iron Brother"; profile.rankMeaning = "Full Member"; }
            else { profile.rank = "Circuit Runner"; profile.rankMeaning = "Tech Specialist"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Cyberware Installation");
        ArrayPush(specs, "Heavy Weapons");
        ArrayPush(specs, "Organ Acquisition");
        ArrayPush(specs, "Chrome Maintenance");
        ArrayPush(specs, "Kidnapping Ops");
        ArrayPush(specs, "Territory Defense");
        ArrayPush(specs, "Scrap Salvage");
        ArrayPush(specs, "Arms Dealing");
        ArrayPush(specs, "Intimidation");
        ArrayPush(specs, "Borg Conversion");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "All Foods Plant");
        ArrayPush(territories, "Northside Industrial");
        ArrayPush(territories, "Totentanz");
        ArrayPush(territories, "Watson Docks");
        ArrayPush(territories, "Underground Labs");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 10);
        profile.bodyCount = MaelstromProfile.GetBodyCount(seed + 400, profile.rank) + RandRange(seed + 410, 5, 20);
        profile.arrestCount = RandRange(seed + 500, 0, 3);
        
        // Chrome percentage - unique to Maelstrom
        profile.chromePercentage = RandRange(seed + 550, 40, 95);
        
        // Loyalty
        profile.loyaltyRating = MaelstromProfile.GetLoyalty(seed + 600);
        
        // Marks - Maelstrom prefer chrome to ink
        let marks: array<String>;
        ArrayPush(marks, IntToString(profile.chromePercentage) + "% cybernetic replacement");
        if RandRange(seed + 700, 1, 100) <= 70 {
            ArrayPush(marks, "Optical replacements (multiple)");
        }
        if RandRange(seed + 710, 1, 100) <= 50 {
            ArrayPush(marks, "Facial chrome plating");
        }
        if RandRange(seed + 720, 1, 100) <= 30 {
            ArrayPush(marks, "Full limb conversions");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Flesh is weakness. Found truth in chrome and circuitry. The collective showed the way to transcendence.");
        ArrayPush(backstories, "Cyberpsychosis survivor. Others feared the edge - Maelstrom embraced it. Here, the madness is understood.");
        ArrayPush(backstories, "Former corpo techie. Saw what chrome could really do when corps weren't limiting the potential.");
        ArrayPush(backstories, "Born defective. Meat body was failing. Maelstrom offered replacement - piece by piece, becoming perfect.");
        ArrayPush(backstories, "Street doc gone too far. Lost license, found family. Now installs chrome for those worthy of ascension.");
        ArrayPush(backstories, "They took everything in a raid. Rebuilt from scrap and rage. More machine than meat now. Stronger.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Chrome harvesting operations in Watson. Fresh meat needed.");
        ArrayPush(activities, "Protecting Totentanz. The bass drops, the bodies drop.");
        ArrayPush(activities, "Running cyberware through Northside. Military grade.");
        ArrayPush(activities, "Recruitment drive. Finding those ready for conversion.");
        ArrayPush(activities, "Territory dispute with Scavs. They take organs. We take everything.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Tech Shaman") || Equals(rank, "Iron Father") { return RandRange(seed, 15, 40); }
        if Equals(rank, "Borg Lieutenant") || Equals(rank, "Chrome Priest") { return RandRange(seed, 10, 30); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "FLESH-BOUND"; }
        if roll <= 30 { return "CONVERTING"; }
        if roll <= 60 { return "CHROME-BLESSED"; }
        if roll <= 85 { return "TRANSCENDING"; }
        return "FULLY INTEGRATED";
    }
}
