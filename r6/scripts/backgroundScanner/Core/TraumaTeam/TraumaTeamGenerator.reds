// Kiroshi Deep Scan - Trauma Team Profile Generator
// Dedicated military-medical profiles for TTI operatives

public abstract class KdspTraumaTeamGenerator {

    public static func GenerateTTBackground(seed: Int32) -> String {
        let backgrounds: array<String>;
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S0"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S1"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S2"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S3"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S4"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S5"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S6"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S7"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S8"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S9"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S10"));
        ArrayPush(backgrounds, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S11"));
        return backgrounds[RandRange(seed + 100, 0, ArraySize(backgrounds) - 1)];
    }

    public static func GenerateTTEarlyLife(seed: Int32) -> String {
        let events: array<String>;
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S12"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S13"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S14"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S15"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S16"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S17"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S18"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S19"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S20"));
        ArrayPush(events, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S21"));
        return events[RandRange(seed + 200, 0, ArraySize(events) - 1)];
    }

    public static func GenerateTTRecentActivity(seed: Int32) -> String {
        let activities: array<String>;
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S22"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S23"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S24"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S25"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S26"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S27"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S28"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S29"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S30"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S31"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S32"));
        ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S33"));
        return activities[RandRange(seed + 300, 0, ArraySize(activities) - 1)];
    }

    // Trauma Team service record (replaces criminal record)
    public static func GenerateTTServiceRecord(seed: Int32) -> String {
        let r = RandRange(seed, 0, 9);
        let years = RandRange(seed + 50, 2, 18);
        let extractions = RandRange(seed + 51, 30, 800);
        let successRate = RandRange(seed + 52, 87, 99);
        let result = GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S34") + IntToString(years) + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S35") + IntToString(extractions) + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S36") + IntToString(successRate) + "%";

        // Commendations or disciplinary
        if r <= 4 {
            let commRoll = RandRange(seed + 60, 0, 5);
            if commRoll == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S37"); }
            else if commRoll == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S38"); }
            else if commRoll == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S39"); }
            else if commRoll == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S40"); }
            else if commRoll == 4 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S41"); }
            else { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S42"); }
        } else if r <= 6 {
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S43");
        } else if r == 7 {
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S44");
        } else if r == 8 {
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S45");
        } else {
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S46");
        }

        return result;
    }

    // Trauma Team financial profile
    public static func GenerateTTFinancial(seed: Int32) -> String {
        let rankRoll = RandRange(seed, 0, 9);
        let rank: String;
        let salary: String;
        if rankRoll <= 2 { rank = "Operative"; salary = "65,000-85,000"; }
        else if rankRoll <= 5 { rank = "Senior Operative"; salary = "90,000-120,000"; }
        else if rankRoll <= 7 { rank = "Team Leader"; salary = "130,000-180,000"; }
        else if rankRoll == 8 { rank = "Flight Medic"; salary = "95,000-140,000"; }
        else { rank = "Tactical Specialist"; salary = "110,000-160,000"; }

        let result = GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S47") + rank + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S48") + salary + "/yr";

        // Benefits
        let benefitRoll = RandRange(seed + 70, 0, 4);
        if benefitRoll == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S49"); }
        else if benefitRoll == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S50"); }
        else if benefitRoll == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S51"); }
        else if benefitRoll == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S52"); }
        else { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S53"); }

        return result;
    }

    // Trauma Team medical readiness
    public static func GenerateTTMedical(seed: Int32) -> String {
        let bloodRoll = RandRange(seed, 0, 7);
        let blood: String;
        if bloodRoll == 0 { blood = "O RhD+"; }
        else if bloodRoll == 1 { blood = "O RhD-"; }
        else if bloodRoll == 2 { blood = "A RhD+"; }
        else if bloodRoll == 3 { blood = "A RhD-"; }
        else if bloodRoll == 4 { blood = "B RhD+"; }
        else if bloodRoll == 5 { blood = "B RhD-"; }
        else if bloodRoll == 6 { blood = "AB RhD+"; }
        else { blood = "AB RhD-"; }

        let fitnessRoll = RandRange(seed + 10, 0, 9);
        let fitness: String;
        if fitnessRoll <= 5 { fitness = "COMBAT READY"; }
        else if fitnessRoll <= 7 { fitness = "FIT FOR DUTY"; }
        else if fitnessRoll == 8 { fitness = GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S54"); }
        else { fitness = GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S55"); }

        let result = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S95") + blood + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S56") + fitness + " | TT: EMPLOYEE COVERAGE";

        // Combat injuries
        let injuryRoll = RandRange(seed + 20, 0, 9);
        if injuryRoll <= 3 {
            // No significant injuries
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S57");
        } else if injuryRoll <= 6 {
            let injType = RandRange(seed + 21, 0, 4);
            if injType == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S58"); }
            else if injType == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S59"); }
            else if injType == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S60"); }
            else if injType == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S61"); }
            else { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S62"); }
        } else {
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S63");
        }

        return result;
    }

    // Trauma Team tactical assessment
    public static func GenerateTTThreatAssessment(seed: Int32) -> String {
        let roleRoll = RandRange(seed, 0, 7);
        let role: String;
        if roleRoll <= 1 { role = "Pointman"; }
        else if roleRoll <= 3 { role = "Combat Medic"; }
        else if roleRoll == 4 { role = "Marksman"; }
        else if roleRoll == 5 { role = "Breacher"; }
        else if roleRoll == 6 { role = "AV Gunner"; }
        else { role = "Team Leader"; }

        let result = GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S64") + role + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S65");

        let combatRoll = RandRange(seed + 10, 0, 4);
        if combatRoll == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S66"); }
        else if combatRoll == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S67"); }
        else if combatRoll == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S68"); }
        else if combatRoll == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S69"); }
        else { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S70"); }

        // Engagement stats on some
        let engRoll = RandRange(seed + 20, 0, 9);
        if engRoll <= 5 {
            let engagements = RandRange(seed + 21, 5, 120);
            result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S71") + IntToString(engagements);
        }

        return result;
    }

    // Trauma Team cyberware profile
    public static func GenerateTTCyberware(seed: Int32) -> String {
        let implantCount = RandRange(seed, 5, 12);
        let result = GetLocalizedTextByKey(n"Kdsp-BackstoryManag-S90") + IntToString(implantCount) + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S72");

        let loadoutRoll = RandRange(seed + 10, 0, 5);
        if loadoutRoll == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S73"); }
        else if loadoutRoll == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S74"); }
        else if loadoutRoll == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S75"); }
        else if loadoutRoll == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S76"); }
        else if loadoutRoll == 4 { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S77"); }
        else { result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S78"); }

        result = result + GetLocalizedTextByKey(n"Kdsp-TraumaTeamGene-S79");
        return result;
    }

    // ══════════════════════════════════════════════════════════════
    // PERSONAL DATA LEAKS - Surveillance State Quirks
    // The kind of embarrassing personal data a corpo surveillance
    // state would collect on its citizens. Adds humanity and humor.
    // ══════════════════════════════════════════════════════════════

}
