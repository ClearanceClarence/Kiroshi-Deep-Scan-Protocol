// Kiroshi Deep Scan Protocol - Unique NPC Data Structures
// Hand-crafted backstories for named story characters

public class KdspUniqueNPCBackstory {
    public let characterId: String;          // TweakDB character ID (e.g., "Character.intim_takemura")
    public let displayName: String;          // Override display name if needed
    public let background: String;           // Origin/background story
    public let earlyLife: String;            // Early career/life events
    public let significantEvents: String;    // Recent/notable events
    public let affiliation: String;          // Faction/group affiliation
    public let criminalRecord: String;       // Criminal history (if any)
    public let cyberwareStatus: String;      // Known cyberware
    public let financialStatus: String;      // Financial info
    public let medicalStatus: String;        // Medical notes
    public let threatAssessment: String;     // Threat level
    public let relationships: String;        // Known associates
    public let notes: String;                // Additional intel/notes
    public let classification: String;       // Database classification (e.g., "ARASAKA PERSONNEL", "FIXER")

    public static func Create(id: String) -> ref<KdspUniqueNPCBackstory> {
        let self = new KdspUniqueNPCBackstory();
        self.characterId = id;
        self.displayName = "";
        self.background = "";
        self.earlyLife = "";
        self.significantEvents = "";
        self.affiliation = "";
        self.criminalRecord = "";
        self.cyberwareStatus = "";
        self.financialStatus = "";
        self.medicalStatus = "";
        self.threatAssessment = "";
        self.relationships = "";
        self.notes = "";
        self.classification = "CLASSIFIED";
        return self;
    }

    // Builder pattern methods for clean entry creation
    public func SetDisplayName(name: String) -> ref<KdspUniqueNPCBackstory> {
        this.displayName = name;
        return this;
    }

    public func SetBackground(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.background = text;
        return this;
    }

    public func SetEarlyLife(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.earlyLife = text;
        return this;
    }

    public func SetSignificantEvents(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.significantEvents = text;
        return this;
    }

    public func SetAffiliation(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.affiliation = text;
        return this;
    }

    public func SetCriminalRecord(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.criminalRecord = text;
        return this;
    }

    public func SetCyberwareStatus(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.cyberwareStatus = text;
        return this;
    }

    public func SetFinancialStatus(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.financialStatus = text;
        return this;
    }

    public func SetMedicalStatus(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.medicalStatus = text;
        return this;
    }

    public func SetThreatAssessment(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.threatAssessment = text;
        return this;
    }

    public func SetRelationships(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.relationships = text;
        return this;
    }

    public func SetNotes(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.notes = text;
        return this;
    }

    public func SetClassification(text: String) -> ref<KdspUniqueNPCBackstory> {
        this.classification = text;
        return this;
    }

    // Convert to KdspBackstoryUI for display
    public func ToBackstoryUI() -> KdspBackstoryUI {
        let ui: KdspBackstoryUI;
        ui.background = this.background;
        ui.earlyLife = this.earlyLife;
        ui.significantEvents = this.significantEvents;
        ui.criminalRecord = this.criminalRecord;
        ui.cyberwareStatus = this.cyberwareStatus;
        ui.financialStatus = this.financialStatus;
        ui.medicalStatus = this.medicalStatus;
        ui.threatAssessment = this.threatAssessment;
        ui.relationships = this.relationships;
        ui.gangAffiliation = this.affiliation;
        ui.rareFlag = this.notes;
        ui.ncpdOfficer = "";
        ui.pronouns = "";
        ui.isUnique = true;
        ui.uniqueClassification = this.classification;
        return ui;
    }
}
