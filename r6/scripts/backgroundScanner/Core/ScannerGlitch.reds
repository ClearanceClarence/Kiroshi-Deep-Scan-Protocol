// ══════════════════════════════════════════════════════════════
// SCANNER GLITCH SYSTEM
// Rare data corruption event that replaces all scan fields with
// garbled, corrupted, or redacted text. Simulates hardware
// malfunction, database corruption, or active countermeasures.
// ══════════════════════════════════════════════════════════════

public abstract class KdspScannerGlitch {

    // Master corruption function - corrupts all fields of a backstoryUI
    public static func CorruptScan(seed: Int32, backstoryUI: KdspBackstoryUI) -> KdspBackstoryUI {
        let glitched: KdspBackstoryUI;

        // Pick a glitch type - determines the overall flavor
        let glitchType = RandRange(seed + 100, 0, 7);

        // Use large prime multipliers to avoid RandNoiseF seed clustering
        // NCPD ID - always corrupted
        glitched.ncID = KdspScannerGlitch.CorruptID(seed * 3 + 7919);

        // Background
        glitched.background = KdspScannerGlitch.CorruptField(seed * 7 + 15473, glitchType, "background");

        // Early Life
        glitched.earlyLife = KdspScannerGlitch.CorruptField(seed * 11 + 28661, glitchType, GetLocalizedTextByKey(n"Kdsp-ScannerGlitch-T1"));

        // Recent Activity
        glitched.significantEvents = KdspScannerGlitch.CorruptField(seed * 13 + 42853, glitchType, "recent");

        // Psych
        if NotEquals(backstoryUI.threatAssessment, "") {
            glitched.threatAssessment = KdspScannerGlitch.CorruptField(seed * 17 + 57047, glitchType, "psych");
        }

        // Criminal
        if NotEquals(backstoryUI.criminalRecord, "") {
            glitched.criminalRecord = KdspScannerGlitch.CorruptField(seed * 19 + 71249, glitchType, "criminal");
        }

        // Cyberware
        if NotEquals(backstoryUI.cyberwareStatus, "") {
            glitched.cyberwareStatus = KdspScannerGlitch.CorruptField(seed * 23 + 85453, glitchType, "cyberware");
        }

        // Financial
        if NotEquals(backstoryUI.financialStatus, "") {
            glitched.financialStatus = KdspScannerGlitch.CorruptField(seed * 29 + 99661, glitchType, "financial");
        }

        // Medical
        if NotEquals(backstoryUI.medicalStatus, "") {
            glitched.medicalStatus = KdspScannerGlitch.CorruptField(seed * 31 + 113873, glitchType, "medical");
        }

        // Relationships
        if NotEquals(backstoryUI.relationships, "") {
            glitched.relationships = KdspScannerGlitch.CorruptField(seed * 37 + 128087, glitchType, "relationships");
        }

        // Gang affiliation - blank it out or corrupt
        if NotEquals(backstoryUI.gangAffiliation, "") {
            glitched.gangAffiliation = KdspScannerGlitch.CorruptField(seed * 41 + 142297, glitchType, "gang");
        }

        // Vehicle registration
        if NotEquals(backstoryUI.vehicleRegistration, "") {
            glitched.vehicleRegistration = KdspScannerGlitch.CorruptField(seed * 43 + 156503, glitchType, "vehicle");
        }

        // NET profile
        if NotEquals(backstoryUI.netProfile, "") {
            glitched.netProfile = KdspScannerGlitch.CorruptField(seed * 47 + 170719, glitchType, "netprofile");
        }

        // Rare flag - override with glitch-specific flag
        glitched.rareFlag = KdspScannerGlitch.GetGlitchFlag(seed * 53 + 184937, glitchType);

        // Unique classification - always blank (glitch overrides)
        glitched.isUnique = false;
        glitched.uniqueClassification = "";

        // NCPD officer - blank
        glitched.ncpdOfficer = "";

        // Pronouns - corrupt or blank
        glitched.pronouns = "";

        // Debug info - show glitch metadata
        glitched.debugInfo = backstoryUI.debugInfo + GetLocalizedTextByKey(n"Kdsp-ScannerGlitch-T3") + IntToString(glitchType);

        return glitched;
    }

    // Corrupt the NCPD ID
    private static func CorruptID(seed: Int32) -> String {
        let r = RandRange(seed, 0, 9);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CorruptID-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-ScannerGlitch-V0"); }
        if r == 2 { return "ERR_NULL_REF"; }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CorruptID-3"); }
        if r == 4 { return "ID_NOT_FOUND"; }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CorruptID-5"); }
        if r == 6 { return "RECORD_EXPUNGED"; }
        if r == 7 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CorruptID-7"); }
        if r == 8 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CorruptID-8"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-CorruptID-9");
    }

    // Generate the glitch classification flag
    private static func GetGlitchFlag(seed: Int32, glitchType: Int32) -> String {
        // Type 0: Hardware malfunction
        if glitchType == 0 { 
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-0"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-1"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-2"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-3"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-4");
        }
        // Type 1: Database corruption
        if glitchType == 1 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-5"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-6"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-7"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-8"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-9");
        }
        // Type 2: NetWatch interference 
        if glitchType == 2 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-10"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-11"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-12"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-13"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-14");
        }
        // Type 3: Ghost / scrubbed identity
        if glitchType == 3 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-15"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-16"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-17"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-18"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-19");
        }
        // Type 4: Cyberpsychosis interference
        if glitchType == 4 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-20"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-21"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-22"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-23"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-24");
        }
        // Type 5: Classified / government blackout
        if glitchType == 5 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-25"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-26"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-27"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-28"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-29");
        }
        // Type 6: Data overflow / memory corruption
        if glitchType == 6 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-30"); }
            if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-31"); }
            if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-32"); }
            if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-33"); }
            return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-34");
        }
        // Type 7: Signal jamming
        let r = RandRange(seed, 0, 4);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-35"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-36"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-37"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-38"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-GetGlitchFlag-39");
    }

    // Corrupt a specific field based on glitch type
    private static func CorruptField(seed: Int32, glitchType: Int32, fieldName: String) -> String {
        // Type 0: Hardware - garbled fragments of real-sounding data
        if glitchType == 0 {
            return KdspScannerGlitch.HardwareGlitch(seed, fieldName);
        }
        // Type 1: Database - SQL errors and corrupted records
        if glitchType == 1 {
            return KdspScannerGlitch.DatabaseGlitch(seed, fieldName);
        }
        // Type 2: NetWatch - redacted / access denied
        if glitchType == 2 {
            return KdspScannerGlitch.NetWatchGlitch(seed, fieldName);
        }
        // Type 3: Ghost - everything returns null/empty
        if glitchType == 3 {
            return KdspScannerGlitch.GhostGlitch(seed, fieldName);
        }
        // Type 4: Cyberpsychosis - hostile signal garbling
        if glitchType == 4 {
            return KdspScannerGlitch.CyberpsychoGlitch(seed, fieldName);
        }
        // Type 5: Classified - redacted government style
        if glitchType == 5 {
            return KdspScannerGlitch.ClassifiedGlitch(seed, fieldName);
        }
        // Type 6: Memory corruption - hex dumps and stack traces
        if glitchType == 6 {
            return KdspScannerGlitch.MemoryGlitch(seed, fieldName);
        }
        // Type 7: Signal jam - static and fragments
        return KdspScannerGlitch.JammedGlitch(seed, fieldName);
    }

    // ═══════════════════ GLITCH TYPE GENERATORS ═══════════════════

    private static func HardwareGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-HardwareGlitch-7");
    }

    private static func DatabaseGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-DatabaseGlitch-7");
    }

    private static func NetWatchGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-NetWatchGlitch-7");
    }

    private static func GhostGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-GhostGlitch-7");
    }

    private static func CyberpsychoGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-CyberpsychoGlitch-7");
    }

    private static func ClassifiedGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-ClassifiedGlitch-7");
    }

    private static func MemoryGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-MemoryGlitch-7");
    }

    private static func JammedGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-0"); }
        if r == 1 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-1"); }
        if r == 2 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-2"); }
        if r == 3 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-3"); }
        if r == 4 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-4"); }
        if r == 5 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-5"); }
        if r == 6 { return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-6"); }
        return GetLocalizedTextByKey(n"Kdsp-Glitch-JammedGlitch-7");
    }
}
