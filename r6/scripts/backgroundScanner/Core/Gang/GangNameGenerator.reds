// Gang Member Name Generation System
// Generates culturally appropriate names and gang-specific aliases for generic gang NPCs
public class KdspGangNameGenerator {

    public static func Generate(seed: Int32, gangAffiliation: String, gender: String, ethnicity: KdspNPCEthnicity) -> ref<KdspGangMemberNameData> {
        let data: ref<KdspGangMemberNameData> = new KdspGangMemberNameData();

        // Override ethnicity based on gang affiliation for lore accuracy
        // Some gangs recruit specific demographics; others are diverse
        let gangEthnicity = KdspGangNameGenerator.GetGangEthnicity(seed, gangAffiliation, ethnicity);

        // Generate real name from ethnicity-appropriate pool
        data.fullName = KdspNameGenerator.GenerateFullNameByEthnicity(seed, gender, gangEthnicity);
        data.firstName = KdspNameGenerator.GetFirstNameByEthnicity(seed, gender, gangEthnicity);
        data.lastName = KdspNameGenerator.GetLastNameByEthnicity(seed + 100, gangEthnicity);

        // Generate street alias — chance-based, not every gangster has one
        let aliasRoll = RandRange(seed + 200, 1, 100);
        if aliasRoll <= 65 {
            // 65% chance of having a street alias
            data.alias = KdspGangNameGenerator.GetGangAlias(seed + 300, gangAffiliation);
            data.hasAlias = true;
        } else {
            data.alias = "";
            data.hasAlias = false;
        }

        return data;
    }

    // Build the display string: "Razor" Kenji Tanaka  or  Maria Vasquez
    public static func GetDisplayName(data: ref<KdspGangMemberNameData>) -> String {
        if data.hasAlias {
            return "\"" + data.alias + "\" " + data.fullName;
        }
        return data.fullName;
    }

    // Gang-appropriate ethnicity routing
    // Lore-accurate: Tyger Claws are Asian, Valentinos are Hispanic, etc.
    // Diverse gangs (Animals, Moxes) use the NPC's detected ethnicity
    private static func GetGangEthnicity(seed: Int32, gang: String, detectedEthnicity: KdspNPCEthnicity) -> KdspNPCEthnicity {
        if Equals(gang, "TYGER_CLAWS") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 50 { return KdspNPCEthnicity.Japanese; }
            if roll <= 75 { return KdspNPCEthnicity.Chinese; }
            return KdspNPCEthnicity.Korean;
        }
        if Equals(gang, "VALENTINOS") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 85 { return KdspNPCEthnicity.Hispanic; }
            return KdspNPCEthnicity.American;
        }
        if Equals(gang, "VOODOO_BOYS") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 80 { return KdspNPCEthnicity.Haitian; }
            return KdspNPCEthnicity.African;
        }
        if Equals(gang, "MAELSTROM") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 40 { return KdspNPCEthnicity.Slavic; }
            if roll <= 70 { return KdspNPCEthnicity.European; }
            return KdspNPCEthnicity.American;
        }
        if Equals(gang, "6TH_STREET") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 55 { return KdspNPCEthnicity.American; }
            if roll <= 80 { return KdspNPCEthnicity.AfricanAmerican; }
            return KdspNPCEthnicity.Hispanic;
        }
        if Equals(gang, "SCAVENGERS") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 60 { return KdspNPCEthnicity.Slavic; }
            if roll <= 85 { return KdspNPCEthnicity.European; }
            return KdspNPCEthnicity.American;
        }
        if Equals(gang, "WRAITHS") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 60 { return KdspNPCEthnicity.American; }
            if roll <= 80 { return KdspNPCEthnicity.Hispanic; }
            return KdspNPCEthnicity.European;
        }
        if Equals(gang, "ALDECALDOS") {
            let roll = RandRange(seed + 500, 1, 100);
            if roll <= 60 { return KdspNPCEthnicity.Hispanic; }
            if roll <= 85 { return KdspNPCEthnicity.American; }
            return KdspNPCEthnicity.Indian;
        }
        // Animals, Moxes, and others — diverse, use detected ethnicity
        // If detected as Mixed/unknown, randomize
        if Equals(EnumInt(detectedEthnicity), EnumInt(KdspNPCEthnicity.Mixed)) {
            return KdspEthnicityDetector.GetRandomEthnicity(seed + 600);
        }
        return detectedEthnicity;
    }

    // Gang-specific street aliases
    private static func GetGangAlias(seed: Int32, gang: String) -> String {
        if Equals(gang, "TYGER_CLAWS") { return KdspGangNameGenerator.GetTygerClawAlias(seed); }
        if Equals(gang, "VALENTINOS") { return KdspGangNameGenerator.GetValentinoAlias(seed); }
        if Equals(gang, "MAELSTROM") { return KdspGangNameGenerator.GetMaelstromAlias(seed); }
        if Equals(gang, "ANIMALS") { return KdspGangNameGenerator.GetAnimalsAlias(seed); }
        if Equals(gang, "6TH_STREET") { return KdspGangNameGenerator.GetSixthStreetAlias(seed); }
        if Equals(gang, "VOODOO_BOYS") { return KdspGangNameGenerator.GetVoodooBoysAlias(seed); }
        if Equals(gang, "MOXES") { return KdspGangNameGenerator.GetMoxesAlias(seed); }
        if Equals(gang, "SCAVENGERS") { return KdspGangNameGenerator.GetScavengersAlias(seed); }
        if Equals(gang, "WRAITHS") { return KdspGangNameGenerator.GetWraithsAlias(seed); }
        if Equals(gang, "ALDECALDOS") { return KdspGangNameGenerator.GetAldecaldosAlias(seed); }
        return KdspGangNameGenerator.GetGenericAlias(seed);
    }

    // === TYGER CLAWS — Japanese underworld style ===
    private static func GetTygerClawAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Razor"; }
        if roll == 1 { return "Oni"; }
        if roll == 2 { return "Kitsune"; }
        if roll == 3 { return "Ronin"; }
        if roll == 4 { return "Neon"; }
        if roll == 5 { return "Katana"; }
        if roll == 6 { return "Silent"; }
        if roll == 7 { return "Viper"; }
        if roll == 8 { return "Tengu"; }
        if roll == 9 { return "Shiv"; }
        if roll == 10 { return "Zero"; }
        if roll == 11 { return "Fang"; }
        if roll == 12 { return "Neko"; }
        if roll == 13 { return "Washi"; }
        if roll == 14 { return "Tanto"; }
        if roll == 15 { return "Kage"; }
        if roll == 16 { return "Smoke"; }
        if roll == 17 { return "Jade"; }
        if roll == 18 { return "Inari"; }
        if roll == 19 { return "Sting"; }
        if roll == 20 { return "Raijin"; }
        if roll == 21 { return "Hebi"; }
        if roll == 22 { return "Flash"; }
        if roll == 23 { return "Kumo"; }
        if roll == 24 { return "Sickle"; }
        if roll == 25 { return "Red Eye"; }
        if roll == 26 { return "Hannya"; }
        if roll == 27 { return "Yasha"; }
        if roll == 28 { return "Shinobi"; }
        return "Gin";
    }

    // === VALENTINOS — Spanish street names ===
    private static func GetValentinoAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "El Santo"; }
        if roll == 1 { return "Lobo"; }
        if roll == 2 { return "Diablo"; }
        if roll == 3 { return "Fuego"; }
        if roll == 4 { return "Muerte"; }
        if roll == 5 { return "Corazón"; }
        if roll == 6 { return "Sombra"; }
        if roll == 7 { return "Cruz"; }
        if roll == 8 { return "Toro"; }
        if roll == 9 { return "Escorpión"; }
        if roll == 10 { return "Veneno"; }
        if roll == 11 { return "Relámpago"; }
        if roll == 12 { return "Fantasma"; }
        if roll == 13 { return "Oro"; }
        if roll == 14 { return "Cuchillo"; }
        if roll == 15 { return "Hueso"; }
        if roll == 16 { return "Rey"; }
        if roll == 17 { return "Sangre"; }
        if roll == 18 { return "Víbora"; }
        if roll == 19 { return "Bravo"; }
        if roll == 20 { return "Serpiente"; }
        if roll == 21 { return "Demonio"; }
        if roll == 22 { return "Flaco"; }
        if roll == 23 { return "Trueno"; }
        if roll == 24 { return "Calavera"; }
        if roll == 25 { return "Pistola"; }
        if roll == 26 { return "Halcón"; }
        if roll == 27 { return "Hermano"; }
        if roll == 28 { return "Chingón"; }
        return "La Sombra";
    }

    // === MAELSTROM — Tech/chrome handles ===
    private static func GetMaelstromAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Glitch"; }
        if roll == 1 { return "Voltex"; }
        if roll == 2 { return "Flatline"; }
        if roll == 3 { return "Chrome"; }
        if roll == 4 { return "Splinter"; }
        if roll == 5 { return "Bypass"; }
        if roll == 6 { return "Wrench"; }
        if roll == 7 { return "Optic"; }
        if roll == 8 { return "Corrode"; }
        if roll == 9 { return "Daemon"; }
        if roll == 10 { return "Null"; }
        if roll == 11 { return "Rivet"; }
        if roll == 12 { return "Torque"; }
        if roll == 13 { return "Wire"; }
        if roll == 14 { return "Solder"; }
        if roll == 15 { return "Scalpel"; }
        if roll == 16 { return "Arc"; }
        if roll == 17 { return "Drill"; }
        if roll == 18 { return "Hex"; }
        if roll == 19 { return "Spark"; }
        if roll == 20 { return "Meltdown"; }
        if roll == 21 { return "Strobe"; }
        if roll == 22 { return "Fuse"; }
        if roll == 23 { return "Grinder"; }
        if roll == 24 { return "Piston"; }
        if roll == 25 { return "Slag"; }
        if roll == 26 { return "Hollow"; }
        if roll == 27 { return "Blitz"; }
        if roll == 28 { return "Clamp"; }
        return "Rust";
    }

    // === ANIMALS — Strength/beast handles ===
    private static func GetAnimalsAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Bull"; }
        if roll == 1 { return "Rhino"; }
        if roll == 2 { return "Hammer"; }
        if roll == 3 { return "Brick"; }
        if roll == 4 { return "Tank"; }
        if roll == 5 { return "Gorilla"; }
        if roll == 6 { return "Rampage"; }
        if roll == 7 { return "Crush"; }
        if roll == 8 { return "Iron"; }
        if roll == 9 { return "Grizzly"; }
        if roll == 10 { return "Boulder"; }
        if roll == 11 { return "Spine"; }
        if roll == 12 { return "Mauler"; }
        if roll == 13 { return "Mammoth"; }
        if roll == 14 { return "Savage"; }
        if roll == 15 { return "Pit"; }
        if roll == 16 { return "Jackal"; }
        if roll == 17 { return "Kong"; }
        if roll == 18 { return "Bruiser"; }
        if roll == 19 { return "Slab"; }
        if roll == 20 { return "Feral"; }
        if roll == 21 { return "Apex"; }
        if roll == 22 { return "Boar"; }
        if roll == 23 { return "Flex"; }
        if roll == 24 { return "Hyena"; }
        if roll == 25 { return "Stampede"; }
        if roll == 26 { return "Brute"; }
        if roll == 27 { return "Titan"; }
        if roll == 28 { return "Bison"; }
        return "Beast";
    }

    // === 6TH STREET — Military callsigns ===
    private static func GetSixthStreetAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Gunner"; }
        if roll == 1 { return "Sarge"; }
        if roll == 2 { return "Hawk"; }
        if roll == 3 { return "Duke"; }
        if roll == 4 { return "Maverick"; }
        if roll == 5 { return "Patriot"; }
        if roll == 6 { return "Eagle"; }
        if roll == 7 { return "Brass"; }
        if roll == 8 { return "Vanguard"; }
        if roll == 9 { return "Bulldog"; }
        if roll == 10 { return "Valor"; }
        if roll == 11 { return "Top"; }
        if roll == 12 { return "Reaper"; }
        if roll == 13 { return "Blaze"; }
        if roll == 14 { return "Steel"; }
        if roll == 15 { return "Ranger"; }
        if roll == 16 { return "Wolf"; }
        if roll == 17 { return "Scope"; }
        if roll == 18 { return "Trigger"; }
        if roll == 19 { return "Mustang"; }
        if roll == 20 { return "Chief"; }
        if roll == 21 { return "Nomad"; }
        if roll == 22 { return "Hound"; }
        if roll == 23 { return "Buckshot"; }
        if roll == 24 { return "Ramrod"; }
        if roll == 25 { return "Yankee"; }
        if roll == 26 { return "Liberty"; }
        if roll == 27 { return "Caliber"; }
        if roll == 28 { return "Foxhound"; }
        return "Flag";
    }

    // === VOODOO BOYS — Vodou/Creole handles ===
    private static func GetVoodooBoysAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Baron"; }
        if roll == 1 { return "Mambo"; }
        if roll == 2 { return "Gris-Gris"; }
        if roll == 3 { return "Loa"; }
        if roll == 4 { return "Shadow"; }
        if roll == 5 { return "Ogun"; }
        if roll == 6 { return "Root"; }
        if roll == 7 { return "Duppy"; }
        if roll == 8 { return "Hex"; }
        if roll == 9 { return "Legba"; }
        if roll == 10 { return "Bone"; }
        if roll == 11 { return "Mojo"; }
        if roll == 12 { return "Marasa"; }
        if roll == 13 { return "Ti Chwal"; }
        if roll == 14 { return "Damballa"; }
        if roll == 15 { return "Deep"; }
        if roll == 16 { return "Crossroads"; }
        if roll == 17 { return "Papa"; }
        if roll == 18 { return "Spirit"; }
        if roll == 19 { return "Tide"; }
        if roll == 20 { return "Agwe"; }
        if roll == 21 { return "Erzulie"; }
        if roll == 22 { return "Sousson"; }
        if roll == 23 { return "Ghede"; }
        if roll == 24 { return "Wanga"; }
        if roll == 25 { return "Serpent"; }
        if roll == 26 { return "Petro"; }
        if roll == 27 { return "Ogoun"; }
        if roll == 28 { return "Ti Malice"; }
        return "Baka";
    }

    // === MOXES — Stage/persona names ===
    private static func GetMoxesAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Glitter"; }
        if roll == 1 { return "Nails"; }
        if roll == 2 { return "Cherry"; }
        if roll == 3 { return "Riot"; }
        if roll == 4 { return "Velvet"; }
        if roll == 5 { return "Stiletto"; }
        if roll == 6 { return "Pixie"; }
        if roll == 7 { return "Vixen"; }
        if roll == 8 { return "Siren"; }
        if roll == 9 { return "Bliss"; }
        if roll == 10 { return "Scarlet"; }
        if roll == 11 { return "Thorn"; }
        if roll == 12 { return "Diva"; }
        if roll == 13 { return "Razor Kiss"; }
        if roll == 14 { return "Neon"; }
        if roll == 15 { return "Muse"; }
        if roll == 16 { return "Venom"; }
        if roll == 17 { return "Sugar"; }
        if roll == 18 { return "Pepper"; }
        if roll == 19 { return "Storm"; }
        if roll == 20 { return "Jinx"; }
        if roll == 21 { return "Fury"; }
        if roll == 22 { return "Lacquer"; }
        if roll == 23 { return "Dollface"; }
        if roll == 24 { return "Switchblade"; }
        if roll == 25 { return "Karma"; }
        if roll == 26 { return "Toxic"; }
        if roll == 27 { return "Venus"; }
        if roll == 28 { return "Malice"; }
        return "Candy";
    }

    // === SCAVENGERS — Dark/organ trade handles ===
    private static func GetScavengersAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Butcher"; }
        if roll == 1 { return "Reaper"; }
        if roll == 2 { return "Scalpel"; }
        if roll == 3 { return "Maggot"; }
        if roll == 4 { return "Carrion"; }
        if roll == 5 { return "Harvest"; }
        if roll == 6 { return "Cleaver"; }
        if roll == 7 { return "Marrow"; }
        if roll == 8 { return "Rot"; }
        if roll == 9 { return "Vulture"; }
        if roll == 10 { return "Stitch"; }
        if roll == 11 { return "Gutter"; }
        if roll == 12 { return "Parasite"; }
        if roll == 13 { return "Carcass"; }
        if roll == 14 { return "Bile"; }
        if roll == 15 { return "Husk"; }
        if roll == 16 { return "Sawbone"; }
        if roll == 17 { return "Liver"; }
        if roll == 18 { return "Needle"; }
        if roll == 19 { return "Filth"; }
        if roll == 20 { return "Crow"; }
        if roll == 21 { return "Gash"; }
        if roll == 22 { return "Blight"; }
        if roll == 23 { return "Gut"; }
        if roll == 24 { return "Flenser"; }
        if roll == 25 { return "Offal"; }
        if roll == 26 { return "Bones"; }
        if roll == 27 { return "Sepsis"; }
        if roll == 28 { return "Sinew"; }
        return "Leech";
    }

    // === WRAITHS — Road warrior handles ===
    private static func GetWraithsAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Dust"; }
        if roll == 1 { return "Roadkill"; }
        if roll == 2 { return "Phantom"; }
        if roll == 3 { return "Gasoline"; }
        if roll == 4 { return "Mirage"; }
        if roll == 5 { return "Sandstorm"; }
        if roll == 6 { return "Axle"; }
        if roll == 7 { return "Burnout"; }
        if roll == 8 { return "Jackal"; }
        if roll == 9 { return "Scorcher"; }
        if roll == 10 { return "Haunt"; }
        if roll == 11 { return "Nitro"; }
        if roll == 12 { return "Rattlesnake"; }
        if roll == 13 { return "Vulture"; }
        if roll == 14 { return "Skid"; }
        if roll == 15 { return "Deadpan"; }
        if roll == 16 { return "Coyote"; }
        if roll == 17 { return "Diesel"; }
        if roll == 18 { return "Shade"; }
        if roll == 19 { return "Flatbed"; }
        if roll == 20 { return "Prowler"; }
        if roll == 21 { return "Smoke"; }
        if roll == 22 { return "Scorch"; }
        if roll == 23 { return "Rustbelt"; }
        if roll == 24 { return "Howler"; }
        if roll == 25 { return "Wasteland"; }
        if roll == 26 { return "Raven"; }
        if roll == 27 { return "Tumbleweed"; }
        if roll == 28 { return "Haze"; }
        return "Sidewinder";
    }

    // === ALDECALDOS — Road/family names ===
    private static func GetAldecaldosAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Dusty"; }
        if roll == 1 { return "Wheels"; }
        if roll == 2 { return "Compass"; }
        if roll == 3 { return "Cactus"; }
        if roll == 4 { return "Blacktop"; }
        if roll == 5 { return "Mesa"; }
        if roll == 6 { return "Sundown"; }
        if roll == 7 { return "Jackrabbit"; }
        if roll == 8 { return "Ridge"; }
        if roll == 9 { return "Trailhead"; }
        if roll == 10 { return "Breeze"; }
        if roll == 11 { return "Longhaul"; }
        if roll == 12 { return "Roadrunner"; }
        if roll == 13 { return "Horizon"; }
        if roll == 14 { return "Gearshift"; }
        if roll == 15 { return "Skyline"; }
        if roll == 16 { return "Ember"; }
        if roll == 17 { return "Prairie"; }
        if roll == 18 { return "Rattler"; }
        if roll == 19 { return "Convoy"; }
        if roll == 20 { return "Gravel"; }
        if roll == 21 { return "Outrider"; }
        if roll == 22 { return "Drifter"; }
        if roll == 23 { return "Buckaroo"; }
        if roll == 24 { return "Tread"; }
        if roll == 25 { return "Windbreak"; }
        if roll == 26 { return "Overpass"; }
        if roll == 27 { return "Hardpan"; }
        if roll == 28 { return "Freeway"; }
        return "Mile";
    }

    // === GENERIC FALLBACK ===
    private static func GetGenericAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 19);
        if roll == 0 { return "Ghost"; }
        if roll == 1 { return "Snake"; }
        if roll == 2 { return "Chrome"; }
        if roll == 3 { return "Razor"; }
        if roll == 4 { return "Venom"; }
        if roll == 5 { return "Spike"; }
        if roll == 6 { return "Switch"; }
        if roll == 7 { return "Shade"; }
        if roll == 8 { return "Bullet"; }
        if roll == 9 { return "Prowl"; }
        if roll == 10 { return "Ash"; }
        if roll == 11 { return "Flicker"; }
        if roll == 12 { return "Torch"; }
        if roll == 13 { return "Scratch"; }
        if roll == 14 { return "Fuse"; }
        if roll == 15 { return "Wraith"; }
        if roll == 16 { return "Jackhammer"; }
        if roll == 17 { return "Tack"; }
        if roll == 18 { return "Splint"; }
        return "Nail";
    }

    // Check if an NPC's display name is a generic gang label
    public static func IsGenericGangName(displayName: String) -> Bool {
        // Empty or very short
        if Equals(displayName, "") || StrLen(displayName) < 3 { return true; }
        // LocKey means unresolved localization — generic
        if StrContains(displayName, "LocKey") { return true; }
        // Common generic gang display names from the game
        if Equals(displayName, "None") || Equals(displayName, "Enemy") { return true; }
        // Tyger Claws
        if Equals(displayName, "Tyger Claws") || Equals(displayName, "Tyger Claw") { return true; }
        if StrContains(displayName, "Tyger Claws") && StrLen(displayName) <= 25 { return true; }
        // Maelstrom
        if Equals(displayName, "Maelstrom") || Equals(displayName, "Maelstromer") { return true; }
        if StrContains(displayName, "Maelstrom") && StrLen(displayName) <= 25 { return true; }
        // Valentinos
        if Equals(displayName, "Valentinos") || Equals(displayName, "Valentino") { return true; }
        if StrContains(displayName, "Valentino") && StrLen(displayName) <= 25 { return true; }
        // 6th Street
        if Equals(displayName, "6th Street") { return true; }
        if StrContains(displayName, "6th Street") && StrLen(displayName) <= 25 { return true; }
        // Animals
        if Equals(displayName, "Animals") || Equals(displayName, "Animal") { return true; }
        if StrContains(displayName, "Animals") && StrLen(displayName) <= 25 { return true; }
        // Voodoo Boys
        if Equals(displayName, "Voodoo Boys") || Equals(displayName, "Voodoo Boy") { return true; }
        if StrContains(displayName, "Voodoo") && StrLen(displayName) <= 25 { return true; }
        // Moxes
        if Equals(displayName, "Mox") || Equals(displayName, "Moxes") || Equals(displayName, "The Moxes") { return true; }
        // Scavengers
        if Equals(displayName, "Scavenger") || Equals(displayName, "Scavengers") || Equals(displayName, "Scav") { return true; }
        // Wraiths
        if Equals(displayName, "Wraith") || Equals(displayName, "Wraiths") { return true; }
        // Aldecaldos
        if Equals(displayName, "Aldecaldo") || Equals(displayName, "Aldecaldos") { return true; }
        // Generic combat labels
        if Equals(displayName, "Gangster") || Equals(displayName, "Gang Member") || Equals(displayName, "Thug") { return true; }
        if Equals(displayName, "Ganger") || Equals(displayName, "Criminal") || Equals(displayName, "Bandit") { return true; }
        if Equals(displayName, "Fighter") || Equals(displayName, "Brawler") || Equals(displayName, "Soldier") { return true; }
        if Equals(displayName, "Sniper") || Equals(displayName, "Netrunner") || Equals(displayName, "Psycho") { return true; }
        return false;
    }
}

// Data class for gang member name generation
public class KdspGangMemberNameData {
    public let fullName: String;
    public let firstName: String;
    public let lastName: String;
    public let alias: String;
    public let hasAlias: Bool;
}
