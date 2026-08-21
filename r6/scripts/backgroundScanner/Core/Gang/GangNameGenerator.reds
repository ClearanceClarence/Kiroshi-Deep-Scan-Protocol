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
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T15"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T0"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T1"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T12"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T2"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T3"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T4"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T2"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T5"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T6"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T7"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T8"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T9"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T10"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T11"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T12"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T13"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T14"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T15"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T16"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T17"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T18"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T19"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T20"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T21"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T22"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T23"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T24"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T25"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T26");
    }

    // === VALENTINOS — Spanish street names ===
    private static func GetValentinoAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T27"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T28"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T29"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T30"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T31"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T32"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T33"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T34"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T35"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T36"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T37"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T38"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T39"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T40"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T41"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T42"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T43"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T44"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T45"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T46"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T47"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T48"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T49"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T50"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T51"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T52"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T53"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T54"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T55"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T56");
    }

    // === MAELSTROM — Tech/chrome handles ===
    private static func GetMaelstromAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T57"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T58"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T59"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T60"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T61"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T62"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T63"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T64"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T65"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T66"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T67"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T68"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T69"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T70"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T71"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T72"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T73"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T74"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T75"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T76"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T77"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T78"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T79"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T80"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T81"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T82"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T83"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T84"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T85"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T86");
    }

    // === ANIMALS — Strength/beast handles ===
    private static func GetAnimalsAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T87"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T88"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T89"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T90"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T91"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-U13"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T92"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T93"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T94"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T95"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T96"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T97"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T98"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T99"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T100"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T101"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T7"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T102"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T103"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T104"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T105"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U1"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T106"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T107"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T108"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T109"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T110"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T11"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T111"); }
        return GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-U1");
    }

    // === 6TH STREET — Military callsigns ===
    private static func GetSixthStreetAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T112"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T113"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T6"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T114"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T115"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T116"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T117"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T118"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T119"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T120"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T121"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T122"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T0"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T123"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T124"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T125"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T5"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T126"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T127"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T128"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T129"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T10"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T3"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T130"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T131"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T132"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T133"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T134"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T135"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T136");
    }

    // === VOODOO BOYS — Vodou/Creole handles ===
    private static func GetVoodooBoysAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T137"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T138"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T139"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T140"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T13"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T141"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T142"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T143"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T75"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T144"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T145"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T146"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T147"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T148"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T149"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T150"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T151"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T152"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T153"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T154"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T155"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T156"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T157"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T158"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T159"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T160"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T161"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T162"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T163"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T164");
    }

    // === MOXES — Stage/persona names ===
    private static func GetMoxesAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-CoherenceManag-T17"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T165"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T166"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T167"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T168"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T169"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T170"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T171"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T172"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T173"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T174"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T175"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T176"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T177"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T2"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T178"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T179"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T180"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T181"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T182"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T183"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T184"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T185"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T186"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T187"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T188"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T189"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T190"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T191"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T192");
    }

    // === SCAVENGERS — Dark/organ trade handles ===
    private static func GetScavengersAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T193"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T0"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T72"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T194"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T195"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T196"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T197"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T198"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T199"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T200"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T201"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T202"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T203"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T204"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T205"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T206"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T207"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T208"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T209"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T210"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T211"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T212"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T213"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T214"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T215"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T216"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T217"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T218"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T219"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T220");
    }

    // === WRAITHS — Road warrior handles ===
    private static func GetWraithsAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T221"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T222"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T223"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T224"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T225"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T226"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T227"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T228"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T7"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T229"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T230"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T231"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T232"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T200"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T233"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T234"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T235"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T236"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T237"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T238"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T239"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T13"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T240"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T241"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T242"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T243"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T4"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T244"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T245"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T246");
    }

    // === ALDECALDOS — Road/family names ===
    private static func GetAldecaldosAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T247"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T248"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T249"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T250"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T251"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T252"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T253"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T254"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T255"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T256"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T257"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T258"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T259"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T260"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T261"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T262"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T263"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T264"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T265"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T266"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T267"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T268"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T269"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T270"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T271"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T272"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T273"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T274"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T275"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T276");
    }

    // === GENERIC FALLBACK ===
    private static func GetGenericAlias(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 19);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T1"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T277"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T60"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T15"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T179"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T278"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T279"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T237"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T280"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T281"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T282"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T283"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T284"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T285"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T79"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U0"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T286"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T287"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T288"); }
        return GetLocalizedTextByKey(n"Kdsp-GangNameGenera-T289");
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
