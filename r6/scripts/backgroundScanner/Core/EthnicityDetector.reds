// Ethnicity Detection System
// Parses NPC appearance strings to determine likely ethnicity for name matching

enum NPCEthnicity {
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

public class EthnicityDetector {

    // Main detection function - analyzes appearance string
    public static func GetEthnicityFromAppearance(appearanceName: String, gangAffiliation: String) -> NPCEthnicity {
        let lower = StrLower(appearanceName);
        
        // ══════════════════════════════════════════════════════════════
        // GANG-BASED DETECTION (highest confidence)
        // ══════════════════════════════════════════════════════════════
        
        // Tyger Claws - Japanese
        if Equals(gangAffiliation, "TYGER_CLAWS") {
            return NPCEthnicity.Japanese;
        }
        
        // Valentinos - Hispanic
        if Equals(gangAffiliation, "VALENTINOS") {
            return NPCEthnicity.Hispanic;
        }
        
        // Voodoo Boys - Haitian
        if Equals(gangAffiliation, "VOODOO_BOYS") {
            return NPCEthnicity.Haitian;
        }
        
        // 6th Street - American
        if Equals(gangAffiliation, "6TH_STREET") {
            return NPCEthnicity.American;
        }
        
        // Scavengers - Slavic
        if Equals(gangAffiliation, "SCAVENGERS") {
            return NPCEthnicity.Slavic;
        }
        
        // ══════════════════════════════════════════════════════════════
        // APPEARANCE STRING DETECTION
        // ══════════════════════════════════════════════════════════════
        
        // Japanese indicators
        if StrContains(lower, "japanese") || StrContains(lower, "_jpn_") || StrContains(lower, "_jp_") {
            return NPCEthnicity.Japanese;
        }
        if StrContains(lower, "tyger") || StrContains(lower, "tiger_claw") {
            return NPCEthnicity.Japanese;
        }
        
        // Chinese indicators
        if StrContains(lower, "chinese") || StrContains(lower, "_chn_") || StrContains(lower, "_ch_") {
            return NPCEthnicity.Chinese;
        }
        
        // Korean indicators
        if StrContains(lower, "korean") || StrContains(lower, "_kor_") || StrContains(lower, "_kr_") {
            return NPCEthnicity.Korean;
        }
        
        // Generic Asian - randomize between Japanese/Chinese/Korean
        if StrContains(lower, "asian") || StrContains(lower, "_as_") || StrContains(lower, "_asn_") {
            return NPCEthnicity.Japanese; // Default Asian to Japanese for Night City
        }
        
        // Hispanic/Latino indicators
        if StrContains(lower, "latino") || StrContains(lower, "latina") || StrContains(lower, "hispanic") {
            return NPCEthnicity.Hispanic;
        }
        if StrContains(lower, "_lat_") || StrContains(lower, "_hsp_") || StrContains(lower, "valentino") {
            return NPCEthnicity.Hispanic;
        }
        if StrContains(lower, "mexican") || StrContains(lower, "_mex_") {
            return NPCEthnicity.Hispanic;
        }
        
        // African-American indicators
        if StrContains(lower, "african_american") || StrContains(lower, "_aa_") || StrContains(lower, "_afam_") {
            return NPCEthnicity.AfricanAmerican;
        }
        if StrContains(lower, "black_") || StrContains(lower, "_black") || StrContains(lower, "_blk_") {
            return NPCEthnicity.AfricanAmerican;
        }
        
        // Haitian indicators (Voodoo Boys territory)
        if StrContains(lower, "haitian") || StrContains(lower, "haiti") {
            return NPCEthnicity.Haitian;
        }
        if StrContains(lower, "voodoo") || StrContains(lower, "vdb") || StrContains(lower, "pacifica") {
            return NPCEthnicity.Haitian;
        }
        
        // African indicators (Nigerian, etc.)
        if StrContains(lower, "african") || StrContains(lower, "_afr_") {
            return NPCEthnicity.African;
        }
        
        // Slavic/Eastern European indicators
        if StrContains(lower, "slavic") || StrContains(lower, "russian") || StrContains(lower, "polish") {
            return NPCEthnicity.Slavic;
        }
        if StrContains(lower, "_slv_") || StrContains(lower, "_rus_") || StrContains(lower, "_eur_east") {
            return NPCEthnicity.Slavic;
        }
        if StrContains(lower, "scav") {
            return NPCEthnicity.Slavic;
        }
        
        // Indian/South Asian indicators
        if StrContains(lower, "indian") || StrContains(lower, "south_asian") || StrContains(lower, "_ind_") {
            return NPCEthnicity.Indian;
        }
        if StrContains(lower, "pakistani") || StrContains(lower, "bangladeshi") {
            return NPCEthnicity.Indian;
        }
        
        // Middle Eastern indicators
        if StrContains(lower, "middle_east") || StrContains(lower, "arab") || StrContains(lower, "_me_") {
            return NPCEthnicity.MiddleEastern;
        }
        if StrContains(lower, "persian") || StrContains(lower, "iranian") {
            return NPCEthnicity.MiddleEastern;
        }
        
        // Southeast Asian indicators
        if StrContains(lower, "southeast") || StrContains(lower, "vietnamese") || StrContains(lower, "thai") {
            return NPCEthnicity.SoutheastAsian;
        }
        if StrContains(lower, "_sea_") || StrContains(lower, "filipino") || StrContains(lower, "indonesian") {
            return NPCEthnicity.SoutheastAsian;
        }
        
        // European indicators (non-Slavic)
        if StrContains(lower, "european") || StrContains(lower, "_eur_") {
            return NPCEthnicity.European;
        }
        if StrContains(lower, "german") || StrContains(lower, "french") || StrContains(lower, "italian") {
            return NPCEthnicity.European;
        }
        if StrContains(lower, "british") || StrContains(lower, "irish") || StrContains(lower, "nordic") {
            return NPCEthnicity.European;
        }
        
        // Caucasian/White indicators - default to American
        if StrContains(lower, "caucasian") || StrContains(lower, "_cau_") || StrContains(lower, "white") {
            return NPCEthnicity.American;
        }
        
        // ══════════════════════════════════════════════════════════════
        // CORPO / ARCHETYPE DETECTION
        // ══════════════════════════════════════════════════════════════
        
        // Arasaka employees - likely Japanese
        if StrContains(lower, "arasaka") {
            return NPCEthnicity.Japanese;
        }
        
        // Kang Tao - likely Chinese
        if StrContains(lower, "kang_tao") || StrContains(lower, "kangtao") {
            return NPCEthnicity.Chinese;
        }
        
        // ══════════════════════════════════════════════════════════════
        // DEFAULT - Mixed/Random
        // ══════════════════════════════════════════════════════════════
        return NPCEthnicity.Mixed;
    }
    
    // Get ethnicity from seed when appearance doesn't give clear signals
    public static func GetRandomEthnicity(seed: Int32) -> NPCEthnicity {
        // Night City demographics weighted distribution
        // Based on lore: heavy Japanese, Hispanic, American presence
        let roll = RandRange(seed, 0, 100);
        
        if roll < 18 {
            return NPCEthnicity.American;        // 18%
        }
        if roll < 33 {
            return NPCEthnicity.Hispanic;        // 15%
        }
        if roll < 48 {
            return NPCEthnicity.Japanese;        // 15%
        }
        if roll < 58 {
            return NPCEthnicity.AfricanAmerican; // 10%
        }
        if roll < 66 {
            return NPCEthnicity.Chinese;         // 8%
        }
        if roll < 73 {
            return NPCEthnicity.Slavic;          // 7%
        }
        if roll < 78 {
            return NPCEthnicity.Haitian;         // 5% (Pacifica)
        }
        if roll < 83 {
            return NPCEthnicity.European;        // 5%
        }
        if roll < 87 {
            return NPCEthnicity.Korean;          // 4%
        }
        if roll < 91 {
            return NPCEthnicity.Indian;          // 4%
        }
        if roll < 94 {
            return NPCEthnicity.MiddleEastern;   // 3%
        }
        if roll < 97 {
            return NPCEthnicity.African;         // 3%
        }
        if roll < 100 {
            return NPCEthnicity.SoutheastAsian;  // 3%
        }
        return NPCEthnicity.Mixed;               // fallback
    }
    
    // Convert enum to string for debugging
    public static func EthnicityToString(ethnicity: NPCEthnicity) -> String {
        switch ethnicity {
            case NPCEthnicity.American:
                return "American";
            case NPCEthnicity.AfricanAmerican:
                return "African-American";
            case NPCEthnicity.Hispanic:
                return "Hispanic";
            case NPCEthnicity.Japanese:
                return "Japanese";
            case NPCEthnicity.Chinese:
                return "Chinese";
            case NPCEthnicity.Korean:
                return "Korean";
            case NPCEthnicity.Slavic:
                return "Slavic";
            case NPCEthnicity.Indian:
                return "Indian";
            case NPCEthnicity.MiddleEastern:
                return "Middle Eastern";
            case NPCEthnicity.African:
                return "African";
            case NPCEthnicity.SoutheastAsian:
                return "Southeast Asian";
            case NPCEthnicity.European:
                return "European";
            case NPCEthnicity.Haitian:
                return "Haitian";
            case NPCEthnicity.Mixed:
                return "Mixed";
            default:
                return "Unknown";
        }
    }
}
