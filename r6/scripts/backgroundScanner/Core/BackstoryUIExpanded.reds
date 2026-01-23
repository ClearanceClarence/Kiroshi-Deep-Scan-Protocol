// Expanded BackstoryUI with all new data categories
public struct BackstoryUIExpanded {
    // Original fields
    public let background: String;
    public let earlyLife: String;
    public let significantEvents: String;

    // Criminal Record
    public let criminalStatus: String;
    public let warrantStatus: String;
    public let arrests: array<String>;
    public let gangAffiliation: String;
    public let gangRank: String;

    // Cyberware Registry
    public let installedCyberware: array<String>;
    public let cyberwareManufacturers: array<String>;
    public let illegalCyberware: Bool;
    public let cyberpsychosisRisk: Int32;
    public let rejectedImplants: array<String>;

    // Financial Profile
    public let creditScore: Int32;
    public let creditTier: String;
    public let debtHolder: String;
    public let debtAmount: Int32;
    public let propertyStatus: String;
    public let recentPurchases: array<String>;

    // Medical History
    public let bloodType: String;
    public let chronicConditions: array<String>;
    public let organReplacements: array<String>;
    public let ripperdocVisits: Int32;
    public let allergies: array<String>;
    public let donorStatus: String;

    // Psychological Assessment
    public let threatLevel: String;
    public let threatColor: String;
    public let personalityFlags: array<String>;
    public let addictions: array<String>;
    public let traumaEvents: array<String>;
    public let psychEvaluation: String;

    // Relationships
    public let knownAssociates: array<String>;
    public let familyMembers: array<String>;
    public let romanticHistory: String;
    public let dependents: Int32;

    // District Context
    public let currentDistrict: String;
    public let residenceDistrict: String;
    public let districtStanding: String;

    // Rare Flags
    public let isRareNPC: Bool;
    public let rareFlag: String;
    public let rareDescription: String;

    // Database Source
    public let primaryDatabase: String;
    public let classifiedSections: array<String>;
    public let dataIntegrity: Int32;
}

public struct AssociateData {
    public let name: String;
    public let relationship: String;
    public let status: String;
    public let affiliation: String;
}

public struct CyberwareData {
    public let name: String;
    public let manufacturer: String;
    public let slot: String;
    public let isLegal: Bool;
    public let condition: String;
}

public struct CrimeRecord {
    public let crime: String;
    public let year: Int32;
    public let status: String;
    public let severity: String;
}
