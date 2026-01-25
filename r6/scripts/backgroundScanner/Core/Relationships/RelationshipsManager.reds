// Relationships Generation System
public class RelationshipsManager {

    public static func Generate(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: NPCEthnicity) -> ref<RelationshipsData> {
        let relations: ref<RelationshipsData> = new RelationshipsData();
        
        // Generate family last name (shared by blood relatives) - use ethnicity-aware
        let familyLastName = NameGenerator.GetLastNameByEthnicity(seed + 50, ethnicity);

        // Known associates - limited by density
        let associateCount = RelationshipsManager.GetAssociateCount(seed, archetype, gangAffiliation);
        associateCount = KiroshiSettings.GetMaxListItems(associateCount);
        
        let i = 0;
        while i < associateCount {
            ArrayPush(relations.knownAssociates, RelationshipsManager.GenerateAssociate(seed + (i * 67), archetype, gangAffiliation, ethnicity));
            i += 1;
        }

        // Family members - limited by density
        let familyCount = RelationshipsManager.GetFamilyCount(seed + 100, archetype);
        familyCount = KiroshiSettings.GetMaxListItems(familyCount);
        
        i = 0;
        while i < familyCount {
            ArrayPush(relations.familyMembers, RelationshipsManager.GenerateFamilyMember(seed + 110 + (i * 73), archetype, familyLastName, ethnicity));
            i += 1;
        }

        // Romantic history - only on medium/high density
        if !KiroshiSettings.IsLowDensity() {
            relations.romanticHistory = RelationshipsManager.GenerateRomanticHistory(seed + 200, archetype);
        }
        relations.currentRelationshipStatus = RelationshipsManager.GenerateRelationshipStatus(seed + 210, archetype);

        // Dependents
        relations.dependents = RelationshipsManager.GenerateDependents(seed + 300, archetype);

        // Emergency contact
        if RandRange(seed + 400, 1, 100) <= 60 {
            relations.emergencyContact = RelationshipsManager.GenerateEmergencyContact(seed + 410, archetype, ethnicity);
        } else {
            relations.emergencyContact = "NONE ON FILE";
        }

        // Enemies/Rivals - limited by density
        if RandRange(seed + 500, 1, 100) <= RelationshipsManager.GetEnemyChance(archetype) {
            let enemyCount = RandRange(seed + 510, 1, 3);
            enemyCount = KiroshiSettings.GetMaxListItems(enemyCount);
            
            i = 0;
            while i < enemyCount {
                ArrayPush(relations.knownEnemies, RelationshipsManager.GenerateEnemy(seed + 520 + (i * 79), archetype, gangAffiliation, ethnicity));
                i += 1;
            }
        }

        // Professional contacts - only on medium/high density
        if !KiroshiSettings.IsLowDensity() && RelationshipsManager.HasProfessionalContacts(archetype) {
            let contactCount = RandRange(seed + 600, 1, 4);
            contactCount = KiroshiSettings.GetMaxListItems(contactCount);
            
            i = 0;
            while i < contactCount {
                ArrayPush(relations.professionalContacts, RelationshipsManager.GenerateProfessionalContact(seed + 610 + (i * 83), archetype));
                i += 1;
            }
        }

        // Social network size
        relations.socialNetworkSize = RelationshipsManager.CalculateSocialNetworkSize(relations, archetype);

        return relations;
    }

    private static func GetAssociateCount(seed: Int32, archetype: String, gangAffiliation: String) -> Int32 {
        let base: Int32;

        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") {
            base = RandRange(seed, 3, 8);
        } else if Equals(archetype, "CORPO_MANAGER") {
            base = RandRange(seed, 2, 5);
        } else if Equals(archetype, "HOMELESS") {
            base = RandRange(seed, 0, 2);
        } else {
            base = RandRange(seed, 1, 4);
        }

        return base;
    }

    private static func GenerateAssociate(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: NPCEthnicity) -> ref<AssociateInfo> {
        let associate: ref<AssociateInfo> = new AssociateInfo();

        // Generate name - ethnicity aware
        associate.name = RelationshipsManager.GenerateNameByEthnicity(seed, ethnicity);
        
        // Or use alias
        if RandRange(seed + 5, 1, 100) <= 30 {
            associate.name = RelationshipsManager.GenerateStreetAlias(seed + 10);
            associate.isAlias = true;
        }

        // Relationship type
        associate.relationship = RelationshipsManager.GetAssociateRelationship(seed + 20, archetype, gangAffiliation);

        // Status
        associate.status = RelationshipsManager.GetAssociateStatus(seed + 30);

        // Affiliation
        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") && RandRange(seed + 40, 1, 100) <= 70 {
            associate.affiliation = gangAffiliation;
        } else {
            associate.affiliation = RelationshipsManager.GetRandomAffiliation(seed + 50, archetype);
        }

        return associate;
    }

    private static func GenerateName(seed: Int32) -> String {
        // Use shared NameGenerator with random gender and ethnicity
        let gender = NameGenerator.GetRandomGender(seed + 999);
        return NameGenerator.GenerateFullName(seed, gender);
    }

    private static func GenerateNameByEthnicity(seed: Int32, ethnicity: NPCEthnicity) -> String {
        // Use shared NameGenerator with random gender but specific ethnicity
        let gender = NameGenerator.GetRandomGender(seed + 999);
        return NameGenerator.GenerateFullNameByEthnicity(seed, gender, ethnicity);
    }

    private static func GenerateStreetAlias(seed: Int32) -> String {
        return NameGenerator.GetStreetAlias(seed);
    }

    private static func GetAssociateRelationship(seed: Int32, archetype: String, gangAffiliation: String) -> String {
        let relationships: array<String>;

        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") {
            ArrayPush(relationships, "Fellow gang member");
            ArrayPush(relationships, "Gang superior");
            ArrayPush(relationships, "Gang subordinate");
            ArrayPush(relationships, "Trusted lieutenant");
            ArrayPush(relationships, "Drug supplier");
            ArrayPush(relationships, "Weapons contact");
        }

        ArrayPush(relationships, "Childhood friend");
        ArrayPush(relationships, "Coworker");
        ArrayPush(relationships, "Former partner");
        ArrayPush(relationships, "Drinking buddy");
        ArrayPush(relationships, "Business associate");
        ArrayPush(relationships, "Neighbor");
        ArrayPush(relationships, "Fixer contact");
        ArrayPush(relationships, "Ripperdoc");
        ArrayPush(relationships, "Dealer");
        ArrayPush(relationships, "Informant");

        return relationships[RandRange(seed, 0, ArraySize(relationships) - 1)];
    }

    private static func GetAssociateStatus(seed: Int32) -> String {
        let statuses: array<String>;

        ArrayPush(statuses, "Active");
        ArrayPush(statuses, "Active");
        ArrayPush(statuses, "Active");
        ArrayPush(statuses, "Deceased (" + IntToString(RandRange(seed + 5, 2070, 2077)) + ")");
        ArrayPush(statuses, "Incarcerated");
        ArrayPush(statuses, "Missing");
        ArrayPush(statuses, "Relocated");
        ArrayPush(statuses, "Under Surveillance");
        ArrayPush(statuses, "Wanted");
        ArrayPush(statuses, "Unknown");

        return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
    }

    private static func GetRandomAffiliation(seed: Int32, archetype: String) -> String {
        let affiliations: array<String>;

        ArrayPush(affiliations, "None");
        ArrayPush(affiliations, "Unknown");
        ArrayPush(affiliations, "Arasaka (Suspected)");
        ArrayPush(affiliations, "Militech (Suspected)");
        ArrayPush(affiliations, "Criminal (Unaffiliated)");
        ArrayPush(affiliations, "Fixer Network");
        ArrayPush(affiliations, "Street Merc");

        return affiliations[RandRange(seed, 0, ArraySize(affiliations) - 1)];
    }

    private static func GetFamilyCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 1); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 2, 5); } // Close family ties
        return RandRange(seed, 0, 4);
    }

    private static func GenerateFamilyMember(seed: Int32, archetype: String, familyLastName: String, ethnicity: NPCEthnicity) -> ref<FamilyMemberInfo> {
        let family: ref<FamilyMemberInfo> = new FamilyMemberInfo();

        // Relation type
        let relations: array<String>;
        ArrayPush(relations, "Mother");
        ArrayPush(relations, "Father");
        ArrayPush(relations, "Sister");
        ArrayPush(relations, "Brother");
        ArrayPush(relations, "Spouse");
        ArrayPush(relations, "Child");
        ArrayPush(relations, "Grandmother");
        ArrayPush(relations, "Grandfather");
        ArrayPush(relations, "Aunt");
        ArrayPush(relations, "Uncle");
        ArrayPush(relations, "Cousin");

        // Diverse family structures when enabled
        if KiroshiSettings.DiverseRelationshipsEnabled() {
            ArrayPush(relations, "Second Mother");
            ArrayPush(relations, "Second Father");
            ArrayPush(relations, "Same-sex Spouse");
            ArrayPush(relations, "Non-binary Sibling");
            ArrayPush(relations, "Partner (polyam)");
            ArrayPush(relations, "Chosen Family");
            ArrayPush(relations, "Adoptive Parent");
        }

        family.relation = relations[RandRange(seed, 0, ArraySize(relations) - 1)];
        
        // Generate name - blood relatives share family last name
        let gender = NameGenerator.GetRandomGender(seed + 5);
        
        // Determine gender based on relation type (with some flexibility when diverse mode enabled)
        if Equals(family.relation, "Mother") || Equals(family.relation, "Sister") || 
           Equals(family.relation, "Grandmother") || Equals(family.relation, "Second Mother") {
            gender = "female";
        } else if Equals(family.relation, "Father") || Equals(family.relation, "Brother") || 
                  Equals(family.relation, "Grandfather") || Equals(family.relation, "Second Father") {
            gender = "male";
        } else if Equals(family.relation, "Non-binary Sibling") || Equals(family.relation, "Chosen Family") {
            // Keep random gender for non-binary/chosen family
            gender = NameGenerator.GetRandomGender(seed + 5);
        } else if Equals(family.relation, "Same-sex Spouse") || Equals(family.relation, "Partner (polyam)") {
            // Random gender for these relationships
            gender = NameGenerator.GetRandomGender(seed + 5);
        };
        
        // Use ethnicity-aware first name
        let firstName = NameGenerator.GetFirstNameByEthnicity(seed + 10, gender, ethnicity);
        
        // Blood relatives share the family last name
        if Equals(family.relation, "Mother") || Equals(family.relation, "Father") || 
           Equals(family.relation, "Sister") || Equals(family.relation, "Brother") ||
           Equals(family.relation, "Grandmother") || Equals(family.relation, "Grandfather") ||
           Equals(family.relation, "Child") || Equals(family.relation, "Non-binary Sibling") ||
           Equals(family.relation, "Second Mother") || Equals(family.relation, "Second Father") {
            family.name = firstName + " " + familyLastName;
        } else {
            // Spouse, Aunt, Uncle, Cousin, Partners might have different last names
            if Equals(family.relation, "Spouse") || Equals(family.relation, "Same-sex Spouse") || 
               Equals(family.relation, "Partner (polyam)") {
                // Spouse might have taken family name or kept maiden name
                if RandRange(seed + 15, 1, 100) <= 50 {
                    family.name = firstName + " " + familyLastName;
                } else {
                    family.name = firstName + " " + NameGenerator.GetLastNameByEthnicity(seed + 20, ethnicity);
                };
            } else {
                // Aunt/Uncle/Cousin/Chosen Family - different branch of family
                family.name = firstName + " " + NameGenerator.GetLastNameByEthnicity(seed + 20, ethnicity);
            };
        };

        // Status
        let roll = RandRange(seed + 20, 1, 100);
        if roll <= 50 { family.status = "Alive"; }
        else if roll <= 70 { family.status = "Deceased"; }
        else if roll <= 80 { family.status = "Estranged"; }
        else if roll <= 90 { family.status = "Unknown"; }
        else { family.status = "Missing"; }

        // Location
        if Equals(family.status, "Alive") {
            let locations: array<String>;
            ArrayPush(locations, "Night City");
            ArrayPush(locations, "Night City");
            ArrayPush(locations, "Badlands");
            ArrayPush(locations, "NUSA (Relocated)");
            ArrayPush(locations, "Europe");
            ArrayPush(locations, "Asia");
            ArrayPush(locations, "Unknown");
            family.location = locations[RandRange(seed + 30, 0, ArraySize(locations) - 1)];
        }

        return family;
    }

    private static func GenerateRomanticHistory(seed: Int32, archetype: String) -> String {
        let histories: array<String>;

        ArrayPush(histories, "No significant relationships on record");
        ArrayPush(histories, "1 failed marriage");
        ArrayPush(histories, "2 failed marriages");
        ArrayPush(histories, "Multiple short-term relationships");
        ArrayPush(histories, "1 long-term relationship (ended)");
        ArrayPush(histories, "Widowed");
        ArrayPush(histories, "Serial dater");
        ArrayPush(histories, "Committed relationship history");
        ArrayPush(histories, "Records indicate frequent use of joytoy services");

        // Diverse histories when enabled
        if KiroshiSettings.DiverseRelationshipsEnabled() {
            ArrayPush(histories, "History of same-sex relationships");
            ArrayPush(histories, "Bisexual dating pattern indicated");
            ArrayPush(histories, "Previously in polyamorous arrangement");
            ArrayPush(histories, "Same-sex marriage (ended)");
            ArrayPush(histories, "Multiple concurrent partnerships on record");
            ArrayPush(histories, "Gender-diverse dating history");
        }

        return histories[RandRange(seed, 0, ArraySize(histories) - 1)];
    }

    private static func GenerateRelationshipStatus(seed: Int32, archetype: String) -> String {
        let statuses: array<String>;

        ArrayPush(statuses, "Single");
        ArrayPush(statuses, "Single");
        ArrayPush(statuses, "In relationship");
        ArrayPush(statuses, "Married");
        ArrayPush(statuses, "Domestic partnership");
        ArrayPush(statuses, "Separated");
        ArrayPush(statuses, "Divorced");
        ArrayPush(statuses, "Widowed");
        ArrayPush(statuses, "It's complicated");
        ArrayPush(statuses, "Unknown");

        // Diverse relationships when enabled
        if KiroshiSettings.DiverseRelationshipsEnabled() {
            ArrayPush(statuses, "Polyamorous arrangement");
            ArrayPush(statuses, "Open relationship");
            ArrayPush(statuses, "Same-sex partnership");
            ArrayPush(statuses, "Same-sex marriage");
            ArrayPush(statuses, "Cohabitating (multiple partners)");
        }

        return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
    }

    private static func GenerateDependents(seed: Int32, archetype: String) -> Int32 {
        let chance: Int32;

        if Equals(archetype, "CORPO_MANAGER") { chance = 40; }
        else if Equals(archetype, "CIVVIE") { chance = 50; }
        else if Equals(archetype, "HOMELESS") { chance = 10; }
        else if Equals(archetype, "JUNKIE") { chance = 15; }
        else { chance = 30; }

        if RandRange(seed, 1, 100) <= chance {
            return RandRange(seed + 10, 1, 3);
        }
        return 0;
    }

    private static func GenerateEmergencyContact(seed: Int32, archetype: String, ethnicity: NPCEthnicity) -> String {
        let name = RelationshipsManager.GenerateNameByEthnicity(seed, ethnicity);
        let relations: array<String>;
        ArrayPush(relations, "Spouse");
        ArrayPush(relations, "Parent");
        ArrayPush(relations, "Sibling");
        ArrayPush(relations, "Partner");
        ArrayPush(relations, "Friend");

        return name + " (" + relations[RandRange(seed + 10, 0, ArraySize(relations) - 1)] + ")";
    }

    private static func GetEnemyChance(archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return 60; }
        if Equals(archetype, "LOWLIFE") { return 40; }
        if Equals(archetype, "NOMAD") { return 35; }
        if Equals(archetype, "CORPO_MANAGER") { return 25; }
        return 20;
    }

    private static func GenerateEnemy(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: NPCEthnicity) -> ref<EnemyInfo> {
        let enemy: ref<EnemyInfo> = new EnemyInfo();

        // Enemies may or may not share ethnicity - 50% chance of different ethnicity
        let enemyEthnicity = ethnicity;
        if RandRange(seed + 3, 1, 100) <= 50 {
            enemyEthnicity = EthnicityDetector.GetRandomEthnicity(seed + 7);
        }

        enemy.name = RelationshipsManager.GenerateNameByEthnicity(seed, enemyEthnicity);
        if RandRange(seed + 5, 1, 100) <= 40 {
            enemy.name = RelationshipsManager.GenerateStreetAlias(seed + 10);
        }

        // Reason for enmity
        let reasons: array<String>;
        ArrayPush(reasons, "Business dispute");
        ArrayPush(reasons, "Personal betrayal");
        ArrayPush(reasons, "Romantic rivalry");
        ArrayPush(reasons, "Gang conflict");
        ArrayPush(reasons, "Debt dispute");
        ArrayPush(reasons, "Family feud");
        ArrayPush(reasons, "Territorial dispute");
        ArrayPush(reasons, "Past violence");
        ArrayPush(reasons, "Unknown origin");

        enemy.reason = reasons[RandRange(seed + 20, 0, ArraySize(reasons) - 1)];

        // Threat level
        let roll = RandRange(seed + 30, 1, 100);
        if roll <= 30 { enemy.threatLevel = "Low"; }
        else if roll <= 70 { enemy.threatLevel = "Moderate"; }
        else if roll <= 90 { enemy.threatLevel = "High"; }
        else { enemy.threatLevel = "Extreme"; }

        return enemy;
    }

    private static func HasProfessionalContacts(archetype: String) -> Bool {
        if Equals(archetype, "CORPO_MANAGER") { return true; }
        if Equals(archetype, "CORPO_DRONE") { return true; }
        if Equals(archetype, "YUPPIE") { return true; }
        if Equals(archetype, "GANGER") { return true; }
        return false;
    }

    private static func GenerateProfessionalContact(seed: Int32, archetype: String) -> ref<ProfessionalContactInfo> {
        let contact: ref<ProfessionalContactInfo> = new ProfessionalContactInfo();

        contact.name = RelationshipsManager.GenerateName(seed);

        // Type based on archetype
        let types: array<String>;
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            ArrayPush(types, "Colleague");
            ArrayPush(types, "Supervisor");
            ArrayPush(types, "Client");
            ArrayPush(types, "Business Partner");
            ArrayPush(types, "Corporate Contact");
        } else if Equals(archetype, "GANGER") {
            ArrayPush(types, "Fixer");
            ArrayPush(types, "Arms Dealer");
            ArrayPush(types, "Ripperdoc");
            ArrayPush(types, "Drug Supplier");
            ArrayPush(types, "Information Broker");
        } else {
            ArrayPush(types, "Business Contact");
            ArrayPush(types, "Service Provider");
            ArrayPush(types, "Mentor");
        }

        contact.type = types[RandRange(seed + 10, 0, ArraySize(types) - 1)];
        contact.frequency = RandRange(seed + 20, 1, 100) <= 50 ? "Regular contact" : "Occasional contact";

        return contact;
    }

    private static func CalculateSocialNetworkSize(relations: ref<RelationshipsData>, archetype: String) -> String {
        let total = ArraySize(relations.knownAssociates) + ArraySize(relations.familyMembers) + 
                   ArraySize(relations.professionalContacts) + relations.dependents;

        if total >= 10 { return "Large (" + IntToString(total) + "+ connections)"; }
        if total >= 5 { return "Moderate (" + IntToString(total) + " connections)"; }
        if total >= 2 { return "Small (" + IntToString(total) + " connections)"; }
        return "Isolated (minimal connections)";
    }
}

public class RelationshipsData {
    public let knownAssociates: array<ref<AssociateInfo>>;
    public let familyMembers: array<ref<FamilyMemberInfo>>;
    public let romanticHistory: String;
    public let currentRelationshipStatus: String;
    public let dependents: Int32;
    public let emergencyContact: String;
    public let knownEnemies: array<ref<EnemyInfo>>;
    public let professionalContacts: array<ref<ProfessionalContactInfo>>;
    public let socialNetworkSize: String;
}

public class AssociateInfo {
    public let name: String;
    public let isAlias: Bool;
    public let relationship: String;
    public let status: String;
    public let affiliation: String;
}

public class FamilyMemberInfo {
    public let name: String;
    public let relation: String;
    public let status: String;
    public let location: String;
}

public class EnemyInfo {
    public let name: String;
    public let reason: String;
    public let threatLevel: String;
}

public class ProfessionalContactInfo {
    public let name: String;
    public let type: String;
    public let frequency: String;
}
