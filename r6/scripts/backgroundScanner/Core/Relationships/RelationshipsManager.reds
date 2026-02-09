// Relationships Generation System - Full Version (Shared Pool, Stack-Safe)
// Uses a heap-allocated NamePool built once per scan to avoid repeated stack array allocations.
// All sub-functions receive the pre-built pool and just index into it - zero allocation.

// ══════════════════════════════════════════════════════════════════════
// NAME POOL - Pre-built on heap, passed to all generation functions
// ══════════════════════════════════════════════════════════════════════
public class NamePool {
    public let maleFirstNames: array<String>;
    public let femaleFirstNames: array<String>;
    public let lastNames: array<String>;
    public let aliases: array<String>;

    // Build a name pool for a given ethnicity by collecting names from NameGenerator.
    // Each NameGenerator call temporarily allocates a stack array, but they happen
    // sequentially in this flat loop - stack frames release between iterations.
    // Once built, sub-functions never touch NameGenerator again.
    public static func Build(seed: Int32, ethnicity: NPCEthnicity) -> ref<NamePool> {
        let pool: ref<NamePool> = new NamePool();
        let i = 0;
        
        // Collect 20 male first names, 20 female first names, 20 last names
        // Using widely-spaced seeds to maximize variety
        while i < 20 {
            let s = seed + (i * 137);
            ArrayPush(pool.maleFirstNames, NameGenerator.GetFirstNameByEthnicity(s, "male", ethnicity));
            ArrayPush(pool.femaleFirstNames, NameGenerator.GetFirstNameByEthnicity(s + 50, "female", ethnicity));
            ArrayPush(pool.lastNames, NameGenerator.GetLastNameByEthnicity(s + 100, ethnicity));
            i += 1;
        }

        // Collect 15 aliases
        i = 0;
        while i < 15 {
            ArrayPush(pool.aliases, NameGenerator.GetStreetAlias(seed + (i * 89)));
            i += 1;
        }
        
        return pool;
    }

    // Pick a full name from pre-built arrays - zero allocation
    public func GetFullName(seed: Int32, gender: String) -> String {
        let firstName: String;
        if Equals(gender, "male") {
            firstName = this.maleFirstNames[RandRange(seed, 0, ArraySize(this.maleFirstNames) - 1)];
        } else {
            firstName = this.femaleFirstNames[RandRange(seed, 0, ArraySize(this.femaleFirstNames) - 1)];
        }
        let lastName = this.lastNames[RandRange(seed + 50, 0, ArraySize(this.lastNames) - 1)];
        return firstName + " " + lastName;
    }

    // Pick just a first name
    public func GetFirstName(seed: Int32, gender: String) -> String {
        if Equals(gender, "male") {
            return this.maleFirstNames[RandRange(seed, 0, ArraySize(this.maleFirstNames) - 1)];
        }
        return this.femaleFirstNames[RandRange(seed, 0, ArraySize(this.femaleFirstNames) - 1)];
    }

    // Pick just a last name
    public func GetLastName(seed: Int32) -> String {
        return this.lastNames[RandRange(seed, 0, ArraySize(this.lastNames) - 1)];
    }

    // Pick a street alias
    public func GetAlias(seed: Int32) -> String {
        return this.aliases[RandRange(seed, 0, ArraySize(this.aliases) - 1)];
    }
}

// ══════════════════════════════════════════════════════════════════════
// RELATIONSHIPS MANAGER - Full generation restored
// ══════════════════════════════════════════════════════════════════════
public class RelationshipsManager {

    public static func Generate(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: NPCEthnicity) -> ref<RelationshipsData> {
        // No NPC name provided - use random family name
        return RelationshipsManager.GenerateWithName(seed, archetype, gangAffiliation, ethnicity, "");
    }

    public static func GenerateWithName(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: NPCEthnicity, npcLastName: String) -> ref<RelationshipsData> {
        let relations: ref<RelationshipsData> = new RelationshipsData();
        
        // Build name pool ONCE on the heap - all sub-functions reuse this
        let pool: ref<NamePool> = NamePool.Build(seed, ethnicity);
        
        // Family last name - use NPC's actual last name if provided, otherwise random
        let familyLastName: String;
        if NotEquals(npcLastName, "") {
            familyLastName = npcLastName;
        } else {
            familyLastName = pool.GetLastName(seed + 50);
        }

        // Romantic history
        relations.romanticHistory = RelationshipsManager.GetRomanticHistory(seed + 200, archetype);
        
        // Relationship status and dependents
        relations.currentRelationshipStatus = RelationshipsManager.GetRelationshipStatus(seed + 210, archetype);
        relations.dependents = RelationshipsManager.GetDependents(seed + 300, archetype);
        
        // Emergency contact
        if RandRange(seed + 400, 1, 100) <= 60 {
            let ecGender = NameGenerator.GetRandomGender(seed + 415);
            let ecName = pool.GetFullName(seed + 410, ecGender);
            relations.emergencyContact = ecName + " (" + RelationshipsManager.GetContactRelationType(seed + 420) + ")";
        } else {
            relations.emergencyContact = "NONE ON FILE";
        }

        // Known associates - full count restored
        let associateCount = RelationshipsManager.GetAssociateCount(seed, archetype, gangAffiliation);
        let i = 0;
        while i < associateCount {
            ArrayPush(relations.knownAssociates, RelationshipsManager.GenerateAssociate(seed + (i * 100), archetype, gangAffiliation, pool));
            i += 1;
        }

        // Family members - full tree restored
        let familyCount = RelationshipsManager.GetFamilyCount(seed + 100, archetype);
        i = 0;
        while i < familyCount {
            ArrayPush(relations.familyMembers, RelationshipsManager.GenerateFamilyMember(seed + 110 + (i * 73), archetype, familyLastName, pool));
            i += 1;
        }

        // Enemies
        let enemyCount = RelationshipsManager.GetEnemyCount(seed + 500, archetype);
        i = 0;
        while i < enemyCount {
            ArrayPush(relations.knownEnemies, RelationshipsManager.GenerateEnemy(seed + 520 + (i * 80), archetype, gangAffiliation, pool));
            i += 1;
        }

        // Professional contacts
        if RelationshipsManager.HasProfessionalContacts(archetype) {
            let proCount = RandRange(seed + 600, 1, 3);
            i = 0;
            while i < proCount {
                ArrayPush(relations.professionalContacts, RelationshipsManager.GenerateProfessionalContact(seed + 610 + (i * 90), archetype, pool));
                i += 1;
            }
        }

        // Social network size
        relations.socialNetworkSize = RelationshipsManager.CalculateSocialNetworkSize(relations, archetype);
        
        return relations;
    }

    // ══════════════════════════════════════════════════════════════════════
    // ASSOCIATE GENERATION
    // ══════════════════════════════════════════════════════════════════════

    private static func GetAssociateCount(seed: Int32, archetype: String, gangAffiliation: String) -> Int32 {
        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") {
            return RandRange(seed, 3, 8);
        }
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 2, 5); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 2); }
        return RandRange(seed, 1, 4);
    }

    private static func GenerateAssociate(seed: Int32, archetype: String, gangAffiliation: String, pool: ref<NamePool>) -> ref<AssociateInfo> {
        let associate: ref<AssociateInfo> = new AssociateInfo();

        // Name from pre-built pool - zero allocation
        let gender = NameGenerator.GetRandomGender(seed + 999);
        associate.name = pool.GetFullName(seed, gender);
        associate.isAlias = false;
        
        // 30% chance for alias instead
        if RandRange(seed + 5, 1, 100) <= 30 {
            associate.name = pool.GetAlias(seed + 10);
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

    private static func GetAssociateRelationship(seed: Int32, archetype: String, gangAffiliation: String) -> String {
        let isGang = !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "");
        
        if isGang {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Fellow gang member"; }
            if i == 1 { return "Gang superior"; }
            if i == 2 { return "Gang subordinate"; }
            if i == 3 { return "Trusted lieutenant"; }
            if i == 4 { return "Drug supplier"; }
            if i == 5 { return "Weapons contact"; }
            if i == 6 { return "Enforcer buddy"; }
            if i == 7 { return "Initiation sponsor"; }
            if i == 8 { return "Territory partner"; }
            if i == 9 { return "Getaway driver"; }
            if i == 10 { return "Safe house contact"; }
            return "Money handler";
        }

        // Universal relationships (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Childhood friend"; }
        if i == 1 { return "Coworker"; }
        if i == 2 { return "Former partner"; }
        if i == 3 { return "Drinking buddy"; }
        if i == 4 { return "Business associate"; }
        if i == 5 { return "Neighbor"; }
        if i == 6 { return "Fixer contact"; }
        if i == 7 { return "Ripperdoc"; }
        if i == 8 { return "Dealer"; }
        if i == 9 { return "Informant"; }
        if i == 10 { return "Gym partner"; }
        if i == 11 { return "Former roommate"; }
        if i == 12 { return "Gambling buddy"; }
        if i == 13 { return "Online friend"; }
        if i == 14 { return "Regular at same bar"; }
        if i == 15 { return "Church/temple contact"; }
        if i == 16 { return "Hobby group friend"; }
        if i == 17 { return "Ex-coworker"; }
        if i == 18 { return "Mechanic"; }
        return "Street vendor contact";
    }

    private static func GetAssociateStatus(seed: Int32) -> String {
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "Active"; }
        if i == 1 { return "Active"; }
        if i == 2 { return "Active"; }
        if i == 3 { return "Active - frequent contact"; }
        if i == 4 { return "Active - occasional contact"; }
        if i == 5 { return "Deceased (" + IntToString(RandRange(seed + 5, 2070, 2077)) + ")"; }
        if i == 6 { return "Incarcerated"; }
        if i == 7 { return "Missing"; }
        if i == 8 { return "Relocated"; }
        if i == 9 { return "Under Surveillance"; }
        if i == 10 { return "Wanted"; }
        if i == 11 { return "In hiding"; }
        if i == 12 { return "Hospitalized"; }
        if i == 13 { return "Off-grid"; }
        return "Unknown";
    }

    private static func GetRandomAffiliation(seed: Int32, archetype: String) -> String {
        let i = RandRange(seed, 0, 11);
        if i == 0 { return "None"; }
        if i == 1 { return "None"; }
        if i == 2 { return "Unknown"; }
        if i == 3 { return "Arasaka (Suspected)"; }
        if i == 4 { return "Militech (Suspected)"; }
        if i == 5 { return "Criminal (Unaffiliated)"; }
        if i == 6 { return "Fixer Network"; }
        if i == 7 { return "Street Merc"; }
        if i == 8 { return "Netrunner collective"; }
        if i == 9 { return "Black market"; }
        if i == 10 { return "Scav connections"; }
        return "Corporate security";
    }

    // ══════════════════════════════════════════════════════════════════════
    // FAMILY GENERATION
    // ══════════════════════════════════════════════════════════════════════

    private static func GetFamilyCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 1); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 2, 5); }
        return RandRange(seed, 0, 4);
    }

    private static func GenerateFamilyMember(seed: Int32, archetype: String, familyLastName: String, pool: ref<NamePool>) -> ref<FamilyMemberInfo> {
        let family: ref<FamilyMemberInfo> = new FamilyMemberInfo();

        // Relation type via roll - no array needed
        family.relation = RelationshipsManager.GetFamilyRelationType(seed);
        
        // Determine gender based on relation
        let gender = "male";
        if Equals(family.relation, "Mother") || Equals(family.relation, "Sister") || 
           Equals(family.relation, "Grandmother") || Equals(family.relation, "Second Mother") {
            gender = "female";
        } else if Equals(family.relation, "Father") || Equals(family.relation, "Brother") || 
                  Equals(family.relation, "Grandfather") || Equals(family.relation, "Second Father") {
            gender = "male";
        } else if Equals(family.relation, "Non-binary Sibling") || Equals(family.relation, "Chosen Family") ||
                  Equals(family.relation, "Same-sex Spouse") || Equals(family.relation, "Partner (polyam)") {
            gender = NameGenerator.GetRandomGender(seed + 5);
        } else if Equals(family.relation, "Aunt") {
            gender = "female";
        } else if Equals(family.relation, "Uncle") {
            gender = "male";
        } else if Equals(family.relation, "Spouse") || Equals(family.relation, "Child") || Equals(family.relation, "Cousin") {
            gender = NameGenerator.GetRandomGender(seed + 5);
        }
        
        // First name from pool
        let firstName = pool.GetFirstName(seed + 10, gender);
        
        // Blood relatives share the family last name
        if RelationshipsManager.IsBloodRelative(family.relation) {
            family.name = firstName + " " + familyLastName;
        } else if Equals(family.relation, "Spouse") || Equals(family.relation, "Same-sex Spouse") || 
                  Equals(family.relation, "Partner (polyam)") {
            // Spouses usually take family name (80%), some keep maiden name (20%)
            if RandRange(seed + 15, 1, 100) <= 80 {
                family.name = firstName + " " + familyLastName;
            } else {
                family.name = firstName + " " + pool.GetLastName(seed + 20);
            }
        } else {
            // Aunt/Uncle/Cousin/Chosen Family - different branch
            family.name = firstName + " " + pool.GetLastName(seed + 20);
        }

        // Status
        let roll = RandRange(seed + 20, 1, 100);
        if roll <= 50 { family.status = "Alive"; }
        else if roll <= 70 { family.status = "Deceased"; }
        else if roll <= 80 { family.status = "Estranged"; }
        else if roll <= 90 { family.status = "Unknown"; }
        else { family.status = "Missing"; }

        // Location (only for living family)
        family.location = "";
        if Equals(family.status, "Alive") {
            family.location = RelationshipsManager.GetFamilyLocation(seed + 30);
        }

        return family;
    }

    private static func GetFamilyRelationType(seed: Int32) -> String {
        let diverse = KiroshiSettings.DiverseRelationshipsEnabled();
        let maxRoll = 11;
        if diverse { maxRoll = 18; }
        
        let roll = RandRange(seed, 1, maxRoll);
        if roll == 1 { return "Mother"; }
        if roll == 2 { return "Father"; }
        if roll == 3 { return "Sister"; }
        if roll == 4 { return "Brother"; }
        if roll == 5 { return "Spouse"; }
        if roll == 6 { return "Child"; }
        if roll == 7 { return "Grandmother"; }
        if roll == 8 { return "Grandfather"; }
        if roll == 9 { return "Aunt"; }
        if roll == 10 { return "Uncle"; }
        if roll == 11 { return "Cousin"; }
        // Diverse options
        if roll == 12 { return "Second Mother"; }
        if roll == 13 { return "Second Father"; }
        if roll == 14 { return "Same-sex Spouse"; }
        if roll == 15 { return "Non-binary Sibling"; }
        if roll == 16 { return "Partner (polyam)"; }
        if roll == 17 { return "Chosen Family"; }
        return "Adoptive Parent";
    }

    private static func IsBloodRelative(relation: String) -> Bool {
        if Equals(relation, "Mother") { return true; }
        if Equals(relation, "Father") { return true; }
        if Equals(relation, "Sister") { return true; }
        if Equals(relation, "Brother") { return true; }
        if Equals(relation, "Grandmother") { return true; }
        if Equals(relation, "Grandfather") { return true; }
        if Equals(relation, "Child") { return true; }
        if Equals(relation, "Non-binary Sibling") { return true; }
        if Equals(relation, "Second Mother") { return true; }
        if Equals(relation, "Second Father") { return true; }
        if Equals(relation, "Adoptive Parent") { return true; }
        return false;
    }

    private static func GetFamilyLocation(seed: Int32) -> String {
        let i = RandRange(seed, 0, 11);
        if i == 0 { return "Night City"; }
        if i == 1 { return "Night City"; }
        if i == 2 { return "Night City"; }
        if i == 3 { return "Badlands"; }
        if i == 4 { return "NUSA (Relocated)"; }
        if i == 5 { return "Europe"; }
        if i == 6 { return "Asia"; }
        if i == 7 { return "South America"; }
        if i == 8 { return "Orbital station"; }
        if i == 9 { return "Crystal Palace"; }
        if i == 10 { return "Texas Free State"; }
        return "Unknown";
    }

    // ══════════════════════════════════════════════════════════════════════
    // ENEMY GENERATION
    // ══════════════════════════════════════════════════════════════════════

    private static func GetEnemyCount(seed: Int32, archetype: String) -> Int32 {
        let chance = RelationshipsManager.GetEnemyChance(archetype);
        if RandRange(seed, 1, 100) <= chance {
            if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
                return RandRange(seed + 10, 1, 3);
            }
            return RandRange(seed + 10, 1, 2);
        }
        return 0;
    }

    private static func GetEnemyChance(archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return 60; }
        if Equals(archetype, "LOWLIFE") { return 40; }
        if Equals(archetype, "NOMAD") { return 35; }
        if Equals(archetype, "CORPO_MANAGER") { return 25; }
        return 20;
    }

    private static func GenerateEnemy(seed: Int32, archetype: String, gangAffiliation: String, pool: ref<NamePool>) -> ref<EnemyInfo> {
        let enemy: ref<EnemyInfo> = new EnemyInfo();

        // Name from pool or alias
        let gender = NameGenerator.GetRandomGender(seed + 3);
        enemy.name = pool.GetFullName(seed, gender);
        
        // 40% chance for alias instead
        if RandRange(seed + 5, 1, 100) <= 40 {
            enemy.name = pool.GetAlias(seed + 10);
        }

        // Reason for enmity
        enemy.reason = RelationshipsManager.GetEnemyReason(seed + 20);

        // Threat level
        let roll = RandRange(seed + 30, 1, 100);
        if roll <= 30 { enemy.threatLevel = "Low"; }
        else if roll <= 70 { enemy.threatLevel = "Moderate"; }
        else if roll <= 90 { enemy.threatLevel = "High"; }
        else { enemy.threatLevel = "Extreme"; }

        return enemy;
    }

    private static func GetEnemyReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "Business dispute"; }
        if i == 1 { return "Personal betrayal"; }
        if i == 2 { return "Romantic rivalry"; }
        if i == 3 { return "Gang conflict"; }
        if i == 4 { return "Debt dispute"; }
        if i == 5 { return "Family feud"; }
        if i == 6 { return "Territorial dispute"; }
        if i == 7 { return "Past violence"; }
        if i == 8 { return "Theft accusation"; }
        if i == 9 { return "Snitch suspicion"; }
        if i == 10 { return "Killed their friend"; }
        if i == 11 { return "Professional rivalry"; }
        if i == 12 { return "Blackmail situation"; }
        if i == 13 { return "Drug deal gone bad"; }
        return "Unknown origin";
    }

    // ══════════════════════════════════════════════════════════════════════
    // PROFESSIONAL CONTACTS
    // ══════════════════════════════════════════════════════════════════════

    private static func HasProfessionalContacts(archetype: String) -> Bool {
        if Equals(archetype, "CORPO_MANAGER") { return true; }
        if Equals(archetype, "CORPO_DRONE") { return true; }
        if Equals(archetype, "YUPPIE") { return true; }
        if Equals(archetype, "GANGER") { return true; }
        return false;
    }

    private static func GenerateProfessionalContact(seed: Int32, archetype: String, pool: ref<NamePool>) -> ref<ProfessionalContactInfo> {
        let contact: ref<ProfessionalContactInfo> = new ProfessionalContactInfo();

        let gender = NameGenerator.GetRandomGender(seed + 999);
        contact.name = pool.GetFullName(seed, gender);

        // Type based on archetype
        contact.type = RelationshipsManager.GetProfessionalContactType(seed + 10, archetype);
        
        if RandRange(seed + 20, 1, 100) <= 50 {
            contact.frequency = "Regular contact";
        } else {
            contact.frequency = "Occasional contact";
        }

        return contact;
    }

    private static func GetProfessionalContactType(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Colleague"; }
            if i == 1 { return "Supervisor"; }
            if i == 2 { return "Client"; }
            if i == 3 { return "Business Partner"; }
            if i == 4 { return "Corporate Contact"; }
            if i == 5 { return "Legal counsel"; }
            if i == 6 { return "Accountant"; }
            if i == 7 { return "HR contact"; }
            if i == 8 { return "Industry contact"; }
            return "Networking connection";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Fixer"; }
            if i == 1 { return "Arms Dealer"; }
            if i == 2 { return "Ripperdoc"; }
            if i == 3 { return "Drug Supplier"; }
            if i == 4 { return "Information Broker"; }
            if i == 5 { return "Fence"; }
            if i == 6 { return "Chop shop owner"; }
            if i == 7 { return "Bookie"; }
            if i == 8 { return "Smuggler"; }
            return "Street doc";
        }
        
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Business Contact"; }
        if i == 1 { return "Service Provider"; }
        if i == 2 { return "Mentor"; }
        if i == 3 { return "Former teacher"; }
        if i == 4 { return "Trade contact"; }
        return "Professional acquaintance";
    }

    // ══════════════════════════════════════════════════════════════════════
    // STATUS / MISC - All use roll-based selection, no arrays
    // ══════════════════════════════════════════════════════════════════════

    private static func GetRomanticHistory(seed: Int32, archetype: String) -> String {
        let diverse = KiroshiSettings.DiverseRelationshipsEnabled();
        let maxRoll = 9;
        if diverse { maxRoll = 15; }
        
        let roll = RandRange(seed, 1, maxRoll);
        if roll == 1 { return "No significant relationships on record"; }
        if roll == 2 { return "1 failed marriage"; }
        if roll == 3 { return "2 failed marriages"; }
        if roll == 4 { return "Multiple short-term relationships"; }
        if roll == 5 { return "1 long-term relationship (ended)"; }
        if roll == 6 { return "Widowed"; }
        if roll == 7 { return "Serial dater"; }
        if roll == 8 { return "Committed relationship history"; }
        if roll == 9 { return "Records indicate frequent use of joytoy services"; }
        // Diverse options
        if roll == 10 { return "History of same-sex relationships"; }
        if roll == 11 { return "Bisexual dating pattern indicated"; }
        if roll == 12 { return "Previously in polyamorous arrangement"; }
        if roll == 13 { return "Same-sex marriage (ended)"; }
        if roll == 14 { return "Multiple concurrent partnerships on record"; }
        return "Gender-diverse dating history";
    }

    private static func GetRelationshipStatus(seed: Int32, archetype: String) -> String {
        let diverse = KiroshiSettings.DiverseRelationshipsEnabled();
        let maxRoll = 10;
        if diverse { maxRoll = 15; }
        
        let roll = RandRange(seed, 1, maxRoll);
        if roll == 1 { return "Single"; }
        if roll == 2 { return "Single"; }
        if roll == 3 { return "In relationship"; }
        if roll == 4 { return "Married"; }
        if roll == 5 { return "Domestic partnership"; }
        if roll == 6 { return "Separated"; }
        if roll == 7 { return "Divorced"; }
        if roll == 8 { return "Widowed"; }
        if roll == 9 { return "It's complicated"; }
        if roll == 10 { return "Unknown"; }
        // Diverse options
        if roll == 11 { return "Polyamorous arrangement"; }
        if roll == 12 { return "Open relationship"; }
        if roll == 13 { return "Same-sex partnership"; }
        if roll == 14 { return "Same-sex marriage"; }
        return "Cohabitating (multiple partners)";
    }

    private static func GetDependents(seed: Int32, archetype: String) -> Int32 {
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

    private static func GetContactRelationType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 9);
        if i == 0 { return "Spouse"; }
        if i == 1 { return "Partner"; }
        if i == 2 { return "Parent"; }
        if i == 3 { return "Sibling"; }
        if i == 4 { return "Friend"; }
        if i == 5 { return "Ex-Partner"; }
        if i == 6 { return "Child"; }
        if i == 7 { return "Coworker"; }
        if i == 8 { return "Roommate"; }
        return "Neighbor";
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

// ══════════════════════════════════════════════════════════════════════
// DATA CLASSES
// ══════════════════════════════════════════════════════════════════════

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
