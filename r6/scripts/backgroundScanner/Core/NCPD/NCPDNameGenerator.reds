// NCPD Officer Name Generation System
public class NCPDNameGenerator {

    public static func IsNCPD(appearanceName: String) -> Bool {
        if StrContains(appearanceName, "ncpd") || StrContains(appearanceName, "police") || StrContains(appearanceName, "cop") {
            return true;
        }
        if StrContains(appearanceName, "officer") || StrContains(appearanceName, "patrol") {
            return true;
        }
        if StrContains(appearanceName, "maxtac") || StrContains(appearanceName, "max_tac") {
            return true;
        }
        return false;
    }

    public static func IsMaxTac(appearanceName: String) -> Bool {
        if StrContains(appearanceName, "maxtac") || StrContains(appearanceName, "max_tac") {
            return true;
        }
        return false;
    }

    public static func Generate(seed: Int32, appearanceName: String, gender: String, ethnicity: NPCEthnicity) -> ref<NCPDOfficerData> {
        let data: ref<NCPDOfficerData> = new NCPDOfficerData();
        
        // Generate name using shared NameGenerator with correct gender and ethnicity
        data.fullName = NameGenerator.GenerateFullNameByEthnicity(seed, gender, ethnicity);
        
        // Extract last name for radio calls - use ethnicity-aware
        let lastName = NameGenerator.GetLastNameByEthnicity(seed + 100, ethnicity);
        data.lastName = lastName;
        
        // Determine unit type
        if NCPDNameGenerator.IsMaxTac(appearanceName) {
            data.unit = "MAX-TAC";
            data.rank = NCPDNameGenerator.GetMaxTacRank(seed + 200);
            data.badge = "MT-" + IntToString(RandRange(seed + 300, 1000, 9999));
            data.specialization = NCPDNameGenerator.GetMaxTacSpecialization(seed + 400);
            data.yearsOfService = RandRange(seed + 500, 5, 20);
            data.confirmedNeutralizations = RandRange(seed + 600, 10, 150);
        } else {
            data.unit = NCPDNameGenerator.GetUnit(seed + 200);
            data.rank = NCPDNameGenerator.GetRank(seed + 250);
            data.badge = NCPDNameGenerator.GetBadgeNumber(seed + 300);
            data.specialization = "";
            data.yearsOfService = RandRange(seed + 500, 1, 25);
            data.confirmedNeutralizations = 0;
        }
        
        // Assignment district
        data.assignedDistrict = NCPDNameGenerator.GetDistrict(seed + 700);
        
        // Service record
        data.commendations = RandRange(seed + 800, 0, 12);
        data.disciplinaryActions = RandRange(seed + 900, 0, 3);
        data.partnerStatus = NCPDNameGenerator.GetPartnerStatus(seed + 1000);
        
        // Status
        data.dutyStatus = NCPDNameGenerator.GetDutyStatus(seed + 1100);
        
        return data;
    }

    private static func GetRank(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 50 { return "Officer"; }
        if roll <= 75 { return "Senior Officer"; }
        if roll <= 88 { return "Sergeant"; }
        if roll <= 95 { return "Lieutenant"; }
        if roll <= 98 { return "Captain"; }
        return "Inspector";
    }

    private static func GetMaxTacRank(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 40 { return "Operative"; }
        if roll <= 70 { return "Senior Operative"; }
        if roll <= 85 { return "Team Lead"; }
        if roll <= 95 { return "Commander"; }
        return "Division Chief";
    }

    private static func GetUnit(seed: Int32) -> String {
        let units: array<String>;
        
        ArrayPush(units, "Patrol Division");
        ArrayPush(units, "Street Enforcement");
        ArrayPush(units, "Gang Task Force");
        ArrayPush(units, "Traffic Division");
        ArrayPush(units, "Cybercrimes Unit");
        ArrayPush(units, "Homicide Division");
        ArrayPush(units, "Vice Squad");
        ArrayPush(units, "Organized Crime");
        ArrayPush(units, "Riot Control");
        ArrayPush(units, "Harbor Patrol");
        ArrayPush(units, "Air Support");
        ArrayPush(units, "K-9 Unit");
        
        return units[RandRange(seed, 0, ArraySize(units) - 1)];
    }

    private static func GetMaxTacSpecialization(seed: Int32) -> String {
        let specs: array<String>;
        
        ArrayPush(specs, "Cyberpsycho Containment");
        ArrayPush(specs, "Heavy Assault");
        ArrayPush(specs, "Tactical Sniper");
        ArrayPush(specs, "Breach Specialist");
        ArrayPush(specs, "Combat Netrunner");
        ArrayPush(specs, "Demolitions");
        ArrayPush(specs, "Close Quarters");
        ArrayPush(specs, "Recon/Intel");
        
        return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
    }

    private static func GetBadgeNumber(seed: Int32) -> String {
        let prefix = "";
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 30 { prefix = "NC-"; }
        else { if roll <= 60 { prefix = "P-"; }
        else { if roll <= 80 { prefix = "NCP-"; }
        else { prefix = ""; }}}
        
        return prefix + IntToString(RandRange(seed + 50, 10000, 99999));
    }

    private static func GetDistrict(seed: Int32) -> String {
        let districts: array<String>;
        
        ArrayPush(districts, "Watson");
        ArrayPush(districts, "Westbrook");
        ArrayPush(districts, "City Center");
        ArrayPush(districts, "Heywood");
        ArrayPush(districts, "Pacifica");
        ArrayPush(districts, "Santo Domingo");
        ArrayPush(districts, "Arroyo");
        ArrayPush(districts, "Rancho Coronado");
        ArrayPush(districts, "Kabuki");
        ArrayPush(districts, "Little China");
        ArrayPush(districts, "Japantown");
        ArrayPush(districts, "Charter Hill");
        ArrayPush(districts, "Vista Del Rey");
        ArrayPush(districts, "The Glen");
        ArrayPush(districts, "Wellsprings");
        
        return districts[RandRange(seed, 0, ArraySize(districts) - 1)];
    }

    private static func GetPartnerStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 60 { return "Partnered"; }
        if roll <= 80 { return "Solo Patrol"; }
        if roll <= 90 { return "Partner KIA"; }
        return "Awaiting Assignment";
    }

    private static func GetDutyStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 85 { return "ACTIVE"; }
        if roll <= 92 { return "ADMINISTRATIVE"; }
        if roll <= 96 { return "MEDICAL LEAVE"; }
        return "DISCIPLINARY REVIEW";
    }
}

public class NCPDOfficerData {
    public let fullName: String;
    public let lastName: String;
    public let rank: String;
    public let badge: String;
    public let unit: String;
    public let specialization: String;
    public let assignedDistrict: String;
    public let yearsOfService: Int32;
    public let commendations: Int32;
    public let disciplinaryActions: Int32;
    public let partnerStatus: String;
    public let dutyStatus: String;
    public let confirmedNeutralizations: Int32;
}
