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
                    let alert: String = "⊕ CROSS-REFERENCE: Subject matches contact listed by previously scanned NPC";
                    alert += "\n  Prior scan: " + priorHit;
                    alert += "\n  Confidence: HIGH — exact name match";
                    ArrayPush(result.alerts, alert);
                    result.crossRefDetected = true;
                };

                // 2. Do any of this NPC's relationships match a previously scanned NPC?
                let shared: array<String> = tracker.FindSharedContacts(relNames);
                if ArraySize(shared) > 0 {
                    let alert: String = "⊕ SHARED CONTACTS — " + IntToString(ArraySize(shared)) + " overlap(s) with prior scans";
                    let k: Int32 = 0;
                    while k < ArraySize(shared) && k < 3 {
                        alert += "\n  " + shared[k];
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
                        result.injectedRelContext = KdspConnectionDetector.GetInjectionContext(seed + 9002) + " ⊕ PREVIOUSLY SCANNED";
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
                    let alert: String = "⊕ NETWORK OVERLAP: Subject shares social connections with previously scanned NPC(s)";
                    let m: Int32 = 0;
                    while m < ArraySize(communityMatches) && m < 2 {
                        alert += "\n  " + communityMatches[m];
                        m += 1;
                    };
                    alert += "\n  Analysis: Likely same social circle — " + district;
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

        let out: String = "───── NETWORK ANALYSIS ─────\n";
        let i: Int32 = 0;
        while i < ArraySize(result.alerts) {
            out += result.alerts[i];
            if i < ArraySize(result.alerts) - 1 {
                out += "\n";
            };
            i += 1;
        };
        if result.totalScansTracked > 0 {
            out += "\n  [Scan database: " + IntToString(result.totalScansTracked) + " subjects indexed]";
        };
        return out;
    }

    // ── Format One-Line Alert ─────────────────────────────────────────────

    public static func FormatShort(result: ref<KdspConnectionResult>) -> String {
        if Equals(result.connectionStrength, "NONE") { return ""; };
        if result.crossRefDetected {
            return "⊕ CROSS-REFERENCE: Known to previously scanned subject";
        };
        if result.sharedContactCount > 0 {
            return "⊕ SHARED CONTACTS: " + IntToString(result.sharedContactCount) + " overlap(s) with prior scans";
        };
        return "⊕ NETWORK: Peripheral connection detected";
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
            ArrayPush(relContexts, "Enemy — " + relations.knownEnemies[i].reason);
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

    private static func GetInjectionContext(seed: Int32) -> String {
        let roll: Int32 = RandRange(seed, 0, 20);
        if roll == 0  { return "Seen together recently"; };
        if roll == 1  { return "Shared communication channel"; };
        if roll == 2  { return "Met at same location"; };
        if roll == 3  { return "Financial transaction detected"; };
        if roll == 4  { return "Phone records show contact"; };
        if roll == 5  { return "Listed as emergency contact"; };
        if roll == 6  { return "Tagged in same NCPD report"; };
        if roll == 7  { return "Co-signers on lease"; };
        if roll == 8  { return "Same ripperdoc patient file"; };
        if roll == 9  { return "Gym membership overlap"; };
        if roll == 10 { return "Vehicle registered to same address"; };
        if roll == 11 { return "Flagged in surveillance feed together"; };
        if roll == 12 { return "Same employer — different shifts"; };
        if roll == 13 { return "Mutual fixer connections"; };
        if roll == 14 { return "Both attended same event"; };
        if roll == 15 { return "DNA found at same crime scene"; };
        if roll == 16 { return "Social media connections"; };
        if roll == 17 { return "Shared storage unit"; };
        if roll == 18 { return "Same braindance subscription"; };
        if roll == 19 { return "Biometric proximity data"; };
        return "Connection flagged";
    }
}
