// Aldecaldos Gang Profile Generator
// Nomad clan focused on family, freedom, and the open road

public class AldecaldosProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
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
        ArrayPush(specs, "Solar Tech Maintenance");
        ArrayPush(specs, "Animal Husbandry");
        ArrayPush(specs, "Water Purification");
        ArrayPush(specs, "Communications/Radio");
        ArrayPush(specs, "Youth Training");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Rocky Ridge Camp");
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
        profile.loyaltyRating = AldecaldosProfile.GetLoyalty(seed + 600);
        
        // Style
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 70 {
            ArrayPush(marks, "Aldecaldo clan tattoo");
        }
        if RandRange(seed + 710, 1, 100) <= 50 {
            ArrayPush(marks, "Road-worn appearance");
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, "Family memorial marks");
        }
        if RandRange(seed + 730, 1, 100) <= 55 {
            ArrayPush(marks, "Calloused mechanic hands");
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, "Desert sun tan lines");
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, "Clan beadwork jewelry");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Born on the road. Aldecaldo blood. The clan is home, wherever the wheels take us.");
        ArrayPush(backstories, "Left Night City's poison. Found family in the Badlands. Nomad life isn't easy, but it's free.");
        ArrayPush(backstories, "Third generation Aldecaldo. Grandparents founded this clan. Legacy means something.");
        ArrayPush(backstories, "Outsider taken in when no one else would. Clan doesn't judge where you're from, only who you become.");
        ArrayPush(backstories, "Former corpo who woke up. Everything they said about nomads was lies. Found truth on the road.");
        ArrayPush(backstories, "Married into the clan. Took time to earn trust. Now would die for familia without hesitation.");
        ArrayPush(backstories, "Orphaned by a Wraith raid. Aldecaldos found the wreckage and a scared kid. Raised as their own.");
        ArrayPush(backstories, "Mechanic who kept a convoy alive through a three-day sandstorm. Earned a permanent spot that night.");
        ArrayPush(backstories, "Ran from a corpo contract on my life. Aldecaldos don't ask questions when someone needs shelter.");
        ArrayPush(backstories, "Grew up fixing solar panels at Rocky Ridge. Every watt of power is a small victory against the wasteland.");
        ArrayPush(backstories, "Former street kid from Heywood. City was eating me alive. The open road healed what concrete broke.");
        ArrayPush(backstories, "Voted into the clan by council after smuggling medical supplies through Militech checkpoints. Actions earned the name.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Supply run to Night City. Trade goods for essentials.");
        ArrayPush(activities, "Camp maintenance. Keeping home in working order.");
        ArrayPush(activities, "Convoy escort. Getting goods through Wraith territory.");
        ArrayPush(activities, "Tech salvage in the wastes. One person's trash is our survival.");
        ArrayPush(activities, "Clan gathering. Family comes first, always.");
        ArrayPush(activities, "Solar array expansion at Rocky Ridge. More power means more independence.");
        ArrayPush(activities, "Water purification rig repair. Can't afford downtime in the desert.");
        ArrayPush(activities, "Negotiating trade deal with a Night City fixer. Fair terms or no deal.");
        ArrayPush(activities, "Scouting new camp locations. Need to stay ahead of the Wraith patrols.");
        ArrayPush(activities, "Teaching younger members to drive and shoot. Survival skills are a birthright.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
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
