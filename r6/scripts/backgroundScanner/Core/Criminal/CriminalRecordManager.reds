// Criminal Record Generation System
public class CriminalRecordManager {

    public static func Generate(seed: Int32, archetype: String, gangAffil: String) -> ref<CriminalRecordData> {
        let record: ref<CriminalRecordData> = new CriminalRecordData();
        
        // Determine if they have a criminal record based on archetype
        let hasCriminalRecord = CriminalRecordManager.HasCriminalRecord(seed, archetype);
        record.hasRecord = hasCriminalRecord;

        if !hasCriminalRecord {
            record.status = "NO CRIMINAL RECORD";
            record.warrantStatus = "NONE";
            return record;
        }

        // Generate criminal status
        record.status = CriminalRecordManager.GenerateStatus(seed, archetype);
        record.warrantStatus = CriminalRecordManager.GenerateWarrantStatus(seed + 100, archetype);
        
        // Generate arrests
        let arrestCount = CriminalRecordManager.GetArrestCount(seed + 200, archetype);
        let i = 0;
        while i < arrestCount {
            ArrayPush(record.arrests, CriminalRecordManager.GenerateArrest(seed + (i * 77), archetype, gangAffil));
            i += 1;
        }

        // Generate convictions
        let convictionCount = RandRange(seed + 300, 0, arrestCount);
        i = 0;
        while i < convictionCount {
            ArrayPush(record.convictions, CriminalRecordManager.GenerateConviction(seed + (i * 88), archetype));
            i += 1;
        }

        // Gang affiliation details
        if !Equals(gangAffil, "NONE") && !Equals(gangAffil, "") {
            record.gangAffiliation = gangAffil;
            record.gangRank = CriminalRecordManager.GenerateGangRank(seed + 400, archetype);
            record.gangStatus = CriminalRecordManager.GenerateGangStatus(seed + 500);
        }

        // NCPD threat classification
        record.ncpdClassification = CriminalRecordManager.GenerateNCPDClassification(seed + 600, archetype, ArraySize(record.arrests));

        return record;
    }

    private static func HasCriminalRecord(seed: Int32, archetype: String) -> Bool {
        let chance: Int32;
        
        if Equals(archetype, "CORPO_MANAGER") { chance = 5; }
        else if Equals(archetype, "CORPO_DRONE") { chance = 10; }
        else if Equals(archetype, "YUPPIE") { chance = 15; }
        else if Equals(archetype, "CIVVIE") { chance = 30; }
        else if Equals(archetype, "NOMAD") { chance = 45; }
        else if Equals(archetype, "LOWLIFE") { chance = 70; }
        else if Equals(archetype, "GANGER") { chance = 95; }
        else if Equals(archetype, "JUNKIE") { chance = 80; }
        else if Equals(archetype, "HOMELESS") { chance = 50; }
        else { chance = 35; }

        return RandRange(seed, 1, 100) <= chance;
    }

    private static func GenerateStatus(seed: Int32, archetype: String) -> String {
        let statuses: array<String>;
        
        ArrayPush(statuses, "MINOR INFRACTIONS");
        ArrayPush(statuses, "MISDEMEANOR RECORD");
        ArrayPush(statuses, "FELONY RECORD");
        ArrayPush(statuses, "VIOLENT OFFENDER");
        ArrayPush(statuses, "REPEAT OFFENDER");
        ArrayPush(statuses, "CURRENTLY ON PAROLE");
        ArrayPush(statuses, "PROBATIONARY STATUS");
        ArrayPush(statuses, "REFORMED - RECORD SEALED");

        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            return statuses[RandRange(seed, 2, ArraySize(statuses) - 2)];
        }
        return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
    }

    private static func GenerateWarrantStatus(seed: Int32, archetype: String) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if Equals(archetype, "GANGER") {
            if roll <= 30 { return "ACTIVE - VIOLENT CRIME"; }
            if roll <= 50 { return "ACTIVE - PROPERTY CRIME"; }
            if roll <= 70 { return "BENCH WARRANT"; }
            return "NONE";
        }
        
        if roll <= 5 { return "ACTIVE - VIOLENT CRIME"; }
        if roll <= 15 { return "ACTIVE - PROPERTY CRIME"; }
        if roll <= 25 { return "BENCH WARRANT"; }
        if roll <= 30 { return "WARRANT CLEARED (2077)"; }
        return "NONE";
    }

    private static func GetArrestCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return RandRange(seed, 2, 8); }
        if Equals(archetype, "LOWLIFE") { return RandRange(seed, 1, 5); }
        if Equals(archetype, "JUNKIE") { return RandRange(seed, 1, 6); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 3); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 0, 3); }
        return RandRange(seed, 1, 3);
    }

    private static func GenerateArrest(seed: Int32, archetype: String, gangAffil: String) -> String {
        let crimes: array<String>;
        let year = RandRange(seed + 1000, 2060, 2077);

        // Common crimes
        ArrayPush(crimes, "Public intoxication");
        ArrayPush(crimes, "Disorderly conduct");
        ArrayPush(crimes, "Petty theft");
        ArrayPush(crimes, "Trespassing");
        ArrayPush(crimes, "Vandalism");
        ArrayPush(crimes, "Illegal possession of controlled substance");
        ArrayPush(crimes, "Assault");
        ArrayPush(crimes, "Battery");
        ArrayPush(crimes, "Grand theft auto");
        ArrayPush(crimes, "Breaking and entering");
        ArrayPush(crimes, "Illegal weapons possession");
        ArrayPush(crimes, "Aggravated assault");
        ArrayPush(crimes, "Armed robbery");
        ArrayPush(crimes, "Assault with cyberware");
        ArrayPush(crimes, "Illegal cyberware modification");
        ArrayPush(crimes, "Data theft");
        ArrayPush(crimes, "Corporate espionage");
        ArrayPush(crimes, "Vehicular assault");
        ArrayPush(crimes, "Reckless endangerment");
        ArrayPush(crimes, "Resisting arrest");

        // Gang-specific crimes
        if !Equals(gangAffil, "NONE") && !Equals(gangAffil, "") {
            ArrayPush(crimes, "Gang activity");
            ArrayPush(crimes, "Conspiracy to commit murder");
            ArrayPush(crimes, "Racketeering");
            ArrayPush(crimes, "Extortion");
            ArrayPush(crimes, "Drug trafficking");
        }

        // Archetype-weighted selection
        let index: Int32;
        if Equals(archetype, "GANGER") {
            index = RandRange(seed, 8, ArraySize(crimes) - 1);
        } else if Equals(archetype, "JUNKIE") {
            index = RandRange(seed, 0, 7);
        } else if Equals(archetype, "CORPO_DRONE") || Equals(archetype, "CORPO_MANAGER") {
            if RandRange(seed + 50, 1, 100) <= 60 {
                return "Corporate policy violation (" + IntToString(year) + ")";
            }
            index = RandRange(seed, 15, 18);
        } else {
            index = RandRange(seed, 0, ArraySize(crimes) - 1);
        }

        return crimes[index] + " (" + IntToString(year) + ")";
    }

    private static func GenerateConviction(seed: Int32, archetype: String) -> String {
        let sentences: array<String>;
        
        ArrayPush(sentences, "Fine: €$" + IntToString(RandRange(seed, 100, 5000)));
        ArrayPush(sentences, "Community service: " + IntToString(RandRange(seed + 10, 20, 200)) + " hours");
        ArrayPush(sentences, "Probation: " + IntToString(RandRange(seed + 20, 6, 36)) + " months");
        ArrayPush(sentences, "County detention: " + IntToString(RandRange(seed + 30, 1, 12)) + " months");
        ArrayPush(sentences, "State prison: " + IntToString(RandRange(seed + 40, 1, 10)) + " years");
        ArrayPush(sentences, "Corporate labor assignment: " + IntToString(RandRange(seed + 50, 1, 5)) + " years");
        ArrayPush(sentences, "Mandatory rehabilitation program");
        ArrayPush(sentences, "Electronic monitoring: " + IntToString(RandRange(seed + 60, 6, 24)) + " months");
        
        return sentences[RandRange(seed, 0, ArraySize(sentences) - 1)];
    }

    private static func GenerateGangRank(seed: Int32, archetype: String) -> String {
        let ranks: array<String>;
        
        ArrayPush(ranks, "Associate");
        ArrayPush(ranks, "Prospect");
        ArrayPush(ranks, "Soldier");
        ArrayPush(ranks, "Enforcer");
        ArrayPush(ranks, "Lieutenant");
        ArrayPush(ranks, "Captain");
        ArrayPush(ranks, "Underboss");

        // Weight towards lower ranks
        let roll = RandRange(seed, 1, 100);
        if roll <= 30 { return ranks[0]; }
        if roll <= 55 { return ranks[1]; }
        if roll <= 75 { return ranks[2]; }
        if roll <= 88 { return ranks[3]; }
        if roll <= 95 { return ranks[4]; }
        if roll <= 99 { return ranks[5]; }
        return ranks[6];
    }

    private static func GenerateGangStatus(seed: Int32) -> String {
        let statuses: array<String>;
        
        ArrayPush(statuses, "Active member");
        ArrayPush(statuses, "Inactive - still affiliated");
        ArrayPush(statuses, "On probation with gang");
        ArrayPush(statuses, "Recently initiated");
        ArrayPush(statuses, "Blood in - confirmed kills");
        ArrayPush(statuses, "Seeking to leave (HIGH RISK)");
        ArrayPush(statuses, "Informant status - CLASSIFIED");

        return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
    }

    private static func GenerateNCPDClassification(seed: Int32, archetype: String, arrestCount: Int32) -> String {
        let baseScore = arrestCount * 10;
        
        if Equals(archetype, "GANGER") { baseScore += 40; }
        else if Equals(archetype, "LOWLIFE") { baseScore += 20; }
        else if Equals(archetype, "JUNKIE") { baseScore += 15; }
        
        baseScore += RandRange(seed, -10, 20);

        if baseScore >= 80 { return "HIGH PRIORITY TARGET"; }
        if baseScore >= 60 { return "ELEVATED THREAT"; }
        if baseScore >= 40 { return "MODERATE CONCERN"; }
        if baseScore >= 20 { return "LOW PRIORITY"; }
        return "MINIMAL THREAT";
    }
}

public class CriminalRecordData {
    public let hasRecord: Bool;
    public let status: String;
    public let warrantStatus: String;
    public let arrests: array<String>;
    public let convictions: array<String>;
    public let gangAffiliation: String;
    public let gangRank: String;
    public let gangStatus: String;
    public let ncpdClassification: String;
}
