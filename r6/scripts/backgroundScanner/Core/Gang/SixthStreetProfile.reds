// 6th Street Gang Profile Generator
// Military veterans turned community defenders

public class SixthStreetProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
        profile.gangAffiliation = "6TH_STREET";
        profile.gangName = "6th Street";
        profile.headerLabel = "6TH STREET VETERAN FILE";
        
        // Military-style ranks
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "veteran");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "First Sergeant"; profile.rankMeaning = "Senior NCO"; }
            else if roll <= 70 { profile.rank = "Staff Sergeant"; profile.rankMeaning = "Squad Leader"; }
            else if roll <= 90 { profile.rank = "Captain"; profile.rankMeaning = "Company Leader"; }
            else { profile.rank = "Commander"; profile.rankMeaning = "Regional Boss"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Private"; profile.rankMeaning = "New Blood"; }
            else if roll <= 70 { profile.rank = "Corporal"; profile.rankMeaning = "Fireteam Lead"; }
            else if roll <= 90 { profile.rank = "Sergeant"; profile.rankMeaning = "Full Member"; }
            else { profile.rank = "Specialist"; profile.rankMeaning = "Tech Expert"; }
        }
        
        // Specializations - military focus
        let specs: array<String>;
        ArrayPush(specs, "Weapons Specialist");
        ArrayPush(specs, "Demolitions");
        ArrayPush(specs, "Vehicle Operations");
        ArrayPush(specs, "Territory Defense");
        ArrayPush(specs, "Community Watch");
        ArrayPush(specs, "Arms Dealing");
        ArrayPush(specs, "Training Cadre");
        ArrayPush(specs, "Intelligence");
        ArrayPush(specs, "Supply/Logistics");
        ArrayPush(specs, "Sniper");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Arroyo");
        ArrayPush(territories, "Rancho Coronado");
        ArrayPush(territories, "Santo Domingo Industrial");
        ArrayPush(territories, "Red Dirt Bar");
        ArrayPush(territories, "Veterans Hall");
        ArrayPush(territories, "Gun Range District");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 25);
        profile.bodyCount = SixthStreetProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 4);
        
        // Military service - unique to 6th Street
        let services: array<String>;
        ArrayPush(services, "NUSA Army - Unification War");
        ArrayPush(services, "NUSA Marines - Border Ops");
        ArrayPush(services, "Militech PMC - Corporate Conflicts");
        ArrayPush(services, "National Guard - Domestic");
        ArrayPush(services, "Private Security - Corp Wars");
        ArrayPush(services, "No prior service - Community trained");
        profile.priorService = services[RandRange(seed + 350, 0, ArraySize(services) - 1)];
        
        // Loyalty
        profile.loyaltyRating = SixthStreetProfile.GetLoyalty(seed + 600);
        
        // Tattoos - American/military imagery
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 90 {
            ArrayPush(tattoos, "American flag imagery");
        }
        if RandRange(seed + 710, 1, 100) <= 70 {
            ArrayPush(tattoos, "Military unit insignia");
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(tattoos, "6th Street stars");
        }
        if RandRange(seed + 730, 1, 100) <= 30 {
            ArrayPush(tattoos, "Memorial names - fallen brothers");
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Served in the Unification War. Came home to nothing. 6th Street gave purpose to soldiers forgotten by NUSA.");
        ArrayPush(backstories, "Community was being torn apart by gangs. 6th Street offered protection and asked for loyalty. Fair trade.");
        ArrayPush(backstories, "Father was 6th Street. His father before him. Patriotism and protection run in the family.");
        ArrayPush(backstories, "Lost squad overseas to corpo orders. Found new brothers in Santo Domingo. Fighting for something real now.");
        ArrayPush(backstories, "Ex-Militech. Got tired of corporate wars. 6th Street fights for the neighborhood, not shareholders.");
        ArrayPush(backstories, "Never served, but trained by vets. Earned respect through dedication. Community over everything.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Neighborhood watch in Arroyo. Keeping streets safe from predators.");
        ArrayPush(activities, "Arms deal in progress. Quality military hardware, fair prices.");
        ArrayPush(activities, "Training new recruits. Standards matter. Discipline saves lives.");
        ArrayPush(activities, "Territory patrol. Rancho Coronado stays American.");
        ArrayPush(activities, "Community cookout security. Protecting our people, our way.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetBodyCount(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Commander") || Equals(rank, "Captain") { return RandRange(seed, 15, 50); }
        if Equals(rank, "First Sergeant") || Equals(rank, "Staff Sergeant") { return RandRange(seed, 8, 30); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "RECRUIT"; }
        if roll <= 30 { return "ENLISTED"; }
        if roll <= 60 { return "COMMITTED"; }
        if roll <= 85 { return "DEDICATED"; }
        return "TRUE PATRIOT";
    }
}
