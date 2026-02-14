// Tyger Claws Gang Profile Generator
// Yakuza-style organization with Arasaka ties

public class TygerClawsProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
        profile.gangAffiliation = "TYGER_CLAWS";
        profile.gangName = "Tyger Claws";
        profile.headerLabel = "TYGER CLAWS SYNDICATE FILE";
        
        // Yakuza-style ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Shateigashira"; profile.rankMeaning = "Lieutenant"; }
            else if roll <= 70 { profile.rank = "Kyodai"; profile.rankMeaning = "Big Brother"; }
            else if roll <= 90 { profile.rank = "Wakagashira"; profile.rankMeaning = "First Lieutenant"; }
            else { profile.rank = "Saiko-komon"; profile.rankMeaning = "Senior Advisor"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { profile.rank = "Shatei"; profile.rankMeaning = "Little Brother"; }
            else if roll <= 80 { profile.rank = "Kobun"; profile.rankMeaning = "Soldier"; }
            else { profile.rank = "Kyodai"; profile.rankMeaning = "Big Brother"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Gambling Operations");
        ArrayPush(specs, "Prostitution Oversight");
        ArrayPush(specs, "BD Production");
        ArrayPush(specs, "Protection Collection");
        ArrayPush(specs, "Street Enforcement");
        ArrayPush(specs, "Weapon Running");
        ArrayPush(specs, "Club Security");
        ArrayPush(specs, "Human Trafficking");
        ArrayPush(specs, "Drug Distribution");
        ArrayPush(specs, "Arasaka Liaison");
        ArrayPush(specs, "Money Laundering");
        ArrayPush(specs, "Netrunner Ops");
        ArrayPush(specs, "Street Racing Circuit");
        ArrayPush(specs, "Blackmail/Extortion");
        ArrayPush(specs, "Import/Export Coordination");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Japantown");
        ArrayPush(territories, "Kabuki");
        ArrayPush(territories, "Charter Hill");
        ArrayPush(territories, "Ho-Oh Club");
        ArrayPush(territories, "Clouds");
        ArrayPush(territories, "Dark Matter");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 15);
        profile.bodyCount = TygerClawsProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 5);
        
        // Loyalty
        profile.loyaltyRating = TygerClawsProfile.GetLoyalty(seed + 600);
        
        // Tattoos - Tyger Claws have luminous tattoos
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 85 {
            ArrayPush(tattoos, "Luminous tiger stripes");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(tattoos, "Kanji loyalty marks");
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(tattoos, "Full irezumi back piece");
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(tattoos, "Neon dragon sleeve");
        }
        if RandRange(seed + 740, 1, 100) <= 30 {
            ArrayPush(tattoos, "Missing finger tip (yubitsume)");
        }
        if RandRange(seed + 750, 1, 100) <= 35 {
            ArrayPush(tattoos, "Subdermal luminous ink (face)");
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Born into Tyger family. The code is everything. Learned to kill before learning to read.");
        ArrayPush(backstories, "Former Arasaka security who found the corporate life too restrictive. The Claws offered freedom and power.");
        ArrayPush(backstories, "Immigrated from Tokyo with nothing. Tyger Claws gave purpose, family, and a future worth fighting for.");
        ArrayPush(backstories, "Street kid from Kabuki. Joined young, rose fast. The neon runs through these veins now.");
        ArrayPush(backstories, "Recruited from Japantown youth. Proved loyalty through blood. Never looked back.");
        ArrayPush(backstories, "Debt to the Claws could only be paid one way - service. Now the debt is someone else's problem.");
        ArrayPush(backstories, "Ran a pachinko parlor that was already Claw territory. Paying protection became joining the family.");
        ArrayPush(backstories, "Father was Shatei, grandfather was Kyodai. Blood obligation. Refusing was never an option.");
        ArrayPush(backstories, "Won a street race in Japantown. Claws noticed. Driving skills got a foot in the door - blade skills kept it open.");
        ArrayPush(backstories, "Former joytoy at Clouds. Saw too much. The Claws offered a new role - one where nobody touches you uninvited.");
        ArrayPush(backstories, "Dishonored a rival gang boss in a card game. Needed protection fast. Tyger Claws respect a good gambler.");
        ArrayPush(backstories, "Served time in a NUSA federal prison. Met Claw brothers inside. Came out with a new family and new purpose.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Overseeing BD studio operations in Japantown.");
        ArrayPush(activities, "Collection runs in Kabuki. Business as usual.");
        ArrayPush(activities, "Enforcing Arasaka interests in Westbrook.");
        ArrayPush(activities, "Running security at the clubs. Eyes everywhere.");
        ArrayPush(activities, "Managing joytoy operations. Premium clientele only.");
        ArrayPush(activities, "Laundering eddies through pachinko parlors. Clean money, dirty work.");
        ArrayPush(activities, "Street racing circuit enforcement. House always wins.");
        ArrayPush(activities, "Meeting with Arasaka contact. New shipment arrangements.");
        ArrayPush(activities, "Disciplining a member who skimmed off collections. Yubitsume pending.");
        ArrayPush(activities, "Expanding influence into Charter Hill. New restaurant fronts opening.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        // Status
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Saiko-komon") || Equals(rank, "Wakagashira") { return RandRange(seed, 15, 50); }
        if Equals(rank, "Shateigashira") { return RandRange(seed, 10, 35); }
        if Equals(rank, "Kyodai") { return RandRange(seed, 5, 20); }
        return RandRange(seed, 0, 12);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "UNPROVEN"; }
        if roll <= 30 { return "BOUND"; }
        if roll <= 60 { return "HONORED"; }
        if roll <= 85 { return "BLOOD OATH"; }
        return "SWORN UNTO DEATH";
    }
}
