// Kiroshi Deep Scan Protocol - Unique NPC Manager
// Detects and retrieves hand-crafted backstories for named characters

public abstract class KdspUniqueNPCManager {

    // Resolves the entry once across all three identifier types
    // (record ID → display name → appearance name).
    // Returns null if this isn't a unique NPC.
    public static func TryGetBackstory(target: wref<NPCPuppet>) -> ref<KdspUniqueNPCBackstory> {
        // 1. Record ID
        let recordId = KdspUniqueNPCManager.GetCharacterRecordId(target);
        let entry = KdspUniqueNPCEntries.GetEntry(recordId);
        if IsDefined(entry) {
            if !KdspUniqueNPCManager.MeetsQuestRequirements(target, recordId) {
                return null;
            }
            return entry;
        }
        // 2. Display name
        let displayName = KdspUniqueNPCManager.GetDisplayName(target);
        entry = KdspUniqueNPCEntries.GetEntry(displayName);
        if IsDefined(entry) {
            if !KdspUniqueNPCManager.MeetsQuestRequirements(target, displayName) {
                return null;
            }
            return entry;
        }
        // 3. Appearance name
        let appearanceName = KdspUniqueNPCManager.GetAppearanceName(target);
        return KdspUniqueNPCEntries.GetEntry(appearanceName);
    }

    public static func IsUniqueNPC(target: wref<NPCPuppet>) -> Bool {
        return IsDefined(KdspUniqueNPCManager.TryGetBackstory(target));
    }

    // Check if quest requirements are met for certain NPCs
    public static func MeetsQuestRequirements(target: wref<NPCPuppet>, recordId: String) -> Bool {
        let id = StrLower(recordId);
        let game = target.GetGame();
        
        // Viktor - only after first ripperdoc visit (q001_01_victor)
        if StrContains(id, "viktor") || StrContains(id, "vektor") {
            return KdspUniqueNPCManager.IsFactTrue(game, "q001_01_victor_done") || 
                   KdspUniqueNPCManager.IsFactTrue(game, "q001_done") ||
                   KdspUniqueNPCManager.IsQuestComplete(game, "q001_01_victor");
        }
        
        // All other NPCs don't have quest requirements
        return true;
    }
    
    // Helper: Check if a game fact is set (non-zero)
    public static func IsFactTrue(game: GameInstance, factName: String) -> Bool {
        let qs = GameInstance.GetQuestsSystem(game);
        if IsDefined(qs) {
            return qs.GetFact(StringToName(factName)) > 0;
        }
        return false;
    }
    
    // Helper: Check if a quest phase is complete via journal
    public static func IsQuestComplete(game: GameInstance, questId: String) -> Bool {
        let journal = GameInstance.GetJournalManager(game);
        if IsDefined(journal) {
            // Try to get quest state - if we've interacted with Viktor, the quest should be tracked
            let factValue = GameInstance.GetQuestsSystem(game).GetFact(StringToName(questId));
            return factValue > 0;
        }
        return false;
    }

    // Get the character's TweakDB record ID as a string
    public static func GetCharacterRecordId(target: wref<NPCPuppet>) -> String {
        let record = target.GetRecord();
        if IsDefined(record) {
            return TDBID.ToStringDEBUG(record.GetID());
        }
        return "";
    }

    // Get the NPC's display name
    public static func GetDisplayName(target: wref<NPCPuppet>) -> String {
        let record = target.GetRecord();
        if IsDefined(record) {
            return GetLocalizedTextByKey(record.FullDisplayName());
        }
        return "";
    }

    // Check if we have an entry for this character ID
    // Add new characters here using StrContains for flexible matching
    public static func HasEntry(recordId: String) -> Bool {
        return IsDefined(KdspUniqueNPCEntries.GetEntry(recordId));
    }

    public static func GetBackstory(target: wref<NPCPuppet>) -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCManager.TryGetBackstory(target);
    }

    // Get the NPC's current appearance name
    public static func GetAppearanceName(target: wref<NPCPuppet>) -> String {
        return NameToString(target.GetCurrentAppearanceName());
    }
}
