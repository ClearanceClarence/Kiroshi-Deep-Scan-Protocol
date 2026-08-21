// Kiroshi Deep Scan - NCPD Officer Profile Generator
// Procedural background, early life, and recent activity for NCPD officers

public abstract class KdspNCPDProfileGenerator {

    public static func GenerateNCPDBackground(seed: Int32, lifePath: ref<KdspLifePath>) -> String {
        let origin = KdspNCPDProfileGenerator.GetOrigin(seed + 100);
        let path = KdspNCPDProfileGenerator.GetPathToNCPD(seed + 150);
        return origin + " " + path;
    }

    private static func GetOrigin(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 39);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S0"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S1"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S2"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S3"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S4"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S5"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S6"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S7"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S8"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S9"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S10"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S11"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S12"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S13"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S14"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S15"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S16"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S17"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S18"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S19"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S20"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S21"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S22"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S23"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S24"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S25"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S26"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S27"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S28"); }
        if roll == 29 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S29"); }
        if roll == 30 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S30"); }
        if roll == 31 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S31"); }
        if roll == 32 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S32"); }
        if roll == 33 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S33"); }
        if roll == 34 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S34"); }
        if roll == 35 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S35"); }
        if roll == 36 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S36"); }
        if roll == 37 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S37"); }
        if roll == 38 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S38"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S39");
    }

    private static func GetPathToNCPD(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 24);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S40"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S41"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S42"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S43"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S44"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S45"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S46"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S47"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S48"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S49"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S50"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S51"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S52"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S53"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S54"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S55"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S56"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S57"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S58"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S59"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S60"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S61"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S62"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S63"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S64");
    }

    public static func GenerateNCPDEarlyLife(seed: Int32, lifePath: ref<KdspLifePath>) -> String {
        let event = KdspNCPDProfileGenerator.GetEarlyCareerEvent(seed + 200);
        let detail = KdspNCPDProfileGenerator.GetCareerDetail(seed + 250);
        return event + " " + detail;
    }

    private static func GetEarlyCareerEvent(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 39);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S65"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S66"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S67"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S68"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S69"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S70"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S71"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S72"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S73"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S74"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S75"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S76"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S77"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S78"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S79"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S80"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S81"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S82"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S83"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S84"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S85"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S86"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S87"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S88"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S89"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S90"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S91"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S92"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S93"); }
        if roll == 29 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S94"); }
        if roll == 30 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S95"); }
        if roll == 31 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S96"); }
        if roll == 32 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S97"); }
        if roll == 33 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S98"); }
        if roll == 34 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S99"); }
        if roll == 35 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S100"); }
        if roll == 36 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S101"); }
        if roll == 37 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S102"); }
        if roll == 38 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S103"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S104");
    }

    private static func GetCareerDetail(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 24);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S105"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S106"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S107"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S108"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-U0"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S109"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S110"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S111"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S112"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S113"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S114"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S115"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S116"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S117"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S118"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S119"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S120"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S121"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S122"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S123"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S124"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S125"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S126"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S127"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S128");
    }

    public static func GenerateNCPDRecentActivity(seed: Int32, lifePath: ref<KdspLifePath>) -> String {
        let current = KdspNCPDProfileGenerator.GetCurrentSituation(seed + 300);
        let developing = KdspNCPDProfileGenerator.GetDevelopingElement(seed + 350);
        return current + " " + developing;
    }

    private static func GetCurrentSituation(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 39);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S129"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S130"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S131"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S132"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S133"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S134"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S135"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S136"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S137"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-U1"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S138"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S139"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S140"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S141"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S142"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S143"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S144"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S145"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S146"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S147"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S148"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S149"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S150"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S151"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S152"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S153"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S154"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S155"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S156"); }
        if roll == 29 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S157"); }
        if roll == 30 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S158"); }
        if roll == 31 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S159"); }
        if roll == 32 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S160"); }
        if roll == 33 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S161"); }
        if roll == 34 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S162"); }
        if roll == 35 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S163"); }
        if roll == 36 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S164"); }
        if roll == 37 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S165"); }
        if roll == 38 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S166"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S167");
    }

    private static func GetDevelopingElement(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S168"); }
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S169"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S170"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S171"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S172"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S173"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S174"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S175"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S176"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S177"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S178"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S179"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S180"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S181"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S182"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S183"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S184"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S185"); }
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S186"); }
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S187"); }
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-U2"); }
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S188"); }
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S189"); }
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S190"); }
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S191"); }
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S192"); }
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S193"); }
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S194"); }
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S195"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDProfileGen-S196");
    }

    // ══════════════════════════════════════════════════════════════
    // TRAUMA TEAM GENERATORS
    // Professional military-medical operatives. Corporate soldiers.

}
