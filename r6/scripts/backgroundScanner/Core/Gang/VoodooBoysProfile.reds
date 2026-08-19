// Voodoo Boys Gang Profile Generator
// Haitian netrunner collective seeking answers beyond the Blackwall

public class KdspVoodooBoysProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = "VOODOO_BOYS";
        profile.gangName = "Voodoo Boys";
        profile.headerLabel = "VOODOO BOYS NET RECORD";
        
        // Netrunner hierarchy
        let isElite = StrContains(appearanceName, "elite") || StrContains(appearanceName, "boss") || StrContains(appearanceName, "netrunner");
        if isElite {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Houngan"; profile.rankMeaning = "Priest/Senior Runner"; }
            else if roll <= 70 { profile.rank = "Mambo"; profile.rankMeaning = "Priestess/Leader"; }
            else if roll <= 90 { profile.rank = "Bokor"; profile.rankMeaning = "Sorcerer/Elite"; }
            else { profile.rank = "Gede"; profile.rankMeaning = "Death Aspect/Assassin"; }
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { profile.rank = "Serviteur"; profile.rankMeaning = "Servant/Initiate"; }
            else if roll <= 70 { profile.rank = "Chwal"; profile.rankMeaning = "Horse/Runner"; }
            else if roll <= 90 { profile.rank = "Ti Moun"; profile.rankMeaning = "Child/Prospect"; }
            else { profile.rank = "Solda"; profile.rankMeaning = "Soldier/Guard"; }
        }
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S0"));
        ArrayPush(specs, "ICE Breaking");
        ArrayPush(specs, "Data Mining");
        ArrayPush(specs, "Blackwall Research");
        ArrayPush(specs, "AI Contact");
        ArrayPush(specs, "Information Brokering");
        ArrayPush(specs, "System Infiltration");
        ArrayPush(specs, "Territory Defense");
        ArrayPush(specs, "Surveillance");
        ArrayPush(specs, "Wetwork Support");
        ArrayPush(specs, "Daemon Crafting");
        ArrayPush(specs, "Signal Jamming");
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S1"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S2"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S3"));
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Coastview");
        ArrayPush(territories, "Pacifica Chapel");
        ArrayPush(territories, "Batty's Hotel");
        ArrayPush(territories, "GIM Underground");
        ArrayPush(territories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S4"));
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 15);
        profile.bodyCount = RandRange(seed + 400, 0, 30); // VDBs prefer not to dirty hands
        profile.arrestCount = RandRange(seed + 500, 0, 2); // Hard to catch what you can't trace
        
        // Net stats - unique to VDBs
        profile.systemsCompromised = RandRange(seed + 350, 10, 500);
        profile.netDepth = RandRange(seed + 360, 3, 9); // How deep they dive
        
        // Loyalty
        profile.loyaltyRating = KdspVoodooBoysProfile.GetLoyalty(seed + 600);
        
        // Marks
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 70 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S5"));
        }
        if RandRange(seed + 710, 1, 100) <= 80 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S6"));
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S7"));
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S8"));
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S9"));
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S10"));
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S11"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S12"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S13"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S14"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S15"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S16"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S17"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S18"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S19"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S20"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S21"));
        ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S22"));
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S30"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S31"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-VoodooBoysProf-S32"));
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = KdspGangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "OUTSIDER"; }
        if roll <= 30 { return "ACCEPTED"; }
        if roll <= 60 { return "TRUSTED"; }
        if roll <= 85 { return "INNER CIRCLE"; }
        return "BLOOD OF PACIFICA";
    }
}
