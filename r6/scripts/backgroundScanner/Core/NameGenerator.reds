// Shared Name Generation Utility
public class NameGenerator {

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

    public static func GetMaleFirstName(seed: Int32) -> String {
        let names: array<String>;
        
        // American/English
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
        ArrayPush(names, "Jerome");
        ArrayPush(names, "Deshawn");
        ArrayPush(names, "Jamal");
        ArrayPush(names, "Tyler");
        ArrayPush(names, "Derek");
        
        // Hispanic/Latino
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
        
        // Japanese
        ArrayPush(names, "Takeshi");
        ArrayPush(names, "Hiroshi");
        ArrayPush(names, "Kenji");
        ArrayPush(names, "Ryu");
        ArrayPush(names, "Shinji");
        ArrayPush(names, "Kazuo");
        ArrayPush(names, "Akira");
        ArrayPush(names, "Daichi");
        
        // Chinese/Korean
        ArrayPush(names, "Chen Wei");
        ArrayPush(names, "Liu Yang");
        ArrayPush(names, "Zhang Min");
        ArrayPush(names, "Jin-ho");
        ArrayPush(names, "Sung");
        ArrayPush(names, "Min-jun");
        
        // Slavic/Eastern European
        ArrayPush(names, "Viktor");
        ArrayPush(names, "Dmitri");
        ArrayPush(names, "Alexei");
        ArrayPush(names, "Yuri");
        ArrayPush(names, "Sergei");
        ArrayPush(names, "Nikolai");
        ArrayPush(names, "Andrei");
        ArrayPush(names, "Marek");
        ArrayPush(names, "Pawel");
        
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    public static func GetFemaleFirstName(seed: Int32) -> String {
        let names: array<String>;
        
        // American/English
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
        ArrayPush(names, "Tanya");
        ArrayPush(names, "Keisha");
        ArrayPush(names, "Brianna");
        ArrayPush(names, "Destiny");
        ArrayPush(names, "Jasmine");
        
        // Hispanic/Latino
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
        
        // Japanese
        ArrayPush(names, "Yuki");
        ArrayPush(names, "Mei");
        ArrayPush(names, "Akiko");
        ArrayPush(names, "Sakura");
        ArrayPush(names, "Haruka");
        ArrayPush(names, "Mika");
        ArrayPush(names, "Rina");
        ArrayPush(names, "Kaori");
        
        // Chinese/Korean
        ArrayPush(names, "Lin");
        ArrayPush(names, "Xiao");
        ArrayPush(names, "Mei-Lin");
        ArrayPush(names, "Ji-yeon");
        ArrayPush(names, "Min-ji");
        ArrayPush(names, "Su-bin");
        
        // Slavic/Eastern European
        ArrayPush(names, "Natasha");
        ArrayPush(names, "Svetlana");
        ArrayPush(names, "Katya");
        ArrayPush(names, "Olga");
        ArrayPush(names, "Anna");
        ArrayPush(names, "Irina");
        ArrayPush(names, "Anya");
        ArrayPush(names, "Marta");
        ArrayPush(names, "Zofia");
        
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    public static func GetLastName(seed: Int32) -> String {
        let names: array<String>;
        
        // American/English
        ArrayPush(names, "Johnson");
        ArrayPush(names, "Williams");
        ArrayPush(names, "Brown");
        ArrayPush(names, "Davis");
        ArrayPush(names, "Miller");
        ArrayPush(names, "Wilson");
        ArrayPush(names, "Moore");
        ArrayPush(names, "Taylor");
        ArrayPush(names, "Jackson");
        ArrayPush(names, "White");
        ArrayPush(names, "Harris");
        ArrayPush(names, "Clark");
        ArrayPush(names, "Wright");
        ArrayPush(names, "Walker");
        ArrayPush(names, "Scott");
        
        // Hispanic/Latino
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
        
        // Japanese
        ArrayPush(names, "Tanaka");
        ArrayPush(names, "Yamamoto");
        ArrayPush(names, "Nakamura");
        ArrayPush(names, "Suzuki");
        ArrayPush(names, "Sato");
        ArrayPush(names, "Watanabe");
        ArrayPush(names, "Takahashi");
        ArrayPush(names, "Kobayashi");
        
        // Chinese/Korean
        ArrayPush(names, "Chen");
        ArrayPush(names, "Wang");
        ArrayPush(names, "Liu");
        ArrayPush(names, "Zhang");
        ArrayPush(names, "Kim");
        ArrayPush(names, "Park");
        ArrayPush(names, "Lee");
        ArrayPush(names, "Choi");
        
        // Slavic/Eastern European
        ArrayPush(names, "Volkov");
        ArrayPush(names, "Petrov");
        ArrayPush(names, "Ivanov");
        ArrayPush(names, "Kowalski");
        ArrayPush(names, "Nowak");
        ArrayPush(names, "Kovacs");
        ArrayPush(names, "Novak");
        
        // Irish/Other
        ArrayPush(names, "O'Brien");
        ArrayPush(names, "Murphy");
        ArrayPush(names, "Kelly");
        ArrayPush(names, "Schmidt");
        ArrayPush(names, "Mueller");
        
        return names[RandRange(seed, 0, ArraySize(names) - 1)];
    }

    public static func GetStreetAlias(seed: Int32) -> String {
        let aliases: array<String>;

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

        return "\"" + aliases[RandRange(seed, 0, ArraySize(aliases) - 1)] + "\"";
    }

    // Random gender for NPCs where we don't know
    public static func GetRandomGender(seed: Int32) -> String {
        if RandRange(seed, 0, 100) < 50 {
            return "male";
        }
        return "female";
    }
}
