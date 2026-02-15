// Gang Profile Utilities and Data Classes
// Shared functions and structures for all gang profiles

public class KdspGangProfileUtils {

    public static func GetStatus(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 75 { return "ACTIVE"; }
        if roll <= 85 { return "PROBATION"; }
        if roll <= 92 { return "INJURED"; }
        if roll <= 96 { return "SUSPENDED"; }
        return "FLAGGED";
    }

    public static func GetGangName(affiliation: String) -> String {
        if Equals(affiliation, "TYGER_CLAWS") { return "Tyger Claws"; }
        if Equals(affiliation, "MAELSTROM") { return "Maelstrom"; }
        if Equals(affiliation, "VALENTINOS") { return "Valentinos"; }
        if Equals(affiliation, "6TH_STREET") { return "6th Street"; }
        if Equals(affiliation, "ANIMALS") { return "Animals"; }
        if Equals(affiliation, "VOODOO_BOYS") { return "Voodoo Boys"; }
        if Equals(affiliation, "MOXES") { return "The Moxes"; }
        if Equals(affiliation, "SCAVENGERS") { return "Scavengers"; }
        if Equals(affiliation, "WRAITHS") { return "Wraiths"; }
        if Equals(affiliation, "ALDECALDOS") { return "Aldecaldos"; }
        return "Unknown";
    }
}

// Data structure for detailed gang profiles
public class KdspDetailedGangProfile {
    public let gangAffiliation: String;
    public let gangName: String;
    public let headerLabel: String;
    public let rank: String;
    public let rankMeaning: String;
    public let role: String;
    public let territory: String;
    public let yearsActive: Int32;
    public let bodyCount: Int32;
    public let arrestCount: Int32;
    public let loyaltyRating: String;
    public let distinguishingMarks: array<String>;
    public let background: String;
    public let recentActivity: String;
    public let status: String;
    
    // Gang-specific stats
    public let chromePercentage: Int32;      // Maelstrom
    public let fightWins: Int32;             // Animals
    public let fightLosses: Int32;           // Animals
    public let systemsCompromised: Int32;    // VDBs
    public let netDepth: Int32;              // VDBs
    public let organsHarvested: Int32;       // Scavengers
    public let successfulRaids: Int32;       // Wraiths
    public let convoyRuns: Int32;            // Aldecaldos
    public let peopleProtected: Int32;       // Moxes
    public let priorService: String;         // 6th Street
}
