// Scavengers Gang Profile Generator
// Organ harvesters and chrome thieves operating in cells

public class ScavengersProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
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
        ArrayPush(specs, "Black Market Sales");
        ArrayPush(specs, "Body Disposal");
        ArrayPush(specs, "Ripperdoc Work");
        ArrayPush(specs, "Vehicle Operations");
        ArrayPush(specs, "Site Security");
        ArrayPush(specs, "Intimidation");
        ArrayPush(specs, "Clean-up Crew");
        ArrayPush(specs, "Sedation Specialist");
        ArrayPush(specs, "Cold Storage Management");
        ArrayPush(specs, "Buyer Liaison");
        ArrayPush(specs, "Transport Logistics");
        ArrayPush(specs, "Street Surveillance");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory - Scavs operate everywhere
        let territories: array<String>;
        ArrayPush(territories, "Watson Underground");
        ArrayPush(territories, "Kabuki Back Alleys");
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
        profile.loyaltyRating = ScavengersProfile.GetLoyalty(seed + 600);
        
        // Marks
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 50 {
            ArrayPush(marks, "Surgical scars");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, "Cheap cyberware");
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, "Eastern European prison tattoos");
        }
        if RandRange(seed + 730, 1, 100) <= 45 {
            ArrayPush(marks, "Chemical staining on hands");
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, "Faint antiseptic smell");
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, "Mismatched salvaged optics");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Came from the old country with nothing. Learned that in Night City, everything has a price - including people.");
        ArrayPush(backstories, "Former medical student. Couldn't afford to finish. Found that organs pay better than degrees anyway.");
        ArrayPush(backstories, "Survived by being useful to the cell. Morality is a luxury for people with options.");
        ArrayPush(backstories, "Debt to the wrong people. Only way out was through. Now too deep to ever leave.");
        ArrayPush(backstories, "Sociopath by diagnosis. Found the one job where that's an asset. Cutting comes naturally.");
        ArrayPush(backstories, "Family back home needs money. Don't ask where it comes from. Just send it.");
        ArrayPush(backstories, "Worked in a corpo organ farm. Laid off. Took the skills freelance. Market's always hungry.");
        ArrayPush(backstories, "Human trafficking victim who turned the tables. Learned the business from the inside out.");
        ArrayPush(backstories, "Ex-paramedic who realized saving lives paid nothing. Taking them apart pays everything.");
        ArrayPush(backstories, "Grew up in the Watson sewers. Nobody notices what happens underground. Perfect for the trade.");
        ArrayPush(backstories, "Former Maelstrom who wasn't crazy enough for the chrome cult. Scavs just want product. Simpler.");
        ArrayPush(backstories, "Immigrated on a shipping container. The smugglers offered a job on arrival. Didn't have the luxury of saying no.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Acquisition run in Watson. Fresh inventory needed.");
        ArrayPush(activities, "Processing at the chop shop. Quota to meet.");
        ArrayPush(activities, "Black market delivery. Premium chrome, no questions.");
        ArrayPush(activities, "Site relocation. NCPD got too close to the old spot.");
        ArrayPush(activities, "Scouting new hunting grounds. Supply and demand.");
        ArrayPush(activities, "Cleaning a crime scene. Bleach and patience. No traces left.");
        ArrayPush(activities, "Negotiating with a ripperdoc buyer. Wants specific blood types.");
        ArrayPush(activities, "Baiting a trap in Kabuki. Tourist district - easy pickings.");
        ArrayPush(activities, "Cold storage maintenance. Product spoils if temp fluctuates.");
        ArrayPush(activities, "Disposing of a problem. Someone talked. Someone won't anymore.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
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
