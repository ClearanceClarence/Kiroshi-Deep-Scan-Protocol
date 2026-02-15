// Coherence Profile System
// Generates a unified "life theme" that influences all other generators
// Ensures criminal records match medical history, finances match lifestyle, etc.

public class KdspCoherenceProfile {
    // Life circumstances
    public let lifeTheme: String;           // STRUGGLING, STABLE, CLIMBING, FALLING, CRIMINAL, CORPORATE
    public let hasSubstanceIssues: Bool;
    public let hasViolentPast: Bool;
    public let hasTrauma: Bool;
    public let isInDebt: Bool;
    public let hasChronicHealth: Bool;
    
    // Specific flags that multiple systems should reference
    public let substanceType: String;       // "alcohol", "synth-coke", "black lace", etc.
    public let traumaType: String;          // "accident", "violence", "loss", "war"
    public let debtReason: String;          // "medical", "gambling", "failed business", "cyberware"
    public let violenceType: String;        // "gang", "domestic", "random", "self-defense"
    
    // Career coherence
    public let jobHistory: String;          // "steady", "unstable", "criminal", "corpo", "none"
    public let educationLevel: String;      // "none", "basic", "technical", "university", "corpo-academy"
    
    // Social coherence
    public let familyStatus: String;        // "intact", "estranged", "deceased", "unknown"
    public let hasChildren: Bool;
    public let relationshipPattern: String; // "stable", "chaotic", "loner", "serial"
}

public class KdspCoherenceManager {

    // Generate a coherent life profile based on archetype
    public static func Generate(seed: Int32, archetype: String, age: Int32, gangAffiliation: String) -> ref<KdspCoherenceProfile> {
        let profile = new KdspCoherenceProfile();
        
        // ══════════════════════════════════════════════════════════════
        // DETERMINE LIFE THEME BASED ON ARCHETYPE
        // ══════════════════════════════════════════════════════════════
        
        profile.lifeTheme = KdspCoherenceManager.DetermineLifeTheme(seed, archetype, gangAffiliation);
        
        // ══════════════════════════════════════════════════════════════
        // SUBSTANCE ISSUES - Coherent across medical, criminal, psych
        // ══════════════════════════════════════════════════════════════
        
        let substanceChance = KdspCoherenceManager.GetSubstanceChance(archetype, profile.lifeTheme);
        profile.hasSubstanceIssues = RandRange(seed + 100, 1, 100) <= substanceChance;
        
        if profile.hasSubstanceIssues {
            profile.substanceType = KdspCoherenceManager.GetSubstanceType(seed + 101, archetype);
        } else {
            profile.substanceType = "";
        }
        
        // ══════════════════════════════════════════════════════════════
        // VIOLENT PAST - Coherent across criminal, medical, psych
        // ══════════════════════════════════════════════════════════════
        
        let violenceChance = KdspCoherenceManager.GetViolenceChance(archetype, gangAffiliation, profile.lifeTheme);
        profile.hasViolentPast = RandRange(seed + 200, 1, 100) <= violenceChance;
        
        if profile.hasViolentPast {
            profile.violenceType = KdspCoherenceManager.GetViolenceType(seed + 201, archetype, gangAffiliation);
        } else {
            profile.violenceType = "";
        }
        
        // ══════════════════════════════════════════════════════════════
        // TRAUMA - Coherent across medical, psych, backstory
        // ══════════════════════════════════════════════════════════════
        
        let traumaChance = KdspCoherenceManager.GetTraumaChance(archetype, profile.lifeTheme, age);
        profile.hasTrauma = RandRange(seed + 300, 1, 100) <= traumaChance;
        
        if profile.hasTrauma {
            profile.traumaType = KdspCoherenceManager.GetTraumaType(seed + 301, archetype, profile.hasViolentPast);
        } else {
            profile.traumaType = "";
        }
        
        // ══════════════════════════════════════════════════════════════
        // DEBT - Coherent across financial, medical, criminal
        // ══════════════════════════════════════════════════════════════
        
        let debtChance = KdspCoherenceManager.GetDebtChance(archetype, profile.lifeTheme);
        profile.isInDebt = RandRange(seed + 400, 1, 100) <= debtChance;
        
        if profile.isInDebt {
            profile.debtReason = KdspCoherenceManager.GetDebtReason(seed + 401, archetype, profile.hasSubstanceIssues, profile.hasChronicHealth);
        } else {
            profile.debtReason = "";
        }
        
        // ══════════════════════════════════════════════════════════════
        // CHRONIC HEALTH - Coherent across medical, financial
        // ══════════════════════════════════════════════════════════════
        
        let healthChance = KdspCoherenceManager.GetChronicHealthChance(archetype, age, profile.hasSubstanceIssues);
        profile.hasChronicHealth = RandRange(seed + 500, 1, 100) <= healthChance;
        
        // ══════════════════════════════════════════════════════════════
        // CAREER & EDUCATION COHERENCE
        // ══════════════════════════════════════════════════════════════
        
        profile.jobHistory = KdspCoherenceManager.GetJobHistory(seed + 600, archetype, profile.lifeTheme);
        profile.educationLevel = KdspCoherenceManager.GetEducationLevel(seed + 610, archetype);
        
        // ══════════════════════════════════════════════════════════════
        // FAMILY & RELATIONSHIP COHERENCE
        // ══════════════════════════════════════════════════════════════
        
        profile.familyStatus = KdspCoherenceManager.GetFamilyStatus(seed + 700, archetype, profile.lifeTheme, profile.hasTrauma);
        profile.hasChildren = KdspCoherenceManager.DetermineHasChildren(seed + 710, age, archetype, profile.lifeTheme);
        profile.relationshipPattern = KdspCoherenceManager.GetRelationshipPattern(seed + 720, archetype, profile.lifeTheme, profile.hasSubstanceIssues);
        
        return profile;
    }

    // ══════════════════════════════════════════════════════════════════════
    // LIFE THEME DETERMINATION
    // ══════════════════════════════════════════════════════════════════════

    private static func DetermineLifeTheme(seed: Int32, archetype: String, gangAffiliation: String) -> String {
        // Gang members
        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "CRIMINAL"; }
            if roll <= 70 { return "STRUGGLING"; }
            if roll <= 85 { return "CLIMBING"; }
            return "FALLING";
        }
        
        // Archetype-based themes
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_EMPLOYEE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "CORPORATE"; }
            if roll <= 60 { return "CLIMBING"; }
            if roll <= 80 { return "STABLE"; }
            return "FALLING";
        }
        
        if Equals(archetype, "HOMELESS") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "FALLING"; }
            if roll <= 80 { return "STRUGGLING"; }
            return "CRIMINAL";
        }
        
        if Equals(archetype, "WEALTHY") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "STABLE"; }
            if roll <= 75 { return "CLIMBING"; }
            if roll <= 90 { return "CORPORATE"; }
            return "FALLING";
        }
        
        if Equals(archetype, "WORKER") || Equals(archetype, "SERVICE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 35 { return "STABLE"; }
            if roll <= 60 { return "STRUGGLING"; }
            if roll <= 80 { return "CLIMBING"; }
            return "FALLING";
        }
        
        // Default distribution
        let roll = RandRange(seed, 1, 100);
        if roll <= 25 { return "STABLE"; }
        if roll <= 50 { return "STRUGGLING"; }
        if roll <= 65 { return "CLIMBING"; }
        if roll <= 80 { return "FALLING"; }
        if roll <= 90 { return "CRIMINAL"; }
        return "CORPORATE";
    }

    // ══════════════════════════════════════════════════════════════════════
    // SUBSTANCE ISSUES
    // ══════════════════════════════════════════════════════════════════════

    private static func GetSubstanceChance(archetype: String, lifeTheme: String) -> Int32 {
        let base: Int32 = 15;
        
        // Theme modifiers
        if Equals(lifeTheme, "FALLING") { base += 30; }
        if Equals(lifeTheme, "STRUGGLING") { base += 15; }
        if Equals(lifeTheme, "CRIMINAL") { base += 20; }
        if Equals(lifeTheme, "CORPORATE") { base += 10; } // Stress coping
        if Equals(lifeTheme, "STABLE") { base -= 10; }
        
        // Archetype modifiers
        if Equals(archetype, "HOMELESS") { base += 25; }
        if Equals(archetype, "PARTY") { base += 20; }
        if Equals(archetype, "WEALTHY") { base += 5; } // Designer drugs
        
        if base < 5 { return 5; }
        if base > 70 { return 70; }
        return base;
    }

    private static func GetSubstanceType(seed: Int32, archetype: String) -> String {
        let roll = RandRange(seed, 1, 100);
        
        // Wealthy/corpo get different drugs
        if Equals(archetype, "WEALTHY") || Equals(archetype, "CORPO_MANAGER") {
            if roll <= 30 { return "synthetic alcohol"; }
            if roll <= 50 { return "designer stims"; }
            if roll <= 70 { return "prescription abuse"; }
            if roll <= 85 { return "synth-coke"; }
            return "exotic imports";
        }
        
        // Street level
        if roll <= 25 { return "alcohol"; }
        if roll <= 45 { return "synth-coke"; }
        if roll <= 60 { return "Black Lace"; }
        if roll <= 75 { return "Glitter"; }
        if roll <= 85 { return "cheap stims"; }
        if roll <= 95 { return "inhaler drugs"; }
        return "unknown compound";
    }

    // ══════════════════════════════════════════════════════════════════════
    // VIOLENT PAST
    // ══════════════════════════════════════════════════════════════════════

    private static func GetViolenceChance(archetype: String, gangAffiliation: String, lifeTheme: String) -> Int32 {
        let base: Int32 = 10;
        
        // Gang = high violence
        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") {
            base += 50;
        }
        
        // Theme modifiers
        if Equals(lifeTheme, "CRIMINAL") { base += 35; }
        if Equals(lifeTheme, "FALLING") { base += 15; }
        if Equals(lifeTheme, "STRUGGLING") { base += 10; }
        if Equals(lifeTheme, "CORPORATE") { base -= 5; }
        if Equals(lifeTheme, "STABLE") { base -= 5; }
        
        if base < 5 { return 5; }
        if base > 80 { return 80; }
        return base;
    }

    private static func GetViolenceType(seed: Int32, archetype: String, gangAffiliation: String) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if !Equals(gangAffiliation, "NONE") && !Equals(gangAffiliation, "") {
            if roll <= 50 { return "gang"; }
            if roll <= 70 { return "territorial"; }
            if roll <= 85 { return "enforcement"; }
            return "initiation";
        }
        
        if roll <= 30 { return "self-defense"; }
        if roll <= 50 { return "random"; }
        if roll <= 65 { return "domestic"; }
        if roll <= 80 { return "bar fight"; }
        return "road rage";
    }

    // ══════════════════════════════════════════════════════════════════════
    // TRAUMA
    // ══════════════════════════════════════════════════════════════════════

    private static func GetTraumaChance(archetype: String, lifeTheme: String, age: Int32) -> Int32 {
        let base: Int32 = 20;
        
        // Age increases trauma chance (more time for bad things)
        if age > 40 { base += 15; }
        if age > 55 { base += 10; }
        
        // Theme modifiers
        if Equals(lifeTheme, "FALLING") { base += 25; }
        if Equals(lifeTheme, "CRIMINAL") { base += 20; }
        if Equals(lifeTheme, "STRUGGLING") { base += 15; }
        
        // Night City is rough
        if Equals(archetype, "HOMELESS") { base += 30; }
        
        if base > 75 { return 75; }
        return base;
    }

    private static func GetTraumaType(seed: Int32, archetype: String, hasViolentPast: Bool) -> String {
        let roll = RandRange(seed, 1, 100);
        
        // Violence history influences trauma type
        if hasViolentPast {
            if roll <= 40 { return "violence"; }
            if roll <= 60 { return "accident"; }
            if roll <= 80 { return "loss"; }
            return "war";
        }
        
        if roll <= 30 { return "loss"; }
        if roll <= 50 { return "accident"; }
        if roll <= 65 { return "violence"; }
        if roll <= 80 { return "abandonment"; }
        if roll <= 90 { return "medical"; }
        return "war";
    }

    // ══════════════════════════════════════════════════════════════════════
    // DEBT
    // ══════════════════════════════════════════════════════════════════════

    private static func GetDebtChance(archetype: String, lifeTheme: String) -> Int32 {
        let base: Int32 = 30; // Night City default
        
        if Equals(lifeTheme, "FALLING") { base += 35; }
        if Equals(lifeTheme, "STRUGGLING") { base += 25; }
        if Equals(lifeTheme, "CLIMBING") { base += 15; } // Loans for advancement
        if Equals(lifeTheme, "STABLE") { base -= 15; }
        if Equals(lifeTheme, "CORPORATE") { base -= 10; }
        
        if Equals(archetype, "HOMELESS") { base += 20; }
        if Equals(archetype, "WEALTHY") { base -= 25; }
        
        if base < 10 { return 10; }
        if base > 80 { return 80; }
        return base;
    }

    private static func GetDebtReason(seed: Int32, archetype: String, hasSubstanceIssues: Bool, hasChronicHealth: Bool) -> String {
        let roll = RandRange(seed, 1, 100);
        
        // Coherent with other issues
        if hasSubstanceIssues && roll <= 40 {
            return "substance habit";
        }
        if hasChronicHealth && roll <= 50 {
            return "medical bills";
        }
        
        if roll <= 20 { return "medical bills"; }
        if roll <= 35 { return "cyberware loans"; }
        if roll <= 50 { return "gambling"; }
        if roll <= 65 { return "failed business"; }
        if roll <= 75 { return "education loans"; }
        if roll <= 85 { return "family support"; }
        return "living expenses";
    }

    // ══════════════════════════════════════════════════════════════════════
    // CHRONIC HEALTH
    // ══════════════════════════════════════════════════════════════════════

    private static func GetChronicHealthChance(archetype: String, age: Int32, hasSubstanceIssues: Bool) -> Int32 {
        let base: Int32 = 15;
        
        // Age is primary factor
        if age > 35 { base += 10; }
        if age > 45 { base += 15; }
        if age > 55 { base += 20; }
        
        // Substance abuse causes health issues
        if hasSubstanceIssues { base += 20; }
        
        // Archetype modifiers
        if Equals(archetype, "HOMELESS") { base += 25; }
        if Equals(archetype, "WORKER") { base += 10; } // Hard labor
        if Equals(archetype, "WEALTHY") { base -= 10; } // Better healthcare
        
        if base > 70 { return 70; }
        return base;
    }

    // ══════════════════════════════════════════════════════════════════════
    // JOB HISTORY
    // ══════════════════════════════════════════════════════════════════════

    private static func GetJobHistory(seed: Int32, archetype: String, lifeTheme: String) -> String {
        if Equals(lifeTheme, "CRIMINAL") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 60 { return "criminal"; }
            if roll <= 80 { return "unstable"; }
            return "none";
        }
        
        if Equals(lifeTheme, "CORPORATE") {
            return "corpo";
        }
        
        if Equals(lifeTheme, "STABLE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 70 { return "steady"; }
            return "corpo";
        }
        
        if Equals(lifeTheme, "FALLING") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "unstable"; }
            if roll <= 80 { return "criminal"; }
            return "none";
        }
        
        if Equals(archetype, "HOMELESS") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 60 { return "none"; }
            return "unstable";
        }
        
        // Default
        let roll = RandRange(seed, 1, 100);
        if roll <= 40 { return "steady"; }
        if roll <= 70 { return "unstable"; }
        if roll <= 85 { return "criminal"; }
        return "none";
    }

    // ══════════════════════════════════════════════════════════════════════
    // EDUCATION
    // ══════════════════════════════════════════════════════════════════════

    private static func GetEducationLevel(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 60 { return "corpo-academy"; }
            return "university";
        }
        
        if Equals(archetype, "CORPO_EMPLOYEE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 30 { return "corpo-academy"; }
            if roll <= 70 { return "university"; }
            return "technical";
        }
        
        if Equals(archetype, "HOMELESS") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "none"; }
            if roll <= 80 { return "basic"; }
            return "technical";
        }
        
        if Equals(archetype, "WEALTHY") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "university"; }
            if roll <= 80 { return "corpo-academy"; }
            return "technical";
        }
        
        // Default Night City education
        let roll = RandRange(seed, 1, 100);
        if roll <= 20 { return "none"; }
        if roll <= 55 { return "basic"; }
        if roll <= 80 { return "technical"; }
        if roll <= 95 { return "university"; }
        return "corpo-academy";
    }

    // ══════════════════════════════════════════════════════════════════════
    // FAMILY STATUS
    // ══════════════════════════════════════════════════════════════════════

    private static func GetFamilyStatus(seed: Int32, archetype: String, lifeTheme: String, hasTrauma: Bool) -> String {
        // Trauma often involves family loss
        if hasTrauma {
            let roll = RandRange(seed, 1, 100);
            if roll <= 30 { return "deceased"; }
            if roll <= 60 { return "estranged"; }
            if roll <= 80 { return "intact"; }
            return "unknown";
        }
        
        if Equals(lifeTheme, "STABLE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 60 { return "intact"; }
            if roll <= 85 { return "estranged"; }
            return "deceased";
        }
        
        if Equals(lifeTheme, "FALLING") || Equals(lifeTheme, "CRIMINAL") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 25 { return "intact"; }
            if roll <= 55 { return "estranged"; }
            if roll <= 80 { return "deceased"; }
            return "unknown";
        }
        
        // Default
        let roll = RandRange(seed, 1, 100);
        if roll <= 35 { return "intact"; }
        if roll <= 60 { return "estranged"; }
        if roll <= 85 { return "deceased"; }
        return "unknown";
    }

    // ══════════════════════════════════════════════════════════════════════
    // CHILDREN
    // ══════════════════════════════════════════════════════════════════════

    private static func DetermineHasChildren(seed: Int32, age: Int32, archetype: String, lifeTheme: String) -> Bool {
        // Too young
        if age < 22 { return false; }
        
        let chance: Int32 = 20;
        
        // Age increases chance
        if age > 28 { chance += 15; }
        if age > 35 { chance += 15; }
        if age > 45 { chance += 10; }
        
        // Life theme
        if Equals(lifeTheme, "STABLE") { chance += 20; }
        if Equals(lifeTheme, "CRIMINAL") { chance -= 10; }
        if Equals(lifeTheme, "FALLING") { chance -= 5; }
        
        return RandRange(seed, 1, 100) <= chance;
    }

    // ══════════════════════════════════════════════════════════════════════
    // RELATIONSHIP PATTERN
    // ══════════════════════════════════════════════════════════════════════

    private static func GetRelationshipPattern(seed: Int32, archetype: String, lifeTheme: String, hasSubstanceIssues: Bool) -> String {
        // Substance issues affect relationships
        if hasSubstanceIssues {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "chaotic"; }
            if roll <= 75 { return "loner"; }
            return "serial";
        }
        
        if Equals(lifeTheme, "STABLE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 60 { return "stable"; }
            if roll <= 85 { return "serial"; }
            return "loner";
        }
        
        if Equals(lifeTheme, "CRIMINAL") || Equals(lifeTheme, "FALLING") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 35 { return "chaotic"; }
            if roll <= 60 { return "loner"; }
            if roll <= 85 { return "serial"; }
            return "stable";
        }
        
        // Default
        let roll = RandRange(seed, 1, 100);
        if roll <= 30 { return "stable"; }
        if roll <= 55 { return "serial"; }
        if roll <= 75 { return "loner"; }
        return "chaotic";
    }
}
