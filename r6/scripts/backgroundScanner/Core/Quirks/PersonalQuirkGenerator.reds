// Kiroshi Deep Scan - Personal Quirk Generator
// 200 surveillance-state data entries across 7 categories

public abstract class KdspPersonalQuirkGenerator {

    public static func GeneratePersonalQuirk(seed: Int32, archetype: String) -> String {
        // 7 categories, pick one then pick within it
        let cat = RandRange(seed, 0, 6);

        // ── ILLICIT AFFAIRS / RELATIONSHIPS ──
        if cat == 0 {
            let i = RandRange(seed + 10, 0, 34);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S0"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S1"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S2"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S3"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S4"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S5"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S6"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S7"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S8"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S9"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S10"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S11"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S12"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S13"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S14"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S15"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S16"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S17"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S18"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S19"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S20"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S21"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S22"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S23"); }
            if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S24"); }
            if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S25"); }
            if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S26"); }
            if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S27"); }
            if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S28"); }
            if i == 29 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S29"); }
            if i == 30 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S30"); }
            if i == 31 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S31"); }
            if i == 32 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S32"); }
            if i == 33 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S33"); }
            return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S34");
        }

        // ── PHOBIAS / PSYCHOLOGICAL QUIRKS ──
        if cat == 1 {
            let i = RandRange(seed + 10, 0, 29);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S35"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S36"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S37"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S38"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S39"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S40"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S41"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S42"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S43"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S44"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S45"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S46"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S47"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S48"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S49"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S50"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S51"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S52"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S53"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S54"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S55"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S56"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S57"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S58"); }
            if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S59"); }
            if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S60"); }
            if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S61"); }
            if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S62"); }
            if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S63"); }
            return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S64");
        }

        // ── EMBARRASSING HABITS / PERSONAL SECRETS ──
        if cat == 2 {
            let i = RandRange(seed + 10, 0, 29);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S65"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S66"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S67"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S68"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S69"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S70"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S71"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S72"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S73"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S74"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S75"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S76"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S77"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S78"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S79"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S80"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S81"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S82"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S83"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S84"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S85"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S86"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S87"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S88"); }
            if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S89"); }
            if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S90"); }
            if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S91"); }
            if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S92"); }
            if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S93"); }
            return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S94");
        }

        // ── CONSPIRACY / DELUSIONAL BELIEFS ──
        if cat == 3 {
            let i = RandRange(seed + 10, 0, 24);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S95"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S96"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S97"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S98"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S99"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S100"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S101"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S102"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S103"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S104"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S105"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S106"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S107"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S108"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S109"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S110"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S111"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S112"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S113"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S114"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S115"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S116"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S117"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S118"); }
            return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S119");
        }

        // ── WEIRD NCPD / LEGAL FLAGS ──
        if cat == 4 {
            let i = RandRange(seed + 10, 0, 24);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S120"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S121"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S122"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S123"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S124"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S125"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S126"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S127"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S128"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S129"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S130"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S131"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S132"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S133"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S134"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S135"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S136"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S137"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S138"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S139"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S140"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S141"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S142"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S143"); }
            return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S144");
        }

        // ── SECRET DOUBLE LIVES ──
        if cat == 5 {
            let i = RandRange(seed + 10, 0, 24);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S145"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S146"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S147"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S148"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S149"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S150"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S151"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S152"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S153"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S154"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S155"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S156"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S157"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S158"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S159"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S160"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S161"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S162"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S163"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S164"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S165"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S166"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S167"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S168"); }
            return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S169");
        }

        // ── MUNDANE BUT ABSURD ──
        let i = RandRange(seed + 10, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S170"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S171"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S172"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S173"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S174"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S175"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S176"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S177"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S178"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S179"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S180"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S181"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S182"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S183"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S184"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S185"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S186"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S187"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S188"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S189"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S190"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S191"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S192"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S193"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S194"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S195"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S196"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S197"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S198"); }
        return GetLocalizedTextByKey(n"Kdsp-PersonalQuirkG-S199");
    }

    // Extract last name from NPC's display name for family relationship consistency

}
