// Multiple Database Sources System
// Provides different "views" of NPC data based on fictional database sources
public class KdspDatabaseSourceManager {

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

    public static func GenerateDatabaseView(seed: Int32, databaseType: String, expandedData: ref<KdspExpandedNPCData>) -> ref<KdspDatabaseViewData> {
        let view: ref<KdspDatabaseViewData> = new KdspDatabaseViewData();
        view.databaseName = databaseType;

        if Equals(databaseType, "NCPD") {
            view = KdspDatabaseSourceManager.GenerateNCPDView(seed, expandedData, view);
        }
        else if Equals(databaseType, "ARASAKA") {
            view = KdspDatabaseSourceManager.GenerateArasakaView(seed, expandedData, view);
        }
        else if Equals(databaseType, "TRAUMA_TEAM") {
            view = KdspDatabaseSourceManager.GenerateTraumaTeamView(seed, expandedData, view);
        }
        else if Equals(databaseType, "NETWATCH") {
            view = KdspDatabaseSourceManager.GenerateNetwatchView(seed, expandedData, view);
        }
        else if Equals(databaseType, "STREET") {
            view = KdspDatabaseSourceManager.GenerateStreetView(seed, expandedData, view);
        }
        else if Equals(databaseType, "MEDICAL") {
            view = KdspDatabaseSourceManager.GenerateMedicalView(seed, expandedData, view);
        }

        return view;
    }

    private static func GenerateNCPDView(seed: Int32, data: ref<KdspExpandedNPCData>, view: ref<KdspDatabaseViewData>) -> ref<KdspDatabaseViewData> {
        view.headerTitle = "NCPD CRIMINAL DATABASE";
        view.headerSubtitle = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S0");
        view.accentColor = "BLUE";
        view.iconGlyph = "BADGE";

        // Classification
        if data.criminalRecord.hasRecord {
            view.classification = data.criminalRecord.ncpdClassification;
        } else {
            view.classification = "NO CRIMINAL RECORD";
        }

        // Primary sections
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("SUBJECT STATUS", 
            GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S1") + data.criminalRecord.warrantStatus + "\n" +
            GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S2") + data.criminalRecord.status));

        // Arrest history
        if ArraySize(data.criminalRecord.arrests) > 0 {
            let arrestText = "";
            let i = 0;
            while i < ArraySize(data.criminalRecord.arrests) && i < 5 {
                arrestText += "• " + data.criminalRecord.arrests[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("ARREST HISTORY", arrestText));
        }

        // Gang affiliation
        if !Equals(data.criminalRecord.gangAffiliation, "") && !Equals(data.criminalRecord.gangAffiliation, "NONE") {
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("GANG AFFILIATION",
                GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S3") + data.criminalRecord.gangAffiliation + "\n" +
                GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S4") + data.criminalRecord.gangRank + "\n" +
                GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S87") + data.criminalRecord.gangStatus));
        }

        // Threat assessment
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("THREAT ASSESSMENT",
            GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S5") + data.psychProfile.threatDescription + "\n" +
            GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S6") + data.psychProfile.armedLikelihood + "\n" +
            GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S7") + data.psychProfile.approachRecommendation));

        // Known associates (limited)
        if ArraySize(data.relationships.knownAssociates) > 0 {
            let assocText = "";
            let i = 0;
            while i < ArraySize(data.relationships.knownAssociates) && i < 3 {
                let assoc = data.relationships.knownAssociates[i];
                assocText += "• " + assoc.name + " - " + assoc.status + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("KNOWN ASSOCIATES", assocText));
        }

        view.footerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S8");
        view.dataIntegrity = RandRange(seed, 85, 99);

        return view;
    }

    private static func GenerateArasakaView(seed: Int32, data: ref<KdspExpandedNPCData>, view: ref<KdspDatabaseViewData>) -> ref<KdspDatabaseViewData> {
        view.headerTitle = "ARASAKA INTELLIGENCE DOSSIER";
        view.headerSubtitle = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S9");
        view.accentColor = "RED";
        view.iconGlyph = "ARASAKA";

        // Corporate classification
        let corpThreat = KdspDatabaseSourceManager.CalculateCorporateThreat(data);
        view.classification = corpThreat;

        // Subject assessment with redactions
        let assessment = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S10") + data.archetype + "\n";
        assessment += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S11");
        if Equals(data.archetype, "CORPO_MANAGER") || Equals(data.archetype, "CORPO_DRONE") {
            assessment += data.financialProfile.employer + "\n";
        } else {
            assessment += "NONE (Civilian)\n";
        }
        assessment += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S12") + KdspDatabaseSourceManager.GetAssetValue(data) + "\n";
        assessment += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S13") + corpThreat;
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("SUBJECT ASSESSMENT", assessment));

        // Financial intelligence
        let finText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S14") + IntToString(data.financialProfile.estimatedWealth) + "\n";
        finText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S15") + data.financialProfile.creditTier + "\n";
        if data.financialProfile.hasDebt {
            finText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S16") + data.financialProfile.debtStatus + "\n";
            finText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S17");
        } else {
            finText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S18");
        }
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("FINANCIAL INTELLIGENCE", finText));

        // Cyberware assessment
        let cyberText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S19") + IntToString(data.cyberwareRegistry.totalImplants) + "\n";
        cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S20") + (data.cyberwareRegistry.hasIllegalCyberware ? "DETECTED" : "NONE DETECTED") + "\n";
        cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S21") + data.psychProfile.combatTraining + "\n";
        cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S22") + IntToString(data.cyberwareRegistry.cyberpsychosisRisk) + "%";
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("COMBAT ASSESSMENT", cyberText));

        // Redacted section
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("CLASSIFIED OPERATIONS",
            "████████████████████████\n" +
            GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S23") +
            "████████████████████████"));

        // Recommendation
        let recommendation = KdspDatabaseSourceManager.GetArasakaRecommendation(data, corpThreat);
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("RECOMMENDED ACTION", recommendation));

        view.footerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S24");
        view.dataIntegrity = RandRange(seed, 90, 100);

        return view;
    }

    private static func CalculateCorporateThreat(data: ref<KdspExpandedNPCData>) -> String {
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

    private static func GetAssetValue(data: ref<KdspExpandedNPCData>) -> String {
        if Equals(data.archetype, "CORPO_MANAGER") { return "HIGH - POTENTIAL RECRUITMENT"; }
        if Equals(data.archetype, "CORPO_DRONE") { return "MODERATE - POTENTIAL ASSET"; }
        if Equals(data.archetype, "YUPPIE") { return "LOW - CONSUMER VALUE"; }
        if Equals(data.archetype, "GANGER") { return "NEGATIVE - LIABILITY"; }
        return "NEGLIGIBLE";
    }

    private static func GetArasakaRecommendation(data: ref<KdspExpandedNPCData>, threat: String) -> String {
        if Equals(threat, "HIGH THREAT") {
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S25");
        }
        if Equals(threat, "MODERATE THREAT") {
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S26");
        }
        return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S27");
    }

    private static func GenerateTraumaTeamView(seed: Int32, data: ref<KdspExpandedNPCData>, view: ref<KdspDatabaseViewData>) -> ref<KdspDatabaseViewData> {
        view.headerTitle = "TRAUMA TEAM MEDICAL FILE";
        view.headerSubtitle = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S28");
        view.accentColor = "WHITE";
        view.iconGlyph = "MEDICAL";

        // Coverage status
        view.classification = data.financialProfile.traumaTeamCoverage;

        // Medical priority
        let priorityText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S29") + data.financialProfile.traumaTeamCoverage + "\n";
        if StrContains(data.financialProfile.traumaTeamCoverage, "NONE") || StrContains(data.financialProfile.traumaTeamCoverage, "EXPIRED") || StrContains(data.financialProfile.traumaTeamCoverage, "LAPSED") {
            priorityText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S30");
            priorityText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S31");
        } else {
            priorityText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S32") + KdspDatabaseSourceManager.GetResponsePriority(data.financialProfile.traumaTeamCoverage) + "\n";
            priorityText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S33");
        }
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("SERVICE STATUS", priorityText));

        // Medical summary
        let medText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S34") + data.medicalHistory.bloodType + "\n";
        medText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S35") + data.medicalHistory.healthRating + "\n";
        medText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S36") + (ArraySize(data.medicalHistory.allergies) > 0 ? IntToString(ArraySize(data.medicalHistory.allergies)) + " documented" : "None") + "\n";
        medText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S37") + data.medicalHistory.donorStatus;
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("MEDICAL SUMMARY", medText));

        // Cyberware for emergency response
        let cyberText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S19") + IntToString(data.cyberwareRegistry.totalImplants) + "\n";
        cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S38") + data.cyberwareRegistry.warrantyStatus + "\n";
        if ArraySize(data.cyberwareRegistry.rejectedImplants) > 0 {
            cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S39");
        }
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("CYBERWARE STATUS", cyberText));

        // Conditions
        if ArraySize(data.medicalHistory.chronicConditions) > 0 {
            let condText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.chronicConditions) {
                condText += "• " + data.medicalHistory.chronicConditions[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("CHRONIC CONDITIONS", condText));
        }

        // Emergency contact
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("EMERGENCY CONTACT",
            data.relationships.emergencyContact));

        // Response history
        let historyText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S40") + IntToString(data.medicalHistory.emergencyVisits) + "\n";
        historyText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S41") + (data.medicalHistory.emergencyVisits > 0 ? "On file" : "N/A");
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("RESPONSE HISTORY", historyText));

        view.footerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S42");
        view.dataIntegrity = RandRange(seed, 95, 100);

        return view;
    }

    private static func GetResponsePriority(coverage: String) -> String {
        if StrContains(coverage, "PLATINUM") { return "IMMEDIATE (< 3 min)"; }
        if StrContains(coverage, "GOLD") { return "PRIORITY (< 5 min)"; }
        if StrContains(coverage, "SILVER") { return "STANDARD (< 7 min)"; }
        return "NON-CLIENT";
    }

    private static func GenerateNetwatchView(seed: Int32, data: ref<KdspExpandedNPCData>, view: ref<KdspDatabaseViewData>) -> ref<KdspDatabaseViewData> {
        view.headerTitle = "NETWATCH SURVEILLANCE FILE";
        view.headerSubtitle = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S43");
        view.accentColor = "CYAN";
        view.iconGlyph = "EYE";

        // Net activity classification
        let netThreat = KdspDatabaseSourceManager.CalculateNetThreat(seed, data);
        view.classification = netThreat;

        // Digital footprint
        let digitalText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S44") + KdspDatabaseSourceManager.GetNetActivityLevel(seed, data.archetype) + "\n";
        digitalText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S45") + IntToString(RandRange(seed, 1, 8)) + " registered\n";
        digitalText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S46") + KdspDatabaseSourceManager.GetEncryptionLevel(seed, data.archetype) + "\n";
        digitalText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S47") + (RandRange(seed + 10, 1, 100) <= 40 ? "DETECTED" : "NONE DETECTED");
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("DIGITAL FOOTPRINT", digitalText));

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
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("NETRUNNING HARDWARE", cyberText));
        }

        // Blackwall proximity (for rare NPCs this could be elevated)
        let blackwallText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S48") + (RandRange(seed + 20, 1, 1000) == 1 ? "SUSPECTED" : "NONE DETECTED") + "\n";
        blackwallText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S49");
        blackwallText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S50") + (RandRange(seed + 30, 1, 100) <= 20 ? "DETECTED" : "NONE");
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("BLACKWALL STATUS", blackwallText));

        // Flagged searches/activity
        if RandRange(seed + 40, 1, 100) <= 30 {
            let flaggedText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S51");
            let searches: array<String>;
            ArrayPush(searches, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S52"));
            ArrayPush(searches, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S53"));
            ArrayPush(searches, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S54"));
            ArrayPush(searches, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S55"));
            ArrayPush(searches, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S56"));
            flaggedText += searches[RandRange(seed + 50, 0, ArraySize(searches) - 1)];
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("FLAGGED ACTIVITY", flaggedText));
        }

        // Monitoring status
        let monitorText = "Current Status: " + (Equals(netThreat, "HIGH") ? "ACTIVE MONITORING" : "PASSIVE SURVEILLANCE") + "\n";
        monitorText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S57") + IntToString(RandRange(seed + 60, 1, 48)) + GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S58");
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("MONITORING STATUS", monitorText));

        view.footerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S59");
        view.dataIntegrity = RandRange(seed, 80, 98);

        return view;
    }

    private static func CalculateNetThreat(seed: Int32, data: ref<KdspExpandedNPCData>) -> String {
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

    private static func GenerateStreetView(seed: Int32, data: ref<KdspExpandedNPCData>, view: ref<KdspDatabaseViewData>) -> ref<KdspDatabaseViewData> {
        view.headerTitle = "STREET INTELLIGENCE";
        view.headerSubtitle = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S60");
        view.accentColor = "ORANGE";
        view.iconGlyph = "STREET";

        // Street rep
        let rep = KdspDatabaseSourceManager.CalculateStreetRep(data);
        view.classification = rep;

        // Word on the street
        let wordText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S61") + rep + "\n";
        wordText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S62") + (RandRange(seed, 1, 100) <= 30 ? KdspDatabaseSourceManager.GenerateStreetNickname(seed) : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S63")) + "\n";
        wordText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S64") + KdspDatabaseSourceManager.GetReliability(seed, data.archetype);
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("REPUTATION", wordText));

        // Connections
        if !Equals(data.gangProfile.gangAffiliation, "NONE") && !Equals(data.gangProfile.gangAffiliation, "") {
            let gangText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S65") + data.gangProfile.gangName + "\n";
            gangText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S4") + data.gangProfile.memberRank + "\n";
            gangText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S66") + data.gangProfile.loyaltyRating;
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("GANG TIES", gangText));
        }

        // Skills/Uses
        let skillsText = KdspDatabaseSourceManager.GetStreetSkills(seed, data);
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("USEFUL FOR", skillsText));

        // Danger assessment (street perspective)
        let dangerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S67") + data.psychProfile.armedLikelihood + "\n";
        dangerText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S68") + (data.psychProfile.threatLevel >= 50 ? GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S69") : "Probably fine") + "\n";
        dangerText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S70") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S71") : "Seems legit");
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("WORD OF CAUTION", dangerText));

        // Hangouts
        if ArraySize(data.districtProfile.localConnections) > 0 {
            let hangoutText = "";
            let i = 0;
            while i < ArraySize(data.districtProfile.localConnections) && i < 3 {
                hangoutText += "• " + data.districtProfile.localConnections[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("WHERE TO FIND", hangoutText));
        }

        view.footerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S72");
        view.dataIntegrity = RandRange(seed, 60, 85); // Street intel is less reliable

        return view;
    }

    private static func CalculateStreetRep(data: ref<KdspExpandedNPCData>) -> String {
        if Equals(data.archetype, "GANGER") && data.psychProfile.threatLevel >= 60 {
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S73");
        }
        if Equals(data.archetype, "CORPO_MANAGER") {
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S74");
        }
        if Equals(data.archetype, "NOMAD") {
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S75");
        }
        if Equals(data.archetype, "HOMELESS") {
            return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S76");
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
        ArrayPush(options, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S77"));
        ArrayPush(options, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S78"));
        ArrayPush(options, GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S79"));
        return options[RandRange(seed, 0, ArraySize(options) - 1)];
    }

    private static func GetStreetSkills(seed: Int32, data: ref<KdspExpandedNPCData>) -> String {
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

    private static func GenerateMedicalView(seed: Int32, data: ref<KdspExpandedNPCData>, view: ref<KdspDatabaseViewData>) -> ref<KdspDatabaseViewData> {
        view.headerTitle = "MEDICAL RECORDS";
        view.headerSubtitle = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S80");
        view.accentColor = "GREEN";
        view.iconGlyph = "HEALTH";

        view.classification = data.medicalHistory.healthRating;

        // Vitals/basics
        let vitalsText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S81") + IntToString(data.medicalHistory.age) + GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S82") + IntToString(data.medicalHistory.biologicalAge) + ")\n";
        vitalsText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S34") + data.medicalHistory.bloodType + "\n";
        vitalsText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S83") + data.medicalHistory.height + "\n";
        vitalsText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S84") + data.medicalHistory.weight;
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("PATIENT VITALS", vitalsText));

        // Conditions
        if ArraySize(data.medicalHistory.chronicConditions) > 0 {
            let condText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.chronicConditions) {
                condText += "• " + data.medicalHistory.chronicConditions[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("DIAGNOSED CONDITIONS", condText));
        }

        // Medications
        if ArraySize(data.medicalHistory.currentMedications) > 0 {
            let medText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.currentMedications) {
                medText += "• " + data.medicalHistory.currentMedications[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("CURRENT MEDICATIONS", medText));
        }

        // Cyberware summary
        let cyberText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S19") + IntToString(data.cyberwareRegistry.totalImplants) + "\n";
        cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S85") + data.cyberwareRegistry.lastRipperdocVisit + "\n";
        cyberText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S22") + IntToString(data.cyberwareRegistry.cyberpsychosisRisk) + "% - " + data.cyberwareRegistry.cyberpsychosisStatus;
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("CYBERWARE SUMMARY", cyberText));

        // Visit history
        let visitText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S86") + data.medicalHistory.lastCheckup + "\n";
        visitText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S87") + IntToString(data.medicalHistory.ripperdocVisits) + "\n";
        visitText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S88") + IntToString(data.medicalHistory.emergencyVisits) + " visits\n";
        visitText += GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S89") + data.medicalHistory.vaccinationStatus;
        ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("VISIT HISTORY", visitText));

        // Allergies
        if ArraySize(data.medicalHistory.allergies) > 0 {
            let allergyText = "";
            let i = 0;
            while i < ArraySize(data.medicalHistory.allergies) {
                allergyText += "⚠ " + data.medicalHistory.allergies[i] + "\n";
                i += 1;
            }
            ArrayPush(view.sections, KdspDatabaseSourceManager.CreateSection("ALLERGIES - CRITICAL", allergyText));
        }

        view.footerText = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-S90");
        view.dataIntegrity = RandRange(seed, 90, 100);

        return view;
    }

    private static func CreateSection(title: String, content: String) -> ref<KdspDatabaseSection> {
        let section: ref<KdspDatabaseSection> = new KdspDatabaseSection();
        section.title = title;
        section.content = content;
        return section;
    }
}

public class KdspDatabaseViewData {
    public let databaseName: String;
    public let headerTitle: String;
    public let headerSubtitle: String;
    public let accentColor: String;
    public let iconGlyph: String;
    public let classification: String;
    public let sections: array<ref<KdspDatabaseSection>>;
    public let footerText: String;
    public let dataIntegrity: Int32;
}

public class KdspDatabaseSection {
    public let title: String;
    public let content: String;
    public let isRedacted: Bool;
    public let isHighlighted: Bool;
}
