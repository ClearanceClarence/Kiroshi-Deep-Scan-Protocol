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
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S0"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S1"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S2"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S3"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S4"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S5"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S6"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S7"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S8"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S9"));
        
        let bgIndex = RandRange(seed, 0, ArraySize(backgrounds) - 1);
        backstoryUI.background = backgrounds[bgIndex];
        
        // === EARLY LIFE (Family/Daily Life) ===
        let earlyLifeEvents: array<String>;
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S10"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S11"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S12"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S13"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S14"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S15"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S16"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S17"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S18"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S19"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S20"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S21"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S22"));
        ArrayPush(earlyLifeEvents, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S23"));
        
        let elIndex = RandRange(seed + 100, 0, ArraySize(earlyLifeEvents) - 1);
        backstoryUI.earlyLife = earlyLifeEvents[elIndex];
        
        // === SIGNIFICANT EVENTS (Recent Activities) ===
        let events: array<String>;
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S24"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S25"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S26"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S27"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S28"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S29"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S30"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S31"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S32"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S33"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S34"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S35"));
        
        let evIndex = RandRange(seed + 200, 0, ArraySize(events) - 1);
        backstoryUI.significantEvents = events[evIndex];
        
        // === RESTRICTED DATA FOR MINORS ===
        // Children have limited/protected records in adult databases
        backstoryUI.criminalRecord = "";  // No criminal record for minors
        backstoryUI.cyberwareStatus = GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S36");
        backstoryUI.financialStatus = GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S37");
        backstoryUI.medicalStatus = GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S38");
        backstoryUI.threatAssessment = GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S39");
        backstoryUI.gangAffiliation = "";  // No gang data for minors
        backstoryUI.rareFlag = "";
        backstoryUI.ncpdOfficer = "";
        
        // Family relationships for minors
        let familyTypes: array<String>;
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S40"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S41"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S42"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S43"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S44"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S45"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S46"));
        ArrayPush(familyTypes, GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S47"));
        
        let famIndex = RandRange(seed + 300, 0, ArraySize(familyTypes) - 1);
        backstoryUI.relationships = familyTypes[famIndex] + GetLocalizedTextByKey(n"Kdsp-ChildBackstory-S48");
        
        return backstoryUI;
    }


}
