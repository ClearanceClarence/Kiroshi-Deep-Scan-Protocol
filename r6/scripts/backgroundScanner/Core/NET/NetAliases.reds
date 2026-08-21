// Kiroshi Deep Scan - NET Alias Generator
// Procedural online handle/alias generation for NET Profile section

public abstract class KdspNetAliases {

    // Main entry point — returns a formatted alias string or empty if roll fails
    public static func GenerateAlias(seed: Int32) -> String {
        // Pick from 10 style categories, then variant within
        let style = RandRange(seed, 0, 9);

        if style == 0 { return KdspNetAliases.HackerHandle(seed + 10); }
        if style == 1 { return KdspNetAliases.GamerTag(seed + 10); }
        if style == 2 { return KdspNetAliases.EdgeRunner(seed + 10); }
        if style == 3 { return KdspNetAliases.CorpoLeak(seed + 10); }
        if style == 4 { return KdspNetAliases.StreetSlang(seed + 10); }
        if style == 5 { return KdspNetAliases.Netrunner(seed + 10); }
        if style == 6 { return KdspNetAliases.Weeb(seed + 10); }
        if style == 7 { return KdspNetAliases.Paranoid(seed + 10); }
        if style == 8 { return KdspNetAliases.Pretentious(seed + 10); }
        return KdspNetAliases.NumberCrunch(seed + 10);
    }

    // ── HACKER HANDLES ── l33tspeak, classic hacker culture
    private static func HackerHandle(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T0") + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T1"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T2"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T3"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T4"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T5") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T6"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T7"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T8"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T9"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T10"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T11") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T12"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T13"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T14") + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T15") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T16"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T17"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T18"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T19"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T20"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T21"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T22"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T23"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T24"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T25"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T26"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T27"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T28"); }
        return "3xpl01t_" + IntToString(RandRange(seed + 1, 100, 999));
    }

    // ── GAMER TAGS ── xX format, competitive gaming culture
    private static func GamerTag(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T30"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T31"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T32"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T33") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T34"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T35") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T36"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T37"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T38"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T39"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T40"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T41"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T42") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T43"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T44"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T45"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T46"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T47"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T48") + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T49"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T50"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T51"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T52"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T53"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T54"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T55"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T56"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T57") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T58"); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T59") + IntToString(RandRange(seed + 1, 100, 999));
    }

    // ── EDGERUNNER ── Night City street culture, merc references
    private static func EdgeRunner(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T60"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T61") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T62"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T63"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T64"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T65") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T66"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T67"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T68"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T69"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T70"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T71"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T72"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T73"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T74"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T75") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T76"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T77"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T78"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T79"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T80"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T81"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T82"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T83"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T84"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T85"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T86"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T87"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T88"); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T89") + IntToString(RandRange(seed + 1, 2040, 2077));
    }

    // ── CORPO LEAK ── corporate culture, office worker handles
    private static func CorpoLeak(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T90"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T91") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T92") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T93"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T94"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T95"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T96"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T97"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T98"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T99"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T100"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T101"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T102"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T103") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T104"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T105"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T106"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T107"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T108"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T109"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T110") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T111"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T112") + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T113"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T114"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T115"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T116"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T117"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T118"); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T119") + IntToString(RandRange(seed + 1, 1, 99));
    }

    // ── STREET SLANG ── gang adjacent, street culture
    private static func StreetSlang(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T120"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T121") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T122"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T123"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T124") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T125"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T126"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T127"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T128"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T129"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T130"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T131"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T132"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T133"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T134"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T135"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T136") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T137"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T138"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T139"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T140"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T141"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T142"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T143") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T144"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T145") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T146"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T147"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T148"); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T149") + IntToString(RandRange(seed + 1, 1, 99));
    }

    // ── NETRUNNER ── deep net culture, ICE references, Old Net nostalgia
    private static func Netrunner(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T150") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T151"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T152"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T153"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T154") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T155") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T156"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T157"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T158"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T159"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T160"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T161"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T162"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T163"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T164"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T165"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T166"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T167"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T168"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T169"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T170"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T171") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T172"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T173"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T174"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T175") + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T176"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T177"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T178") + IntToString(RandRange(seed + 1, 1, 50)); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T179") + IntToString(RandRange(seed + 1, 100, 999));
    }

    // ── WEEB ── anime/manga culture, Japanese-influenced handles
    private static func Weeb(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T180"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T181"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T182") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T183"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T184") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T185"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T186"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T187"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T188") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T189"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T190"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T191"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T192"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T193"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T194"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T195"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T196") + IntToString(RandRange(seed + 1, 0, 13)); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T197"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T198"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T199") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T200"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T201"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T202") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T203"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T204"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T205"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T206") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T207"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T208") + IntToString(RandRange(seed + 1, 1, 50)); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T209");
    }

    // ── PARANOID ── conspiracy, surveillance fear, tinfoil
    private static func Paranoid(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T210"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T211") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T212") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T213") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T214"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T215"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T216"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T217"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T218") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T219"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T220"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T221") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T222"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T223"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T224"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T225"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T226"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T227"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T228"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T229") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T230") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T231") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T232"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T233"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T234"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T235"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T236"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T237"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T238"); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T239") + IntToString(RandRange(seed + 1, 100000, 999999));
    }

    // ── PRETENTIOUS ── pseudo-intellectual, philosophy, trying too hard
    private static func Pretentious(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T240"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T241"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T242"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T243") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T244") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T245"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T246"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T247"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T248"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T249"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T250") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T251"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T252"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T253"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T254"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T255"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T256") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T257"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T258") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T259"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T260"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T261"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T262"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T263") + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T264"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T265") + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T266"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T267"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T268"); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T269") + IntToString(RandRange(seed + 1, 1, 99));
    }

    // ── NUMBER CRUNCH ── generic, auto-generated feeling, default accounts
    private static func NumberCrunch(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T270") + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T271") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T272") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T273") + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T274") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T275") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T276") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T277") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T278") + IntToString(RandRange(seed + 1, 1, 999)); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T279") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 10 { return "ID_" + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T281") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T282") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T283") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T284") + IntToString(RandRange(seed + 1, 1, 500)); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T285") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 16 { return "NC" + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T286") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T287") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T288") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T289") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T290") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T291") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T292") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T293") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T294") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T295") + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T296") + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-NetAliases-T297") + IntToString(RandRange(seed + 1, 10000, 99999)); }
        return GetLocalizedTextByKey(n"Kdsp-NetAliases-T298") + IntToString(RandRange(seed + 1, 100000, 999999));
    }
}
