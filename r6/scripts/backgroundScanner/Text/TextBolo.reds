// BOLO / lookout notice strings.
// TRANSLATION: keep the "BOLO:", "ALERT:", "NOTICE:" prefixes in English —
// they are matched in UI/NetWatchDBReport.reds to trigger the red highlight.
// Lines with + IntToString(...) append numbers in code; both string halves
// can be rearranged for your language as long as the appended value survives.
public abstract class KdspTextBolo {

    public static func GetNotice(seed: Int32) -> String {
        let roll = RandRange(seed + 7, 0, 72);


        // ── Person of interest ────────────────────────────────────────
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-Bolo-0"); };
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-Bolo-1"); };
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-Bolo-2"); };
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-Bolo-3"); };
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-Bolo-4"); };
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-Bolo-5"); };
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-Bolo-6"); };
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-Bolo-7"); };
        // ── Witness-related ───────────────────────────────────────────
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-Bolo-8"); };
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-Bolo-9"); };
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-Bolo-10"); };
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-Bolo-11"); };
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-Bolo-12"); };
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-Bolo-13"); };
        // ── Missing persons ───────────────────────────────────────────
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-Bolo-14") + IntToString(RandRange(seed + 13, 40000, 99999)); };
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-Bolo-15"); };
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-Bolo-16") + IntToString(RandRange(seed + 17, 2073, 2077)) + GetLocalizedTextByKey(n"Kdsp-Bolo-16b"); };
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-Bolo-17") + IntToString(RandRange(seed + 19, 2070, 2075)) + GetLocalizedTextByKey(n"Kdsp-Bolo-17b"); };
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-Bolo-18"); };
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-Bolo-19") + IntToString(RandRange(seed + 23, 2058, 2066)); };
        // ── Corp-related ──────────────────────────────────────────────
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-Bolo-20"); };
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-Bolo-21"); };
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-Bolo-22"); };
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-Bolo-23"); };
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-Bolo-24"); };
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-Bolo-25"); };
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-Bolo-26"); };
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-Bolo-27"); };
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-Bolo-28"); };
        // ── Civil / administrative ────────────────────────────────────
        if roll == 29 { return GetLocalizedTextByKey(n"Kdsp-Bolo-29"); };
        if roll == 30 { return GetLocalizedTextByKey(n"Kdsp-Bolo-30"); };
        if roll == 31 { return GetLocalizedTextByKey(n"Kdsp-Bolo-31"); };
        if roll == 32 { return GetLocalizedTextByKey(n"Kdsp-Bolo-32"); };
        if roll == 33 { return GetLocalizedTextByKey(n"Kdsp-Bolo-33"); };
        if roll == 34 { return GetLocalizedTextByKey(n"Kdsp-Bolo-34"); };
        if roll == 35 { return GetLocalizedTextByKey(n"Kdsp-Bolo-35"); };
        if roll == 36 { return GetLocalizedTextByKey(n"Kdsp-Bolo-36"); };
        if roll == 37 { return GetLocalizedTextByKey(n"Kdsp-Bolo-37"); };
        // ── Medical / safety ──────────────────────────────────────────
        if roll == 38 { return GetLocalizedTextByKey(n"Kdsp-Bolo-38"); };
        if roll == 39 { return GetLocalizedTextByKey(n"Kdsp-Bolo-39"); };
        if roll == 40 { return GetLocalizedTextByKey(n"Kdsp-Bolo-40"); };
        if roll == 41 { return GetLocalizedTextByKey(n"Kdsp-Bolo-41"); };
        if roll == 42 { return GetLocalizedTextByKey(n"Kdsp-Bolo-42") + IntToString(RandRange(seed + 29, 2074, 2077)); };
        if roll == 43 { return GetLocalizedTextByKey(n"Kdsp-Bolo-43"); };
        if roll == 44 { return GetLocalizedTextByKey(n"Kdsp-Bolo-44"); };
        if roll == 45 { return GetLocalizedTextByKey(n"Kdsp-Bolo-45"); };
        // ── NetWatch / cyber ──────────────────────────────────────────
        if roll == 46 { return GetLocalizedTextByKey(n"Kdsp-Bolo-46"); };
        if roll == 47 { return GetLocalizedTextByKey(n"Kdsp-Bolo-47"); };
        if roll == 48 { return GetLocalizedTextByKey(n"Kdsp-Bolo-48"); };
        if roll == 49 { return GetLocalizedTextByKey(n"Kdsp-Bolo-49"); };
        if roll == 50 { return GetLocalizedTextByKey(n"Kdsp-Bolo-50") + IntToString(RandRange(seed + 31, 10000, 39999)) + GetLocalizedTextByKey(n"Kdsp-Bolo-50b"); };
        // ── Gang / street ─────────────────────────────────────────────
        if roll == 51 { return GetLocalizedTextByKey(n"Kdsp-Bolo-51"); };
        if roll == 52 { return GetLocalizedTextByKey(n"Kdsp-Bolo-52"); };
        if roll == 53 { return GetLocalizedTextByKey(n"Kdsp-Bolo-53"); };
        if roll == 54 { return GetLocalizedTextByKey(n"Kdsp-Bolo-54"); };
        if roll == 55 { return GetLocalizedTextByKey(n"Kdsp-Bolo-55"); };
        // ── Financial ─────────────────────────────────────────────────
        if roll == 56 { return GetLocalizedTextByKey(n"Kdsp-Bolo-56"); };
        if roll == 57 { return GetLocalizedTextByKey(n"Kdsp-Bolo-57"); };
        if roll == 58 { return GetLocalizedTextByKey(n"Kdsp-Bolo-58"); };
        if roll == 59 { return GetLocalizedTextByKey(n"Kdsp-Bolo-59"); };
        if roll == 60 { return GetLocalizedTextByKey(n"Kdsp-Bolo-60"); };
        // ── Bounty / private ──────────────────────────────────────────
        if roll == 61 { return GetLocalizedTextByKey(n"Kdsp-Bolo-61"); };
        if roll == 62 { return GetLocalizedTextByKey(n"Kdsp-Bolo-62"); };
        if roll == 63 { return GetLocalizedTextByKey(n"Kdsp-Bolo-63"); };
        if roll == 64 { return GetLocalizedTextByKey(n"Kdsp-Bolo-64"); };
        // ── Historical / cold case ────────────────────────────────────
        if roll == 65 { return GetLocalizedTextByKey(n"Kdsp-Bolo-65"); };
        if roll == 66 { return GetLocalizedTextByKey(n"Kdsp-Bolo-66") + IntToString(RandRange(seed + 37, 2060, 2070)) + GetLocalizedTextByKey(n"Kdsp-Bolo-66b"); };
        if roll == 67 { return GetLocalizedTextByKey(n"Kdsp-Bolo-67"); };
        // ── Odd ones ──────────────────────────────────────────────────
        if roll == 68 { return GetLocalizedTextByKey(n"Kdsp-Bolo-68"); };
        if roll == 69 { return GetLocalizedTextByKey(n"Kdsp-Bolo-69"); };
        if roll == 70 { return GetLocalizedTextByKey(n"Kdsp-Bolo-70"); };
        if roll == 71 { return GetLocalizedTextByKey(n"Kdsp-Bolo-71"); };
        return "";
    }
}
