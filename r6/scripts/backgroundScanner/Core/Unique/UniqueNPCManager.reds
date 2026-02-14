// Kiroshi Deep Scan Protocol - Unique NPC Manager
// Detects and retrieves hand-crafted backstories for named characters

public abstract class UniqueNPCManager {

    // Check if an NPC is a unique/named character we have data for
    public static func IsUniqueNPC(target: wref<NPCPuppet>) -> Bool {
        let recordId = UniqueNPCManager.GetCharacterRecordId(target);
        if UniqueNPCManager.HasEntry(recordId) {
            // Check quest requirements for specific NPCs
            if !UniqueNPCManager.MeetsQuestRequirements(target, recordId) {
                return false;
            }
            return true;
        }
        // Fallback: check by display name
        let displayName = UniqueNPCManager.GetDisplayName(target);
        if UniqueNPCManager.HasEntry(displayName) {
            if !UniqueNPCManager.MeetsQuestRequirements(target, displayName) {
                return false;
            }
            return true;
        }
        return false;
    }

    // Check if quest requirements are met for certain NPCs
    public static func MeetsQuestRequirements(target: wref<NPCPuppet>, recordId: String) -> Bool {
        let id = StrLower(recordId);
        let game = target.GetGame();
        
        // Viktor - only after first ripperdoc visit (q001_01_victor)
        if StrContains(id, "viktor") || StrContains(id, "vektor") {
            return UniqueNPCManager.IsFactTrue(game, "q001_01_victor_done") || 
                   UniqueNPCManager.IsFactTrue(game, "q001_done") ||
                   UniqueNPCManager.IsQuestComplete(game, "q001_01_victor");
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
        return IsDefined(UniqueNPCEntries.GetEntry(recordId));
    }

    // Get the backstory for a unique NPC
    public static func GetBackstory(target: wref<NPCPuppet>) -> ref<UniqueNPCBackstory> {
        let recordId = UniqueNPCManager.GetCharacterRecordId(target);
        let entry = UniqueNPCEntries.GetEntry(recordId);
        if IsDefined(entry) {
            return entry;
        }
        // Fallback: try by display name
        let displayName = UniqueNPCManager.GetDisplayName(target);
        return UniqueNPCEntries.GetEntry(displayName);
    }
}
