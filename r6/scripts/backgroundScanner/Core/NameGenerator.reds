// Shared Name Generation Utility
// Night City Demographics: American, Hispanic, Japanese, Chinese, Korean, 
// Slavic, Indian, Middle Eastern, African, Southeast Asian, European
public class NameGenerator {

    // ══════════════════════════════════════════════════════════════════════
    // MAIN ENTRY POINTS - ETHNICITY AWARE
    // ══════════════════════════════════════════════════════════════════════

    // Generate full name matching ethnicity
    public static func GenerateFullNameByEthnicity(seed: Int32, gender: String, ethnicity: NPCEthnicity) -> String {
        let firstName = NameGenerator.GetFirstNameByEthnicity(seed, gender, ethnicity);
        let lastName = NameGenerator.GetLastNameByEthnicity(seed + 100, ethnicity);
        return firstName + " " + lastName;
    }

    // Get first name by ethnicity
    public static func GetFirstNameByEthnicity(seed: Int32, gender: String, ethnicity: NPCEthnicity) -> String {
        if Equals(gender, "male") {
            return NameGenerator.GetMaleFirstNameByEthnicity(seed, ethnicity);
        } else {
            return NameGenerator.GetFemaleFirstNameByEthnicity(seed, ethnicity);
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    // LEGACY FUNCTIONS - Random from all pools (backward compatibility)
    // ══════════════════════════════════════════════════════════════════════

    public static func GenerateFullName(seed: Int32, gender: String) -> String {
        let firstName = NameGenerator.GetFirstName(seed, gender);
        let lastName = NameGenerator.GetLastName(seed + 100);
        return firstName + " " + lastName;
    }

    public static func GetFirstName(seed: Int32, gender: String) -> String {
        if Equals(gender, "male") {
            return NameGenerator.GetMaleFirstName(seed);
        } else {
            return NameGenerator.GetFemaleFirstName(seed);
        }
    }

    // Random gender for NPCs where we don't know
    public static func GetRandomGender(seed: Int32) -> String {
        if RandRange(seed, 0, 100) < 50 {
            return "male";
        }
        return "female";
    }

    // ══════════════════════════════════════════════════════════════════════
    // MALE FIRST NAMES BY ETHNICITY
    // ══════════════════════════════════════════════════════════════════════

    public static func GetMaleFirstNameByEthnicity(seed: Int32, ethnicity: NPCEthnicity) -> String {
        switch ethnicity {
            case NPCEthnicity.American:
                return NameGenerator.GetMaleAmericanNames(seed);
            case NPCEthnicity.AfricanAmerican:
                return NameGenerator.GetMaleAfricanAmericanNames(seed);
            case NPCEthnicity.Hispanic:
                return NameGenerator.GetMaleHispanicNames(seed);
            case NPCEthnicity.Japanese:
                return NameGenerator.GetMaleJapaneseNames(seed);
            case NPCEthnicity.Chinese:
                return NameGenerator.GetMaleChineseNames(seed);
            case NPCEthnicity.Korean:
                return NameGenerator.GetMaleKoreanNames(seed);
            case NPCEthnicity.Slavic:
                return NameGenerator.GetMaleSlavicNames(seed);
            case NPCEthnicity.Indian:
                return NameGenerator.GetMaleIndianNames(seed);
            case NPCEthnicity.MiddleEastern:
                return NameGenerator.GetMaleMiddleEasternNames(seed);
            case NPCEthnicity.African:
                return NameGenerator.GetMaleAfricanNames(seed);
            case NPCEthnicity.SoutheastAsian:
                return NameGenerator.GetMaleSoutheastAsianNames(seed);
            case NPCEthnicity.European:
                return NameGenerator.GetMaleEuropeanNames(seed);
            case NPCEthnicity.Haitian:
                return NameGenerator.GetMaleHaitianNames(seed);
            default:
                return NameGenerator.GetMaleFirstName(seed);
        }
    }

    private static func GetMaleAmericanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Marcus");
        ArrayPush(names, "James");
        ArrayPush(names, "Robert");
        ArrayPush(names, "Michael");
        ArrayPush(names, "David");
        ArrayPush(names, "William");
        ArrayPush(names, "Thomas");
        ArrayPush(names, "Daniel");
        ArrayPush(names, "Kevin");
        ArrayPush(names, "Brandon");
        ArrayPush(names, "Tyler");
        ArrayPush(names, "Derek");
        ArrayPush(names, "Ryan");
        ArrayPush(names, "Jason");
        ArrayPush(names, "Kyle");
        ArrayPush(names, "Trevor");
        ArrayPush(names, "Nathan");
        ArrayPush(names, "Sean");
        ArrayPush(names, "Brian");
        ArrayPush(names, "Eric");
        ArrayPush(names, "Adam");
        ArrayPush(names, "Justin");
        ArrayPush(names, "Cody");
        ArrayPush(names, "Aaron");
        ArrayPush(names, "Jake");
        ArrayPush(names, "Zach");
        ArrayPush(names, "Travis");
        ArrayPush(names, "Blake");
        ArrayPush(names, "Shane");
        ArrayPush(names, "Ethan");
        ArrayPush(names, "Matt");
        ArrayPush(names, "Chris");
        ArrayPush(names, "Steve");
        ArrayPush(names, "Jeff");
        ArrayPush(names, "Scott");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleAfricanAmericanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Jerome");
        ArrayPush(names, "Deshawn");
        ArrayPush(names, "Jamal");
        ArrayPush(names, "Tyrone");
        ArrayPush(names, "Darius");
        ArrayPush(names, "DeAndre");
        ArrayPush(names, "Terrell");
        ArrayPush(names, "Lamar");
        ArrayPush(names, "Marquis");
        ArrayPush(names, "Dante");
        ArrayPush(names, "Malik");
        ArrayPush(names, "Andre");
        ArrayPush(names, "Kareem");
        ArrayPush(names, "Rashid");
        ArrayPush(names, "Kwame");
        ArrayPush(names, "Dwayne");
        ArrayPush(names, "Tyrell");
        ArrayPush(names, "Jermaine");
        ArrayPush(names, "Leroy");
        ArrayPush(names, "Marcus");
        ArrayPush(names, "Antoine");
        ArrayPush(names, "Cedric");
        ArrayPush(names, "Denzel");
        ArrayPush(names, "Trevon");
        ArrayPush(names, "Jaylon");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleHispanicNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Carlos");
        ArrayPush(names, "Antonio");
        ArrayPush(names, "Miguel");
        ArrayPush(names, "Alejandro");
        ArrayPush(names, "Jorge");
        ArrayPush(names, "Diego");
        ArrayPush(names, "Raul");
        ArrayPush(names, "Javier");
        ArrayPush(names, "Roberto");
        ArrayPush(names, "Fernando");
        ArrayPush(names, "Ricardo");
        ArrayPush(names, "Eduardo");
        ArrayPush(names, "Luis");
        ArrayPush(names, "Hector");
        ArrayPush(names, "Oscar");
        ArrayPush(names, "Rafael");
        ArrayPush(names, "Pablo");
        ArrayPush(names, "Sergio");
        ArrayPush(names, "Enrique");
        ArrayPush(names, "Manuel");
        ArrayPush(names, "Arturo");
        ArrayPush(names, "Julio");
        ArrayPush(names, "Gabriel");
        ArrayPush(names, "Francisco");
        ArrayPush(names, "Armando");
        ArrayPush(names, "Cesar");
        ArrayPush(names, "Ramiro");
        ArrayPush(names, "Ignacio");
        ArrayPush(names, "Esteban");
        ArrayPush(names, "Mateo");
        ArrayPush(names, "Angel");
        ArrayPush(names, "Jesus");
        ArrayPush(names, "Pedro");
        ArrayPush(names, "Juan");
        ArrayPush(names, "Jose");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleJapaneseNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Takeshi");
        ArrayPush(names, "Hiroshi");
        ArrayPush(names, "Kenji");
        ArrayPush(names, "Ryu");
        ArrayPush(names, "Shinji");
        ArrayPush(names, "Kazuo");
        ArrayPush(names, "Akira");
        ArrayPush(names, "Daichi");
        ArrayPush(names, "Yuto");
        ArrayPush(names, "Haruki");
        ArrayPush(names, "Ren");
        ArrayPush(names, "Kaito");
        ArrayPush(names, "Sora");
        ArrayPush(names, "Hayato");
        ArrayPush(names, "Kenta");
        ArrayPush(names, "Masaru");
        ArrayPush(names, "Shin");
        ArrayPush(names, "Tetsuya");
        ArrayPush(names, "Hideki");
        ArrayPush(names, "Noboru");
        ArrayPush(names, "Taro");
        ArrayPush(names, "Koji");
        ArrayPush(names, "Ichiro");
        ArrayPush(names, "Goro");
        ArrayPush(names, "Kenichi");
        ArrayPush(names, "Saburo");
        ArrayPush(names, "Yoshi");
        ArrayPush(names, "Hideo");
        ArrayPush(names, "Makoto");
        ArrayPush(names, "Satoshi");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleChineseNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Wei");
        ArrayPush(names, "Jun");
        ArrayPush(names, "Feng");
        ArrayPush(names, "Lei");
        ArrayPush(names, "Hao");
        ArrayPush(names, "Jian");
        ArrayPush(names, "Ming");
        ArrayPush(names, "Tao");
        ArrayPush(names, "Bo");
        ArrayPush(names, "Cheng");
        ArrayPush(names, "Long");
        ArrayPush(names, "Xiang");
        ArrayPush(names, "Yong");
        ArrayPush(names, "Zhen");
        ArrayPush(names, "Hui");
        ArrayPush(names, "Qiang");
        ArrayPush(names, "Liang");
        ArrayPush(names, "Kun");
        ArrayPush(names, "Dong");
        ArrayPush(names, "Gang");
        ArrayPush(names, "Peng");
        ArrayPush(names, "Jie");
        ArrayPush(names, "Bing");
        ArrayPush(names, "Hai");
        ArrayPush(names, "Lin");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleKoreanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Jin-ho");
        ArrayPush(names, "Sung");
        ArrayPush(names, "Min-jun");
        ArrayPush(names, "Jae-won");
        ArrayPush(names, "Hyun");
        ArrayPush(names, "Seung");
        ArrayPush(names, "Tae-hyun");
        ArrayPush(names, "Dong-woo");
        ArrayPush(names, "Soo-hyun");
        ArrayPush(names, "Ji-hoon");
        ArrayPush(names, "Woo-jin");
        ArrayPush(names, "Kyung");
        ArrayPush(names, "Sang-hoon");
        ArrayPush(names, "Yong-jun");
        ArrayPush(names, "Dae-jung");
        // Squid Game Easter Eggs
        ArrayPush(names, "Gi-hun");
        ArrayPush(names, "Sang-woo");
        ArrayPush(names, "Il-nam");
        ArrayPush(names, "Deok-su");
        ArrayPush(names, "Jun-ho");
        ArrayPush(names, "In-ho");
        ArrayPush(names, "Chan-wook");
        ArrayPush(names, "Young-soo");
        ArrayPush(names, "Byung-hun");
        ArrayPush(names, "Kyu-hyun");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleSlavicNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Viktor");
        ArrayPush(names, "Dmitri");
        ArrayPush(names, "Alexei");
        ArrayPush(names, "Yuri");
        ArrayPush(names, "Sergei");
        ArrayPush(names, "Nikolai");
        ArrayPush(names, "Andrei");
        ArrayPush(names, "Marek");
        ArrayPush(names, "Pawel");
        ArrayPush(names, "Ivan");
        ArrayPush(names, "Boris");
        ArrayPush(names, "Oleg");
        ArrayPush(names, "Mikhail");
        ArrayPush(names, "Konstantin");
        ArrayPush(names, "Vadim");
        ArrayPush(names, "Roman");
        ArrayPush(names, "Stanislav");
        ArrayPush(names, "Grigori");
        ArrayPush(names, "Anatoly");
        ArrayPush(names, "Vladislav");
        ArrayPush(names, "Piotr");
        ArrayPush(names, "Wojciech");
        ArrayPush(names, "Jarek");
        ArrayPush(names, "Tomasz");
        ArrayPush(names, "Krzysztof");
        ArrayPush(names, "Igor");
        ArrayPush(names, "Vasily");
        ArrayPush(names, "Maxim");
        ArrayPush(names, "Arkady");
        ArrayPush(names, "Lev");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleIndianNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Raj");
        ArrayPush(names, "Vikram");
        ArrayPush(names, "Arjun");
        ArrayPush(names, "Sanjay");
        ArrayPush(names, "Ravi");
        ArrayPush(names, "Deepak");
        ArrayPush(names, "Anil");
        ArrayPush(names, "Sunil");
        ArrayPush(names, "Pradeep");
        ArrayPush(names, "Amit");
        ArrayPush(names, "Rahul");
        ArrayPush(names, "Nikhil");
        ArrayPush(names, "Ashok");
        ArrayPush(names, "Kiran");
        ArrayPush(names, "Rohan");
        ArrayPush(names, "Varun");
        ArrayPush(names, "Aditya");
        ArrayPush(names, "Naveen");
        ArrayPush(names, "Sachin");
        ArrayPush(names, "Gaurav");
        // Squid Game Easter Egg
        ArrayPush(names, "Abdul");
        ArrayPush(names, "Vijay");
        ArrayPush(names, "Prakash");
        ArrayPush(names, "Suresh");
        ArrayPush(names, "Ramesh");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleMiddleEasternNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Omar");
        ArrayPush(names, "Hassan");
        ArrayPush(names, "Ahmed");
        ArrayPush(names, "Khalid");
        ArrayPush(names, "Tariq");
        ArrayPush(names, "Yusuf");
        ArrayPush(names, "Samir");
        ArrayPush(names, "Faisal");
        ArrayPush(names, "Nabil");
        ArrayPush(names, "Karim");
        ArrayPush(names, "Rashid");
        ArrayPush(names, "Hamid");
        ArrayPush(names, "Amir");
        ArrayPush(names, "Ibrahim");
        ArrayPush(names, "Reza");
        ArrayPush(names, "Darius");
        ArrayPush(names, "Cyrus");
        ArrayPush(names, "Arash");
        ArrayPush(names, "Farid");
        ArrayPush(names, "Jamal");
        ArrayPush(names, "Mustafa");
        ArrayPush(names, "Ali");
        ArrayPush(names, "Mohammed");
        ArrayPush(names, "Sayed");
        ArrayPush(names, "Walid");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleAfricanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Kofi");
        ArrayPush(names, "Kwame");
        ArrayPush(names, "Chidi");
        ArrayPush(names, "Emeka");
        ArrayPush(names, "Oluwaseun");
        ArrayPush(names, "Tunde");
        ArrayPush(names, "Babatunde");
        ArrayPush(names, "Adewale");
        ArrayPush(names, "Chijioke");
        ArrayPush(names, "Nnamdi");
        ArrayPush(names, "Sekou");
        ArrayPush(names, "Mamadou");
        ArrayPush(names, "Ousmane");
        ArrayPush(names, "Amadou");
        ArrayPush(names, "Yohannes");
        ArrayPush(names, "Jean-Baptiste");
        ArrayPush(names, "Pierre-Louis");
        ArrayPush(names, "Francois");
        ArrayPush(names, "Remy");
        ArrayPush(names, "Jacques");
        ArrayPush(names, "Emmanuel");
        ArrayPush(names, "Samuel");
        ArrayPush(names, "Daniel");
        ArrayPush(names, "Solomon");
        ArrayPush(names, "Moses");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleHaitianNames(seed: Int32) -> String {
        let names: array<String>;
        // Haitian Creole / French-influenced names
        ArrayPush(names, "Jean-Pierre");
        ArrayPush(names, "Jean-Baptiste");
        ArrayPush(names, "Pierre-Louis");
        ArrayPush(names, "Jean-Claude");
        ArrayPush(names, "Jean-Michel");
        ArrayPush(names, "Frantz");
        ArrayPush(names, "Remy");
        ArrayPush(names, "Jacques");
        ArrayPush(names, "Wilner");
        ArrayPush(names, "Mackenson");
        ArrayPush(names, "Dieudonne");
        ArrayPush(names, "Emmanuel");
        ArrayPush(names, "Samuel");
        ArrayPush(names, "Daniel");
        ArrayPush(names, "Evens");
        ArrayPush(names, "Wisly");
        ArrayPush(names, "Woodly");
        ArrayPush(names, "Stanley");
        ArrayPush(names, "Eddy");
        ArrayPush(names, "Reginald");
        ArrayPush(names, "Placide");
        ArrayPush(names, "Toussaint");
        ArrayPush(names, "Dessalines");
        ArrayPush(names, "Christophe");
        ArrayPush(names, "Jude");
        ArrayPush(names, "Maxo");
        ArrayPush(names, "Wyclef");
        ArrayPush(names, "Ti");
        ArrayPush(names, "Manu");
        ArrayPush(names, "Ricardo");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleSoutheastAsianNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Minh");
        ArrayPush(names, "Duc");
        ArrayPush(names, "Huy");
        ArrayPush(names, "Bao");
        ArrayPush(names, "Tam");
        ArrayPush(names, "Thien");
        ArrayPush(names, "Somchai");
        ArrayPush(names, "Prasert");
        ArrayPush(names, "Sompong");
        ArrayPush(names, "Rizal");
        ArrayPush(names, "Arief");
        ArrayPush(names, "Budi");
        ArrayPush(names, "Agus");
        ArrayPush(names, "Tuan");
        ArrayPush(names, "Quang");
        ArrayPush(names, "Thanh");
        ArrayPush(names, "Phong");
        ArrayPush(names, "Kiet");
        ArrayPush(names, "Vinh");
        ArrayPush(names, "Long");
        ArrayPush(names, "Duy");
        ArrayPush(names, "Dat");
        ArrayPush(names, "Thai");
        ArrayPush(names, "Nam");
        ArrayPush(names, "Hung");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMaleEuropeanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Jean");
        ArrayPush(names, "Pierre");
        ArrayPush(names, "Laurent");
        ArrayPush(names, "Francois");
        ArrayPush(names, "Thierry");
        ArrayPush(names, "Klaus");
        ArrayPush(names, "Hans");
        ArrayPush(names, "Wolfgang");
        ArrayPush(names, "Heinrich");
        ArrayPush(names, "Fritz");
        ArrayPush(names, "Marco");
        ArrayPush(names, "Luca");
        ArrayPush(names, "Giovanni");
        ArrayPush(names, "Alessandro");
        ArrayPush(names, "Matteo");
        ArrayPush(names, "Lars");
        ArrayPush(names, "Erik");
        ArrayPush(names, "Sven");
        ArrayPush(names, "Magnus");
        ArrayPush(names, "Bjorn");
        ArrayPush(names, "Patrick");
        ArrayPush(names, "Sean");
        ArrayPush(names, "Connor");
        ArrayPush(names, "Liam");
        ArrayPush(names, "Declan");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // FEMALE FIRST NAMES BY ETHNICITY
    // ══════════════════════════════════════════════════════════════════════

    public static func GetFemaleFirstNameByEthnicity(seed: Int32, ethnicity: NPCEthnicity) -> String {
        switch ethnicity {
            case NPCEthnicity.American:
                return NameGenerator.GetFemaleAmericanNames(seed);
            case NPCEthnicity.AfricanAmerican:
                return NameGenerator.GetFemaleAfricanAmericanNames(seed);
            case NPCEthnicity.Hispanic:
                return NameGenerator.GetFemaleHispanicNames(seed);
            case NPCEthnicity.Japanese:
                return NameGenerator.GetFemaleJapaneseNames(seed);
            case NPCEthnicity.Chinese:
                return NameGenerator.GetFemaleChineseNames(seed);
            case NPCEthnicity.Korean:
                return NameGenerator.GetFemaleKoreanNames(seed);
            case NPCEthnicity.Slavic:
                return NameGenerator.GetFemaleSlavicNames(seed);
            case NPCEthnicity.Indian:
                return NameGenerator.GetFemaleIndianNames(seed);
            case NPCEthnicity.MiddleEastern:
                return NameGenerator.GetFemaleMiddleEasternNames(seed);
            case NPCEthnicity.African:
                return NameGenerator.GetFemaleAfricanNames(seed);
            case NPCEthnicity.SoutheastAsian:
                return NameGenerator.GetFemaleSoutheastAsianNames(seed);
            case NPCEthnicity.European:
                return NameGenerator.GetFemaleEuropeanNames(seed);
            case NPCEthnicity.Haitian:
                return NameGenerator.GetFemaleHaitianNames(seed);
            default:
                return NameGenerator.GetFemaleFirstName(seed);
        }
    }

    private static func GetFemaleAmericanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Sarah");
        ArrayPush(names, "Jennifer");
        ArrayPush(names, "Michelle");
        ArrayPush(names, "Amanda");
        ArrayPush(names, "Jessica");
        ArrayPush(names, "Rachel");
        ArrayPush(names, "Lisa");
        ArrayPush(names, "Angela");
        ArrayPush(names, "Stephanie");
        ArrayPush(names, "Nicole");
        ArrayPush(names, "Lauren");
        ArrayPush(names, "Ashley");
        ArrayPush(names, "Emily");
        ArrayPush(names, "Megan");
        ArrayPush(names, "Samantha");
        ArrayPush(names, "Heather");
        ArrayPush(names, "Amber");
        ArrayPush(names, "Crystal");
        ArrayPush(names, "Brittany");
        ArrayPush(names, "Courtney");
        ArrayPush(names, "Kaitlyn");
        ArrayPush(names, "Hannah");
        ArrayPush(names, "Madison");
        ArrayPush(names, "Alexis");
        ArrayPush(names, "Taylor");
        ArrayPush(names, "Jordan");
        ArrayPush(names, "Morgan");
        ArrayPush(names, "Sydney");
        ArrayPush(names, "Brooke");
        ArrayPush(names, "Paige");
        ArrayPush(names, "Kelly");
        ArrayPush(names, "Katie");
        ArrayPush(names, "Lindsey");
        ArrayPush(names, "Danielle");
        ArrayPush(names, "Christina");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleAfricanAmericanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Tanya");
        ArrayPush(names, "Keisha");
        ArrayPush(names, "Brianna");
        ArrayPush(names, "Destiny");
        ArrayPush(names, "Jasmine");
        ArrayPush(names, "Aaliyah");
        ArrayPush(names, "Shanice");
        ArrayPush(names, "Tamika");
        ArrayPush(names, "Latoya");
        ArrayPush(names, "Diamond");
        ArrayPush(names, "Precious");
        ArrayPush(names, "Ebony");
        ArrayPush(names, "Imani");
        ArrayPush(names, "Shaniqua");
        ArrayPush(names, "Monique");
        ArrayPush(names, "Tanisha");
        ArrayPush(names, "Shonda");
        ArrayPush(names, "Lakisha");
        ArrayPush(names, "Niesha");
        ArrayPush(names, "Deja");
        ArrayPush(names, "Tamara");
        ArrayPush(names, "Yolanda");
        ArrayPush(names, "Tiffany");
        ArrayPush(names, "Renee");
        ArrayPush(names, "Jazmin");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleHispanicNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Maria");
        ArrayPush(names, "Rosa");
        ArrayPush(names, "Carmen");
        ArrayPush(names, "Sofia");
        ArrayPush(names, "Valentina");
        ArrayPush(names, "Isabella");
        ArrayPush(names, "Gabriela");
        ArrayPush(names, "Lucia");
        ArrayPush(names, "Elena");
        ArrayPush(names, "Ana");
        ArrayPush(names, "Camila");
        ArrayPush(names, "Mariana");
        ArrayPush(names, "Adriana");
        ArrayPush(names, "Alejandra");
        ArrayPush(names, "Daniela");
        ArrayPush(names, "Fernanda");
        ArrayPush(names, "Natalia");
        ArrayPush(names, "Veronica");
        ArrayPush(names, "Catalina");
        ArrayPush(names, "Marisol");
        ArrayPush(names, "Esperanza");
        ArrayPush(names, "Guadalupe");
        ArrayPush(names, "Xiomara");
        ArrayPush(names, "Yolanda");
        ArrayPush(names, "Dolores");
        ArrayPush(names, "Consuelo");
        ArrayPush(names, "Raquel");
        ArrayPush(names, "Pilar");
        ArrayPush(names, "Ines");
        ArrayPush(names, "Paloma");
        ArrayPush(names, "Luz");
        ArrayPush(names, "Teresa");
        ArrayPush(names, "Patricia");
        ArrayPush(names, "Claudia");
        ArrayPush(names, "Diana");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleJapaneseNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Yuki");
        ArrayPush(names, "Mei");
        ArrayPush(names, "Akiko");
        ArrayPush(names, "Sakura");
        ArrayPush(names, "Haruka");
        ArrayPush(names, "Mika");
        ArrayPush(names, "Rina");
        ArrayPush(names, "Kaori");
        ArrayPush(names, "Yui");
        ArrayPush(names, "Aoi");
        ArrayPush(names, "Hana");
        ArrayPush(names, "Nanami");
        ArrayPush(names, "Kana");
        ArrayPush(names, "Ayumi");
        ArrayPush(names, "Misaki");
        ArrayPush(names, "Natsuki");
        ArrayPush(names, "Saki");
        ArrayPush(names, "Tomoko");
        ArrayPush(names, "Keiko");
        ArrayPush(names, "Noriko");
        ArrayPush(names, "Mariko");
        ArrayPush(names, "Kumiko");
        ArrayPush(names, "Yumiko");
        ArrayPush(names, "Reiko");
        ArrayPush(names, "Michiko");
        ArrayPush(names, "Naomi");
        ArrayPush(names, "Emi");
        ArrayPush(names, "Asuka");
        ArrayPush(names, "Rei");
        ArrayPush(names, "Hikari");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleChineseNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Lin");
        ArrayPush(names, "Xiao");
        ArrayPush(names, "Mei-Lin");
        ArrayPush(names, "Yan");
        ArrayPush(names, "Jing");
        ArrayPush(names, "Hua");
        ArrayPush(names, "Xiu");
        ArrayPush(names, "Fang");
        ArrayPush(names, "Li");
        ArrayPush(names, "Na");
        ArrayPush(names, "Ying");
        ArrayPush(names, "Hong");
        ArrayPush(names, "Lan");
        ArrayPush(names, "Qing");
        ArrayPush(names, "Shu");
        ArrayPush(names, "Wen");
        ArrayPush(names, "Zhi");
        ArrayPush(names, "Yun");
        ArrayPush(names, "Xia");
        ArrayPush(names, "Mei");
        ArrayPush(names, "Ling");
        ArrayPush(names, "Hui");
        ArrayPush(names, "Min");
        ArrayPush(names, "Ping");
        ArrayPush(names, "Wei");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleKoreanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Ji-yeon");
        ArrayPush(names, "Min-ji");
        ArrayPush(names, "Su-bin");
        ArrayPush(names, "Hye-jin");
        ArrayPush(names, "Soo-yeon");
        ArrayPush(names, "Eun-ji");
        ArrayPush(names, "Yoon-ah");
        ArrayPush(names, "Ha-na");
        ArrayPush(names, "Ae-ri");
        ArrayPush(names, "Bo-ra");
        ArrayPush(names, "Da-hye");
        ArrayPush(names, "Ga-young");
        ArrayPush(names, "In-young");
        ArrayPush(names, "Mi-sun");
        ArrayPush(names, "Sun-hee");
        // Squid Game Easter Eggs
        ArrayPush(names, "Sae-byeok");
        ArrayPush(names, "Mi-nyeo");
        ArrayPush(names, "Ji-yeong");
        ArrayPush(names, "Young-hee");
        ArrayPush(names, "Yeon-hee");
        ArrayPush(names, "Jung-ah");
        ArrayPush(names, "Hee-jung");
        ArrayPush(names, "Soo-jin");
        ArrayPush(names, "Ye-jin");
        ArrayPush(names, "Min-young");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleSlavicNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Natasha");
        ArrayPush(names, "Svetlana");
        ArrayPush(names, "Katya");
        ArrayPush(names, "Olga");
        ArrayPush(names, "Anna");
        ArrayPush(names, "Irina");
        ArrayPush(names, "Anya");
        ArrayPush(names, "Marta");
        ArrayPush(names, "Zofia");
        ArrayPush(names, "Tatiana");
        ArrayPush(names, "Yelena");
        ArrayPush(names, "Nadia");
        ArrayPush(names, "Vera");
        ArrayPush(names, "Marina");
        ArrayPush(names, "Galina");
        ArrayPush(names, "Ludmila");
        ArrayPush(names, "Valentina");
        ArrayPush(names, "Oksana");
        ArrayPush(names, "Yulia");
        ArrayPush(names, "Daria");
        ArrayPush(names, "Agnieszka");
        ArrayPush(names, "Kasia");
        ArrayPush(names, "Monika");
        ArrayPush(names, "Ewa");
        ArrayPush(names, "Beata");
        ArrayPush(names, "Nina");
        ArrayPush(names, "Sasha");
        ArrayPush(names, "Larisa");
        ArrayPush(names, "Tamara");
        ArrayPush(names, "Zoya");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleIndianNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Priya");
        ArrayPush(names, "Anita");
        ArrayPush(names, "Sunita");
        ArrayPush(names, "Kavita");
        ArrayPush(names, "Meena");
        ArrayPush(names, "Deepa");
        ArrayPush(names, "Anjali");
        ArrayPush(names, "Pooja");
        ArrayPush(names, "Neha");
        ArrayPush(names, "Rani");
        ArrayPush(names, "Lakshmi");
        ArrayPush(names, "Geeta");
        ArrayPush(names, "Radha");
        ArrayPush(names, "Sita");
        ArrayPush(names, "Divya");
        ArrayPush(names, "Rekha");
        ArrayPush(names, "Asha");
        ArrayPush(names, "Padma");
        ArrayPush(names, "Usha");
        ArrayPush(names, "Nisha");
        ArrayPush(names, "Meera");
        ArrayPush(names, "Shanti");
        ArrayPush(names, "Kamala");
        ArrayPush(names, "Savitri");
        ArrayPush(names, "Indira");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleMiddleEasternNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Fatima");
        ArrayPush(names, "Aisha");
        ArrayPush(names, "Layla");
        ArrayPush(names, "Yasmin");
        ArrayPush(names, "Noor");
        ArrayPush(names, "Salma");
        ArrayPush(names, "Amira");
        ArrayPush(names, "Leila");
        ArrayPush(names, "Samira");
        ArrayPush(names, "Zara");
        ArrayPush(names, "Rania");
        ArrayPush(names, "Maryam");
        ArrayPush(names, "Farah");
        ArrayPush(names, "Nadira");
        ArrayPush(names, "Shirin");
        ArrayPush(names, "Parisa");
        ArrayPush(names, "Soraya");
        ArrayPush(names, "Roxana");
        ArrayPush(names, "Azadeh");
        ArrayPush(names, "Nasrin");
        ArrayPush(names, "Zahra");
        ArrayPush(names, "Hana");
        ArrayPush(names, "Sara");
        ArrayPush(names, "Dina");
        ArrayPush(names, "Mariam");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleAfricanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Amara");
        ArrayPush(names, "Adaeze");
        ArrayPush(names, "Chiamaka");
        ArrayPush(names, "Ngozi");
        ArrayPush(names, "Nneka");
        ArrayPush(names, "Adanna");
        ArrayPush(names, "Folake");
        ArrayPush(names, "Yetunde");
        ArrayPush(names, "Aminata");
        ArrayPush(names, "Mariama");
        ArrayPush(names, "Awa");
        ArrayPush(names, "Fatou");
        ArrayPush(names, "Aissatou");
        ArrayPush(names, "Tigist");
        ArrayPush(names, "Makeda");
        ArrayPush(names, "Marie-Claire");
        ArrayPush(names, "Josephine");
        ArrayPush(names, "Claudine");
        ArrayPush(names, "Nadege");
        ArrayPush(names, "Esther");
        ArrayPush(names, "Ruth");
        ArrayPush(names, "Miriam");
        ArrayPush(names, "Grace");
        ArrayPush(names, "Hope");
        ArrayPush(names, "Blessing");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleHaitianNames(seed: Int32) -> String {
        let names: array<String>;
        // Haitian Creole / French-influenced names
        ArrayPush(names, "Marie-Claire");
        ArrayPush(names, "Marie-Louise");
        ArrayPush(names, "Marie-Josee");
        ArrayPush(names, "Nadege");
        ArrayPush(names, "Mireille");
        ArrayPush(names, "Fabienne");
        ArrayPush(names, "Guerline");
        ArrayPush(names, "Yolande");
        ArrayPush(names, "Ginette");
        ArrayPush(names, "Judith");
        ArrayPush(names, "Roseline");
        ArrayPush(names, "Claudette");
        ArrayPush(names, "Carline");
        ArrayPush(names, "Magalie");
        ArrayPush(names, "Mimose");
        ArrayPush(names, "Tifane");
        ArrayPush(names, "Kettely");
        ArrayPush(names, "Islande");
        ArrayPush(names, "Fleurette");
        ArrayPush(names, "Esther");
        ArrayPush(names, "Ruth");
        ArrayPush(names, "Naomi");
        ArrayPush(names, "Deborah");
        ArrayPush(names, "Sherly");
        ArrayPush(names, "Widline");
        ArrayPush(names, "Lovely");
        ArrayPush(names, "Dieula");
        ArrayPush(names, "Venise");
        ArrayPush(names, "Pascale");
        ArrayPush(names, "Beatrice");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleSoutheastAsianNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Mai");
        ArrayPush(names, "Linh");
        ArrayPush(names, "Thi");
        ArrayPush(names, "Huong");
        ArrayPush(names, "Thanh");
        ArrayPush(names, "Lan");
        ArrayPush(names, "Nguyet");
        ArrayPush(names, "Nattaya");
        ArrayPush(names, "Siriwan");
        ArrayPush(names, "Malee");
        ArrayPush(names, "Dewi");
        ArrayPush(names, "Putri");
        ArrayPush(names, "Siti");
        ArrayPush(names, "Ratna");
        ArrayPush(names, "Thao");
        ArrayPush(names, "Ngoc");
        ArrayPush(names, "Vy");
        ArrayPush(names, "Tuyet");
        ArrayPush(names, "Kim");
        ArrayPush(names, "Hoa");
        ArrayPush(names, "Hong");
        ArrayPush(names, "Phuong");
        ArrayPush(names, "Trang");
        ArrayPush(names, "Thu");
        ArrayPush(names, "Anh");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetFemaleEuropeanNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Marie");
        ArrayPush(names, "Sophie");
        ArrayPush(names, "Chloe");
        ArrayPush(names, "Camille");
        ArrayPush(names, "Isabelle");
        ArrayPush(names, "Greta");
        ArrayPush(names, "Heidi");
        ArrayPush(names, "Ingrid");
        ArrayPush(names, "Frieda");
        ArrayPush(names, "Hilde");
        ArrayPush(names, "Giulia");
        ArrayPush(names, "Francesca");
        ArrayPush(names, "Chiara");
        ArrayPush(names, "Alessia");
        ArrayPush(names, "Bianca");
        ArrayPush(names, "Astrid");
        ArrayPush(names, "Freya");
        ArrayPush(names, "Sigrid");
        ArrayPush(names, "Helga");
        ArrayPush(names, "Siobhan");
        ArrayPush(names, "Aisling");
        ArrayPush(names, "Niamh");
        ArrayPush(names, "Fiona");
        ArrayPush(names, "Brigitte");
        ArrayPush(names, "Monique");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // LAST NAMES BY ETHNICITY
    // ══════════════════════════════════════════════════════════════════════

    public static func GetLastNameByEthnicity(seed: Int32, ethnicity: NPCEthnicity) -> String {
        switch ethnicity {
            case NPCEthnicity.American:
                return NameGenerator.GetAmericanLastNames(seed);
            case NPCEthnicity.AfricanAmerican:
                return NameGenerator.GetAfricanAmericanLastNames(seed);
            case NPCEthnicity.Hispanic:
                return NameGenerator.GetHispanicLastNames(seed);
            case NPCEthnicity.Japanese:
                return NameGenerator.GetJapaneseLastNames(seed);
            case NPCEthnicity.Chinese:
                return NameGenerator.GetChineseLastNames(seed);
            case NPCEthnicity.Korean:
                return NameGenerator.GetKoreanLastNames(seed);
            case NPCEthnicity.Slavic:
                return NameGenerator.GetSlavicLastNames(seed);
            case NPCEthnicity.Indian:
                return NameGenerator.GetIndianLastNames(seed);
            case NPCEthnicity.MiddleEastern:
                return NameGenerator.GetMiddleEasternLastNames(seed);
            case NPCEthnicity.African:
                return NameGenerator.GetAfricanLastNames(seed);
            case NPCEthnicity.SoutheastAsian:
                return NameGenerator.GetSoutheastAsianLastNames(seed);
            case NPCEthnicity.European:
                return NameGenerator.GetEuropeanLastNames(seed);
            case NPCEthnicity.Haitian:
                return NameGenerator.GetHaitianLastNames(seed);
            default:
                return NameGenerator.GetLastName(seed);
        }
    }

    private static func GetAmericanLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Johnson");
        ArrayPush(names, "Williams");
        ArrayPush(names, "Brown");
        ArrayPush(names, "Davis");
        ArrayPush(names, "Miller");
        ArrayPush(names, "Wilson");
        ArrayPush(names, "Moore");
        ArrayPush(names, "Taylor");
        ArrayPush(names, "White");
        ArrayPush(names, "Clark");
        ArrayPush(names, "Wright");
        ArrayPush(names, "Walker");
        ArrayPush(names, "Scott");
        ArrayPush(names, "Adams");
        ArrayPush(names, "Baker");
        ArrayPush(names, "Nelson");
        ArrayPush(names, "Carter");
        ArrayPush(names, "Mitchell");
        ArrayPush(names, "Roberts");
        ArrayPush(names, "Turner");
        ArrayPush(names, "Phillips");
        ArrayPush(names, "Campbell");
        ArrayPush(names, "Parker");
        ArrayPush(names, "Evans");
        ArrayPush(names, "Edwards");
        ArrayPush(names, "Collins");
        ArrayPush(names, "Stewart");
        ArrayPush(names, "Morris");
        ArrayPush(names, "Reed");
        ArrayPush(names, "Morgan");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetAfricanAmericanLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Jackson");
        ArrayPush(names, "Harris");
        ArrayPush(names, "Robinson");
        ArrayPush(names, "Lewis");
        ArrayPush(names, "Walker");
        ArrayPush(names, "Green");
        ArrayPush(names, "Hall");
        ArrayPush(names, "Young");
        ArrayPush(names, "King");
        ArrayPush(names, "Wright");
        ArrayPush(names, "Hill");
        ArrayPush(names, "Scott");
        ArrayPush(names, "Adams");
        ArrayPush(names, "Baker");
        ArrayPush(names, "Carter");
        ArrayPush(names, "Mitchell");
        ArrayPush(names, "Turner");
        ArrayPush(names, "Collins");
        ArrayPush(names, "Morgan");
        ArrayPush(names, "Bell");
        ArrayPush(names, "Washington");
        ArrayPush(names, "Jefferson");
        ArrayPush(names, "Freeman");
        ArrayPush(names, "Brooks");
        ArrayPush(names, "Coleman");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetHispanicLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Rodriguez");
        ArrayPush(names, "Martinez");
        ArrayPush(names, "Garcia");
        ArrayPush(names, "Hernandez");
        ArrayPush(names, "Lopez");
        ArrayPush(names, "Gonzalez");
        ArrayPush(names, "Cruz");
        ArrayPush(names, "Torres");
        ArrayPush(names, "Reyes");
        ArrayPush(names, "Santos");
        ArrayPush(names, "Moreno");
        ArrayPush(names, "Ramirez");
        ArrayPush(names, "Diaz");
        ArrayPush(names, "Flores");
        ArrayPush(names, "Vasquez");
        ArrayPush(names, "Castillo");
        ArrayPush(names, "Jimenez");
        ArrayPush(names, "Morales");
        ArrayPush(names, "Ruiz");
        ArrayPush(names, "Ortiz");
        ArrayPush(names, "Gutierrez");
        ArrayPush(names, "Mendoza");
        ArrayPush(names, "Vargas");
        ArrayPush(names, "Romero");
        ArrayPush(names, "Alvarez");
        ArrayPush(names, "Chavez");
        ArrayPush(names, "Delgado");
        ArrayPush(names, "Sandoval");
        ArrayPush(names, "Aguilar");
        ArrayPush(names, "Medina");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetJapaneseLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Tanaka");
        ArrayPush(names, "Yamamoto");
        ArrayPush(names, "Nakamura");
        ArrayPush(names, "Suzuki");
        ArrayPush(names, "Sato");
        ArrayPush(names, "Watanabe");
        ArrayPush(names, "Takahashi");
        ArrayPush(names, "Kobayashi");
        ArrayPush(names, "Ito");
        ArrayPush(names, "Kato");
        ArrayPush(names, "Yoshida");
        ArrayPush(names, "Yamada");
        ArrayPush(names, "Sasaki");
        ArrayPush(names, "Yamaguchi");
        ArrayPush(names, "Matsumoto");
        ArrayPush(names, "Inoue");
        ArrayPush(names, "Kimura");
        ArrayPush(names, "Hayashi");
        ArrayPush(names, "Shimizu");
        ArrayPush(names, "Yamazaki");
        ArrayPush(names, "Mori");
        ArrayPush(names, "Abe");
        ArrayPush(names, "Ikeda");
        ArrayPush(names, "Hashimoto");
        ArrayPush(names, "Ogawa");
        ArrayPush(names, "Okada");
        ArrayPush(names, "Arasaka");
        ArrayPush(names, "Fujimoto");
        ArrayPush(names, "Nishikawa");
        ArrayPush(names, "Takeda");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetChineseLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Chen");
        ArrayPush(names, "Wang");
        ArrayPush(names, "Liu");
        ArrayPush(names, "Zhang");
        ArrayPush(names, "Li");
        ArrayPush(names, "Huang");
        ArrayPush(names, "Yang");
        ArrayPush(names, "Wu");
        ArrayPush(names, "Zhou");
        ArrayPush(names, "Xu");
        ArrayPush(names, "Sun");
        ArrayPush(names, "Ma");
        ArrayPush(names, "Zhu");
        ArrayPush(names, "Hu");
        ArrayPush(names, "Guo");
        ArrayPush(names, "He");
        ArrayPush(names, "Lin");
        ArrayPush(names, "Gao");
        ArrayPush(names, "Luo");
        ArrayPush(names, "Zheng");
        ArrayPush(names, "Kang");
        ArrayPush(names, "Tao");
        ArrayPush(names, "Feng");
        ArrayPush(names, "Xie");
        ArrayPush(names, "Cao");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetKoreanLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Kim");
        ArrayPush(names, "Park");
        ArrayPush(names, "Lee");
        ArrayPush(names, "Choi");
        ArrayPush(names, "Jung");
        ArrayPush(names, "Kang");
        ArrayPush(names, "Cho");
        ArrayPush(names, "Yoon");
        ArrayPush(names, "Jang");
        ArrayPush(names, "Lim");
        ArrayPush(names, "Han");
        ArrayPush(names, "Oh");
        ArrayPush(names, "Seo");
        ArrayPush(names, "Shin");
        ArrayPush(names, "Kwon");
        // Squid Game Easter Eggs
        ArrayPush(names, "Seong");
        ArrayPush(names, "Hwang");
        ArrayPush(names, "Byun");
        ArrayPush(names, "Ahn");
        ArrayPush(names, "Song");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetSlavicLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Volkov");
        ArrayPush(names, "Petrov");
        ArrayPush(names, "Ivanov");
        ArrayPush(names, "Kowalski");
        ArrayPush(names, "Nowak");
        ArrayPush(names, "Kovacs");
        ArrayPush(names, "Novak");
        ArrayPush(names, "Popov");
        ArrayPush(names, "Sokolov");
        ArrayPush(names, "Morozov");
        ArrayPush(names, "Smirnov");
        ArrayPush(names, "Kuznetsov");
        ArrayPush(names, "Fedorov");
        ArrayPush(names, "Mikhailov");
        ArrayPush(names, "Nikolaev");
        ArrayPush(names, "Kozlov");
        ArrayPush(names, "Stepanov");
        ArrayPush(names, "Orlov");
        ArrayPush(names, "Lebedev");
        ArrayPush(names, "Romanov");
        ArrayPush(names, "Wisniewski");
        ArrayPush(names, "Wojciechowski");
        ArrayPush(names, "Kaminski");
        ArrayPush(names, "Lewandowski");
        ArrayPush(names, "Zielinski");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetIndianLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Patel");
        ArrayPush(names, "Sharma");
        ArrayPush(names, "Singh");
        ArrayPush(names, "Kumar");
        ArrayPush(names, "Gupta");
        ArrayPush(names, "Mehta");
        ArrayPush(names, "Shah");
        ArrayPush(names, "Rao");
        ArrayPush(names, "Reddy");
        ArrayPush(names, "Nair");
        ArrayPush(names, "Menon");
        ArrayPush(names, "Joshi");
        ArrayPush(names, "Desai");
        ArrayPush(names, "Kapoor");
        ArrayPush(names, "Malhotra");
        ArrayPush(names, "Khanna");
        ArrayPush(names, "Chopra");
        ArrayPush(names, "Agarwal");
        ArrayPush(names, "Verma");
        ArrayPush(names, "Iyer");
        // Squid Game Easter Egg
        ArrayPush(names, "Ali");
        ArrayPush(names, "Khan");
        ArrayPush(names, "Prasad");
        ArrayPush(names, "Das");
        ArrayPush(names, "Saxena");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetMiddleEasternLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Al-Farsi");
        ArrayPush(names, "Al-Rashid");
        ArrayPush(names, "Al-Hassan");
        ArrayPush(names, "Al-Zahrani");
        ArrayPush(names, "Al-Qahtani");
        ArrayPush(names, "Al-Dosari");
        ArrayPush(names, "Mohammed");
        ArrayPush(names, "Ibrahim");
        ArrayPush(names, "Abdullah");
        ArrayPush(names, "Habibi");
        ArrayPush(names, "Nazari");
        ArrayPush(names, "Tehrani");
        ArrayPush(names, "Shirazi");
        ArrayPush(names, "Hosseini");
        ArrayPush(names, "Bakhtiari");
        ArrayPush(names, "Ahmadi");
        ArrayPush(names, "Karimi");
        ArrayPush(names, "Hashemi");
        ArrayPush(names, "Mousavi");
        ArrayPush(names, "Rahmani");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetAfricanLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Okonkwo");
        ArrayPush(names, "Okafor");
        ArrayPush(names, "Nwachukwu");
        ArrayPush(names, "Adeyemi");
        ArrayPush(names, "Ogundimu");
        ArrayPush(names, "Bakare");
        ArrayPush(names, "Mensah");
        ArrayPush(names, "Asante");
        ArrayPush(names, "Diallo");
        ArrayPush(names, "Traore");
        ArrayPush(names, "Keita");
        ArrayPush(names, "Cisse");
        ArrayPush(names, "Mbeki");
        ArrayPush(names, "Zuma");
        ArrayPush(names, "Abebe");
        ArrayPush(names, "Jean-Pierre");
        ArrayPush(names, "Baptiste");
        ArrayPush(names, "Celestin");
        ArrayPush(names, "Beaumont");
        ArrayPush(names, "Toussaint");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetHaitianLastNames(seed: Int32) -> String {
        let names: array<String>;
        // Haitian surnames - French colonial influence
        ArrayPush(names, "Jean-Pierre");
        ArrayPush(names, "Baptiste");
        ArrayPush(names, "Celestin");
        ArrayPush(names, "Beaumont");
        ArrayPush(names, "Toussaint");
        ArrayPush(names, "Dessalines");
        ArrayPush(names, "Christophe");
        ArrayPush(names, "Louverture");
        ArrayPush(names, "Pierre-Louis");
        ArrayPush(names, "Lafontant");
        ArrayPush(names, "Aristide");
        ArrayPush(names, "Duvalier");
        ArrayPush(names, "Preval");
        ArrayPush(names, "Martelly");
        ArrayPush(names, "Hyppolite");
        ArrayPush(names, "Auguste");
        ArrayPush(names, "Belizaire");
        ArrayPush(names, "Beauvoir");
        ArrayPush(names, "Delphin");
        ArrayPush(names, "Estimable");
        ArrayPush(names, "Gaston");
        ArrayPush(names, "Janvier");
        ArrayPush(names, "Legros");
        ArrayPush(names, "Narcisse");
        ArrayPush(names, "Placide");
        ArrayPush(names, "Raphael");
        ArrayPush(names, "Simeon");
        ArrayPush(names, "Theophile");
        ArrayPush(names, "Vilfort");
        ArrayPush(names, "Zamor");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetSoutheastAsianLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "Nguyen");
        ArrayPush(names, "Tran");
        ArrayPush(names, "Pham");
        ArrayPush(names, "Le");
        ArrayPush(names, "Hoang");
        ArrayPush(names, "Vu");
        ArrayPush(names, "Bui");
        ArrayPush(names, "Dang");
        ArrayPush(names, "Sukhumvit");
        ArrayPush(names, "Thongchai");
        ArrayPush(names, "Wijaya");
        ArrayPush(names, "Gunawan");
        ArrayPush(names, "Santoso");
        ArrayPush(names, "Hartono");
        ArrayPush(names, "Tan");
        ArrayPush(names, "Do");
        ArrayPush(names, "Ngo");
        ArrayPush(names, "Vo");
        ArrayPush(names, "Trinh");
        ArrayPush(names, "Duong");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    private static func GetEuropeanLastNames(seed: Int32) -> String {
        let names: array<String>;
        ArrayPush(names, "O'Brien");
        ArrayPush(names, "Kelly");
        ArrayPush(names, "O'Connor");
        ArrayPush(names, "Walsh");
        ArrayPush(names, "Schmidt");
        ArrayPush(names, "Mueller");
        ArrayPush(names, "Schneider");
        ArrayPush(names, "Fischer");
        ArrayPush(names, "Weber");
        ArrayPush(names, "Meyer");
        ArrayPush(names, "Wagner");
        ArrayPush(names, "Becker");
        ArrayPush(names, "Hoffman");
        ArrayPush(names, "Richter");
        ArrayPush(names, "Rossi");
        ArrayPush(names, "Russo");
        ArrayPush(names, "Ferrari");
        ArrayPush(names, "Bianchi");
        ArrayPush(names, "Romano");
        ArrayPush(names, "Dubois");
        ArrayPush(names, "Bernard");
        ArrayPush(names, "Moreau");
        ArrayPush(names, "Laurent");
        ArrayPush(names, "Leroy");
        ArrayPush(names, "Johansson");
        ArrayPush(names, "Lindberg");
        ArrayPush(names, "Eriksson");
        ArrayPush(names, "Larsson");
        ArrayPush(names, "Olsen");
        ArrayPush(names, "Murphy");
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // LEGACY ALL-POOL FUNCTIONS (backward compatibility)
    // ══════════════════════════════════════════════════════════════════════

    public static func GetMaleFirstName(seed: Int32) -> String {
        // Pick random ethnicity then get name from that pool
        let ethnicity = EthnicityDetector.GetRandomEthnicity(seed + 999);
        return NameGenerator.GetMaleFirstNameByEthnicity(seed, ethnicity);
    }

    public static func GetFemaleFirstName(seed: Int32) -> String {
        // Pick random ethnicity then get name from that pool
        let ethnicity = EthnicityDetector.GetRandomEthnicity(seed + 999);
        return NameGenerator.GetFemaleFirstNameByEthnicity(seed, ethnicity);
    }

    public static func GetLastName(seed: Int32) -> String {
        // Pick random ethnicity then get name from that pool
        let ethnicity = EthnicityDetector.GetRandomEthnicity(seed + 999);
        return NameGenerator.GetLastNameByEthnicity(seed, ethnicity);
    }

    // ══════════════════════════════════════════════════════════════════════
    // STREET ALIASES
    // ══════════════════════════════════════════════════════════════════════

    public static func GetStreetAlias(seed: Int32) -> String {
        let aliases: array<String>;

        // Classic street names
        ArrayPush(aliases, "Razor");
        ArrayPush(aliases, "Ghost");
        ArrayPush(aliases, "Neon");
        ArrayPush(aliases, "Spike");
        ArrayPush(aliases, "Chrome");
        ArrayPush(aliases, "Bullet");
        ArrayPush(aliases, "Zero");
        ArrayPush(aliases, "Glitch");
        ArrayPush(aliases, "Snake");
        ArrayPush(aliases, "Ice");
        ArrayPush(aliases, "Wire");
        ArrayPush(aliases, "Shadow");
        ArrayPush(aliases, "Byte");
        ArrayPush(aliases, "Torch");
        ArrayPush(aliases, "Venom");
        ArrayPush(aliases, "Blade");
        ArrayPush(aliases, "Cipher");
        ArrayPush(aliases, "Hex");
        ArrayPush(aliases, "Rogue");
        ArrayPush(aliases, "Nova");
        ArrayPush(aliases, "Blaze");
        ArrayPush(aliases, "Pixel");
        ArrayPush(aliases, "Crash");
        ArrayPush(aliases, "Static");
        ArrayPush(aliases, "Null");

        // Violence/Weapons
        ArrayPush(aliases, "Switchblade");
        ArrayPush(aliases, "Trigger");
        ArrayPush(aliases, "Hammer");
        ArrayPush(aliases, "Shiv");
        ArrayPush(aliases, "Crowbar");
        ArrayPush(aliases, "Cleaver");
        ArrayPush(aliases, "Mantis");
        ArrayPush(aliases, "Gorilla");
        ArrayPush(aliases, "Fist");
        ArrayPush(aliases, "Knuckles");
        ArrayPush(aliases, "Breaker");
        ArrayPush(aliases, "Crusher");

        // Tech/Netrunner
        ArrayPush(aliases, "Virus");
        ArrayPush(aliases, "Daemon");
        ArrayPush(aliases, "Root");
        ArrayPush(aliases, "Trojan");
        ArrayPush(aliases, "Firewall");
        ArrayPush(aliases, "Proxy");
        ArrayPush(aliases, "Protocol");
        ArrayPush(aliases, "Binary");
        ArrayPush(aliases, "Ping");
        ArrayPush(aliases, "Buffer");
        ArrayPush(aliases, "Node");
        ArrayPush(aliases, "Patch");

        // Animals
        ArrayPush(aliases, "Scorpion");
        ArrayPush(aliases, "Panther");
        ArrayPush(aliases, "Viper");
        ArrayPush(aliases, "Jackal");
        ArrayPush(aliases, "Cobra");
        ArrayPush(aliases, "Hawk");
        ArrayPush(aliases, "Wolf");
        ArrayPush(aliases, "Tiger");
        ArrayPush(aliases, "Spider");
        ArrayPush(aliases, "Shark");
        ArrayPush(aliases, "Raven");
        ArrayPush(aliases, "Crow");

        // Appearance/Traits
        ArrayPush(aliases, "Scar");
        ArrayPush(aliases, "One-Eye");
        ArrayPush(aliases, "Ink");
        ArrayPush(aliases, "Slim");
        ArrayPush(aliases, "Tank");
        ArrayPush(aliases, "Giant");
        ArrayPush(aliases, "Tiny");
        ArrayPush(aliases, "Red");
        ArrayPush(aliases, "Silver");
        ArrayPush(aliases, "Smokey");

        // Personality
        ArrayPush(aliases, "Mad Dog");
        ArrayPush(aliases, "Psycho");
        ArrayPush(aliases, "Joker");
        ArrayPush(aliases, "Lucky");
        ArrayPush(aliases, "Silent");
        ArrayPush(aliases, "Whisper");
        ArrayPush(aliases, "Twitch");
        ArrayPush(aliases, "Quick");
        ArrayPush(aliases, "Smooth");

        // Elements
        ArrayPush(aliases, "Thunder");
        ArrayPush(aliases, "Lightning");
        ArrayPush(aliases, "Frost");
        ArrayPush(aliases, "Ember");
        ArrayPush(aliases, "Ash");
        ArrayPush(aliases, "Stone");
        ArrayPush(aliases, "Iron");
        ArrayPush(aliases, "Steel");
        ArrayPush(aliases, "Acid");
        ArrayPush(aliases, "Toxic");

        // Roles
        ArrayPush(aliases, "Doc");
        ArrayPush(aliases, "Chef");
        ArrayPush(aliases, "Preacher");
        ArrayPush(aliases, "King");
        ArrayPush(aliases, "Duke");
        ArrayPush(aliases, "Boss");
        ArrayPush(aliases, "Merc");
        ArrayPush(aliases, "Fixer");
        ArrayPush(aliases, "Runner");
        ArrayPush(aliases, "Driver");

        // Night City Slang
        ArrayPush(aliases, "Choom");
        ArrayPush(aliases, "Gonk");
        ArrayPush(aliases, "Preem");
        ArrayPush(aliases, "Delta");
        ArrayPush(aliases, "Flatline");
        ArrayPush(aliases, "Corpo");
        ArrayPush(aliases, "Badge");

        // Squid Game Easter Eggs
        ArrayPush(aliases, "456");
        ArrayPush(aliases, "067");
        ArrayPush(aliases, "218");
        ArrayPush(aliases, "001");
        ArrayPush(aliases, "Front Man");
        ArrayPush(aliases, "Red Light");
        ArrayPush(aliases, "Green Light");

        // Numbers
        ArrayPush(aliases, "Six");
        ArrayPush(aliases, "Seven");
        ArrayPush(aliases, "Ace");
        ArrayPush(aliases, "Solo");
        ArrayPush(aliases, "Prime");
        ArrayPush(aliases, "Omega");
        ArrayPush(aliases, "Alpha");
        ArrayPush(aliases, "X");

        return "\"" + aliases[RandRange(seed, 0, ArraySize(aliases) - 1)] + "\"";
    }
}
