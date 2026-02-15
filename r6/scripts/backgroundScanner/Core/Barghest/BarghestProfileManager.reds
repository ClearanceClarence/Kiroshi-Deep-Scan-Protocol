// Barghest Militia Profile Generation System
// Kurt Hansen's private military force in Dogtown
public class KdspBarghestProfileManager {

    public static func IsBarghest(appearanceName: String, gangAffiliation: String) -> Bool {
        return StrContains(appearanceName, "barghest") || Equals(gangAffiliation, "BARGHEST");
    }

    public static func Generate(seed: Int32, appearanceName: String, gender: String, ethnicity: KdspNPCEthnicity) -> ref<KdspBarghestProfileData> {
        let data: ref<KdspBarghestProfileData> = new KdspBarghestProfileData();
        
        // Generate name
        data.fullName = KdspNameGenerator.GenerateFullNameByEthnicity(seed, gender, ethnicity);
        data.callsign = KdspBarghestProfileManager.GenerateCallsign(seed + 50);
        
        // Military background
        data.formerAffiliation = KdspBarghestProfileManager.GetFormerAffiliation(seed + 100);
        data.militaryRank = KdspBarghestProfileManager.GetMilitaryRank(seed + 150, appearanceName);
        data.barghestRank = KdspBarghestProfileManager.GetBarghestRank(seed + 200, appearanceName);
        data.yearsService = RandRange(seed + 250, 2, 15);
        data.yearsBarghest = RandRange(seed + 260, 1, 8);
        
        // Specialization based on unit type
        data.mos = KdspBarghestProfileManager.GetMOS(seed + 300, appearanceName);
        data.combatRole = KdspBarghestProfileManager.GetCombatRole(seed + 350, appearanceName);
        
        // Service record
        data.deployments = RandRange(seed + 400, 1, 12);
        data.confirmedKills = KdspBarghestProfileManager.GetConfirmedKills(seed + 450, data.barghestRank);
        data.commendations = RandRange(seed + 500, 0, 8);
        data.disciplinaryActions = RandRange(seed + 550, 0, 2);
        
        // Status
        data.loyaltyRating = KdspBarghestProfileManager.GetLoyaltyRating(seed + 600);
        data.dutyStatus = KdspBarghestProfileManager.GetDutyStatus(seed + 650);
        data.assignedSector = KdspBarghestProfileManager.GetAssignedSector(seed + 700);
        
        // Background
        data.reasonJoined = KdspBarghestProfileManager.GetReasonJoined(seed + 800);
        data.background = KdspBarghestProfileManager.GenerateBackground(seed + 900, data.formerAffiliation, data.reasonJoined);
        
        return data;
    }

    private static func GenerateCallsign(seed: Int32) -> String {
        let callsigns: array<String>;
        
        ArrayPush(callsigns, "Reaper");
        ArrayPush(callsigns, "Ghost");
        ArrayPush(callsigns, "Viper");
        ArrayPush(callsigns, "Hound");
        ArrayPush(callsigns, "Raven");
        ArrayPush(callsigns, "Wolf");
        ArrayPush(callsigns, "Hawk");
        ArrayPush(callsigns, "Jackal");
        ArrayPush(callsigns, "Cobra");
        ArrayPush(callsigns, "Wraith");
        ArrayPush(callsigns, "Specter");
        ArrayPush(callsigns, "Nomad");
        ArrayPush(callsigns, "Titan");
        ArrayPush(callsigns, "Ronin");
        ArrayPush(callsigns, "Shadow");
        ArrayPush(callsigns, "Striker");
        ArrayPush(callsigns, "Razor");
        ArrayPush(callsigns, "Bishop");
        ArrayPush(callsigns, "Apex");
        ArrayPush(callsigns, "Vandal");
        
        let roll = RandRange(seed, 1, 100);
        if roll <= 40 {
            // 40% chance of having a callsign
            return callsigns[RandRange(seed + 10, 0, ArraySize(callsigns) - 1)];
        }
        return "";
    }

    private static func GetFormerAffiliation(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 35 { return "NUSA Armed Forces"; }
        if roll <= 50 { return "NUSA Army - Deserter"; }
        if roll <= 60 { return "Militech Corporate Security"; }
        if roll <= 70 { return "Private Military Contractor"; }
        if roll <= 78 { return "Arasaka Security (Former)"; }
        if roll <= 84 { return "European Federation Military"; }
        if roll <= 88 { return "SovOil Security Forces"; }
        if roll <= 92 { return "Free State Militia"; }
        if roll <= 96 { return "NCPD (Discharged)"; }
        return "Street Merc";
    }

    private static func GetMilitaryRank(seed: Int32, appearanceName: String) -> String {
        // Check if this is an officer/commander type
        let isOfficer = StrContains(appearanceName, "officer") || StrContains(appearanceName, "commander") || StrContains(appearanceName, "elite");
        
        if isOfficer {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "Captain"; }
            if roll <= 70 { return "Lieutenant"; }
            if roll <= 90 { return "Major"; }
            return "Colonel";
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "Private"; }
            if roll <= 65 { return "Corporal"; }
            if roll <= 85 { return "Sergeant"; }
            if roll <= 95 { return "Staff Sergeant"; }
            return "Master Sergeant";
        }
    }

    private static func GetBarghestRank(seed: Int32, appearanceName: String) -> String {
        let isOfficer = StrContains(appearanceName, "officer") || StrContains(appearanceName, "commander") || StrContains(appearanceName, "elite");
        let isHeavy = StrContains(appearanceName, "heavy") || StrContains(appearanceName, "mech");
        let isSniper = StrContains(appearanceName, "sniper") || StrContains(appearanceName, "recon");
        let isNetrunner = StrContains(appearanceName, "netrunner") || StrContains(appearanceName, "tech");
        
        if isOfficer {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "Squad Leader"; }
            if roll <= 80 { return "Platoon Commander"; }
            if roll <= 95 { return "Company Commander"; }
            return "Hansen's Inner Circle";
        } else if isHeavy {
            return "Heavy Weapons Specialist";
        } else if isSniper {
            return "Recon Specialist";
        } else if isNetrunner {
            return "Combat Netrunner";
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "Trooper"; }
            if roll <= 75 { return "Veteran Trooper"; }
            if roll <= 90 { return "Fire Team Leader"; }
            return "Section Leader";
        }
    }

    private static func GetMOS(seed: Int32, appearanceName: String) -> String {
        if StrContains(appearanceName, "heavy") || StrContains(appearanceName, "mech") {
            let specs: array<String>;
            ArrayPush(specs, "Heavy Weapons (Support Gunner)");
            ArrayPush(specs, "Heavy Weapons (Anti-Armor)");
            ArrayPush(specs, "Mechanized Infantry");
            ArrayPush(specs, "Exosuit Operations");
            return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
        }
        if StrContains(appearanceName, "sniper") || StrContains(appearanceName, "recon") {
            let specs: array<String>;
            ArrayPush(specs, "Scout Sniper");
            ArrayPush(specs, "Reconnaissance");
            ArrayPush(specs, "Forward Observer");
            ArrayPush(specs, "Designated Marksman");
            return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
        }
        if StrContains(appearanceName, "netrunner") || StrContains(appearanceName, "tech") {
            let specs: array<String>;
            ArrayPush(specs, "Combat Netrunner");
            ArrayPush(specs, "Electronic Warfare");
            ArrayPush(specs, "Communications Specialist");
            ArrayPush(specs, "Drone Operations");
            return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
        }
        
        let specs: array<String>;
        ArrayPush(specs, "Infantry (Rifleman)");
        ArrayPush(specs, "Infantry (Grenadier)");
        ArrayPush(specs, "Infantry (Automatic Rifleman)");
        ArrayPush(specs, "Combat Medic");
        ArrayPush(specs, "Combat Engineer");
        ArrayPush(specs, "Vehicle Crew");
        ArrayPush(specs, "Close Quarters Specialist");
        ArrayPush(specs, "Urban Warfare");
        return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
    }

    private static func GetCombatRole(seed: Int32, appearanceName: String) -> String {
        if StrContains(appearanceName, "heavy") { return "Fire Support"; }
        if StrContains(appearanceName, "sniper") { return "Overwatch"; }
        if StrContains(appearanceName, "recon") { return "Reconnaissance"; }
        if StrContains(appearanceName, "netrunner") { return "Electronic Warfare"; }
        if StrContains(appearanceName, "officer") { return "Command"; }
        if StrContains(appearanceName, "mech") { return "Heavy Assault"; }
        
        let roles: array<String>;
        ArrayPush(roles, "Assault Element");
        ArrayPush(roles, "Security Detail");
        ArrayPush(roles, "Patrol");
        ArrayPush(roles, "Checkpoint Operations");
        ArrayPush(roles, "Quick Reaction Force");
        ArrayPush(roles, "Perimeter Defense");
        return roles[RandRange(seed, 0, ArraySize(roles) - 1)];
    }

    private static func GetConfirmedKills(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Hansen's Inner Circle") { return RandRange(seed, 50, 200); }
        if Equals(rank, "Company Commander") { return RandRange(seed, 30, 80); }
        if Equals(rank, "Platoon Commander") { return RandRange(seed, 20, 50); }
        if Equals(rank, "Squad Leader") { return RandRange(seed, 15, 40); }
        if Equals(rank, "Section Leader") { return RandRange(seed, 10, 30); }
        if Equals(rank, "Fire Team Leader") { return RandRange(seed, 8, 25); }
        if Equals(rank, "Veteran Trooper") { return RandRange(seed, 5, 20); }
        if Equals(rank, "Heavy Weapons Specialist") { return RandRange(seed, 10, 40); }
        if Equals(rank, "Recon Specialist") { return RandRange(seed, 8, 35); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyaltyRating(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return "PROBATIONARY"; }
        if roll <= 30 { return "STANDARD"; }
        if roll <= 60 { return "TRUSTED"; }
        if roll <= 85 { return "LOYAL"; }
        if roll <= 95 { return "DEVOTED"; }
        return "HANSEN LOYALIST";
    }

    private static func GetDutyStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 80 { return "ACTIVE"; }
        if roll <= 90 { return "RESERVE"; }
        if roll <= 95 { return "LIGHT DUTY"; }
        return "PENDING REVIEW";
    }

    private static func GetAssignedSector(seed: Int32) -> String {
        let sectors: array<String>;
        ArrayPush(sectors, "Stadium Gate");
        ArrayPush(sectors, "Black Sapphire District");
        ArrayPush(sectors, "Heavy Hearts Club Area");
        ArrayPush(sectors, "EBM Petrochem Perimeter");
        ArrayPush(sectors, "Luxor High Perimeter");
        ArrayPush(sectors, "Terra Cognita Border");
        ArrayPush(sectors, "Growth District Patrol");
        ArrayPush(sectors, "Hansen's HQ Security");
        ArrayPush(sectors, "Checkpoint Alpha");
        ArrayPush(sectors, "Checkpoint Bravo");
        ArrayPush(sectors, "Mobile Response Unit");
        ArrayPush(sectors, "Supply Depot Guard");
        return sectors[RandRange(seed, 0, ArraySize(sectors) - 1)];
    }

    private static func GetReasonJoined(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 20 { return "DESERTER"; }
        if roll <= 35 { return "DISCHARGED"; }
        if roll <= 50 { return "MERCENARY"; }
        if roll <= 60 { return "IDEOLOGICAL"; }
        if roll <= 70 { return "REFUGEE"; }
        if roll <= 80 { return "CRIMINAL_PAST"; }
        if roll <= 90 { return "ECONOMIC"; }
        return "RECRUITED";
    }

    private static func GenerateBackground(seed: Int32, formerAffiliation: String, reason: String) -> String {
        let backgrounds: array<String>;
        
        if Equals(reason, "DESERTER") {
            ArrayPush(backgrounds, "Deserted during the Unification War. Found purpose in Hansen's vision for Dogtown.");
            ArrayPush(backgrounds, "Went AWOL after refusing illegal orders. NUSA wants them back - dead or alive.");
            ArrayPush(backgrounds, "Fled unit after friendly fire incident. Haunted but effective.");
        } else if Equals(reason, "DISCHARGED") {
            ArrayPush(backgrounds, "Dishonorably discharged for excessive force. Hansen appreciates the aggression.");
            ArrayPush(backgrounds, "Medical discharge after severe injuries. Cyberware got them back in the fight.");
            ArrayPush(backgrounds, "Discharged for insubordination. Follows Hansen's orders without question now.");
        } else if Equals(reason, "MERCENARY") {
            ArrayPush(backgrounds, "Professional soldier for hire. Hansen pays well and on time.");
            ArrayPush(backgrounds, "Former PMC operator. Tired of corpo politics, prefers Hansen's direct approach.");
            ArrayPush(backgrounds, "Freelance military contractor. Dogtown offers steady work and no questions.");
        } else if Equals(reason, "IDEOLOGICAL") {
            ArrayPush(backgrounds, "True believer in Hansen's free Dogtown. Would die for the cause.");
            ArrayPush(backgrounds, "Hates NUSA government. Sees Barghest as freedom fighters.");
            ArrayPush(backgrounds, "Believes corporations are the enemy. Hansen offers a different path.");
        } else if Equals(reason, "REFUGEE") {
            ArrayPush(backgrounds, "Fled war-torn region. Found new home and purpose with Barghest.");
            ArrayPush(backgrounds, "Family killed in corporate conflict. Barghest is their only family now.");
            ArrayPush(backgrounds, "Escaped corpo black site. Hansen gave them shelter and a gun.");
        } else if Equals(reason, "CRIMINAL_PAST") {
            ArrayPush(backgrounds, "Wanted in multiple jurisdictions. Dogtown offers sanctuary.");
            ArrayPush(backgrounds, "Former gang soldier. Barghest offered legitimacy and better pay.");
            ArrayPush(backgrounds, "Escaped convict. Hansen doesn't care about the past, only loyalty.");
        } else if Equals(reason, "ECONOMIC") {
            ArrayPush(backgrounds, "Couldn't find work after military service. Barghest was the only option.");
            ArrayPush(backgrounds, "Family needed money for medical care. Barghest pays well for combat skills.");
            ArrayPush(backgrounds, "Debt drove them to mercenary work. Hansen cleared the debt for service.");
        } else {
            ArrayPush(backgrounds, "Recruited directly by Barghest scouts. Skills speak for themselves.");
            ArrayPush(backgrounds, "Impressed Hansen during a firefight. Got an offer they couldn't refuse.");
            ArrayPush(backgrounds, "Recommended by another Barghest veteran. Loyalty vouched for.");
        }
        
        // Add former affiliation context
        if StrContains(formerAffiliation, "NUSA") {
            ArrayPush(backgrounds, "Former NUSA soldier who saw too much corruption. Hansen's truth resonated.");
        }
        if StrContains(formerAffiliation, "Militech") {
            ArrayPush(backgrounds, "Ex-Militech operative. Left after being treated as expendable. Hansen values soldiers.");
        }
        if StrContains(formerAffiliation, "Arasaka") {
            ArrayPush(backgrounds, "Former Arasaka security. Tower attack changed everything. Found new purpose.");
        }
        
        return backgrounds[RandRange(seed, 0, ArraySize(backgrounds) - 1)];
    }

    public static func FormatServiceRecord(data: ref<KdspBarghestProfileData>) -> String {
        let record = "";
        
        if NotEquals(data.callsign, "") {
            record = data.barghestRank + " \"" + data.callsign + "\"";
        } else {
            record = data.barghestRank;
        }
        
        record += " | MOS: " + data.mos;
        record += " | " + IntToString(data.yearsBarghest) + " yrs Barghest";
        record += " | Prior: " + data.formerAffiliation;
        record += " | Sector: " + data.assignedSector;
        record += " | Status: " + data.dutyStatus;
        
        return record;
    }
}

public class KdspBarghestProfileData {
    public let fullName: String;
    public let callsign: String;
    public let formerAffiliation: String;
    public let militaryRank: String;
    public let barghestRank: String;
    public let yearsService: Int32;
    public let yearsBarghest: Int32;
    public let mos: String;
    public let combatRole: String;
    public let deployments: Int32;
    public let confirmedKills: Int32;
    public let commendations: Int32;
    public let disciplinaryActions: Int32;
    public let loyaltyRating: String;
    public let dutyStatus: String;
    public let assignedSector: String;
    public let reasonJoined: String;
    public let background: String;
}
