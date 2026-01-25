// Rare NPC Generation System
// Handles special flagged NPCs with unique classifications and backstories
public class RareNPCManager {

    // Check if this NPC should be rare based on settings
    public static func ShouldBeRareNPC(seed: Int32) -> Bool {
        let rarity = KiroshiSettings.GetSpecialNPCRarity();
        
        // 0 = disabled
        if rarity <= 0 {
            return false;
        }
        
        // Roll 1 in [rarity] chance
        return RandRange(seed, 1, rarity) == 1;
    }

    public static func Generate(seed: Int32, archetype: String) -> ref<RareNPCData> {
        let rareData: ref<RareNPCData> = new RareNPCData();

        // Determine rare type
        let rareType = RareNPCManager.DetermineRareType(seed);
        rareData.rareType = rareType;
        rareData.isRare = true;

        // Generate based on type
        if Equals(rareType, "SLEEPER_AGENT") {
            rareData = RareNPCManager.GenerateSleeperAgent(seed, rareData);
        }
        else if Equals(rareType, "PRE_CYBERPSYCHO") {
            rareData = RareNPCManager.GeneratePreCyberpsycho(seed, rareData);
        }
        else if Equals(rareType, "LEGACY_CHARACTER") {
            rareData = RareNPCManager.GenerateLegacyCharacter(seed, rareData);
        }
        else if Equals(rareType, "TIME_ANOMALY") {
            rareData = RareNPCManager.GenerateTimeAnomaly(seed, rareData);
        }
        else if Equals(rareType, "GHOST") {
            rareData = RareNPCManager.GenerateGhost(seed, rareData);
        }
        else if Equals(rareType, "WITNESS") {
            rareData = RareNPCManager.GenerateWitness(seed, rareData);
        }
        else if Equals(rareType, "HUNTED") {
            rareData = RareNPCManager.GenerateHunted(seed, rareData);
        }
        else if Equals(rareType, "AI_CONTACT") {
            rareData = RareNPCManager.GenerateAIContact(seed, rareData);
        }
        else if Equals(rareType, "CORPO_WHISTLEBLOWER") {
            rareData = RareNPCManager.GenerateWhistleblower(seed, rareData);
        }
        else if Equals(rareType, "HIDDEN_NETRUNNER") {
            rareData = RareNPCManager.GenerateHiddenNetrunner(seed, rareData);
        }

        return rareData;
    }

    private static func DetermineRareType(seed: Int32) -> String {
        let types: array<String>;

        ArrayPush(types, "SLEEPER_AGENT");
        ArrayPush(types, "PRE_CYBERPSYCHO");
        ArrayPush(types, "LEGACY_CHARACTER");
        ArrayPush(types, "TIME_ANOMALY");
        ArrayPush(types, "GHOST");
        ArrayPush(types, "WITNESS");
        ArrayPush(types, "HUNTED");
        ArrayPush(types, "AI_CONTACT");
        ArrayPush(types, "CORPO_WHISTLEBLOWER");
        ArrayPush(types, "HIDDEN_NETRUNNER");

        return types[RandRange(seed, 0, ArraySize(types) - 1)];
    }

    private static func GenerateSleeperAgent(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "██ DEEP COVER OPERATIVE ██";
        data.flagColor = "RED";
        
        let agencies: array<String>;
        ArrayPush(agencies, "ARASAKA COVERT OPS");
        ArrayPush(agencies, "MILITECH BLACK DIVISION");
        ArrayPush(agencies, "NETWATCH");
        ArrayPush(agencies, "NUSA INTELLIGENCE");
        ArrayPush(agencies, "UNKNOWN FOREIGN AGENCY");
        ArrayPush(agencies, "CORPORATE COUNTER-INTEL");

        data.secretAffiliation = agencies[RandRange(seed, 0, ArraySize(agencies) - 1)];
        
        data.description = "ALERT: Subject identity is a fabricated cover. True identity classified at highest levels. ";
        data.description += "Activation status: " + (RandRange(seed + 10, 1, 100) <= 30 ? "ACTIVE" : "DORMANT") + ". ";
        data.description += "Handler: [REDACTED]. Mission parameters: [CLASSIFIED]. ";
        data.description += "WARNING: Do not approach. Do not engage. Report sighting immediately.";

        data.hiddenInfo = "Agent has been embedded for " + IntToString(RandRange(seed + 20, 2, 15)) + " years. ";
        data.hiddenInfo += "Cover identity rated: DEEP. Suspected mission: " + RareNPCManager.GetSleeperMission(seed + 30);

        data.scannerWarning = "FILE LOCKED - CLEARANCE INSUFFICIENT";
        data.dangerLevel = "UNKNOWN - ASSUME EXTREME";

        return data;
    }

    private static func GetSleeperMission(seed: Int32) -> String {
        let missions: array<String>;
        ArrayPush(missions, "Corporate infiltration");
        ArrayPush(missions, "Gang intelligence");
        ArrayPush(missions, "Political surveillance");
        ArrayPush(missions, "Technology theft");
        ArrayPush(missions, "Assassination preparation");
        ArrayPush(missions, "Network mapping");
        
        return missions[RandRange(seed, 0, ArraySize(missions) - 1)];
    }

    private static func GeneratePreCyberpsycho(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "⚠ CYBERPSYCHOSIS WARNING ⚠";
        data.flagColor = "ORANGE";

        let stage = RandRange(seed, 1, 5);
        data.secretAffiliation = "NONE - MEDICAL CONCERN";

        data.description = "PSYCHOLOGICAL ALERT: Subject displaying escalating cyberpsychosis indicators. ";
        data.description += "Current stage: " + IntToString(stage) + "/5. ";
        
        let symptoms: array<String>;
        ArrayPush(symptoms, "Increasing paranoid ideation");
        ArrayPush(symptoms, "Violent outbursts reported");
        ArrayPush(symptoms, "Dissociation from humanity");
        ArrayPush(symptoms, "Obsessive cyberware acquisition");
        ArrayPush(symptoms, "Emotional numbing");
        ArrayPush(symptoms, "Delusional episodes");
        
        data.description += "Primary symptoms: " + symptoms[RandRange(seed + 10, 0, ArraySize(symptoms) - 1)] + ", ";
        data.description += symptoms[RandRange(seed + 20, 0, ArraySize(symptoms) - 1)] + ". ";
        
        if stage >= 4 {
            data.description += "CRITICAL: Full break imminent. MaxTac notification pending.";
            data.dangerLevel = "EXTREME - POTENTIAL CYBERPSYCHO";
        } else {
            data.description += "Intervention recommended before escalation.";
            data.dangerLevel = "HIGH - UNSTABLE";
        }

        data.hiddenInfo = "Last therapy session: " + IntToString(RandRange(seed + 30, 6, 36)) + " months ago. ";
        data.hiddenInfo += "Cyberware saturation: " + IntToString(RandRange(seed + 40, 75, 98)) + "%. ";
        data.hiddenInfo += "Previous incidents: " + IntToString(RandRange(seed + 50, 1, 5));

        data.scannerWarning = "APPROACH WITH EXTREME CAUTION - PSYCHOTIC BREAK POSSIBLE";

        return data;
    }

    private static func GenerateLegacyCharacter(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "★ HISTORICAL CONNECTION ★";
        data.flagColor = "GOLD";

        let connections: array<String>;
        let details: array<String>;

        ArrayPush(connections, "SILVERHAND");
        ArrayPush(details, "Genetic analysis indicates possible relation to Johnny Silverhand. Blood relative or clone origin unclear.");
        
        ArrayPush(connections, "ARASAKA");
        ArrayPush(details, "Distant relative of the Arasaka family. Removed from official records after corporate restructuring.");
        
        ArrayPush(connections, "BLACKHAND");
        ArrayPush(details, "Records suggest connection to Morgan Blackhand. Possibly trained by or descended from the legendary solo.");
        
        ArrayPush(connections, "BARTMOSS");
        ArrayPush(details, "Unusual neural patterns match theoretical Bartmoss engram fragments. Origin unknown.");
        
        ArrayPush(connections, "ALT_CUNNINGHAM");
        ArrayPush(details, "Displays anomalous netrunning capabilities. Possible connection to Alt Cunningham's research.");

        let index = RandRange(seed, 0, ArraySize(connections) - 1);
        data.secretAffiliation = connections[index] + " CONNECTION";
        data.description = details[index];
        
        data.hiddenInfo = "This connection is suppressed in public databases. ";
        data.hiddenInfo += "Arasaka flag: " + (RandRange(seed + 10, 1, 100) <= 50 ? "ACTIVE" : "INACTIVE") + ". ";
        data.hiddenInfo += "Subject awareness of connection: " + (RandRange(seed + 20, 1, 100) <= 30 ? "LIKELY" : "UNKNOWN");

        data.scannerWarning = "FLAGGED FOR HISTORICAL SIGNIFICANCE";
        data.dangerLevel = "VARIABLE - MONITOR";

        return data;
    }

    private static func GenerateTimeAnomaly(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◈ TEMPORAL ANOMALY ◈";
        data.flagColor = "PURPLE";

        data.secretAffiliation = "UNKNOWN - DATA CORRUPTION SUSPECTED";

        // Generate impossible dates
        let birthYear = RandRange(seed, 2085, 2120); // Future birth
        let deathYear = RandRange(seed + 10, 2040, 2065); // Past death

        data.description = "CRITICAL DATABASE ERROR: Temporal inconsistencies detected in subject records. ";
        data.description += "Birth date: " + IntToString(birthYear) + " (FUTURE). ";
        data.description += "Death date: " + IntToString(deathYear) + " (PAST). ";
        data.description += "Current status: ALIVE (VERIFIED). ";
        data.description += "Multiple existence confirmations across incompatible timelines. Data integrity: COMPROMISED.";

        let theories: array<String>;
        ArrayPush(theories, "Possible Blackwall data corruption");
        ArrayPush(theories, "Rogue AI manipulation of records");
        ArrayPush(theories, "Experimental technology subject");
        ArrayPush(theories, "Deep fake identity with corrupted source");
        ArrayPush(theories, "Unknown phenomenon");

        data.hiddenInfo = "Investigation status: ONGOING. ";
        data.hiddenInfo += "Theory: " + theories[RandRange(seed + 20, 0, ArraySize(theories) - 1)] + ". ";
        data.hiddenInfo += "NetWatch interest: HIGH. ";
        data.hiddenInfo += "Recommended action: OBSERVE AND REPORT";

        data.scannerWarning = "DATA INTEGRITY FAILURE - TIMELINE INCONSISTENT";
        data.dangerLevel = "UNKNOWN - ANOMALOUS";

        return data;
    }

    private static func GenerateGhost(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "? ENTITY NOT FOUND ?";
        data.flagColor = "GREY";

        data.secretAffiliation = "NO DATA";

        data.description = "ERROR: No records exist for scanned entity. ";
        data.description += "Biometric scan: VALID HUMAN. ";
        data.description += "Database match: NONE. ";
        data.description += "Cross-reference (NCPD, Corporate, Medical, Financial): NO RESULTS. ";
        data.description += "Subject appears to have no digital footprint whatsoever.";

        let possibilities: array<String>;
        ArrayPush(possibilities, "Deep cover operative with scrubbed identity");
        ArrayPush(possibilities, "Survivor of total identity theft");
        ArrayPush(possibilities, "Off-grid birth, never registered");
        ArrayPush(possibilities, "Witness protection (highest level)");
        ArrayPush(possibilities, "Escaped corporate experiment subject");
        ArrayPush(possibilities, "Digital ghost - existence deliberately erased");

        data.hiddenInfo = "Possible explanation: " + possibilities[RandRange(seed + 10, 0, ArraySize(possibilities) - 1)] + ". ";
        data.hiddenInfo += "Facial recognition: 0 matches worldwide. ";
        data.hiddenInfo += "This individual officially does not exist.";

        data.scannerWarning = "NO DATA AVAILABLE - IDENTITY UNKNOWN";
        data.dangerLevel = "UNASSESSABLE";

        return data;
    }

    private static func GenerateWitness(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◉ PROTECTED WITNESS ◉";
        data.flagColor = "BLUE";

        let cases: array<String>;
        ArrayPush(cases, "Arasaka Tower incident (2023)");
        ArrayPush(cases, "Corporate assassination (classified)");
        ArrayPush(cases, "Gang massacre survivor");
        ArrayPush(cases, "Cyberpsycho incident witness");
        ArrayPush(cases, "Corpo black site escapee");
        ArrayPush(cases, "Political assassination witness");

        data.secretAffiliation = "NCPD/CORPORATE WITNESS PROTECTION";

        data.description = "PROTECTED STATUS: Subject is enrolled in witness protection program. ";
        data.description += "Original case: " + cases[RandRange(seed, 0, ArraySize(cases) - 1)] + ". ";
        data.description += "Threat assessment to witness: ONGOING. ";
        data.description += "Current cover identity active since: " + IntToString(RandRange(seed + 10, 2070, 2076)) + ".";

        data.hiddenInfo = "Original identity: [SEALED]. ";
        data.hiddenInfo += "Parties seeking witness: " + IntToString(RandRange(seed + 20, 1, 4)) + " known organizations. ";
        data.hiddenInfo += "Bounty (unofficial): €$" + IntToString(RandRange(seed + 30, 50000, 500000));

        data.scannerWarning = "WITNESS PROTECTION - DO NOT DISCLOSE LOCATION";
        data.dangerLevel = "PROTECTED ASSET - HANDLE CAREFULLY";

        return data;
    }

    private static func GenerateHunted(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "⊗ ACTIVE HUNT TARGET ⊗";
        data.flagColor = "RED";

        let hunters: array<String>;
        ArrayPush(hunters, "Arasaka Black Ops");
        ArrayPush(hunters, "Militech Enforcement");
        ArrayPush(hunters, "Multiple gang contracts");
        ArrayPush(hunters, "Unknown corporate entity");
        ArrayPush(hunters, "International bounty hunters");
        ArrayPush(hunters, "NetWatch termination order");

        data.secretAffiliation = "TARGET";

        data.description = "ALERT: Subject has active termination/capture orders from multiple parties. ";
        data.description += "Primary hunter: " + hunters[RandRange(seed, 0, ArraySize(hunters) - 1)] + ". ";
        data.description += "Total bounty value: €$" + IntToString(RandRange(seed + 10, 100000, 2000000)) + ". ";
        data.description += "Status: ACTIVELY EVADING. Days on run: " + IntToString(RandRange(seed + 20, 30, 500)) + ".";

        let reasons: array<String>;
        ArrayPush(reasons, "Stole proprietary technology");
        ArrayPush(reasons, "Killed high-value target");
        ArrayPush(reasons, "Possesses classified information");
        ArrayPush(reasons, "Betrayed organization");
        ArrayPush(reasons, "Witnessed something they shouldn't");

        data.hiddenInfo = "Reason for hunt: " + reasons[RandRange(seed + 30, 0, ArraySize(reasons) - 1)] + ". ";
        data.hiddenInfo += "Near-miss captures: " + IntToString(RandRange(seed + 40, 2, 8)) + ". ";
        data.hiddenInfo += "Survival assessment: " + (RandRange(seed + 50, 1, 100) <= 30 ? "LOW" : "MODERATE");

        data.scannerWarning = "HIGH-VALUE TARGET - MULTIPLE PARTIES SEEKING";
        data.dangerLevel = "EXTREME - DESPERATE AND DANGEROUS";

        return data;
    }

    private static func GenerateAIContact(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◬ BLACKWALL CONTACT ◬";
        data.flagColor = "CYAN";

        data.secretAffiliation = "UNKNOWN AI ENTITY";

        data.description = "NETWATCH ALERT: Subject has confirmed or suspected contact with rogue AI beyond the Blackwall. ";
        data.description += "Contact type: " + (RandRange(seed, 1, 100) <= 50 ? "WILLING" : "UNKNOWN") + ". ";
        data.description += "Neural contamination: " + (RandRange(seed + 10, 1, 100) <= 40 ? "DETECTED" : "SUSPECTED") + ". ";
        data.description += "Behavioral changes noted since contact initiation.";

        data.hiddenInfo = "AI designation: [UNIDENTIFIED BLACKWALL ENTITY]. ";
        data.hiddenInfo += "Communication method: Direct neural link. ";
        data.hiddenInfo += "NetWatch monitoring status: ACTIVE. ";
        data.hiddenInfo += "Termination recommendation: " + (RandRange(seed + 20, 1, 100) <= 30 ? "APPROVED" : "PENDING REVIEW");

        data.scannerWarning = "AI CONTACT SUSPECTED - NETWATCH FLAGGED";
        data.dangerLevel = "EXTREME - POTENTIAL VECTOR";

        return data;
    }

    private static func GenerateWhistleblower(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◇ CORPORATE LEAK ◇";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "Arasaka");
        ArrayPush(corps, "Militech");
        ArrayPush(corps, "Biotechnica");
        ArrayPush(corps, "Kang Tao");
        ArrayPush(corps, "Zetatech");
        ArrayPush(corps, "Trauma Team");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = "FORMER " + corp + " EMPLOYEE";

        data.description = "CORPORATE ALERT: Subject identified as source of confidential data leak from " + corp + ". ";
        data.description += "Leak severity: " + (RandRange(seed + 10, 1, 100) <= 50 ? "CRITICAL" : "SIGNIFICANT") + ". ";
        data.description += "Data compromised: " + RareNPCManager.GetLeakedData(seed + 20) + ". ";
        data.description += "Corporate response: ACTIVE RETRIEVAL OPERATION.";

        data.hiddenInfo = "Former position: " + RareNPCManager.GetCorpoPosition(seed + 30) + ". ";
        data.hiddenInfo += "Data sold to: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Media outlet" : "Rival corporation") + ". ";
        data.hiddenInfo += "Price received: €$" + IntToString(RandRange(seed + 50, 100000, 5000000));

        data.scannerWarning = "CORPORATE TARGET - EXTRACTION TEAMS DEPLOYED";
        data.dangerLevel = "HIGH - CORPORATE ASSETS INBOUND";

        return data;
    }

    private static func GetLeakedData(seed: Int32) -> String {
        let data: array<String>;
        ArrayPush(data, "Research and development files");
        ArrayPush(data, "Financial records showing illegal activity");
        ArrayPush(data, "Human experimentation documentation");
        ArrayPush(data, "Assassination order records");
        ArrayPush(data, "Blackmail material on executives");
        ArrayPush(data, "Classified weapons projects");
        
        return data[RandRange(seed, 0, ArraySize(data) - 1)];
    }

    private static func GetCorpoPosition(seed: Int32) -> String {
        let positions: array<String>;
        ArrayPush(positions, "Senior Data Analyst");
        ArrayPush(positions, "Security Administrator");
        ArrayPush(positions, "Research Scientist");
        ArrayPush(positions, "Executive Assistant");
        ArrayPush(positions, "Internal Auditor");
        ArrayPush(positions, "Systems Administrator");
        
        return positions[RandRange(seed, 0, ArraySize(positions) - 1)];
    }

    private static func GenerateHiddenNetrunner(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◈ HIDDEN NETRUNNER ◈";
        data.flagColor = "CYAN";

        data.secretAffiliation = "UNDERGROUND NETRUNNER";

        let aliases: array<String>;
        ArrayPush(aliases, "zer0c00l");
        ArrayPush(aliases, "gh0st_in_machine");
        ArrayPush(aliases, "blackICE_queen");
        ArrayPush(aliases, "datakrash");
        ArrayPush(aliases, "neural_nomad");
        ArrayPush(aliases, "cipher_punk");

        let alias = aliases[RandRange(seed, 0, ArraySize(aliases) - 1)];

        data.description = "NETWATCH ALERT: Subject identified as underground netrunner operating under alias '" + alias + "'. ";
        data.description += "Skill assessment: " + (RandRange(seed + 10, 1, 100) <= 30 ? "ELITE" : "ADVANCED") + ". ";
        data.description += "Known operations: Data theft, corporate espionage, infrastructure attacks. ";
        data.description += "Current bounty (NetWatch): €$" + IntToString(RandRange(seed + 20, 50000, 500000)) + ".";

        data.hiddenInfo = "Last known deep dive: " + IntToString(RandRange(seed + 30, 1, 30)) + " days ago. ";
        data.hiddenInfo += "Suspected Blackwall proximity: " + IntToString(RandRange(seed + 40, 1, 100)) + "%. ";
        data.hiddenInfo += "Known associates: Voodoo Boys (suspected). ";
        data.hiddenInfo += "Capture priority: " + (RandRange(seed + 50, 1, 100) <= 40 ? "HIGH" : "MEDIUM");

        data.scannerWarning = "NETWATCH TARGET - APPROACH MAY TRIGGER ICE DEPLOYMENT";
        data.dangerLevel = "HIGH - NETRUNNING CAPABILITIES";

        return data;
    }
}

public class RareNPCData {
    public let isRare: Bool;
    public let rareType: String;
    public let displayFlag: String;
    public let flagColor: String;
    public let description: String;
    public let hiddenInfo: String;
    public let secretAffiliation: String;
    public let scannerWarning: String;
    public let dangerLevel: String;
}
