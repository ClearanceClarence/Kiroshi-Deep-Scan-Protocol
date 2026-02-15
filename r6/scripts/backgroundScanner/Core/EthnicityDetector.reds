// Ethnicity Detection System
// Parses NPC appearance strings to determine likely ethnicity for name matching

enum KdspNPCEthnicity {
    American = 0,
    AfricanAmerican = 1,
    Hispanic = 2,
    Japanese = 3,
    Chinese = 4,
    Korean = 5,
    Slavic = 6,
    Indian = 7,
    MiddleEastern = 8,
    African = 9,
    SoutheastAsian = 10,
    European = 11,
    Haitian = 12,
    Mixed = 99
}

public class KdspEthnicityDetector {

    // Main detection function - analyzes appearance string
    public static func GetEthnicityFromAppearance(appearanceName: String, gangAffiliation: String) -> KdspNPCEthnicity {
        let lower = StrLower(appearanceName);
        
        // ══════════════════════════════════════════════════════════════
        // GANG-BASED DETECTION (highest confidence)
        // ══════════════════════════════════════════════════════════════
        
        // Tyger Claws - Japanese
        if Equals(gangAffiliation, "TYGER_CLAWS") {
            return KdspNPCEthnicity.Japanese;
        }
        
        // Valentinos - Hispanic
        if Equals(gangAffiliation, "VALENTINOS") {
            return KdspNPCEthnicity.Hispanic;
        }
        
        // Voodoo Boys - Haitian
        if Equals(gangAffiliation, "VOODOO_BOYS") {
            return KdspNPCEthnicity.Haitian;
        }
        
        // 6th Street - American
        if Equals(gangAffiliation, "6TH_STREET") {
            return KdspNPCEthnicity.American;
        }
        
        // Scavengers - Slavic
        if Equals(gangAffiliation, "SCAVENGERS") {
            return KdspNPCEthnicity.Slavic;
        }
        
        // ══════════════════════════════════════════════════════════════
        // APPEARANCE STRING DETECTION
        // ══════════════════════════════════════════════════════════════
        
        // Japanese indicators
        if StrContains(lower, "japanese") || StrContains(lower, "_jpn_") || StrContains(lower, "_jp_") {
            return KdspNPCEthnicity.Japanese;
        }
        if StrContains(lower, "tyger") || StrContains(lower, "tiger_claw") {
            return KdspNPCEthnicity.Japanese;
        }
        
        // Chinese indicators
        if StrContains(lower, "chinese") || StrContains(lower, "_chn_") || StrContains(lower, "_ch_") {
            return KdspNPCEthnicity.Chinese;
        }
        
        // Korean indicators
        if StrContains(lower, "korean") || StrContains(lower, "_kor_") || StrContains(lower, "_kr_") {
            return KdspNPCEthnicity.Korean;
        }
        
        // Generic Asian - randomize between Japanese/Chinese/Korean
        if StrContains(lower, "asian") || StrContains(lower, "_as_") || StrContains(lower, "_asn_") {
            return KdspNPCEthnicity.Japanese; // Default Asian to Japanese for Night City
        }
        
        // Hispanic/Latino indicators
        if StrContains(lower, "latino") || StrContains(lower, "latina") || StrContains(lower, "hispanic") {
            return KdspNPCEthnicity.Hispanic;
        }
        if StrContains(lower, "_lat_") || StrContains(lower, "_hsp_") || StrContains(lower, "valentino") {
            return KdspNPCEthnicity.Hispanic;
        }
        if StrContains(lower, "mexican") || StrContains(lower, "_mex_") {
            return KdspNPCEthnicity.Hispanic;
        }
        
        // African-American indicators
        if StrContains(lower, "african_american") || StrContains(lower, "_aa_") || StrContains(lower, "_afam_") {
            return KdspNPCEthnicity.AfricanAmerican;
        }
        if StrContains(lower, "black_") || StrContains(lower, "_black") || StrContains(lower, "_blk_") {
            return KdspNPCEthnicity.AfricanAmerican;
        }
        
        // Haitian indicators (Voodoo Boys territory)
        if StrContains(lower, "haitian") || StrContains(lower, "haiti") {
            return KdspNPCEthnicity.Haitian;
        }
        if StrContains(lower, "voodoo") || StrContains(lower, "vdb") || StrContains(lower, "pacifica") {
            return KdspNPCEthnicity.Haitian;
        }
        
        // African indicators (Nigerian, etc.)
        if StrContains(lower, "african") || StrContains(lower, "_afr_") {
            return KdspNPCEthnicity.African;
        }
        
        // Slavic/Eastern European indicators
        if StrContains(lower, "slavic") || StrContains(lower, "russian") || StrContains(lower, "polish") {
            return KdspNPCEthnicity.Slavic;
        }
        if StrContains(lower, "_slv_") || StrContains(lower, "_rus_") || StrContains(lower, "_eur_east") {
            return KdspNPCEthnicity.Slavic;
        }
        if StrContains(lower, "scav") {
            return KdspNPCEthnicity.Slavic;
        }
        
        // Indian/South Asian indicators
        if StrContains(lower, "indian") || StrContains(lower, "south_asian") || StrContains(lower, "_ind_") {
            return KdspNPCEthnicity.Indian;
        }
        if StrContains(lower, "pakistani") || StrContains(lower, "bangladeshi") {
            return KdspNPCEthnicity.Indian;
        }
        
        // Middle Eastern indicators
        if StrContains(lower, "middle_east") || StrContains(lower, "arab") || StrContains(lower, "_me_") {
            return KdspNPCEthnicity.MiddleEastern;
        }
        if StrContains(lower, "persian") || StrContains(lower, "iranian") {
            return KdspNPCEthnicity.MiddleEastern;
        }
        
        // Southeast Asian indicators
        if StrContains(lower, "southeast") || StrContains(lower, "vietnamese") || StrContains(lower, "thai") {
            return KdspNPCEthnicity.SoutheastAsian;
        }
        if StrContains(lower, "_sea_") || StrContains(lower, "filipino") || StrContains(lower, "indonesian") {
            return KdspNPCEthnicity.SoutheastAsian;
        }
        
        // European indicators (non-Slavic)
        if StrContains(lower, "european") || StrContains(lower, "_eur_") {
            return KdspNPCEthnicity.European;
        }
        if StrContains(lower, "german") || StrContains(lower, "french") || StrContains(lower, "italian") {
            return KdspNPCEthnicity.European;
        }
        if StrContains(lower, "british") || StrContains(lower, "irish") || StrContains(lower, "nordic") {
            return KdspNPCEthnicity.European;
        }
        
        // Caucasian/White indicators - default to American
        if StrContains(lower, "caucasian") || StrContains(lower, "_cau_") || StrContains(lower, "white") {
            return KdspNPCEthnicity.American;
        }
        
        // ══════════════════════════════════════════════════════════════
        // CORPO / ARCHETYPE DETECTION
        // ══════════════════════════════════════════════════════════════
        
        // Arasaka employees - likely Japanese
        if StrContains(lower, "arasaka") {
            return KdspNPCEthnicity.Japanese;
        }
        
        // Kang Tao - likely Chinese
        if StrContains(lower, "kang_tao") || StrContains(lower, "kangtao") {
            return KdspNPCEthnicity.Chinese;
        }
        
        // ══════════════════════════════════════════════════════════════
        // DEFAULT - Mixed/Random
        // ══════════════════════════════════════════════════════════════
        return KdspNPCEthnicity.Mixed;
    }
    
    // Get ethnicity from seed when appearance doesn't give clear signals
    public static func GetRandomEthnicity(seed: Int32) -> KdspNPCEthnicity {
        // Night City demographics weighted distribution
        // Based on lore: heavy Japanese, Hispanic, American presence
        let roll = RandRange(seed, 0, 100);
        
        if roll < 18 {
            return KdspNPCEthnicity.American;        // 18%
        }
        if roll < 33 {
            return KdspNPCEthnicity.Hispanic;        // 15%
        }
        if roll < 48 {
            return KdspNPCEthnicity.Japanese;        // 15%
        }
        if roll < 58 {
            return KdspNPCEthnicity.AfricanAmerican; // 10%
        }
        if roll < 66 {
            return KdspNPCEthnicity.Chinese;         // 8%
        }
        if roll < 73 {
            return KdspNPCEthnicity.Slavic;          // 7%
        }
        if roll < 78 {
            return KdspNPCEthnicity.Haitian;         // 5% (Pacifica)
        }
        if roll < 83 {
            return KdspNPCEthnicity.European;        // 5%
        }
        if roll < 87 {
            return KdspNPCEthnicity.Korean;          // 4%
        }
        if roll < 91 {
            return KdspNPCEthnicity.Indian;          // 4%
        }
        if roll < 94 {
            return KdspNPCEthnicity.MiddleEastern;   // 3%
        }
        if roll < 97 {
            return KdspNPCEthnicity.African;         // 3%
        }
        if roll < 100 {
            return KdspNPCEthnicity.SoutheastAsian;  // 3%
        }
        return KdspNPCEthnicity.Mixed;               // fallback
    }
    
    // Convert enum to string for debugging
    public static func EthnicityToString(ethnicity: KdspNPCEthnicity) -> String {
        switch ethnicity {
            case KdspNPCEthnicity.American:
                return "American";
            case KdspNPCEthnicity.AfricanAmerican:
                return "African-American";
            case KdspNPCEthnicity.Hispanic:
                return "Hispanic";
            case KdspNPCEthnicity.Japanese:
                return "Japanese";
            case KdspNPCEthnicity.Chinese:
                return "Chinese";
            case KdspNPCEthnicity.Korean:
                return "Korean";
            case KdspNPCEthnicity.Slavic:
                return "Slavic";
            case KdspNPCEthnicity.Indian:
                return "Indian";
            case KdspNPCEthnicity.MiddleEastern:
                return "Middle Eastern";
            case KdspNPCEthnicity.African:
                return "African";
            case KdspNPCEthnicity.SoutheastAsian:
                return "Southeast Asian";
            case KdspNPCEthnicity.European:
                return "European";
            case KdspNPCEthnicity.Haitian:
                return "Haitian";
            case KdspNPCEthnicity.Mixed:
                return "Mixed";
            default:
                return "Unknown";
        }
    }
}
