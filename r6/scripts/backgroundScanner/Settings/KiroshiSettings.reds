// Kiroshi Deep Scan - Mod Settings Integration
// Requires: Mod Settings Menu (https://www.nexusmods.com/cyberpunk2077/mods/4885)

// Enum for Compact Mode dropdown
enum KdspCompactMode {
    Off = 0,
    Tight = 1,
    Tighter = 2,
    Tightest = 3
}

// Enum for Special NPC Rarity dropdown
enum KdspSpecialNPCRarity {
    Common = 0,
    Rare = 1,
    Mythic = 2
}

public class KdspDeepScanSystem extends ScriptableSystem {
    private let m_settings: ref<KdspDeepScanSettings>;

    private func OnAttach() -> Void {
        this.m_settings = new KdspDeepScanSettings();
        ModSettings.RegisterListenerToClass(this.m_settings);
    }

    private func OnDetach() -> Void {
        ModSettings.UnregisterListenerToClass(this.m_settings);
        this.m_settings = null;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<KdspDeepScanSystem> {
        let system = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"KdspDeepScanSystem") as KdspDeepScanSystem;
        return system;
    }

    public func GetSettings() -> ref<KdspDeepScanSettings> {
        return this.m_settings;
    }
}

public class KdspDeepScanSettings {
    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display")
    @runtimeProperty("ModSettings.displayName", "Data Density")
    @runtimeProperty("ModSettings.description", "Amount of information shown per scan. High shows full reports, Medium shows condensed data, Low shows essentials only.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "3")
    public let dataDensity: Int32 = 3;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display")
    @runtimeProperty("ModSettings.displayName", "Header Font Size")
    @runtimeProperty("ModSettings.description", "Size of section headers like Background, Criminal Record, etc.")
    @runtimeProperty("ModSettings.step", "2")
    @runtimeProperty("ModSettings.min", "14")
    @runtimeProperty("ModSettings.max", "28")
    public let headerFontSize: Int32 = 20;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display")
    @runtimeProperty("ModSettings.displayName", "Text Font Size")
    @runtimeProperty("ModSettings.description", "Size of the body text within each section.")
    @runtimeProperty("ModSettings.step", "2")
    @runtimeProperty("ModSettings.min", "18")
    @runtimeProperty("ModSettings.max", "34")
    public let textFontSize: Int32 = 26;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display")
    @runtimeProperty("ModSettings.displayName", "Compact Mode")
    @runtimeProperty("ModSettings.description", "Reduces spacing between sections. Useful if other scanner mods add content and the panel gets too tall.")
    @runtimeProperty("ModSettings.displayValues.Off", "Off")
    @runtimeProperty("ModSettings.displayValues.Tight", "Tight")
    @runtimeProperty("ModSettings.displayValues.Tighter", "Tighter")
    @runtimeProperty("ModSettings.displayValues.Tightest", "Tightest")
    public let compactMode: KdspCompactMode = KdspCompactMode.Off;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display")
    @runtimeProperty("ModSettings.displayName", "Compact Relationships")
    @runtimeProperty("ModSettings.description", "Trims the Relationships section to essentials: status, 2 family, 2 associates, enemies. Off shows the full version with emergency contact, professional contacts, romantic history, and network size.")
    public let compactRelationships: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Generation")
    @runtimeProperty("ModSettings.displayName", "Special NPC Rarity")
    @runtimeProperty("ModSettings.description", "How often NPCs have hidden status flags like sleeper agents, pre-cyberpsychos, or witnesses.")
    @runtimeProperty("ModSettings.displayValues.Common", "Common (1 in 250)")
    @runtimeProperty("ModSettings.displayValues.Rare", "Rare (1 in 750)")
    @runtimeProperty("ModSettings.displayValues.Mythic", "Mythic (1 in 2000)")
    public let specialNPCRarity: KdspSpecialNPCRarity = KdspSpecialNPCRarity.Rare;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Content")
    @runtimeProperty("ModSettings.displayName", "Diverse Relationships")
    @runtimeProperty("ModSettings.description", "Includes same-sex partnerships, polyamory, and varied relationship types in NPC backstories.")
    public let enableDiverseRelationships: Bool = false;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Content")
    @runtimeProperty("ModSettings.displayName", "Body Modification Records")
    @runtimeProperty("ModSettings.description", "Includes gender-affirming cyberware in NPC medical records.")
    public let enableBodyModRecords: Bool = false;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Content")
    @runtimeProperty("ModSettings.displayName", "Pronouns")
    @runtimeProperty("ModSettings.description", "Shows pronoun information in scan data.")
    public let enablePronounDisplay: Bool = false;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Generation")
    @runtimeProperty("ModSettings.displayName", "Scanner Glitches")
    @runtimeProperty("ModSettings.description", "Rare chance that a scan is fully corrupted — showing garbled data, redacted records, or error messages. Simulates hardware malfunctions, NetWatch interference, and scrubbed identities.")
    public let enableScannerGlitches: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Generation")
    @runtimeProperty("ModSettings.displayName", "Scanner Glitch Chance")
    @runtimeProperty("ModSettings.description", "How often scanner glitches occur. 1 = every scan is glitched, 500 = 1 in 500 chance. Default: 200 (0.5%).")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "500")
    public let scannerGlitchChance: Int32 = 200;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Developer")
    @runtimeProperty("ModSettings.displayName", "Debug Mode")
    @runtimeProperty("ModSettings.description", "Shows the NPC's TweakDB ID and appearance name in the scanner. Useful for bug reports.")
    public let enableDebugMode: Bool = false;

    // ═══════════════════════════════════════════════════════════
    // SECTION TOGGLES - Show/hide individual scan sections
    // ═══════════════════════════════════════════════════════════

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Background")
    @runtimeProperty("ModSettings.description", "Show the Background section (upbringing, origin story).")
    public let showBackground: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Early Life")
    @runtimeProperty("ModSettings.description", "Show the Early Life section (childhood events, formative experiences).")
    public let showEarlyLife: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Recent Activity")
    @runtimeProperty("ModSettings.description", "Show the Recent Activity section (current job, recent events).")
    public let showRecentActivity: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Psych Profile")
    @runtimeProperty("ModSettings.description", "Show the Psych Profile section (personality traits, mental state).")
    public let showPsychProfile: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Criminal Record")
    @runtimeProperty("ModSettings.description", "Show the Criminal Record section (NCPD database, arrests, warrants).")
    public let showCriminalRecord: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Gang Affiliation")
    @runtimeProperty("ModSettings.description", "Show the Gang Affiliation section (gang membership details, rank, operations).")
    public let showGangAffiliation: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Cyberware")
    @runtimeProperty("ModSettings.description", "Show the Cyberware section (implant count, status, illegal mods).")
    public let showCyberware: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Financial")
    @runtimeProperty("ModSettings.description", "Show the Financial section (income, credit rating, NCID).")
    public let showFinancial: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Medical")
    @runtimeProperty("ModSettings.description", "Show the Medical section (blood type, conditions, Trauma Team status).")
    public let showMedical: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Relationships")
    @runtimeProperty("ModSettings.description", "Show the Relationships section (family, associates, enemies).")
    public let showRelationships: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "Vehicle Registration")
    @runtimeProperty("ModSettings.description", "Show the Vehicle Registration section (owned vehicles, license status).")
    public let showVehicle: Bool = true;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Sections")
    @runtimeProperty("ModSettings.displayName", "NET Profile")
    @runtimeProperty("ModSettings.description", "Show the NET Profile section (network activity, darknet presence).")
    public let showNetProfile: Bool = true;
}

// Static helper class for accessing settings from anywhere
public abstract class KdspSettings {
    
    // Returns 1 (Low), 2 (Medium), or 3 (High/Full)
    public static func GetDataDensity() -> Int32 {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().dataDensity;
        }
        return 3; // Default to High
    }

    public static func GetHeaderFontSize() -> Int32 {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().headerFontSize;
        }
        return 20; // Default
    }

    public static func GetTextFontSize() -> Int32 {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().textFontSize;
        }
        return 26; // Default
    }

    // Helper to check density levels
    public static func IsLowDensity() -> Bool {
        return KdspSettings.GetDataDensity() == 1;
    }

    public static func IsMediumDensity() -> Bool {
        return KdspSettings.GetDataDensity() == 2;
    }

    public static func IsHighDensity() -> Bool {
        return KdspSettings.GetDataDensity() >= 3;
    }

    // Returns max items for lists based on density
    // High=max, Medium=half, Low=1-2
    public static func GetMaxListItems(maxItems: Int32) -> Int32 {
        let density = KdspSettings.GetDataDensity();
        if density == 1 {
            return Max(1, maxItems / 4);
        } else if density == 2 {
            return Max(1, maxItems / 2);
        }
        return maxItems;
    }

    // Narrative Coherence is always enabled
    // Cross-system data must always be consistent
    public static func CoherenceEnabled() -> Bool {
        return true;
    }

    public static func GetSpecialNPCRarity() -> Int32 {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            let option = system.GetSettings().specialNPCRarity;
            // Convert enum to actual rarity value
            // Common = 250, Rare = 750, Mythic = 2000
            if Equals(option, KdspSpecialNPCRarity.Common) { return 250; }
            if Equals(option, KdspSpecialNPCRarity.Rare) { return 750; }
            if Equals(option, KdspSpecialNPCRarity.Mythic) { return 2000; }
        }
        return 750; // Default to Rare
    }

    public static func DiverseRelationshipsEnabled() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableDiverseRelationships;
        }
        return false;
    }

    public static func BodyModRecordsEnabled() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableBodyModRecords;
        }
        return false;
    }

    public static func PronounDisplayEnabled() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enablePronounDisplay;
        }
        return false;
    }

    public static func DebugModeEnabled() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableDebugMode;
        }
        return false;
    }

    public static func ScannerGlitchesEnabled() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableScannerGlitches;
        }
        return true;
    }

    public static func GetScannerGlitchChance() -> Int32 {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().scannerGlitchChance;
        }
        return 200;
    }

    public static func CompactRelationshipsEnabled() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().compactRelationships;
        }
        return true; // Default on
    }

    // Compact Mode helpers
    public static func GetCompactLevel() -> Int32 {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            let mode = system.GetSettings().compactMode;
            if Equals(mode, KdspCompactMode.Tight) { return 1; }
            if Equals(mode, KdspCompactMode.Tighter) { return 2; }
            if Equals(mode, KdspCompactMode.Tightest) { return 3; }
        }
        return 0; // Off
    }

    // Returns section bottom margin with compact offset
    public static func GetSectionMargin(baseMargin: Float) -> Float {
        let level = KdspSettings.GetCompactLevel();
        if level == 1 { return MaxF(1.0, baseMargin - 7.0); }
        if level == 2 { return MaxF(1.0, baseMargin - 10.0); }
        if level == 3 { return 0.0; }
        return baseMargin;
    }

    // Returns header-to-value gap with compact offset
    public static func GetHeaderValueGap(baseGap: Float) -> Float {
        let level = KdspSettings.GetCompactLevel();
        if level == 1 { return MaxF(0.0, baseGap - 2.0); }
        if level == 2 { return 0.0; }
        if level == 3 { return 0.0; }
        return baseGap;
    }

    // ═══════════════════════════════════════════════════════════
    // SECTION TOGGLE HELPERS
    // ═══════════════════════════════════════════════════════════

    public static func ShowBackground() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showBackground;
        }
        return true;
    }

    public static func ShowEarlyLife() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showEarlyLife;
        }
        return true;
    }

    public static func ShowRecentActivity() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showRecentActivity;
        }
        return true;
    }

    public static func ShowPsychProfile() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showPsychProfile;
        }
        return true;
    }

    public static func ShowCriminalRecord() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showCriminalRecord;
        }
        return true;
    }

    public static func ShowGangAffiliation() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showGangAffiliation;
        }
        return true;
    }

    public static func ShowCyberware() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showCyberware;
        }
        return true;
    }

    public static func ShowFinancial() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showFinancial;
        }
        return true;
    }

    public static func ShowMedical() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showMedical;
        }
        return true;
    }

    public static func ShowRelationships() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showRelationships;
        }
        return true;
    }

    public static func ShowVehicle() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showVehicle;
        }
        return true;
    }

    public static func ShowNetProfile() -> Bool {
        let system = KdspDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().showNetProfile;
        }
        return true;
    }
}
