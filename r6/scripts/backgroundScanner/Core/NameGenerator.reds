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
        let i = RandRange(seed, 0, 34);
        if i == 0 { return "Marcus"; }
        if i == 1 { return "James"; }
        if i == 2 { return "Robert"; }
        if i == 3 { return "Michael"; }
        if i == 4 { return "David"; }
        if i == 5 { return "William"; }
        if i == 6 { return "Thomas"; }
        if i == 7 { return "Daniel"; }
        if i == 8 { return "Kevin"; }
        if i == 9 { return "Brandon"; }
        if i == 10 { return "Tyler"; }
        if i == 11 { return "Derek"; }
        if i == 12 { return "Ryan"; }
        if i == 13 { return "Jason"; }
        if i == 14 { return "Kyle"; }
        if i == 15 { return "Trevor"; }
        if i == 16 { return "Nathan"; }
        if i == 17 { return "Sean"; }
        if i == 18 { return "Brian"; }
        if i == 19 { return "Eric"; }
        if i == 20 { return "Adam"; }
        if i == 21 { return "Justin"; }
        if i == 22 { return "Cody"; }
        if i == 23 { return "Aaron"; }
        if i == 24 { return "Jake"; }
        if i == 25 { return "Zach"; }
        if i == 26 { return "Travis"; }
        if i == 27 { return "Blake"; }
        if i == 28 { return "Shane"; }
        if i == 29 { return "Ethan"; }
        if i == 30 { return "Matt"; }
        if i == 31 { return "Chris"; }
        if i == 32 { return "Steve"; }
        if i == 33 { return "Jeff"; }
        return "Scott";
    }

    private static func GetMaleAfricanAmericanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Jerome"; }
        if i == 1 { return "Deshawn"; }
        if i == 2 { return "Jamal"; }
        if i == 3 { return "Tyrone"; }
        if i == 4 { return "Darius"; }
        if i == 5 { return "DeAndre"; }
        if i == 6 { return "Terrell"; }
        if i == 7 { return "Lamar"; }
        if i == 8 { return "Marquis"; }
        if i == 9 { return "Dante"; }
        if i == 10 { return "Malik"; }
        if i == 11 { return "Andre"; }
        if i == 12 { return "Kareem"; }
        if i == 13 { return "Rashid"; }
        if i == 14 { return "Kwame"; }
        if i == 15 { return "Dwayne"; }
        if i == 16 { return "Tyrell"; }
        if i == 17 { return "Jermaine"; }
        if i == 18 { return "Leroy"; }
        if i == 19 { return "Marcus"; }
        if i == 20 { return "Antoine"; }
        if i == 21 { return "Cedric"; }
        if i == 22 { return "Denzel"; }
        if i == 23 { return "Trevon"; }
        return "Jaylon";
    }

    private static func GetMaleHispanicNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 34);
        if i == 0 { return "Carlos"; }
        if i == 1 { return "Antonio"; }
        if i == 2 { return "Miguel"; }
        if i == 3 { return "Alejandro"; }
        if i == 4 { return "Jorge"; }
        if i == 5 { return "Diego"; }
        if i == 6 { return "Raul"; }
        if i == 7 { return "Javier"; }
        if i == 8 { return "Roberto"; }
        if i == 9 { return "Fernando"; }
        if i == 10 { return "Ricardo"; }
        if i == 11 { return "Eduardo"; }
        if i == 12 { return "Luis"; }
        if i == 13 { return "Hector"; }
        if i == 14 { return "Oscar"; }
        if i == 15 { return "Rafael"; }
        if i == 16 { return "Pablo"; }
        if i == 17 { return "Sergio"; }
        if i == 18 { return "Enrique"; }
        if i == 19 { return "Manuel"; }
        if i == 20 { return "Arturo"; }
        if i == 21 { return "Julio"; }
        if i == 22 { return "Gabriel"; }
        if i == 23 { return "Francisco"; }
        if i == 24 { return "Armando"; }
        if i == 25 { return "Cesar"; }
        if i == 26 { return "Ramiro"; }
        if i == 27 { return "Ignacio"; }
        if i == 28 { return "Esteban"; }
        if i == 29 { return "Mateo"; }
        if i == 30 { return "Angel"; }
        if i == 31 { return "Jesus"; }
        if i == 32 { return "Pedro"; }
        if i == 33 { return "Juan"; }
        return "Jose";
    }

    private static func GetMaleJapaneseNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Takeshi"; }
        if i == 1 { return "Hiroshi"; }
        if i == 2 { return "Kenji"; }
        if i == 3 { return "Ryu"; }
        if i == 4 { return "Shinji"; }
        if i == 5 { return "Kazuo"; }
        if i == 6 { return "Akira"; }
        if i == 7 { return "Daichi"; }
        if i == 8 { return "Yuto"; }
        if i == 9 { return "Haruki"; }
        if i == 10 { return "Ren"; }
        if i == 11 { return "Kaito"; }
        if i == 12 { return "Sora"; }
        if i == 13 { return "Hayato"; }
        if i == 14 { return "Kenta"; }
        if i == 15 { return "Masaru"; }
        if i == 16 { return "Shin"; }
        if i == 17 { return "Tetsuya"; }
        if i == 18 { return "Hideki"; }
        if i == 19 { return "Noboru"; }
        if i == 20 { return "Taro"; }
        if i == 21 { return "Koji"; }
        if i == 22 { return "Ichiro"; }
        if i == 23 { return "Goro"; }
        if i == 24 { return "Kenichi"; }
        if i == 25 { return "Saburo"; }
        if i == 26 { return "Yoshi"; }
        if i == 27 { return "Hideo"; }
        if i == 28 { return "Makoto"; }
        return "Satoshi";
    }

    private static func GetMaleChineseNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Wei"; }
        if i == 1 { return "Jun"; }
        if i == 2 { return "Feng"; }
        if i == 3 { return "Lei"; }
        if i == 4 { return "Hao"; }
        if i == 5 { return "Jian"; }
        if i == 6 { return "Ming"; }
        if i == 7 { return "Tao"; }
        if i == 8 { return "Bo"; }
        if i == 9 { return "Cheng"; }
        if i == 10 { return "Long"; }
        if i == 11 { return "Xiang"; }
        if i == 12 { return "Yong"; }
        if i == 13 { return "Zhen"; }
        if i == 14 { return "Hui"; }
        if i == 15 { return "Qiang"; }
        if i == 16 { return "Liang"; }
        if i == 17 { return "Kun"; }
        if i == 18 { return "Dong"; }
        if i == 19 { return "Gang"; }
        if i == 20 { return "Peng"; }
        if i == 21 { return "Jie"; }
        if i == 22 { return "Bing"; }
        if i == 23 { return "Hai"; }
        return "Lin";
    }

    private static func GetMaleKoreanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Jin-ho"; }
        if i == 1 { return "Sung"; }
        if i == 2 { return "Min-jun"; }
        if i == 3 { return "Jae-won"; }
        if i == 4 { return "Hyun"; }
        if i == 5 { return "Seung"; }
        if i == 6 { return "Tae-hyun"; }
        if i == 7 { return "Dong-woo"; }
        if i == 8 { return "Soo-hyun"; }
        if i == 9 { return "Ji-hoon"; }
        if i == 10 { return "Woo-jin"; }
        if i == 11 { return "Kyung"; }
        if i == 12 { return "Sang-hoon"; }
        if i == 13 { return "Yong-jun"; }
        if i == 14 { return "Dae-jung"; }
        if i == 15 { return "Gi-hun"; }
        if i == 16 { return "Sang-woo"; }
        if i == 17 { return "Il-nam"; }
        if i == 18 { return "Deok-su"; }
        if i == 19 { return "Jun-ho"; }
        if i == 20 { return "In-ho"; }
        if i == 21 { return "Chan-wook"; }
        if i == 22 { return "Young-soo"; }
        if i == 23 { return "Byung-hun"; }
        return "Kyu-hyun";
    }

    private static func GetMaleSlavicNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Viktor"; }
        if i == 1 { return "Dmitri"; }
        if i == 2 { return "Alexei"; }
        if i == 3 { return "Yuri"; }
        if i == 4 { return "Sergei"; }
        if i == 5 { return "Nikolai"; }
        if i == 6 { return "Andrei"; }
        if i == 7 { return "Marek"; }
        if i == 8 { return "Pawel"; }
        if i == 9 { return "Ivan"; }
        if i == 10 { return "Boris"; }
        if i == 11 { return "Oleg"; }
        if i == 12 { return "Mikhail"; }
        if i == 13 { return "Konstantin"; }
        if i == 14 { return "Vadim"; }
        if i == 15 { return "Roman"; }
        if i == 16 { return "Stanislav"; }
        if i == 17 { return "Grigori"; }
        if i == 18 { return "Anatoly"; }
        if i == 19 { return "Vladislav"; }
        if i == 20 { return "Piotr"; }
        if i == 21 { return "Wojciech"; }
        if i == 22 { return "Jarek"; }
        if i == 23 { return "Tomasz"; }
        if i == 24 { return "Krzysztof"; }
        if i == 25 { return "Igor"; }
        if i == 26 { return "Vasily"; }
        if i == 27 { return "Maxim"; }
        if i == 28 { return "Arkady"; }
        return "Lev";
    }

    private static func GetMaleIndianNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Raj"; }
        if i == 1 { return "Vikram"; }
        if i == 2 { return "Arjun"; }
        if i == 3 { return "Sanjay"; }
        if i == 4 { return "Ravi"; }
        if i == 5 { return "Deepak"; }
        if i == 6 { return "Anil"; }
        if i == 7 { return "Sunil"; }
        if i == 8 { return "Pradeep"; }
        if i == 9 { return "Amit"; }
        if i == 10 { return "Rahul"; }
        if i == 11 { return "Nikhil"; }
        if i == 12 { return "Ashok"; }
        if i == 13 { return "Kiran"; }
        if i == 14 { return "Rohan"; }
        if i == 15 { return "Varun"; }
        if i == 16 { return "Aditya"; }
        if i == 17 { return "Naveen"; }
        if i == 18 { return "Sachin"; }
        if i == 19 { return "Gaurav"; }
        if i == 20 { return "Abdul"; }
        if i == 21 { return "Vijay"; }
        if i == 22 { return "Prakash"; }
        if i == 23 { return "Suresh"; }
        return "Ramesh";
    }

    private static func GetMaleMiddleEasternNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Omar"; }
        if i == 1 { return "Hassan"; }
        if i == 2 { return "Ahmed"; }
        if i == 3 { return "Khalid"; }
        if i == 4 { return "Tariq"; }
        if i == 5 { return "Yusuf"; }
        if i == 6 { return "Samir"; }
        if i == 7 { return "Faisal"; }
        if i == 8 { return "Nabil"; }
        if i == 9 { return "Karim"; }
        if i == 10 { return "Rashid"; }
        if i == 11 { return "Hamid"; }
        if i == 12 { return "Amir"; }
        if i == 13 { return "Ibrahim"; }
        if i == 14 { return "Reza"; }
        if i == 15 { return "Darius"; }
        if i == 16 { return "Cyrus"; }
        if i == 17 { return "Arash"; }
        if i == 18 { return "Farid"; }
        if i == 19 { return "Jamal"; }
        if i == 20 { return "Mustafa"; }
        if i == 21 { return "Ali"; }
        if i == 22 { return "Mohammed"; }
        if i == 23 { return "Sayed"; }
        return "Walid";
    }

    private static func GetMaleAfricanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Kofi"; }
        if i == 1 { return "Kwame"; }
        if i == 2 { return "Chidi"; }
        if i == 3 { return "Emeka"; }
        if i == 4 { return "Oluwaseun"; }
        if i == 5 { return "Tunde"; }
        if i == 6 { return "Babatunde"; }
        if i == 7 { return "Adewale"; }
        if i == 8 { return "Chijioke"; }
        if i == 9 { return "Nnamdi"; }
        if i == 10 { return "Sekou"; }
        if i == 11 { return "Mamadou"; }
        if i == 12 { return "Ousmane"; }
        if i == 13 { return "Amadou"; }
        if i == 14 { return "Yohannes"; }
        if i == 15 { return "Jean-Baptiste"; }
        if i == 16 { return "Pierre-Louis"; }
        if i == 17 { return "Francois"; }
        if i == 18 { return "Remy"; }
        if i == 19 { return "Jacques"; }
        if i == 20 { return "Emmanuel"; }
        if i == 21 { return "Samuel"; }
        if i == 22 { return "Daniel"; }
        if i == 23 { return "Solomon"; }
        return "Moses";
    }

    private static func GetMaleHaitianNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Jean-Pierre"; }
        if i == 1 { return "Jean-Baptiste"; }
        if i == 2 { return "Pierre-Louis"; }
        if i == 3 { return "Jean-Claude"; }
        if i == 4 { return "Jean-Michel"; }
        if i == 5 { return "Frantz"; }
        if i == 6 { return "Remy"; }
        if i == 7 { return "Jacques"; }
        if i == 8 { return "Wilner"; }
        if i == 9 { return "Mackenson"; }
        if i == 10 { return "Dieudonne"; }
        if i == 11 { return "Emmanuel"; }
        if i == 12 { return "Samuel"; }
        if i == 13 { return "Daniel"; }
        if i == 14 { return "Evens"; }
        if i == 15 { return "Wisly"; }
        if i == 16 { return "Woodly"; }
        if i == 17 { return "Stanley"; }
        if i == 18 { return "Eddy"; }
        if i == 19 { return "Reginald"; }
        if i == 20 { return "Placide"; }
        if i == 21 { return "Toussaint"; }
        if i == 22 { return "Dessalines"; }
        if i == 23 { return "Christophe"; }
        if i == 24 { return "Jude"; }
        if i == 25 { return "Maxo"; }
        if i == 26 { return "Wyclef"; }
        if i == 27 { return "Ti"; }
        if i == 28 { return "Manu"; }
        return "Ricardo";
    }

    private static func GetMaleSoutheastAsianNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Minh"; }
        if i == 1 { return "Duc"; }
        if i == 2 { return "Huy"; }
        if i == 3 { return "Bao"; }
        if i == 4 { return "Tam"; }
        if i == 5 { return "Thien"; }
        if i == 6 { return "Somchai"; }
        if i == 7 { return "Prasert"; }
        if i == 8 { return "Sompong"; }
        if i == 9 { return "Rizal"; }
        if i == 10 { return "Arief"; }
        if i == 11 { return "Budi"; }
        if i == 12 { return "Agus"; }
        if i == 13 { return "Tuan"; }
        if i == 14 { return "Quang"; }
        if i == 15 { return "Thanh"; }
        if i == 16 { return "Phong"; }
        if i == 17 { return "Kiet"; }
        if i == 18 { return "Vinh"; }
        if i == 19 { return "Long"; }
        if i == 20 { return "Duy"; }
        if i == 21 { return "Dat"; }
        if i == 22 { return "Thai"; }
        if i == 23 { return "Nam"; }
        return "Hung";
    }

    private static func GetMaleEuropeanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Jean"; }
        if i == 1 { return "Pierre"; }
        if i == 2 { return "Laurent"; }
        if i == 3 { return "Francois"; }
        if i == 4 { return "Thierry"; }
        if i == 5 { return "Klaus"; }
        if i == 6 { return "Hans"; }
        if i == 7 { return "Wolfgang"; }
        if i == 8 { return "Heinrich"; }
        if i == 9 { return "Fritz"; }
        if i == 10 { return "Marco"; }
        if i == 11 { return "Luca"; }
        if i == 12 { return "Giovanni"; }
        if i == 13 { return "Alessandro"; }
        if i == 14 { return "Matteo"; }
        if i == 15 { return "Lars"; }
        if i == 16 { return "Erik"; }
        if i == 17 { return "Sven"; }
        if i == 18 { return "Magnus"; }
        if i == 19 { return "Bjorn"; }
        if i == 20 { return "Patrick"; }
        if i == 21 { return "Sean"; }
        if i == 22 { return "Connor"; }
        if i == 23 { return "Liam"; }
        return "Declan";
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
        let i = RandRange(seed, 0, 34);
        if i == 0 { return "Sarah"; }
        if i == 1 { return "Jennifer"; }
        if i == 2 { return "Michelle"; }
        if i == 3 { return "Amanda"; }
        if i == 4 { return "Jessica"; }
        if i == 5 { return "Rachel"; }
        if i == 6 { return "Lisa"; }
        if i == 7 { return "Angela"; }
        if i == 8 { return "Stephanie"; }
        if i == 9 { return "Nicole"; }
        if i == 10 { return "Lauren"; }
        if i == 11 { return "Ashley"; }
        if i == 12 { return "Emily"; }
        if i == 13 { return "Megan"; }
        if i == 14 { return "Samantha"; }
        if i == 15 { return "Heather"; }
        if i == 16 { return "Amber"; }
        if i == 17 { return "Crystal"; }
        if i == 18 { return "Brittany"; }
        if i == 19 { return "Courtney"; }
        if i == 20 { return "Kaitlyn"; }
        if i == 21 { return "Hannah"; }
        if i == 22 { return "Madison"; }
        if i == 23 { return "Alexis"; }
        if i == 24 { return "Taylor"; }
        if i == 25 { return "Jordan"; }
        if i == 26 { return "Morgan"; }
        if i == 27 { return "Sydney"; }
        if i == 28 { return "Brooke"; }
        if i == 29 { return "Paige"; }
        if i == 30 { return "Kelly"; }
        if i == 31 { return "Katie"; }
        if i == 32 { return "Lindsey"; }
        if i == 33 { return "Danielle"; }
        return "Christina";
    }

    private static func GetFemaleAfricanAmericanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Tanya"; }
        if i == 1 { return "Keisha"; }
        if i == 2 { return "Brianna"; }
        if i == 3 { return "Destiny"; }
        if i == 4 { return "Jasmine"; }
        if i == 5 { return "Aaliyah"; }
        if i == 6 { return "Shanice"; }
        if i == 7 { return "Tamika"; }
        if i == 8 { return "Latoya"; }
        if i == 9 { return "Diamond"; }
        if i == 10 { return "Precious"; }
        if i == 11 { return "Ebony"; }
        if i == 12 { return "Imani"; }
        if i == 13 { return "Shaniqua"; }
        if i == 14 { return "Monique"; }
        if i == 15 { return "Tanisha"; }
        if i == 16 { return "Shonda"; }
        if i == 17 { return "Lakisha"; }
        if i == 18 { return "Niesha"; }
        if i == 19 { return "Deja"; }
        if i == 20 { return "Tamara"; }
        if i == 21 { return "Yolanda"; }
        if i == 22 { return "Tiffany"; }
        if i == 23 { return "Renee"; }
        return "Jazmin";
    }

    private static func GetFemaleHispanicNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 34);
        if i == 0 { return "Maria"; }
        if i == 1 { return "Rosa"; }
        if i == 2 { return "Carmen"; }
        if i == 3 { return "Sofia"; }
        if i == 4 { return "Valentina"; }
        if i == 5 { return "Isabella"; }
        if i == 6 { return "Gabriela"; }
        if i == 7 { return "Lucia"; }
        if i == 8 { return "Elena"; }
        if i == 9 { return "Ana"; }
        if i == 10 { return "Camila"; }
        if i == 11 { return "Mariana"; }
        if i == 12 { return "Adriana"; }
        if i == 13 { return "Alejandra"; }
        if i == 14 { return "Daniela"; }
        if i == 15 { return "Fernanda"; }
        if i == 16 { return "Natalia"; }
        if i == 17 { return "Veronica"; }
        if i == 18 { return "Catalina"; }
        if i == 19 { return "Marisol"; }
        if i == 20 { return "Esperanza"; }
        if i == 21 { return "Guadalupe"; }
        if i == 22 { return "Xiomara"; }
        if i == 23 { return "Yolanda"; }
        if i == 24 { return "Dolores"; }
        if i == 25 { return "Consuelo"; }
        if i == 26 { return "Raquel"; }
        if i == 27 { return "Pilar"; }
        if i == 28 { return "Ines"; }
        if i == 29 { return "Paloma"; }
        if i == 30 { return "Luz"; }
        if i == 31 { return "Teresa"; }
        if i == 32 { return "Patricia"; }
        if i == 33 { return "Claudia"; }
        return "Diana";
    }

    private static func GetFemaleJapaneseNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Yuki"; }
        if i == 1 { return "Mei"; }
        if i == 2 { return "Akiko"; }
        if i == 3 { return "Sakura"; }
        if i == 4 { return "Haruka"; }
        if i == 5 { return "Mika"; }
        if i == 6 { return "Rina"; }
        if i == 7 { return "Kaori"; }
        if i == 8 { return "Yui"; }
        if i == 9 { return "Aoi"; }
        if i == 10 { return "Hana"; }
        if i == 11 { return "Nanami"; }
        if i == 12 { return "Kana"; }
        if i == 13 { return "Ayumi"; }
        if i == 14 { return "Misaki"; }
        if i == 15 { return "Natsuki"; }
        if i == 16 { return "Saki"; }
        if i == 17 { return "Tomoko"; }
        if i == 18 { return "Keiko"; }
        if i == 19 { return "Noriko"; }
        if i == 20 { return "Mariko"; }
        if i == 21 { return "Kumiko"; }
        if i == 22 { return "Yumiko"; }
        if i == 23 { return "Reiko"; }
        if i == 24 { return "Michiko"; }
        if i == 25 { return "Naomi"; }
        if i == 26 { return "Emi"; }
        if i == 27 { return "Asuka"; }
        if i == 28 { return "Rei"; }
        return "Hikari";
    }

    private static func GetFemaleChineseNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Lin"; }
        if i == 1 { return "Xiao"; }
        if i == 2 { return "Mei-Lin"; }
        if i == 3 { return "Yan"; }
        if i == 4 { return "Jing"; }
        if i == 5 { return "Hua"; }
        if i == 6 { return "Xiu"; }
        if i == 7 { return "Fang"; }
        if i == 8 { return "Li"; }
        if i == 9 { return "Na"; }
        if i == 10 { return "Ying"; }
        if i == 11 { return "Hong"; }
        if i == 12 { return "Lan"; }
        if i == 13 { return "Qing"; }
        if i == 14 { return "Shu"; }
        if i == 15 { return "Wen"; }
        if i == 16 { return "Zhi"; }
        if i == 17 { return "Yun"; }
        if i == 18 { return "Xia"; }
        if i == 19 { return "Mei"; }
        if i == 20 { return "Ling"; }
        if i == 21 { return "Hui"; }
        if i == 22 { return "Min"; }
        if i == 23 { return "Ping"; }
        return "Wei";
    }

    private static func GetFemaleKoreanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Ji-yeon"; }
        if i == 1 { return "Min-ji"; }
        if i == 2 { return "Su-bin"; }
        if i == 3 { return "Hye-jin"; }
        if i == 4 { return "Soo-yeon"; }
        if i == 5 { return "Eun-ji"; }
        if i == 6 { return "Yoon-ah"; }
        if i == 7 { return "Ha-na"; }
        if i == 8 { return "Ae-ri"; }
        if i == 9 { return "Bo-ra"; }
        if i == 10 { return "Da-hye"; }
        if i == 11 { return "Ga-young"; }
        if i == 12 { return "In-young"; }
        if i == 13 { return "Mi-sun"; }
        if i == 14 { return "Sun-hee"; }
        if i == 15 { return "Sae-byeok"; }
        if i == 16 { return "Mi-nyeo"; }
        if i == 17 { return "Ji-yeong"; }
        if i == 18 { return "Young-hee"; }
        if i == 19 { return "Yeon-hee"; }
        if i == 20 { return "Jung-ah"; }
        if i == 21 { return "Hee-jung"; }
        if i == 22 { return "Soo-jin"; }
        if i == 23 { return "Ye-jin"; }
        return "Min-young";
    }

    private static func GetFemaleSlavicNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Natasha"; }
        if i == 1 { return "Svetlana"; }
        if i == 2 { return "Katya"; }
        if i == 3 { return "Olga"; }
        if i == 4 { return "Anna"; }
        if i == 5 { return "Irina"; }
        if i == 6 { return "Anya"; }
        if i == 7 { return "Marta"; }
        if i == 8 { return "Zofia"; }
        if i == 9 { return "Tatiana"; }
        if i == 10 { return "Yelena"; }
        if i == 11 { return "Nadia"; }
        if i == 12 { return "Vera"; }
        if i == 13 { return "Marina"; }
        if i == 14 { return "Galina"; }
        if i == 15 { return "Ludmila"; }
        if i == 16 { return "Valentina"; }
        if i == 17 { return "Oksana"; }
        if i == 18 { return "Yulia"; }
        if i == 19 { return "Daria"; }
        if i == 20 { return "Agnieszka"; }
        if i == 21 { return "Kasia"; }
        if i == 22 { return "Monika"; }
        if i == 23 { return "Ewa"; }
        if i == 24 { return "Beata"; }
        if i == 25 { return "Nina"; }
        if i == 26 { return "Sasha"; }
        if i == 27 { return "Larisa"; }
        if i == 28 { return "Tamara"; }
        return "Zoya";
    }

    private static func GetFemaleIndianNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Priya"; }
        if i == 1 { return "Anita"; }
        if i == 2 { return "Sunita"; }
        if i == 3 { return "Kavita"; }
        if i == 4 { return "Meena"; }
        if i == 5 { return "Deepa"; }
        if i == 6 { return "Anjali"; }
        if i == 7 { return "Pooja"; }
        if i == 8 { return "Neha"; }
        if i == 9 { return "Rani"; }
        if i == 10 { return "Lakshmi"; }
        if i == 11 { return "Geeta"; }
        if i == 12 { return "Radha"; }
        if i == 13 { return "Sita"; }
        if i == 14 { return "Divya"; }
        if i == 15 { return "Rekha"; }
        if i == 16 { return "Asha"; }
        if i == 17 { return "Padma"; }
        if i == 18 { return "Usha"; }
        if i == 19 { return "Nisha"; }
        if i == 20 { return "Meera"; }
        if i == 21 { return "Shanti"; }
        if i == 22 { return "Kamala"; }
        if i == 23 { return "Savitri"; }
        return "Indira";
    }

    private static func GetFemaleMiddleEasternNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Fatima"; }
        if i == 1 { return "Aisha"; }
        if i == 2 { return "Layla"; }
        if i == 3 { return "Yasmin"; }
        if i == 4 { return "Noor"; }
        if i == 5 { return "Salma"; }
        if i == 6 { return "Amira"; }
        if i == 7 { return "Leila"; }
        if i == 8 { return "Samira"; }
        if i == 9 { return "Zara"; }
        if i == 10 { return "Rania"; }
        if i == 11 { return "Maryam"; }
        if i == 12 { return "Farah"; }
        if i == 13 { return "Nadira"; }
        if i == 14 { return "Shirin"; }
        if i == 15 { return "Parisa"; }
        if i == 16 { return "Soraya"; }
        if i == 17 { return "Roxana"; }
        if i == 18 { return "Azadeh"; }
        if i == 19 { return "Nasrin"; }
        if i == 20 { return "Zahra"; }
        if i == 21 { return "Hana"; }
        if i == 22 { return "Sara"; }
        if i == 23 { return "Dina"; }
        return "Mariam";
    }

    private static func GetFemaleAfricanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Amara"; }
        if i == 1 { return "Adaeze"; }
        if i == 2 { return "Chiamaka"; }
        if i == 3 { return "Ngozi"; }
        if i == 4 { return "Nneka"; }
        if i == 5 { return "Adanna"; }
        if i == 6 { return "Folake"; }
        if i == 7 { return "Yetunde"; }
        if i == 8 { return "Aminata"; }
        if i == 9 { return "Mariama"; }
        if i == 10 { return "Awa"; }
        if i == 11 { return "Fatou"; }
        if i == 12 { return "Aissatou"; }
        if i == 13 { return "Tigist"; }
        if i == 14 { return "Makeda"; }
        if i == 15 { return "Marie-Claire"; }
        if i == 16 { return "Josephine"; }
        if i == 17 { return "Claudine"; }
        if i == 18 { return "Nadege"; }
        if i == 19 { return "Esther"; }
        if i == 20 { return "Ruth"; }
        if i == 21 { return "Miriam"; }
        if i == 22 { return "Grace"; }
        if i == 23 { return "Hope"; }
        return "Blessing";
    }

    private static func GetFemaleHaitianNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Marie-Claire"; }
        if i == 1 { return "Marie-Louise"; }
        if i == 2 { return "Marie-Josee"; }
        if i == 3 { return "Nadege"; }
        if i == 4 { return "Mireille"; }
        if i == 5 { return "Fabienne"; }
        if i == 6 { return "Guerline"; }
        if i == 7 { return "Yolande"; }
        if i == 8 { return "Ginette"; }
        if i == 9 { return "Judith"; }
        if i == 10 { return "Roseline"; }
        if i == 11 { return "Claudette"; }
        if i == 12 { return "Carline"; }
        if i == 13 { return "Magalie"; }
        if i == 14 { return "Mimose"; }
        if i == 15 { return "Tifane"; }
        if i == 16 { return "Kettely"; }
        if i == 17 { return "Islande"; }
        if i == 18 { return "Fleurette"; }
        if i == 19 { return "Esther"; }
        if i == 20 { return "Ruth"; }
        if i == 21 { return "Naomi"; }
        if i == 22 { return "Deborah"; }
        if i == 23 { return "Sherly"; }
        if i == 24 { return "Widline"; }
        if i == 25 { return "Lovely"; }
        if i == 26 { return "Dieula"; }
        if i == 27 { return "Venise"; }
        if i == 28 { return "Pascale"; }
        return "Beatrice";
    }

    private static func GetFemaleSoutheastAsianNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Mai"; }
        if i == 1 { return "Linh"; }
        if i == 2 { return "Thi"; }
        if i == 3 { return "Huong"; }
        if i == 4 { return "Thanh"; }
        if i == 5 { return "Lan"; }
        if i == 6 { return "Nguyet"; }
        if i == 7 { return "Nattaya"; }
        if i == 8 { return "Siriwan"; }
        if i == 9 { return "Malee"; }
        if i == 10 { return "Dewi"; }
        if i == 11 { return "Putri"; }
        if i == 12 { return "Siti"; }
        if i == 13 { return "Ratna"; }
        if i == 14 { return "Thao"; }
        if i == 15 { return "Ngoc"; }
        if i == 16 { return "Vy"; }
        if i == 17 { return "Tuyet"; }
        if i == 18 { return "Kim"; }
        if i == 19 { return "Hoa"; }
        if i == 20 { return "Hong"; }
        if i == 21 { return "Phuong"; }
        if i == 22 { return "Trang"; }
        if i == 23 { return "Thu"; }
        return "Anh";
    }

    private static func GetFemaleEuropeanNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Marie"; }
        if i == 1 { return "Sophie"; }
        if i == 2 { return "Chloe"; }
        if i == 3 { return "Camille"; }
        if i == 4 { return "Isabelle"; }
        if i == 5 { return "Greta"; }
        if i == 6 { return "Heidi"; }
        if i == 7 { return "Ingrid"; }
        if i == 8 { return "Frieda"; }
        if i == 9 { return "Hilde"; }
        if i == 10 { return "Giulia"; }
        if i == 11 { return "Francesca"; }
        if i == 12 { return "Chiara"; }
        if i == 13 { return "Alessia"; }
        if i == 14 { return "Bianca"; }
        if i == 15 { return "Astrid"; }
        if i == 16 { return "Freya"; }
        if i == 17 { return "Sigrid"; }
        if i == 18 { return "Helga"; }
        if i == 19 { return "Siobhan"; }
        if i == 20 { return "Aisling"; }
        if i == 21 { return "Niamh"; }
        if i == 22 { return "Fiona"; }
        if i == 23 { return "Brigitte"; }
        return "Monique";
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
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Johnson"; }
        if i == 1 { return "Williams"; }
        if i == 2 { return "Brown"; }
        if i == 3 { return "Davis"; }
        if i == 4 { return "Miller"; }
        if i == 5 { return "Wilson"; }
        if i == 6 { return "Moore"; }
        if i == 7 { return "Taylor"; }
        if i == 8 { return "White"; }
        if i == 9 { return "Clark"; }
        if i == 10 { return "Wright"; }
        if i == 11 { return "Walker"; }
        if i == 12 { return "Scott"; }
        if i == 13 { return "Adams"; }
        if i == 14 { return "Baker"; }
        if i == 15 { return "Nelson"; }
        if i == 16 { return "Carter"; }
        if i == 17 { return "Mitchell"; }
        if i == 18 { return "Roberts"; }
        if i == 19 { return "Turner"; }
        if i == 20 { return "Phillips"; }
        if i == 21 { return "Campbell"; }
        if i == 22 { return "Parker"; }
        if i == 23 { return "Evans"; }
        if i == 24 { return "Edwards"; }
        if i == 25 { return "Collins"; }
        if i == 26 { return "Stewart"; }
        if i == 27 { return "Morris"; }
        if i == 28 { return "Reed"; }
        return "Morgan";
    }

    private static func GetAfricanAmericanLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Jackson"; }
        if i == 1 { return "Harris"; }
        if i == 2 { return "Robinson"; }
        if i == 3 { return "Lewis"; }
        if i == 4 { return "Walker"; }
        if i == 5 { return "Green"; }
        if i == 6 { return "Hall"; }
        if i == 7 { return "Young"; }
        if i == 8 { return "King"; }
        if i == 9 { return "Wright"; }
        if i == 10 { return "Hill"; }
        if i == 11 { return "Scott"; }
        if i == 12 { return "Adams"; }
        if i == 13 { return "Baker"; }
        if i == 14 { return "Carter"; }
        if i == 15 { return "Mitchell"; }
        if i == 16 { return "Turner"; }
        if i == 17 { return "Collins"; }
        if i == 18 { return "Morgan"; }
        if i == 19 { return "Bell"; }
        if i == 20 { return "Washington"; }
        if i == 21 { return "Jefferson"; }
        if i == 22 { return "Freeman"; }
        if i == 23 { return "Brooks"; }
        return "Coleman";
    }

    private static func GetHispanicLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Rodriguez"; }
        if i == 1 { return "Martinez"; }
        if i == 2 { return "Garcia"; }
        if i == 3 { return "Hernandez"; }
        if i == 4 { return "Lopez"; }
        if i == 5 { return "Gonzalez"; }
        if i == 6 { return "Cruz"; }
        if i == 7 { return "Torres"; }
        if i == 8 { return "Reyes"; }
        if i == 9 { return "Santos"; }
        if i == 10 { return "Moreno"; }
        if i == 11 { return "Ramirez"; }
        if i == 12 { return "Diaz"; }
        if i == 13 { return "Flores"; }
        if i == 14 { return "Vasquez"; }
        if i == 15 { return "Castillo"; }
        if i == 16 { return "Jimenez"; }
        if i == 17 { return "Morales"; }
        if i == 18 { return "Ruiz"; }
        if i == 19 { return "Ortiz"; }
        if i == 20 { return "Gutierrez"; }
        if i == 21 { return "Mendoza"; }
        if i == 22 { return "Vargas"; }
        if i == 23 { return "Romero"; }
        if i == 24 { return "Alvarez"; }
        if i == 25 { return "Chavez"; }
        if i == 26 { return "Delgado"; }
        if i == 27 { return "Sandoval"; }
        if i == 28 { return "Aguilar"; }
        return "Medina";
    }

    private static func GetJapaneseLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Tanaka"; }
        if i == 1 { return "Yamamoto"; }
        if i == 2 { return "Nakamura"; }
        if i == 3 { return "Suzuki"; }
        if i == 4 { return "Sato"; }
        if i == 5 { return "Watanabe"; }
        if i == 6 { return "Takahashi"; }
        if i == 7 { return "Kobayashi"; }
        if i == 8 { return "Ito"; }
        if i == 9 { return "Kato"; }
        if i == 10 { return "Yoshida"; }
        if i == 11 { return "Yamada"; }
        if i == 12 { return "Sasaki"; }
        if i == 13 { return "Yamaguchi"; }
        if i == 14 { return "Matsumoto"; }
        if i == 15 { return "Inoue"; }
        if i == 16 { return "Kimura"; }
        if i == 17 { return "Hayashi"; }
        if i == 18 { return "Shimizu"; }
        if i == 19 { return "Yamazaki"; }
        if i == 20 { return "Mori"; }
        if i == 21 { return "Abe"; }
        if i == 22 { return "Ikeda"; }
        if i == 23 { return "Hashimoto"; }
        if i == 24 { return "Ogawa"; }
        if i == 25 { return "Okada"; }
        if i == 26 { return "Arasaka"; }
        if i == 27 { return "Fujimoto"; }
        if i == 28 { return "Nishikawa"; }
        return "Takeda";
    }

    private static func GetChineseLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Chen"; }
        if i == 1 { return "Wang"; }
        if i == 2 { return "Liu"; }
        if i == 3 { return "Zhang"; }
        if i == 4 { return "Li"; }
        if i == 5 { return "Huang"; }
        if i == 6 { return "Yang"; }
        if i == 7 { return "Wu"; }
        if i == 8 { return "Zhou"; }
        if i == 9 { return "Xu"; }
        if i == 10 { return "Sun"; }
        if i == 11 { return "Ma"; }
        if i == 12 { return "Zhu"; }
        if i == 13 { return "Hu"; }
        if i == 14 { return "Guo"; }
        if i == 15 { return "He"; }
        if i == 16 { return "Lin"; }
        if i == 17 { return "Gao"; }
        if i == 18 { return "Luo"; }
        if i == 19 { return "Zheng"; }
        if i == 20 { return "Kang"; }
        if i == 21 { return "Tao"; }
        if i == 22 { return "Feng"; }
        if i == 23 { return "Xie"; }
        return "Cao";
    }

    private static func GetKoreanLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Kim"; }
        if i == 1 { return "Park"; }
        if i == 2 { return "Lee"; }
        if i == 3 { return "Choi"; }
        if i == 4 { return "Jung"; }
        if i == 5 { return "Kang"; }
        if i == 6 { return "Cho"; }
        if i == 7 { return "Yoon"; }
        if i == 8 { return "Jang"; }
        if i == 9 { return "Lim"; }
        if i == 10 { return "Han"; }
        if i == 11 { return "Oh"; }
        if i == 12 { return "Seo"; }
        if i == 13 { return "Shin"; }
        if i == 14 { return "Kwon"; }
        if i == 15 { return "Seong"; }
        if i == 16 { return "Hwang"; }
        if i == 17 { return "Byun"; }
        if i == 18 { return "Ahn"; }
        return "Song";
    }

    private static func GetSlavicLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Volkov"; }
        if i == 1 { return "Petrov"; }
        if i == 2 { return "Ivanov"; }
        if i == 3 { return "Kowalski"; }
        if i == 4 { return "Nowak"; }
        if i == 5 { return "Kovacs"; }
        if i == 6 { return "Novak"; }
        if i == 7 { return "Popov"; }
        if i == 8 { return "Sokolov"; }
        if i == 9 { return "Morozov"; }
        if i == 10 { return "Smirnov"; }
        if i == 11 { return "Kuznetsov"; }
        if i == 12 { return "Fedorov"; }
        if i == 13 { return "Mikhailov"; }
        if i == 14 { return "Nikolaev"; }
        if i == 15 { return "Kozlov"; }
        if i == 16 { return "Stepanov"; }
        if i == 17 { return "Orlov"; }
        if i == 18 { return "Lebedev"; }
        if i == 19 { return "Romanov"; }
        if i == 20 { return "Wisniewski"; }
        if i == 21 { return "Wojciechowski"; }
        if i == 22 { return "Kaminski"; }
        if i == 23 { return "Lewandowski"; }
        return "Zielinski";
    }

    private static func GetIndianLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Patel"; }
        if i == 1 { return "Sharma"; }
        if i == 2 { return "Singh"; }
        if i == 3 { return "Kumar"; }
        if i == 4 { return "Gupta"; }
        if i == 5 { return "Mehta"; }
        if i == 6 { return "Shah"; }
        if i == 7 { return "Rao"; }
        if i == 8 { return "Reddy"; }
        if i == 9 { return "Nair"; }
        if i == 10 { return "Menon"; }
        if i == 11 { return "Joshi"; }
        if i == 12 { return "Desai"; }
        if i == 13 { return "Kapoor"; }
        if i == 14 { return "Malhotra"; }
        if i == 15 { return "Khanna"; }
        if i == 16 { return "Chopra"; }
        if i == 17 { return "Agarwal"; }
        if i == 18 { return "Verma"; }
        if i == 19 { return "Iyer"; }
        if i == 20 { return "Ali"; }
        if i == 21 { return "Khan"; }
        if i == 22 { return "Prasad"; }
        if i == 23 { return "Das"; }
        return "Saxena";
    }

    private static func GetMiddleEasternLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Al-Farsi"; }
        if i == 1 { return "Al-Rashid"; }
        if i == 2 { return "Al-Hassan"; }
        if i == 3 { return "Al-Zahrani"; }
        if i == 4 { return "Al-Qahtani"; }
        if i == 5 { return "Al-Dosari"; }
        if i == 6 { return "Mohammed"; }
        if i == 7 { return "Ibrahim"; }
        if i == 8 { return "Abdullah"; }
        if i == 9 { return "Habibi"; }
        if i == 10 { return "Nazari"; }
        if i == 11 { return "Tehrani"; }
        if i == 12 { return "Shirazi"; }
        if i == 13 { return "Hosseini"; }
        if i == 14 { return "Bakhtiari"; }
        if i == 15 { return "Ahmadi"; }
        if i == 16 { return "Karimi"; }
        if i == 17 { return "Hashemi"; }
        if i == 18 { return "Mousavi"; }
        return "Rahmani";
    }

    private static func GetAfricanLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Okonkwo"; }
        if i == 1 { return "Okafor"; }
        if i == 2 { return "Nwachukwu"; }
        if i == 3 { return "Adeyemi"; }
        if i == 4 { return "Ogundimu"; }
        if i == 5 { return "Bakare"; }
        if i == 6 { return "Mensah"; }
        if i == 7 { return "Asante"; }
        if i == 8 { return "Diallo"; }
        if i == 9 { return "Traore"; }
        if i == 10 { return "Keita"; }
        if i == 11 { return "Cisse"; }
        if i == 12 { return "Mbeki"; }
        if i == 13 { return "Zuma"; }
        if i == 14 { return "Abebe"; }
        if i == 15 { return "Jean-Pierre"; }
        if i == 16 { return "Baptiste"; }
        if i == 17 { return "Celestin"; }
        if i == 18 { return "Beaumont"; }
        return "Toussaint";
    }

    private static func GetHaitianLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Jean-Pierre"; }
        if i == 1 { return "Baptiste"; }
        if i == 2 { return "Celestin"; }
        if i == 3 { return "Beaumont"; }
        if i == 4 { return "Toussaint"; }
        if i == 5 { return "Dessalines"; }
        if i == 6 { return "Christophe"; }
        if i == 7 { return "Louverture"; }
        if i == 8 { return "Pierre-Louis"; }
        if i == 9 { return "Lafontant"; }
        if i == 10 { return "Aristide"; }
        if i == 11 { return "Duvalier"; }
        if i == 12 { return "Preval"; }
        if i == 13 { return "Martelly"; }
        if i == 14 { return "Hyppolite"; }
        if i == 15 { return "Auguste"; }
        if i == 16 { return "Belizaire"; }
        if i == 17 { return "Beauvoir"; }
        if i == 18 { return "Delphin"; }
        if i == 19 { return "Estimable"; }
        if i == 20 { return "Gaston"; }
        if i == 21 { return "Janvier"; }
        if i == 22 { return "Legros"; }
        if i == 23 { return "Narcisse"; }
        if i == 24 { return "Placide"; }
        if i == 25 { return "Raphael"; }
        if i == 26 { return "Simeon"; }
        if i == 27 { return "Theophile"; }
        if i == 28 { return "Vilfort"; }
        return "Zamor";
    }

    private static func GetSoutheastAsianLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Nguyen"; }
        if i == 1 { return "Tran"; }
        if i == 2 { return "Pham"; }
        if i == 3 { return "Le"; }
        if i == 4 { return "Hoang"; }
        if i == 5 { return "Vu"; }
        if i == 6 { return "Bui"; }
        if i == 7 { return "Dang"; }
        if i == 8 { return "Sukhumvit"; }
        if i == 9 { return "Thongchai"; }
        if i == 10 { return "Wijaya"; }
        if i == 11 { return "Gunawan"; }
        if i == 12 { return "Santoso"; }
        if i == 13 { return "Hartono"; }
        if i == 14 { return "Tan"; }
        if i == 15 { return "Do"; }
        if i == 16 { return "Ngo"; }
        if i == 17 { return "Vo"; }
        if i == 18 { return "Trinh"; }
        return "Duong";
    }

    private static func GetEuropeanLastNames(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "O'Brien"; }
        if i == 1 { return "Kelly"; }
        if i == 2 { return "O'Connor"; }
        if i == 3 { return "Walsh"; }
        if i == 4 { return "Schmidt"; }
        if i == 5 { return "Mueller"; }
        if i == 6 { return "Schneider"; }
        if i == 7 { return "Fischer"; }
        if i == 8 { return "Weber"; }
        if i == 9 { return "Meyer"; }
        if i == 10 { return "Wagner"; }
        if i == 11 { return "Becker"; }
        if i == 12 { return "Hoffman"; }
        if i == 13 { return "Richter"; }
        if i == 14 { return "Rossi"; }
        if i == 15 { return "Russo"; }
        if i == 16 { return "Ferrari"; }
        if i == 17 { return "Bianchi"; }
        if i == 18 { return "Romano"; }
        if i == 19 { return "Dubois"; }
        if i == 20 { return "Bernard"; }
        if i == 21 { return "Moreau"; }
        if i == 22 { return "Laurent"; }
        if i == 23 { return "Leroy"; }
        if i == 24 { return "Johansson"; }
        if i == 25 { return "Lindberg"; }
        if i == 26 { return "Eriksson"; }
        if i == 27 { return "Larsson"; }
        if i == 28 { return "Olsen"; }
        return "Murphy";
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
        let i = RandRange(seed, 0, 121);
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
        if i == 99 { return "\"Driver\""; }
        if i == 100 { return "\"Choom\""; }
        if i == 101 { return "\"Gonk\""; }
        if i == 102 { return "\"Preem\""; }
        if i == 103 { return "\"Delta\""; }
        if i == 104 { return "\"Flatline\""; }
        if i == 105 { return "\"Corpo\""; }
        if i == 106 { return "\"Badge\""; }
        if i == 107 { return "\"456\""; }
        if i == 108 { return "\"067\""; }
        if i == 109 { return "\"218\""; }
        if i == 110 { return "\"001\""; }
        if i == 111 { return "\"Front Man\""; }
        if i == 112 { return "\"Red Light\""; }
        if i == 113 { return "\"Green Light\""; }
        if i == 114 { return "\"Six\""; }
        if i == 115 { return "\"Seven\""; }
        if i == 116 { return "\"Ace\""; }
        if i == 117 { return "\"Solo\""; }
        if i == 118 { return "\"Prime\""; }
        if i == 119 { return "\"Omega\""; }
        if i == 120 { return "\"Alpha\""; }
        return "\"X\"";
    }
}
