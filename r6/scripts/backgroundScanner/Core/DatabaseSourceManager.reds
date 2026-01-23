// Multiple Database Sources System
// Provides different "views" of NPC data based on fictional database sources
public class DatabaseSourceManager {

    public static func GetAvailableDatabases() -> array<String> {
        let databases: array<String>;
        ArrayPush(databases, "NCPD");
        ArrayPush(databases, "ARASAKA");
        ArrayPush(databases, "TRAUMA_TEAM");
        ArrayPush(databases, "NETWATCH");
        ArrayPush(databases, "STREET");
        ArrayPush(databases, "MEDICAL");
        return databases;
    }

    public static func GenerateDatabaseView(seed: Int32, databaseType: String, expandedData: ref<ExpandedNPCData>) -> ref<DatabaseViewData> {
        let view: ref<DatabaseViewData> = new DatabaseViewData();
        view.databaseName = databaseType;

        if Equals(databaseType, "NCPD") {
            view = DatabaseSourceManager.GenerateNCPDView(seed, expandedData, view);
        }
        else if Equals(databaseType, "ARASAKA") {
            view = DatabaseSourceManager.GenerateArasakaView(seed, expandedData, view);
        }
        else if Equals(databaseType, "TRAUMA_TEAM") {
            view = DatabaseSourceManager.GenerateTraumaTeamView(seed, expandedData, view);
        }
        else if Equals(databaseType, "NETWATCH") {
            view = DatabaseSourceManager.GenerateNetwatchView(seed, expandedData, view);
        }
        else if Equals(databaseType, "STREET") {
            view = DatabaseSourceManager.GenerateStreetView(seed, expandedData, view);
        }
        else if Equals(databaseType, "MEDICAL") {
            view = DatabaseSourceManager.GenerateMedicalView(seed, expandedData, view);
        }

        return view;
    }

    private static func GenerateNCPDView(seed: Int32, data: ref<ExpandedNPCData>, view: ref<DatabaseViewData>) -> ref<DatabaseViewData> {
        view.headerTitle = "NCPD CRIMINAL DATABASE";
        view.headerSubtitle = "Night City Police Department - Records Division";
        view.accentColor = "BLUE";
        view.iconGlyph = "BADGE";

        // Classification
        if data.criminalRecord.hasRecord {
            view.classification = data.criminalRecord.ncpdClassification;
        } else {
            view.classification = "NO CRIMINAL RECORD";
        }

        // Primary sections
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("SUBJECT STATUS", 
            "Warrant Status: " + data.criminalRecord.warrantStatus + "\n" +
            "Criminal Status: " + data.criminalRecord.status));

        // Arrest history
        if ArraySize(data.criminalRecord.arrests) > 0 {
            let arrestText = "";
            let i = 0;
            while i < ArraySize(data.criminalRecord.arrests) && i < 5 {
                arrestText += "• " + data.criminalRecord.arrests[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("ARREST HISTORY", arrestText));
        }

        // Gang affiliation
        if !Equals(data.criminalRecord.gangAffiliation, "") && !Equals(data.criminalRecord.gangAffiliation, "NONE") {
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("GANG AFFILIATION",
                "Organization: " + data.criminalRecord.gangAffiliation + "\n" +
                "Rank: " + data.criminalRecord.gangRank + "\n" +
                "Status: " + data.criminalRecord.gangStatus));
        }

        // Threat assessment
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("THREAT ASSESSMENT",
            "Level: " + data.psychProfile.threatDescription + "\n" +
            "Armed Likelihood: " + data.psychProfile.armedLikelihood + "\n" +
            "Approach: " + data.psychProfile.approachRecommendation));

        // Known associates (limited)
        if ArraySize(data.relationships.knownAssociates) > 0 {
            let assocText = "";
            let i = 0;
            while i < ArraySize(data.relationships.knownAssociates) && i < 3 {
                let assoc = data.relationships.knownAssociates[i];
                assocText += "• " + assoc.name + " - " + assoc.status + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("KNOWN ASSOCIATES", assocText));
        }

        view.footerText = "NCPD Database - Access Level: PATROL";
        view.dataIntegrity = RandRange(seed, 85, 99);

        return view;
    }

    private static func GenerateArasakaView(seed: Int32, data: ref<ExpandedNPCData>, view: ref<DatabaseViewData>) -> ref<DatabaseViewData> {
        view.headerTitle = "ARASAKA INTELLIGENCE DOSSIER";
        view.headerSubtitle = "Corporate Security Division - Threat Assessment";
        view.accentColor = "RED";
        view.iconGlyph = "ARASAKA";

        // Corporate classification
        let corpThreat = DatabaseSourceManager.CalculateCorporateThreat(data);
        view.classification = corpThreat;

        // Subject assessment with redactions
        let assessment = "Subject Profile: " + data.archetype + "\n";
        assessment += "Corporate Affiliation: ";
        if Equals(data.archetype, "CORPO_MANAGER") || Equals(data.archetype, "CORPO_DRONE") {
            assessment += data.financialProfile.employer + "\n";
        } else {
            assessment += "NONE (Civilian)\n";
        }
        assessment += "Asset Value: " + DatabaseSourceManager.GetAssetValue(data) + "\n";
        assessment += "Threat to Arasaka Interests: " + corpThreat;
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("SUBJECT ASSESSMENT", assessment));

        // Financial intelligence
        let finText = "Estimated Net Worth: €$" + IntToString(data.financialProfile.estimatedWealth) + "\n";
        finText += "Credit Rating: " + data.financialProfile.creditTier + "\n";
        if data.financialProfile.hasDebt {
            finText += "Debt Status: " + data.financialProfile.debtStatus + "\n";
            finText += "Leverage Potential: HIGH";
        } else {
            finText += "Leverage Potential: LOW";
        }
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("FINANCIAL INTELLIGENCE", finText));

        // Cyberware assessment
        let cyberText = "Total Implants: " + IntToString(data.cyberwareRegistry.totalImplants) + "\n";
        cyberText += "Illegal Modifications: " + (data.cyberwareRegistry.hasIllegalCyberware ? "DETECTED" : "NONE DETECTED") + "\n";
        cyberText += "Combat Capability: " + data.psychProfile.combatTraining + "\n";
        cyberText += "Cyberpsychosis Risk: " + IntToString(data.cyberwareRegistry.cyberpsychosisRisk) + "%";
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("COMBAT ASSESSMENT", cyberText));

        // Redacted section
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("CLASSIFIED OPERATIONS",
            "████████████████████████\n" +
            "██████ CLEARANCE REQUIRED ██████\n" +
            "████████████████████████"));

        // Recommendation
        let recommendation = DatabaseSourceManager.GetArasakaRecommendation(data, corpThreat);
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("RECOMMENDED ACTION", recommendation));

        view.footerText = "ARASAKA EYES ONLY - Unauthorized access will be prosecuted";
        view.dataIntegrity = RandRange(seed, 90, 100);

        return view;
    }

    private static func CalculateCorporateThreat(data: ref<ExpandedNPCData>) -> String {
        let score = 0;
        
        if data.criminalRecord.hasRecord { score += 20; }
        if data.psychProfile.threatLevel >= 60 { score += 30; }
        if !Equals(data.criminalRecord.gangAffiliation, "NONE") { score += 25; }
        if data.cyberwareRegistry.hasIllegalCyberware { score += 15; }
        if data.psychProfile.hasVendetta { score += 20; }

        if score >= 70 { return "HIGH THREAT"; }
        if score >= 40 { return "MODERATE THREAT"; }
        if score >= 20 { return "LOW THREAT"; }
        return "MINIMAL";
    }

    private static func GetAssetValue(data: ref<ExpandedNPCData>) -> String {
        if Equals(data.archetype, "CORPO_MANAGER") { return "HIGH - POTENTIAL RECRUITMENT"; }
        if Equals(data.archetype, "CORPO_DRONE") { return "MODERATE - POTENTIAL ASSET"; }
        if Equals(data.archetype, "YUPPIE") { return "LOW - CONSUMER VALUE"; }
        if Equals(data.archetype, "GANGER") { return "NEGATIVE - LIABILITY"; }
        return "NEGLIGIBLE";
    }

    private static func GetArasakaRecommendation(data: ref<ExpandedNPCData>, threat: String) -> String {
        if Equals(threat, "HIGH THREAT") {
            return "MONITOR CLOSELY. Consider preemptive neutralization if threat escalates. Flag for Counter-Intel review.";
        }
        if Equals(threat, "MODERATE THREAT") {
            return "Standard monitoring protocols. Update file quarterly. No immediate action required.";
        }
        return "Low priority. Maintain passive surveillance. No resources allocated.";
    }

    private static func GenerateTraumaTeamView(seed: Int32, data: ref<ExpandedNPCData>, view: ref<DatabaseViewData>) -> ref<DatabaseViewData> {
        view.headerTitle = "TRAUMA TEAM MEDICAL FILE";
        view.headerSubtitle = "Emergency Response Database";
        view.accentColor = "WHITE";
        view.iconGlyph = "MEDICAL";

        // Coverage status
        view.classification = data.financialProfile.traumaTeamCoverage;

        // Medical priority
        let priorityText = "Coverage Tier: " + data.financialProfile.traumaTeamCoverage + "\n";
        if Equals(data.financialProfile.traumaTeamCoverage, "NONE") {
            priorityText += "Response Priority: NON-CLIENT\n";
            priorityText += "Payment Status: CASH ON DELIVERY";
        } else {
            priorityText += "Response Priority: " + DatabaseSourceManager.GetResponsePriority(data.financialProfile.traumaTeamCoverage) + "\n";
            priorityText += "Account Status: ACTIVE";
        }
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("SERVICE STATUS", priorityText));

        // Medical summary
        let medText = "Blood Type: " + data.medicalHistory.bloodType + "\n";
        medText += "Health Rating: " + data.medicalHistory.healthRating + "\n";
        medText += "Known Allergies: " + (ArraySize(data.medicalHistory.allergies) > 0 ? IntToString(ArraySize(data.medicalHistory.allergies)) + " documented" : "None") + "\n";
        medText += "Donor Status: " + data.medicalHistory.donorStatus;
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("MEDICAL SUMMARY", medText));

        // Cyberware for emergency response
        let cyberText = "Total Implants: " + IntToString(data.cyberwareRegistry.totalImplants) + "\n";
        cyberText += "Cyberware Compatibility: " + data.cyberwareRegistry.warrantyStatus + "\n";
        if ArraySize(data.cyberwareRegistry.rejectedImplants) > 0 {
            cyberText += "ALERT: Previous implant rejections documented";
        }
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("CYBERWARE STATUS", cyberText));

        // Conditions
        if ArraySize(data.medicalHistory.chronicConditions) > 0 {
            let condText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.chronicConditions) {
                condText += "• " + data.medicalHistory.chronicConditions[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("CHRONIC CONDITIONS", condText));
        }

        // Emergency contact
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("EMERGENCY CONTACT",
            data.relationships.emergencyContact));

        // Response history
        let historyText = "Emergency Responses: " + IntToString(data.medicalHistory.emergencyVisits) + "\n";
        historyText += "Last Response: " + (data.medicalHistory.emergencyVisits > 0 ? "On file" : "N/A");
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("RESPONSE HISTORY", historyText));

        view.footerText = "TRAUMA TEAM INTERNATIONAL - Saving Lives Since 2020";
        view.dataIntegrity = RandRange(seed, 95, 100);

        return view;
    }

    private static func GetResponsePriority(coverage: String) -> String {
        if StrContains(coverage, "PLATINUM") { return "IMMEDIATE (< 3 min)"; }
        if StrContains(coverage, "GOLD") { return "PRIORITY (< 5 min)"; }
        if StrContains(coverage, "SILVER") { return "STANDARD (< 10 min)"; }
        if StrContains(coverage, "BRONZE") { return "BASIC (< 15 min)"; }
        return "NON-CLIENT";
    }

    private static func GenerateNetwatchView(seed: Int32, data: ref<ExpandedNPCData>, view: ref<DatabaseViewData>) -> ref<DatabaseViewData> {
        view.headerTitle = "NETWATCH SURVEILLANCE FILE";
        view.headerSubtitle = "Network Security Agency - Subject Monitoring";
        view.accentColor = "CYAN";
        view.iconGlyph = "EYE";

        // Net activity classification
        let netThreat = DatabaseSourceManager.CalculateNetThreat(seed, data);
        view.classification = netThreat;

        // Digital footprint
        let digitalText = "Net Activity Level: " + DatabaseSourceManager.GetNetActivityLevel(seed, data.archetype) + "\n";
        digitalText += "Device Count: " + IntToString(RandRange(seed, 1, 8)) + " registered\n";
        digitalText += "Encryption Usage: " + DatabaseSourceManager.GetEncryptionLevel(seed, data.archetype) + "\n";
        digitalText += "VPN/Proxy Usage: " + (RandRange(seed + 10, 1, 100) <= 40 ? "DETECTED" : "NONE DETECTED");
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("DIGITAL FOOTPRINT", digitalText));

        // Cyberware with netrunning capability
        let hasNetrunnerGear = false;
        let cyberText = "";
        let i = 0;
        while i < ArraySize(data.cyberwareRegistry.implants) {
            let implant = data.cyberwareRegistry.implants[i];
            if StrContains(implant.slot, "Operating System") || StrContains(implant.name, "Net") || 
               StrContains(implant.name, "Cyberdeck") || StrContains(implant.name, "RAM") {
                cyberText += "• " + implant.name + " (" + implant.manufacturer + ")\n";
                hasNetrunnerGear = true;
            }
            i += 1;
        }
        if hasNetrunnerGear {
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("NETRUNNING HARDWARE", cyberText));
        }

        // Blackwall proximity (for rare NPCs this could be elevated)
        let blackwallText = "Blackwall Contact: " + (RandRange(seed + 20, 1, 1000) == 1 ? "SUSPECTED" : "NONE DETECTED") + "\n";
        blackwallText += "Rogue AI Interaction: NO FLAGS\n";
        blackwallText += "Data Haven Activity: " + (RandRange(seed + 30, 1, 100) <= 20 ? "DETECTED" : "NONE");
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("BLACKWALL STATUS", blackwallText));

        // Flagged searches/activity
        if RandRange(seed + 40, 1, 100) <= 30 {
            let flaggedText = "FLAGGED SEARCHES DETECTED:\n";
            let searches: array<String>;
            ArrayPush(searches, "• Corporate security vulnerabilities");
            ArrayPush(searches, "• Illegal braindance sources");
            ArrayPush(searches, "• Netrunner forums");
            ArrayPush(searches, "• Weapon modifications");
            ArrayPush(searches, "• Identity services");
            flaggedText += searches[RandRange(seed + 50, 0, ArraySize(searches) - 1)];
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("FLAGGED ACTIVITY", flaggedText));
        }

        // Monitoring status
        let monitorText = "Current Status: " + (Equals(netThreat, "HIGH") ? "ACTIVE MONITORING" : "PASSIVE SURVEILLANCE") + "\n";
        monitorText += "Last Activity: " + IntToString(RandRange(seed + 60, 1, 48)) + " hours ago";
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("MONITORING STATUS", monitorText));

        view.footerText = "NETWATCH - Protecting the Net Since 2045";
        view.dataIntegrity = RandRange(seed, 80, 98);

        return view;
    }

    private static func CalculateNetThreat(seed: Int32, data: ref<ExpandedNPCData>) -> String {
        let score = RandRange(seed, 0, 30);
        
        if Equals(data.archetype, "GANGER") { score += 20; }
        if data.criminalRecord.hasRecord { score += 15; }
        if data.cyberwareRegistry.hasIllegalCyberware { score += 25; }

        if score >= 60 { return "HIGH"; }
        if score >= 30 { return "MODERATE"; }
        return "LOW";
    }

    private static func GetNetActivityLevel(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            return "HIGH (Work-related)";
        }
        if Equals(archetype, "HOMELESS") {
            return "MINIMAL";
        }
        let levels: array<String>;
        ArrayPush(levels, "LOW");
        ArrayPush(levels, "MODERATE");
        ArrayPush(levels, "HIGH");
        return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
    }

    private static func GetEncryptionLevel(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "MILITARY-GRADE"; }
        if Equals(archetype, "CORPO_DRONE") { return "CORPORATE STANDARD"; }
        if Equals(archetype, "YUPPIE") { return "CONSUMER PREMIUM"; }
        if Equals(archetype, "GANGER") { return RandRange(seed, 1, 100) <= 50 ? "CUSTOM" : "BASIC"; }
        return "BASIC/NONE";
    }

    private static func GenerateStreetView(seed: Int32, data: ref<ExpandedNPCData>, view: ref<DatabaseViewData>) -> ref<DatabaseViewData> {
        view.headerTitle = "STREET INTELLIGENCE";
        view.headerSubtitle = "Fixer Network - Word on the Street";
        view.accentColor = "ORANGE";
        view.iconGlyph = "STREET";

        // Street rep
        let rep = DatabaseSourceManager.CalculateStreetRep(data);
        view.classification = rep;

        // Word on the street
        let wordText = "Street Rep: " + rep + "\n";
        wordText += "Known As: " + (RandRange(seed, 1, 100) <= 30 ? DatabaseSourceManager.GenerateStreetNickname(seed) : "No alias known") + "\n";
        wordText += "Reliability: " + DatabaseSourceManager.GetReliability(seed, data.archetype);
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("REPUTATION", wordText));

        // Connections
        if !Equals(data.gangProfile.gangAffiliation, "NONE") && !Equals(data.gangProfile.gangAffiliation, "") {
            let gangText = "Gang: " + data.gangProfile.gangName + "\n";
            gangText += "Rank: " + data.gangProfile.memberRank + "\n";
            gangText += "Loyalty: " + data.gangProfile.loyaltyRating;
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("GANG TIES", gangText));
        }

        // Skills/Uses
        let skillsText = DatabaseSourceManager.GetStreetSkills(seed, data);
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("USEFUL FOR", skillsText));

        // Danger assessment (street perspective)
        let dangerText = "Armed: " + data.psychProfile.armedLikelihood + "\n";
        dangerText += "Violent: " + (data.psychProfile.threatLevel >= 50 ? "Yeah, watch yourself" : "Probably fine") + "\n";
        dangerText += "Trustworthy: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Wouldn't turn my back" : "Seems legit");
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("WORD OF CAUTION", dangerText));

        // Hangouts
        if ArraySize(data.districtProfile.localConnections) > 0 {
            let hangoutText = "";
            let i = 0;
            while i < ArraySize(data.districtProfile.localConnections) && i < 3 {
                hangoutText += "• " + data.districtProfile.localConnections[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("WHERE TO FIND", hangoutText));
        }

        view.footerText = "Info courtesy of the Fixer Network - You didn't hear it from me";
        view.dataIntegrity = RandRange(seed, 60, 85); // Street intel is less reliable

        return view;
    }

    private static func CalculateStreetRep(data: ref<ExpandedNPCData>) -> String {
        if Equals(data.archetype, "GANGER") && data.psychProfile.threatLevel >= 60 {
            return "DANGEROUS - Don't cross them";
        }
        if Equals(data.archetype, "CORPO_MANAGER") {
            return "SUIT - Got money but no street cred";
        }
        if Equals(data.archetype, "NOMAD") {
            return "OUTSIDER - Badlands crew";
        }
        if Equals(data.archetype, "HOMELESS") {
            return "GHOST - Off the grid";
        }
        if !Equals(data.gangProfile.gangAffiliation, "NONE") {
            return "CONNECTED - " + data.gangProfile.gangName;
        }
        return "NOBODY SPECIAL";
    }

    private static func GenerateStreetNickname(seed: Int32) -> String {
        let nicknames: array<String>;
        ArrayPush(nicknames, "\"Whisper\"");
        ArrayPush(nicknames, "\"Two-Time\"");
        ArrayPush(nicknames, "\"Chrome\"");
        ArrayPush(nicknames, "\"Lucky\"");
        ArrayPush(nicknames, "\"Ghost\"");
        ArrayPush(nicknames, "\"Switchblade\"");
        ArrayPush(nicknames, "\"Neon\"");
        ArrayPush(nicknames, "\"Stitches\"");
        
        return nicknames[RandRange(seed, 0, ArraySize(nicknames) - 1)];
    }

    private static func GetReliability(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "JUNKIE") { return "UNRELIABLE - Desperate"; }
        if Equals(archetype, "GANGER") { return "DEPENDS - Loyal to their own"; }
        if Equals(archetype, "CORPO_MANAGER") { return "UNTRUSTWORTHY - Corp interests first"; }
        if Equals(archetype, "NOMAD") { return "SOLID - Family first, but honest"; }
        
        let options: array<String>;
        ArrayPush(options, "UNKNOWN - Haven't tested");
        ArrayPush(options, "DECENT - Keeps their word mostly");
        ArrayPush(options, "SKETCHY - Watch your eddies");
        return options[RandRange(seed, 0, ArraySize(options) - 1)];
    }

    private static func GetStreetSkills(seed: Int32, data: ref<ExpandedNPCData>) -> String {
        let skills: array<String>;
        
        if !Equals(data.gangProfile.gangAffiliation, "NONE") {
            ArrayPush(skills, "Gang connections");
        }
        if Equals(data.archetype, "CORPO_DRONE") || Equals(data.archetype, "CORPO_MANAGER") {
            ArrayPush(skills, "Corporate intel");
        }
        if data.cyberwareRegistry.totalImplants >= 5 {
            ArrayPush(skills, "Chrome hookup");
        }
        ArrayPush(skills, "Local knowledge");
        
        let result = "";
        let i = 0;
        while i < ArraySize(skills) && i < 3 {
            result += "• " + skills[i] + "\n";
            i += 1;
        }
        return result;
    }

    private static func GenerateMedicalView(seed: Int32, data: ref<ExpandedNPCData>, view: ref<DatabaseViewData>) -> ref<DatabaseViewData> {
        view.headerTitle = "MEDICAL RECORDS";
        view.headerSubtitle = "Night City Health Database";
        view.accentColor = "GREEN";
        view.iconGlyph = "HEALTH";

        view.classification = data.medicalHistory.healthRating;

        // Vitals/basics
        let vitalsText = "Age: " + IntToString(data.medicalHistory.age) + " (Bio: " + IntToString(data.medicalHistory.biologicalAge) + ")\n";
        vitalsText += "Blood Type: " + data.medicalHistory.bloodType + "\n";
        vitalsText += "Height: " + data.medicalHistory.height + "\n";
        vitalsText += "Weight: " + data.medicalHistory.weight;
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("PATIENT VITALS", vitalsText));

        // Conditions
        if ArraySize(data.medicalHistory.chronicConditions) > 0 {
            let condText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.chronicConditions) {
                condText += "• " + data.medicalHistory.chronicConditions[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("DIAGNOSED CONDITIONS", condText));
        }

        // Medications
        if ArraySize(data.medicalHistory.currentMedications) > 0 {
            let medText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.currentMedications) {
                medText += "• " + data.medicalHistory.currentMedications[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("CURRENT MEDICATIONS", medText));
        }

        // Cyberware summary
        let cyberText = "Total Implants: " + IntToString(data.cyberwareRegistry.totalImplants) + "\n";
        cyberText += "Last Maintenance: " + data.cyberwareRegistry.lastRipperdocVisit + "\n";
        cyberText += "Cyberpsychosis Risk: " + IntToString(data.cyberwareRegistry.cyberpsychosisRisk) + "% - " + data.cyberwareRegistry.cyberpsychosisStatus;
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("CYBERWARE SUMMARY", cyberText));

        // Visit history
        let visitText = "Last Checkup: " + data.medicalHistory.lastCheckup + "\n";
        visitText += "Ripperdoc Visits: " + IntToString(data.medicalHistory.ripperdocVisits) + "\n";
        visitText += "Emergency Room: " + IntToString(data.medicalHistory.emergencyVisits) + " visits\n";
        visitText += "Vaccination Status: " + data.medicalHistory.vaccinationStatus;
        ArrayPush(view.sections, DatabaseSourceManager.CreateSection("VISIT HISTORY", visitText));

        // Allergies
        if ArraySize(data.medicalHistory.allergies) > 0 {
            let allergyText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.allergies) {
                allergyText += "⚠ " + data.medicalHistory.allergies[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, DatabaseSourceManager.CreateSection("ALLERGIES - CRITICAL", allergyText));
        }

        view.footerText = "Night City Medical Database - HIPAA Compliant";
        view.dataIntegrity = RandRange(seed, 90, 100);

        return view;
    }

    private static func CreateSection(title: String, content: String) -> ref<DatabaseSection> {
        let section: ref<DatabaseSection> = new DatabaseSection();
        section.title = title;
        section.content = content;
        return section;
    }
}

public class DatabaseViewData {
    public let databaseName: String;
    public let headerTitle: String;
    public let headerSubtitle: String;
    public let accentColor: String;
    public let iconGlyph: String;
    public let classification: String;
    public let sections: array<ref<DatabaseSection>>;
    public let footerText: String;
    public let dataIntegrity: Int32;
}

public class DatabaseSection {
    public let title: String;
    public let content: String;
    public let isRedacted: Bool;
    public let isHighlighted: Bool;
}
