// Moxes Gang Profile Generator
// Protective collective defending sex workers and marginalized people

public class MoxesProfile {

    public static func Generate(seed: Int32, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
        profile.gangAffiliation = "MOXES";
        profile.gangName = "The Moxes";
        profile.headerLabel = "MOXES COLLECTIVE FILE";
        
        // Collective structure - less hierarchical
        let roll = RandRange(seed, 1, 100);
        if roll <= 30 { profile.rank = "Sister"; profile.rankMeaning = "Full Member"; }
        else if roll <= 50 { profile.rank = "Brother"; profile.rankMeaning = "Full Member"; }
        else if roll <= 70 { profile.rank = "Guardian"; profile.rankMeaning = "Protector"; }
        else if roll <= 85 { profile.rank = "Voice"; profile.rankMeaning = "Spokesperson"; }
        else if roll <= 95 { profile.rank = "Elder"; profile.rankMeaning = "Veteran"; }
        else { profile.rank = "Founding"; profile.rankMeaning = "Original Member"; }
        profile.rankMeaning = "";
        
        // Specializations
        let specs: array<String>;
        ArrayPush(specs, "Worker Protection");
        ArrayPush(specs, "BD Production");
        ArrayPush(specs, "Bar Security");
        ArrayPush(specs, "Community Outreach");
        ArrayPush(specs, "Anti-Trafficking");
        ArrayPush(specs, "Street Patrol");
        ArrayPush(specs, "Medical Support");
        ArrayPush(specs, "Safe House Ops");
        ArrayPush(specs, "Intelligence");
        ArrayPush(specs, "Self-Defense Training");
        ArrayPush(specs, "Victim Counseling");
        ArrayPush(specs, "Surveillance/Counter-Surveillance");
        ArrayPush(specs, "Legal Aid Coordination");
        ArrayPush(specs, "Supply Procurement");
        ArrayPush(specs, "Communications/Alerts");
        profile.role = specs[RandRange(seed + 100, 0, ArraySize(specs) - 1)];
        
        // Territory
        let territories: array<String>;
        ArrayPush(territories, "Lizzie's Bar");
        ArrayPush(territories, "Kabuki Safe Zones");
        ArrayPush(territories, "Watson Worker Districts");
        ArrayPush(territories, "Underground Network");
        profile.territory = territories[RandRange(seed + 200, 0, ArraySize(territories) - 1)];
        
        // Stats
        profile.yearsActive = RandRange(seed + 300, 1, 10);
        profile.bodyCount = RandRange(seed + 400, 0, 15); // Moxes defend, don't hunt
        profile.arrestCount = RandRange(seed + 500, 0, 4);
        
        // People protected - unique to Moxes
        profile.peopleProtected = RandRange(seed + 350, 5, 100);
        
        // Loyalty
        profile.loyaltyRating = MoxesProfile.GetLoyalty(seed + 600);
        
        // Style
        let marks: array<String>;
        if RandRange(seed + 700, 1, 100) <= 80 {
            ArrayPush(marks, "Mox signature style");
        }
        if RandRange(seed + 710, 1, 100) <= 60 {
            ArrayPush(marks, "Protective sigil tattoos");
        }
        if RandRange(seed + 720, 1, 100) <= 50 {
            ArrayPush(marks, "Lizzie memorial mark");
        }
        if RandRange(seed + 730, 1, 100) <= 45 {
            ArrayPush(marks, "Neon hair coloring");
        }
        if RandRange(seed + 740, 1, 100) <= 35 {
            ArrayPush(marks, "Self-defense scarring");
        }
        if RandRange(seed + 750, 1, 100) <= 30 {
            ArrayPush(marks, "Customized baseball bat");
        }
        profile.distinguishingMarks = marks;
        
        // Backstory
        let backstories: array<String>;
        ArrayPush(backstories, "Survived the streets. Moxes offered protection without price. Now protecting others the same way.");
        ArrayPush(backstories, "Worked the clubs before Lizzie's. Saw what happens without protection. Never again - for anyone.");
        ArrayPush(backstories, "Lost someone to traffickers. Joined Moxes to make sure it doesn't happen to others.");
        ArrayPush(backstories, "Former joytoy who fought back. Moxes welcomed and trained. Now a guardian instead of prey.");
        ArrayPush(backstories, "Believed in Lizzie's mission. Her death made it stronger. The cause continues.");
        ArrayPush(backstories, "Outsider who proved dedication. Moxes judge by actions, not background. Found family.");
        ArrayPush(backstories, "Escaped a Tyger Claw operation. Moxes took in, patched up, and gave a bat. Repaying that debt every day.");
        ArrayPush(backstories, "BD editor who saw too many snuff scrolls. Decided to fight the source. Moxes were the only ones who cared.");
        ArrayPush(backstories, "Grew up watching friends disappear into trafficking networks. Moxes were the first to actually do something about it.");
        ArrayPush(backstories, "Former NCPD who quit when brass buried trafficking cases. Found the Moxes actually enforce justice.");
        ArrayPush(backstories, "Transitioned on the streets with no support. Moxes provided safety, medical contacts, and belonging.");
        ArrayPush(backstories, "Bartender at Lizzie's who picked up a weapon when Claws came knocking. Never put it back down.");
        profile.background = backstories[RandRange(seed + 800, 0, ArraySize(backstories) - 1)];
        
        // Recent activity
        let activities: array<String>;
        ArrayPush(activities, "Running security at Lizzie's. Safe space maintained.");
        ArrayPush(activities, "Escort detail for workers. Getting home safe matters.");
        ArrayPush(activities, "Investigating trafficking reports. Predators don't operate in our territory.");
        ArrayPush(activities, "Community self-defense class. Everyone deserves to feel safe.");
        ArrayPush(activities, "BD production oversight. Ethical content, fair compensation.");
        ArrayPush(activities, "Raided a Scav den near Kabuki. Three workers recovered alive.");
        ArrayPush(activities, "Setting up a new safe house. Location classified, need-to-know only.");
        ArrayPush(activities, "Gathering intel on a Tyger Claw trafficking pipeline. Planning intervention.");
        ArrayPush(activities, "Medical supply run for workers without clinic access. No questions asked.");
        ArrayPush(activities, "Coordinating with a fixer on a client who roughed up a joytoy. Justice pending.");
        profile.recentActivity = activities[RandRange(seed + 900, 0, ArraySize(activities) - 1)];
        
        profile.status = GangProfileUtils.GetStatus(seed + 1000);
        
        return profile;
    }

    private static func GetLoyalty(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "NEW"; }
        if roll <= 30 { return "TRUSTED"; }
        if roll <= 60 { return "DEDICATED"; }
        if roll <= 85 { return "DEVOTED"; }
        return "FOUNDING SPIRIT";
    }
}
