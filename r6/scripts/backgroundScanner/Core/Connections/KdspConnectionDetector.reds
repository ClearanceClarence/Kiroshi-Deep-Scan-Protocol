// Kiroshi Deep Scan Protocol - Connection Detector
// Runs cross-reference checks after relationship generation and produces
// the Network Analysis alert text. connectionMode: 0=Off 1=Phantom 2=Tracked 3=Full

public class KdspConnectionResult {
    public let alerts:              array<String>;
    public let crossRefDetected:    Bool;
    public let sharedContactCount:  Int32;
    public let connectionStrength:  String;       // NONE / PERIPHERAL / LINKED / DIRECT
    public let totalScansTracked:   Int32;

    // Injected relationship (if triggered)
    public let hasInjectedRel:      Bool;
    public let injectedRelName:     String;
    public let injectedRelContext:   String;
}

public abstract class KdspConnectionDetector {

    // ── Main Pipeline ─────────────────────────────────────────────────────
    //  Called after relationships are generated.
    //  Extracts names from the KdspRelationshipsData, runs all checks,
    //  returns a result with alerts and optional injected relationship.

    public static func Detect(
        gi: GameInstance,
        entityHash: Int32,
        npcName: String,
        gang: String,
        district: String,
        archetype: String,
        relations: ref<KdspRelationshipsData>,
        connectionMode: Int32,
        seed: Int32
    ) -> ref<KdspConnectionResult> {

        let result: ref<KdspConnectionResult> = new KdspConnectionResult();
        result.connectionStrength = "NONE";

        if connectionMode == 0 || !IsDefined(relations) {
            return result;
        };

        let usePhantom: Bool = connectionMode == 1 || connectionMode == 3;
        let useTracked: Bool = connectionMode == 2 || connectionMode == 3;

        // Extract all relationship names from the generated data
        let relNames: array<String>;
        let relContexts: array<String>;
        KdspConnectionDetector.ExtractRelationshipNames(relations, relNames, relContexts);

        // ── TRACKED MODE ──────────────────────────────────────────────
        if useTracked {
            let tracker: ref<KdspConnectionTracker> = KdspConnectionTracker.GetInstance(gi);
            if IsDefined(tracker) {

                // 1. Was this NPC mentioned as a contact by someone we already scanned?
                let priorHit: String = tracker.FindInPriorRelationships(npcName);
                if NotEquals(priorHit, "") {
                    let alert: String = GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S0");
                    alert += GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S1") + priorHit;
                    alert += GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S2");
                    ArrayPush(result.alerts, alert);
                    result.crossRefDetected = true;
                };

                // 2. Do any of this NPC's relationships match a previously scanned NPC?
                let shared: array<String> = tracker.FindSharedContacts(relNames);
                if ArraySize(shared) > 0 {
                    let alert: String = GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S3") + IntToString(ArraySize(shared)) + GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S4");
                    let k: Int32 = 0;
                    while k < ArraySize(shared) && k < 3 {
                        alert += GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S5") + shared[k];
                        k += 1;
                    };
                    ArrayPush(result.alerts, alert);
                    result.sharedContactCount = ArraySize(shared);
                };

                // 3. Inject a previously scanned NPC as a new relationship?
                if tracker.ShouldInject(seed + 9000) {
                    let injName: String = tracker.GetInjectableNPC(seed + 9001, district, gang);
                    if NotEquals(injName, "") && !Equals(injName, npcName) {
                        result.injectedRelName = injName;
                        result.injectedRelContext = KdspTextConnections.GetInjectionContext(seed + 9002) + GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S6");
                        result.hasInjectedRel = true;
                    };
                };

                // Register this scan for future cross-referencing
                tracker.RegisterScan(entityHash, npcName, gang, district, archetype, relNames, relContexts);
                result.totalScansTracked = tracker.GetScanCount();
            };
        };

        // ── PHANTOM + TRACKED combined check ──────────────────────────
        if usePhantom && useTracked {
            let tracker: ref<KdspConnectionTracker> = KdspConnectionTracker.GetInstance(gi);
            if IsDefined(tracker) && !result.crossRefDetected {
                let communityMatches: array<String> = tracker.FindSharedContacts(relNames);
                if ArraySize(communityMatches) > 0 {
                    let alert: String = GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S7");
                    let m: Int32 = 0;
                    while m < ArraySize(communityMatches) && m < 2 {
                        alert += GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S5") + communityMatches[m];
                        m += 1;
                    };
                    alert += GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S8") + district;
                    ArrayPush(result.alerts, alert);
                };
            };
        };

        // Set strength
        if result.crossRefDetected {
            result.connectionStrength = "DIRECT";
        } else if result.sharedContactCount > 0 {
            result.connectionStrength = "LINKED";
        } else if ArraySize(result.alerts) > 0 {
            result.connectionStrength = "PERIPHERAL";
        };

        return result;
    }

    // ── Format Full Alert Block ───────────────────────────────────────────

    public static func FormatAlerts(result: ref<KdspConnectionResult>) -> String {
        if ArraySize(result.alerts) == 0 {
            return "";
        };

        let out: String = GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S9");
        let i: Int32 = 0;
        while i < ArraySize(result.alerts) {
            out += result.alerts[i];
            if i < ArraySize(result.alerts) - 1 {
                out += "\n";
            };
            i += 1;
        };
        if result.totalScansTracked > 0 {
            out += GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S10") + IntToString(result.totalScansTracked) + GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S11");
        };
        return out;
    }

    // ── Format One-Line Alert ─────────────────────────────────────────────

    public static func FormatShort(result: ref<KdspConnectionResult>) -> String {
        if Equals(result.connectionStrength, "NONE") { return ""; };
        if result.crossRefDetected {
            return GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S12");
        };
        if result.sharedContactCount > 0 {
            return GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S13") + IntToString(result.sharedContactCount) + GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S4");
        };
        return GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S14");
    }

    // ── Extract all names from KdspRelationshipsData ──────────────────────
    //  Walks family, associates, enemies, professional contacts.

    private static func ExtractRelationshipNames(
        relations: ref<KdspRelationshipsData>,
        out relNames: array<String>,
        out relContexts: array<String>
    ) -> Void {
        let i: Int32;

        // Family
        i = 0;
        while i < ArraySize(relations.familyMembers) {
            ArrayPush(relNames, relations.familyMembers[i].name);
            ArrayPush(relContexts, relations.familyMembers[i].relation);
            i += 1;
        };

        // Associates
        i = 0;
        while i < ArraySize(relations.knownAssociates) {
            if !relations.knownAssociates[i].isAlias {
                ArrayPush(relNames, relations.knownAssociates[i].name);
                ArrayPush(relContexts, relations.knownAssociates[i].relationship);
            };
            i += 1;
        };

        // Enemies
        i = 0;
        while i < ArraySize(relations.knownEnemies) {
            ArrayPush(relNames, relations.knownEnemies[i].name);
            ArrayPush(relContexts, GetLocalizedTextByKey(n"Kdsp-ConnectionDete-S15") + relations.knownEnemies[i].reason);
            i += 1;
        };

        // Professional contacts
        i = 0;
        while i < ArraySize(relations.professionalContacts) {
            ArrayPush(relNames, relations.professionalContacts[i].name);
            ArrayPush(relContexts, relations.professionalContacts[i].type);
            i += 1;
        };
    }

    // ── Injection Contexts (20 entries) ───────────────────────────────────

}
