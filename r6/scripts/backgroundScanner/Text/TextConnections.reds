// Connection system context strings.
// TRANSLATION: everything here is player-visible and translatable.
public abstract class KdspTextConnections {

    public static func GetCommunityContext(seed: Int32) -> String {
        let roll: Int32 = RandRange(seed, 0, 40);

        // Proximity
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-0"); };
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-1"); };
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-2"); };
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-3"); };
        // Commercial
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-4"); };
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-5"); };
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-6"); };
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-7"); };
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-8"); };
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-9"); };
        // Practical
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-10"); };
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-11"); };
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-12"); };
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-13"); };
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-14"); };
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-15"); };
        // Social
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-16"); };
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-17"); };
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-18"); };
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-19"); };
        if roll == 20 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-20"); };
        if roll == 21 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-21"); };
        // Work-adjacent
        if roll == 22 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-22"); };
        if roll == 23 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-23"); };
        if roll == 24 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-24"); };
        if roll == 25 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-25"); };
        if roll == 26 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-26"); };
        if roll == 27 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-27"); };
        // Deeper
        if roll == 28 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-28"); };
        if roll == 29 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-29"); };
        if roll == 30 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-30"); };
        if roll == 31 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-31"); };
        if roll == 32 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-32"); };
        if roll == 33 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-33"); };
        // Negative
        if roll == 34 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-34"); };
        if roll == 35 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-35"); };
        if roll == 36 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-36"); };
        if roll == 37 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-37"); };
        // Surveillance
        if roll == 38 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-38"); };
        if roll == 39 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-39"); };
        return GetLocalizedTextByKey(n"Kdsp-ConnCtx-Default");
    }

    public static func GetInjectionContext(seed: Int32) -> String {
        let roll: Int32 = RandRange(seed, 0, 20);
        if roll == 0 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-0"); };
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-1"); };
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-2"); };
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-3"); };
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-4"); };
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-5"); };
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-6"); };
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-7"); };
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-8"); };
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-9"); };
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-10"); };
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-11"); };
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-12"); };
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-13"); };
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-14"); };
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-15"); };
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-16"); };
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-17"); };
        if roll == 18 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-18"); };
        if roll == 19 { return GetLocalizedTextByKey(n"Kdsp-ConnInj-19"); };
        return GetLocalizedTextByKey(n"Kdsp-ConnInj-Default");
    }
}
