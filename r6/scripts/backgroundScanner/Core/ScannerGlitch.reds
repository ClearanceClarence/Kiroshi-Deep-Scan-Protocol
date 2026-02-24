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
        glitched.earlyLife = KdspScannerGlitch.CorruptField(seed * 11 + 28661, glitchType, "earlyLife");

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
        glitched.debugInfo = backstoryUI.debugInfo + " | GLITCH TYPE: " + IntToString(glitchType);

        return glitched;
    }

    // Corrupt the NCPD ID
    private static func CorruptID(seed: Int32) -> String {
        let r = RandRange(seed, 0, 9);
        if r == 0 { return "NC??????"; }
        if r == 1 { return "NC000000"; }
        if r == 2 { return "ERR_NULL_REF"; }
        if r == 3 { return "NC---[CORRUPTED]"; }
        if r == 4 { return "ID_NOT_FOUND"; }
        if r == 5 { return "NC8█████"; }
        if r == 6 { return "RECORD_EXPUNGED"; }
        if r == 7 { return "██████████"; }
        if r == 8 { return "NC[OVERFLOW]"; }
        return "SYS_ERR_0xDEAD";
    }

    // Generate the glitch classification flag
    private static func GetGlitchFlag(seed: Int32, glitchType: Int32) -> String {
        // Type 0: Hardware malfunction
        if glitchType == 0 { 
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ KIROSHI OPTICS MALFUNCTION - DATA INTEGRITY COMPROMISED ⚠"; }
            if r == 1 { return "⚠ SCANNER HARDWARE FAULT - RECALIBRATION REQUIRED ⚠"; }
            if r == 2 { return "⚠ OPTIC NERVE INTERFERENCE DETECTED - SCAN UNRELIABLE ⚠"; }
            if r == 3 { return "⚠ FIRMWARE CORRUPTION - KIROSHI v4.7.2 INTEGRITY CHECK FAILED ⚠"; }
            return "⚠ LENS ARRAY MISALIGNMENT - BIOMETRIC READ FAILED ⚠";
        }
        // Type 1: Database corruption
        if glitchType == 1 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ NCPD DATABASE CORRUPTION - RECORD UNREADABLE ⚠"; }
            if r == 1 { return "⚠ DB_ERROR: TABLE 'citizens' CHECKSUM MISMATCH ⚠"; }
            if r == 2 { return "⚠ CORRUPTED SECTOR 0x7F - PARTIAL DATA LOSS ⚠"; }
            if r == 3 { return "⚠ DATABASE TIMEOUT - NCPD CENTRAL NODE UNREACHABLE ⚠"; }
            return "⚠ FATAL: CITIZEN RECORD FRAGMENTED ACROSS 3 SHARDS ⚠";
        }
        // Type 2: NetWatch interference 
        if glitchType == 2 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ NETWATCH INTERFERENCE DETECTED - SCAN BLOCKED ⚠"; }
            if r == 1 { return "⚠ ACTIVE ICE ENCOUNTERED - DATA RETRIEVAL ABORTED ⚠"; }
            if r == 2 { return "⚠ NETWATCH BLACKWALL PROXIMITY ALERT - SIGNAL SCRAMBLED ⚠"; }
            if r == 3 { return "⚠ NET INTRUSION COUNTERMEASURE ACTIVE - ACCESS DENIED ⚠"; }
            return "⚠ UNAUTHORIZED SCAN DETECTED BY NETWATCH - CONNECTION SEVERED ⚠";
        }
        // Type 3: Ghost / scrubbed identity
        if glitchType == 3 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ IDENTITY SCRUBBED - PROFESSIONAL WIPE DETECTED ⚠"; }
            if r == 1 { return "⚠ GHOST PROTOCOL - NO RECORDS EXIST FOR THIS INDIVIDUAL ⚠"; }
            if r == 2 { return "⚠ ALL DATABASES RETURN NULL - IDENTITY DOES NOT EXIST ⚠"; }
            if r == 3 { return "⚠ FIXER-GRADE IDENTITY WIPE - ZERO FOOTPRINT ⚠"; }
            return "⚠ SUBJECT HAS NO DIGITAL EXISTENCE - POSSIBLE DEEP COVER ⚠";
        }
        // Type 4: Cyberpsychosis interference
        if glitchType == 4 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ SUBJECT EMITTING HOSTILE SIGNAL - SCAN CORRUPTED ⚠"; }
            if r == 1 { return "⚠ CYBERPSYCHOTIC EMISSION DETECTED - OPTICS SCRAMBLED ⚠"; }
            if r == 2 { return "⚠ ELECTROMAGNETIC INTERFERENCE FROM SUBJECT - DATA LOST ⚠"; }
            if r == 3 { return "⚠ HOSTILE CYBERWARE BROADCAST - SCANNER OVERLOADED ⚠"; }
            return "⚠ WARNING: SUBJECT'S ICE ATTACKING YOUR OPTICS ⚠";
        }
        // Type 5: Classified / government blackout
        if glitchType == 5 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ CLASSIFIED - NUSA FEDERAL RECORDS SEALED ⚠"; }
            if r == 1 { return "⚠ ACCESS LEVEL INSUFFICIENT - ARASAKA SECURITY CLEARANCE REQUIRED ⚠"; }
            if r == 2 { return "⚠ MILITECH COUNTERINTELLIGENCE FLAG - DATA RESTRICTED ⚠"; }
            if r == 3 { return "⚠ RECORD SEALED BY ORDER OF NIGHT CITY COUNCIL ⚠"; }
            return "⚠ CORPORATE BLACKSITE PERSONNEL - ALL DATA CLASSIFIED ⚠";
        }
        // Type 6: Data overflow / memory corruption
        if glitchType == 6 {
            let r = RandRange(seed, 0, 4);
            if r == 0 { return "⚠ BUFFER OVERFLOW - STACK TRACE DUMPED ⚠"; }
            if r == 1 { return "⚠ MEMORY ALLOCATION FAILURE - KIROSHI CORE DUMP ⚠"; }
            if r == 2 { return "⚠ SEGFAULT AT 0xDEADBEEF - REBOOT OPTICS ⚠"; }
            if r == 3 { return "⚠ HEAP CORRUPTION DETECTED - SCAN DATA UNRELIABLE ⚠"; }
            return "⚠ FATAL EXCEPTION IN BIOMETRIC_PARSER.DLL - SCAN ABORTED ⚠";
        }
        // Type 7: Signal jamming
        let r = RandRange(seed, 0, 4);
        if r == 0 { return "⚠ ACTIVE SIGNAL JAMMER IN AREA - SCAN DISRUPTED ⚠"; }
        if r == 1 { return "⚠ ELECTRONIC WARFARE COUNTERMEASURES DETECTED ⚠"; }
        if r == 2 { return "⚠ MILITARY-GRADE SIGNAL INTERFERENCE - NO DATA ⚠"; }
        if r == 3 { return "⚠ BROADBAND JAMMING ON ALL FREQUENCIES - SCAN FAILED ⚠"; }
        return "⚠ UNKNOWN SIGNAL SOURCE DISRUPTING KIROSHI UPLINK ⚠";
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
        if r == 0 { return "L█ved in a c░rpo z██e... [LENS ERROR] ...fa██er d█ed of..."; }
        if r == 1 { return "R░ised by... [SIGNAL LOST] ...str██t fig██s for m░ney..."; }
        if r == 2 { return "█████ ░░░ OPTIC FEED INTERRUPTED ░░░ █████"; }
        if r == 3 { return "...wor██d as a... [CALIBRATION DRIFT] ...ter░inated in 20█░..."; }
        if r == 4 { return "Sc░nner re░d: [NOISE] ...imp█ants: █ | Sta█us: ░░░..."; }
        if r == 5 { return "Da█a fr░gment: ...cr░dit ra█ing: ░░░ | Inc░me: €$█,███..."; }
        if r == 6 { return "Bio░etric lo██: ...bl██d: ░ R█D+ | Co█ditions: ░░░ [ERR]..."; }
        return "[KIROSHI v4.7 RECALIBRATING] ...par█ial d░ta: ...███ ░░░ ███...";
    }

    private static func DatabaseGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "ERROR 1045: Access denied for user 'kiroshi_scan'@'ncpd.local'"; }
        if r == 1 { return "SELECT * FROM citizens WHERE id=NULL; -- 0 rows returned"; }
        if r == 2 { return "TABLE 'background_records' corrupted at block 0x4F2A - rebuild required"; }
        if r == 3 { return "FOREIGN KEY CONSTRAINT FAILED: citizen_id references deleted record"; }
        if r == 4 { return "WARNING: Record modified 847 times in last 24h - data tampering suspected"; }
        if r == 5 { return "DEADLOCK on table 'financial_records' - transaction rolled back"; }
        if r == 6 { return "Checksum mismatch: expected 0xA7F3, got 0x0000. Record zeroed."; }
        return "CONNECTION_RESET: NCPD master DB unreachable (timeout after 30000ms)";
    }

    private static func NetWatchGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "[ACCESS DENIED - NETWATCH AUTH LEVEL 7 REQUIRED]"; }
        if r == 1 { return "██████████████ [REDACTED BY NETWATCH] ██████████████"; }
        if r == 2 { return "CONNECTION TERMINATED BY REMOTE HOST (netwatch-node-07.nc)"; }
        if r == 3 { return "ICE LEVEL 3 ENCOUNTERED - SCAN PROBE DESTROYED"; }
        if r == 4 { return "[BLACKWALL ADJACENT DATA - RETRIEVAL PROHIBITED]"; }
        if r == 5 { return "NETWATCH DIRECTIVE 7-7-0: UNAUTHORIZED SCAN OF PROTECTED INDIVIDUAL"; }
        if r == 6 { return "YOUR KIROSHI SERIAL HAS BEEN LOGGED. CEASE SCANNING IMMEDIATELY."; }
        return "DATA QUARANTINED - POSSIBLE ROGUE AI CONTAMINATION IN RECORD";
    }

    private static func GhostGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "[NO DATA]"; }
        if r == 1 { return "[RECORD NOT FOUND]"; }
        if r == 2 { return "---"; }
        if r == 3 { return "[NULL]"; }
        if r == 4 { return "This person does not exist."; }
        if r == 5 { return "[ZERO RESULTS ACROSS ALL DATABASES]"; }
        if r == 6 { return "No birth certificate. No ID. No history. Nothing."; }
        return "[BLANK]";
    }

    private static func CyberpsychoGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "k̷͉̈́i̸̛̱l̸̰̾l̶̰̈ ̴̧̛t̸͙̊h̶͎̄e̸̞̔m̶̩̊ ̷̣̊a̶̦͝l̸̰̈́l̶̜͝ k̵̢̈́i̷̱̇l̸̰̾l̶̰̈ SIGNAL CORRUPTED"; }
        if r == 1 { return "HOSTILE BROADCAST: ...I CAN SEE YOU SCANNING ME..."; }
        if r == 2 { return "█▓▒░ OPTICS OVERLOAD ░▒▓█ ...they're in the walls..."; }
        if r == 3 { return "ALERT: Your cyberware is being probed. Disconnect NOW."; }
        if r == 4 { return "W̵̱̄Ȃ̷̧R̸̖̈N̸̡̔Ȉ̸̧N̷̰̕G̸̱̈: ̸̧̈S̵̱̄U̸̡̔B̵̰̄J̵̧̈́E̵̱̔C̵̢̈́T̸̖̈ ̵̧̈́A̵̱̔W̵̰̄Ä̵̧́Ṟ̵̔E̸̡̔"; }
        if r == 5 { return "ṠCAN ░RROR: Subject's chrome is broadcasting junk data on all bands"; }
        if r == 6 { return "...hElP mE... [INTERCEPTION] ...iT wOnT sToP... [SIGNAL NOISE]..."; }
        return "CYBERPSYCHOTIC EMISSION OVERRIDING SCAN FEED - PURGING BUFFER";
    }

    private static func ClassifiedGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "[CLASSIFIED - NUSA FEDERAL STATUTE 77.4.2]"; }
        if r == 1 { return "████████████ [REDACTED] ████████████"; }
        if r == 2 { return "[SECURITY CLEARANCE LEVEL 9 REQUIRED - YOU HAVE LEVEL 0]"; }
        if r == 3 { return "This record is sealed by corporate security order #NC-2077-CLASSIFIED"; }
        if r == 4 { return "[DATA RESTRICTED - AUTHORIZED PERSONNEL ONLY]"; }
        if r == 5 { return "ARASAKA SECURITY DIVISION: ACCESS TO THIS FILE IS A CRIMINAL OFFENSE"; }
        if r == 6 { return "[MILITECH INTERNAL - EYES ONLY - DO NOT DISTRIBUTE]"; }
        return "[SEALED BY NIGHT CITY DISTRICT ATTORNEY - PENDING INVESTIGATION]";
    }

    private static func MemoryGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "0x4B 0x49 0x52 0x4F 0x53 0x48 0x49 [HEAP OVERFLOW]"; }
        if r == 1 { return "at kiroshi.scan.parse(BiometricData.cpp:1847) SIGSEGV"; }
        if r == 2 { return "PANIC: kernel stack overflow at address 0xFFFFFFFF8041A2C0"; }
        if r == 3 { return "free(): corrupted unsorted chunks - optics firmware unstable"; }
        if r == 4 { return "*** stack smashing detected ***: kiroshi_scanner terminated"; }
        if r == 5 { return "NullPointerException: target.biometric_profile is undefined"; }
        if r == 6 { return "CORE DUMP: /tmp/kiroshi_crash_2077_02_14.bin (47.3 MB)"; }
        return "malloc(): memory corruption (fast) 0x0000555555DC4A70";
    }

    private static func JammedGlitch(seed: Int32, fieldName: String) -> String {
        let r = RandRange(seed, 0, 7);
        if r == 0 { return "░░░░░░ [STATIC] ░░░░░░ [STATIC] ░░░░░░"; }
        if r == 1 { return "...fra█ment... [JAM] ...█████... [JAM] ...los░..."; }
        if r == 2 { return "[SIGNAL: 2% - INSUFFICIENT FOR BIOMETRIC READ]"; }
        if r == 3 { return "▓▓▓▓▓ NO CARRIER ▓▓▓▓▓"; }
        if r == 4 { return "[BROADBAND NOISE FLOOR EXCEEDED - ALL CHANNELS UNUSABLE]"; }
        if r == 5 { return "...░░░... [BURST] ...█████... [LOST] ...░░░... [NOTHING]..."; }
        if r == 6 { return "CARRIER LOST | RETRY 1/5... FAILED | RETRY 2/5... FAILED | ABORTING"; }
        return "JAMMING SOURCE TRIANGULATED: <LOCATION UNKNOWN> - MILITARY GRADE EQUIPMENT";
    }
}
