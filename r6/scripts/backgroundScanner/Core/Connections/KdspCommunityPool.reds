// Kiroshi Deep Scan Protocol - Community Pool
// Deterministic district name pools — NPCs in the same area independently
// generate overlapping contacts. Used by Phantom and Full connection modes.

public abstract class KdspCommunityPool {

    // ── District Seeds (fixed, stable across sessions) ────────────────────

    public static func GetDistrictSeed(district: String) -> Int32 {
        let d: String = StrLower(district);
        if StrContains(d, "watson")       { return 70001; };
        if StrContains(d, "westbrook")    { return 70002; };
        if StrContains(d, "heywood")      { return 70003; };
        if StrContains(d, "pacifica")     { return 70004; };
        if StrContains(d, "santo")        { return 70005; };
        if StrContains(d, "city center")  { return 70006; };
        if StrContains(d, "badlands")     { return 70007; };
        if StrContains(d, "dogtown")      { return 70008; };
        if StrContains(d, "northside")    { return 70009; };
        if StrContains(d, "rancho")       { return 70010; };
        return 70000 + StrLen(district) * 137;
    }

    // Sub-district: divides entity hash space into ~8 blocks per district
    public static func GetSubDistrictSeed(district: String, entityHash: Int32) -> Int32 {
        let base: Int32 = KdspCommunityPool.GetDistrictSeed(district);
        let block: Int32 = (entityHash / 10000) % 8;
        return base + (block * 500);
    }

    // ── District Ethnicity Mix (lore-accurate) ────────────────────────────

    public static func GetDistrictEthnicity(districtSeed: Int32, roll: Int32) -> KdspNPCEthnicity {
        let r: Int32 = roll % 100;

        // Watson — heavy East Asian + Slavic
        if districtSeed == 70001 {
            if r < 25 { return KdspNPCEthnicity.Japanese; };
            if r < 45 { return KdspNPCEthnicity.Chinese; };
            if r < 55 { return KdspNPCEthnicity.Korean; };
            if r < 70 { return KdspNPCEthnicity.Slavic; };
            if r < 85 { return KdspNPCEthnicity.American; };
            return KdspNPCEthnicity.European;
        };

        // Westbrook — Japanese dominated
        if districtSeed == 70002 {
            if r < 40 { return KdspNPCEthnicity.Japanese; };
            if r < 55 { return KdspNPCEthnicity.Chinese; };
            if r < 65 { return KdspNPCEthnicity.Korean; };
            if r < 80 { return KdspNPCEthnicity.European; };
            return KdspNPCEthnicity.American;
        };

        // Heywood — Hispanic core
        if districtSeed == 70003 {
            if r < 50 { return KdspNPCEthnicity.Hispanic; };
            if r < 65 { return KdspNPCEthnicity.American; };
            if r < 80 { return KdspNPCEthnicity.AfricanAmerican; };
            return KdspNPCEthnicity.European;
        };

        // Pacifica — Haitian/African
        if districtSeed == 70004 {
            if r < 45 { return KdspNPCEthnicity.Haitian; };
            if r < 70 { return KdspNPCEthnicity.African; };
            if r < 85 { return KdspNPCEthnicity.AfricanAmerican; };
            return KdspNPCEthnicity.American;
        };

        // Santo Domingo — Hispanic/American mix
        if districtSeed == 70005 {
            if r < 35 { return KdspNPCEthnicity.Hispanic; };
            if r < 60 { return KdspNPCEthnicity.American; };
            if r < 75 { return KdspNPCEthnicity.AfricanAmerican; };
            return KdspNPCEthnicity.European;
        };

        // City Center — corpo melting pot
        if districtSeed == 70006 {
            if r < 20 { return KdspNPCEthnicity.European; };
            if r < 35 { return KdspNPCEthnicity.American; };
            if r < 50 { return KdspNPCEthnicity.Japanese; };
            if r < 60 { return KdspNPCEthnicity.Indian; };
            if r < 70 { return KdspNPCEthnicity.Chinese; };
            if r < 80 { return KdspNPCEthnicity.MiddleEastern; };
            return KdspNPCEthnicity.Slavic;
        };

        // Badlands — American/Hispanic
        if districtSeed == 70007 {
            if r < 40 { return KdspNPCEthnicity.American; };
            if r < 65 { return KdspNPCEthnicity.Hispanic; };
            if r < 80 { return KdspNPCEthnicity.AfricanAmerican; };
            return KdspNPCEthnicity.Indian;
        };

        // Dogtown — military melting pot
        if districtSeed == 70008 {
            if r < 25 { return KdspNPCEthnicity.American; };
            if r < 40 { return KdspNPCEthnicity.AfricanAmerican; };
            if r < 55 { return KdspNPCEthnicity.Slavic; };
            if r < 70 { return KdspNPCEthnicity.European; };
            if r < 85 { return KdspNPCEthnicity.Hispanic; };
            return KdspNPCEthnicity.African;
        };

        // Default — mixed
        if r < 20 { return KdspNPCEthnicity.American; };
        if r < 35 { return KdspNPCEthnicity.Hispanic; };
        if r < 50 { return KdspNPCEthnicity.Japanese; };
        if r < 65 { return KdspNPCEthnicity.European; };
        if r < 80 { return KdspNPCEthnicity.Slavic; };
        return KdspNPCEthnicity.AfricanAmerican;
    }

    // ── Generate Community Member Name ────────────────────────────────────
    //  Uses real KdspNameGenerator signatures.

    public static func GetCommunityName(poolSeed: Int32, memberIndex: Int32, isFemale: Bool) -> String {
        let nameSeed: Int32 = poolSeed + (memberIndex * 137);
        let ethRoll: Int32 = RandRange(nameSeed, 0, 100);
        let ethnicity: KdspNPCEthnicity = KdspCommunityPool.GetDistrictEthnicity(poolSeed, ethRoll);

        let gender: String;
        if isFemale { gender = "Female"; } else { gender = "Male"; };

        let first: String = KdspNameGenerator.GetFirstNameByEthnicity(nameSeed + 1, gender, ethnicity);
        let last: String = KdspNameGenerator.GetLastNameByEthnicity(nameSeed + 2, ethnicity);
        return first + " " + last;
    }

    // ── Community Relationship Contexts (40 entries) ──────────────────────


    // ── Injection Pipeline ────────────────────────────────────────────────
    //  Returns [name, context] or empty array if no injection.
    //  District pool (15 names): 20% chance
    //  Sub-district pool (10 names): 25% chance
    //  Combined effective: ~40% that at least one relationship is local.

    public static func TryInject(
        district: String,
        entityHash: Int32,
        seed: Int32
    ) -> array<String> {
        let result: array<String>;

        // Sub-district pool (tighter, 10 names)
        if RandRange(seed, 0, 100) < 25 {
            let subSeed: Int32 = KdspCommunityPool.GetSubDistrictSeed(district, entityHash);
            let idx: Int32 = RandRange(seed + 1, 0, 10);
            let female: Bool = RandRange(seed + 2, 0, 2) == 0;
            ArrayPush(result, KdspCommunityPool.GetCommunityName(subSeed, idx, female));
            ArrayPush(result, KdspTextConnections.GetCommunityContext(seed + 3));
            return result;
        };

        // District pool (broader, 15 names)
        if RandRange(seed + 100, 0, 100) < 20 {
            let distSeed: Int32 = KdspCommunityPool.GetDistrictSeed(district);
            let idx: Int32 = RandRange(seed + 4, 0, 15);
            let female: Bool = RandRange(seed + 5, 0, 2) == 0;
            ArrayPush(result, KdspCommunityPool.GetCommunityName(distSeed, idx, female));
            ArrayPush(result, KdspTextConnections.GetCommunityContext(seed + 6));
            return result;
        };

        return result;
    }
}
