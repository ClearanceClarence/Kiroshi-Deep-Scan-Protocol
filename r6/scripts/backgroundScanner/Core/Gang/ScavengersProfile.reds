// Scavengers Gang Profile Generator
// Organ harvesters and chrome thieves operating in cells

public class KdspScavengersProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "SCAVENGERS";
        profile.gangName = "Scavengers";
        profile.headerLabel = "SCAVENGER CELL RECORD";
        
        // Cell structure
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Cell Leader"; profile.rankMeaning = "Boss"; }
            else if roll <= 70 { profile.rank = "Surgeon"; profile.rankMeaning = "Ripper"; }
            else if roll <= 90 { profile.rank = "Butcher"; profile.rankMeaning = "Senior"; }
            else { profile.rank = "Broker"; profile.rankMeaning = "Fence"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Grabber"; profile.rankMeaning = "Kidnapper"; }
            else if roll <= 70 { profile.rank = "Cutter"; profile.rankMeaning = "Harvester"; }
            else if roll <= 90 { profile.rank = "Runner"; profile.rankMeaning = "Courier"; }
            else { profile.rank = "Lookout"; profile.rankMeaning = "Scout"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Organ Harvesting");
        ArrayPush(specs, "Cyberware Extraction");
        ArrayPush(specs, "Victim Acquisition");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S0"));
        ArrayPush(specs, "Body Disposal");
        ArrayPush(specs, "Ripperdoc Work");
        ArrayPush(specs, "Vehicle Operations");
        ArrayPush(specs, "Site Security");
        ArrayPush(specs, "Intimidation");
        ArrayPush(specs, "Clean-up Crew");
        ArrayPush(specs, "Sedation Specialist");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S1"));
        ArrayPush(specs, "Buyer Liaison");
        ArrayPush(specs, "Transport Logistics");
        ArrayPush(specs, "Street Surveillance");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory - Scavs operate everywhere
        let territories: array<String>;
        ArrayPush(territories, "Watson Underground");
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-ScavengersProf-S2"));
        ArrayPush(territories, "Northside Warehouses");
        ArrayPush(territories, "Industrial Basements");
        ArrayPush(territories, "Abandoned Clinics");
        ArrayPush(territories, "Pacifica Ruins");
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
            ArrayPush(marks, "Surgical scars");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, "Cheap cyberware");
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
        if roll <= 20 { return "EXPENDABLE"; }
        if roll <= 50 { return "USEFUL"; }
        if roll <= 80 { return "TRUSTED"; }
        return "ESSENTIAL";
    }
}
