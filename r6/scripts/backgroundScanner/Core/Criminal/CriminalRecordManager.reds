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
            record.status = GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T0");
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
            if roll <= 40 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T1"); }
            if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T2"); }
            if roll <= 75 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T9"); }
            if roll <= 90 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T3"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T4");
        }

        // If substance issues, weight towards drug-related
        if IsDefined(coherence) && coherence.hasSubstanceIssues {
            let roll = RandRange(seed, 1, 100);
            if roll <= 35 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T5"); }
            if roll <= 55 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T6"); }
            if roll <= 70 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T7"); }
            if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T3"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T8");
        }

        return KdspCriminalRecordManager.GenerateStatus(seed, archetype);
    }

    private static func GenerateStatus(seed: Int32, archetype: String) -> String {
        // Archetype-specific statuses
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T2"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T1"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T9"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T3"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T9"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T10"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T11"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T12"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T13"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T14"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T15"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T16"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T17"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T18"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T19");
        }

        // General statuses (30 options)
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T6"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T7"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T2"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T1"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T9"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T3"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T20"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T21"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T22"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T23"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T24"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T25"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T26"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T27"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T28"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T29"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T30"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T31"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T32"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T33"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T34"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T35"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T36"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T37"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T38"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T39"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T40"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T41"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T42"); }
        return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T43");
    }

    private static func GenerateWarrantStatus(seed: Int32, archetype: String) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if Equals(archetype, "GANGER") {
            if roll <= 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T44"); }
            if roll <= 25 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T45"); }
            if roll <= 35 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T46"); }
            if roll <= 45 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T47"); }
            if roll <= 55 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T48"); }
            if roll <= 65 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T49"); }
            if roll <= 75 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T50"); }
            if roll <= 80 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T51"); }
            return "NONE";
        }
        
        // 25 warrant types total
        if roll <= 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T44"); }
        if roll <= 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T45"); }
        if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T46"); }
        if roll <= 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T52"); }
        if roll <= 16 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T53"); }
        if roll <= 19 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T54"); }
        if roll <= 22 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T55"); }
        if roll <= 25 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T56"); }
        if roll <= 28 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T57"); }
        if roll <= 31 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T58"); }
        if roll <= 35 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T49"); }
        if roll <= 38 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T50"); }
        if roll <= 41 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T51"); }
        if roll <= 44 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T59"); }
        if roll <= 46 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T60"); }
        if roll <= 48 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T61"); }
        if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T62"); }
        if roll <= 52 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T63"); }
        if roll <= 54 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T64"); }
        if roll <= 56 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T65"); }
        if roll <= 58 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T66"); }
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
                ArrayPush(substanceCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S0"));
                ArrayPush(substanceCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T67"));
                ArrayPush(substanceCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S1"));
                ArrayPush(substanceCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S2"));
                ArrayPush(substanceCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S3"));
                
                if NotEquals(coherence.substanceType, "") {
                    ArrayPush(substanceCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S4") + coherence.substanceType);
                }
                
                return substanceCrimes[RandRange(seed, 0, ArraySize(substanceCrimes) - 1)] + " (" + IntToString(year) + ")";
            }
            
            // Violence-related arrests
            if coherence.hasViolentPast && RandRange(seed + 501, 1, 100) <= 60 {
                let violentCrimes: array<String>;
                ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T68"));
                ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T69"));
                ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T70"));
                ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S5"));
                ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S6"));
                ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T71"));
                
                if Equals(coherence.violenceType, "gang") {
                    ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-Shared-C20"));
                    ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T72"));
                }
                if Equals(coherence.violenceType, "domestic") {
                    ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-Shared-C21"));
                    ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T73"));
                }
                if Equals(coherence.violenceType, GetLocalizedTextByKey(n"Kdsp-Shared-C17")) {
                    ArrayPush(violentCrimes, "Brawling");
                    ArrayPush(violentCrimes, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S7"));
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S8") + IntToString(year) + ")"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S9") + IntToString(year) + ")"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T74") + IntToString(year) + ")"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T75") + IntToString(year) + ")"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S10") + IntToString(year) + ")"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S11") + IntToString(year) + ")"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S12") + IntToString(year) + ")"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S13") + IntToString(year) + ")"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S14") + IntToString(year) + ")"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S15") + IntToString(year) + ")"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S16") + IntToString(year) + ")"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S17") + IntToString(year) + ")"; }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S18") + IntToString(year) + ")"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S19") + IntToString(year) + ")"; }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S20") + IntToString(year) + ")"; }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S21") + IntToString(year) + ")"; }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S22") + IntToString(year) + ")"; }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S23") + IntToString(year) + ")"; }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S24") + IntToString(year) + ")"; }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S25") + IntToString(year) + ")";
        }

        // Corpo-specific crimes
        if (Equals(archetype, "CORPO_DRONE") || Equals(archetype, "CORPO_MANAGER")) && RandRange(seed + 501, 1, 100) <= 70 {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S26") + IntToString(year) + ")"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S27") + IntToString(year) + ")"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S28") + IntToString(year) + ")"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S29") + IntToString(year) + ")"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T76") + IntToString(year) + ")"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S30") + IntToString(year) + ")"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S31") + IntToString(year) + ")"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S32") + IntToString(year) + ")"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S33") + IntToString(year) + ")"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S34") + IntToString(year) + ")"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S35") + IntToString(year) + ")"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S36") + IntToString(year) + ")"; }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S37") + IntToString(year) + ")"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S38") + IntToString(year) + ")"; }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S39") + IntToString(year) + ")";
        }

        // Junkie-specific crimes
        if Equals(archetype, "JUNKIE") && RandRange(seed + 502, 1, 100) <= 60 {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S40") + IntToString(year) + ")"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S41") + IntToString(year) + ")"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S42") + IntToString(year) + ")"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S43") + IntToString(year) + ")"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S44") + IntToString(year) + ")"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S45") + IntToString(year) + ")"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S46") + IntToString(year) + ")"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S47") + IntToString(year) + ")"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S48") + IntToString(year) + ")"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S49") + IntToString(year) + ")"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T77") + IntToString(year) + ")"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S50") + IntToString(year) + ")"; }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S51") + IntToString(year) + ")"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S52") + IntToString(year) + ")"; }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T78") + IntToString(year) + ")";
        }

        // General crimes (100 options)
        let i = RandRange(seed, 0, 99);
        
        // Minor offenses (0-19)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S40") + IntToString(year) + ")"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S53") + IntToString(year) + ")"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S54") + IntToString(year) + ")"; }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T78") + IntToString(year) + ")"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T79") + IntToString(year) + ")"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T80") + IntToString(year) + ")"; }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S55") + IntToString(year) + ")"; }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S56") + IntToString(year) + ")"; }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S57") + IntToString(year) + ")"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S58") + IntToString(year) + ")"; }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S59") + IntToString(year) + ")"; }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T81") + IntToString(year) + ")"; }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S60") + IntToString(year) + ")"; }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S61") + IntToString(year) + ")"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S62") + IntToString(year) + ")"; }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S63") + IntToString(year) + ")"; }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S64") + IntToString(year) + ")"; }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S65") + IntToString(year) + ")"; }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S66") + IntToString(year) + ")"; }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S67") + IntToString(year) + ")"; }
        
        // Drug/Substance (20-29)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S41") + IntToString(year) + ")"; }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S42") + IntToString(year) + ")"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S68") + IntToString(year) + ")"; }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S69") + IntToString(year) + ")"; }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S47") + IntToString(year) + ")"; }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S70") + IntToString(year) + ")"; }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S71") + IntToString(year) + ")"; }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S46") + IntToString(year) + ")"; }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S72") + IntToString(year) + ")"; }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S73") + IntToString(year) + ")"; }
        
        // Theft/Property (30-44)
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S74") + IntToString(year) + ")"; }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S75") + IntToString(year) + ")"; }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T82") + IntToString(year) + ")"; }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T77") + IntToString(year) + ")"; }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S76") + IntToString(year) + ")"; }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S77") + IntToString(year) + ")"; }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T83") + IntToString(year) + ")"; }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S78") + IntToString(year) + ")"; }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S79") + IntToString(year) + ")"; }
        if i == 39 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T84") + IntToString(year) + ")"; }
        if i == 40 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T85") + IntToString(year) + ")"; }
        if i == 41 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S80") + IntToString(year) + ")"; }
        if i == 42 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S81") + IntToString(year) + ")"; }
        if i == 43 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S82") + IntToString(year) + ")"; }
        if i == 44 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S83") + IntToString(year) + ")"; }
        
        // Violence (45-59)
        if i == 45 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T86") + IntToString(year) + ")"; }
        if i == 46 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T87") + IntToString(year) + ")"; }
        if i == 47 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S84") + IntToString(year) + ")"; }
        if i == 48 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S85") + IntToString(year) + ")"; }
        if i == 49 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S86") + IntToString(year) + ")"; }
        if i == 50 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S87") + IntToString(year) + ")"; }
        if i == 51 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S88") + IntToString(year) + ")"; }
        if i == 52 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S89") + IntToString(year) + ")"; }
        if i == 53 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T88") + IntToString(year) + ")"; }
        if i == 54 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S90") + IntToString(year) + ")"; }
        if i == 55 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T89") + IntToString(year) + ")"; }
        if i == 56 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T90") + IntToString(year) + ")"; }
        if i == 57 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T91") + IntToString(year) + ")"; }
        if i == 58 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T92") + IntToString(year) + ")"; }
        if i == 59 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S91") + IntToString(year) + ")"; }
        
        // Weapons (60-69)
        if i == 60 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S92") + IntToString(year) + ")"; }
        if i == 61 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S93") + IntToString(year) + ")"; }
        if i == 62 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S94") + IntToString(year) + ")"; }
        if i == 63 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S95") + IntToString(year) + ")"; }
        if i == 64 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S96") + IntToString(year) + ")"; }
        if i == 65 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S97") + IntToString(year) + ")"; }
        if i == 66 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S98") + IntToString(year) + ")"; }
        if i == 67 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S99") + IntToString(year) + ")"; }
        if i == 68 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S100") + IntToString(year) + ")"; }
        if i == 69 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S101") + IntToString(year) + ")"; }
        
        // Cybercrimes (70-79)
        if i == 70 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S102") + IntToString(year) + ")"; }
        if i == 71 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S27") + IntToString(year) + ")"; }
        if i == 72 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T93") + IntToString(year) + ")"; }
        if i == 73 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S103") + IntToString(year) + ")"; }
        if i == 74 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S104") + IntToString(year) + ")"; }
        if i == 75 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S105") + IntToString(year) + ")"; }
        if i == 76 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S106") + IntToString(year) + ")"; }
        if i == 77 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S107") + IntToString(year) + ")"; }
        if i == 78 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S108") + IntToString(year) + ")"; }
        if i == 79 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S109") + IntToString(year) + ")"; }
        
        // Traffic/Vehicle (80-84)
        if i == 80 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S110") + IntToString(year) + ")"; }
        if i == 81 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S111") + IntToString(year) + ")"; }
        if i == 82 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S112") + IntToString(year) + ")"; }
        if i == 83 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S113") + IntToString(year) + ")"; }
        if i == 84 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S114") + IntToString(year) + ")"; }
        
        // Fraud/White collar (85-89)
        if i == 85 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T94") + IntToString(year) + ")"; }
        if i == 86 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T95") + IntToString(year) + ")"; }
        if i == 87 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T96") + IntToString(year) + ")"; }
        if i == 88 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S115") + IntToString(year) + ")"; }
        if i == 89 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S116") + IntToString(year) + ")"; }
        
        // Other (90-99)
        if i == 90 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S117") + IntToString(year) + ")"; }
        if i == 91 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S118") + IntToString(year) + ")"; }
        if i == 92 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S119") + IntToString(year) + ")"; }
        if i == 93 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S120") + IntToString(year) + ")"; }
        if i == 94 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S121") + IntToString(year) + ")"; }
        if i == 95 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T97") + IntToString(year) + ")"; }
        if i == 96 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T98") + IntToString(year) + ")"; }
        if i == 97 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T4") + IntToString(year) + ")"; }
        if i == 98 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S122") + IntToString(year) + ")"; }
        return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S123") + IntToString(year) + ")";
    }

    private static func GenerateConviction(seed: Int32, archetype: String) -> String {
        let i = RandRange(seed, 0, 29);
        
        // Fines (0-4)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S124") + IntToString(RandRange(seed, 100, 500)); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S124") + IntToString(RandRange(seed, 500, 2000)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S124") + IntToString(RandRange(seed, 2000, 10000)); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S124") + IntToString(RandRange(seed, 10000, 50000)); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S124") + IntToString(RandRange(seed, 50000, 250000)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T99"); }
        
        // Community service (5-7)
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S125") + IntToString(RandRange(seed + 10, 20, 100)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T100"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S125") + IntToString(RandRange(seed + 10, 100, 300)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T100"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S125") + IntToString(RandRange(seed + 10, 300, 500)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T100"); }
        
        // Probation (8-10)
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S126") + IntToString(RandRange(seed + 20, 6, 12)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S126") + IntToString(RandRange(seed + 20, 12, 36)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S126") + IntToString(RandRange(seed + 20, 36, 60)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        
        // Detention/Prison (11-16)
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S127") + IntToString(RandRange(seed + 30, 1, 6)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S127") + IntToString(RandRange(seed + 30, 6, 12)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S128") + IntToString(RandRange(seed + 40, 1, 3)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S128") + IntToString(RandRange(seed + 40, 3, 10)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S128") + IntToString(RandRange(seed + 40, 10, 25)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S129") + IntToString(RandRange(seed + 40, 5, 15)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        
        // Corporate sentences (17-19)
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S130") + IntToString(RandRange(seed + 50, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S131") + IntToString(RandRange(seed + 50, 1, 3)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S132") + IntToString(RandRange(seed + 50, 2, 10)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        
        // Alternative sentences (20-24)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S133"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S134") + IntToString(RandRange(seed + 60, 6, 24)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S135") + IntToString(RandRange(seed + 60, 3, 18)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S136"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S137"); }
        
        // Special conditions (25-29)
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S138"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S139"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S140") + IntToString(RandRange(seed, 5000, 100000)); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S141") + IntToString(RandRange(seed + 70, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T102"); }
        return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S142") + IntToString(RandRange(seed + 70, 12, 36)) + GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T101");
    }

    private static func GenerateGangRank(seed: Int32, archetype: String) -> String {
        // Weight towards lower ranks
        let roll = RandRange(seed, 1, 100);
        
        // Low ranks (60%)
        if roll <= 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T103"); }
        if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T104"); }
        if roll <= 40 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T105"); }
        if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T106"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T107"); }
        
        // Mid ranks (30%)
        if roll <= 68 { return "Soldier"; }
        if roll <= 75 { return "Enforcer"; }
        if roll <= 82 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T108"); }
        if roll <= 88 { return "Lieutenant"; }
        if roll <= 92 { return "Captain"; }
        
        // High ranks (10%)
        if roll <= 95 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T109"); }
        if roll <= 97 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T110"); }
        if roll <= 99 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T111"); }
        return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S143");
    }

    private static func GenerateGangStatus(seed: Int32) -> String {
        let i = RandRange(seed, 0, 19);
        
        // Active statuses (0-7)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T112"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S144"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S145"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S146"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S147"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S148"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S149"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S150"); }
        
        // Probationary/New (8-11)
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T113"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T114"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S151"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T115"); }
        
        // Inactive/Problem (12-15)
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S152"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S153"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S154"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S155"); }
        
        // High risk (16-19)
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S156"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T116"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S157"); }
        return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-S158");
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T117"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T118"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T119"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T120");
        }
        if baseScore >= 80 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T121"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T122"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T123"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T124");
        }
        if baseScore >= 60 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T125"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T126"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T127"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T128");
        }
        if baseScore >= 40 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T129"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T9"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T130"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T131");
        }
        if baseScore >= 20 { 
            let i = RandRange(seed + 100, 0, 3);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T132"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T133"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T134"); }
            return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T135");
        }
        
        let i = RandRange(seed + 100, 0, 3);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T136"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T137"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T22"); }
        return GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T138");
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
