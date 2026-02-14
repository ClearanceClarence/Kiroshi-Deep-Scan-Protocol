public class BackstoryManager {

    // SEED VERSION - Increment this to regenerate all NPC backstories on next load
    // Change this value when making major content updates
    public static func GetSeedVersion() -> Int32 {
        return 3;
    }

    public static func GenerateBackstoryUI(target: wref<NPCPuppet>) -> BackstoryUI {
        let entityIDHash: Int32 = Cast(EntityID.GetHash(target.GetEntityID()));
        // Seed version allows forcing regeneration of all NPCs when mod is updated
        let seed = RandRange(entityIDHash + (BackstoryManager.GetSeedVersion() * 100000), 0, 2147483647);
        let lifePath: ref<LifePath> = LifePath.Create(target);
        
        // Get data density setting
        let density = KiroshiSettings.GetDataDensity();

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

        // Detect ethnicity from appearance and gang affiliation
        let ethnicity = EthnicityDetector.GetEthnicityFromAppearance(appearanceName, gangAffiliation);
        if Equals(ethnicity, NPCEthnicity.Mixed) {
            // No clear ethnicity detected, use random weighted by Night City demographics
            ethnicity = EthnicityDetector.GetRandomEthnicity(seed + 888);
        }

        // Detect NCPD early - they get different treatment
        // Barghest uses Prevention archetype but are NOT NCPD - exclude them
        let isBarghest: Bool = Equals(gangAffiliation, "BARGHEST") || StrContains(appearanceName, "barghest") || StrContains(appearanceName, "kurtz");
        let isNCPD: Bool = !isBarghest && (NCPDNameGenerator.IsNCPD(appearanceName) || target.IsPrevention() || target.IsCharacterPolice());

        // Check if coherence mode is enabled in settings
        let coherence: ref<CoherenceProfile>;
        if KiroshiSettings.CoherenceEnabled() {
            // Generate coherence profile - this ensures all data is interconnected
            coherence = CoherenceManager.Generate(seed + 500, archetype, age, gangAffiliation);
        } else {
            // No coherence - each system generates independently (maximum variety)
            coherence = null;
        }

        // Generate expanded data (coherence may be null for independent generation)
        let criminal = CriminalRecordManager.GenerateCoherent(seed + 1000, archetype, gangAffiliation, coherence);
        let cyberware = CyberwareRegistryManager.GenerateCoherent(seed + 2000, archetype, wealth, coherence);
        let financial = FinancialProfileManager.GenerateCoherent(seed + 3000, archetype, coherence);
        let medical = MedicalHistoryManager.GenerateCoherent(seed + 4000, archetype, age, coherence);
        let psych = PsychProfileManager.GenerateCoherent(seed + 5000, archetype, coherence);

        // Build BackstoryUI
        let backstoryUI: BackstoryUI;
        
        // Check if this is a gang member (not Barghest - they have separate handling)
        let isGangMember: Bool = !Equals(gangAffiliation, "NONE") && !isBarghest;
        
        // NCPD officers get cop-specific backstory, not civilian backstory
        if isNCPD {
            backstoryUI.background = BackstoryManager.GenerateNCPDBackground(seed, lifePath);
            // Early life only on medium/high density
            if density >= 2 {
                backstoryUI.earlyLife = BackstoryManager.GenerateNCPDEarlyLife(seed, lifePath);
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = BackstoryManager.GenerateNCPDRecentActivity(seed, lifePath);
        } else if isBarghest {
            // Barghest get militia-style backgrounds
            let barghestData = BarghestProfileManager.Generate(seed + 8000, appearanceName, lifePath.gender, ethnicity);
            backstoryUI.background = barghestData.background;
            if density >= 2 {
                backstoryUI.earlyLife = "Prior service: " + barghestData.formerAffiliation + ". " + IntToString(barghestData.yearsService) + " years military experience.";
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = "Joined Barghest " + IntToString(barghestData.yearsBarghest) + " years ago. Combat role: " + barghestData.combatRole + ".";
        } else if isGangMember {
            // Gang members get gang-specific detailed backstories
            let gangData = GangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);
            backstoryUI.background = gangData.background;
            if density >= 2 {
                backstoryUI.earlyLife = IntToString(gangData.yearsActive) + " years with " + gangData.gangName + ". Role: " + gangData.role + ".";
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = gangData.recentActivity;
        } else {
            backstoryUI.background = background;
            // Early life only on medium/high density
            if density >= 2 {
                backstoryUI.earlyLife = earlyLife;
            } else {
                backstoryUI.earlyLife = "";
            };
            backstoryUI.significantEvents = significantEvents;
        };

        // Generate pronouns if enabled - only on high density
        if density >= 3 && KiroshiSettings.PronounDisplayEnabled() {
            backstoryUI.pronouns = BackstoryManager.GeneratePronouns(seed + 7777, lifePath.gender);
        } else {
            backstoryUI.pronouns = "";
        };

        // Criminal Record Section - skip for NCPD, Barghest, and gang members (they have their own records)
        if criminal.hasRecord && !isNCPD && !isBarghest && !isGangMember {
            backstoryUI.criminalRecord = "Status: " + criminal.status;
            // Show arrests on medium/high density
            if density >= 2 && ArraySize(criminal.arrests) > 0 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | Arrests: " + criminal.arrests[0];
                if density >= 3 && ArraySize(criminal.arrests) > 1 {
                    backstoryUI.criminalRecord = backstoryUI.criminalRecord + ", " + criminal.arrests[1];
                };
            };
            if !Equals(criminal.warrantStatus, "NONE") && !Equals(criminal.warrantStatus, "CLEARED") {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | WARRANT: " + criminal.warrantStatus;
            };
            // NCPD classification on medium/high
            if density >= 2 {
                backstoryUI.criminalRecord = backstoryUI.criminalRecord + " | NCPD: " + criminal.ncpdClassification;
            };
        } else {
            backstoryUI.criminalRecord = "";
        };

        // Cyberware Registry Section - skip for gang members, only on medium/high density
        if density >= 2 && Equals(gangAffiliation, "NONE") && cyberware.totalImplants > 0 {
            backstoryUI.cyberwareStatus = "Implants: " + IntToString(cyberware.totalImplants) + " | Status: " + cyberware.cyberpsychosisStatus;
            if cyberware.cyberpsychosisRisk >= 60 {
                backstoryUI.cyberwareStatus = backstoryUI.cyberwareStatus + " | PSYCHOSIS RISK: " + IntToString(cyberware.cyberpsychosisRisk) + "%";
            };
            // Extra details on high density only
            if density >= 3 {
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
            };
        } else {
            backstoryUI.cyberwareStatus = "";
        };

        // Financial Status Section - skip for gang members and NCPD, only on medium/high density
        if density >= 2 && Equals(gangAffiliation, "NONE") && !isNCPD {
            backstoryUI.financialStatus = "Credit Rating: " + financial.creditTier + " | Income: " + financial.incomeLevel;
            if financial.hasDebt {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | DEBT: " + financial.debtStatus;
            };
            // Corp info on high density only
            if density >= 3 && financial.corporateAsset {
                backstoryUI.financialStatus = backstoryUI.financialStatus + " | Corp: " + financial.employer;
            };
        } else {
            backstoryUI.financialStatus = "";
        };

        // Medical History Section - skip for gang members and NCPD, only on medium/high density
        if density >= 2 && Equals(gangAffiliation, "NONE") && !isNCPD {
            // Blood type always shown first
            backstoryUI.medicalStatus = "Blood: " + medical.bloodType;
            
            if ArraySize(medical.chronicConditions) > 0 || ArraySize(medical.pastInjuries) > 0 {
                if ArraySize(medical.chronicConditions) > 0 {
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Conditions: " + medical.chronicConditions[0];
                    // Extra conditions on high density
                    if density >= 3 && ArraySize(medical.chronicConditions) > 1 {
                        backstoryUI.medicalStatus = backstoryUI.medicalStatus + ", " + medical.chronicConditions[1];
                    };
                };
                // Injuries on high density only
                if density >= 3 && ArraySize(medical.pastInjuries) > 0 {
                    backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Injuries: " + medical.pastInjuries[0];
                };
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | Health: " + medical.healthRating;
            } else {
                backstoryUI.medicalStatus = backstoryUI.medicalStatus + " | No significant conditions | Health: " + medical.healthRating;
            };
        } else {
            backstoryUI.medicalStatus = "";
        };

        // Behavioral Profile Section (replaces threat assessment) - skip for NCPD, custom for Barghest and gang members
        if isBarghest {
            // Barghest get military threat assessment
            let barghestData = BarghestProfileManager.Generate(seed + 8000, appearanceName, lifePath.gender, ethnicity);
            backstoryUI.threatAssessment = "HOSTILE | Military trained | " + barghestData.combatRole;
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Confirmed kills: " + IntToString(barghestData.confirmedKills);
            };
            if density >= 3 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Hansen loyalist";
            };
        } else if isGangMember {
            // Gang members get gang-appropriate threat assessment
            let gangData = GangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);
            
            // Threat level based on gang type
            let threatPrefix: String = "HOSTILE";
            if Equals(gangAffiliation, "MOXES") || Equals(gangAffiliation, "ALDECALDOS") {
                threatPrefix = "CAUTION";
            };
            
            backstoryUI.threatAssessment = threatPrefix + " | " + gangData.gangName;
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | " + gangData.role;
                if gangData.bodyCount > 0 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Bodies: " + IntToString(gangData.bodyCount);
                };
            };
            if density >= 3 {
                if ArraySize(gangData.distinguishingMarks) > 0 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Marks: " + gangData.distinguishingMarks[0];
                };
            };
        } else if !isNCPD {
            let temperament = PsychProfileManager.GetTemperament(psych.stabilityScore, psych.threatLevel);
            let disposition = PsychProfileManager.GetDisposition(seed + 5500, archetype);
            
            backstoryUI.threatAssessment = temperament;
            // Add disposition on medium/high density
            if density >= 2 {
                backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | " + disposition;
            };
            // Extra flags on high density only
            if density >= 3 {
                if psych.stabilityScore <= 40 {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Unstable";
                };
                if psych.hasAddictions {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Substance issues";
                };
                if psych.hasVendetta {
                    backstoryUI.threatAssessment = backstoryUI.threatAssessment + " | Grudge-holder";
                };
            };
        } else {
            backstoryUI.threatAssessment = "";
        };

        // Gang Affiliation Section - use detailed profiles (no rank - game shows that as NPC name)
        if isGangMember {
            let gangData = GangProfileGenerator.Generate(seed + 6000, gangAffiliation, appearanceName, lifePath.gender);
            backstoryUI.gangAffiliation = gangData.gangName + " | " + gangData.role + " | " + IntToString(gangData.yearsActive) + " yrs active";
            
            // Extra details on medium/high density
            if density >= 2 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Territory: " + gangData.territory;
                
                // Gang-specific stats
                if Equals(gangAffiliation, "MAELSTROM") && gangData.chromePercentage > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Chrome: " + IntToString(gangData.chromePercentage) + "%";
                };
                if Equals(gangAffiliation, "ANIMALS") && gangData.fightWins > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Fight Record: " + IntToString(gangData.fightWins) + "W-" + IntToString(gangData.fightLosses) + "L";
                };
                if Equals(gangAffiliation, "VOODOO_BOYS") && gangData.systemsCompromised > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Systems Hit: " + IntToString(gangData.systemsCompromised);
                };
                if Equals(gangAffiliation, "SCAVENGERS") && gangData.organsHarvested > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Harvests: " + IntToString(gangData.organsHarvested);
                };
                if Equals(gangAffiliation, "WRAITHS") && gangData.successfulRaids > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Raids: " + IntToString(gangData.successfulRaids);
                };
                if Equals(gangAffiliation, "ALDECALDOS") && gangData.convoyRuns > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Convoy Runs: " + IntToString(gangData.convoyRuns);
                };
                if Equals(gangAffiliation, "MOXES") && gangData.peopleProtected > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Protected: " + IntToString(gangData.peopleProtected);
                };
                if Equals(gangAffiliation, "6TH_STREET") && NotEquals(gangData.priorService, "") {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Prior: " + gangData.priorService;
                };
                
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Loyalty: " + gangData.loyaltyRating;
                if density >= 3 && gangData.bodyCount > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Body Count: " + IntToString(gangData.bodyCount);
                };
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Status: " + gangData.status;
            };
        } else {
            backstoryUI.gangAffiliation = "";
        };

        // Rare NPC Flag - skip for NCPD, Barghest, and gang members, show on all density levels (it's rare enough)
        if !isNCPD && !isBarghest && !isGangMember && RareNPCManager.ShouldBeRareNPC(seed + 9999) {
            let rareData = RareNPCManager.Generate(seed + 10000, archetype);
            backstoryUI.rareFlag = rareData.displayFlag + " - " + rareData.rareType;
        } else {
            backstoryUI.rareFlag = "";
        };

        // NCPD Officer Detection and Name Generation
        if isNCPD {
            let ncpdData = NCPDNameGenerator.Generate(seed + 7000, appearanceName, lifePath.gender, ethnicity);
            
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
            // Extra NCPD details on medium/high density
            if density >= 2 {
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + ncpdData.unit;
                if density >= 3 && StrLen(ncpdData.specialization) > 0 {
                    backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Spec: " + ncpdData.specialization;
                };
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | District: " + ncpdData.assignedDistrict;
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | " + IntToString(ncpdData.yearsOfService) + " yrs service";
                if density >= 3 && ncpdData.confirmedNeutralizations > 0 {
                    backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Neutralizations: " + IntToString(ncpdData.confirmedNeutralizations);
                };
                backstoryUI.ncpdOfficer = backstoryUI.ncpdOfficer + " | Status: " + ncpdData.dutyStatus;
            };
        } else if isBarghest {
            // Barghest get militia service records - use gangAffiliation, not ncpdOfficer
            let barghestData = BarghestProfileManager.Generate(seed + 8000, appearanceName, lifePath.gender, ethnicity);
            
            // Build display name with callsign if present
            let displayName: String = "";
            if NotEquals(barghestData.callsign, "") {
                displayName = barghestData.barghestRank + " \"" + barghestData.callsign + "\" " + barghestData.fullName;
            } else {
                displayName = barghestData.barghestRank + " " + barghestData.fullName;
            };
            
            backstoryUI.gangAffiliation = "Barghest Militia | " + displayName + " | MOS: " + barghestData.mos;
            // Extra Barghest details on medium/high density
            if density >= 2 {
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Prior: " + barghestData.formerAffiliation;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Sector: " + barghestData.assignedSector;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | " + IntToString(barghestData.yearsBarghest) + " yrs Barghest";
                if density >= 3 && barghestData.confirmedKills > 0 {
                    backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Confirmed: " + IntToString(barghestData.confirmedKills);
                };
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Loyalty: " + barghestData.loyaltyRating;
                backstoryUI.gangAffiliation = backstoryUI.gangAffiliation + " | Status: " + barghestData.dutyStatus;
            };
            backstoryUI.ncpdOfficer = "";
        } else {
            backstoryUI.ncpdOfficer = "";
        };

        // Relationships - skip for NCPD, Barghest, and gang members, only on medium/high density
        if density >= 2 && !isNCPD && !isBarghest && !isGangMember {
            // Get NPC's last name so family members share it
            let npcLastName = BackstoryManager.ExtractLastName(target);
            let relations = RelationshipsManager.GenerateWithName(seed + 8000, archetype, gangAffiliation, ethnicity, npcLastName);
            backstoryUI.relationships = "";
            
            // Status and dependents
            backstoryUI.relationships = relations.currentRelationshipStatus;
            if relations.dependents > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Dependents: " + IntToString(relations.dependents);
            };
            
            // Emergency contact - high density only
            if density >= 3 && !Equals(relations.emergencyContact, "NONE ON FILE") {
                backstoryUI.relationships = backstoryUI.relationships + " | Emergency: " + relations.emergencyContact;
            };
            
            // Family members
            if ArraySize(relations.familyMembers) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Family: ";
                let i = 0;
                let maxFamily = 2;
                if density >= 3 {
                    maxFamily = 4;
                };
                if ArraySize(relations.familyMembers) < maxFamily {
                    maxFamily = ArraySize(relations.familyMembers);
                };
                while i < maxFamily {
                    let fam = relations.familyMembers[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + fam.name + " (" + fam.relation;
                    if !Equals(fam.status, "Alive") && !Equals(fam.status, "") {
                        backstoryUI.relationships = backstoryUI.relationships + " - " + fam.status;
                    };
                    backstoryUI.relationships = backstoryUI.relationships + ")";
                    i += 1;
                };
                if ArraySize(relations.familyMembers) > maxFamily {
                    backstoryUI.relationships = backstoryUI.relationships + " +" + IntToString(ArraySize(relations.familyMembers) - maxFamily) + " more";
                };
            };
            
            // Known associates
            if ArraySize(relations.knownAssociates) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Associates: ";
                let i = 0;
                let maxShow = 2;
                if density >= 3 {
                    maxShow = 3;
                };
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
                if ArraySize(relations.knownAssociates) > maxShow {
                    backstoryUI.relationships = backstoryUI.relationships + " +" + IntToString(ArraySize(relations.knownAssociates) - maxShow) + " more";
                };
            };
            
            // Professional contacts - high density only
            if density >= 3 && ArraySize(relations.professionalContacts) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | Contacts: ";
                let i = 0;
                while i < ArraySize(relations.professionalContacts) {
                    let pro = relations.professionalContacts[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + pro.name + " (" + pro.type + ")";
                    i += 1;
                };
            };
            
            // Known enemies - high density only
            if density >= 3 && ArraySize(relations.knownEnemies) > 0 {
                backstoryUI.relationships = backstoryUI.relationships + " | ENEMIES: ";
                let i = 0;
                while i < ArraySize(relations.knownEnemies) {
                    let enemy = relations.knownEnemies[i];
                    if i > 0 {
                        backstoryUI.relationships = backstoryUI.relationships + ", ";
                    };
                    backstoryUI.relationships = backstoryUI.relationships + enemy.name + " (" + enemy.reason + " - " + enemy.threatLevel + ")";
                    i += 1;
                };
            };
            
            // Romantic history - high density only
            if density >= 3 && !Equals(relations.romanticHistory, "") {
                backstoryUI.relationships = backstoryUI.relationships + " | History: " + relations.romanticHistory;
            };
            
            // Social network size - high density only
            if density >= 3 {
                backstoryUI.relationships = backstoryUI.relationships + " | Network: " + relations.socialNetworkSize;
            };
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
        
        ArrayPush(corpos, TextCorpos.NIPPON_NETWORK());
        ArrayPush(corpos, TextCorpos.DIVERSE_MEDIA());
        ArrayPush(corpos, TextCorpos.WORLD_NEWS());
        ArrayPush(corpos, TextCorpos.AKAROMI());
        ArrayPush(corpos, TextCorpos.CONAG());
        ArrayPush(corpos, TextCorpos.NN54());
        ArrayPush(corpos, TextCorpos.PETROCHEM());
        ArrayPush(corpos, TextCorpos.SOVOIL());
        ArrayPush(corpos, TextCorpos.ARASAKA());
        ArrayPush(corpos, TextCorpos.KANG_TAO());
        ArrayPush(corpos, TextCorpos.MILITECH());
        ArrayPush(corpos, TextCorpos.MITSU_SUGO());
        ArrayPush(corpos, TextCorpos.SEG_ATARI());
        ArrayPush(corpos, TextCorpos.TDS());
        ArrayPush(corpos, TextCorpos.AHI());
        ArrayPush(corpos, TextCorpos.EBM());
        ArrayPush(corpos, TextCorpos.IEC());
        ArrayPush(corpos, TextCorpos.MICROTECH());
        ArrayPush(corpos, TextCorpos.ZETATECH());
        ArrayPush(corpos, TextCorpos.ADREK_ROBO());
        ArrayPush(corpos, TextCorpos.AKAGI_SYS());
        ArrayPush(corpos, TextCorpos.BAKU_CHIPMASTERS());
        ArrayPush(corpos, TextCorpos.BIOTECHNICA());
        ArrayPush(corpos, TextCorpos.CYPHIRE());
        ArrayPush(corpos, TextCorpos.DAKAI());
        ArrayPush(corpos, TextCorpos.DYNALAR());
        ArrayPush(corpos, TextCorpos.KENJIRI());
        ArrayPush(corpos, TextCorpos.KIROSHI());
        ArrayPush(corpos, TextCorpos.TTI());
        ArrayPush(corpos, TextCorpos.MAF());
        ArrayPush(corpos, TextCorpos.TOYOTA());
        ArrayPush(corpos, TextCorpos.FUYUTSUKI());
        ArrayPush(corpos, TextCorpos.ORBITAL_AIR());
        ArrayPush(corpos, TextCorpos.WORLDSAT());
        ArrayPush(corpos, TextCorpos.EUROBANK());
        ArrayPush(corpos, TextCorpos.FUJIWARA());
        ArrayPush(corpos, TextCorpos.INFOCOMP());
        ArrayPush(corpos, TextCorpos.BAKENEKO());

        let corpoVal = RandRange(seed + 41948, 0, ArraySize(corpos)-1);

        return corpos[corpoVal];
    }

    // ========== CHILD NPC DETECTION & HANDLING ==========

    // Detect if NPC is a child based on appearance name patterns
    private static func IsChildNPC(appearanceName: String) -> Bool {
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

    // Extract last name from NPC's display name for family relationship consistency
    private static func ExtractLastName(target: wref<NPCPuppet>) -> String {
        let record = target.GetRecord();
        if !IsDefined(record) {
            return "";
        }
        
        // Try method 1: GetTweakDBFullDisplayName (used by scanner)
        let fullName = target.GetTweakDBFullDisplayName(true);
        
        // Try method 2: GetLocalizedTextByKey if first method fails
        if Equals(fullName, "") || StrLen(fullName) < 3 {
            fullName = GetLocalizedTextByKey(record.FullDisplayName());
        }
        
        // Check if it's a generic name we should ignore
        if Equals(fullName, "") || StrLen(fullName) < 3 ||
           Equals(fullName, "None") || 
           Equals(fullName, "Enemy") ||
           Equals(fullName, "Citizen") ||
           Equals(fullName, "Civilian") ||
           Equals(fullName, "Gang Member") ||
           Equals(fullName, "Thug") ||
           StrContains(fullName, "LocKey") {
            return "";
        }
        
        // Find last space - everything after is the last name
        let lastSpace = -1;
        let i = 0;
        let len = StrLen(fullName);
        while i < len {
            if Equals(StrMid(fullName, i, 1), " ") {
                lastSpace = i;
            }
            i += 1;
        }
        
        if lastSpace > 0 && lastSpace < len - 1 {
            return StrMid(fullName, lastSpace + 1, len - lastSpace - 1);
        }
        
        // No space found or edge case - return empty (will use random)
        return "";
    }
}
