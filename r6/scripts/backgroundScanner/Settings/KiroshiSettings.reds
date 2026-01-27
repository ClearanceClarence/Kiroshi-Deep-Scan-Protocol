// Kiroshi Deep Scan - Mod Settings Integration
// Requires: Mod Settings Menu (https://www.nexusmods.com/cyberpunk2077/mods/4885)

// Enum for Special NPC Rarity dropdown
enum SpecialNPCRarity {
    Common = 0,
    Rare = 1,
    Mythic = 2
}

public class KiroshiDeepScanSystem extends ScriptableSystem {
    private let m_settings: ref<KiroshiDeepScanSettings>;

    private func OnAttach() -> Void {
        this.m_settings = new KiroshiDeepScanSettings();
        ModSettings.RegisterListenerToClass(this.m_settings);
    }

    private func OnDetach() -> Void {
        ModSettings.UnregisterListenerToClass(this.m_settings);
        this.m_settings = null;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<KiroshiDeepScanSystem> {
        let system = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"KiroshiDeepScanSystem") as KiroshiDeepScanSystem;
        return system;
    }

    public func GetSettings() -> ref<KiroshiDeepScanSettings> {
        return this.m_settings;
    }
}

public class KiroshiDeepScanSettings {
    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display Options")
    @runtimeProperty("ModSettings.displayName", "Data Density")
    @runtimeProperty("ModSettings.description", "Controls how much information is displayed per scan. High = Full detailed reports (default). Medium = Condensed data, fewer entries. Low = Minimal essential info only.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "3")
    public let dataDensity: Int32 = 3;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display Options")
    @runtimeProperty("ModSettings.displayName", "Header Font Size")
    @runtimeProperty("ModSettings.description", "Font size for section headers (Background, Criminal Record, etc). Default: 20")
    @runtimeProperty("ModSettings.step", "2")
    @runtimeProperty("ModSettings.min", "14")
    @runtimeProperty("ModSettings.max", "28")
    public let headerFontSize: Int32 = 20;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Display Options")
    @runtimeProperty("ModSettings.displayName", "Text Font Size")
    @runtimeProperty("ModSettings.description", "Font size for data text content. Default: 26")
    @runtimeProperty("ModSettings.step", "2")
    @runtimeProperty("ModSettings.min", "18")
    @runtimeProperty("ModSettings.max", "34")
    public let textFontSize: Int32 = 26;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Generation Mode")
    @runtimeProperty("ModSettings.displayName", "Narrative Coherence")
    @runtimeProperty("ModSettings.description", "Links NPC data together into believable stories. Criminal records explain backstory events, jobs match wealth levels, medical history reflects lifestyle. Disabled = maximum variety, Enabled = tighter narratives.")
    public let enableCoherence: Bool = false;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Generation Mode")
    @runtimeProperty("ModSettings.displayName", "Special NPC Rarity")
    @runtimeProperty("ModSettings.description", "How often special flagged NPCs appear (sleeper agents, pre-cyberpsychos, witnesses, etc).")
    @runtimeProperty("ModSettings.displayValues.Common", "Common (1 in 250)")
    @runtimeProperty("ModSettings.displayValues.Rare", "Rare (1 in 750)")
    @runtimeProperty("ModSettings.displayValues.Mythic", "Mythic (1 in 2000)")
    public let specialNPCRarity: SpecialNPCRarity = SpecialNPCRarity.Rare;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Content Options")
    @runtimeProperty("ModSettings.displayName", "Enable Diverse Relationships")
    @runtimeProperty("ModSettings.description", "Includes same-sex relationships, polyamory, and varied romantic configurations in NPC backstories. Lore-friendly for Night City.")
    public let enableDiverseRelationships: Bool = false;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Content Options")
    @runtimeProperty("ModSettings.displayName", "Enable Body Modification Records")
    @runtimeProperty("ModSettings.description", "Includes gender-affirming cyberware in NPC medical records. Reflects the body modification culture of Night City.")
    public let enableBodyModRecords: Bool = false;

    @runtimeProperty("ModSettings.mod", "Kiroshi Deep Scan")
    @runtimeProperty("ModSettings.category", "Content Options")
    @runtimeProperty("ModSettings.displayName", "Display Pronouns")
    @runtimeProperty("ModSettings.description", "Shows pronoun information in NPC scan data. Includes they/them and neopronouns for some NPCs.")
    public let enablePronounDisplay: Bool = false;
}

// Static helper class for accessing settings from anywhere
public abstract class KiroshiSettings {
    
    // Returns 1 (Low), 2 (Medium), or 3 (High/Full)
    public static func GetDataDensity() -> Int32 {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().dataDensity;
        }
        return 3; // Default to High
    }

    public static func GetHeaderFontSize() -> Int32 {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().headerFontSize;
        }
        return 20; // Default
    }

    public static func GetTextFontSize() -> Int32 {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().textFontSize;
        }
        return 26; // Default
    }

    // Helper to check density levels
    public static func IsLowDensity() -> Bool {
        return KiroshiSettings.GetDataDensity() == 1;
    }

    public static func IsMediumDensity() -> Bool {
        return KiroshiSettings.GetDataDensity() == 2;
    }

    public static func IsHighDensity() -> Bool {
        return KiroshiSettings.GetDataDensity() >= 3;
    }

    // Returns max items for lists based on density
    // High=max, Medium=half, Low=1-2
    public static func GetMaxListItems(maxItems: Int32) -> Int32 {
        let density = KiroshiSettings.GetDataDensity();
        if density == 1 {
            return Max(1, maxItems / 4);
        } else if density == 2 {
            return Max(1, maxItems / 2);
        }
        return maxItems;
    }

    public static func CoherenceEnabled() -> Bool {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableCoherence;
        }
        return false;
    }

    public static func GetSpecialNPCRarity() -> Int32 {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            let option = system.GetSettings().specialNPCRarity;
            // Convert enum to actual rarity value
            // Common = 250, Rare = 750, Mythic = 2000
            if Equals(option, SpecialNPCRarity.Common) { return 250; }
            if Equals(option, SpecialNPCRarity.Rare) { return 750; }
            if Equals(option, SpecialNPCRarity.Mythic) { return 2000; }
        }
        return 750; // Default to Rare
    }

    public static func DiverseRelationshipsEnabled() -> Bool {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableDiverseRelationships;
        }
        return false;
    }

    public static func BodyModRecordsEnabled() -> Bool {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enableBodyModRecords;
        }
        return false;
    }

    public static func PronounDisplayEnabled() -> Bool {
        let system = KiroshiDeepScanSystem.GetInstance(GetGameInstance());
        if IsDefined(system) && IsDefined(system.GetSettings()) {
            return system.GetSettings().enablePronounDisplay;
        }
        return false;
    }
}
