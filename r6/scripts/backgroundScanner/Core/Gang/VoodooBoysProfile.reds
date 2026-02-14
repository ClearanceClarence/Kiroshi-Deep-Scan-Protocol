// Voodoo Boys Gang Profile Generator
// Haitian netrunner collective seeking answers beyond the Blackwall

public class VoodooBoysProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
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
        ArrayPush(specs, "Deep Net Diving");
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
        ArrayPush(specs, "Dead Drop Networks");
        ArrayPush(specs, "Rogue AI Containment");
        ArrayPush(specs, "Community Net Access");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Coastview");
        ArrayPush(territories, "Pacifica Chapel");
        ArrayPush(territories, "Batty's Hotel");
        ArrayPush(territories, "GIM Underground");
        ArrayPush(territories, "Net Cafe Row");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 15);
        profile.bodyCount = RandRange(seed + 400, 0, 30); // VDBs prefer not to dirty hands
        profile.arrestCount = RandRange(seed + 500, 0, 2); // Hard to catch what you can't trace
        
        // Net stats - unique to VDBs
        profile.systemsCompromised = RandRange(seed + 350, 10, 500);
        profile.netDepth = RandRange(seed + 360, 3, 9); // How deep they dive
        
        // Loyalty
        profile.loyaltyRating = VoodooBoysProfile.GetLoyalty(seed + 600);
        
        // Marks
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 70 {
            ArrayPush(marks, "Veve ritual scarification");
        }
        if RandRange(seed + 710, 1, 100) <= 80 {
            ArrayPush(marks, "Netrunning interface ports");
        }
        if RandRange(seed + 720, 1, 100) <= 40 {
            ArrayPush(marks, "Haitian spiritual symbols");
        }
        if RandRange(seed + 730, 1, 100) <= 50 {
            ArrayPush(marks, "Bloodshot eyes from deep dives");
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, "Neural burn scarring at temples");
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, "Protective gris-gris charms");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Born in Pacifica to Haitian parents. The Net is the loa now - spirits in the machine. Seeking truth beyond the Blackwall.");
        ArrayPush(backstories, "Refugee from the islands. Found community in Pacifica. The Voodoo Boys protect their own - in meat and in Net.");
        ArrayPush(backstories, "Touched the other side during a deep dive. Something spoke back. Now searching for answers only VDBs understand.");
        ArrayPush(backstories, "Grew up with a deck in hand. Natural talent caught Brigitte's attention. Trained in ways outsiders never see.");
        ArrayPush(backstories, "Outsider who proved loyalty. Rare for non-Haitians. The spirits accepted - that's what matters.");
        ArrayPush(backstories, "Lost family to corpo data theft. Learned to fight back in the Net. VDBs gave purpose to the rage.");
        ArrayPush(backstories, "Grandmother was a real mambo back in Haiti. Said the loa would find new homes. She was right - they live in the Net.");
        ArrayPush(backstories, "NetWatch killed a friend during a raid. Pacifica doesn't forget. The Blackwall is their weapon - it will be ours.");
        ArrayPush(backstories, "Grew up in the ruins when Pacifica was abandoned. No corps came to help. VDBs built something from nothing.");
        ArrayPush(backstories, "Flatlined during a deep dive and saw what waits beyond. Came back different. The others understand.");
        ArrayPush(backstories, "Former corpo netrunner who discovered what NetWatch really guards. Defected to the only people seeking real answers.");
        ArrayPush(backstories, "Second generation Pacifica. Parents built this community with bare hands. Protecting it with code and will.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Deep Net reconnaissance. Mapping pathways to the Blackwall.");
        ArrayPush(activities, "Information extraction contract. Client pays well, asks no questions.");
        ArrayPush(activities, "Protecting Pacifica servers. Outsiders keep probing. Keep failing.");
        ArrayPush(activities, "Ritual dive scheduled. Contacting the other side requires preparation.");
        ArrayPush(activities, "Training new runners. Knowledge passes to the worthy.");
        ArrayPush(activities, "Intercepted NetWatch probe near Coastview. Traced and neutralized.");
        ArrayPush(activities, "Daemon deployment across Night City infrastructure. Sleeper protocol.");
        ArrayPush(activities, "Community network maintenance. Pacifica stays connected on our terms.");
        ArrayPush(activities, "Encrypted data auction. Corpo secrets fetch premium prices.");
        ArrayPush(activities, "Blackwall fluctuation detected. Council convened. Something is changing.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
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
