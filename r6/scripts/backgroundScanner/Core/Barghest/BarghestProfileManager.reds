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
        
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T0"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T1"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T2"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T3"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T4"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T5"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T6"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T7"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T8"));
        ArrayPush(callsigns, "Wraith");
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T9"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T10"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T11"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T12"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T13"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T14"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T15"));
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T16"));
        ArrayPush(callsigns, "Apex");
        ArrayPush(callsigns, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T17"));
        
        let roll = RandRange(seed, 1, 100);
        if roll <= 40 {
            // 40% chance of having a callsign
            return callsigns[RandRange(seed + 10, 0, ArraySize(callsigns) - 1)];
        }
        return "";
    }

    private static func GetFormerAffiliation(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 35 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S0"); }
        if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S1"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S2"); }
        if roll <= 70 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S3"); }
        if roll <= 78 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S4"); }
        if roll <= 84 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S5"); }
        if roll <= 88 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S6"); }
        if roll <= 92 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S7"); }
        if roll <= 96 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T18"); }
        return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T19");
    }

    private static func GetMilitaryRank(seed: Int32, appearanceName: String) -> String {
        // Check if this is an officer/commander type
        let isOfficer = StrContains(appearanceName, "officer") || StrContains(appearanceName, "commander") || StrContains(appearanceName, "elite");
        
        if isOfficer {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "Captain"; }
            if roll <= 70 { return "Lieutenant"; }
            if roll <= 90 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T20"); }
            return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T21");
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T22"); }
            if roll <= 65 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T23"); }
            if roll <= 85 { return "Sergeant"; }
            if roll <= 95 { return GetLocalizedTextByKey(n"Kdsp-Shared-C9"); }
            return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T24");
        }
    }

    private static func GetBarghestRank(seed: Int32, appearanceName: String) -> String {
        let isOfficer = StrContains(appearanceName, "officer") || StrContains(appearanceName, "commander") || StrContains(appearanceName, "elite");
        let isHeavy = StrContains(appearanceName, "heavy") || StrContains(appearanceName, "mech");
        let isSniper = StrContains(appearanceName, "sniper") || StrContains(appearanceName, "recon");
        let isNetrunner = StrContains(appearanceName, "netrunner") || StrContains(appearanceName, "tech");
        
        if isOfficer {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-Shared-C12"); }
            if roll <= 80 { return GetLocalizedTextByKey(n"Kdsp-Shared-C7"); }
            if roll <= 95 { return GetLocalizedTextByKey(n"Kdsp-Shared-C10"); }
            return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S8");
        } else if isHeavy {
            return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S9");
        } else if isSniper {
            return GetLocalizedTextByKey(n"Kdsp-Shared-C11");
        } else if isNetrunner {
            return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T25");
        } else {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T26"); }
            if roll <= 75 { return GetLocalizedTextByKey(n"Kdsp-Shared-C8"); }
            if roll <= 90 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S10"); }
            return GetLocalizedTextByKey(n"Kdsp-Shared-C13");
        }
    }

    private static func GetMOS(seed: Int32, appearanceName: String) -> String {
        if StrContains(appearanceName, "heavy") || StrContains(appearanceName, "mech") {
            let specs: array<String>;
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S11"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S12"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T27"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T28"));
            return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
        }
        if StrContains(appearanceName, "sniper") || StrContains(appearanceName, "recon") {
            let specs: array<String>;
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T29"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T30"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T31"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T32"));
            return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
        }
        if StrContains(appearanceName, "netrunner") || StrContains(appearanceName, "tech") {
            let specs: array<String>;
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T25"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T33"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T34"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T35"));
            return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
        }
        
        let specs: array<String>;
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T36"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T37"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S13"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T38"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T39"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T40"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S14"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T41"));
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
        ArrayPush(roles, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T42"));
        ArrayPush(roles, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T43"));
        ArrayPush(roles, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T44"));
        ArrayPush(roles, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T45"));
        ArrayPush(roles, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S15"));
        ArrayPush(roles, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T46"));
        return roles[RandRange(seed, 0, ArraySize(roles) - 1)];
    }

    private static func GetConfirmedKills(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Hansen's Inner Circle") { return RandRange(seed, 50, 200); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C10")) { return RandRange(seed, 30, 80); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C7")) { return RandRange(seed, 20, 50); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C12")) { return RandRange(seed, 15, 40); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C13")) { return RandRange(seed, 10, 30); }
        if Equals(rank, "Fire Team Leader") { return RandRange(seed, 8, 25); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C8")) { return RandRange(seed, 5, 20); }
        if Equals(rank, "Heavy Weapons Specialist") { return RandRange(seed, 10, 40); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C11")) { return RandRange(seed, 8, 35); }
        return RandRange(seed, 0, 15);
    }

    private static func GetLoyaltyRating(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T47"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T48"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T49"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T50"); }
        if roll <= 95 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T51"); }
        return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T52");
    }

    private static func GetDutyStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 80 { return "ACTIVE"; }
        if roll <= 90 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T53"); }
        if roll <= 95 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T54"); }
        return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T55");
    }

    private static func GetAssignedSector(seed: Int32) -> String {
        let sectors: array<String>;
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T56"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S16"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S17"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S18"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S19"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S20"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S21"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S22"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T57"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T58"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S23"));
        ArrayPush(sectors, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S24"));
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
        return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T59");
    }

    private static func GenerateBackground(seed: Int32, formerAffiliation: String, reason: String) -> String {
        let backgrounds: array<String>;
        
        if Equals(reason, "DESERTER") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S25"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S26"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S27"));
        } else if Equals(reason, "DISCHARGED") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S28"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S29"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S30"));
        } else if Equals(reason, "MERCENARY") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S31"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S32"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S33"));
        } else if Equals(reason, "IDEOLOGICAL") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S34"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S35"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S36"));
        } else if Equals(reason, "REFUGEE") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S37"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S38"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S39"));
        } else if Equals(reason, "CRIMINAL_PAST") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S40"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S41"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S42"));
        } else if Equals(reason, "ECONOMIC") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S43"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S44"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S45"));
        } else {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S46"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S47"));
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S48"));
        }
        
        // Add former affiliation context
        if StrContains(formerAffiliation, "NUSA") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S49"));
        }
        if StrContains(formerAffiliation, "Militech") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S50"));
        }
        if StrContains(formerAffiliation, "Arasaka") {
            ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-S51"));
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
        
        record += GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T31") + data.mos;
        record += " | " + IntToString(data.yearsBarghest) + GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S127");
        record += GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S117") + data.formerAffiliation;
        record += GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S126") + data.assignedSector;
        record += GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S91") + data.dutyStatus;
        
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
