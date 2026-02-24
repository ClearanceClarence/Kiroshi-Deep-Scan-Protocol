// Kiroshi Deep Scan - Child NPC Backstory Generator
// Age-appropriate content for child NPCs

public abstract class KdspChildBackstoryGenerator {

    public static func IsChildNPC(appearanceName: String) -> Bool {
        let lowerName = StrLower(appearanceName);
        
        // Common child appearance indicators in CP2077
        // Be specific to avoid false positives on young adults
        if StrContains(lowerName, "child") { return true; };
        if StrContains(lowerName, "_kid_") { return true; };
        if StrContains(lowerName, "_kid") && !StrContains(lowerName, "street_kid") { return true; };
        if StrContains(lowerName, "kid_") && !StrContains(lowerName, "street_kid") { return true; };
        if StrContains(lowerName, "_boy_") { return true; };
        if StrContains(lowerName, "_girl_") { return true; };
        if StrContains(lowerName, "juvenile") { return true; };
        if StrContains(lowerName, "urchin") { return true; };
        
        // Removed: "young_", "_young" - too broad, matches young adults
        // Removed: "teen" - could match "canteen", "fourteen", adult young NPCs
        // Removed: "minor" - could match "miner", other words
        // Removed: "street_kid" - this is a lifepath, not age indicator
        
        return false;
    }

    // Generate age-appropriate backstory for child NPCs
    public static func GenerateChildBackstory(seed: Int32, lifePath: ref<KdspLifePath>) -> KdspBackstoryUI {
        let backstoryUI: KdspBackstoryUI;
        
        // === BACKGROUND (School/Living Situation) ===
        let backgrounds: array<String>;
        ArrayPush(backgrounds, "Currently enrolled in public school. ");
        ArrayPush(backgrounds, "Attends a corporate-sponsored academy. ");
        ArrayPush(backgrounds, "Homeschooled via braindance tutorials. ");
        ArrayPush(backgrounds, "Student at a megatower community school. ");
        ArrayPush(backgrounds, "Enrolled in Night City Youth Program. ");
        ArrayPush(backgrounds, "Attends school in Pacifica district. ");
        ArrayPush(backgrounds, "Student at Watson Community School. ");
        ArrayPush(backgrounds, "Enrolled in Heywood Public Education. ");
        ArrayPush(backgrounds, "Attending Westbrook Junior Academy. ");
        ArrayPush(backgrounds, "Home-tutored by family. ");
        
        let bgIndex = RandRange(seed, 0, ArraySize(backgrounds) - 1);
        backstoryUI.background = backgrounds[bgIndex];
        
        // === EARLY LIFE (Family/Daily Life) ===
        let earlyLifeEvents: array<String>;
        ArrayPush(earlyLifeEvents, "Lives with family in a megatower apartment. ");
        ArrayPush(earlyLifeEvents, "Enjoys playing with neighborhood friends. ");
        ArrayPush(earlyLifeEvents, "Spends free time on braindance games. ");
        ArrayPush(earlyLifeEvents, "Has a pet cyber-cat. ");
        ArrayPush(earlyLifeEvents, "Takes the NCART to school daily. ");
        ArrayPush(earlyLifeEvents, "Collects vintage tech toys. ");
        ArrayPush(earlyLifeEvents, "Member of a junior sports league. ");
        ArrayPush(earlyLifeEvents, "Learning to code at school. ");
        ArrayPush(earlyLifeEvents, "Helps at family's small business. ");
        ArrayPush(earlyLifeEvents, "Lives with extended family. ");
        ArrayPush(earlyLifeEvents, "Often seen at local food vendors. ");
        ArrayPush(earlyLifeEvents, "Regularly visits the local arcade. ");
        ArrayPush(earlyLifeEvents, "Member of school's tech club. ");
        ArrayPush(earlyLifeEvents, "Takes care of younger siblings. ");
        
        let elIndex = RandRange(seed + 100, 0, ArraySize(earlyLifeEvents) - 1);
        backstoryUI.earlyLife = earlyLifeEvents[elIndex];
        
        // === SIGNIFICANT EVENTS (Recent Activities) ===
        let events: array<String>;
        ArrayPush(events, "Recently started a new school year. ");
        ArrayPush(events, "Won a school science fair competition. ");
        ArrayPush(events, "Made the junior hoopball team. ");
        ArrayPush(events, "Got a new braindance gaming rig. ");
        ArrayPush(events, "Family recently moved to a new district. ");
        ArrayPush(events, "Started learning martial arts. ");
        ArrayPush(events, "Joined the school robotics club. ");
        ArrayPush(events, "Participated in Youth of Night City program. ");
        ArrayPush(events, "Recently celebrated a birthday. ");
        ArrayPush(events, "Started a new hobby. ");
        ArrayPush(events, "Made a new best friend. ");
        ArrayPush(events, "Adopted a stray animal. ");
        
        let evIndex = RandRange(seed + 200, 0, ArraySize(events) - 1);
        backstoryUI.significantEvents = events[evIndex];
        
        // === RESTRICTED DATA FOR MINORS ===
        // Children have limited/protected records in adult databases
        backstoryUI.criminalRecord = "";  // No criminal record for minors
        backstoryUI.cyberwareStatus = "MINOR - Registry data restricted";
        backstoryUI.financialStatus = "DEPENDENT - No independent credit history";
        backstoryUI.medicalStatus = "Pediatric records sealed | Status: Protected";
        backstoryUI.threatAssessment = "Level: NONE (0/100) | Classification: MINOR - Protected";
        backstoryUI.gangAffiliation = "";  // No gang data for minors
        backstoryUI.rareFlag = "";
        backstoryUI.ncpdOfficer = "";
        
        // Family relationships for minors
        let familyTypes: array<String>;
        ArrayPush(familyTypes, "Lives with parents");
        ArrayPush(familyTypes, "Lives with mother");
        ArrayPush(familyTypes, "Lives with father");
        ArrayPush(familyTypes, "Lives with grandparents");
        ArrayPush(familyTypes, "Lives with guardian");
        ArrayPush(familyTypes, "Lives with extended family");
        ArrayPush(familyTypes, "In foster care system");
        ArrayPush(familyTypes, "Lives in group home");
        
        let famIndex = RandRange(seed + 300, 0, ArraySize(familyTypes) - 1);
        backstoryUI.relationships = familyTypes[famIndex] + " | Status: MINOR - Data Protected";
        
        return backstoryUI;
    }


}
