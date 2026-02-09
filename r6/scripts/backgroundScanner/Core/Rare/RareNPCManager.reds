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

        // Generate based on type - Original types
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
        // v1.6 Expanded types
        else if Equals(rareType, "UNDERCOVER_COP") {
            rareData = RareNPCManager.GenerateUndercoverCop(seed, rareData);
        }
        else if Equals(rareType, "RETIRED_LEGEND") {
            rareData = RareNPCManager.GenerateRetiredLegend(seed, rareData);
        }
        else if Equals(rareType, "CLONE_SUBJECT") {
            rareData = RareNPCManager.GenerateCloneSubject(seed, rareData);
        }
        else if Equals(rareType, "MAXTAC_TARGET") {
            rareData = RareNPCManager.GenerateMaxtacTarget(seed, rareData);
        }
        else if Equals(rareType, "WITNESS_PROTECTION") {
            rareData = RareNPCManager.GenerateWitnessProtection(seed, rareData);
        }
        else if Equals(rareType, "ENGRAM_CANDIDATE") {
            rareData = RareNPCManager.GenerateEngramCandidate(seed, rareData);
        }
        else if Equals(rareType, "CORPO_DEFECTOR") {
            rareData = RareNPCManager.GenerateCorpoDefector(seed, rareData);
        }
        else if Equals(rareType, "GANG_INFILTRATOR") {
            rareData = RareNPCManager.GenerateGangInfiltrator(seed, rareData);
        }
        else if Equals(rareType, "TRAUMA_TEAM_MARKED") {
            rareData = RareNPCManager.GenerateTraumaTeamMarked(seed, rareData);
        }
        else if Equals(rareType, "FIXER_ASSET") {
            rareData = RareNPCManager.GenerateFixerAsset(seed, rareData);
        }
        else if Equals(rareType, "BLACKMAIL_VICTIM") {
            rareData = RareNPCManager.GenerateBlackmailVictim(seed, rareData);
        }
        else if Equals(rareType, "MILITARY_AWOL") {
            rareData = RareNPCManager.GenerateMilitaryAwol(seed, rareData);
        }
        else if Equals(rareType, "EXPERIMENTAL_SUBJECT") {
            rareData = RareNPCManager.GenerateExperimentalSubject(seed, rareData);
        }
        else if Equals(rareType, "DEBT_COLLECTION") {
            rareData = RareNPCManager.GenerateDebtCollection(seed, rareData);
        }
        else if Equals(rareType, "ORGAN_MARKED") {
            rareData = RareNPCManager.GenerateOrganMarked(seed, rareData);
        }
        else if Equals(rareType, "CULT_ESCAPEE") {
            rareData = RareNPCManager.GenerateCultEscapee(seed, rareData);
        }
        else if Equals(rareType, "RELIC_COMPATIBLE") {
            rareData = RareNPCManager.GenerateRelicCompatible(seed, rareData);
        }
        else if Equals(rareType, "DATA_COURIER") {
            rareData = RareNPCManager.GenerateDataCourier(seed, rareData);
        }
        else if Equals(rareType, "DOUBLE_AGENT") {
            rareData = RareNPCManager.GenerateDoubleAgent(seed, rareData);
        }
        else if Equals(rareType, "NOMAD_EXILE") {
            rareData = RareNPCManager.GenerateNomadExile(seed, rareData);
        }

        return rareData;
    }

    private static func DetermineRareType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        
        // Original types (0-9)
        if i == 0 { return "SLEEPER_AGENT"; }
        if i == 1 { return "PRE_CYBERPSYCHO"; }
        if i == 2 { return "LEGACY_CHARACTER"; }
        if i == 3 { return "TIME_ANOMALY"; }
        if i == 4 { return "GHOST"; }
        if i == 5 { return "WITNESS"; }
        if i == 6 { return "HUNTED"; }
        if i == 7 { return "AI_CONTACT"; }
        if i == 8 { return "CORPO_WHISTLEBLOWER"; }
        if i == 9 { return "HIDDEN_NETRUNNER"; }
        
        // v1.6 Expanded types (10-29)
        if i == 10 { return "UNDERCOVER_COP"; }
        if i == 11 { return "RETIRED_LEGEND"; }
        if i == 12 { return "CLONE_SUBJECT"; }
        if i == 13 { return "MAXTAC_TARGET"; }
        if i == 14 { return "WITNESS_PROTECTION"; }
        if i == 15 { return "ENGRAM_CANDIDATE"; }
        if i == 16 { return "CORPO_DEFECTOR"; }
        if i == 17 { return "GANG_INFILTRATOR"; }
        if i == 18 { return "TRAUMA_TEAM_MARKED"; }
        if i == 19 { return "FIXER_ASSET"; }
        if i == 20 { return "BLACKMAIL_VICTIM"; }
        if i == 21 { return "MILITARY_AWOL"; }
        if i == 22 { return "EXPERIMENTAL_SUBJECT"; }
        if i == 23 { return "DEBT_COLLECTION"; }
        if i == 24 { return "ORGAN_MARKED"; }
        if i == 25 { return "CULT_ESCAPEE"; }
        if i == 26 { return "RELIC_COMPATIBLE"; }
        if i == 27 { return "DATA_COURIER"; }
        if i == 28 { return "DOUBLE_AGENT"; }
        return "NOMAD_EXILE";
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

    // ═══════════════════════════════════════════════════════════════════════
    // v1.6 EXPANDED FLAGGED INDIVIDUAL TYPES
    // ═══════════════════════════════════════════════════════════════════════

    private static func GenerateUndercoverCop(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◉ UNDERCOVER OFFICER ◉";
        data.flagColor = "BLUE";
        data.secretAffiliation = "NCPD SPECIAL OPERATIONS";

        let units: array<String>;
        ArrayPush(units, "Gang Intelligence Unit");
        ArrayPush(units, "Narcotics Division");
        ArrayPush(units, "Organized Crime Task Force");
        ArrayPush(units, "Vice Squad");
        ArrayPush(units, "Counter-Terrorism");

        let unit = units[RandRange(seed, 0, ArraySize(units) - 1)];
        let years = IntToString(RandRange(seed + 10, 1, 8));

        data.description = "NCPD CLASSIFIED: Subject is undercover officer assigned to " + unit + ". ";
        data.description += "Deep cover status: " + years + " years. Handler: [REDACTED]. ";
        data.description += "WARNING: Blowing cover could result in officer death and case collapse.";

        data.hiddenInfo = "Badge number: [CLASSIFIED]. Real identity protected by court order. ";
        data.hiddenInfo += "Current target: " + RareNPCManager.GetUndercoverTarget(seed + 20);

        data.scannerWarning = "NCPD PROTECTED ASSET - DO NOT EXPOSE";
        data.dangerLevel = "VARIABLE - DEEP COVER";

        return data;
    }

    private static func GetUndercoverTarget(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Maelstrom leadership"; }
        if i == 1 { return "Tyger Claws operations"; }
        if i == 2 { return "6th Street weapons trafficking"; }
        if i == 3 { return "Valentinos drug network"; }
        if i == 4 { return "Scav harvesting ring"; }
        return "Fixer network mapping";
    }

    private static func GenerateRetiredLegend(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "★ RETIRED LEGEND ★";
        data.flagColor = "GOLD";

        let professions: array<String>;
        let details: array<String>;

        ArrayPush(professions, "Former Solo");
        ArrayPush(details, "Legendary solo with " + IntToString(RandRange(seed, 50, 200)) + "+ confirmed operations. Officially retired but skills remain sharp.");

        ArrayPush(professions, "Ex-Netrunner");
        ArrayPush(details, "Former elite netrunner who survived multiple Blackwall encounters. Now living quietly under assumed identity.");

        ArrayPush(professions, "Retired Fixer");
        ArrayPush(details, "Once controlled half the contracts in " + RareNPCManager.GetDistrict(seed) + ". Knows where all the bodies are buried.");

        ArrayPush(professions, "Former MaxTac");
        ArrayPush(details, "Ex-MaxTac operative with classified kill count. Left under mysterious circumstances. Still receives pension.");

        ArrayPush(professions, "Legendary Merc");
        ArrayPush(details, "Name still whispered in merc circles. Supposedly dead, but records suggest otherwise.");

        let index = RandRange(seed, 0, ArraySize(professions) - 1);
        data.secretAffiliation = professions[index];
        data.description = details[index];

        data.hiddenInfo = "Bounty attempts: " + IntToString(RandRange(seed + 10, 0, 12)) + " (all failed). ";
        data.hiddenInfo += "Known associates still active in the field.";

        data.scannerWarning = "CAUTION: EXTREME THREAT IF PROVOKED";
        data.dangerLevel = "DORMANT - POTENTIALLY EXTREME";

        return data;
    }

    private static func GetDistrict(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Watson"; }
        if i == 1 { return "Westbrook"; }
        if i == 2 { return "Heywood"; }
        if i == 3 { return "Pacifica"; }
        if i == 4 { return "Santo Domingo"; }
        return "City Center";
    }

    private static func GenerateCloneSubject(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "⧫ CLONE DETECTED ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA SUBJECT";

        let generation = RandRange(seed, 2, 7);
        let original = RandRange(seed + 10, 1, 100) <= 30 ? "KNOWN" : "CLASSIFIED";

        data.description = "BIOTECH ALERT: Subject confirmed as Generation " + IntToString(generation) + " clone. ";
        data.description += "Original template: " + original + ". Legal status: COMPLICATED. ";
        data.description += "Memory implantation: " + (RandRange(seed + 20, 1, 100) <= 60 ? "COMPLETE" : "PARTIAL") + ". ";
        data.description += "Subject may or may not be aware of clone status.";

        data.hiddenInfo = "Clone batch: " + IntToString(RandRange(seed + 30, 1, 50)) + ". Siblings active: " + IntToString(RandRange(seed + 40, 0, 5)) + ". ";
        data.hiddenInfo += "Genetic degradation: " + IntToString(RandRange(seed + 50, 0, 30)) + "%. ";
        data.hiddenInfo += "Corporate ownership claim: " + (RandRange(seed + 60, 1, 100) <= 50 ? "ACTIVE" : "DISPUTED");

        data.scannerWarning = "CLONE RIGHTS DISPUTED - LEGAL GREY ZONE";
        data.dangerLevel = "LOW - IDENTITY CRISIS POSSIBLE";

        return data;
    }

    private static func GenerateMaxtacTarget(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "⚠ MAXTAC TARGET ⚠";
        data.flagColor = "RED";
        data.secretAffiliation = "ACTIVE MAXTAC WARRANT";

        let priority = RandRange(seed, 1, 5);
        let reason = RareNPCManager.GetMaxtacReason(seed + 10);

        data.description = "MAXTAC ALERT: Subject is Priority " + IntToString(priority) + " target. ";
        data.description += "Reason: " + reason + ". ";
        data.description += "Capture/neutralize order: " + (priority <= 2 ? "SHOOT ON SIGHT" : "CAPTURE PREFERRED") + ". ";
        data.description += "Civilian casualties authorized: " + (priority <= 2 ? "YES" : "MINIMIZE") + ".";

        data.hiddenInfo = "Previous encounters: " + IntToString(RandRange(seed + 20, 0, 3)) + ". ";
        data.hiddenInfo += "MaxTac officers wounded/killed: " + IntToString(RandRange(seed + 30, 0, 5)) + ". ";
        data.hiddenInfo += "Bounty: €$" + IntToString(RandRange(seed + 40, 100000, 1000000));

        data.scannerWarning = "EXTREME DANGER - MAXTAC INBOUND IF ENGAGED";
        data.dangerLevel = "EXTREME - MAXTAC PRIORITY";

        return data;
    }

    private static func GetMaxtacReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Cyberpsychosis confirmed"; }
        if i == 1 { return "Mass casualty event"; }
        if i == 2 { return "Cop killer"; }
        if i == 3 { return "Terrorist activities"; }
        if i == 4 { return "Escaped MaxTac detention"; }
        return "Military-grade cyberware illegal";
    }

    private static func GenerateWitnessProtection(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◈ WITNESS PROTECTION ◈";
        data.flagColor = "BLUE";
        data.secretAffiliation = "NUSA WITNESS PROGRAM";

        let witnessed = RareNPCManager.GetWitnessedEvent(seed);
        let years = IntToString(RandRange(seed + 10, 1, 15));

        data.description = "CLASSIFIED: Subject in federal witness protection. Original identity sealed. ";
        data.description += "Testified against: " + witnessed + ". ";
        data.description += "Time in program: " + years + " years. ";
        data.description += "ALERT: Multiple assassination attempts on file.";

        data.hiddenInfo = "Original name: [SEALED BY COURT ORDER]. Previous location: [REDACTED]. ";
        data.hiddenInfo += "Handlers: US Marshals Service. Threat level to original identity: EXTREME. ";
        data.hiddenInfo += "Bounty on original identity: €$" + IntToString(RandRange(seed + 20, 500000, 5000000));

        data.scannerWarning = "FEDERAL PROTECTION - DO NOT COMPROMISE";
        data.dangerLevel = "LOW - BUT HIGH VALUE TARGET";

        return data;
    }

    private static func GetWitnessedEvent(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Arasaka war crimes"; }
        if i == 1 { return "Militech black ops"; }
        if i == 2 { return "Gang leadership murder"; }
        if i == 3 { return "Political assassination"; }
        if i == 4 { return "Corporate mass murder"; }
        return "Government corruption";
    }

    private static func GenerateEngramCandidate(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◎ ENGRAM CANDIDATE ◎";
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA SOUL PROJECT";

        let compatibility = IntToString(RandRange(seed, 85, 99));
        let status = RandRange(seed + 10, 1, 100) <= 40 ? "AWARE" : "UNAWARE";

        data.description = "SOULKILLER ALERT: Subject identified as high-compatibility engram candidate. ";
        data.description += "Neural mapping compatibility: " + compatibility + "%. ";
        data.description += "Subject awareness: " + status + ". ";
        data.description += "Corporate interest: EXTREME. Extraction attempts: LIKELY.";

        data.hiddenInfo = "Arasaka bounty for live capture: €$" + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ". ";
        data.hiddenInfo += "Unique neural architecture identified. ";
        data.hiddenInfo += "Potential Relic compatibility: " + (RandRange(seed + 30, 1, 100) <= 30 ? "CONFIRMED" : "SUSPECTED");

        data.scannerWarning = "HIGH VALUE CORPORATE ASSET - EXTRACTION TEAMS POSSIBLE";
        data.dangerLevel = "MODERATE - BUT HIGH INTEREST";

        return data;
    }

    private static func GenerateCorpoDefector(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "▼ CORPORATE DEFECTOR ▼";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, "MILITECH");
        ArrayPush(corps, "KANG TAO");
        ArrayPush(corps, "BIOTECHNICA");
        ArrayPush(corps, "PETROCHEM");
        ArrayPush(corps, "ZETATECH");

        let fromCorp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        let toCorp = corps[RandRange(seed + 10, 0, ArraySize(corps) - 1)];

        data.secretAffiliation = "EX-" + fromCorp;

        data.description = "CORPORATE ALERT: Former " + fromCorp + " employee defected to " + toCorp + ". ";
        data.description += "Classified data stolen: " + (RandRange(seed + 20, 1, 100) <= 70 ? "CONFIRMED" : "SUSPECTED") + ". ";
        data.description += "Kill order from " + fromCorp + ": ACTIVE. ";
        data.description += "Protection from " + toCorp + ": " + (RandRange(seed + 30, 1, 100) <= 50 ? "CONFIRMED" : "RUMORED");

        data.hiddenInfo = "Original position: " + RareNPCManager.GetCorpoPosition(seed + 40) + ". ";
        data.hiddenInfo += "Data value estimate: €$" + IntToString(RandRange(seed + 50, 10000000, 100000000)) + ". ";
        data.hiddenInfo += "Assassination attempts: " + IntToString(RandRange(seed + 60, 1, 8));

        data.scannerWarning = "CORPORATE WAR ASSET - MULTIPLE PARTIES INTERESTED";
        data.dangerLevel = "HIGH - ASSASSINATION LIKELY";

        return data;
    }

    private static func GenerateGangInfiltrator(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◉ GANG INFILTRATOR ◉";
        data.flagColor = "ORANGE";

        let gangs: array<String>;
        ArrayPush(gangs, "MAELSTROM");
        ArrayPush(gangs, "TYGER CLAWS");
        ArrayPush(gangs, "6TH STREET");
        ArrayPush(gangs, "VALENTINOS");
        ArrayPush(gangs, "ANIMALS");
        ArrayPush(gangs, "VOODOO BOYS");

        let infiltrated = gangs[RandRange(seed, 0, ArraySize(gangs) - 1)];
        let employer = RandRange(seed + 10, 1, 100) <= 50 ? "RIVAL GANG" : "CORPORATE";

        data.secretAffiliation = employer + " PLANT IN " + infiltrated;

        data.description = "GANG INTEL: Subject is embedded infiltrator within " + infiltrated + ". ";
        data.description += "Employer: " + employer + ". Time embedded: " + IntToString(RandRange(seed + 20, 1, 5)) + " years. ";
        data.description += "Position achieved: " + RareNPCManager.GetGangPosition(seed + 30) + ". ";
        data.description += "Discovery would result in immediate execution.";

        data.hiddenInfo = "Intelligence gathered on: Leadership, operations, alliances. ";
        data.hiddenInfo += "Handler contact: Every " + IntToString(RandRange(seed + 40, 3, 14)) + " days. ";
        data.hiddenInfo += "Extraction plan: " + (RandRange(seed + 50, 1, 100) <= 50 ? "IN PLACE" : "NONE");

        data.scannerWarning = "DEEP COVER - EXPOSURE FATAL";
        data.dangerLevel = "HIGH - GANG EXECUTION IF EXPOSED";

        return data;
    }

    private static func GetGangPosition(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Lieutenant"; }
        if i == 1 { return "Enforcer"; }
        if i == 2 { return "Drug distributor"; }
        if i == 3 { return "Weapons handler"; }
        return "Trusted soldier";
    }

    private static func GenerateTraumaTeamMarked(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "✚ TRAUMA TEAM FLAGGED ✚";
        data.flagColor = "RED";
        data.secretAffiliation = "TRAUMA TEAM DNR";

        let reason = RareNPCManager.GetTraumaReason(seed);

        data.description = "TRAUMA TEAM ALERT: Subject flagged in TT database. Status: DO NOT RESUSCITATE. ";
        data.description += "Reason: " + reason + ". ";
        data.description += "If flatlined, no Trauma Team response will be dispatched regardless of subscription. ";
        data.description += "This flag is permanent and non-appealable.";

        data.hiddenInfo = "Flag placed by: [CORPORATE AUTHORITY]. ";
        data.hiddenInfo += "Incidents causing flag: " + IntToString(RandRange(seed + 10, 1, 5)) + ". ";
        data.hiddenInfo += "Previous TT personnel injured by subject: " + IntToString(RandRange(seed + 20, 0, 3));

        data.scannerWarning = "NO TRAUMA TEAM RESPONSE - LEFT TO DIE";
        data.dangerLevel = "MODERATE - BUT EXPENDABLE";

        return data;
    }

    private static func GetTraumaReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Attacked TT personnel during rescue"; }
        if i == 1 { return "Outstanding debt to Trauma Team"; }
        if i == 2 { return "Used TT subscription fraudulently"; }
        if i == 3 { return "Killed TT staff"; }
        return "Corporate blacklist request";
    }

    private static func GenerateFixerAsset(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◈ FIXER ASSET ◈";
        data.flagColor = "GREEN";
        data.secretAffiliation = "FIXER NETWORK";

        let role = RareNPCManager.GetFixerRole(seed);
        let fixer = RareNPCManager.GetFixerName(seed + 10);

        data.description = "STREET INTEL: Subject is a protected asset of fixer " + fixer + ". ";
        data.description += "Role: " + role + ". ";
        data.description += "Harming this individual will result in network-wide blacklist. ";
        data.description += "Protection level: SIGNIFICANT.";

        data.hiddenInfo = "Years in network: " + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += "Jobs facilitated: " + IntToString(RandRange(seed + 30, 10, 200)) + ". ";
        data.hiddenInfo += "Street cred: ESTABLISHED";

        data.scannerWarning = "FIXER PROTECTED - NETWORK CONSEQUENCES";
        data.dangerLevel = "LOW - BUT CONNECTED";

        return data;
    }

    private static func GetFixerRole(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Information broker"; }
        if i == 1 { return "Safe house operator"; }
        if i == 2 { return "Weapons supplier"; }
        if i == 3 { return "Medical contact"; }
        if i == 4 { return "Transport specialist"; }
        return "Money launderer";
    }

    private static func GetFixerName(seed: Int32) -> String {
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "Rogue"; }
        if i == 1 { return "Wakako Okada"; }
        if i == 2 { return "Padre"; }
        if i == 3 { return "Regina Jones"; }
        if i == 4 { return "Dino Dinovic"; }
        if i == 5 { return "Dakota Smith"; }
        if i == 6 { return "Mr. Hands"; }
        return "Unknown Fixer";
    }

    private static func GenerateBlackmailVictim(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◆ BLACKMAIL VICTIM ◆";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "COMPROMISED INDIVIDUAL";

        let secret = RareNPCManager.GetBlackmailSecret(seed);
        let blackmailer = RareNPCManager.GetBlackmailerType(seed + 10);

        data.description = "INTEL: Subject is being blackmailed. ";
        data.description += "Compromising material: " + secret + ". ";
        data.description += "Blackmailer: " + blackmailer + ". ";
        data.description += "Subject is controlled and may act against their own interests.";

        data.hiddenInfo = "Duration of blackmail: " + IntToString(RandRange(seed + 20, 1, 10)) + " years. ";
        data.hiddenInfo += "Payments made: €$" + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += "Desperation level: " + (RandRange(seed + 40, 1, 100) <= 50 ? "CRITICAL" : "HIGH");

        data.scannerWarning = "COMPROMISED - MAY BE UNRELIABLE";
        data.dangerLevel = "UNPREDICTABLE";

        return data;
    }

    private static func GetBlackmailSecret(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Corporate espionage evidence"; }
        if i == 1 { return "Past murder covered up"; }
        if i == 2 { return "Hidden family secret"; }
        if i == 3 { return "Financial crimes"; }
        if i == 4 { return "Compromising personal recordings"; }
        return "Hidden identity";
    }

    private static func GetBlackmailerType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Criminal organization"; }
        if i == 1 { return "Corporate rival"; }
        if i == 2 { return "Former associate"; }
        if i == 3 { return "Netrunner"; }
        return "Unknown party";
    }

    private static func GenerateMilitaryAwol(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "▲ MILITARY DESERTER ▲";
        data.flagColor = "RED";

        let branches: array<String>;
        ArrayPush(branches, "NUSA ARMY");
        ArrayPush(branches, "MILITECH PMC");
        ArrayPush(branches, "ARASAKA SECURITY");
        ArrayPush(branches, "LAZARUS GROUP");
        ArrayPush(branches, "KANG TAO FORCES");

        let branch = branches[RandRange(seed, 0, ArraySize(branches) - 1)];
        data.secretAffiliation = "AWOL - " + branch;

        let rank = RareNPCManager.GetMilitaryRank(seed + 10);
        let years = IntToString(RandRange(seed + 20, 1, 10));

        data.description = "MILITARY ALERT: Subject is AWOL from " + branch + ". ";
        data.description += "Former rank: " + rank + ". Deserted: " + years + " years ago. ";
        data.description += "Classified training: " + (RandRange(seed + 30, 1, 100) <= 40 ? "YES" : "STANDARD") + ". ";
        data.description += "Capture order: ACTIVE. Return for court martial.";

        data.hiddenInfo = "Service record: [CLASSIFIED]. Reason for desertion: UNKNOWN. ";
        data.hiddenInfo += "Equipment taken during desertion: " + (RandRange(seed + 40, 1, 100) <= 50 ? "MILITARY GRADE CYBERWARE" : "STANDARD ISSUE") + ". ";
        data.hiddenInfo += "Bounty: €$" + IntToString(RandRange(seed + 50, 50000, 500000));

        data.scannerWarning = "MILITARY TRAINING - COMBAT CAPABLE";
        data.dangerLevel = "HIGH - TRAINED COMBATANT";

        return data;
    }

    private static func GetMilitaryRank(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Private"; }
        if i == 1 { return "Corporal"; }
        if i == 2 { return "Sergeant"; }
        if i == 3 { return "Lieutenant"; }
        if i == 4 { return "Captain"; }
        return "Special Forces Operative";
    }

    private static func GenerateExperimentalSubject(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "⧫ EXPERIMENTAL SUBJECT ⧫";
        data.flagColor = "PURPLE";

        let experiments: array<String>;
        ArrayPush(experiments, "Cyberware enhancement");
        ArrayPush(experiments, "Genetic modification");
        ArrayPush(experiments, "Neural programming");
        ArrayPush(experiments, "Combat drug trials");
        ArrayPush(experiments, "Soulkiller testing");
        ArrayPush(experiments, "AI integration");

        let experiment = experiments[RandRange(seed, 0, ArraySize(experiments) - 1)];
        let corp = RandRange(seed + 10, 1, 100) <= 50 ? "BIOTECHNICA" : "UNKNOWN CORP";
        data.secretAffiliation = corp + " TEST SUBJECT";

        data.description = "BIOTECH ALERT: Subject was part of " + experiment + " experiments. ";
        data.description += "Escaped from facility: " + IntToString(RandRange(seed + 20, 1, 10)) + " years ago. ";
        data.description += "Side effects: UNKNOWN BUT PROBABLE. ";
        data.description += "Corporate recapture priority: " + (RandRange(seed + 30, 1, 100) <= 50 ? "HIGH" : "MODERATE");

        data.hiddenInfo = "Subject number: #" + IntToString(RandRange(seed + 40, 100, 999)) + ". Batch survivors: " + IntToString(RandRange(seed + 50, 1, 5)) + ". ";
        data.hiddenInfo += "Known modifications: " + IntToString(RandRange(seed + 60, 1, 8)) + ". ";
        data.hiddenInfo += "Stable?: " + (RandRange(seed + 70, 1, 100) <= 60 ? "MOSTLY" : "DETERIORATING");

        data.scannerWarning = "EXPERIMENTAL MODIFICATIONS - UNPREDICTABLE";
        data.dangerLevel = "UNKNOWN - POSSIBLY EXTREME";

        return data;
    }

    private static func GenerateDebtCollection(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "€$ DEBT MARKED €$";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "CORPO DEBT COLLECTION";

        let creditor = RareNPCManager.GetCreditor(seed);
        let amount = IntToString(RandRange(seed + 10, 100000, 5000000));

        data.description = "FINANCIAL ALERT: Subject owes €$" + amount + " to " + creditor + ". ";
        data.description += "Collection status: ACTIVE. Payment deadline: PASSED. ";
        data.description += "Collection method authorized: " + (RandRange(seed + 20, 1, 100) <= 40 ? "ANY MEANS" : "AGGRESSIVE") + ". ";
        data.description += "Organ harvest clause: " + (RandRange(seed + 30, 1, 100) <= 30 ? "ACTIVE" : "INACTIVE");

        data.hiddenInfo = "Original debt: €$" + IntToString(RandRange(seed + 40, 10000, 500000)) + " (interest accumulated). ";
        data.hiddenInfo += "Previous collection attempts: " + IntToString(RandRange(seed + 50, 1, 10)) + ". ";
        data.hiddenInfo += "Bounty for live delivery: €$" + IntToString(RandRange(seed + 60, 10000, 100000));

        data.scannerWarning = "DEBT COLLECTORS HUNTING";
        data.dangerLevel = "MODERATE - DESPERATE";

        return data;
    }

    private static func GetCreditor(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Arasaka Financial"; }
        if i == 1 { return "Night City Credit Union"; }
        if i == 2 { return "Tyger Claws loan sharks"; }
        if i == 3 { return "Militech Collections"; }
        if i == 4 { return "Underground lenders"; }
        return "Multiple creditors";
    }

    private static func GenerateOrganMarked(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "✖ ORGAN MARKED ✖";
        data.flagColor = "RED";
        data.secretAffiliation = "SCAV TARGET";

        let organs: array<String>;
        ArrayPush(organs, "rare blood type");
        ArrayPush(organs, "compatible neural tissue");
        ArrayPush(organs, "pristine organs");
        ArrayPush(organs, "unique genetic markers");
        ArrayPush(organs, "high-compatibility tissue");

        let organ = organs[RandRange(seed, 0, ArraySize(organs) - 1)];

        data.description = "SCAV ALERT: Subject has been marked for harvest. Reason: " + organ + ". ";
        data.description += "Bounty placed by: " + (RandRange(seed + 10, 1, 100) <= 50 ? "SCAV NETWORK" : "BLACK MARKET BUYER") + ". ";
        data.description += "Harvest value: €$" + IntToString(RandRange(seed + 20, 50000, 500000)) + ". ";
        data.description += "Subject awareness: " + (RandRange(seed + 30, 1, 100) <= 30 ? "AWARE" : "UNAWARE");

        data.hiddenInfo = "Previous abduction attempts: " + IntToString(RandRange(seed + 40, 0, 3)) + ". ";
        data.hiddenInfo += "Scav teams assigned: " + IntToString(RandRange(seed + 50, 1, 3)) + ". ";
        data.hiddenInfo += "Best opportunity: " + RareNPCManager.GetHarvestOpportunity(seed + 60);

        data.scannerWarning = "SCAV TARGET - ABDUCTION RISK";
        data.dangerLevel = "VICTIM - NOT THREAT";

        return data;
    }

    private static func GetHarvestOpportunity(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Routine commute"; }
        if i == 1 { return "Regular bar visit"; }
        if i == 2 { return "Jogging route"; }
        if i == 3 { return "Isolated residence"; }
        return "Work location";
    }

    private static func GenerateCultEscapee(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◎ CULT ESCAPEE ◎";
        data.flagColor = "ORANGE";

        let cults: array<String>;
        ArrayPush(cults, "Church of the Digital Resurrection");
        ArrayPush(cults, "Children of the Blackwall");
        ArrayPush(cults, "Arasaka Loyalists");
        ArrayPush(cults, "Blood Covenant");
        ArrayPush(cults, "Temple of the Chrome God");
        ArrayPush(cults, "Followers of Alt");

        let cult = cults[RandRange(seed, 0, ArraySize(cults) - 1)];
        data.secretAffiliation = "ESCAPED FROM " + cult;

        data.description = "CULT ALERT: Subject escaped from " + cult + ". ";
        data.description += "Time in cult: " + IntToString(RandRange(seed + 10, 2, 15)) + " years. ";
        data.description += "Position held: " + (RandRange(seed + 20, 1, 100) <= 30 ? "INNER CIRCLE" : "MEMBER") + ". ";
        data.description += "Cult retrieval teams: ACTIVE. Subject knows secrets they want buried.";

        data.hiddenInfo = "Information on cult crimes: EXTENSIVE. ";
        data.hiddenInfo += "Deprogramming status: " + (RandRange(seed + 30, 1, 100) <= 50 ? "PARTIAL" : "COMPLETE") + ". ";
        data.hiddenInfo += "Kill order from cult: " + (RandRange(seed + 40, 1, 100) <= 70 ? "CONFIRMED" : "SUSPECTED");

        data.scannerWarning = "CULT HUNTERS ACTIVE - IN DANGER";
        data.dangerLevel = "LOW THREAT - HIGH VALUE";

        return data;
    }

    private static func GenerateRelicCompatible(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "✦ RELIC COMPATIBLE ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA INTEREST";

        let compatibility = IntToString(RandRange(seed, 90, 99));

        data.description = "ARASAKA PRIORITY: Subject has rare Relic chip compatibility (" + compatibility + "%). ";
        data.description += "Neural architecture: OPTIMAL FOR ENGRAM HOSTING. ";
        data.description += "Subject awareness: " + (RandRange(seed + 10, 1, 100) <= 20 ? "AWARE" : "UNAWARE") + ". ";
        data.description += "Arasaka acquisition interest: EXTREME.";

        data.hiddenInfo = "Similar subjects identified globally: <50. ";
        data.hiddenInfo += "Estimated value to Arasaka: €$" + IntToString(RandRange(seed + 20, 50000000, 200000000)) + ". ";
        data.hiddenInfo += "Saburo Arasaka engram potential host: " + (RandRange(seed + 30, 1, 100) <= 30 ? "POSSIBLE" : "UNLIKELY");

        data.scannerWarning = "EXTREME CORPORATE VALUE - EXTRACTION TEAMS LIKELY";
        data.dangerLevel = "LOW PERSONAL - EXTREME TARGET VALUE";

        return data;
    }

    private static func GenerateDataCourier(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "◈ DATA COURIER ◈";
        data.flagColor = "GREEN";
        data.secretAffiliation = "COURIER NETWORK";

        let dataType = RareNPCManager.GetCourierData(seed);
        let client = RareNPCManager.GetCourierClient(seed + 10);

        data.description = "INTEL: Subject is active data courier. Current payload: " + dataType + ". ";
        data.description += "Client: " + client + ". ";
        data.description += "Delivery method: NEURAL IMPLANT. Data extraction requires: RIPPERDOC. ";
        data.description += "Value of current payload: €$" + IntToString(RandRange(seed + 20, 100000, 10000000));

        data.hiddenInfo = "Active courier for: " + IntToString(RandRange(seed + 30, 1, 10)) + " years. ";
        data.hiddenInfo += "Successful deliveries: " + IntToString(RandRange(seed + 40, 50, 500)) + ". ";
        data.hiddenInfo += "Interception attempts survived: " + IntToString(RandRange(seed + 50, 0, 20));

        data.scannerWarning = "CARRIES VALUABLE DATA - INTERCEPTION TARGET";
        data.dangerLevel = "MODERATE - PROTECTED BY CLIENTS";

        return data;
    }

    private static func GetCourierData(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Corporate secrets"; }
        if i == 1 { return "Government intelligence"; }
        if i == 2 { return "Financial records"; }
        if i == 3 { return "Research data"; }
        if i == 4 { return "Blackmail material"; }
        return "Unknown - encrypted";
    }

    private static func GetCourierClient(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Corporate client"; }
        if i == 1 { return "Fixer network"; }
        if i == 2 { return "Government"; }
        if i == 3 { return "Unknown party"; }
        return "Multiple clients";
    }

    private static func GenerateDoubleAgent(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "✦ DOUBLE AGENT ✦";
        data.flagColor = "RED";

        let org1 = RareNPCManager.GetAgentOrg(seed);
        let org2 = RareNPCManager.GetAgentOrg(seed + 10);
        data.secretAffiliation = "SERVING: " + org1 + " AND " + org2;

        data.description = "INTELLIGENCE ALERT: Subject confirmed as double agent. ";
        data.description += "Claims loyalty to: " + org1 + ". Actually serving: " + org2 + ". ";
        data.description += "Or possibly serving both. True allegiance: UNKNOWN. ";
        data.description += "Information reliability: ZERO.";

        data.hiddenInfo = "Duration of double game: " + IntToString(RandRange(seed + 20, 1, 10)) + " years. ";
        data.hiddenInfo += "Compromised operations: " + IntToString(RandRange(seed + 30, 5, 50)) + ". ";
        data.hiddenInfo += "Deaths attributed to intel leaks: " + IntToString(RandRange(seed + 40, 0, 20));

        data.scannerWarning = "TRUST NOTHING - LOYALTY UNKNOWN";
        data.dangerLevel = "EXTREME - UNPREDICTABLE";

        return data;
    }

    private static func GetAgentOrg(seed: Int32) -> String {
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "ARASAKA"; }
        if i == 1 { return "MILITECH"; }
        if i == 2 { return "NETWATCH"; }
        if i == 3 { return "NUSA GOV"; }
        if i == 4 { return "GANG LEADERSHIP"; }
        if i == 5 { return "FIXER NETWORK"; }
        if i == 6 { return "FOREIGN POWER"; }
        return "UNKNOWN PARTY";
    }

    private static func GenerateNomadExile(seed: Int32, data: ref<RareNPCData>) -> ref<RareNPCData> {
        data.displayFlag = "▼ NOMAD EXILE ▼";
        data.flagColor = "ORANGE";

        let clans: array<String>;
        ArrayPush(clans, "ALDECALDOS");
        ArrayPush(clans, "WRAITHS");
        ArrayPush(clans, "BAKKERS");
        ArrayPush(clans, "SNAKE NATION");
        ArrayPush(clans, "JODES");

        let clan = clans[RandRange(seed, 0, ArraySize(clans) - 1)];
        data.secretAffiliation = "EXILED FROM " + clan;

        let reason = RareNPCManager.GetExileReason(seed + 10);

        data.description = "NOMAD INTEL: Subject exiled from " + clan + " clan. ";
        data.description += "Reason: " + reason + ". ";
        data.description += "Exile type: " + (RandRange(seed + 20, 1, 100) <= 50 ? "PERMANENT - KILL ON SIGHT" : "PERMANENT - NO CONTACT") + ". ";
        data.description += "Subject has intimate knowledge of clan operations, routes, and safe houses.";

        data.hiddenInfo = "Years with clan: " + IntToString(RandRange(seed + 30, 5, 25)) + ". ";
        data.hiddenInfo += "Clan secrets known: EXTENSIVE. ";
        data.hiddenInfo += "Bounty from clan: €$" + IntToString(RandRange(seed + 40, 10000, 100000));

        data.scannerWarning = "NOMAD HUNTERS MAY BE ACTIVE";
        data.dangerLevel = "MODERATE - HUNTED";

        return data;
    }

    private static func GetExileReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Betrayed clan to corpos"; }
        if i == 1 { return "Killed clan member"; }
        if i == 2 { return "Stole from clan"; }
        if i == 3 { return "Violated sacred clan law"; }
        if i == 4 { return "Endangered entire clan"; }
        return "Leadership dispute";
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
