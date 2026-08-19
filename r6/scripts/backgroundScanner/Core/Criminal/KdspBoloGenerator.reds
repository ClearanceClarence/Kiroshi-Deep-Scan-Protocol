// Kiroshi Deep Scan Protocol - BOLO / Alert Notice System
// NCPD lookout notices on scanned civilians, independent of warrant status.
// A BOLO doesn't mean charges — it means someone is looking for this person.

public abstract class KdspBoloGenerator {

    public static func Generate(seed: Int32, archetype: String) -> String {
        if !KdspSettings.BoloNoticesEnabled() {
            return "";
        };

        let chance: Int32 = KdspSettings.GetBoloNoticeChance();
        if chance < 1 { chance = 1; };
        if RandRange(seed, 0, chance) != 0 {
            return "";
        };

        return KdspTextBolo.GetNotice(seed);
    }
}
