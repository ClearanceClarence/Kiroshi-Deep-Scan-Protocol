// Kiroshi Deep Scan Protocol - Connection Tracker
// Session scan history for cross-referencing between scanned NPCs.
// Used by Tracked and Full connection modes. Resets on load.

public class KdspConnectionTracker extends ScriptableSystem {

    // Parallel arrays — index N across all = one scanned NPC
    private let m_entityHashes:   array<Int32>;
    private let m_names:          array<String>;
    private let m_gangs:          array<String>;
    private let m_districts:      array<String>;
    private let m_archetypes:     array<String>;

    // Relationship cross-reference index
    // Every relationship name from every scan, pointing back to its owner
    private let m_relNames:       array<String>;
    private let m_relContexts:    array<String>;
    private let m_relOwnerIdx:    array<Int32>;

    private let m_maxScans: Int32;

    // ── Lifecycle ─────────────────────────────────────────────────────────

    private func OnAttach() -> Void {
        this.m_maxScans = 150;
    }

    public static func GetInstance(gi: GameInstance) -> ref<KdspConnectionTracker> {
        let system = GameInstance.GetScriptableSystemsContainer(gi).Get(n"KdspConnectionTracker") as KdspConnectionTracker;
        return system;
    }

    // ── Register a Scan ───────────────────────────────────────────────────

    public func RegisterScan(
        entityHash: Int32,
        fullName: String,
        gang: String,
        district: String,
        archetype: String,
        relationshipNames: array<String>,
        relationshipContexts: array<String>
    ) -> Void {

        if this.HasEntity(entityHash) {
            return;
        };

        if ArraySize(this.m_entityHashes) >= this.m_maxScans {
            this.EvictOldest();
        };

        let scanIdx: Int32 = ArraySize(this.m_entityHashes);
        ArrayPush(this.m_entityHashes, entityHash);
        ArrayPush(this.m_names, fullName);
        ArrayPush(this.m_gangs, gang);
        ArrayPush(this.m_districts, district);
        ArrayPush(this.m_archetypes, archetype);

        let i: Int32 = 0;
        while i < ArraySize(relationshipNames) {
            ArrayPush(this.m_relNames, relationshipNames[i]);
            if i < ArraySize(relationshipContexts) {
                ArrayPush(this.m_relContexts, relationshipContexts[i]);
            } else {
                ArrayPush(this.m_relContexts, "Known contact");
            };
            ArrayPush(this.m_relOwnerIdx, scanIdx);
            i += 1;
        };
    }

    // ── Query: Was this name listed as a relationship in any prior scan? ──

    public func FindInPriorRelationships(name: String) -> String {
        if StrLen(name) < 3 {
            return "";
        };

        let target: String = StrLower(name);
        let i: Int32 = 0;
        while i < ArraySize(this.m_relNames) {
            if Equals(StrLower(this.m_relNames[i]), target) {
                let idx: Int32 = this.m_relOwnerIdx[i];
                if idx >= 0 && idx < ArraySize(this.m_names) {
                    let out: String = this.m_names[idx];
                    if NotEquals(this.m_gangs[idx], "") && NotEquals(this.m_gangs[idx], "NONE") {
                        out += " [" + this.m_gangs[idx] + "]";
                    };
                    if NotEquals(this.m_districts[idx], "") {
                        out += GetLocalizedTextByKey(n"Kdsp-ConnectionTrac-S0") + this.m_districts[idx];
                    };
                    out += GetLocalizedTextByKey(n"Kdsp-ConnectionTrac-S1") + this.m_relContexts[i];
                    return out;
                };
            };
            i += 1;
        };
        return "";
    }

    // ── Query: Do any of these names match relationships in prior scans? ──

    public func FindSharedContacts(names: array<String>) -> array<String> {
        let matches: array<String>;
        let i: Int32 = 0;
        while i < ArraySize(names) {
            let target: String = StrLower(names[i]);
            let j: Int32 = 0;
            while j < ArraySize(this.m_relNames) {
                if Equals(StrLower(this.m_relNames[j]), target) {
                    let idx: Int32 = this.m_relOwnerIdx[j];
                    if idx >= 0 && idx < ArraySize(this.m_names) {
                        ArrayPush(matches, names[i] + GetLocalizedTextByKey(n"Kdsp-ConnectionTrac-S2") + this.m_names[idx] + ")");
                    };
                };
                j += 1;
            };
            i += 1;
        };
        return matches;
    }

    // ── Query: Get a previously scanned NPC for injection ─────────────────
    //  Prefers same district or gang.

    public func GetInjectableNPC(seed: Int32, district: String, gang: String) -> String {
        let count: Int32 = ArraySize(this.m_names);
        if count == 0 { return ""; };

        // Try same district or gang first
        let candidates: array<Int32>;
        let i: Int32 = 0;
        while i < count {
            let sameDistrict: Bool = NotEquals(district, "") && Equals(this.m_districts[i], district);
            let sameGang: Bool = NotEquals(gang, "") && NotEquals(gang, "NONE") && Equals(this.m_gangs[i], gang);
            if sameDistrict || sameGang {
                ArrayPush(candidates, i);
            };
            i += 1;
        };

        if ArraySize(candidates) == 0 {
            return this.m_names[RandRange(seed, 0, count)];
        };

        return this.m_names[candidates[RandRange(seed, 0, ArraySize(candidates))]];
    }

    // ── Query: Should we inject? (15% after 3+ scans) ─────────────────────

    public func ShouldInject(seed: Int32) -> Bool {
        return ArraySize(this.m_names) >= 3 && RandRange(seed, 0, 100) < 15;
    }

    // ── Query: Scan count ─────────────────────────────────────────────────

    public func GetScanCount() -> Int32 {
        return ArraySize(this.m_entityHashes);
    }

    // ── Internal ──────────────────────────────────────────────────────────

    private func HasEntity(entityHash: Int32) -> Bool {
        let i: Int32 = 0;
        while i < ArraySize(this.m_entityHashes) {
            if this.m_entityHashes[i] == entityHash { return true; };
            i += 1;
        };
        return false;
    }

    private func EvictOldest() -> Void {
        if ArraySize(this.m_entityHashes) == 0 { return; };

        ArrayErase(this.m_entityHashes, 0);
        ArrayErase(this.m_names, 0);
        ArrayErase(this.m_gangs, 0);
        ArrayErase(this.m_districts, 0);
        ArrayErase(this.m_archetypes, 0);

        let i: Int32 = ArraySize(this.m_relNames) - 1;
        while i >= 0 {
            if this.m_relOwnerIdx[i] == 0 {
                ArrayErase(this.m_relNames, i);
                ArrayErase(this.m_relContexts, i);
                ArrayErase(this.m_relOwnerIdx, i);
            } else {
                this.m_relOwnerIdx[i] -= 1;
            };
            i -= 1;
        };
    }
}
