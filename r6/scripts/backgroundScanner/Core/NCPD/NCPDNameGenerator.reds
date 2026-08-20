// NCPD Officer Name Generation System
public class KdspNCPDNameGenerator {

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

    public static func Generate(seed: Int32, appearanceName: String, gender: String, ethnicity: KdspNPCEthnicity) -> ref<KdspNCPDOfficerData> {
        let data: ref<KdspNCPDOfficerData> = new KdspNCPDOfficerData();
        
        // Generate name using shared KdspNameGenerator with correct gender and ethnicity
        data.fullName = KdspNameGenerator.GenerateFullNameByEthnicity(seed, gender, ethnicity);
        
        // Extract last name for radio calls - use ethnicity-aware
        let lastName = KdspNameGenerator.GetLastNameByEthnicity(seed + 100, ethnicity);
        data.lastName = lastName;
        
        // Determine unit type
        if KdspNCPDNameGenerator.IsMaxTac(appearanceName) {
            data.unit = GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T0");
            data.rank = KdspNCPDNameGenerator.GetMaxTacRank(seed + 200);
            data.badge = GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T1") + IntToString(RandRange(seed + 300, 1000, 9999));
            data.specialization = KdspNCPDNameGenerator.GetMaxTacSpecialization(seed + 400);
            data.yearsOfService = RandRange(seed + 500, 5, 20);
            data.confirmedNeutralizations = RandRange(seed + 600, 10, 150);
        } else {
            data.unit = KdspNCPDNameGenerator.GetUnit(seed + 200);
            data.rank = KdspNCPDNameGenerator.GetRank(seed + 250);
            data.badge = KdspNCPDNameGenerator.GetBadgeNumber(seed + 300);
            data.specialization = "";
            data.yearsOfService = RandRange(seed + 500, 1, 25);
            data.confirmedNeutralizations = 0;
        }
        
        // Assignment district
        data.assignedDistrict = KdspNCPDNameGenerator.GetDistrict(seed + 700);
        
        // Service record
        data.commendations = RandRange(seed + 800, 0, 12);
        data.disciplinaryActions = RandRange(seed + 900, 0, 3);
        data.partnerStatus = KdspNCPDNameGenerator.GetPartnerStatus(seed + 1000);
        
        // Status
        data.dutyStatus = KdspNCPDNameGenerator.GetDutyStatus(seed + 1100);
        
        return data;
    }

    private static func GetRank(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 50 { return "Officer"; }
        if roll <= 75 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T2"); }
        if roll <= 88 { return "Sergeant"; }
        if roll <= 95 { return "Lieutenant"; }
        if roll <= 98 { return "Captain"; }
        return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T3");
    }

    private static func GetMaxTacRank(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 40 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T4"); }
        if roll <= 70 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T5"); }
        if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T6"); }
        if roll <= 95 { return "Commander"; }
        return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T7");
    }

    private static func GetUnit(seed: Int32) -> String {
        let units: array<String>;
        
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T8"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T9"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-S0"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T9"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T10"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T11"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T12"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T13"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T14"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T15"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T16"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T17"));
        
        return units[RandRange(seed, 0, ArraySize(units) - 1)];
    }

    private static func GetMaxTacSpecialization(seed: Int32) -> String {
        let specs: array<String>;
        
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T18"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T19"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T20"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T21"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T25"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T8"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T22"));
        ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T23"));
        
        return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
    }

    private static func GetBadgeNumber(seed: Int32) -> String {
        let prefix = "";
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 30 { prefix = "NC-"; }
        else { if roll <= 60 { prefix = GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T24"); }
        else { if roll <= 80 { prefix = GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T25"); }
        else { prefix = ""; }}}
        
        return prefix + IntToString(RandRange(seed + 50, 10000, 99999));
    }

    private static func GetDistrict(seed: Int32) -> String {
        let districts: array<String>;
        
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T26"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T27"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T28"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T29"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T30"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T31"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T15"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-SixthStreetPro-T16"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T18"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T32"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T17"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-TygerClawsProf-T19"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-S1"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T13"));
        ArrayPush(districts, GetLocalizedTextByKey(n"Kdsp-ValentinosProf-T14"));
        
        return districts[RandRange(seed, 0, ArraySize(districts) - 1)];
    }

    private static func GetPartnerStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T33"); }
        if roll <= 80 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T34"); }
        if roll <= 90 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T35"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T36");
    }

    private static func GetDutyStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if roll <= 85 { return "ACTIVE"; }
        if roll <= 92 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T37"); }
        if roll <= 96 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T38"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T39");
    }
}

public class KdspNCPDOfficerData {
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
