public class BackstoryManager {

    public static func GenerateBackstoryUI(target: wref<NPCPuppet>) -> BackstoryUI {
        let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
        let seed = RandRange(entityIDHash, 0, 2147483647);
        let lifePath: ref<LifePath> = LifePath.Create(target);

        // Get appearance for detection
        let appearanceName = NameToString(target.GetCurrentAppearanceName());
        
        // Check if NPC is a child - generate age-appropriate content
        if BackstoryManager.IsChildNPC(appearanceName) {
            return BackstoryManager.GenerateChildBackstory(seed, lifePath);
        };

        // Original backstory generation for adults
        let background = BackstoryManager.GenerateChildhoodHome(seed, lifePath) + BackstoryManager.GenerateUpbringingEvent(seed, lifePath);
        let earlyLife = BackstoryManager.GenerateChildhoodEvents(seed, lifePath);
        let significantEvents = BackstoryManager.GenerateFirstJob(seed, lifePath) + BackstoryManager.GenerateAdultEvents(seed, lifePath);

        // Get context for expanded systems
        let archetype = lifePath.archetype;
        let gangAffiliation = GangManager.DetectGangAffiliation(appearanceName, "");
        let wealth = BackstoryManager.GetWealthScore(archetype);
        let age = BackstoryManager.GetAge(seed, archetype);

        // Detect NCPD early - they get different treatment
        let isNCPD: Bool = NCPDNameGenerator.IsNCPD(appearanceName) || target.IsPrevention() || target.IsCharacterPolice();

        // Generate expanded data
        let criminal = CriminalRecordManager.Generate(seed + 1000, archetype, gangAffiliation);
        let cyberware = CyberwareRegistryManager.Generate(seed + 2000, archetype, wealth);
        let financial = FinancialProfileManager.Generate(seed + 3000, archetype);
        let medical = MedicalHistoryManager.Generate(seed + 4000, archetype, age);
        let psych = PsychProfileManager.Generate(seed + 5000, archetype, criminal, cyberware);

        // Build BackstoryUI
        let backstoryUI: BackstoryUI;
        
        // NCPD officers get cop-specific backstory, not civilian backstory
        if isNCPD {
            backstoryUI.background = BackstoryManager.GenerateNCPDBackground(seed, lifePath);
            backstoryUI.earlyLife = BackstoryManager.GenerateNCPDEarlyLife(seed, lifePath);
            backstoryUI.significantEvents = BackstoryManager.GenerateNCPDRecentActivity(seed, lifePath);
        } else {
            backstoryUI.background = background;
            backstoryUI.earlyLife = earlyLife;
            backstoryUI.significantEvents = significantEvents;
        };

        // Generate pronouns if enabled
        if KiroshiSettings.PronounDisplayEnabled() {
            backstoryUI.pronouns = BackstoryManager.GeneratePronouns(seed + 7777, lifePath.gender);
        } else {
            backstoryUI.pronouns = "";
        };

        // Criminal Record Section - skip for NCPD (they have personnel files instead)
        if criminal.hasRecord && !isNCPD {
            backstoryUI.criminalRecord = "Status: " + criminal.status;
            if ArraySize(criminal.arrests) > 0 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | Arrests: " + criminal.arrests[0];
                if ArraySize(criminal.arrests) > 1 {
                    backstoryUI.criminalRecord = backstoryUI.criminalRecord + ", " + criminal.arrests[1];
                };
            };
            if !Equals(criminal.warrantStatus, "NONE") && !Equals(criminal.warrantStatus, "CLEARED") {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | WARRANT: " + criminal.warrantStatus;
            };
            backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | NCPD: " + criminal.ncpdClassification;
        } else {
            backstoryUI.criminalRecord = "";
        };

        // Cyberware Registry Section - skip for gang members
        if Equals(gangAffiliation, "NONE") && cyberware.totalImplants > 0 {
            backstoryUI.cyberwareStatus = "Implants: " + IntToString(cyberware.totalImplants) + " | Status: " + cyberware.cyberpsychosisStatus;
            if cyberware.cyberpsychosisRisk >= 60 {
                backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | PSYCHOSIS RISK: " + IntToString(cyberware.cyberpsychosisRisk) + "%";
            };
            if cyberware.hasIllegalCyberware {
                backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | ILLEGAL MODS: " + IntToString(cyberware.illegalCount);
            };
            if cyberware.hasRejectedImplants {
                backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | REJECTED IMPLANTS DETECTED";
            };
            
            // Check for body modification implants and display them
            let bodyModFound: String = BackstoryManager.FindBodyModImplant(cyberware);
            if NotEquals(bodyModFound, "") {
                backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | BODY MOD: " + bodyModFound;
            };
        } else {
            backstoryUI.cyberwareStatus = "";
        };

        // Financial Status Section - skip for gang members and NCPD
        if Equals(gangAffiliation, "NONE") && !isNCPD {
            backstoryUI.financialStatus = "Credit Rating: " + financial.creditTier + " | Income: " + financial.incomeLevel;
            if financial.hasDebt {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | DEBT: " + financial.debtStatus;
            };
            if financial.corporateAsset {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | Corp: " + financial.employer;
            };
        } else {
            backstoryUI.financialStatus = "";
        };

        // Medical History Section - skip for gang members and NCPD
        if Equals(gangAffiliation, "NONE") && !isNCPD {
            if ArraySize(medical.chronicConditions) > 0 || ArraySize(medical.pastInjuries) > 0 {
                backstoryUI.medicalStatus = "";
                if ArraySize(medical.chronicConditions) > 0 {
                    backstoryUI.medicalStatus = "Conditions: " + medical.chronicConditions[0];
                    if ArraySize(medical.chronicConditions) > 1 {
                        backstoryUI.medicalStatus = backstoryUI.medicalStatus + ", " + medical.chronicConditions[1];
                    };
                };
                if ArraySize(medical.pastInjuries) > 0 {
                    if StrLen(backstoryUI.medicalStatus) > 0 {
                        backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | ";
                    };
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + "Injuries: " + medical.pastInjuries[0];
                };
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Health: " + medical.healthRating;
            } else {
                backstoryUI.medicalStatus = "No significant conditions | Health: " + medical.healthRating;
            };
        } else {
            backstoryUI.medicalStatus = "";
        };

        // Behavioral Profile Section (replaces threat assessment) - skip for NCPD
        if !isNCPD {
            let temperament = PsychProfileManager.GetTemperament(psych.stabilityScore, psych.threatLevel);
            let disposition = PsychProfileManager.GetDisposition(seed + 5500, archetype);
            
            backstoryUI.threatAssessment = temperament + " | " + disposition;
            if psych.stabilityScore <= 40 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Unstable";
            };
            if psych.hasAddictions {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Substance issues";
            };
            if psych.hasVendetta {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Grudge-holder";
            };
        } else {
            backstoryUI.threatAssessment = "";
        };

        // Gang Affiliation Section
        if !Equals(gangAffiliation, "NONE") {
            let gangProfile = GangManager.GenerateGangProfile(seed + 6000, gangAffiliation);
            backstoryUI.gangAffiliation = gangProfile.gangName + " | Rank: " + gangProfile.memberRank;
            backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Loyalty: " + gangProfile.loyaltyRating;
            if StrLen(gangProfile.territory) > 0 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Territory: " + gangProfile.territory;
            };
        } else {
            backstoryUI.gangAffiliation = "";
        };

        // Rare NPC Flag (1 in 1000) - skip for NCPD
        if !isNCPD && RareNPCManager.ShouldBeRareNPC(seed + 9999) {
            let rareData = RareNPCManager.Generate(seed + 10000, archetype);
            backstoryUI.rareFlag = rareData.displayFlag + " - " + rareData.rareType;
        } else {
            backstoryUI.rareFlag = "";
        };

        // NCPD Officer Detection and Name Generation
        if isNCPD {
            let ncpdData = NCPDNameGenerator.Generate(seed + 7000, appearanceName, lifePath.gender);
            
            // Try to get real name from TweakDB
            let realName: String = target.GetTweakDBFullDisplayName(true);
            let displayName: String = "";
            
            // Check if name is generic (LocKeys for generic names, common generic terms)
            let isGenericName: Bool = Equals(realName, GetLocalizedText("LocKey#1187")) ||
                                      Equals(realName, GetLocalizedText("LocKey#48967")) ||
                                      Equals(realName, GetLocalizedText("LocKey#44024")) ||
                                      Equals(realName, GetLocalizedText("LocKey#44025")) ||
                                      Equals(realName, GetLocalizedText("LocKey#42711")) ||
                                      Equals(realName, "") ||
                                      Equals(realName, "None") ||
                                      Equals(realName, "Enemy") ||
                                      Equals(realName, "Beat Cop") ||
                                      Equals(realName, "Cop") ||
                                      Equals(realName, "Officer") ||
                                      Equals(realName, "Police Officer") ||
                                      Equals(realName, "NCPD Officer") ||
                                      Equals(realName, "Patrol Officer") ||
                                      Equals(realName, "Police") ||
                                      Equals(realName, "NCPD") ||
                                      Equals(realName, "Policeman") ||
                                      Equals(realName, "Policewoman") ||
                                      Equals(realName, "Detective") ||
                                      Equals(realName, "Sergeant") ||
                                      Equals(realName, "Lieutenant") ||
                                      Equals(realName, "Captain") ||
                                      StrContains(realName, "LocKey") ||
                                      StrLen(realName) < 3;
            
            // Use real name if unique, otherwise use generated name
            if !isGenericName {
                displayName = ncpdData.rank + " " + realName;
            } else {
                displayName = ncpdData.rank + " " + ncpdData.fullName;
            };
            
            backstoryUI.ncpdOfficer = displayName + " | Badge: " + ncpdData.badge;
            backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + ncpdData.unit;
            if StrLen(ncpdData.specialization) > 0 {
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Spec: " + ncpdData.specialization;
            };
            backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | District: " + ncpdData.assignedDistrict;
            backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + IntToString(ncpdData.yearsOfService) + " yrs service";
            if ncpdData.confirmedNeutralizations > 0 {
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Neutralizations: " + IntToString(ncpdData.confirmedNeutralizations);
            };
            backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Status: " + ncpdData.dutyStatus;
        } else {
            backstoryUI.ncpdOfficer = "";
        };

        // Relationships - skip for gang members and NCPD
        if Equals(gangAffiliation, "NONE") && !isNCPD {
            let relations = RelationshipsManager.Generate(seed + 8000, archetype, gangAffiliation);
            backstoryUI.relationships = "";
            
            // Status and dependents
            backstoryUI.relationships = relations.currentRelationshipStatus;
            if relations.dependents > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Dependents: " + IntToString(relations.dependents);
            };
            
            // Emergency contact
            if !Equals(relations.emergencyContact, "NONE ON FILE") {
                backstoryUI.relationships = backstoryUI.relationships + " | Emergency: " + relations.emergencyContact;
            };
            
            // Known associates (show first 2)
            if ArraySize(relations.knownAssociates) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Associates: ";
                let i = 0;
                let maxShow = 2;
                if ArraySize(relations.knownAssociates) < maxShow {
                    maxShow = ArraySize(relations.knownAssociates);
                };
                while i < maxShow {
                    let assoc = relations.knownAssociates[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + assoc.name + " (" + assoc.relationship + ")";
                    i += 1;
                };
                if ArraySize(relations.knownAssociates) > 2 {
                    backstoryUI.relationships = backstoryUI.relationships + " +" + IntToString(ArraySize(relations.knownAssociates) - 2) + " more";
                };
            };
            
            // Known enemies
            if ArraySize(relations.knownEnemies) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | ENEMIES: ";
                let i = 0;
                while i < ArraySize(relations.knownEnemies) {
                    let enemy = relations.knownEnemies[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + enemy.name + " (" + enemy.reason + ")";
                    i += 1;
                };
            };
            
            // Social network size
            backstoryUI.relationships = backstoryUI.relationships + " | Network: " + relations.socialNetworkSize;
        } else {
            backstoryUI.relationships = "";
        };

        return backstoryUI;
    }

    private static func GetWealthScore(archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return 85; };
        if Equals(archetype, "YUPPIE") { return 70; };
        if Equals(archetype, "CORPO_DRONE") { return 55; };
        if Equals(archetype, "CIVVIE") { return 40; };
        if Equals(archetype, "NOMAD") { return 30; };
        if Equals(archetype, "GANGER") { return 25; };
        if Equals(archetype, "LOWLIFE") { return 15; };
        if Equals(archetype, "JUNKIE") { return 10; };
        if Equals(archetype, "HOMELESS") { return 5; };
        return 35;
    }

    private static func GetAge(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed + 8888, 35, 60); };
        if Equals(archetype, "CORPO_DRONE") { return RandRange(seed + 8888, 22, 45); };
        if Equals(archetype, "YUPPIE") { return RandRange(seed + 8888, 25, 45); };
        if Equals(archetype, "GANGER") { return RandRange(seed + 8888, 18, 35); };
        if Equals(archetype, "HOMELESS") { return RandRange(seed + 8888, 25, 65); };
        if Equals(archetype, "JUNKIE") { return RandRange(seed + 8888, 20, 50); };
        if Equals(archetype, "NOMAD") { return RandRange(seed + 8888, 20, 50); };
        return RandRange(seed + 8888, 20, 55);
    }

    private static func GenerateUpbringingEvent(seed: Int32, lifePath: ref<LifePath>) -> String {
        return BackstoryManager.GenerateEvent(seed, lifePath, lifePath.possibleEvents.m_weightedUpbringingEvents, lifePath.possibleEvents.m_cdfWeightedUpbringingEvents);
    }

    public static func GenerateChildhoodHome(seed: Int32, lifePath: ref<LifePath>) -> String {
        return BackstoryManager.GenerateEvent(seed, lifePath, lifePath.possibleEvents.m_weightedHomeEvents, lifePath.possibleEvents.m_cdfWeightedHomeEvents);
    }

    private static func GenerateChildhoodEvents(seed: Int32, lifePath: ref<LifePath>) -> String {
        let childhoodEvents: String;
        let eventsCount: Int32 = RandRange(seed + 21620, 1, 2);

        let i = 0;
        while i < eventsCount {
            childhoodEvents += BackstoryManager.GenerateEvent(seed + (i * 199), lifePath, lifePath.possibleEvents.m_weightedChildhoodEvents, lifePath.possibleEvents.m_cdfWeightedChildhoodEvents);
            i += 1;
        }  
        return childhoodEvents;
    }

    private static func GenerateFirstJob(seed: Int32, lifePath: ref<LifePath>) -> String {
        return BackstoryManager.GenerateEvent(seed, lifePath, lifePath.possibleEvents.m_weightedJobEvents, lifePath.possibleEvents.m_cdfWeightedJobEvents);
    }

    private static func GenerateAdultEvents(seed: Int32, lifePath: ref<LifePath>) -> String {
        let adultEvents: String;
        let eventsCount: Int32 = RandRange(seed + 21620, 1, 2);

        let i = 0;
        while i < eventsCount {
            adultEvents += BackstoryManager.GenerateEvent(seed + (i * 199), lifePath, lifePath.possibleEvents.m_weightedAdultEvents, lifePath.possibleEvents.m_cdfWeightedAdultEvents);
            i += 1;
        }  
        return adultEvents;
    }

    private static func GenerateEvent(seed: Int32, lifePath: ref<LifePath>, arr: array<ref<LifePathEvent>>, cdf: array<Int32>) -> String {
        let cdfSize = ArraySize(cdf);
        let totalWeight = cdf[cdfSize - 1];
        let val = RandRange(seed, 0, totalWeight);
        let eventIndex = BackstoryManager.getCorrespondingIndex(cdf, val);

        let event = arr[eventIndex];
        let eventText = event.GetText(lifePath.gender);
        return BackstoryManager.FillReplacements(seed, eventText);
    }

    private static func FillReplacements(seed: Int32, text: String) -> String {
        let ret = text;
        if(StrContains(ret, "%corp%")) {
            ret = ReplaceFirst(ret, "%corp%", BackstoryManager.GetRandomCorpo(seed));
        };
        if(StrContains(ret, "%eddies%")) {
            ret = ReplaceFirst(ret, "%eddies%", IntToString(RandRange(seed, 100, 10000)));
        };
        if(StrContains(ret, "%years%")) {
            ret = ReplaceFirst(ret, "%years%", IntToString(RandRange(seed, 2, 10)));
        };
        if(StrContains(ret, "%year%")) {
            ret = ReplaceFirst(ret, "%year%", IntToString(RandRange(seed, 2020, 2050)));
        };
        if(StrContains(ret, "%young_age%")) {
            ret = ReplaceFirst(ret, "%young_age%", IntToString(RandRange(seed, 10, 16)));
        };
        return ret;
    }

    private static func getCorrespondingIndex(arr: array<Int32>, val: Int32) -> Int32 {
        let acc = 0;
        let i = 0;
        while val > arr[i] {
            i += 1;
        }
        return i;
    }


    private static func GetRandomCorpo(seed: Int32) -> String {
        let corpos: array<String>;
        
        ArrayPush(corpos, Text.NIPPON_NETWORK());
        ArrayPush(corpos, Text.DIVERSE_MEDIA());
        ArrayPush(corpos, Text.WORLD_NEWS());
        ArrayPush(corpos, Text.AKAROMI());
        ArrayPush(corpos, Text.CONAG());
        ArrayPush(corpos, Text.NN54());
        ArrayPush(corpos, Text.PETROCHEM());
        ArrayPush(corpos, Text.SOVOIL());
        ArrayPush(corpos, Text.ARASAKA());
        ArrayPush(corpos, Text.KANG_TAO());
        ArrayPush(corpos, Text.Militech());
        ArrayPush(corpos, Text.MITSU_SUGO());
        ArrayPush(corpos, Text.SEG_ATARI());
        ArrayPush(corpos, Text.TDS());
        ArrayPush(corpos, Text.AHI());
        ArrayPush(corpos, Text.EBM());
        ArrayPush(corpos, Text.IEC());
        ArrayPush(corpos, Text.MICROTECH());
        ArrayPush(corpos, Text.ZETATECH());
        ArrayPush(corpos, Text.ADREK_ROBO());
        ArrayPush(corpos, Text.AKAGI_SYS());
        ArrayPush(corpos, Text.BAKU_CHIPMASTERS());
        ArrayPush(corpos, Text.BIOTECHNICA());
        ArrayPush(corpos, Text.CYPHIRE());
        ArrayPush(corpos, Text.DAKAI());
        ArrayPush(corpos, Text.DYNALAR());
        ArrayPush(corpos, Text.KENJIRI());
        ArrayPush(corpos, Text.KIROSHI());
        ArrayPush(corpos, Text.TTI());
        ArrayPush(corpos, Text.MAF());
        ArrayPush(corpos, Text.TOYOTA());
        ArrayPush(corpos, Text.FUYUTSUKI());
        ArrayPush(corpos, Text.ORBITAL_AIR());
        ArrayPush(corpos, Text.WORLDSAT());
        ArrayPush(corpos, Text.EUROBANK());
        ArrayPush(corpos, Text.FUJIWARA());
        ArrayPush(corpos, Text.INFOCOMP());
        ArrayPush(corpos, Text.BAKENEKO());

        let corpoVal = RandRange(seed + 41948, 0, ArraySize(corpos)-1);

        return corpos[corpoVal];
    }

    // ========== CHILD NPC DETECTION & HANDLING ==========

    // Detect if NPC is a child based on appearance name patterns
    private static func IsChildNPC(appearanceName: String) -> Bool {
        let lowerName = StrLower(appearanceName);
        
        // Common child appearance indicators in CP2077
        if StrContains(lowerName, "child") { return true; };
        if StrContains(lowerName, "_kid_") { return true; };
        if StrContains(lowerName, "_kid") { return true; };
        if StrContains(lowerName, "kid_") { return true; };
        if StrContains(lowerName, "_boy_") { return true; };
        if StrContains(lowerName, "_girl_") { return true; };
        if StrContains(lowerName, "young_") { return true; };
        if StrContains(lowerName, "_young") { return true; };
        if StrContains(lowerName, "teen") { return true; };
        if StrContains(lowerName, "juvenile") { return true; };
        if StrContains(lowerName, "minor") { return true; };
        if StrContains(lowerName, "urchin") { return true; };
        if StrContains(lowerName, "street_kid") { return true; };
        
        return false;
    }

    // Generate age-appropriate backstory for child NPCs
    private static func GenerateChildBackstory(seed: Int32, lifePath: ref<LifePath>) -> BackstoryUI {
        let backstoryUI: BackstoryUI;
        
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

    private static func FindBodyModImplant(cyberware: ref<CyberwareRegistryData>) -> String {
        let i: Int32 = 0;
        while i < ArraySize(cyberware.implants) {
            let implant = cyberware.implants[i];
            if Equals(implant.slot, "Body Modification") {
                return implant.name;
            };
            i += 1;
        };
        return "";
    }

    private static func GeneratePronouns(seed: Int32, gender: String) -> String {
        let roll: Int32 = RandRange(seed, 1, 100);
        
        // Most NPCs use pronouns matching their presentation
        // ~10% use they/them, ~5% use neopronouns or mixed
        if roll <= 85 {
            // Standard pronouns based on gender presentation
            if Equals(gender, "female") {
                return "she/her";
            } else {
                return "he/him";
            };
        } else if roll <= 95 {
            // They/them
            return "they/them";
        } else {
            // Neopronouns and variations (rare)
            let neoRoll: Int32 = RandRange(seed + 10, 1, 100);
            if neoRoll <= 20 {
                return "xe/xem";
            } else if neoRoll <= 40 {
                return "ze/zir";
            } else if neoRoll <= 60 {
                return "it/its";
            } else if neoRoll <= 75 {
                return "she/they";
            } else if neoRoll <= 90 {
                return "he/they";
            } else {
                return "any pronouns";
            };
        };
    }

    // NCPD-specific backstory generation
    private static func GenerateNCPDBackground(seed: Int32, lifePath: ref<LifePath>) -> String {
        let backgrounds: array<String>;
        ArrayPush(backgrounds, "Academy graduate. Family has history of NCPD service.");
        ArrayPush(backgrounds, "Former corporate security, recruited by NCPD.");
        ArrayPush(backgrounds, "Military background. Joined NCPD after discharge.");
        ArrayPush(backgrounds, "Grew up in Watson. Joined the force to make a difference.");
        ArrayPush(backgrounds, "Academy top percentile. Fast-tracked through training.");
        ArrayPush(backgrounds, "Second-generation NCPD. Father was decorated officer.");
        ArrayPush(backgrounds, "Street kid turned cop. Knows the underworld firsthand.");
        ArrayPush(backgrounds, "Former Trauma Team. Transitioned to law enforcement.");
        ArrayPush(backgrounds, "Recruited from private security sector.");
        ArrayPush(backgrounds, "Came up through NCPD cadet program.");
        ArrayPush(backgrounds, "Ex-military police. Extensive combat training.");
        ArrayPush(backgrounds, "Academy scholarship recipient. Night City native.");
        
        return backgrounds[RandRange(seed + 100, 0, ArraySize(backgrounds) - 1)];
    }

    private static func GenerateNCPDEarlyLife(seed: Int32, lifePath: ref<LifePath>) -> String {
        let events: array<String>;
        ArrayPush(events, "Completed standard patrol rotation. No incidents.");
        ArrayPush(events, "Early commendation for bravery during gang shootout.");
        ArrayPush(events, "Transferred between precincts twice. Standard career progression.");
        ArrayPush(events, "Partnered with veteran officer for field training.");
        ArrayPush(events, "Completed advanced tactical training certification.");
        ArrayPush(events, "Assigned to high-crime district early in career.");
        ArrayPush(events, "Received marksmanship award during academy.");
        ArrayPush(events, "First year on the job was during the unification riots.");
        ArrayPush(events, "Volunteered for overtime shifts in Pacifica.");
        ArrayPush(events, "Completed crisis negotiation training.");
        
        return events[RandRange(seed + 200, 0, ArraySize(events) - 1)];
    }

    private static func GenerateNCPDRecentActivity(seed: Int32, lifePath: ref<LifePath>) -> String {
        let activities: array<String>;
        ArrayPush(activities, "Currently on standard patrol rotation. Performance satisfactory.");
        ArrayPush(activities, "Recently involved in successful gang operation. Commendation pending.");
        ArrayPush(activities, "Under consideration for promotion. Evaluation scheduled.");
        ArrayPush(activities, "Transferred to new precinct last month. Adjusting to new assignment.");
        ArrayPush(activities, "Completed mandatory recertification. All scores passing.");
        ArrayPush(activities, "Recently returned from administrative leave. Full duty status.");
        ArrayPush(activities, "Assigned to joint task force operation. Details classified.");
        ArrayPush(activities, "Requested transfer to specialized unit. Application pending.");
        ArrayPush(activities, "Partner recently retired. New partner assignment pending.");
        ArrayPush(activities, "Completed community outreach assignment. Returning to patrol.");
        ArrayPush(activities, "On light duty following minor injury. Expected full recovery.");
        ArrayPush(activities, "Recently passed sergeant examination. Awaiting promotion slot.");
        
        return activities[RandRange(seed + 300, 0, ArraySize(activities) - 1)];
    }
}
