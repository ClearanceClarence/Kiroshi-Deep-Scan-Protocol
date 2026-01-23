// Kiroshi Deep Scan - Mod Settings Integration
// Requires: Mod Settings Menu (https://www.nexusmods.com/cyberpunk2077/mods/4885)

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

