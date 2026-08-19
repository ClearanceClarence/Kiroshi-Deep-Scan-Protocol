// Scanner loading sequence strings.
// TRANSLATION: all display lines here are translatable. Do NOT translate
// the district identifiers ("WATSON", "CITY_CENTER", ...) inside the
// Equals() checks — they are code identifiers, never shown to the player.
public abstract class KdspTextLoading {

    public static func GetDistrictLine(seed: Int32, district: String) -> String {
        let lines: array<String>;

        if Equals(district, "WATSON") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-0"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-1"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-2"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-3"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-4"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-5"));
        } else if Equals(district, "WESTBROOK") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-6"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-7"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-8"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-9"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-10"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-11"));
        } else if Equals(district, "CITY_CENTER") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-12"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-13"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-14"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-15"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-16"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-17"));
        } else if Equals(district, "HEYWOOD") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-18"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-19"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-20"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-21"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-22"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-23"));
        } else if Equals(district, "SANTO_DOMINGO") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-24"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-25"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-26"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-27"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-28"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-29"));
        } else if Equals(district, "PACIFICA") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-30"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-31"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-32"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-33"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-34"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-35"));
        } else if Equals(district, "DOGTOWN") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-36"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-37"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-38"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-39"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-40"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-41"));
        } else if Equals(district, "BADLANDS") {
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-42"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-43"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-44"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-45"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-46"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-47"));
        } else {
            // Fallback for UNKNOWN — generic but local-sounding
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-48"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-49"));
            ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDistrict-50"));
        };

        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    public static func GetConnectionLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-0"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-1"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-2"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-3"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-4"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-5"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-6"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-7"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-8"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-9"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-10"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-11"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-12"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-13"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadConnection-14"));
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    public static func GetDatabaseLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-0"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-1"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-2"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-3"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-4"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-5"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-6"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-7"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-8"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-9"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-10"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-11"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-12"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-13"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-14"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-15"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-16"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-17"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-18"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadDatabase-19"));
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    public static func GetProcessingLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-0"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-1"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-2"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-3"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-4"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-5"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-6"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-7"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-8"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-9"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-10"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-11"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-12"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-13"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-14"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-15"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-16"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-17"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-18"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadProcessing-19"));
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    public static func GetStatusLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-0"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-1"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-2"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-3"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-4"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-5"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-6"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-7"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-8"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-9"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-10"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-11"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-12"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-13"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-14"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-15"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-16"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-17"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-18"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadStatus-19"));
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    public static func GetErrorLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-0"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-1"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-2"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-3"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-4"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-5"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-6"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-7"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-8"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-9"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-10"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-11"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-12"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-13"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-14"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-15"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-16"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-17"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-18"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-19"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-20"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-21"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-22"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadError-23"));
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    public static func GetSuccessLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-0"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-1"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-2"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-3"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-4"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-5"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-6"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-7"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-8"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-9"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-10"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-11"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-12"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-13"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-14"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-15"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-16"));
        ArrayPush(lines, GetLocalizedTextByKey(n"Kdsp-LoadSuccess-17"));
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }
}
