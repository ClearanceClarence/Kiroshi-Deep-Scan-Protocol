// Kiroshi Deep Scan Protocol - Unique NPC Manager
// Detects and retrieves hand-crafted backstories for named characters

public abstract class UniqueNPCManager {

    // Check if an NPC is a unique/named character we have data for
    public static func IsUniqueNPC(target: wref<NPCPuppet>) -> Bool {
        let recordId = UniqueNPCManager.GetCharacterRecordId(target);
        if UniqueNPCManager.HasEntry(recordId) {
            return true;
        }
        // Fallback: check by display name
        let displayName = UniqueNPCManager.GetDisplayName(target);
        return UniqueNPCManager.HasEntry(displayName);
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
