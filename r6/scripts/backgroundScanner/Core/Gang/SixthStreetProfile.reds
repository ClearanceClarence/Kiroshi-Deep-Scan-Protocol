// 6th Street Gang Profile Generator
// Military veterans turned community defenders

public class KdspSixthStreetProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
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
        ArrayPush(specs, "Combat Medic");
        ArrayPush(specs, "Communications/Comms");
        ArrayPush(specs, "Drone Operations");
        ArrayPush(specs, "Perimeter Security");
        ArrayPush(specs, "Recruitment Sergeant");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Arroyo");
        ArrayPush(territories, "Rancho Coronado");
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S0"));
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-GangManager-S18"));
        ArrayPush(territories, "Veterans Hall");
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S1"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 25);
        profile.bodyCount = KdspSixthStreetProfile.GetBodyCount(seed + 400, profile.rank);
        profile.arrestCount = RandRange(seed + 500, 0, 4);
        
        // Military service - unique to 6th Street
        let services: array<String>;
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S2"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S3"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S4"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S5"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S6"));
        ArrayPush(services, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S7"));
        profile.priorService = services[RandRange(seed + 350, 0, ArraySize(services) - 1)];
        
        // Loyalty
        profile.loyaltyRating = KdspSixthStreetProfile.GetLoyalty(seed + 600);
        
        // Tattoos - American/military imagery
        let tattoos: array<String>;
        if RandRange(seed + 700, 1, 100) <= 90 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S10"));
        }
        if RandRange(seed + 710, 1, 100) <= 70 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S11"));
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S8"));
        }
        if RandRange(seed + 730, 1, 100) <= 30 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S9"));
        }
        if RandRange(seed + 740, 1, 100) <= 45 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S10"));
        }
        if RandRange(seed + 750, 1, 100) <= 35 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S11"));
        }
        if RandRange(seed + 760, 1, 100) <= 25 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S12"));
        }
        profile.distinguishingMarks = tattoos;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S18"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S19"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S20"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S21"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S22"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S23"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S24"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S30"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S31"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S32"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S33"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-S34"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
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
