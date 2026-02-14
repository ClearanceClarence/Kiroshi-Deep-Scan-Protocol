// Valentinos Gang Profile Generator
// Family-oriented Heywood gang with Santa Muerte devotion

public class ValentinosProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
        profile.gangAffiliation = "VALENTINOS";
        profile.gangName = "Valentinos";
        profile.headerLabel = "VALENTINOS FAMILIA RECORD";
        
        // Family-style ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Capitan"; profile.rankMeaning = "Captain"; }
            else if roll <= 70 { profile.rank = "Teniente"; profile.rankMeaning = "Lieutenant"; }
            else if roll <= 90 { profile.rank = "Veterano"; profile.rankMeaning = "Veteran"; }
            else { profile.rank = "Consejero"; profile.rankMeaning = "Advisor"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Soldado"; profile.rankMeaning = "Soldier"; }
            else if roll <= 70 { profile.rank = "Hermano"; profile.rankMeaning = "Brother"; }
            else if roll <= 90 { profile.rank = "Aspirante"; profile.rankMeaning = "Prospect"; }
            else { profile.rank = "Sicario"; profile.rankMeaning = "Hitman"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Street Enforcement");
        ArrayPush(specs, "Drug Distribution");
        ArrayPush(specs, "Car Boosting");
        ArrayPush(specs, "Protection Services");
        ArrayPush(specs, "Contract Killing");
        ArrayPush(specs, "Weapons Trade");
        ArrayPush(specs, "Territory Patrol");
        ArrayPush(specs, "Community Relations");
        ArrayPush(specs, "Debt Collection");
        ArrayPush(specs, "Honor Enforcement");
        ArrayPush(specs, "Street Racing");
        ArrayPush(specs, "Fencing Stolen Goods");
        ArrayPush(specs, "Lowrider Mechanic");
        ArrayPush(specs, "Recruitment/Initiation");
        ArrayPush(specs, "Gambling Operations");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Vista del Rey");
        ArrayPush(territories, "The Glen");
        ArrayPush(territories, "Wellsprings");
        ArrayPush(territories, "El Coyote Cojo");
        ArrayPush(territories, "Heywood Streets");
        ArrayPush(territories, "Glen Cemetery");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 20);
        profile.bodyCount = ValentinosProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 8);
        
        // Loyalty
        profile.loyaltyRating = ValentinosProfile.GetLoyalty(seed + 600);
        
        // Tattoos - Valentinos have religious imagery
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 90 {
            ArrayPush(tattoos, "Santa Muerte imagery");
        }
        if RandRange(seed + 710, 1, 100) <= 70 {
            ArrayPush(tattoos, "Golden heart with thorns");
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(tattoos, "Heywood territorial markers");
        }
        if RandRange(seed + 730, 1, 100) <= 40 {
            ArrayPush(tattoos, "Memorial portraits");
        }
        if RandRange(seed + 740, 1, 100) <= 55 {
            ArrayPush(tattoos, "Gold tooth implants");
        }
        if RandRange(seed + 750, 1, 100) <= 35 {
            ArrayPush(tattoos, "Rosary bead wrist tattoo");
        }
        if RandRange(seed + 760, 1, 100) <= 30 {
            ArrayPush(tattoos, "Valentino cross on neck");
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Third generation Valentino. The gold runs in the blood. Heywood is home, familia is everything.");
        ArrayPush(backstories, "Grew up on these streets. Valentinos protected the neighborhood when no one else would. Loyalty repaid.");
        ArrayPush(backstories, "Lost family to corpo greed. Found new family in the Valentinos. Santa Muerte guides now.");
        ArrayPush(backstories, "Started boosting cars young. Valentinos saw potential. Now handling bigger jobs for the familia.");
        ArrayPush(backstories, "Came from nothing. Valentinos offered respect, purpose, brotherhood. Would die for these streets.");
        ArrayPush(backstories, "Ex-military, returned to Heywood. Skills serve the community now. La familia needed soldiers.");
        ArrayPush(backstories, "Crossed the border with nothing but a prayer. Valentinos were the first to offer a hand. Owe them everything.");
        ArrayPush(backstories, "Mother lit candles at the Santa Muerte shrine every night. When she died, the Valentinos paid for everything. Blood debt.");
        ArrayPush(backstories, "Was a boxer in The Glen. Lost a fixed fight, owed the wrong people. Valentinos settled the debt. Now settling theirs.");
        ArrayPush(backstories, "Sicario from way back. Other gangs wanted muscle. Valentinos wanted loyalty. Only one of those earns respect.");
        ArrayPush(backstories, "Grew up watching lowriders cruise Vista del Rey. Always knew which crew to ride with. Gold forever.");
        ArrayPush(backstories, "Abuela was one of the originals. Her stories built this. Carrying the legacy forward - with honor.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Holding down Vista del Rey. Nobody moves without paying respects.");
        ArrayPush(activities, "Running product through Heywood. Clean supply, loyal customers.");
        ArrayPush(activities, "Community protection detail. Valentinos watch over their own.");
        ArrayPush(activities, "Enforcing honor debts. Some lessons taught with gold, others with lead.");
        ArrayPush(activities, "Car acquisition specialist. High-end vehicles for high-end clients.");
        ArrayPush(activities, "Organizing the Santa Muerte procession. The dead walk with us tonight.");
        ArrayPush(activities, "Lowrider meet in The Glen. Business and pleasure. Mostly business.");
        ArrayPush(activities, "Settling a blood feud between two Valentino families. Delicate work.");
        ArrayPush(activities, "Expanding into Wellsprings. New territory means new revenue.");
        ArrayPush(activities, "Weapons cache resupply from a Militech contact. Premium iron at family prices.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
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
        if roll <= 10 { return "PROSPECT"; }
        if roll <= 30 { return "ACCEPTED"; }
        if roll <= 60 { return "FAMILIA"; }
        if roll <= 85 { return "BLOOD FAMILIA"; }
        return "UNTO DEATH";
    }
}
