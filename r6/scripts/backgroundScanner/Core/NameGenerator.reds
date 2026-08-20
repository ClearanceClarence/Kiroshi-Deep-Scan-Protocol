// Shared Name Generation Utility
// Night City Demographics: American, Hispanic, Japanese, Chinese, Korean, 
// Slavic, Indian, Middle Eastern, African, Southeast Asian, European, Haitian, African American
// 100 names per category per gender = 3,900 total names across 13 ethnicities
// Names delegated to separate files in Core/Names/ for maintainability

public class KdspNameGenerator {

    // ══════════════════════════════════════════════════════════════════════
    // MAIN ENTRY POINTS
    // ══════════════════════════════════════════════════════════════════════

    public static func GenerateFullNameByEthnicity(seed: Int32, gender: String, ethnicity: KdspNPCEthnicity) -> String {
        let firstName = KdspNameGenerator.GetFirstNameByEthnicity(seed, gender, ethnicity);
        let lastName = KdspNameGenerator.GetLastNameByEthnicity(seed + 100, ethnicity);
        return firstName + " " + lastName;
    }

    public static func GetFirstNameByEthnicity(seed: Int32, gender: String, ethnicity: KdspNPCEthnicity) -> String {
        if Equals(gender, "male") {
            return KdspNameGenerator.GetMaleFirstNameByEthnicity(seed, ethnicity);
        }
        return KdspNameGenerator.GetFemaleFirstNameByEthnicity(seed, ethnicity);
    }

    public static func GetRandomGender(seed: Int32) -> String {
        if RandRange(seed, 0, 100) < 50 {
            return "male";
        }
        return "female";
    }

    // ══════════════════════════════════════════════════════════════════════
    // MALE FIRST NAMES BY ETHNICITY
    // ══════════════════════════════════════════════════════════════════════

    public static func GetMaleFirstNameByEthnicity(seed: Int32, ethnicity: KdspNPCEthnicity) -> String {
        switch ethnicity {
            case KdspNPCEthnicity.American:
                return KdspAmericanNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.AfricanAmerican:
                return KdspAfricanAmericanNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Hispanic:
                return KdspHispanicNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Japanese:
                return KdspJapaneseNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Chinese:
                return KdspChineseNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Korean:
                return KdspKoreanNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Slavic:
                return KdspSlavicNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Indian:
                return KdspIndianNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.MiddleEastern:
                return KdspMiddleEasternNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.African:
                return KdspAfricanNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.SoutheastAsian:
                return KdspSoutheastAsianNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.European:
                return KdspEuropeanNames.GetMaleFirstName(seed);
            case KdspNPCEthnicity.Haitian:
                return KdspHaitianNames.GetMaleFirstName(seed);
            default:
                return KdspAmericanNames.GetMaleFirstName(seed);
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    // FEMALE FIRST NAMES BY ETHNICITY
    // ══════════════════════════════════════════════════════════════════════

    public static func GetFemaleFirstNameByEthnicity(seed: Int32, ethnicity: KdspNPCEthnicity) -> String {
        switch ethnicity {
            case KdspNPCEthnicity.American:
                return KdspAmericanNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.AfricanAmerican:
                return KdspAfricanAmericanNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Hispanic:
                return KdspHispanicNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Japanese:
                return KdspJapaneseNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Chinese:
                return KdspChineseNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Korean:
                return KdspKoreanNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Slavic:
                return KdspSlavicNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Indian:
                return KdspIndianNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.MiddleEastern:
                return KdspMiddleEasternNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.African:
                return KdspAfricanNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.SoutheastAsian:
                return KdspSoutheastAsianNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.European:
                return KdspEuropeanNames.GetFemaleFirstName(seed);
            case KdspNPCEthnicity.Haitian:
                return KdspHaitianNames.GetFemaleFirstName(seed);
            default:
                return KdspAmericanNames.GetFemaleFirstName(seed);
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    // LAST NAMES BY ETHNICITY
    // ══════════════════════════════════════════════════════════════════════

    public static func GetLastNameByEthnicity(seed: Int32, ethnicity: KdspNPCEthnicity) -> String {
        switch ethnicity {
            case KdspNPCEthnicity.American:
                return KdspAmericanNames.GetLastName(seed);
            case KdspNPCEthnicity.AfricanAmerican:
                return KdspAfricanAmericanNames.GetLastName(seed);
            case KdspNPCEthnicity.Hispanic:
                return KdspHispanicNames.GetLastName(seed);
            case KdspNPCEthnicity.Japanese:
                return KdspJapaneseNames.GetLastName(seed);
            case KdspNPCEthnicity.Chinese:
                return KdspChineseNames.GetLastName(seed);
            case KdspNPCEthnicity.Korean:
                return KdspKoreanNames.GetLastName(seed);
            case KdspNPCEthnicity.Slavic:
                return KdspSlavicNames.GetLastName(seed);
            case KdspNPCEthnicity.Indian:
                return KdspIndianNames.GetLastName(seed);
            case KdspNPCEthnicity.MiddleEastern:
                return KdspMiddleEasternNames.GetLastName(seed);
            case KdspNPCEthnicity.African:
                return KdspAfricanNames.GetLastName(seed);
            case KdspNPCEthnicity.SoutheastAsian:
                return KdspSoutheastAsianNames.GetLastName(seed);
            case KdspNPCEthnicity.European:
                return KdspEuropeanNames.GetLastName(seed);
            case KdspNPCEthnicity.Haitian:
                return KdspHaitianNames.GetLastName(seed);
            default:
                return KdspAmericanNames.GetLastName(seed);
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    // STREET ALIASES
    // ══════════════════════════════════════════════════════════════════════

    public static func GetStreetAlias(seed: Int32) -> String {
        let i = RandRange(seed, 0, 120);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T0"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T63"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T65"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T1"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T61"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T2"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T3"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T4"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T5"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T6"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T7"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T8"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T9"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T10"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T11"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T12"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T13"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T14"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T15"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T16"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T17"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T18"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T19"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T20"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T21"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T64"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T22"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T23"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T24"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T25"); }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T26"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T27"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T28"); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T29"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T30"); }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T31"); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T32"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T33"); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T34"); }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T35"); }
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T36"); }
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T37"); }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T38"); }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T39"); }
        if i == 44 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T40"); }
        if i == 45 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T41"); }
        if i == 46 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T42"); }
        if i == 47 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T43"); }
        if i == 48 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T44"); }
        if i == 49 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T45"); }
        if i == 50 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T46"); }
        if i == 51 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T47"); }
        if i == 52 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T48"); }
        if i == 53 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T49"); }
        if i == 54 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T50"); }
        if i == 55 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T51"); }
        if i == 56 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T52"); }
        if i == 57 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T53"); }
        if i == 58 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T54"); }
        if i == 59 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T55"); }
        if i == 60 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T56"); }
        if i == 61 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T57"); }
        if i == 62 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T58"); }
        if i == 63 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T59"); }
        if i == 64 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T60"); }
        if i == 65 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T61"); }
        if i == 66 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T62"); }
        if i == 67 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T63"); }
        if i == 68 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T64"); }
        if i == 69 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T65"); }
        if i == 70 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T66"); }
        if i == 71 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T67"); }
        if i == 72 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T68"); }
        if i == 73 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T69"); }
        if i == 74 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T62"); }
        if i == 75 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T70"); }
        if i == 76 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T59"); }
        if i == 77 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T71"); }
        if i == 78 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T72"); }
        if i == 79 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T73"); }
        if i == 80 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T74"); }
        if i == 81 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T75"); }
        if i == 82 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T76"); }
        if i == 83 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T77"); }
        if i == 84 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T78"); }
        if i == 85 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T79"); }
        if i == 86 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T80"); }
        if i == 87 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T81"); }
        if i == 88 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T82"); }
        if i == 89 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T83"); }
        if i == 90 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T84"); }
        if i == 91 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T85"); }
        if i == 92 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T86"); }
        if i == 93 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T87"); }
        if i == 94 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T88"); }
        if i == 95 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T89"); }
        if i == 96 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T90"); }
        if i == 97 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T91"); }
        if i == 98 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T92"); }
        if i == 99 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T93"); }
        if i == 100 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T94"); }
        if i == 101 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T95"); }
        if i == 102 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T96"); }
        if i == 103 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T97"); }
        if i == 104 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T98"); }
        if i == 105 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T99"); }
        if i == 106 { return "\"456\""; }
        if i == 107 { return "\"067\""; }
        if i == 108 { return "\"218\""; }
        if i == 109 { return "\"001\""; }
        if i == 110 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T100"); }
        if i == 111 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T101"); }
        if i == 112 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T102"); }
        if i == 113 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T103"); }
        if i == 114 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T104"); }
        if i == 115 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T105"); }
        if i == 116 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T106"); }
        if i == 117 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T107"); }
        if i == 118 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T108"); }
        if i == 119 { return GetLocalizedTextByKey(n"Kdsp-NameGenerator-T109"); }
        return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T63");
    }
}
