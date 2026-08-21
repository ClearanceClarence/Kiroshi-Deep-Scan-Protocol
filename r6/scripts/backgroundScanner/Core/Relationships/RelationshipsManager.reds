// Relationships Generation System - Full Version (Shared Pool, Stack-Safe)
// Uses a heap-allocated KdspNamePool built once per scan to avoid repeated stack array allocations.
// All sub-functions receive the pre-built pool and just index into it - zero allocation.

// ══════════════════════════════════════════════════════════════════════
// NAME POOL - Pre-built on heap, passed to all generation functions
// ══════════════════════════════════════════════════════════════════════
public class KdspNamePool {
    public let maleFirstNames: array<String>;
    public let femaleFirstNames: array<String>;
    public let lastNames: array<String>;
    public let aliases: array<String>;

    // Build a name pool for a given ethnicity by collecting names from KdspNameGenerator.
    // Each KdspNameGenerator call temporarily allocates a stack array, but they happen
    // sequentially in this flat loop - stack frames release between iterations.
    // Once built, sub-functions never touch KdspNameGenerator again.
    public static func Build(seed: Int32, ethnicity: KdspNPCEthnicity) -> ref<KdspNamePool> {
        let pool: ref<KdspNamePool> = new KdspNamePool();
        let i = 0;
        
        // Collect 20 male first names, 20 female first names, 20 last names
        // Using widely-spaced seeds to maximize variety
        while i < 20 {
            let s = seed + (i * 137);
            ArrayPush(pool.maleFirstNames, KdspNameGenerator.GetFirstNameByEthnicity(s, "male", ethnicity));
            ArrayPush(pool.femaleFirstNames, KdspNameGenerator.GetFirstNameByEthnicity(s + 50, "female", ethnicity));
            ArrayPush(pool.lastNames, KdspNameGenerator.GetLastNameByEthnicity(s + 100, ethnicity));
            i += 1;
        }

        // Collect 15 aliases
        i = 0;
        while i < 15 {
            ArrayPush(pool.aliases, KdspNameGenerator.GetStreetAlias(seed + (i * 89)));
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
public class KdspRelationshipsManager {

    public static func Generate(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: KdspNPCEthnicity) -> ref<KdspRelationshipsData> {
        // No NPC name provided - use random family name
        return KdspRelationshipsManager.GenerateWithName(seed, archetype, gangAffiliation, ethnicity, "");
    }

    public static func GenerateWithName(seed: Int32, archetype: String, gangAffiliation: String, ethnicity: KdspNPCEthnicity, npcLastName: String) -> ref<KdspRelationshipsData> {
        let relations: ref<KdspRelationshipsData> = new KdspRelationshipsData();
        
        // Build name pool ONCE on the heap - all sub-functions reuse this
        let pool: ref<KdspNamePool> = KdspNamePool.Build(seed, ethnicity);
        
        // Family last name - use NPC's actual last name if provided, otherwise random
        let familyLastName: String;
        if NotEquals(npcLastName, "") {
            familyLastName = npcLastName;
        } else {
            familyLastName = pool.GetLastName(seed + 50);
        }

        // Romantic history
        relations.romanticHistory = KdspRelationshipsManager.GetRomanticHistory(seed + 200, archetype);
        
        // Relationship status and dependents
        relations.currentRelationshipStatus = KdspRelationshipsManager.GetRelationshipStatus(seed + 210, archetype);
        relations.dependents = KdspRelationshipsManager.GetDependents(seed + 300, archetype);
        
        // Emergency contact
        if RandRange(seed + 400, 1, 100) <= 60 {
            let ecGender = KdspNameGenerator.GetRandomGender(seed + 415);
            let ecName = pool.GetFullName(seed + 410, ecGender);
            relations.emergencyContact = ecName + " (" + KdspRelationshipsManager.GetContactRelationType(seed + 420) + ")";
        } else {
            relations.emergencyContact = GetLocalizedTextByKey(n"Kdsp-Shared-C2");
        }

        // Known associates - full count restored
        let associateCount = KdspRelationshipsManager.GetAssociateCount(seed, archetype, gangAffiliation);
        let i = 0;
        while i < associateCount {
            ArrayPush(relations.knownAssociates, KdspRelationshipsManager.GenerateAssociate(seed + (i * 100), archetype, gangAffiliation, pool));
            i += 1;
        }

        // Family members - full tree restored
        let familyCount = KdspRelationshipsManager.GetFamilyCount(seed + 100, archetype);
        i = 0;
        while i < familyCount {
            ArrayPush(relations.familyMembers, KdspRelationshipsManager.GenerateFamilyMember(seed + 110 + (i * 73), archetype, familyLastName, pool));
            i += 1;
        }

        // Enemies
        let enemyCount = KdspRelationshipsManager.GetEnemyCount(seed + 500, archetype);
        i = 0;
        while i < enemyCount {
            ArrayPush(relations.knownEnemies, KdspRelationshipsManager.GenerateEnemy(seed + 520 + (i * 80), archetype, gangAffiliation, pool));
            i += 1;
        }

        // Professional contacts
        if KdspRelationshipsManager.HasProfessionalContacts(archetype) {
            let proCount = RandRange(seed + 600, 1, 3);
            i = 0;
            while i < proCount {
                ArrayPush(relations.professionalContacts, KdspRelationshipsManager.GenerateProfessionalContact(seed + 610 + (i * 90), archetype, pool));
                i += 1;
            }
        }

        // Social network size
        relations.socialNetworkSize = KdspRelationshipsManager.CalculateSocialNetworkSize(relations, archetype);
        
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

    private static func GenerateAssociate(seed: Int32, archetype: String, gangAffiliation: String, pool: ref<KdspNamePool>) -> ref<KdspAssociateInfo> {
        let associate: ref<KdspAssociateInfo> = new KdspAssociateInfo();

        // Name from pre-built pool - zero allocation
        let gender = KdspNameGenerator.GetRandomGender(seed + 999);
        associate.name = pool.GetFullName(seed, gender);
        associate.isAlias = false;
        
        // 30% chance for alias instead
        if RandRange(seed + 5, 1, 100) <= 30 {
            associate.name = pool.GetAlias(seed + 10);
            associate.isAlias = true;
        }

        // Relationship type
        associate.relationship = KdspRelationshipsManager.GetAssociateRelationship(seed + 20, archetype, gangAffiliation);

        // Status
        associate.status = KdspRelationshipsManager.GetAssociateStatus(seed + 30);

        // Affiliation
        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") && RandRange(seed + 40, 1, 100) <= 70 {
            associate.affiliation = gangAffiliation;
        } else {
            associate.affiliation = KdspRelationshipsManager.GetRandomAffiliation(seed + 50, archetype);
        }

        return associate;
    }

    private static func GetAssociateRelationship(seed: Int32, archetype: String, gangAffiliation: String) -> String {
        let isGang = !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "");
        
        if isGang {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S0"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T0"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T1"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T2"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T3"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T4"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T5"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T6"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T7"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T8"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S1"); }
            return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T9");
        }

        // Universal relationships (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T10"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T11"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T12"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-16"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T13"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T292"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T14"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T2"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-GangManager-T35"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T15"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T16"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T17"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T18"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T19"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-ConnCtx-4"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T20"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S2"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T21"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T17"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S3");
    }

    private static func GetAssociateStatus(seed: Int32) -> String {
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T42"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T42"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T42"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S4"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S5"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T22") + IntToString(RandRange(seed + 5, 2070, 2077)) + ")"; }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T23"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T24"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T25"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T26"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T27"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T28"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T29"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T30"); }
        return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14");
    }

    private static func GetRandomAffiliation(seed: Int32, archetype: String) -> String {
        let i = RandRange(seed, 0, 11);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-Affiliation"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-Affiliation"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T31"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T32"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T33"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T34"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T19"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T35"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T290"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T36"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T37");
    }

    // ══════════════════════════════════════════════════════════════════════
    // FAMILY GENERATION
    // ══════════════════════════════════════════════════════════════════════

    private static func GetFamilyCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 1); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 2, 5); }
        return RandRange(seed, 0, 4);
    }

    private static func GenerateFamilyMember(seed: Int32, archetype: String, familyLastName: String, pool: ref<KdspNamePool>) -> ref<KdspFamilyMemberInfo> {
        let family: ref<KdspFamilyMemberInfo> = new KdspFamilyMemberInfo();

        // Relation type via roll - no array needed
        family.relation = KdspRelationshipsManager.GetFamilyRelationType(seed);
        
        // Determine gender based on relation
        let gender = "male";
        if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U0")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U0")) || 
           Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U1")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C65")) {
            gender = "female";
        } else if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U2")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U1")) || 
                  Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U3")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C68")) {
            gender = "male";
        } else if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C66")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C67")) ||
                  Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C1")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C64")) {
            gender = KdspNameGenerator.GetRandomGender(seed + 5);
        } else if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U4")) {
            gender = "female";
        } else if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U5")) {
            gender = "male";
        } else if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-U17")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U6")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U7")) {
            gender = KdspNameGenerator.GetRandomGender(seed + 5);
        }
        
        // First name from pool
        let firstName = pool.GetFirstName(seed + 10, gender);
        
        // Blood relatives share the family last name
        if KdspRelationshipsManager.IsBloodRelative(family.relation) {
            family.name = firstName + " " + familyLastName;
        } else if Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-U17")) || Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C1")) || 
                  Equals(family.relation, GetLocalizedTextByKey(n"Kdsp-Shared-C64")) {
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
        if roll <= 50 { family.status = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-U18"); }
        else if roll <= 70 { family.status = GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T38"); }
        else if roll <= 80 { family.status = GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T39"); }
        else if roll <= 90 { family.status = GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14"); }
        else { family.status = GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T24"); }

        // Location (only for living family)
        family.location = "";
        if Equals(family.status, GetLocalizedTextByKey(n"Kdsp-BackstoryManag-U18")) {
            family.location = KdspRelationshipsManager.GetFamilyLocation(seed + 30);
        }

        return family;
    }

    private static func GetFamilyRelationType(seed: Int32) -> String {
        let diverse = KdspSettings.DiverseRelationshipsEnabled();
        let maxRoll = 11;
        if diverse { maxRoll = 18; }
        
        let roll = RandRange(seed, 1, maxRoll);
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U0"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U2"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U0"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U1"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-U17"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U6"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U1"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U3"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U4"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U5"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U7"); }
        // Diverse options
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-Shared-C65"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-Shared-C68"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-Shared-C1"); }
        if roll == 15 { return GetLocalizedTextByKey(n"Kdsp-Shared-C66"); }
        if roll == 16 { return GetLocalizedTextByKey(n"Kdsp-Shared-C64"); }
        if roll == 17 { return GetLocalizedTextByKey(n"Kdsp-Shared-C67"); }
        return GetLocalizedTextByKey(n"Kdsp-Shared-C63");
    }

    private static func IsBloodRelative(relation: String) -> Bool {
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U0")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U2")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U0")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-MoxesProfile-U1")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U1")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U3")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U6")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-Shared-C66")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-Shared-C65")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-Shared-C68")) { return true; }
        if Equals(relation, GetLocalizedTextByKey(n"Kdsp-Shared-C63")) { return true; }
        return false;
    }

    private static func GetFamilyLocation(seed: Int32) -> String {
        let i = RandRange(seed, 0, 11);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T33"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T33"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T33"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T40"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T41"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T42"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T43"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T44"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T45"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T524"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S6"); }
        return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14");
    }

    // ══════════════════════════════════════════════════════════════════════
    // ENEMY GENERATION
    // ══════════════════════════════════════════════════════════════════════

    private static func GetEnemyCount(seed: Int32, archetype: String) -> Int32 {
        let chance = KdspRelationshipsManager.GetEnemyChance(archetype);
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

    private static func GenerateEnemy(seed: Int32, archetype: String, gangAffiliation: String, pool: ref<KdspNamePool>) -> ref<KdspEnemyInfo> {
        let enemy: ref<KdspEnemyInfo> = new KdspEnemyInfo();

        // Name from pool or alias
        let gender = KdspNameGenerator.GetRandomGender(seed + 3);
        enemy.name = pool.GetFullName(seed, gender);
        
        // 40% chance for alias instead
        if RandRange(seed + 5, 1, 100) <= 40 {
            enemy.name = pool.GetAlias(seed + 10);
        }

        // Reason for enmity
        enemy.reason = KdspRelationshipsManager.GetEnemyReason(seed + 20);

        // Threat level
        let roll = RandRange(seed + 30, 1, 100);
        if roll <= 30 { enemy.threatLevel = GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T46"); }
        else if roll <= 70 { enemy.threatLevel = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T35"); }
        else if roll <= 90 { enemy.threatLevel = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T36"); }
        else { enemy.threatLevel = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T37"); }

        return enemy;
    }

    private static func GetEnemyReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T47"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T48"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T49"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T50"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T51"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T52"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T53"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T54"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T55"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T56"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S7"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T57"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T58"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S8"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T59");
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

    private static func GenerateProfessionalContact(seed: Int32, archetype: String, pool: ref<KdspNamePool>) -> ref<KdspProfessionalContactInfo> {
        let contact: ref<KdspProfessionalContactInfo> = new KdspProfessionalContactInfo();

        let gender = KdspNameGenerator.GetRandomGender(seed + 999);
        contact.name = pool.GetFullName(seed, gender);

        // Type based on archetype
        contact.type = KdspRelationshipsManager.GetProfessionalContactType(seed + 10, archetype);
        
        if RandRange(seed + 20, 1, 100) <= 50 {
            contact.frequency = GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T60");
        } else {
            contact.frequency = GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T61");
        }

        return contact;
    }

    private static func GetProfessionalContactType(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T62"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T63"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T64"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T65"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T66"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T67"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T68"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T69"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T70"); }
            return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T71");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T72"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T73"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-MaelstromProfi-T2"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T51"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T74"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-ScavengersProf-T6"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S9"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T75"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T76"); }
            return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T77");
        }
        
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T78"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T79"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T80"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T81"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T82"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T83");
    }

    // ══════════════════════════════════════════════════════════════════════
    // STATUS / MISC - All use roll-based selection, no arrays
    // ══════════════════════════════════════════════════════════════════════

    private static func GetRomanticHistory(seed: Int32, archetype: String) -> String {
        let diverse = KdspSettings.DiverseRelationshipsEnabled();
        let maxRoll = 9;
        if diverse { maxRoll = 15; }
        
        let roll = RandRange(seed, 1, maxRoll);
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S10"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S11"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S12"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S13"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S14"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T84"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T85"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S15"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S16"); }
        // Diverse options
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S17"); }
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S18"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S19"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S20"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S21"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S22");
    }

    private static func GetRelationshipStatus(seed: Int32, archetype: String) -> String {
        let diverse = KdspSettings.DiverseRelationshipsEnabled();
        let maxRoll = 10;
        if diverse { maxRoll = 15; }
        
        let roll = RandRange(seed, 1, maxRoll);
        if roll == 1 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T43"); }
        if roll == 2 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T43"); }
        if roll == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T86"); }
        if roll == 4 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T32"); }
        if roll == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T87"); }
        if roll == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T88"); }
        if roll == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T89"); }
        if roll == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T84"); }
        if roll == 9 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T90"); }
        if roll == 10 { return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14"); }
        // Diverse options
        if roll == 11 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T91"); }
        if roll == 12 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T92"); }
        if roll == 13 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T93"); }
        if roll == 14 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T94"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S23");
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
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-U17"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T95"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T529"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T96"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T97"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T98"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-U6"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T11"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T99"); }
        return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T292");
    }

    private static func CalculateSocialNetworkSize(relations: ref<KdspRelationshipsData>, archetype: String) -> String {
        let total = ArraySize(relations.knownAssociates) + ArraySize(relations.familyMembers) + 
                   ArraySize(relations.professionalContacts) + relations.dependents;

        if total >= 10 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T100") + IntToString(total) + GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T101"); }
        if total >= 5 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T102") + IntToString(total) + GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T103"); }
        if total >= 2 { return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T104") + IntToString(total) + GetLocalizedTextByKey(n"Kdsp-RelationshipsM-T103"); }
        return GetLocalizedTextByKey(n"Kdsp-RelationshipsM-S24");
    }
}

// ══════════════════════════════════════════════════════════════════════
// DATA CLASSES
// ══════════════════════════════════════════════════════════════════════

public class KdspRelationshipsData {
    public let knownAssociates: array<ref<KdspAssociateInfo>>;
    public let familyMembers: array<ref<KdspFamilyMemberInfo>>;
    public let romanticHistory: String;
    public let currentRelationshipStatus: String;
    public let dependents: Int32;
    public let emergencyContact: String;
    public let knownEnemies: array<ref<KdspEnemyInfo>>;
    public let professionalContacts: array<ref<KdspProfessionalContactInfo>>;
    public let socialNetworkSize: String;
}

public class KdspAssociateInfo {
    public let name: String;
    public let isAlias: Bool;
    public let relationship: String;
    public let status: String;
    public let affiliation: String;
}

public class KdspFamilyMemberInfo {
    public let name: String;
    public let relation: String;
    public let status: String;
    public let location: String;
}

public class KdspEnemyInfo {
    public let name: String;
    public let reason: String;
    public let threatLevel: String;
}

public class KdspProfessionalContactInfo {
    public let name: String;
    public let type: String;
    public let frequency: String;
}
