// Shared Name Generation Utility - MODULAR v1.6.2
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
        if i == 0 { return "\"Razor\""; }
        if i == 1 { return "\"Ghost\""; }
        if i == 2 { return "\"Neon\""; }
        if i == 3 { return "\"Spike\""; }
        if i == 4 { return "\"Chrome\""; }
        if i == 5 { return "\"Bullet\""; }
        if i == 6 { return "\"Zero\""; }
        if i == 7 { return "\"Glitch\""; }
        if i == 8 { return "\"Snake\""; }
        if i == 9 { return "\"Ice\""; }
        if i == 10 { return "\"Wire\""; }
        if i == 11 { return "\"Shadow\""; }
        if i == 12 { return "\"Byte\""; }
        if i == 13 { return "\"Torch\""; }
        if i == 14 { return "\"Venom\""; }
        if i == 15 { return "\"Blade\""; }
        if i == 16 { return "\"Cipher\""; }
        if i == 17 { return "\"Hex\""; }
        if i == 18 { return "\"Rogue\""; }
        if i == 19 { return "\"Nova\""; }
        if i == 20 { return "\"Blaze\""; }
        if i == 21 { return "\"Pixel\""; }
        if i == 22 { return "\"Crash\""; }
        if i == 23 { return "\"Static\""; }
        if i == 24 { return "\"Null\""; }
        if i == 25 { return "\"Switchblade\""; }
        if i == 26 { return "\"Trigger\""; }
        if i == 27 { return "\"Hammer\""; }
        if i == 28 { return "\"Shiv\""; }
        if i == 29 { return "\"Crowbar\""; }
        if i == 30 { return "\"Cleaver\""; }
        if i == 31 { return "\"Mantis\""; }
        if i == 32 { return "\"Gorilla\""; }
        if i == 33 { return "\"Fist\""; }
        if i == 34 { return "\"Knuckles\""; }
        if i == 35 { return "\"Breaker\""; }
        if i == 36 { return "\"Crusher\""; }
        if i == 37 { return "\"Virus\""; }
        if i == 38 { return "\"Daemon\""; }
        if i == 39 { return "\"Root\""; }
        if i == 40 { return "\"Trojan\""; }
        if i == 41 { return "\"Firewall\""; }
        if i == 42 { return "\"Proxy\""; }
        if i == 43 { return "\"Protocol\""; }
        if i == 44 { return "\"Binary\""; }
        if i == 45 { return "\"Ping\""; }
        if i == 46 { return "\"Buffer\""; }
        if i == 47 { return "\"Node\""; }
        if i == 48 { return "\"Patch\""; }
        if i == 49 { return "\"Scorpion\""; }
        if i == 50 { return "\"Panther\""; }
        if i == 51 { return "\"Viper\""; }
        if i == 52 { return "\"Jackal\""; }
        if i == 53 { return "\"Cobra\""; }
        if i == 54 { return "\"Hawk\""; }
        if i == 55 { return "\"Wolf\""; }
        if i == 56 { return "\"Tiger\""; }
        if i == 57 { return "\"Spider\""; }
        if i == 58 { return "\"Shark\""; }
        if i == 59 { return "\"Raven\""; }
        if i == 60 { return "\"Crow\""; }
        if i == 61 { return "\"Scar\""; }
        if i == 62 { return "\"One-Eye\""; }
        if i == 63 { return "\"Ink\""; }
        if i == 64 { return "\"Slim\""; }
        if i == 65 { return "\"Tank\""; }
        if i == 66 { return "\"Giant\""; }
        if i == 67 { return "\"Tiny\""; }
        if i == 68 { return "\"Red\""; }
        if i == 69 { return "\"Silver\""; }
        if i == 70 { return "\"Smokey\""; }
        if i == 71 { return "\"Mad Dog\""; }
        if i == 72 { return "\"Psycho\""; }
        if i == 73 { return "\"Joker\""; }
        if i == 74 { return "\"Lucky\""; }
        if i == 75 { return "\"Silent\""; }
        if i == 76 { return "\"Whisper\""; }
        if i == 77 { return "\"Twitch\""; }
        if i == 78 { return "\"Quick\""; }
        if i == 79 { return "\"Smooth\""; }
        if i == 80 { return "\"Thunder\""; }
        if i == 81 { return "\"Lightning\""; }
        if i == 82 { return "\"Frost\""; }
        if i == 83 { return "\"Ember\""; }
        if i == 84 { return "\"Ash\""; }
        if i == 85 { return "\"Stone\""; }
        if i == 86 { return "\"Iron\""; }
        if i == 87 { return "\"Steel\""; }
        if i == 88 { return "\"Acid\""; }
        if i == 89 { return "\"Toxic\""; }
        if i == 90 { return "\"Doc\""; }
        if i == 91 { return "\"Chef\""; }
        if i == 92 { return "\"Preacher\""; }
        if i == 93 { return "\"King\""; }
        if i == 94 { return "\"Duke\""; }
        if i == 95 { return "\"Boss\""; }
        if i == 96 { return "\"Merc\""; }
        if i == 97 { return "\"Fixer\""; }
        if i == 98 { return "\"Runner\""; }
        if i == 99 { return "\"Choom\""; }
        if i == 100 { return "\"Gonk\""; }
        if i == 101 { return "\"Preem\""; }
        if i == 102 { return "\"Delta\""; }
        if i == 103 { return "\"Flatline\""; }
        if i == 104 { return "\"Corpo\""; }
        if i == 105 { return "\"Badge\""; }
        if i == 106 { return "\"456\""; }
        if i == 107 { return "\"067\""; }
        if i == 108 { return "\"218\""; }
        if i == 109 { return "\"001\""; }
        if i == 110 { return "\"Front Man\""; }
        if i == 111 { return "\"Six\""; }
        if i == 112 { return "\"Seven\""; }
        if i == 113 { return "\"Ace\""; }
        if i == 114 { return "\"Solo\""; }
        if i == 115 { return "\"Prime\""; }
        if i == 116 { return "\"Omega\""; }
        if i == 117 { return "\"Alpha\""; }
        if i == 118 { return "\"X\""; }
        if i == 119 { return "\"Reaper\""; }
        return "\"Ghost\"";
    }
}
