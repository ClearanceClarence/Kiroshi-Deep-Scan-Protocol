// Criminal Record Generation System
public class KdspCriminalRecordManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String, gangAffil: String) -> ref<KdspCriminalRecordData> {
        return KdspCriminalRecordManager.GenerateCoherent(seed, archetype, gangAffil, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, gangAffil: String, coherence: ref<KdspCoherenceProfile>) -> ref<KdspCriminalRecordData> {
        let record: ref<KdspCriminalRecordData> = new KdspCriminalRecordData();
        
        // Determine if they have a criminal record - influenced by coherence
        let hasCriminalRecord = KdspCriminalRecordManager.HasCriminalRecordCoherent(seed, archetype, coherence);
        record.hasRecord = hasCriminalRecord;

        if !hasCriminalRecord {
            record.status = "NO CRIMINAL RECORD";
            record.warrantStatus = "NONE";
            return record;
        }

        // Generate criminal status - influenced by violence/substance flags
        record.status = KdspCriminalRecordManager.GenerateStatusCoherent(seed, archetype, coherence);
        record.warrantStatus = KdspCriminalRecordManager.GenerateWarrantStatus(seed + 100, archetype);
        
        // Generate arrests - coherent with life theme, limited by density
        let arrestCount = KdspCriminalRecordManager.GetArrestCountCoherent(seed + 200, archetype, coherence);
        arrestCount = KdspSettings.GetMaxListItems(arrestCount);
        
        let i = 0;
        while i < arrestCount {
            ArrayPush(record.arrests, KdspCriminalRecordManager.GenerateArrestCoherent(seed + (i * 77), archetype, gangAffil, coherence));
            i += 1;
        }

        // Generate convictions - limited by density
        let convictionCount = RandRange(seed + 300, 0, arrestCount);
        convictionCount = KdspSettings.GetMaxListItems(convictionCount);
        
        i = 0;
        while i < convictionCount {
            ArrayPush(record.convictions, KdspCriminalRecordManager.GenerateConviction(seed + (i * 88), archetype));
            i += 1;
        }

        // Gang affiliation details
        if !Equals(gangAffil, "NONE") && !Equals(gangAffil, "") {
            record.gangAffiliation = gangAffil;
            record.gangRank = KdspCriminalRecordManager.GenerateGangRank(seed + 400, archetype);
            record.gangStatus = KdspCriminalRecordManager.GenerateGangStatus(seed + 500);
        }

        // NCPD threat classification
        record.ncpdClassification = KdspCriminalRecordManager.GenerateNCPDClassification(seed + 600, archetype, ArraySize(record.arrests));

        return record;
    }

    private static func HasCriminalRecordCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Bool {
        let chance: Int32;
        
        if Equals(archetype, "CORPO_MANAGER") { chance = 5; }
        else if Equals(archetype, "CORPO_DRONE") { chance = 10; }
        else if Equals(archetype, "YUPPIE") { chance = 15; }
        else if Equals(archetype, "CIVVIE") { chance = 30; }
        else if Equals(archetype, "NOMAD") { chance = 45; }
        else if Equals(archetype, "LOWLIFE") { chance = 70; }
        else if Equals(archetype, "GANGER") { chance = 95; }
        else if Equals(archetype, "JUNKIE") { chance = 80; }
        else if Equals(archetype, "HOMELESS") { chance = 50; }
        else { chance = 35; }

        // Coherence modifiers
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "CRIMINAL") { chance += 40; }
            if Equals(coherence.lifeTheme, "FALLING") { chance += 15; }
            if coherence.hasViolentPast { chance += 20; }
            if coherence.hasSubstanceIssues { chance += 15; }
            if Equals(coherence.lifeTheme, "STABLE") { chance -= 15; }
            if Equals(coherence.lifeTheme, "CORPORATE") { chance -= 10; }
        }

        if chance > 95 { chance = 95; }
        if chance < 5 { chance = 5; }

        return RandRange(seed, 1, 100) <= chance;
    }

    private static func HasCriminalRecord(seed: Int32, archetype: String) -> Bool {
        return KdspCriminalRecordManager.HasCriminalRecordCoherent(seed, archetype, null);
    }

    private static func GenerateStatusCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        // If coherence indicates violent past, weight towards violent offenses
        if IsDefined(coherence) && coherence.hasViolentPast {
            let roll = RandRange(seed, 1, 100);
            if roll <= 40 { return "VIOLENT OFFENDER"; }
            if roll <= 60 { return "FELONY RECORD"; }
            if roll <= 75 { return "REPEAT OFFENDER"; }
            if roll <= 90 { return "CURRENTLY ON PAROLE"; }
            return "AGGRAVATED ASSAULT HISTORY";
        }

        // If substance issues, weight towards drug-related
        if IsDefined(coherence) && coherence.hasSubstanceIssues {
            let roll = RandRange(seed, 1, 100);
            if roll <= 35 { return "SUBSTANCE VIOLATION HISTORY"; }
            if roll <= 55 { return "MINOR INFRACTIONS"; }
            if roll <= 70 { return "MISDEMEANOR RECORD"; }
            if roll <= 85 { return "CURRENTLY ON PAROLE"; }
            return "MANDATORY REHAB ORDERED";
        }

        return KdspCriminalRecordManager.GenerateStatus(seed, archetype);
    }

    private static func GenerateStatus(seed: Int32, archetype: String) -> String {
        // Archetype-specific statuses
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "FELONY RECORD"; }
            if i == 1 { return "VIOLENT OFFENDER"; }
            if i == 2 { return "REPEAT OFFENDER"; }
            if i == 3 { return "CURRENTLY ON PAROLE"; }
            if i == 4 { return "MULTIPLE FELONIES"; }
            if i == 5 { return "CAREER CRIMINAL"; }
            if i == 6 { return "GANG-AFFILIATED OFFENDER"; }
            if i == 7 { return "ARMED ROBBERY CONVICTIONS"; }
            if i == 8 { return "ASSAULT RECORD"; }
            if i == 9 { return "WEAPONS CHARGES"; }
            if i == 10 { return "DRUG TRAFFICKING HISTORY"; }
            if i == 11 { return "ESCAPED CUSTODY (PRIOR)"; }
            if i == 12 { return "PROBATION VIOLATION"; }
            if i == 13 { return "THREE STRIKES CANDIDATE"; }
            return "ORGANIZED CRIME TIES";
        }

        // General statuses (30 options)
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "MINOR INFRACTIONS"; }
        if i == 1 { return "MISDEMEANOR RECORD"; }
        if i == 2 { return "FELONY RECORD"; }
        if i == 3 { return "VIOLENT OFFENDER"; }
        if i == 4 { return "REPEAT OFFENDER"; }
        if i == 5 { return "CURRENTLY ON PAROLE"; }
        if i == 6 { return "PROBATIONARY STATUS"; }
        if i == 7 { return "REFORMED - RECORD SEALED"; }
        if i == 8 { return "FIRST TIME OFFENDER"; }
        if i == 9 { return "JUVENILE RECORD (SEALED)"; }
        if i == 10 { return "EXPUNGED RECORD (PARTIAL)"; }
        if i == 11 { return "WHITE COLLAR CRIMES"; }
        if i == 12 { return "PROPERTY CRIMES"; }
        if i == 13 { return "SUBSTANCE VIOLATIONS"; }
        if i == 14 { return "TRAFFIC VIOLATIONS ONLY"; }
        if i == 15 { return "CYBERCRIMES"; }
        if i == 16 { return "CORPORATE VIOLATIONS"; }
        if i == 17 { return "TAX EVASION"; }
        if i == 18 { return "FRAUD CONVICTIONS"; }
        if i == 19 { return "DOMESTIC INCIDENT HISTORY"; }
        if i == 20 { return "PUBLIC ORDER OFFENSES"; }
        if i == 21 { return "WEAPONS VIOLATIONS"; }
        if i == 22 { return "PENDING CHARGES"; }
        if i == 23 { return "CHARGES DROPPED (PRIOR)"; }
        if i == 24 { return "ACQUITTED (PRIOR TRIAL)"; }
        if i == 25 { return "PLEA BARGAIN HISTORY"; }
        if i == 26 { return "DIVERSION PROGRAM GRADUATE"; }
        if i == 27 { return "COMMUNITY SUPERVISION"; }
        if i == 28 { return "ELECTRONIC MONITORING"; }
        return "RESTRICTED MOVEMENT ORDER";
    }

    private static func GenerateWarrantStatus(seed: Int32, archetype: String) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if Equals(archetype, "GANGER") {
            if roll <= 15 { return "ACTIVE - MURDER"; }
            if roll <= 25 { return "ACTIVE - VIOLENT CRIME"; }
            if roll <= 35 { return "ACTIVE - ARMED ROBBERY"; }
            if roll <= 45 { return "ACTIVE - DRUG TRAFFICKING"; }
            if roll <= 55 { return "ACTIVE - WEAPONS CHARGES"; }
            if roll <= 65 { return "BENCH WARRANT"; }
            if roll <= 75 { return "FAILURE TO APPEAR"; }
            if roll <= 80 { return "PROBATION VIOLATION WARRANT"; }
            return "NONE";
        }
        
        // 25 warrant types total
        if roll <= 3 { return "ACTIVE - MURDER"; }
        if roll <= 6 { return "ACTIVE - VIOLENT CRIME"; }
        if roll <= 10 { return "ACTIVE - ARMED ROBBERY"; }
        if roll <= 13 { return "ACTIVE - ASSAULT"; }
        if roll <= 16 { return "ACTIVE - PROPERTY CRIME"; }
        if roll <= 19 { return "ACTIVE - DRUG CHARGES"; }
        if roll <= 22 { return "ACTIVE - WEAPONS POSSESSION"; }
        if roll <= 25 { return "ACTIVE - CYBERCRIMES"; }
        if roll <= 28 { return "ACTIVE - FRAUD"; }
        if roll <= 31 { return "ACTIVE - THEFT"; }
        if roll <= 35 { return "BENCH WARRANT"; }
        if roll <= 38 { return "FAILURE TO APPEAR"; }
        if roll <= 41 { return "PROBATION VIOLATION WARRANT"; }
        if roll <= 44 { return "PAROLE VIOLATION WARRANT"; }
        if roll <= 46 { return "MATERIAL WITNESS WARRANT"; }
        if roll <= 48 { return "CORPO EXTRADITION REQUEST"; }
        if roll <= 50 { return "NCPD DETAINER"; }
        if roll <= 52 { return "WARRANT CLEARED (2077)"; }
        if roll <= 54 { return "WARRANT CLEARED (2076)"; }
        if roll <= 56 { return "WARRANT EXPIRED"; }
        if roll <= 58 { return "WARRANT RECALLED"; }
        return "NONE";
    }

    private static func GetArrestCountCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let base = KdspCriminalRecordManager.GetArrestCount(seed, archetype);
        
        if IsDefined(coherence) {
            // Life theme modifiers
            if Equals(coherence.lifeTheme, "CRIMINAL") { base += RandRange(seed + 50, 1, 3); }
            if Equals(coherence.lifeTheme, "FALLING") { base += RandRange(seed + 51, 0, 2); }
            if coherence.hasViolentPast { base += 1; }
            if coherence.hasSubstanceIssues { base += 1; }
        }
        
        if base > 10 { return 10; }
        return base;
    }

    private static func GetArrestCount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "GANGER") { return RandRange(seed, 2, 8); }
        if Equals(archetype, "LOWLIFE") { return RandRange(seed, 1, 5); }
        if Equals(archetype, "JUNKIE") { return RandRange(seed, 1, 6); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 0, 3); }
        if Equals(archetype, "NOMAD") { return RandRange(seed, 0, 3); }
        return RandRange(seed, 1, 3);
    }

    private static func GenerateArrestCoherent(seed: Int32, archetype: String, gangAffil: String, coherence: ref<KdspCoherenceProfile>) -> String {
        let year = RandRange(seed + 1000, 2060, 2077);
        
        // If coherence gives us specific crime types, use them
        if IsDefined(coherence) {
            // Substance-related arrests
            if coherence.hasSubstanceIssues && RandRange(seed + 500, 1, 100) <= 50 {
                let substanceCrimes: array<String>;
                ArrayPush(substanceCrimes, "Illegal possession of controlled substance");
                ArrayPush(substanceCrimes, "Public intoxication");
                ArrayPush(substanceCrimes, "Possession with intent to distribute");
                ArrayPush(substanceCrimes, "DUI - cyberware impairment");
                ArrayPush(substanceCrimes, "Possession of illegal stimulants");
                
                if NotEquals(coherence.substanceType, "") {
                    ArrayPush(substanceCrimes, "Possession of " + coherence.substanceType);
                }
                
                return substanceCrimes[RandRange(seed, 0, ArraySize(substanceCrimes) - 1)] + " (" + IntToString(year) + ")";
            }
            
            // Violence-related arrests
            if coherence.hasViolentPast && RandRange(seed + 501, 1, 100) <= 60 {
                let violentCrimes: array<String>;
                ArrayPush(violentCrimes, "Assault");
                ArrayPush(violentCrimes, "Aggravated assault");
                ArrayPush(violentCrimes, "Battery");
                ArrayPush(violentCrimes, "Assault with cyberware");
                ArrayPush(violentCrimes, "Assault with deadly weapon");
                ArrayPush(violentCrimes, "Aggravated battery");
                
                if Equals(coherence.violenceType, "gang") {
                    ArrayPush(violentCrimes, "Gang-related assault");
                    ArrayPush(violentCrimes, "Drive-by shooting");
                }
                if Equals(coherence.violenceType, "domestic") {
                    ArrayPush(violentCrimes, "Domestic violence");
                    ArrayPush(violentCrimes, "Domestic assault");
                }
                if Equals(coherence.violenceType, "bar fight") {
                    ArrayPush(violentCrimes, "Brawling");
                    ArrayPush(violentCrimes, "Disorderly conduct - fighting");
                }
                
                return violentCrimes[RandRange(seed, 0, ArraySize(violentCrimes) - 1)] + " (" + IntToString(year) + ")";
            }
        }
        
        // Fall back to standard generation
        return KdspCriminalRecordManager.GenerateArrest(seed, archetype, gangAffil);
    }

    private static func GenerateArrest(seed: Int32, archetype: String, gangAffil: String) -> String {
        let year = RandRange(seed + 1000, 2060, 2077);

        // Gang-specific crimes (20% chance for gang members)
        if (!Equals(gangAffil, "NONE") && !Equals(gangAffil, "")) && RandRange(seed + 500, 1, 100) <= 40 {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Gang activity (" + IntToString(year) + ")"; }
            if i == 1 { return "Conspiracy to commit murder (" + IntToString(year) + ")"; }
            if i == 2 { return "Racketeering (" + IntToString(year) + ")"; }
            if i == 3 { return "Extortion (" + IntToString(year) + ")"; }
            if i == 4 { return "Drug trafficking (" + IntToString(year) + ")"; }
            if i == 5 { return "Drive-by shooting (" + IntToString(year) + ")"; }
            if i == 6 { return "Gang-related assault (" + IntToString(year) + ")"; }
            if i == 7 { return "Turf war violence (" + IntToString(year) + ")"; }
            if i == 8 { return "Gang initiation assault (" + IntToString(year) + ")"; }
            if i == 9 { return "Protection racket (" + IntToString(year) + ")"; }
            if i == 10 { return "Gang conspiracy (" + IntToString(year) + ")"; }
            if i == 11 { return "Witness intimidation (" + IntToString(year) + ")"; }
            if i == 12 { return "Gang-related weapons charge (" + IntToString(year) + ")"; }
            if i == 13 { return "Street racing - gang affiliated (" + IntToString(year) + ")"; }
            if i == 14 { return "Running illegal gambling (" + IntToString(year) + ")"; }
            if i == 15 { return "Fencing stolen goods (" + IntToString(year) + ")"; }
            if i == 16 { return "Human trafficking involvement (" + IntToString(year) + ")"; }
            if i == 17 { return "Contract violence (" + IntToString(year) + ")"; }
            if i == 18 { return "Gang recruitment of minors (" + IntToString(year) + ")"; }
            return "Territory marking vandalism (" + IntToString(year) + ")";
        }

        // Corpo-specific crimes
        if (Equals(archetype, "CORPO_DRONE") || Equals(archetype, "CORPO_MANAGER")) && RandRange(seed + 501, 1, 100) <= 70 {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Corporate policy violation (" + IntToString(year) + ")"; }
            if i == 1 { return "Data theft (" + IntToString(year) + ")"; }
            if i == 2 { return "Corporate espionage (" + IntToString(year) + ")"; }
            if i == 3 { return "Insider trading (" + IntToString(year) + ")"; }
            if i == 4 { return "Embezzlement (" + IntToString(year) + ")"; }
            if i == 5 { return "Securities fraud (" + IntToString(year) + ")"; }
            if i == 6 { return "Breach of NDA (" + IntToString(year) + ")"; }
            if i == 7 { return "Unauthorized data access (" + IntToString(year) + ")"; }
            if i == 8 { return "Corporate sabotage (" + IntToString(year) + ")"; }
            if i == 9 { return "Industrial espionage (" + IntToString(year) + ")"; }
            if i == 10 { return "Trade secret theft (" + IntToString(year) + ")"; }
            if i == 11 { return "Money laundering (" + IntToString(year) + ")"; }
            if i == 12 { return "Bribery of officials (" + IntToString(year) + ")"; }
            if i == 13 { return "Tax fraud (" + IntToString(year) + ")"; }
            return "Antitrust violations (" + IntToString(year) + ")";
        }

        // Junkie-specific crimes
        if Equals(archetype, "JUNKIE") && RandRange(seed + 502, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Public intoxication (" + IntToString(year) + ")"; }
            if i == 1 { return "Possession of controlled substance (" + IntToString(year) + ")"; }
            if i == 2 { return "DUI - cyberware impairment (" + IntToString(year) + ")"; }
            if i == 3 { return "Possession with intent to distribute (" + IntToString(year) + ")"; }
            if i == 4 { return "Drug paraphernalia possession (" + IntToString(year) + ")"; }
            if i == 5 { return "Theft to support habit (" + IntToString(year) + ")"; }
            if i == 6 { return "Prescription fraud (" + IntToString(year) + ")"; }
            if i == 7 { return "Possession of illegal stimulants (" + IntToString(year) + ")"; }
            if i == 8 { return "Under influence in public (" + IntToString(year) + ")"; }
            if i == 9 { return "Possession of synthetic drugs (" + IntToString(year) + ")"; }
            if i == 10 { return "Shoplifting (" + IntToString(year) + ")"; }
            if i == 11 { return "Loitering in drug area (" + IntToString(year) + ")"; }
            if i == 12 { return "Breaking into vehicle (" + IntToString(year) + ")"; }
            if i == 13 { return "Panhandling aggressively (" + IntToString(year) + ")"; }
            return "Trespassing (" + IntToString(year) + ")";
        }

        // General crimes (100 options)
        let i = RandRange(seed, 0, 99);
        
        // Minor offenses (0-19)
        if i == 0 { return "Public intoxication (" + IntToString(year) + ")"; }
        if i == 1 { return "Disorderly conduct (" + IntToString(year) + ")"; }
        if i == 2 { return "Petty theft (" + IntToString(year) + ")"; }
        if i == 3 { return "Trespassing (" + IntToString(year) + ")"; }
        if i == 4 { return "Vandalism (" + IntToString(year) + ")"; }
        if i == 5 { return "Loitering (" + IntToString(year) + ")"; }
        if i == 6 { return "Public urination (" + IntToString(year) + ")"; }
        if i == 7 { return "Noise violation (" + IntToString(year) + ")"; }
        if i == 8 { return "Open container violation (" + IntToString(year) + ")"; }
        if i == 9 { return "Jaywalking (repeat offense) (" + IntToString(year) + ")"; }
        if i == 10 { return "Fare evasion (" + IntToString(year) + ")"; }
        if i == 11 { return "Littering (" + IntToString(year) + ")"; }
        if i == 12 { return "Disturbing the peace (" + IntToString(year) + ")"; }
        if i == 13 { return "Failure to disperse (" + IntToString(year) + ")"; }
        if i == 14 { return "Curfew violation (" + IntToString(year) + ")"; }
        if i == 15 { return "Illegal street vending (" + IntToString(year) + ")"; }
        if i == 16 { return "Unlicensed busking (" + IntToString(year) + ")"; }
        if i == 17 { return "Illegal posting of bills (" + IntToString(year) + ")"; }
        if i == 18 { return "Minor in possession (" + IntToString(year) + ")"; }
        if i == 19 { return "False identification (" + IntToString(year) + ")"; }
        
        // Drug/Substance (20-29)
        if i == 20 { return "Possession of controlled substance (" + IntToString(year) + ")"; }
        if i == 21 { return "DUI - cyberware impairment (" + IntToString(year) + ")"; }
        if i == 22 { return "DUI - alcohol (" + IntToString(year) + ")"; }
        if i == 23 { return "DUI - drugs (" + IntToString(year) + ")"; }
        if i == 24 { return "Possession of illegal stimulants (" + IntToString(year) + ")"; }
        if i == 25 { return "Possession with intent (" + IntToString(year) + ")"; }
        if i == 26 { return "Drug manufacturing (" + IntToString(year) + ")"; }
        if i == 27 { return "Prescription fraud (" + IntToString(year) + ")"; }
        if i == 28 { return "Operating drug den (" + IntToString(year) + ")"; }
        if i == 29 { return "Sale of controlled substance (" + IntToString(year) + ")"; }
        
        // Theft/Property (30-44)
        if i == 30 { return "Grand theft auto (" + IntToString(year) + ")"; }
        if i == 31 { return "Breaking and entering (" + IntToString(year) + ")"; }
        if i == 32 { return "Burglary (" + IntToString(year) + ")"; }
        if i == 33 { return "Shoplifting (" + IntToString(year) + ")"; }
        if i == 34 { return "Receiving stolen property (" + IntToString(year) + ")"; }
        if i == 35 { return "Vehicle theft (" + IntToString(year) + ")"; }
        if i == 36 { return "Carjacking (" + IntToString(year) + ")"; }
        if i == 37 { return "Identity theft (" + IntToString(year) + ")"; }
        if i == 38 { return "Credit fraud (" + IntToString(year) + ")"; }
        if i == 39 { return "Pickpocketing (" + IntToString(year) + ")"; }
        if i == 40 { return "Robbery (" + IntToString(year) + ")"; }
        if i == 41 { return "Armed robbery (" + IntToString(year) + ")"; }
        if i == 42 { return "Home invasion (" + IntToString(year) + ")"; }
        if i == 43 { return "Catalytic converter theft (" + IntToString(year) + ")"; }
        if i == 44 { return "Package theft (" + IntToString(year) + ")"; }
        
        // Violence (45-59)
        if i == 45 { return "Assault (" + IntToString(year) + ")"; }
        if i == 46 { return "Battery (" + IntToString(year) + ")"; }
        if i == 47 { return "Aggravated assault (" + IntToString(year) + ")"; }
        if i == 48 { return "Assault with deadly weapon (" + IntToString(year) + ")"; }
        if i == 49 { return "Assault with cyberware (" + IntToString(year) + ")"; }
        if i == 50 { return "Domestic violence (" + IntToString(year) + ")"; }
        if i == 51 { return "Vehicular assault (" + IntToString(year) + ")"; }
        if i == 52 { return "Reckless endangerment (" + IntToString(year) + ")"; }
        if i == 53 { return "Menacing (" + IntToString(year) + ")"; }
        if i == 54 { return "Criminal threatening (" + IntToString(year) + ")"; }
        if i == 55 { return "Stalking (" + IntToString(year) + ")"; }
        if i == 56 { return "Harassment (" + IntToString(year) + ")"; }
        if i == 57 { return "Intimidation (" + IntToString(year) + ")"; }
        if i == 58 { return "Manslaughter (" + IntToString(year) + ")"; }
        if i == 59 { return "Attempted murder (" + IntToString(year) + ")"; }
        
        // Weapons (60-69)
        if i == 60 { return "Illegal weapons possession (" + IntToString(year) + ")"; }
        if i == 61 { return "Concealed weapon violation (" + IntToString(year) + ")"; }
        if i == 62 { return "Illegal discharge of firearm (" + IntToString(year) + ")"; }
        if i == 63 { return "Possession of illegal ammunition (" + IntToString(year) + ")"; }
        if i == 64 { return "Illegal weapons modification (" + IntToString(year) + ")"; }
        if i == 65 { return "Brandishing a weapon (" + IntToString(year) + ")"; }
        if i == 66 { return "Weapons trafficking (" + IntToString(year) + ")"; }
        if i == 67 { return "Possession of explosive device (" + IntToString(year) + ")"; }
        if i == 68 { return "Illegal military hardware (" + IntToString(year) + ")"; }
        if i == 69 { return "Unlicensed firearm (" + IntToString(year) + ")"; }
        
        // Cybercrimes (70-79)
        if i == 70 { return "Illegal cyberware modification (" + IntToString(year) + ")"; }
        if i == 71 { return "Data theft (" + IntToString(year) + ")"; }
        if i == 72 { return "Hacking (" + IntToString(year) + ")"; }
        if i == 73 { return "Unauthorized system access (" + IntToString(year) + ")"; }
        if i == 74 { return "Illegal braindance distribution (" + IntToString(year) + ")"; }
        if i == 75 { return "Cyberware tampering (" + IntToString(year) + ")"; }
        if i == 76 { return "Net running violation (" + IntToString(year) + ")"; }
        if i == 77 { return "Malware distribution (" + IntToString(year) + ")"; }
        if i == 78 { return "ICE breach (" + IntToString(year) + ")"; }
        if i == 79 { return "Illegal AI possession (" + IntToString(year) + ")"; }
        
        // Traffic/Vehicle (80-84)
        if i == 80 { return "Reckless driving (" + IntToString(year) + ")"; }
        if i == 81 { return "Street racing (" + IntToString(year) + ")"; }
        if i == 82 { return "Hit and run (" + IntToString(year) + ")"; }
        if i == 83 { return "Driving on suspended license (" + IntToString(year) + ")"; }
        if i == 84 { return "Evading police (" + IntToString(year) + ")"; }
        
        // Fraud/White collar (85-89)
        if i == 85 { return "Fraud (" + IntToString(year) + ")"; }
        if i == 86 { return "Forgery (" + IntToString(year) + ")"; }
        if i == 87 { return "Counterfeiting (" + IntToString(year) + ")"; }
        if i == 88 { return "Insurance fraud (" + IntToString(year) + ")"; }
        if i == 89 { return "Wire fraud (" + IntToString(year) + ")"; }
        
        // Other (90-99)
        if i == 90 { return "Resisting arrest (" + IntToString(year) + ")"; }
        if i == 91 { return "Obstruction of justice (" + IntToString(year) + ")"; }
        if i == 92 { return "False police report (" + IntToString(year) + ")"; }
        if i == 93 { return "Contempt of court (" + IntToString(year) + ")"; }
        if i == 94 { return "Bail jumping (" + IntToString(year) + ")"; }
        if i == 95 { return "Perjury (" + IntToString(year) + ")"; }
        if i == 96 { return "Prostitution (" + IntToString(year) + ")"; }
        if i == 97 { return "Solicitation (" + IntToString(year) + ")"; }
        if i == 98 { return "Illegal gambling (" + IntToString(year) + ")"; }
        return "Unlawful assembly (" + IntToString(year) + ")";
    }

    private static func GenerateConviction(seed: Int32, archetype: String) -> String {
        let i = RandRange(seed, 0, 29);
        
        // Fines (0-4)
        if i == 0 { return "Fine: €$" + IntToString(RandRange(seed, 100, 500)); }
        if i == 1 { return "Fine: €$" + IntToString(RandRange(seed, 500, 2000)); }
        if i == 2 { return "Fine: €$" + IntToString(RandRange(seed, 2000, 10000)); }
        if i == 3 { return "Fine: €$" + IntToString(RandRange(seed, 10000, 50000)); }
        if i == 4 { return "Fine: €$" + IntToString(RandRange(seed, 50000, 250000)) + " (corporate)"; }
        
        // Community service (5-7)
        if i == 5 { return "Community service: " + IntToString(RandRange(seed + 10, 20, 100)) + " hours"; }
        if i == 6 { return "Community service: " + IntToString(RandRange(seed + 10, 100, 300)) + " hours"; }
        if i == 7 { return "Community service: " + IntToString(RandRange(seed + 10, 300, 500)) + " hours"; }
        
        // Probation (8-10)
        if i == 8 { return "Probation: " + IntToString(RandRange(seed + 20, 6, 12)) + " months"; }
        if i == 9 { return "Probation: " + IntToString(RandRange(seed + 20, 12, 36)) + " months"; }
        if i == 10 { return "Probation: " + IntToString(RandRange(seed + 20, 36, 60)) + " months"; }
        
        // Detention/Prison (11-16)
        if i == 11 { return "County detention: " + IntToString(RandRange(seed + 30, 1, 6)) + " months"; }
        if i == 12 { return "County detention: " + IntToString(RandRange(seed + 30, 6, 12)) + " months"; }
        if i == 13 { return "State prison: " + IntToString(RandRange(seed + 40, 1, 3)) + " years"; }
        if i == 14 { return "State prison: " + IntToString(RandRange(seed + 40, 3, 10)) + " years"; }
        if i == 15 { return "State prison: " + IntToString(RandRange(seed + 40, 10, 25)) + " years"; }
        if i == 16 { return "Maximum security: " + IntToString(RandRange(seed + 40, 5, 15)) + " years"; }
        
        // Corporate sentences (17-19)
        if i == 17 { return "Corporate labor assignment: " + IntToString(RandRange(seed + 50, 1, 5)) + " years"; }
        if i == 18 { return "Corporate detention facility: " + IntToString(RandRange(seed + 50, 1, 3)) + " years"; }
        if i == 19 { return "Corporate debt servitude: " + IntToString(RandRange(seed + 50, 2, 10)) + " years"; }
        
        // Alternative sentences (20-24)
        if i == 20 { return "Mandatory rehabilitation program"; }
        if i == 21 { return "Electronic monitoring: " + IntToString(RandRange(seed + 60, 6, 24)) + " months"; }
        if i == 22 { return "House arrest: " + IntToString(RandRange(seed + 60, 3, 18)) + " months"; }
        if i == 23 { return "Cyberware restriction order"; }
        if i == 24 { return "Weapons prohibition - permanent"; }
        
        // Special conditions (25-29)
        if i == 25 { return "Mandatory anger management"; }
        if i == 26 { return "Substance abuse treatment"; }
        if i == 27 { return "Restitution: €$" + IntToString(RandRange(seed, 5000, 100000)); }
        if i == 28 { return "Driving privileges revoked: " + IntToString(RandRange(seed + 70, 1, 5)) + " years"; }
        return "Deferred adjudication: " + IntToString(RandRange(seed + 70, 12, 36)) + " months";
    }

    private static func GenerateGangRank(seed: Int32, archetype: String) -> String {
        // Weight towards lower ranks
        let roll = RandRange(seed, 1, 100);
        
        // Low ranks (60%)
        if roll <= 15 { return "Hanger-on"; }
        if roll <= 30 { return "Associate"; }
        if roll <= 40 { return "Prospect"; }
        if roll <= 50 { return "Runner"; }
        if roll <= 60 { return "Street Soldier"; }
        
        // Mid ranks (30%)
        if roll <= 68 { return "Soldier"; }
        if roll <= 75 { return "Enforcer"; }
        if roll <= 82 { return "Crew Chief"; }
        if roll <= 88 { return "Lieutenant"; }
        if roll <= 92 { return "Captain"; }
        
        // High ranks (10%)
        if roll <= 95 { return "Underboss"; }
        if roll <= 97 { return "Right Hand"; }
        if roll <= 99 { return "Inner Circle"; }
        return "Unknown - Classified";
    }

    private static func GenerateGangStatus(seed: Int32) -> String {
        let i = RandRange(seed, 0, 19);
        
        // Active statuses (0-7)
        if i == 0 { return "Active member"; }
        if i == 1 { return "Active - enforcer duties"; }
        if i == 2 { return "Active - drug operations"; }
        if i == 3 { return "Active - recruitment"; }
        if i == 4 { return "Active - territory patrol"; }
        if i == 5 { return "Active - collections"; }
        if i == 6 { return "Blood in - confirmed kills"; }
        if i == 7 { return "Active - inner circle access"; }
        
        // Probationary/New (8-11)
        if i == 8 { return "Recently initiated"; }
        if i == 9 { return "Probationary period"; }
        if i == 10 { return "On probation with gang"; }
        if i == 11 { return "Proving loyalty"; }
        
        // Inactive/Problem (12-15)
        if i == 12 { return "Inactive - still affiliated"; }
        if i == 13 { return "Inactive - incarcerated"; }
        if i == 14 { return "Inactive - in hiding"; }
        if i == 15 { return "Inactive - medical reasons"; }
        
        // High risk (16-19)
        if i == 16 { return "Seeking to leave (HIGH RISK)"; }
        if i == 17 { return "Suspected snitch"; }
        if i == 18 { return "In bad standing"; }
        return "Informant status - CLASSIFIED";
    }

    private static func GenerateNCPDClassification(seed: Int32, archetype: String, arrestCount: Int32) -> String {
        let baseScore = arrestCount * 10;
        
        if Equals(archetype, "GANGER") { baseScore += 40; }
        else if Equals(archetype, "LOWLIFE") { baseScore += 20; }
        else if Equals(archetype, "JUNKIE") { baseScore += 15; }
        else if Equals(archetype, "NOMAD") { baseScore += 10; }
        
        baseScore += RandRange(seed, -10, 20);

        // 20 classification options based on score
        if baseScore >= 100 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return "SHOOT ON SIGHT"; }
            if i == 1 { return "MAXIMUM THREAT - MAXTAC"; }
            if i == 2 { return "CYBERPSYCHO WATCH LIST"; }
            return "PRIORITY ELIMINATION TARGET";
        }
        if baseScore >= 80 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return "HIGH PRIORITY TARGET"; }
            if i == 1 { return "ARMED AND DANGEROUS"; }
            if i == 2 { return "TACTICAL RESPONSE REQUIRED"; }
            return "ENHANCED SURVEILLANCE";
        }
        if baseScore >= 60 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return "ELEVATED THREAT"; }
            if i == 1 { return "APPROACH WITH CAUTION"; }
            if i == 2 { return "KNOWN VIOLENT OFFENDER"; }
            return "GANG TASK FORCE FLAGGED";
        }
        if baseScore >= 40 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return "MODERATE CONCERN"; }
            if i == 1 { return "REPEAT OFFENDER"; }
            if i == 2 { return "PROBATION FLAGGED"; }
            return "WARRANT WATCH";
        }
        if baseScore >= 20 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return "LOW PRIORITY"; }
            if i == 1 { return "MINOR OFFENDER"; }
            if i == 2 { return "COOPERATIVE HISTORY"; }
            return "STANDARD PROCESSING";
        }
        
        let i = RandRange(seed + 100, 0, 3);
        if i == 0 { return "MINIMAL THREAT"; }
        if i == 1 { return "NO CURRENT CONCERN"; }
        if i == 2 { return "FIRST TIME OFFENDER"; }
        return "CLEARED - LOW RISK";
    }
}

public class KdspCriminalRecordData {
    public let hasRecord: Bool;
    public let status: String;
    public let warrantStatus: String;
    public let arrests: array<String>;
    public let convictions: array<String>;
    public let gangAffiliation: String;
    public let gangRank: String;
    public let gangStatus: String;
    public let ncpdClassification: String;
}
