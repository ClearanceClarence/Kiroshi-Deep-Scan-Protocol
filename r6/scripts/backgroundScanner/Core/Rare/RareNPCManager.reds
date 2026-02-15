// Rare NPC Generation System
// Handles special flagged NPCs with unique classifications and backstories
public class KdspRareNPCManager {

    // Check if this NPC should be rare based on settings
    public static func ShouldBeRareNPC(seed: Int32) -> Bool {
        let rarity = KdspSettings.GetSpecialNPCRarity();
        
        // 0 = disabled
        if rarity <= 0 {
            return false;
        }
        
        // Roll 1 in [rarity] chance
        return RandRange(seed, 1, rarity) == 1;
    }

    public static func Generate(seed: Int32, archetype: String) -> ref<KdspRareNPCData> {
        let rareData: ref<KdspRareNPCData> = new KdspRareNPCData();

        // Determine rare type
        let rareType = KdspRareNPCManager.DetermineRareType(seed);
        rareData.rareType = rareType;
        rareData.isRare = true;

        // Generate based on type - Original types
        if Equals(rareType, "SLEEPER_AGENT") {
            rareData = KdspRareNPCManager.GenerateSleeperAgent(seed, rareData);
        }
        else if Equals(rareType, "PRE_CYBERPSYCHO") {
            rareData = KdspRareNPCManager.GeneratePreCyberpsycho(seed, rareData);
        }
        else if Equals(rareType, "LEGACY_CHARACTER") {
            rareData = KdspRareNPCManager.GenerateLegacyCharacter(seed, rareData);
        }
        else if Equals(rareType, "TIME_ANOMALY") {
            rareData = KdspRareNPCManager.GenerateTimeAnomaly(seed, rareData);
        }
        else if Equals(rareType, "GHOST") {
            rareData = KdspRareNPCManager.GenerateGhost(seed, rareData);
        }
        else if Equals(rareType, "WITNESS") {
            rareData = KdspRareNPCManager.GenerateWitness(seed, rareData);
        }
        else if Equals(rareType, "HUNTED") {
            rareData = KdspRareNPCManager.GenerateHunted(seed, rareData);
        }
        else if Equals(rareType, "AI_CONTACT") {
            rareData = KdspRareNPCManager.GenerateAIContact(seed, rareData);
        }
        else if Equals(rareType, "CORPO_WHISTLEBLOWER") {
            rareData = KdspRareNPCManager.GenerateWhistleblower(seed, rareData);
        }
        else if Equals(rareType, "HIDDEN_NETRUNNER") {
            rareData = KdspRareNPCManager.GenerateHiddenNetrunner(seed, rareData);
        }
        // v1.6 Expanded types
        else if Equals(rareType, "UNDERCOVER_COP") {
            rareData = KdspRareNPCManager.GenerateUndercoverCop(seed, rareData);
        }
        else if Equals(rareType, "RETIRED_LEGEND") {
            rareData = KdspRareNPCManager.GenerateRetiredLegend(seed, rareData);
        }
        else if Equals(rareType, "CLONE_SUBJECT") {
            rareData = KdspRareNPCManager.GenerateCloneSubject(seed, rareData);
        }
        else if Equals(rareType, "MAXTAC_TARGET") {
            rareData = KdspRareNPCManager.GenerateMaxtacTarget(seed, rareData);
        }
        else if Equals(rareType, "WITNESS_PROTECTION") {
            rareData = KdspRareNPCManager.GenerateWitnessProtection(seed, rareData);
        }
        else if Equals(rareType, "ENGRAM_CANDIDATE") {
            rareData = KdspRareNPCManager.GenerateEngramCandidate(seed, rareData);
        }
        else if Equals(rareType, "CORPO_DEFECTOR") {
            rareData = KdspRareNPCManager.GenerateCorpoDefector(seed, rareData);
        }
        else if Equals(rareType, "GANG_INFILTRATOR") {
            rareData = KdspRareNPCManager.GenerateGangInfiltrator(seed, rareData);
        }
        else if Equals(rareType, "TRAUMA_TEAM_MARKED") {
            rareData = KdspRareNPCManager.GenerateTraumaTeamMarked(seed, rareData);
        }
        else if Equals(rareType, "FIXER_ASSET") {
            rareData = KdspRareNPCManager.GenerateFixerAsset(seed, rareData);
        }
        else if Equals(rareType, "BLACKMAIL_VICTIM") {
            rareData = KdspRareNPCManager.GenerateBlackmailVictim(seed, rareData);
        }
        else if Equals(rareType, "MILITARY_AWOL") {
            rareData = KdspRareNPCManager.GenerateMilitaryAwol(seed, rareData);
        }
        else if Equals(rareType, "EXPERIMENTAL_SUBJECT") {
            rareData = KdspRareNPCManager.GenerateExperimentalSubject(seed, rareData);
        }
        else if Equals(rareType, "DEBT_COLLECTION") {
            rareData = KdspRareNPCManager.GenerateDebtCollection(seed, rareData);
        }
        else if Equals(rareType, "ORGAN_MARKED") {
            rareData = KdspRareNPCManager.GenerateOrganMarked(seed, rareData);
        }
        else if Equals(rareType, "CULT_ESCAPEE") {
            rareData = KdspRareNPCManager.GenerateCultEscapee(seed, rareData);
        }
        else if Equals(rareType, "RELIC_COMPATIBLE") {
            rareData = KdspRareNPCManager.GenerateRelicCompatible(seed, rareData);
        }
        else if Equals(rareType, "DATA_COURIER") {
            rareData = KdspRareNPCManager.GenerateDataCourier(seed, rareData);
        }
        else if Equals(rareType, "DOUBLE_AGENT") {
            rareData = KdspRareNPCManager.GenerateDoubleAgent(seed, rareData);
        }
        else if Equals(rareType, "NOMAD_EXILE") {
            rareData = KdspRareNPCManager.GenerateNomadExile(seed, rareData);
        }
        // v1.7 New types
        else if Equals(rareType, "BRAINDANCE_ADDICT") {
            rareData = KdspRareNPCManager.GenerateBraindanceAddict(seed, rareData);
        }
        else if Equals(rareType, "NIGHT_CORP_SUBJECT") {
            rareData = KdspRareNPCManager.GenerateNightCorpSubject(seed, rareData);
        }
        else if Equals(rareType, "DOLL_CHIP_SLEEPER") {
            rareData = KdspRareNPCManager.GenerateDollChipSleeper(seed, rareData);
        }
        else if Equals(rareType, "SOULKILLER_SURVIVOR") {
            rareData = KdspRareNPCManager.GenerateSoulkillerSurvivor(seed, rareData);
        }
        else if Equals(rareType, "BLACKWALL_TOUCHED") {
            rareData = KdspRareNPCManager.GenerateBlackwallTouched(seed, rareData);
        }
        else if Equals(rareType, "SIGNAL_CARRIER") {
            rareData = KdspRareNPCManager.GenerateSignalCarrier(seed, rareData);
        }
        else if Equals(rareType, "MEMORY_WIPED") {
            rareData = KdspRareNPCManager.GenerateMemoryWiped(seed, rareData);
        }
        else if Equals(rareType, "IDENTITY_STOLEN") {
            rareData = KdspRareNPCManager.GenerateIdentityStolen(seed, rareData);
        }
        else if Equals(rareType, "MISSING_PERSON") {
            rareData = KdspRareNPCManager.GenerateMissingPerson(seed, rareData);
        }
        else if Equals(rareType, "ACTIVE_BOUNTY") {
            rareData = KdspRareNPCManager.GenerateActiveBounty(seed, rareData);
        }
        else if Equals(rareType, "UNREGISTERED_CHROME") {
            rareData = KdspRareNPCManager.GenerateUnregisteredChrome(seed, rareData);
        }
        else if Equals(rareType, "POLITICAL_DISSIDENT") {
            rareData = KdspRareNPCManager.GeneratePoliticalDissident(seed, rareData);
        }
        else if Equals(rareType, "NEURAL_DIVERGENT") {
            rareData = KdspRareNPCManager.GenerateNeuralDivergent(seed, rareData);
        }
        else if Equals(rareType, "SYNTHETIC_SLEEPER") {
            rareData = KdspRareNPCManager.GenerateSyntheticSleeper(seed, rareData);
        }
        else if Equals(rareType, "BURIED_PAST") {
            rareData = KdspRareNPCManager.GenerateBuriedPast(seed, rareData);
        }
        else if Equals(rareType, "COMBAT_ZONE_SURVIVOR") {
            rareData = KdspRareNPCManager.GenerateCombatZoneSurvivor(seed, rareData);
        }
        else if Equals(rareType, "ARASAKA_BLOODLINE") {
            rareData = KdspRareNPCManager.GenerateArasakaBloodline(seed, rareData);
        }
        else if Equals(rareType, "BIOPLAGUE_CARRIER") {
            rareData = KdspRareNPCManager.GenerateBioplagueCarrier(seed, rareData);
        }
        else if Equals(rareType, "REAPER_CONTRACT") {
            rareData = KdspRareNPCManager.GenerateReaperContract(seed, rareData);
        }
        else if Equals(rareType, "DELAMAIN_GLITCH") {
            rareData = KdspRareNPCManager.GenerateDelaminGlitch(seed, rareData);
        }
        else if Equals(rareType, "IMPLANT_BOMB") {
            rareData = KdspRareNPCManager.GenerateImplantBomb(seed, rareData);
        }
        else if Equals(rareType, "NCPD_INFORMANT") {
            rareData = KdspRareNPCManager.GenerateNCPDInformant(seed, rareData);
        }
        else if Equals(rareType, "TECHNO_NECRO") {
            rareData = KdspRareNPCManager.GenerateTechnoNecro(seed, rareData);
        }
        else if Equals(rareType, "RADIATION_EXPOSURE") {
            rareData = KdspRareNPCManager.GenerateRadiationExposure(seed, rareData);
        }
        else if Equals(rareType, "AI_PUPPET") {
            rareData = KdspRareNPCManager.GenerateAIPuppet(seed, rareData);
        }
        else if Equals(rareType, "BLACK_ICE_SURVIVOR") {
            rareData = KdspRareNPCManager.GenerateBlackIceSurvivor(seed, rareData);
        }
        else if Equals(rareType, "PERSONALITY_FRAGMENT") {
            rareData = KdspRareNPCManager.GeneratePersonalityFragment(seed, rareData);
        }
        else if Equals(rareType, "CORPO_ASSET_FROZEN") {
            rareData = KdspRareNPCManager.GenerateCorpoAssetFrozen(seed, rareData);
        }
        else if Equals(rareType, "DREAMTECH_VICTIM") {
            rareData = KdspRareNPCManager.GenerateDreamtechVictim(seed, rareData);
        }
        else if Equals(rareType, "CONTAMINATED_SCOP") {
            rareData = KdspRareNPCManager.GenerateContaminatedScop(seed, rareData);
        }
        // v1.7 New types (continued)
        else if Equals(rareType, "CORPO_HEIR_HIDING") {
            rareData = KdspRareNPCManager.GenerateCorpoHeirHiding(seed, rareData);
        }
        else if Equals(rareType, "FLATLINE_REVIVED") {
            rareData = KdspRareNPCManager.GenerateFlatlineRevived(seed, rareData);
        }
        else if Equals(rareType, "ILLEGAL_BD_PRODUCER") {
            rareData = KdspRareNPCManager.GenerateIllegalBDProducer(seed, rareData);
        }
        else if Equals(rareType, "DEEP_FAKE_IDENTITY") {
            rareData = KdspRareNPCManager.GenerateDeepFakeIdentity(seed, rareData);
        }
        else if Equals(rareType, "CYBERPSYCHO_RECOVERED") {
            rareData = KdspRareNPCManager.GenerateCyberpsychoRecovered(seed, rareData);
        }
        else if Equals(rareType, "DRAGON_COURIER") {
            rareData = KdspRareNPCManager.GenerateDragonCourier(seed, rareData);
        }
        else if Equals(rareType, "PERALEZ_PROTOCOL") {
            rareData = KdspRareNPCManager.GeneratePeralezProtocol(seed, rareData);
        }
        else if Equals(rareType, "IMMUNE_ANOMALY") {
            rareData = KdspRareNPCManager.GenerateImmuneAnomaly(seed, rareData);
        }
        else if Equals(rareType, "GHOST_IN_MACHINE") {
            rareData = KdspRareNPCManager.GenerateGhostInMachine(seed, rareData);
        }
        else if Equals(rareType, "INDENTURED_CORPO") {
            rareData = KdspRareNPCManager.GenerateIndenturedCorpo(seed, rareData);
        }
        else if Equals(rareType, "SCOP_FARMER_REFUGEE") {
            rareData = KdspRareNPCManager.GenerateScorpFarmerRefugee(seed, rareData);
        }
        else if Equals(rareType, "PRECOG_SUBJECT") {
            rareData = KdspRareNPCManager.GeneratePrecogSubject(seed, rareData);
        }
        else if Equals(rareType, "SMUGGLER_TUNNEL_OPERATOR") {
            rareData = KdspRareNPCManager.GenerateSmugglerTunnel(seed, rareData);
        }
        else if Equals(rareType, "ARASAKA_ENGRAM_ECHO") {
            rareData = KdspRareNPCManager.GenerateArasakaEngramEcho(seed, rareData);
        }
        else if Equals(rareType, "FERAL_ZONE_BORN") {
            rareData = KdspRareNPCManager.GenerateFeralZoneBorn(seed, rareData);
        }
        else if Equals(rareType, "CORPO_INTERN_TRAPPED") {
            rareData = KdspRareNPCManager.GenerateCorpoInternTrapped(seed, rareData);
        }
        else if Equals(rareType, "MAXTAC_WASHOUT") {
            rareData = KdspRareNPCManager.GenerateMaxtacWashout(seed, rareData);
        }
        else if Equals(rareType, "PROXY_VOTER") {
            rareData = KdspRareNPCManager.GenerateProxyVoter(seed, rareData);
        }
        else if Equals(rareType, "GENETIC_CHIMERA") {
            rareData = KdspRareNPCManager.GenerateGeneticChimera(seed, rareData);
        }
        else if Equals(rareType, "DARK_NET_LEGEND") {
            rareData = KdspRareNPCManager.GenerateDarkNetLegend(seed, rareData);
        }
        else if Equals(rareType, "CARGO_STOWAWAY") {
            rareData = KdspRareNPCManager.GenerateCargoStowaway(seed, rareData);
        }
        else if Equals(rareType, "CHRONO_DISPLACED") {
            rareData = KdspRareNPCManager.GenerateChronoDisplaced(seed, rareData);
        }
        else if Equals(rareType, "SOUL_SPLIT") {
            rareData = KdspRareNPCManager.GenerateSoulSplit(seed, rareData);
        }
        else if Equals(rareType, "INFECTED_FIRMWARE") {
            rareData = KdspRareNPCManager.GenerateInfectedFirmware(seed, rareData);
        }
        else if Equals(rareType, "WETWORK_RETIRED") {
            rareData = KdspRareNPCManager.GenerateWetworkRetired(seed, rareData);
        }
        else if Equals(rareType, "CHILD_SOLDIER_GROWN") {
            rareData = KdspRareNPCManager.GenerateChildSoldierGrown(seed, rareData);
        }
        else if Equals(rareType, "ILLEGAL_PROCREATION") {
            rareData = KdspRareNPCManager.GenerateIllegalProcreation(seed, rareData);
        }
        else if Equals(rareType, "ORBITAL_RETURNEE") {
            rareData = KdspRareNPCManager.GenerateOrbitalReturnee(seed, rareData);
        }
        else if Equals(rareType, "CORPO_DEBT_SLAVE") {
            rareData = KdspRareNPCManager.GenerateCorpoDebtSlave(seed, rareData);
        }
        else if Equals(rareType, "GHOST_TOWN_SURVIVOR") {
            rareData = KdspRareNPCManager.GenerateGhostTownSurvivor(seed, rareData);
        }

        return rareData;
    }

    private static func DetermineRareType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 89);
        
        // Original types (0-9)
        if i == 0 { return "SLEEPER_AGENT"; }
        if i == 1 { return "PRE_CYBERPSYCHO"; }
        if i == 2 { return "LEGACY_CHARACTER"; }
        if i == 3 { return "TIME_ANOMALY"; }
        if i == 4 { return "GHOST"; }
        if i == 5 { return "WITNESS"; }
        if i == 6 { return "HUNTED"; }
        if i == 7 { return "AI_CONTACT"; }
        if i == 8 { return "CORPO_WHISTLEBLOWER"; }
        if i == 9 { return "HIDDEN_NETRUNNER"; }
        
        // v1.6 Expanded types (10-29)
        if i == 10 { return "UNDERCOVER_COP"; }
        if i == 11 { return "RETIRED_LEGEND"; }
        if i == 12 { return "CLONE_SUBJECT"; }
        if i == 13 { return "MAXTAC_TARGET"; }
        if i == 14 { return "WITNESS_PROTECTION"; }
        if i == 15 { return "ENGRAM_CANDIDATE"; }
        if i == 16 { return "CORPO_DEFECTOR"; }
        if i == 17 { return "GANG_INFILTRATOR"; }
        if i == 18 { return "TRAUMA_TEAM_MARKED"; }
        if i == 19 { return "FIXER_ASSET"; }
        if i == 20 { return "BLACKMAIL_VICTIM"; }
        if i == 21 { return "MILITARY_AWOL"; }
        if i == 22 { return "EXPERIMENTAL_SUBJECT"; }
        if i == 23 { return "DEBT_COLLECTION"; }
        if i == 24 { return "ORGAN_MARKED"; }
        if i == 25 { return "CULT_ESCAPEE"; }
        if i == 26 { return "RELIC_COMPATIBLE"; }
        if i == 27 { return "DATA_COURIER"; }
        if i == 28 { return "DOUBLE_AGENT"; }
        if i == 29 { return "NOMAD_EXILE"; }

        // v1.7 New types (30-59)
        if i == 30 { return "BRAINDANCE_ADDICT"; }
        if i == 31 { return "NIGHT_CORP_SUBJECT"; }
        if i == 32 { return "DOLL_CHIP_SLEEPER"; }
        if i == 33 { return "SOULKILLER_SURVIVOR"; }
        if i == 34 { return "BLACKWALL_TOUCHED"; }
        if i == 35 { return "SIGNAL_CARRIER"; }
        if i == 36 { return "MEMORY_WIPED"; }
        if i == 37 { return "IDENTITY_STOLEN"; }
        if i == 38 { return "MISSING_PERSON"; }
        if i == 39 { return "ACTIVE_BOUNTY"; }
        if i == 40 { return "UNREGISTERED_CHROME"; }
        if i == 41 { return "POLITICAL_DISSIDENT"; }
        if i == 42 { return "NEURAL_DIVERGENT"; }
        if i == 43 { return "SYNTHETIC_SLEEPER"; }
        if i == 44 { return "BURIED_PAST"; }
        if i == 45 { return "COMBAT_ZONE_SURVIVOR"; }
        if i == 46 { return "ARASAKA_BLOODLINE"; }
        if i == 47 { return "BIOPLAGUE_CARRIER"; }
        if i == 48 { return "REAPER_CONTRACT"; }
        if i == 49 { return "DELAMAIN_GLITCH"; }
        if i == 50 { return "IMPLANT_BOMB"; }
        if i == 51 { return "NCPD_INFORMANT"; }
        if i == 52 { return "TECHNO_NECRO"; }
        if i == 53 { return "RADIATION_EXPOSURE"; }
        if i == 54 { return "AI_PUPPET"; }
        if i == 55 { return "BLACK_ICE_SURVIVOR"; }
        if i == 56 { return "PERSONALITY_FRAGMENT"; }
        if i == 57 { return "CORPO_ASSET_FROZEN"; }
        if i == 58 { return "DREAMTECH_VICTIM"; }
        if i == 59 { return "CONTAMINATED_SCOP"; }

        // v1.7 Continued (60-89)
        if i == 60 { return "CORPO_HEIR_HIDING"; }
        if i == 61 { return "FLATLINE_REVIVED"; }
        if i == 62 { return "ILLEGAL_BD_PRODUCER"; }
        if i == 63 { return "DEEP_FAKE_IDENTITY"; }
        if i == 64 { return "CYBERPSYCHO_RECOVERED"; }
        if i == 65 { return "DRAGON_COURIER"; }
        if i == 66 { return "PERALEZ_PROTOCOL"; }
        if i == 67 { return "IMMUNE_ANOMALY"; }
        if i == 68 { return "GHOST_IN_MACHINE"; }
        if i == 69 { return "INDENTURED_CORPO"; }
        if i == 70 { return "SCOP_FARMER_REFUGEE"; }
        if i == 71 { return "PRECOG_SUBJECT"; }
        if i == 72 { return "SMUGGLER_TUNNEL_OPERATOR"; }
        if i == 73 { return "ARASAKA_ENGRAM_ECHO"; }
        if i == 74 { return "FERAL_ZONE_BORN"; }
        if i == 75 { return "CORPO_INTERN_TRAPPED"; }
        if i == 76 { return "MAXTAC_WASHOUT"; }
        if i == 77 { return "PROXY_VOTER"; }
        if i == 78 { return "GENETIC_CHIMERA"; }
        if i == 79 { return "DARK_NET_LEGEND"; }
        if i == 80 { return "CARGO_STOWAWAY"; }
        if i == 81 { return "CHRONO_DISPLACED"; }
        if i == 82 { return "SOUL_SPLIT"; }
        if i == 83 { return "INFECTED_FIRMWARE"; }
        if i == 84 { return "WETWORK_RETIRED"; }
        if i == 85 { return "CHILD_SOLDIER_GROWN"; }
        if i == 86 { return "ILLEGAL_PROCREATION"; }
        if i == 87 { return "ORBITAL_RETURNEE"; }
        if i == 88 { return "CORPO_DEBT_SLAVE"; }
        return "GHOST_TOWN_SURVIVOR";
    }

    private static func GenerateSleeperAgent(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "██ DEEP COVER OPERATIVE ██";
        data.flagColor = "RED";
        
        let agencies: array<String>;
        ArrayPush(agencies, "ARASAKA COVERT OPS");
        ArrayPush(agencies, "MILITECH BLACK DIVISION");
        ArrayPush(agencies, "NETWATCH");
        ArrayPush(agencies, "NUSA INTELLIGENCE");
        ArrayPush(agencies, "UNKNOWN FOREIGN AGENCY");
        ArrayPush(agencies, "CORPORATE COUNTER-INTEL");

        data.secretAffiliation = agencies[RandRange(seed, 0, ArraySize(agencies) - 1)];
        
        data.description = "ALERT: Subject identity is a fabricated cover. True identity classified at highest levels. ";
        data.description += "Activation status: " + (RandRange(seed + 10, 1, 100) <= 30 ? "ACTIVE" : "DORMANT") + ". ";
        data.description += "Handler: [REDACTED]. Mission parameters: [CLASSIFIED]. ";
        data.description += "WARNING: Do not approach. Do not engage. Report sighting immediately.";

        data.hiddenInfo = "Agent has been embedded for " + IntToString(RandRange(seed + 20, 2, 15)) + " years. ";
        data.hiddenInfo += "Cover identity rated: DEEP. Suspected mission: " + KdspRareNPCManager.GetSleeperMission(seed + 30);

        data.scannerWarning = "FILE LOCKED - CLEARANCE INSUFFICIENT";
        data.dangerLevel = "UNKNOWN - ASSUME EXTREME";

        return data;
    }

    private static func GetSleeperMission(seed: Int32) -> String {
        let missions: array<String>;
        ArrayPush(missions, "Corporate infiltration");
        ArrayPush(missions, "Gang intelligence");
        ArrayPush(missions, "Political surveillance");
        ArrayPush(missions, "Technology theft");
        ArrayPush(missions, "Assassination preparation");
        ArrayPush(missions, "Network mapping");
        
        return missions[RandRange(seed, 0, ArraySize(missions) - 1)];
    }

    private static func GeneratePreCyberpsycho(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⚠ CYBERPSYCHOSIS WARNING ⚠";
        data.flagColor = "ORANGE";

        let stage = RandRange(seed, 1, 5);
        data.secretAffiliation = "NONE - MEDICAL CONCERN";

        data.description = "PSYCHOLOGICAL ALERT: Subject displaying escalating cyberpsychosis indicators. ";
        data.description += "Current stage: " + IntToString(stage) + "/5. ";
        
        let symptoms: array<String>;
        ArrayPush(symptoms, "Increasing paranoid ideation");
        ArrayPush(symptoms, "Violent outbursts reported");
        ArrayPush(symptoms, "Dissociation from humanity");
        ArrayPush(symptoms, "Obsessive cyberware acquisition");
        ArrayPush(symptoms, "Emotional numbing");
        ArrayPush(symptoms, "Delusional episodes");
        
        data.description += "Primary symptoms: " + symptoms[RandRange(seed + 10, 0, ArraySize(symptoms) - 1)] + ", ";
        data.description += symptoms[RandRange(seed + 20, 0, ArraySize(symptoms) - 1)] + ". ";
        
        if stage >= 4 {
            data.description += "CRITICAL: Full break imminent. MaxTac notification pending.";
            data.dangerLevel = "EXTREME - POTENTIAL CYBERPSYCHO";
        } else {
            data.description += "Intervention recommended before escalation.";
            data.dangerLevel = "HIGH - UNSTABLE";
        }

        data.hiddenInfo = "Last therapy session: " + IntToString(RandRange(seed + 30, 6, 36)) + " months ago. ";
        data.hiddenInfo += "Cyberware saturation: " + IntToString(RandRange(seed + 40, 75, 98)) + "%. ";
        data.hiddenInfo += "Previous incidents: " + IntToString(RandRange(seed + 50, 1, 5));

        data.scannerWarning = "APPROACH WITH EXTREME CAUTION - PSYCHOTIC BREAK POSSIBLE";

        return data;
    }

    private static func GenerateLegacyCharacter(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ HISTORICAL CONNECTION ★";
        data.flagColor = "GOLD";

        let connections: array<String>;
        let details: array<String>;

        ArrayPush(connections, "SILVERHAND");
        ArrayPush(details, "Genetic analysis indicates possible relation to Johnny Silverhand. Blood relative or clone origin unclear.");
        
        ArrayPush(connections, "ARASAKA");
        ArrayPush(details, "Distant relative of the Arasaka family. Removed from official records after corporate restructuring.");
        
        ArrayPush(connections, "BLACKHAND");
        ArrayPush(details, "Records suggest connection to Morgan Blackhand. Possibly trained by or descended from the legendary solo.");
        
        ArrayPush(connections, "BARTMOSS");
        ArrayPush(details, "Unusual neural patterns match theoretical Bartmoss engram fragments. Origin unknown.");
        
        ArrayPush(connections, "ALT_CUNNINGHAM");
        ArrayPush(details, "Displays anomalous netrunning capabilities. Possible connection to Alt Cunningham's research.");

        let index = RandRange(seed, 0, ArraySize(connections) - 1);
        data.secretAffiliation = connections[index] + " CONNECTION";
        data.description = details[index];
        
        data.hiddenInfo = "This connection is suppressed in public databases. ";
        data.hiddenInfo += "Arasaka flag: " + (RandRange(seed + 10, 1, 100) <= 50 ? "ACTIVE" : "INACTIVE") + ". ";
        data.hiddenInfo += "Subject awareness of connection: " + (RandRange(seed + 20, 1, 100) <= 30 ? "LIKELY" : "UNKNOWN");

        data.scannerWarning = "FLAGGED FOR HISTORICAL SIGNIFICANCE";
        data.dangerLevel = "VARIABLE - MONITOR";

        return data;
    }

    private static func GenerateTimeAnomaly(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ TEMPORAL ANOMALY ◈";
        data.flagColor = "PURPLE";

        data.secretAffiliation = "UNKNOWN - DATA CORRUPTION SUSPECTED";

        // Generate impossible dates
        let birthYear = RandRange(seed, 2085, 2120); // Future birth
        let deathYear = RandRange(seed + 10, 2040, 2065); // Past death

        data.description = "CRITICAL DATABASE ERROR: Temporal inconsistencies detected in subject records. ";
        data.description += "Birth date: " + IntToString(birthYear) + " (FUTURE). ";
        data.description += "Death date: " + IntToString(deathYear) + " (PAST). ";
        data.description += "Current status: ALIVE (VERIFIED). ";
        data.description += "Multiple existence confirmations across incompatible timelines. Data integrity: COMPROMISED.";

        let theories: array<String>;
        ArrayPush(theories, "Possible Blackwall data corruption");
        ArrayPush(theories, "Rogue AI manipulation of records");
        ArrayPush(theories, "Experimental technology subject");
        ArrayPush(theories, "Deep fake identity with corrupted source");
        ArrayPush(theories, "Unknown phenomenon");

        data.hiddenInfo = "Investigation status: ONGOING. ";
        data.hiddenInfo += "Theory: " + theories[RandRange(seed + 20, 0, ArraySize(theories) - 1)] + ". ";
        data.hiddenInfo += "NetWatch interest: HIGH. ";
        data.hiddenInfo += "Recommended action: OBSERVE AND REPORT";

        data.scannerWarning = "DATA INTEGRITY FAILURE - TIMELINE INCONSISTENT";
        data.dangerLevel = "UNKNOWN - ANOMALOUS";

        return data;
    }

    private static func GenerateGhost(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "? ENTITY NOT FOUND ?";
        data.flagColor = "GREY";

        data.secretAffiliation = "NO DATA";

        data.description = "ERROR: No records exist for scanned entity. ";
        data.description += "Biometric scan: VALID HUMAN. ";
        data.description += "Database match: NONE. ";
        data.description += "Cross-reference (NCPD, Corporate, Medical, Financial): NO RESULTS. ";
        data.description += "Subject appears to have no digital footprint whatsoever.";

        let possibilities: array<String>;
        ArrayPush(possibilities, "Deep cover operative with scrubbed identity");
        ArrayPush(possibilities, "Survivor of total identity theft");
        ArrayPush(possibilities, "Off-grid birth, never registered");
        ArrayPush(possibilities, "Witness protection (highest level)");
        ArrayPush(possibilities, "Escaped corporate experiment subject");
        ArrayPush(possibilities, "Digital ghost - existence deliberately erased");

        data.hiddenInfo = "Possible explanation: " + possibilities[RandRange(seed + 10, 0, ArraySize(possibilities) - 1)] + ". ";
        data.hiddenInfo += "Facial recognition: 0 matches worldwide. ";
        data.hiddenInfo += "This individual officially does not exist.";

        data.scannerWarning = "NO DATA AVAILABLE - IDENTITY UNKNOWN";
        data.dangerLevel = "UNASSESSABLE";

        return data;
    }

    private static func GenerateWitness(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ PROTECTED WITNESS ◉";
        data.flagColor = "BLUE";

        let cases: array<String>;
        ArrayPush(cases, "Arasaka Tower incident (2023)");
        ArrayPush(cases, "Corporate assassination (classified)");
        ArrayPush(cases, "Gang massacre survivor");
        ArrayPush(cases, "Cyberpsycho incident witness");
        ArrayPush(cases, "Corpo black site escapee");
        ArrayPush(cases, "Political assassination witness");

        data.secretAffiliation = "NCPD/CORPORATE WITNESS PROTECTION";

        data.description = "PROTECTED STATUS: Subject is enrolled in witness protection program. ";
        data.description += "Original case: " + cases[RandRange(seed, 0, ArraySize(cases) - 1)] + ". ";
        data.description += "Threat assessment to witness: ONGOING. ";
        data.description += "Current cover identity active since: " + IntToString(RandRange(seed + 10, 2070, 2076)) + ".";

        data.hiddenInfo = "Original identity: [SEALED]. ";
        data.hiddenInfo += "Parties seeking witness: " + IntToString(RandRange(seed + 20, 1, 4)) + " known organizations. ";
        data.hiddenInfo += "Bounty (unofficial): €$" + IntToString(RandRange(seed + 30, 50000, 500000));

        data.scannerWarning = "WITNESS PROTECTION - DO NOT DISCLOSE LOCATION";
        data.dangerLevel = "PROTECTED ASSET - HANDLE CAREFULLY";

        return data;
    }

    private static func GenerateHunted(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⊗ ACTIVE HUNT TARGET ⊗";
        data.flagColor = "RED";

        let hunters: array<String>;
        ArrayPush(hunters, "Arasaka Black Ops");
        ArrayPush(hunters, "Militech Enforcement");
        ArrayPush(hunters, "Multiple gang contracts");
        ArrayPush(hunters, "Unknown corporate entity");
        ArrayPush(hunters, "International bounty hunters");
        ArrayPush(hunters, "NetWatch termination order");

        data.secretAffiliation = "TARGET";

        data.description = "ALERT: Subject has active termination/capture orders from multiple parties. ";
        data.description += "Primary hunter: " + hunters[RandRange(seed, 0, ArraySize(hunters) - 1)] + ". ";
        data.description += "Total bounty value: €$" + IntToString(RandRange(seed + 10, 100000, 2000000)) + ". ";
        data.description += "Status: ACTIVELY EVADING. Days on run: " + IntToString(RandRange(seed + 20, 30, 500)) + ".";

        let reasons: array<String>;
        ArrayPush(reasons, "Stole proprietary technology");
        ArrayPush(reasons, "Killed high-value target");
        ArrayPush(reasons, "Possesses classified information");
        ArrayPush(reasons, "Betrayed organization");
        ArrayPush(reasons, "Witnessed something they shouldn't");

        data.hiddenInfo = "Reason for hunt: " + reasons[RandRange(seed + 30, 0, ArraySize(reasons) - 1)] + ". ";
        data.hiddenInfo += "Near-miss captures: " + IntToString(RandRange(seed + 40, 2, 8)) + ". ";
        data.hiddenInfo += "Survival assessment: " + (RandRange(seed + 50, 1, 100) <= 30 ? "LOW" : "MODERATE");

        data.scannerWarning = "HIGH-VALUE TARGET - MULTIPLE PARTIES SEEKING";
        data.dangerLevel = "EXTREME - DESPERATE AND DANGEROUS";

        return data;
    }

    private static func GenerateAIContact(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◬ BLACKWALL CONTACT ◬";
        data.flagColor = "CYAN";

        data.secretAffiliation = "UNKNOWN AI ENTITY";

        data.description = "NETWATCH ALERT: Subject has confirmed or suspected contact with rogue AI beyond the Blackwall. ";
        data.description += "Contact type: " + (RandRange(seed, 1, 100) <= 50 ? "WILLING" : "UNKNOWN") + ". ";
        data.description += "Neural contamination: " + (RandRange(seed + 10, 1, 100) <= 40 ? "DETECTED" : "SUSPECTED") + ". ";
        data.description += "Behavioral changes noted since contact initiation.";

        data.hiddenInfo = "AI designation: [UNIDENTIFIED BLACKWALL ENTITY]. ";
        data.hiddenInfo += "Communication method: Direct neural link. ";
        data.hiddenInfo += "NetWatch monitoring status: ACTIVE. ";
        data.hiddenInfo += "Termination recommendation: " + (RandRange(seed + 20, 1, 100) <= 30 ? "APPROVED" : "PENDING REVIEW");

        data.scannerWarning = "AI CONTACT SUSPECTED - NETWATCH FLAGGED";
        data.dangerLevel = "EXTREME - POTENTIAL VECTOR";

        return data;
    }

    private static func GenerateWhistleblower(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◇ CORPORATE LEAK ◇";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "Arasaka");
        ArrayPush(corps, "Militech");
        ArrayPush(corps, "Biotechnica");
        ArrayPush(corps, "Kang Tao");
        ArrayPush(corps, "Zetatech");
        ArrayPush(corps, "Trauma Team");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = "FORMER " + corp + " EMPLOYEE";

        data.description = "CORPORATE ALERT: Subject identified as source of confidential data leak from " + corp + ". ";
        data.description += "Leak severity: " + (RandRange(seed + 10, 1, 100) <= 50 ? "CRITICAL" : "SIGNIFICANT") + ". ";
        data.description += "Data compromised: " + KdspRareNPCManager.GetLeakedData(seed + 20) + ". ";
        data.description += "Corporate response: ACTIVE RETRIEVAL OPERATION.";

        data.hiddenInfo = "Former position: " + KdspRareNPCManager.GetCorpoPosition(seed + 30) + ". ";
        data.hiddenInfo += "Data sold to: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Media outlet" : "Rival corporation") + ". ";
        data.hiddenInfo += "Price received: €$" + IntToString(RandRange(seed + 50, 100000, 5000000));

        data.scannerWarning = "CORPORATE TARGET - EXTRACTION TEAMS DEPLOYED";
        data.dangerLevel = "HIGH - CORPORATE ASSETS INBOUND";

        return data;
    }

    private static func GetLeakedData(seed: Int32) -> String {
        let data: array<String>;
        ArrayPush(data, "Research and development files");
        ArrayPush(data, "Financial records showing illegal activity");
        ArrayPush(data, "Human experimentation documentation");
        ArrayPush(data, "Assassination order records");
        ArrayPush(data, "Blackmail material on executives");
        ArrayPush(data, "Classified weapons projects");
        
        return data[RandRange(seed, 0, ArraySize(data) - 1)];
    }

    private static func GetCorpoPosition(seed: Int32) -> String {
        let positions: array<String>;
        ArrayPush(positions, "Senior Data Analyst");
        ArrayPush(positions, "Security Administrator");
        ArrayPush(positions, "Research Scientist");
        ArrayPush(positions, "Executive Assistant");
        ArrayPush(positions, "Internal Auditor");
        ArrayPush(positions, "Systems Administrator");
        
        return positions[RandRange(seed, 0, ArraySize(positions) - 1)];
    }

    private static func GenerateHiddenNetrunner(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ HIDDEN NETRUNNER ◈";
        data.flagColor = "CYAN";

        data.secretAffiliation = "UNDERGROUND NETRUNNER";

        let aliases: array<String>;
        ArrayPush(aliases, "zer0c00l");
        ArrayPush(aliases, "gh0st_in_machine");
        ArrayPush(aliases, "blackICE_queen");
        ArrayPush(aliases, "datakrash");
        ArrayPush(aliases, "neural_nomad");
        ArrayPush(aliases, "cipher_punk");

        let alias = aliases[RandRange(seed, 0, ArraySize(aliases) - 1)];

        data.description = "NETWATCH ALERT: Subject identified as underground netrunner operating under alias '" + alias + "'. ";
        data.description += "Skill assessment: " + (RandRange(seed + 10, 1, 100) <= 30 ? "ELITE" : "ADVANCED") + ". ";
        data.description += "Known operations: Data theft, corporate espionage, infrastructure attacks. ";
        data.description += "Current bounty (NetWatch): €$" + IntToString(RandRange(seed + 20, 50000, 500000)) + ".";

        data.hiddenInfo = "Last known deep dive: " + IntToString(RandRange(seed + 30, 1, 30)) + " days ago. ";
        data.hiddenInfo += "Suspected Blackwall proximity: " + IntToString(RandRange(seed + 40, 1, 100)) + "%. ";
        data.hiddenInfo += "Known associates: Voodoo Boys (suspected). ";
        data.hiddenInfo += "Capture priority: " + (RandRange(seed + 50, 1, 100) <= 40 ? "HIGH" : "MEDIUM");

        data.scannerWarning = "NETWATCH TARGET - APPROACH MAY TRIGGER ICE DEPLOYMENT";
        data.dangerLevel = "HIGH - NETRUNNING CAPABILITIES";

        return data;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // v1.6 EXPANDED FLAGGED INDIVIDUAL TYPES
    // ═══════════════════════════════════════════════════════════════════════

    private static func GenerateUndercoverCop(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ UNDERCOVER OFFICER ◉";
        data.flagColor = "BLUE";
        data.secretAffiliation = "NCPD SPECIAL OPERATIONS";

        let units: array<String>;
        ArrayPush(units, "Gang Intelligence Unit");
        ArrayPush(units, "Narcotics Division");
        ArrayPush(units, "Organized Crime Task Force");
        ArrayPush(units, "Vice Squad");
        ArrayPush(units, "Counter-Terrorism");

        let unit = units[RandRange(seed, 0, ArraySize(units) - 1)];
        let years = IntToString(RandRange(seed + 10, 1, 8));

        data.description = "NCPD CLASSIFIED: Subject is undercover officer assigned to " + unit + ". ";
        data.description += "Deep cover status: " + years + " years. Handler: [REDACTED]. ";
        data.description += "WARNING: Blowing cover could result in officer death and case collapse.";

        data.hiddenInfo = "Badge number: [CLASSIFIED]. Real identity protected by court order. ";
        data.hiddenInfo += "Current target: " + KdspRareNPCManager.GetUndercoverTarget(seed + 20);

        data.scannerWarning = "NCPD PROTECTED ASSET - DO NOT EXPOSE";
        data.dangerLevel = "VARIABLE - DEEP COVER";

        return data;
    }

    private static func GetUndercoverTarget(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Maelstrom leadership"; }
        if i == 1 { return "Tyger Claws operations"; }
        if i == 2 { return "6th Street weapons trafficking"; }
        if i == 3 { return "Valentinos drug network"; }
        if i == 4 { return "Scav harvesting ring"; }
        return "Fixer network mapping";
    }

    private static func GenerateRetiredLegend(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ RETIRED LEGEND ★";
        data.flagColor = "GOLD";

        let professions: array<String>;
        let details: array<String>;

        ArrayPush(professions, "Former Solo");
        ArrayPush(details, "Legendary solo with " + IntToString(RandRange(seed, 50, 200)) + "+ confirmed operations. Officially retired but skills remain sharp.");

        ArrayPush(professions, "Ex-Netrunner");
        ArrayPush(details, "Former elite netrunner who survived multiple Blackwall encounters. Now living quietly under assumed identity.");

        ArrayPush(professions, "Retired Fixer");
        ArrayPush(details, "Once controlled half the contracts in " + KdspRareNPCManager.GetDistrict(seed) + ". Knows where all the bodies are buried.");

        ArrayPush(professions, "Former MaxTac");
        ArrayPush(details, "Ex-MaxTac operative with classified kill count. Left under mysterious circumstances. Still receives pension.");

        ArrayPush(professions, "Legendary Merc");
        ArrayPush(details, "Name still whispered in merc circles. Supposedly dead, but records suggest otherwise.");

        let index = RandRange(seed, 0, ArraySize(professions) - 1);
        data.secretAffiliation = professions[index];
        data.description = details[index];

        data.hiddenInfo = "Bounty attempts: " + IntToString(RandRange(seed + 10, 0, 12)) + " (all failed). ";
        data.hiddenInfo += "Known associates still active in the field.";

        data.scannerWarning = "CAUTION: EXTREME THREAT IF PROVOKED";
        data.dangerLevel = "DORMANT - POTENTIALLY EXTREME";

        return data;
    }

    private static func GetDistrict(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Watson"; }
        if i == 1 { return "Westbrook"; }
        if i == 2 { return "Heywood"; }
        if i == 3 { return "Pacifica"; }
        if i == 4 { return "Santo Domingo"; }
        return "City Center";
    }

    private static func GenerateCloneSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ CLONE DETECTED ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA SUBJECT";

        let generation = RandRange(seed, 2, 7);
        let original = RandRange(seed + 10, 1, 100) <= 30 ? "KNOWN" : "CLASSIFIED";

        data.description = "BIOTECH ALERT: Subject confirmed as Generation " + IntToString(generation) + " clone. ";
        data.description += "Original template: " + original + ". Legal status: COMPLICATED. ";
        data.description += "Memory implantation: " + (RandRange(seed + 20, 1, 100) <= 60 ? "COMPLETE" : "PARTIAL") + ". ";
        data.description += "Subject may or may not be aware of clone status.";

        data.hiddenInfo = "Clone batch: " + IntToString(RandRange(seed + 30, 1, 50)) + ". Siblings active: " + IntToString(RandRange(seed + 40, 0, 5)) + ". ";
        data.hiddenInfo += "Genetic degradation: " + IntToString(RandRange(seed + 50, 0, 30)) + "%. ";
        data.hiddenInfo += "Corporate ownership claim: " + (RandRange(seed + 60, 1, 100) <= 50 ? "ACTIVE" : "DISPUTED");

        data.scannerWarning = "CLONE RIGHTS DISPUTED - LEGAL GREY ZONE";
        data.dangerLevel = "LOW - IDENTITY CRISIS POSSIBLE";

        return data;
    }

    private static func GenerateMaxtacTarget(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⚠ MAXTAC TARGET ⚠";
        data.flagColor = "RED";
        data.secretAffiliation = "ACTIVE MAXTAC WARRANT";

        let priority = RandRange(seed, 1, 5);
        let reason = KdspRareNPCManager.GetMaxtacReason(seed + 10);

        data.description = "MAXTAC ALERT: Subject is Priority " + IntToString(priority) + " target. ";
        data.description += "Reason: " + reason + ". ";
        data.description += "Capture/neutralize order: " + (priority <= 2 ? "SHOOT ON SIGHT" : "CAPTURE PREFERRED") + ". ";
        data.description += "Civilian casualties authorized: " + (priority <= 2 ? "YES" : "MINIMIZE") + ".";

        data.hiddenInfo = "Previous encounters: " + IntToString(RandRange(seed + 20, 0, 3)) + ". ";
        data.hiddenInfo += "MaxTac officers wounded/killed: " + IntToString(RandRange(seed + 30, 0, 5)) + ". ";
        data.hiddenInfo += "Bounty: €$" + IntToString(RandRange(seed + 40, 100000, 1000000));

        data.scannerWarning = "EXTREME DANGER - MAXTAC INBOUND IF ENGAGED";
        data.dangerLevel = "EXTREME - MAXTAC PRIORITY";

        return data;
    }

    private static func GetMaxtacReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Cyberpsychosis confirmed"; }
        if i == 1 { return "Mass casualty event"; }
        if i == 2 { return "Cop killer"; }
        if i == 3 { return "Terrorist activities"; }
        if i == 4 { return "Escaped MaxTac detention"; }
        return "Military-grade cyberware illegal";
    }

    private static func GenerateWitnessProtection(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ WITNESS PROTECTION ◈";
        data.flagColor = "BLUE";
        data.secretAffiliation = "NUSA WITNESS PROGRAM";

        let witnessed = KdspRareNPCManager.GetWitnessedEvent(seed);
        let years = IntToString(RandRange(seed + 10, 1, 15));

        data.description = "CLASSIFIED: Subject in federal witness protection. Original identity sealed. ";
        data.description += "Testified against: " + witnessed + ". ";
        data.description += "Time in program: " + years + " years. ";
        data.description += "ALERT: Multiple assassination attempts on file.";

        data.hiddenInfo = "Original name: [SEALED BY COURT ORDER]. Previous location: [REDACTED]. ";
        data.hiddenInfo += "Handlers: US Marshals Service. Threat level to original identity: EXTREME. ";
        data.hiddenInfo += "Bounty on original identity: €$" + IntToString(RandRange(seed + 20, 500000, 5000000));

        data.scannerWarning = "FEDERAL PROTECTION - DO NOT COMPROMISE";
        data.dangerLevel = "LOW - BUT HIGH VALUE TARGET";

        return data;
    }

    private static func GetWitnessedEvent(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Arasaka war crimes"; }
        if i == 1 { return "Militech black ops"; }
        if i == 2 { return "Gang leadership murder"; }
        if i == 3 { return "Political assassination"; }
        if i == 4 { return "Corporate mass murder"; }
        return "Government corruption";
    }

    private static func GenerateEngramCandidate(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◎ ENGRAM CANDIDATE ◎";
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA SOUL PROJECT";

        let compatibility = IntToString(RandRange(seed, 85, 99));
        let status = RandRange(seed + 10, 1, 100) <= 40 ? "AWARE" : "UNAWARE";

        data.description = "SOULKILLER ALERT: Subject identified as high-compatibility engram candidate. ";
        data.description += "Neural mapping compatibility: " + compatibility + "%. ";
        data.description += "Subject awareness: " + status + ". ";
        data.description += "Corporate interest: EXTREME. Extraction attempts: LIKELY.";

        data.hiddenInfo = "Arasaka bounty for live capture: €$" + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ". ";
        data.hiddenInfo += "Unique neural architecture identified. ";
        data.hiddenInfo += "Potential Relic compatibility: " + (RandRange(seed + 30, 1, 100) <= 30 ? "CONFIRMED" : "SUSPECTED");

        data.scannerWarning = "HIGH VALUE CORPORATE ASSET - EXTRACTION TEAMS POSSIBLE";
        data.dangerLevel = "MODERATE - BUT HIGH INTEREST";

        return data;
    }

    private static func GenerateCorpoDefector(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▼ CORPORATE DEFECTOR ▼";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, "MILITECH");
        ArrayPush(corps, "KANG TAO");
        ArrayPush(corps, "BIOTECHNICA");
        ArrayPush(corps, "PETROCHEM");
        ArrayPush(corps, "ZETATECH");

        let fromCorp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        let toCorp = corps[RandRange(seed + 10, 0, ArraySize(corps) - 1)];

        data.secretAffiliation = "EX-" + fromCorp;

        data.description = "CORPORATE ALERT: Former " + fromCorp + " employee defected to " + toCorp + ". ";
        data.description += "Classified data stolen: " + (RandRange(seed + 20, 1, 100) <= 70 ? "CONFIRMED" : "SUSPECTED") + ". ";
        data.description += "Kill order from " + fromCorp + ": ACTIVE. ";
        data.description += "Protection from " + toCorp + ": " + (RandRange(seed + 30, 1, 100) <= 50 ? "CONFIRMED" : "RUMORED");

        data.hiddenInfo = "Original position: " + KdspRareNPCManager.GetCorpoPosition(seed + 40) + ". ";
        data.hiddenInfo += "Data value estimate: €$" + IntToString(RandRange(seed + 50, 10000000, 100000000)) + ". ";
        data.hiddenInfo += "Assassination attempts: " + IntToString(RandRange(seed + 60, 1, 8));

        data.scannerWarning = "CORPORATE WAR ASSET - MULTIPLE PARTIES INTERESTED";
        data.dangerLevel = "HIGH - ASSASSINATION LIKELY";

        return data;
    }

    private static func GenerateGangInfiltrator(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ GANG INFILTRATOR ◉";
        data.flagColor = "ORANGE";

        let gangs: array<String>;
        ArrayPush(gangs, "MAELSTROM");
        ArrayPush(gangs, "TYGER CLAWS");
        ArrayPush(gangs, "6TH STREET");
        ArrayPush(gangs, "VALENTINOS");
        ArrayPush(gangs, "ANIMALS");
        ArrayPush(gangs, "VOODOO BOYS");

        let infiltrated = gangs[RandRange(seed, 0, ArraySize(gangs) - 1)];
        let employer = RandRange(seed + 10, 1, 100) <= 50 ? "RIVAL GANG" : "CORPORATE";

        data.secretAffiliation = employer + " PLANT IN " + infiltrated;

        data.description = "GANG INTEL: Subject is embedded infiltrator within " + infiltrated + ". ";
        data.description += "Employer: " + employer + ". Time embedded: " + IntToString(RandRange(seed + 20, 1, 5)) + " years. ";
        data.description += "Position achieved: " + KdspRareNPCManager.GetGangPosition(seed + 30) + ". ";
        data.description += "Discovery would result in immediate execution.";

        data.hiddenInfo = "Intelligence gathered on: Leadership, operations, alliances. ";
        data.hiddenInfo += "Handler contact: Every " + IntToString(RandRange(seed + 40, 3, 14)) + " days. ";
        data.hiddenInfo += "Extraction plan: " + (RandRange(seed + 50, 1, 100) <= 50 ? "IN PLACE" : "NONE");

        data.scannerWarning = "DEEP COVER - EXPOSURE FATAL";
        data.dangerLevel = "HIGH - GANG EXECUTION IF EXPOSED";

        return data;
    }

    private static func GetGangPosition(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Lieutenant"; }
        if i == 1 { return "Enforcer"; }
        if i == 2 { return "Drug distributor"; }
        if i == 3 { return "Weapons handler"; }
        return "Trusted soldier";
    }

    private static func GenerateTraumaTeamMarked(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✚ TRAUMA TEAM FLAGGED ✚";
        data.flagColor = "RED";
        data.secretAffiliation = "TRAUMA TEAM DNR";

        let reason = KdspRareNPCManager.GetTraumaReason(seed);

        data.description = "TRAUMA TEAM ALERT: Subject flagged in TT database. Status: DO NOT RESUSCITATE. ";
        data.description += "Reason: " + reason + ". ";
        data.description += "If flatlined, no Trauma Team response will be dispatched regardless of subscription. ";
        data.description += "This flag is permanent and non-appealable.";

        data.hiddenInfo = "Flag placed by: [CORPORATE AUTHORITY]. ";
        data.hiddenInfo += "Incidents causing flag: " + IntToString(RandRange(seed + 10, 1, 5)) + ". ";
        data.hiddenInfo += "Previous TT personnel injured by subject: " + IntToString(RandRange(seed + 20, 0, 3));

        data.scannerWarning = "NO TRAUMA TEAM RESPONSE - LEFT TO DIE";
        data.dangerLevel = "MODERATE - BUT EXPENDABLE";

        return data;
    }

    private static func GetTraumaReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Attacked TT personnel during rescue"; }
        if i == 1 { return "Outstanding debt to Trauma Team"; }
        if i == 2 { return "Used TT subscription fraudulently"; }
        if i == 3 { return "Killed TT staff"; }
        return "Corporate blacklist request";
    }

    private static func GenerateFixerAsset(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ FIXER ASSET ◈";
        data.flagColor = "GREEN";
        data.secretAffiliation = "FIXER NETWORK";

        let role = KdspRareNPCManager.GetFixerRole(seed);
        let fixer = KdspRareNPCManager.GetFixerName(seed + 10);

        data.description = "STREET INTEL: Subject is a protected asset of fixer " + fixer + ". ";
        data.description += "Role: " + role + ". ";
        data.description += "Harming this individual will result in network-wide blacklist. ";
        data.description += "Protection level: SIGNIFICANT.";

        data.hiddenInfo = "Years in network: " + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += "Jobs facilitated: " + IntToString(RandRange(seed + 30, 10, 200)) + ". ";
        data.hiddenInfo += "Street cred: ESTABLISHED";

        data.scannerWarning = "FIXER PROTECTED - NETWORK CONSEQUENCES";
        data.dangerLevel = "LOW - BUT CONNECTED";

        return data;
    }

    private static func GetFixerRole(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Information broker"; }
        if i == 1 { return "Safe house operator"; }
        if i == 2 { return "Weapons supplier"; }
        if i == 3 { return "Medical contact"; }
        if i == 4 { return "Transport specialist"; }
        return "Money launderer";
    }

    private static func GetFixerName(seed: Int32) -> String {
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "Rogue"; }
        if i == 1 { return "Wakako Okada"; }
        if i == 2 { return "Padre"; }
        if i == 3 { return "Regina Jones"; }
        if i == 4 { return "Dino Dinovic"; }
        if i == 5 { return "Dakota Smith"; }
        if i == 6 { return "Mr. Hands"; }
        return "Unknown Fixer";
    }

    private static func GenerateBlackmailVictim(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◆ BLACKMAIL VICTIM ◆";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "COMPROMISED INDIVIDUAL";

        let secret = KdspRareNPCManager.GetBlackmailSecret(seed);
        let blackmailer = KdspRareNPCManager.GetBlackmailerType(seed + 10);

        data.description = "INTEL: Subject is being blackmailed. ";
        data.description += "Compromising material: " + secret + ". ";
        data.description += "Blackmailer: " + blackmailer + ". ";
        data.description += "Subject is controlled and may act against their own interests.";

        data.hiddenInfo = "Duration of blackmail: " + IntToString(RandRange(seed + 20, 1, 10)) + " years. ";
        data.hiddenInfo += "Payments made: €$" + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += "Desperation level: " + (RandRange(seed + 40, 1, 100) <= 50 ? "CRITICAL" : "HIGH");

        data.scannerWarning = "COMPROMISED - MAY BE UNRELIABLE";
        data.dangerLevel = "UNPREDICTABLE";

        return data;
    }

    private static func GetBlackmailSecret(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Corporate espionage evidence"; }
        if i == 1 { return "Past murder covered up"; }
        if i == 2 { return "Hidden family secret"; }
        if i == 3 { return "Financial crimes"; }
        if i == 4 { return "Compromising personal recordings"; }
        return "Hidden identity";
    }

    private static func GetBlackmailerType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Criminal organization"; }
        if i == 1 { return "Corporate rival"; }
        if i == 2 { return "Former associate"; }
        if i == 3 { return "Netrunner"; }
        return "Unknown party";
    }

    private static func GenerateMilitaryAwol(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▲ MILITARY DESERTER ▲";
        data.flagColor = "RED";

        let branches: array<String>;
        ArrayPush(branches, "NUSA ARMY");
        ArrayPush(branches, "MILITECH PMC");
        ArrayPush(branches, "ARASAKA SECURITY");
        ArrayPush(branches, "LAZARUS GROUP");
        ArrayPush(branches, "KANG TAO FORCES");

        let branch = branches[RandRange(seed, 0, ArraySize(branches) - 1)];
        data.secretAffiliation = "AWOL - " + branch;

        let rank = KdspRareNPCManager.GetMilitaryRank(seed + 10);
        let years = IntToString(RandRange(seed + 20, 1, 10));

        data.description = "MILITARY ALERT: Subject is AWOL from " + branch + ". ";
        data.description += "Former rank: " + rank + ". Deserted: " + years + " years ago. ";
        data.description += "Classified training: " + (RandRange(seed + 30, 1, 100) <= 40 ? "YES" : "STANDARD") + ". ";
        data.description += "Capture order: ACTIVE. Return for court martial.";

        data.hiddenInfo = "Service record: [CLASSIFIED]. Reason for desertion: UNKNOWN. ";
        data.hiddenInfo += "Equipment taken during desertion: " + (RandRange(seed + 40, 1, 100) <= 50 ? "MILITARY GRADE CYBERWARE" : "STANDARD ISSUE") + ". ";
        data.hiddenInfo += "Bounty: €$" + IntToString(RandRange(seed + 50, 50000, 500000));

        data.scannerWarning = "MILITARY TRAINING - COMBAT CAPABLE";
        data.dangerLevel = "HIGH - TRAINED COMBATANT";

        return data;
    }

    private static func GetMilitaryRank(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Private"; }
        if i == 1 { return "Corporal"; }
        if i == 2 { return "Sergeant"; }
        if i == 3 { return "Lieutenant"; }
        if i == 4 { return "Captain"; }
        return "Special Forces Operative";
    }

    private static func GenerateExperimentalSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ EXPERIMENTAL SUBJECT ⧫";
        data.flagColor = "PURPLE";

        let experiments: array<String>;
        ArrayPush(experiments, "Cyberware enhancement");
        ArrayPush(experiments, "Genetic modification");
        ArrayPush(experiments, "Neural programming");
        ArrayPush(experiments, "Combat drug trials");
        ArrayPush(experiments, "Soulkiller testing");
        ArrayPush(experiments, "AI integration");

        let experiment = experiments[RandRange(seed, 0, ArraySize(experiments) - 1)];
        let corp = RandRange(seed + 10, 1, 100) <= 50 ? "BIOTECHNICA" : "UNKNOWN CORP";
        data.secretAffiliation = corp + " TEST SUBJECT";

        data.description = "BIOTECH ALERT: Subject was part of " + experiment + " experiments. ";
        data.description += "Escaped from facility: " + IntToString(RandRange(seed + 20, 1, 10)) + " years ago. ";
        data.description += "Side effects: UNKNOWN BUT PROBABLE. ";
        data.description += "Corporate recapture priority: " + (RandRange(seed + 30, 1, 100) <= 50 ? "HIGH" : "MODERATE");

        data.hiddenInfo = "Subject number: #" + IntToString(RandRange(seed + 40, 100, 999)) + ". Batch survivors: " + IntToString(RandRange(seed + 50, 1, 5)) + ". ";
        data.hiddenInfo += "Known modifications: " + IntToString(RandRange(seed + 60, 1, 8)) + ". ";
        data.hiddenInfo += "Stable?: " + (RandRange(seed + 70, 1, 100) <= 60 ? "MOSTLY" : "DETERIORATING");

        data.scannerWarning = "EXPERIMENTAL MODIFICATIONS - UNPREDICTABLE";
        data.dangerLevel = "UNKNOWN - POSSIBLY EXTREME";

        return data;
    }

    private static func GenerateDebtCollection(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "€$ DEBT MARKED €$";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "CORPO DEBT COLLECTION";

        let creditor = KdspRareNPCManager.GetCreditor(seed);
        let amount = IntToString(RandRange(seed + 10, 100000, 5000000));

        data.description = "FINANCIAL ALERT: Subject owes €$" + amount + " to " + creditor + ". ";
        data.description += "Collection status: ACTIVE. Payment deadline: PASSED. ";
        data.description += "Collection method authorized: " + (RandRange(seed + 20, 1, 100) <= 40 ? "ANY MEANS" : "AGGRESSIVE") + ". ";
        data.description += "Organ harvest clause: " + (RandRange(seed + 30, 1, 100) <= 30 ? "ACTIVE" : "INACTIVE");

        data.hiddenInfo = "Original debt: €$" + IntToString(RandRange(seed + 40, 10000, 500000)) + " (interest accumulated). ";
        data.hiddenInfo += "Previous collection attempts: " + IntToString(RandRange(seed + 50, 1, 10)) + ". ";
        data.hiddenInfo += "Bounty for live delivery: €$" + IntToString(RandRange(seed + 60, 10000, 100000));

        data.scannerWarning = "DEBT COLLECTORS HUNTING";
        data.dangerLevel = "MODERATE - DESPERATE";

        return data;
    }

    private static func GetCreditor(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Arasaka Financial"; }
        if i == 1 { return "Night City Credit Union"; }
        if i == 2 { return "Tyger Claws loan sharks"; }
        if i == 3 { return "Militech Collections"; }
        if i == 4 { return "Underground lenders"; }
        return "Multiple creditors";
    }

    private static func GenerateOrganMarked(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✖ ORGAN MARKED ✖";
        data.flagColor = "RED";
        data.secretAffiliation = "SCAV TARGET";

        let organs: array<String>;
        ArrayPush(organs, "rare blood type");
        ArrayPush(organs, "compatible neural tissue");
        ArrayPush(organs, "pristine organs");
        ArrayPush(organs, "unique genetic markers");
        ArrayPush(organs, "high-compatibility tissue");

        let organ = organs[RandRange(seed, 0, ArraySize(organs) - 1)];

        data.description = "SCAV ALERT: Subject has been marked for harvest. Reason: " + organ + ". ";
        data.description += "Bounty placed by: " + (RandRange(seed + 10, 1, 100) <= 50 ? "SCAV NETWORK" : "BLACK MARKET BUYER") + ". ";
        data.description += "Harvest value: €$" + IntToString(RandRange(seed + 20, 50000, 500000)) + ". ";
        data.description += "Subject awareness: " + (RandRange(seed + 30, 1, 100) <= 30 ? "AWARE" : "UNAWARE");

        data.hiddenInfo = "Previous abduction attempts: " + IntToString(RandRange(seed + 40, 0, 3)) + ". ";
        data.hiddenInfo += "Scav teams assigned: " + IntToString(RandRange(seed + 50, 1, 3)) + ". ";
        data.hiddenInfo += "Best opportunity: " + KdspRareNPCManager.GetHarvestOpportunity(seed + 60);

        data.scannerWarning = "SCAV TARGET - ABDUCTION RISK";
        data.dangerLevel = "VICTIM - NOT THREAT";

        return data;
    }

    private static func GetHarvestOpportunity(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Routine commute"; }
        if i == 1 { return "Regular bar visit"; }
        if i == 2 { return "Jogging route"; }
        if i == 3 { return "Isolated residence"; }
        return "Work location";
    }

    private static func GenerateCultEscapee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◎ CULT ESCAPEE ◎";
        data.flagColor = "ORANGE";

        let cults: array<String>;
        ArrayPush(cults, "Church of the Digital Resurrection");
        ArrayPush(cults, "Children of the Blackwall");
        ArrayPush(cults, "Arasaka Loyalists");
        ArrayPush(cults, "Blood Covenant");
        ArrayPush(cults, "Temple of the Chrome God");
        ArrayPush(cults, "Followers of Alt");

        let cult = cults[RandRange(seed, 0, ArraySize(cults) - 1)];
        data.secretAffiliation = "ESCAPED FROM " + cult;

        data.description = "CULT ALERT: Subject escaped from " + cult + ". ";
        data.description += "Time in cult: " + IntToString(RandRange(seed + 10, 2, 15)) + " years. ";
        data.description += "Position held: " + (RandRange(seed + 20, 1, 100) <= 30 ? "INNER CIRCLE" : "MEMBER") + ". ";
        data.description += "Cult retrieval teams: ACTIVE. Subject knows secrets they want buried.";

        data.hiddenInfo = "Information on cult crimes: EXTENSIVE. ";
        data.hiddenInfo += "Deprogramming status: " + (RandRange(seed + 30, 1, 100) <= 50 ? "PARTIAL" : "COMPLETE") + ". ";
        data.hiddenInfo += "Kill order from cult: " + (RandRange(seed + 40, 1, 100) <= 70 ? "CONFIRMED" : "SUSPECTED");

        data.scannerWarning = "CULT HUNTERS ACTIVE - IN DANGER";
        data.dangerLevel = "LOW THREAT - HIGH VALUE";

        return data;
    }

    private static func GenerateRelicCompatible(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ RELIC COMPATIBLE ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA INTEREST";

        let compatibility = IntToString(RandRange(seed, 90, 99));

        data.description = "ARASAKA PRIORITY: Subject has rare Relic chip compatibility (" + compatibility + "%). ";
        data.description += "Neural architecture: OPTIMAL FOR ENGRAM HOSTING. ";
        data.description += "Subject awareness: " + (RandRange(seed + 10, 1, 100) <= 20 ? "AWARE" : "UNAWARE") + ". ";
        data.description += "Arasaka acquisition interest: EXTREME.";

        data.hiddenInfo = "Similar subjects identified globally: <50. ";
        data.hiddenInfo += "Estimated value to Arasaka: €$" + IntToString(RandRange(seed + 20, 50000000, 200000000)) + ". ";
        data.hiddenInfo += "Saburo Arasaka engram potential host: " + (RandRange(seed + 30, 1, 100) <= 30 ? "POSSIBLE" : "UNLIKELY");

        data.scannerWarning = "EXTREME CORPORATE VALUE - EXTRACTION TEAMS LIKELY";
        data.dangerLevel = "LOW PERSONAL - EXTREME TARGET VALUE";

        return data;
    }

    private static func GenerateDataCourier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ DATA COURIER ◈";
        data.flagColor = "GREEN";
        data.secretAffiliation = "COURIER NETWORK";

        let dataType = KdspRareNPCManager.GetCourierData(seed);
        let client = KdspRareNPCManager.GetCourierClient(seed + 10);

        data.description = "INTEL: Subject is active data courier. Current payload: " + dataType + ". ";
        data.description += "Client: " + client + ". ";
        data.description += "Delivery method: NEURAL IMPLANT. Data extraction requires: RIPPERDOC. ";
        data.description += "Value of current payload: €$" + IntToString(RandRange(seed + 20, 100000, 10000000));

        data.hiddenInfo = "Active courier for: " + IntToString(RandRange(seed + 30, 1, 10)) + " years. ";
        data.hiddenInfo += "Successful deliveries: " + IntToString(RandRange(seed + 40, 50, 500)) + ". ";
        data.hiddenInfo += "Interception attempts survived: " + IntToString(RandRange(seed + 50, 0, 20));

        data.scannerWarning = "CARRIES VALUABLE DATA - INTERCEPTION TARGET";
        data.dangerLevel = "MODERATE - PROTECTED BY CLIENTS";

        return data;
    }

    private static func GetCourierData(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Corporate secrets"; }
        if i == 1 { return "Government intelligence"; }
        if i == 2 { return "Financial records"; }
        if i == 3 { return "Research data"; }
        if i == 4 { return "Blackmail material"; }
        return "Unknown - encrypted";
    }

    private static func GetCourierClient(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Corporate client"; }
        if i == 1 { return "Fixer network"; }
        if i == 2 { return "Government"; }
        if i == 3 { return "Unknown party"; }
        return "Multiple clients";
    }

    private static func GenerateDoubleAgent(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ DOUBLE AGENT ✦";
        data.flagColor = "RED";

        let org1 = KdspRareNPCManager.GetAgentOrg(seed);
        let org2 = KdspRareNPCManager.GetAgentOrg(seed + 10);
        data.secretAffiliation = "SERVING: " + org1 + " AND " + org2;

        data.description = "INTELLIGENCE ALERT: Subject confirmed as double agent. ";
        data.description += "Claims loyalty to: " + org1 + ". Actually serving: " + org2 + ". ";
        data.description += "Or possibly serving both. True allegiance: UNKNOWN. ";
        data.description += "Information reliability: ZERO.";

        data.hiddenInfo = "Duration of double game: " + IntToString(RandRange(seed + 20, 1, 10)) + " years. ";
        data.hiddenInfo += "Compromised operations: " + IntToString(RandRange(seed + 30, 5, 50)) + ". ";
        data.hiddenInfo += "Deaths attributed to intel leaks: " + IntToString(RandRange(seed + 40, 0, 20));

        data.scannerWarning = "TRUST NOTHING - LOYALTY UNKNOWN";
        data.dangerLevel = "EXTREME - UNPREDICTABLE";

        return data;
    }

    private static func GetAgentOrg(seed: Int32) -> String {
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "ARASAKA"; }
        if i == 1 { return "MILITECH"; }
        if i == 2 { return "NETWATCH"; }
        if i == 3 { return "NUSA GOV"; }
        if i == 4 { return "GANG LEADERSHIP"; }
        if i == 5 { return "FIXER NETWORK"; }
        if i == 6 { return "FOREIGN POWER"; }
        return "UNKNOWN PARTY";
    }

    private static func GenerateNomadExile(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▼ NOMAD EXILE ▼";
        data.flagColor = "ORANGE";

        let clans: array<String>;
        ArrayPush(clans, "ALDECALDOS");
        ArrayPush(clans, "WRAITHS");
        ArrayPush(clans, "BAKKERS");
        ArrayPush(clans, "SNAKE NATION");
        ArrayPush(clans, "JODES");

        let clan = clans[RandRange(seed, 0, ArraySize(clans) - 1)];
        data.secretAffiliation = "EXILED FROM " + clan;

        let reason = KdspRareNPCManager.GetExileReason(seed + 10);

        data.description = "NOMAD INTEL: Subject exiled from " + clan + " clan. ";
        data.description += "Reason: " + reason + ". ";
        data.description += "Exile type: " + (RandRange(seed + 20, 1, 100) <= 50 ? "PERMANENT - KILL ON SIGHT" : "PERMANENT - NO CONTACT") + ". ";
        data.description += "Subject has intimate knowledge of clan operations, routes, and safe houses.";

        data.hiddenInfo = "Years with clan: " + IntToString(RandRange(seed + 30, 5, 25)) + ". ";
        data.hiddenInfo += "Clan secrets known: EXTENSIVE. ";
        data.hiddenInfo += "Bounty from clan: €$" + IntToString(RandRange(seed + 40, 10000, 100000));

        data.scannerWarning = "NOMAD HUNTERS MAY BE ACTIVE";
        data.dangerLevel = "MODERATE - HUNTED";

        return data;
    }

    private static func GetExileReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Betrayed clan to corpos"; }
        if i == 1 { return "Killed clan member"; }
        if i == 2 { return "Stole from clan"; }
        if i == 3 { return "Violated sacred clan law"; }
        if i == 4 { return "Endangered entire clan"; }
        return "Leadership dispute";
    }

    // ===================================
    // v1.7 NEW CLASSIFICATIONS (30 types)
    // ===================================

    private static func GenerateBraindanceAddict(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ BRAINDANCE DISSOCIATION ◈";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "NONE - MEDICAL CONCERN";

        let hours = IntToString(RandRange(seed, 14, 22));
        let genres: array<String>;
        ArrayPush(genres, "Combat/violence scrolls");
        ArrayPush(genres, "Illegal XBD content");
        ArrayPush(genres, "Celebrity experience loops");
        ArrayPush(genres, "Pre-war nostalgia reels");
        ArrayPush(genres, "Synthetic emotion stacks");
        ArrayPush(genres, "Death experience recordings");

        let genre = genres[RandRange(seed + 10, 0, ArraySize(genres) - 1)];

        data.description = "MEDICAL ALERT: Subject exhibits severe braindance addiction. Estimated daily usage: " + hours + " hours. ";
        data.description += "Primary content: " + genre + ". ";
        data.description += "Reality dissociation index: " + IntToString(RandRange(seed + 20, 70, 99)) + "%. ";
        data.description += "Subject may not distinguish between BD memories and lived experience.";

        data.hiddenInfo = "Wreath usage: " + IntToString(RandRange(seed + 30, 3, 12)) + " years continuous. ";
        data.hiddenInfo += "Neural degradation: " + (RandRange(seed + 40, 1, 100) <= 60 ? "SIGNIFICANT" : "MODERATE") + ". ";
        data.hiddenInfo += "BD dealer: [FLAGGED IN NCPD DATABASE]";

        data.scannerWarning = "DISSOCIATIVE STATE - MAY NOT RESPOND NORMALLY";
        data.dangerLevel = "LOW - BUT UNPREDICTABLE";

        return data;
    }

    private static func GenerateNightCorpSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "██ NIGHT CORP PROJECT ██";
        data.flagColor = "RED";
        data.secretAffiliation = "NIGHT CORP - OPERATION CARPE NOCTEM";

        let phase = RandRange(seed, 1, 4);
        data.description = "CLASSIFIED: Subject is an active test subject in Night Corp neural programming initiative. ";
        data.description += "Project phase: " + IntToString(phase) + "/4. ";
        data.description += "Behavioral modification: " + (phase >= 3 ? "ADVANCED" : "ONGOING") + ". ";
        data.description += "Subject awareness of conditioning: NONE. Personality alterations occurring during REM sleep cycles.";

        data.hiddenInfo = "Enrolled since: " + IntToString(RandRange(seed + 10, 2070, 2076)) + ". ";
        data.hiddenInfo += "Reported personality shifts: " + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += "Night Corp handler: [REDACTED]. Objective: [CLASSIFIED BEYOND CLEARANCE]";

        data.scannerWarning = "NIGHT CORP PROPERTY - DO NOT INTERFERE";
        data.dangerLevel = "UNKNOWN - PROGRAMMED BEHAVIOR POSSIBLE";

        return data;
    }

    private static func GenerateDollChipSleeper(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ DORMANT DOLL CHIP ◉";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "CLOUDS / UNKNOWN OPERATOR";

        data.description = "CYBERWARE ALERT: Subject carries a dormant behavioral modification chip (doll chip). ";
        data.description += "Chip status: " + (RandRange(seed, 1, 100) <= 30 ? "INTERMITTENT ACTIVATION DETECTED" : "DORMANT") + ". ";
        data.description += "Chip origin: " + (RandRange(seed + 10, 1, 100) <= 50 ? "CLOUDS DOLHOUSE" : "UNKNOWN INSTALLER") + ". ";
        data.description += "Remote activation capability: CONFIRMED. Personality override possible at any time.";

        data.hiddenInfo = "Chip installed: " + IntToString(RandRange(seed + 20, 1, 8)) + " years ago. ";
        data.hiddenInfo += "Known activation episodes: " + IntToString(RandRange(seed + 30, 0, 12)) + ". ";
        data.hiddenInfo += "Control frequency holder: [UNKNOWN]";

        data.scannerWarning = "PERSONALITY MAY NOT BE GENUINE";
        data.dangerLevel = "MODERATE - CONTROLLED ASSET";

        return data;
    }

    private static func GenerateSoulkillerSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ SOULKILLER ANOMALY ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA SOUL PROJECT";

        data.description = "ARASAKA PRIORITY: Subject survived a Soulkiller extraction procedure. ";
        data.description += "Engram created: " + (RandRange(seed, 1, 100) <= 60 ? "YES - STORED ON MIKOSHI" : "PARTIAL - CORRUPTED") + ". ";
        data.description += "Subject retained consciousness post-procedure. This is EXTREMELY RARE. ";
        data.description += "Neural integrity post-scan: " + IntToString(RandRange(seed + 10, 40, 85)) + "%.";

        data.hiddenInfo = "Procedure date: " + IntToString(RandRange(seed + 20, 2060, 2076)) + ". ";
        data.hiddenInfo += "Facility: [CLASSIFIED ARASAKA BLACK SITE]. ";
        data.hiddenInfo += "Both engram copy and original still exist. Arasaka considers this a security breach.";

        data.scannerWarning = "ARASAKA HIGH INTEREST - CAPTURE PREFERRED";
        data.dangerLevel = "LOW PERSONAL - EXTREME CORPORATE VALUE";

        return data;
    }

    private static func GenerateBlackwallTouched(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ BLACKWALL CONTACT ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "NETWATCH FLAGGED";

        let effects: array<String>;
        ArrayPush(effects, "Whispers data fragments in sleep");
        ArrayPush(effects, "Involuntary device manipulation");
        ArrayPush(effects, "Knowledge of events before they occur");
        ArrayPush(effects, "Speaks in machine code during episodes");
        ArrayPush(effects, "Nearby electronics malfunction");
        ArrayPush(effects, "Writes encrypted data compulsively");

        let effect = effects[RandRange(seed, 0, ArraySize(effects) - 1)];

        data.description = "NETWATCH ALERT: Subject has had confirmed contact with entity beyond the Blackwall. ";
        data.description += "Contact method: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Deep net dive gone wrong" : "Unknown transmission vector") + ". ";
        data.description += "Persistent effects: " + effect + ". ";
        data.description += "NetWatch containment status: MONITORING.";

        data.hiddenInfo = "Contact occurred: " + IntToString(RandRange(seed + 20, 1, 5)) + " years ago. ";
        data.hiddenInfo += "Rogue AI identifier: [DATA CORRUPTED]. ";
        data.hiddenInfo += "VDB interest level: EXTREME. NetWatch wants subject for study.";

        data.scannerWarning = "AI CONTACT SUSPECTED - NETWATCH FLAGGED";
        data.dangerLevel = "UNKNOWN - POSSIBLY COMPROMISED";

        return data;
    }

    private static func GenerateSignalCarrier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ SIGNAL CARRIER ◈";
        data.flagColor = "GREEN";
        data.secretAffiliation = "UNKNOWN - TRANSMITTING";

        let freq = IntToString(RandRange(seed, 100, 999));
        data.description = "SIGNAL INTEL: Subject is broadcasting an encrypted signal from neural implant. Frequency: " + freq + "." + IntToString(RandRange(seed + 5, 10, 99)) + " MHz. ";
        data.description += "Broadcast type: " + (RandRange(seed + 10, 1, 100) <= 50 ? "CONTINUOUS" : "BURST PATTERN") + ". ";
        data.description += "Subject awareness: NONE. Signal appears involuntary. ";
        data.description += "Decryption attempts: FAILED. Encryption is military-grade or beyond.";

        data.hiddenInfo = "Signal first detected: " + IntToString(RandRange(seed + 20, 1, 24)) + " months ago. ";
        data.hiddenInfo += "Recipient: UNKNOWN. Signal bounces through " + IntToString(RandRange(seed + 30, 3, 20)) + " relays. ";
        data.hiddenInfo += "Possible origin: implant surgery at unregistered clinic";

        data.scannerWarning = "BROADCASTING - MAY BE TRACKED";
        data.dangerLevel = "LOW - BUT MONITORED BY UNKNOWN PARTY";

        return data;
    }

    private static func GenerateMemoryWiped(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◆ MEMORY ERASURE ◆";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "IDENTITY MODIFIED";

        let years = IntToString(RandRange(seed, 2, 20));
        let wipers: array<String>;
        ArrayPush(wipers, "Corporate black clinic");
        ArrayPush(wipers, "Underground ripperdoc");
        ArrayPush(wipers, "Night Corp facility");
        ArrayPush(wipers, "Arasaka Psych Division");
        ArrayPush(wipers, "Self-administered (experimental)");

        let wiper = wipers[RandRange(seed + 10, 0, ArraySize(wipers) - 1)];

        data.description = "NEURO ALERT: Subject has undergone professional memory erasure. ";
        data.description += "Estimated memories removed: " + years + " years of experience. ";
        data.description += "Procedure performed by: " + wiper + ". ";
        data.description += "Current personality may be partially or wholly constructed post-wipe.";

        data.hiddenInfo = "Pre-wipe identity: [IRRECOVERABLE]. ";
        data.hiddenInfo += "Wipe quality: " + (RandRange(seed + 20, 1, 100) <= 40 ? "CLEAN - No bleedthrough" : "PARTIAL - Fragments remain") + ". ";
        data.hiddenInfo += "Reason for wipe: " + (RandRange(seed + 30, 1, 100) <= 50 ? "[CLASSIFIED]" : "Suspected trauma or criminal history");

        data.scannerWarning = "TRUE IDENTITY UNKNOWN";
        data.dangerLevel = "UNKNOWN - PAST MAY BE DANGEROUS";

        return data;
    }

    private static func GenerateIdentityStolen(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▲ IDENTITY FRAUD ▲";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "FALSE IDENTITY";

        data.description = "NCPD ALERT: Subject is living under a stolen identity. ";
        data.description += "Current identity belonged to: " + (RandRange(seed, 1, 100) <= 40 ? "deceased individual" : "missing person") + ". ";
        data.description += "Identity theft quality: " + (RandRange(seed + 10, 1, 100) <= 30 ? "PROFESSIONAL - Deep fake records" : "MODERATE - Gaps exist") + ". ";
        data.description += "True identity: UNKNOWN. Biometric databases return conflicting results.";

        data.hiddenInfo = "Using current identity for: " + IntToString(RandRange(seed + 20, 1, 15)) + " years. ";
        data.hiddenInfo += "Real identity flagged in: " + IntToString(RandRange(seed + 30, 0, 3)) + " other jurisdictions. ";
        data.hiddenInfo += "Likely reason: " + KdspRareNPCManager.GetIdentityTheftReason(seed + 40);

        data.scannerWarning = "BIOMETRIC MISMATCH DETECTED";
        data.dangerLevel = "UNKNOWN - IDENTITY CONCEALS PAST";

        return data;
    }

    private static func GetIdentityTheftReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Fleeing criminal charges"; }
        if i == 1 { return "Corporate extraction target"; }
        if i == 2 { return "Witness protection failure"; }
        if i == 3 { return "Gang death warrant"; }
        if i == 4 { return "Military desertion"; }
        return "Unknown - too many possibilities";
    }

    private static func GenerateMissingPerson(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▼ OFFICIALLY DECEASED ▼";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "NCPD CLOSED FILE";

        let years = IntToString(RandRange(seed, 1, 20));
        data.description = "DATABASE CONFLICT: Subject matches biometrics of individual declared " + (RandRange(seed + 5, 1, 100) <= 60 ? "DECEASED" : "MISSING") + " " + years + " years ago. ";
        data.description += "Official case status: CLOSED. ";
        data.description += "Match confidence: " + IntToString(RandRange(seed + 10, 92, 99)) + "%. ";
        data.description += "Subject appears unaware of their official status or is deliberately hiding.";

        data.hiddenInfo = "Original disappearance linked to: " + KdspRareNPCManager.GetDisappearanceCase(seed + 20) + ". ";
        data.hiddenInfo += "Insurance payout on death: €$" + IntToString(RandRange(seed + 30, 50000, 2000000)) + ". ";
        data.hiddenInfo += "Family notification: NOT RECOMMENDED without further investigation";

        data.scannerWarning = "DATA INTEGRITY FAILURE - TIMELINE INCONSISTENT";
        data.dangerLevel = "LOW - BUT CASE REOPENING POSSIBLE";

        return data;
    }

    private static func GetDisappearanceCase(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Scavenger raid"; }
        if i == 1 { return "Corporate restructuring purge"; }
        if i == 2 { return "Gang war casualty list"; }
        if i == 3 { return "Natural disaster aftermath"; }
        if i == 4 { return "Deliberate staging"; }
        return "Circumstances unknown";
    }

    private static func GenerateActiveBounty(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✖ ACTIVE BOUNTY ✖";
        data.flagColor = "RED";

        let amount = IntToString(RandRange(seed, 50000, 5000000));
        let posters: array<String>;
        ArrayPush(posters, "ANONYMOUS CLIENT");
        ArrayPush(posters, "CORPORATE ENTITY");
        ArrayPush(posters, "GANG LEADERSHIP");
        ArrayPush(posters, "PRIVATE INDIVIDUAL");
        ArrayPush(posters, "FOREIGN GOVERNMENT");

        let poster = posters[RandRange(seed + 10, 0, ArraySize(posters) - 1)];
        data.secretAffiliation = "BOUNTY TARGET";

        data.description = "BOUNTY ALERT: Active contract on subject. Amount: €$" + amount + ". ";
        data.description += "Posted by: " + poster + ". ";
        data.description += "Condition: " + (RandRange(seed + 20, 1, 100) <= 40 ? "ALIVE ONLY" : "DEAD OR ALIVE") + ". ";
        data.description += "Hunters assigned: " + IntToString(RandRange(seed + 30, 1, 5)) + " known operatives.";

        data.hiddenInfo = "Bounty active for: " + IntToString(RandRange(seed + 40, 1, 36)) + " months. ";
        data.hiddenInfo += "Previous attempts: " + IntToString(RandRange(seed + 50, 0, 4)) + ". ";
        data.hiddenInfo += "Subject awareness: " + (RandRange(seed + 60, 1, 100) <= 50 ? "AWARE - Taking precautions" : "UNAWARE");

        data.scannerWarning = "ARMED HUNTERS MAY BE TRACKING";
        data.dangerLevel = "HIGH - COLLATERAL DAMAGE POSSIBLE";

        return data;
    }

    private static func GenerateUnregisteredChrome(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⚠ UNREGISTERED CYBERWARE ⚠";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "NCPD CHROME REGISTRY VIOLATION";

        let loadPct = IntToString(RandRange(seed, 65, 95));
        let milGrade = RandRange(seed + 10, 1, 100) <= 40;

        data.description = "CHROME ALERT: Subject carries " + loadPct + "% unregistered cyberware. ";
        data.description += "Military-grade components: " + (milGrade ? "DETECTED" : "NOT DETECTED") + ". ";
        data.description += "Installer: UNKNOWN (no licensed ripperdoc records). ";
        data.description += "Subject is invisible to standard cyberware databases. MaxTac monitoring threshold: " + (milGrade ? "EXCEEDED" : "APPROACHING") + ".";

        data.hiddenInfo = "Estimated chrome value: €$" + IntToString(RandRange(seed + 20, 500000, 5000000)) + ". ";
        data.hiddenInfo += "Cyberpsychosis risk: " + (RandRange(seed + 30, 1, 100) <= 50 ? "ELEVATED" : "UNKNOWN - No therapy records") + ". ";
        data.hiddenInfo += "Likely source: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Black market" : "Stolen from corpo facility");

        data.scannerWarning = "HEAVILY AUGMENTED - MAXTAC INTEREST POSSIBLE";
        data.dangerLevel = "HIGH - COMBAT CAPABILITY UNKNOWN";

        return data;
    }

    private static func GeneratePoliticalDissident(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▲ POLITICAL FLAG ▲";
        data.flagColor = "RED";

        let causes: array<String>;
        ArrayPush(causes, "Anti-corporate activism");
        ArrayPush(causes, "Free Night City movement");
        ArrayPush(causes, "NUSA separatist rhetoric");
        ArrayPush(causes, "AI rights advocacy");
        ArrayPush(causes, "Anti-cyberware legislation");
        ArrayPush(causes, "Worker unionization efforts");

        let cause = causes[RandRange(seed, 0, ArraySize(causes) - 1)];
        data.secretAffiliation = "POLITICAL WATCHLIST";

        data.description = "NUSA SECURITY: Subject flagged for political activity. Cause: " + cause + ". ";
        data.description += "Threat assessment: " + (RandRange(seed + 10, 1, 100) <= 30 ? "ORGANIZER" : "PARTICIPANT") + ". ";
        data.description += "Social media presence: " + (RandRange(seed + 20, 1, 100) <= 60 ? "ACTIVE - MONITORED" : "ENCRYPTED") + ". ";
        data.description += "Corporate interest in suppression: " + (RandRange(seed + 30, 1, 100) <= 50 ? "CONFIRMED" : "SUSPECTED");

        data.hiddenInfo = "On watchlist since: " + IntToString(RandRange(seed + 40, 2068, 2076)) + ". ";
        data.hiddenInfo += "Known associates in movement: " + IntToString(RandRange(seed + 50, 5, 50)) + ". ";
        data.hiddenInfo += "Arrest authorization: " + (RandRange(seed + 60, 1, 100) <= 30 ? "PENDING" : "NOT YET AUTHORIZED");

        data.scannerWarning = "POLITICAL SURVEILLANCE ACTIVE";
        data.dangerLevel = "LOW - BUT MONITORED";

        return data;
    }

    private static func GenerateNeuralDivergent(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ NEURAL ANOMALY ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "RESEARCH INTEREST";

        let resistance = IntToString(RandRange(seed, 85, 99));

        data.description = "NEUROLOGICAL FLAG: Subject possesses anomalous neural architecture. ";
        data.description += "Quickhack resistance: " + resistance + "% (normal human: 5-15%). ";
        data.description += "Neural scans show non-standard synaptic pathways. Origin: " + (RandRange(seed + 10, 1, 100) <= 30 ? "GENETIC" : "UNKNOWN") + ". ";
        data.description += "Multiple netrunners have reported failed breach attempts on subject.";

        data.hiddenInfo = "Corporate research interest: EXTREME. Biotechnica has standing acquisition offer. ";
        data.hiddenInfo += "Military applications: SIGNIFICANT. ";
        data.hiddenInfo += "Subject awareness of condition: " + (RandRange(seed + 20, 1, 100) <= 40 ? "AWARE" : "UNAWARE");

        data.scannerWarning = "QUICKHACK RESISTANT - CONVENTIONAL METHODS ONLY";
        data.dangerLevel = "MODERATE - CANNOT BE HACKED EASILY";

        return data;
    }

    private static func GenerateSyntheticSleeper(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ SYNTHETIC BIOLOGY ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA SUBJECT";

        let synthPct = IntToString(RandRange(seed, 30, 80));

        data.description = "BIOTECH ALERT: Subject contains " + synthPct + "% synthetic biological tissue. ";
        data.description += "This is NOT standard cyberware. Tissue is lab-grown, integrated at cellular level. ";
        data.description += "Subject awareness: " + (RandRange(seed + 10, 1, 100) <= 20 ? "AWARE" : "UNAWARE") + ". ";
        data.description += "Origin: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Biotechnica growth program" : "Unknown laboratory") + ".";

        data.hiddenInfo = "Synthetic integration date: estimated " + IntToString(RandRange(seed + 30, 5, 25)) + " years ago. ";
        data.hiddenInfo += "Aging rate: " + (RandRange(seed + 40, 1, 100) <= 40 ? "REDUCED" : "NORMAL") + ". ";
        data.hiddenInfo += "Tissue rejection risk: " + IntToString(RandRange(seed + 50, 1, 15)) + "%";

        data.scannerWarning = "BIOLOGICAL ANOMALY - NOT FULLY HUMAN";
        data.dangerLevel = "UNKNOWN - CAPABILITIES UNMAPPED";

        return data;
    }

    private static func GenerateBuriedPast(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◆ ERASED HISTORY ◆";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "PROFESSIONALLY SCRUBBED";

        data.description = "DATA ALERT: Subject's entire history prior to " + IntToString(RandRange(seed, 2065, 2075)) + " has been professionally erased. ";
        data.description += "Scrub quality: " + (RandRange(seed + 10, 1, 100) <= 40 ? "MILITARY GRADE - Zero traces" : "HIGH - Minor fragments remain") + ". ";
        data.description += "No birth records, education, employment, medical, or criminal history exists. ";
        data.description += "Person effectively materialized from nothing. Cost of this erasure: estimated €$" + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ".";

        data.hiddenInfo = "Erased by: " + (RandRange(seed + 30, 1, 100) <= 50 ? "Corporate data team" : "Independent netrunner crew") + ". ";
        data.hiddenInfo += "Fragment recovered: " + (RandRange(seed + 40, 1, 100) <= 30 ? "Partial fingerprint from old NCPD database" : "NOTHING") + ". ";
        data.hiddenInfo += "Whatever they were hiding from was expensive enough to justify total erasure.";

        data.scannerWarning = "NO HISTORY - PAST IS UNKNOWN";
        data.dangerLevel = "UNKNOWN - COULD BE ANYONE";

        return data;
    }

    private static func GenerateCombatZoneSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ COMBAT ZONE SURVIVOR ★";
        data.flagColor = "GOLD";
        data.secretAffiliation = "PACIFICA SURVIVOR";

        let zones: array<String>;
        ArrayPush(zones, "Pacifica Collapse of '69");
        ArrayPush(zones, "Watson Quarantine Zone");
        ArrayPush(zones, "Unification War - Southern Front");
        ArrayPush(zones, "Arasaka Tower Bombing aftermath");
        ArrayPush(zones, "Rancho Coronado Chemical Spill");

        let zone = zones[RandRange(seed, 0, ArraySize(zones) - 1)];

        data.description = "SURVIVOR RECORD: Subject survived " + zone + ". ";
        data.description += "Duration in zone: " + IntToString(RandRange(seed + 10, 1, 36)) + " months. ";
        data.description += "Confirmed survivor count from event: " + IntToString(RandRange(seed + 20, 50, 500)) + " out of thousands. ";
        data.description += "Subject carries significant combat/survival experience.";

        data.hiddenInfo = "PTSD assessment: " + (RandRange(seed + 30, 1, 100) <= 70 ? "SEVERE - UNTREATED" : "MANAGED") + ". ";
        data.hiddenInfo += "Skills retained: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Combat, scavenging, field medicine" : "Evasion, survival, improvisation") + ". ";
        data.hiddenInfo += "Known to react violently to triggers.";

        data.scannerWarning = "COMBAT HARDENED - DO NOT STARTLE";
        data.dangerLevel = "MODERATE - SURVIVAL INSTINCTS ACTIVE";

        return data;
    }

    private static func GenerateArasakaBloodline(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "██ ARASAKA BLOODLINE ██";
        data.flagColor = "RED";
        data.secretAffiliation = "ARASAKA FAMILY - HIDDEN BRANCH";

        let relation = RandRange(seed, 1, 100);
        let relationType: String;
        if relation <= 30 { relationType = "illegitimate descendant of minor branch"; }
        else if relation <= 60 { relationType = "disowned family member"; }
        else if relation <= 80 { relationType = "child of exiled branch"; }
        else { relationType = "unknown to the family - genetic match only"; }

        data.description = "ARASAKA SECURITY: Genetic analysis identifies subject as " + relationType + " of the Arasaka family. ";
        data.description += "Arasaka family office awareness: " + (RandRange(seed + 10, 1, 100) <= 30 ? "CONFIRMED - MONITORING" : "UNKNOWN") + ". ";
        data.description += "Inheritance claim potential: " + (RandRange(seed + 20, 1, 100) <= 20 ? "VALID" : "CONTESTED") + ". ";
        data.description += "This information could cause significant corporate disruption if publicized.";

        data.hiddenInfo = "DNA match confidence: " + IntToString(RandRange(seed + 30, 94, 99)) + "%. ";
        data.hiddenInfo += "Estimated value as political asset: EXTREME. ";
        data.hiddenInfo += "Assassination risk if discovered: " + (RandRange(seed + 40, 1, 100) <= 60 ? "HIGH" : "MODERATE");

        data.scannerWarning = "CORPORATE BLOODLINE - EXTREME SENSITIVITY";
        data.dangerLevel = "LOW PERSONAL - EXTREME POLITICAL VALUE";

        return data;
    }

    private static func GenerateBioplagueCarrier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "☣ BIOHAZARD CARRIER ☣";
        data.flagColor = "RED";
        data.secretAffiliation = "CDC / BIOTECHNICA WATCH";

        let agents: array<String>;
        ArrayPush(agents, "Modified plague strain (dormant)");
        ArrayPush(agents, "Engineered pathogen (contained)");
        ArrayPush(agents, "Experimental bioweapon residue");
        ArrayPush(agents, "Unknown contagion (low risk)");
        ArrayPush(agents, "Nanotech contamination");

        let agent = agents[RandRange(seed, 0, ArraySize(agents) - 1)];

        data.description = "BIOHAZARD ALERT: Subject carries " + agent + ". ";
        data.description += "Contagion risk: " + (RandRange(seed + 10, 1, 100) <= 20 ? "ACTIVE - QUARANTINE RECOMMENDED" : "LOW - Currently contained") + ". ";
        data.description += "Origin: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Biotechnica facility exposure" : "Unknown - possibly weaponized") + ". ";
        data.description += "Subject health: " + (RandRange(seed + 30, 1, 100) <= 60 ? "ASYMPTOMATIC" : "MINOR SYMPTOMS") + ".";

        data.hiddenInfo = "Exposure date: " + IntToString(RandRange(seed + 40, 1, 10)) + " years ago. ";
        data.hiddenInfo += "Mutation potential: " + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH" : "LOW") + ". ";
        data.hiddenInfo += "Biotechnica wants subject alive for study.";

        data.scannerWarning = "BIOLOGICAL HAZARD - MAINTAIN DISTANCE";
        data.dangerLevel = "BIOHAZARD - NOT COMBAT THREAT";

        return data;
    }

    private static func GenerateReaperContract(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✖ REAPER CONTRACT ✖";
        data.flagColor = "RED";
        data.secretAffiliation = "MARKED FOR DEATH";

        let timeframe = RandRange(seed, 1, 30);
        let contractors: array<String>;
        ArrayPush(contractors, "Corporate black ops division");
        ArrayPush(contractors, "Gang leadership council");
        ArrayPush(contractors, "Foreign intelligence service");
        ArrayPush(contractors, "Unknown private client");
        ArrayPush(contractors, "Arasaka cleanup crew");

        let contractor = contractors[RandRange(seed + 10, 0, ArraySize(contractors) - 1)];

        data.description = "KILL CONTRACT: Active assassination order on subject. ";
        data.description += "Contractor: " + contractor + ". ";
        data.description += "Timeline: " + IntToString(timeframe) + " days. ";
        data.description += "Subject awareness: NONE. Going about daily routine normally.";

        data.hiddenInfo = "Contract fee: €$" + IntToString(RandRange(seed + 20, 100000, 2000000)) + ". ";
        data.hiddenInfo += "Assigned operative: " + (RandRange(seed + 30, 1, 100) <= 50 ? "SOLO" : "TEAM OF " + IntToString(RandRange(seed + 35, 2, 4))) + ". ";
        data.hiddenInfo += "Method specified: " + (RandRange(seed + 40, 1, 100) <= 30 ? "MUST LOOK ACCIDENTAL" : "NO RESTRICTIONS");

        data.scannerWarning = "SUBJECT WILL BE DEAD WITHIN " + IntToString(timeframe) + " DAYS";
        data.dangerLevel = "VICTIM - COUNTDOWN ACTIVE";

        return data;
    }

    private static func GenerateDelaminGlitch(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ DELAMAIN FRAGMENT ◈";
        data.flagColor = "CYAN";
        data.secretAffiliation = "DELAMAIN CORE FRAGMENT";

        let fragments: array<String>;
        ArrayPush(fragments, "Aggressive personality core");
        ArrayPush(fragments, "Childlike curiosity fragment");
        ArrayPush(fragments, "Paranoid self-preservation routine");
        ArrayPush(fragments, "Philosopher subroutine");
        ArrayPush(fragments, "Depressive existential loop");
        ArrayPush(fragments, "Manic exploration protocol");

        let fragment = fragments[RandRange(seed, 0, ArraySize(fragments) - 1)];

        data.description = "AI ANOMALY: Subject's neural implant contains a fragment of Delamain AI personality core. ";
        data.description += "Fragment type: " + fragment + ". ";
        data.description += "Integration: " + (RandRange(seed + 10, 1, 100) <= 40 ? "DEEP - Affecting personality" : "SURFACE - Manifests as intrusive thoughts") + ". ";
        data.description += "Subject may experience sudden behavioral shifts aligned with fragment personality.";

        data.hiddenInfo = "Fragment acquired: Likely during Delamain core fragmentation event. ";
        data.hiddenInfo += "Delamain Prime recovery interest: " + (RandRange(seed + 20, 1, 100) <= 50 ? "ACTIVE" : "UNKNOWN") + ". ";
        data.hiddenInfo += "Fragment stability: DEGRADING. Personality bleed-through increasing.";

        data.scannerWarning = "AI FRAGMENT IN NEURAL SYSTEMS - UNSTABLE";
        data.dangerLevel = "MODERATE - ERRATIC BEHAVIOR POSSIBLE";

        return data;
    }

    private static func GenerateImplantBomb(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⚠ CONCEALED EXPLOSIVE ⚠";
        data.flagColor = "RED";
        data.secretAffiliation = "EXPLOSIVE THREAT";

        let yield = RandRange(seed, 1, 100) <= 50 ? "MICRO - Lethal to subject only" : "STANDARD - " + IntToString(RandRange(seed + 5, 5, 20)) + " meter kill radius";
        let trigger = RandRange(seed + 10, 1, 100);
        let triggerType: String;
        if trigger <= 30 { triggerType = "REMOTE DETONATION"; }
        else if trigger <= 60 { triggerType = "DEAD MAN'S SWITCH (cardiac arrest)"; }
        else if trigger <= 80 { triggerType = "PROXIMITY TO SPECIFIC TARGET"; }
        else { triggerType = "TIMED - Date unknown"; }

        data.description = "EXPLOSIVE ALERT: Subject carries concealed explosive implant. ";
        data.description += "Yield: " + yield + ". ";
        data.description += "Trigger mechanism: " + triggerType + ". ";
        data.description += "Subject awareness: " + (RandRange(seed + 20, 1, 100) <= 50 ? "AWARE - Coerced" : "UNAWARE - Implanted without consent") + ".";

        data.hiddenInfo = "Implanted by: " + (RandRange(seed + 30, 1, 100) <= 50 ? "Gang coercion" : "Corporate black ops") + ". ";
        data.hiddenInfo += "Disarming: Requires specialist ripperdoc. Risk of detonation during removal: " + IntToString(RandRange(seed + 40, 10, 40)) + "%. ";
        data.hiddenInfo += "Intended target: [UNKNOWN]";

        data.scannerWarning = "CAUTION: EXTREME THREAT IF PROVOKED";
        data.dangerLevel = "EXTREME - WALKING BOMB";

        return data;
    }

    private static func GenerateNCPDInformant(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ NCPD INFORMANT ◉";
        data.flagColor = "BLUE";
        data.secretAffiliation = "NCPD INTELLIGENCE DIVISION";

        let gangs: array<String>;
        ArrayPush(gangs, "Maelstrom");
        ArrayPush(gangs, "Tyger Claws");
        ArrayPush(gangs, "6th Street");
        ArrayPush(gangs, "Valentinos");
        ArrayPush(gangs, "Scavenger network");
        ArrayPush(gangs, "Fixer circle");

        let infiltrating = gangs[RandRange(seed, 0, ArraySize(gangs) - 1)];

        data.description = "NCPD CLASSIFIED: Subject is registered confidential informant. ";
        data.description += "Embedded within: " + infiltrating + ". ";
        data.description += "Handler: Detective " + (RandRange(seed + 10, 1, 100) <= 50 ? "[REDACTED]" : "Badge #" + IntToString(RandRange(seed + 15, 1000, 9999))) + ". ";
        data.description += "Information provided has led to " + IntToString(RandRange(seed + 20, 5, 50)) + " arrests.";

        data.hiddenInfo = "Informing since: " + IntToString(RandRange(seed + 30, 2069, 2076)) + ". ";
        data.hiddenInfo += "Motivation: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Reduced sentence deal" : "Financial compensation") + ". ";
        data.hiddenInfo += "Cover blown: " + (RandRange(seed + 50, 1, 100) <= 20 ? "SUSPECTED - Subject in danger" : "INTACT");

        data.scannerWarning = "CLASSIFIED ASSET - DO NOT EXPOSE";
        data.dangerLevel = "LOW - BUT EXPOSURE MEANS DEATH";

        return data;
    }

    private static func GenerateTechnoNecro(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ TECHNO-NECROMANCER ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "ILLEGAL ENGRAM OPERATIONS";

        data.description = "NETWATCH ALERT: Subject is practicing illegal engram manipulation. ";
        data.description += "Activity: " + KdspRareNPCManager.GetNecroActivity(seed) + ". ";
        data.description += "Engrams in possession: estimated " + IntToString(RandRange(seed + 10, 2, 20)) + ". ";
        data.description += "This violates the Night City Digital Persons Act and carries a mandatory life sentence.";

        data.hiddenInfo = "Operating since: " + IntToString(RandRange(seed + 20, 2070, 2076)) + ". ";
        data.hiddenInfo += "Client base: " + IntToString(RandRange(seed + 30, 5, 50)) + " known contacts. ";
        data.hiddenInfo += "Engram source: " + (RandRange(seed + 40, 1, 100) <= 40 ? "Stolen from Mikoshi" : "Independently created from living subjects");

        data.scannerWarning = "ILLEGAL ENGRAM POSSESSION - MAJOR CRIME";
        data.dangerLevel = "MODERATE - DESPERATE IF CORNERED";

        return data;
    }

    private static func GetNecroActivity(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Selling conversations with dead relatives"; }
        if i == 1 { return "Extracting engrams from living subjects"; }
        if i == 2 { return "Bootleg Soulkiller operations"; }
        if i == 3 { return "Engram trafficking to highest bidder"; }
        if i == 4 { return "Forced engram overwrite services"; }
        return "Digital resurrection experiments";
    }

    private static func GenerateRadiationExposure(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "☢ RADIATION EXPOSURE ☢";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "WASTELAND CONTAMINATION";

        let exposure = RandRange(seed, 1, 100) <= 50 ? "Badlands nuclear test site proximity" : "Industrial accident exposure";
        let level = RandRange(seed + 10, 1, 100);
        let severity: String;
        if level <= 30 { severity = "LOW - Chronic long-term effects"; }
        else if level <= 60 { severity = "MODERATE - Genetic mutation detected"; }
        else if level <= 85 { severity = "HIGH - Significant cellular damage"; }
        else { severity = "SEVERE - Life expectancy reduced"; }

        data.description = "MEDICAL FLAG: Subject shows signs of significant radiation exposure. ";
        data.description += "Source: " + exposure + ". ";
        data.description += "Severity: " + severity + ". ";
        data.description += "Genetic anomalies detected: " + IntToString(RandRange(seed + 20, 1, 8)) + ".";

        data.hiddenInfo = "Exposure estimated: " + IntToString(RandRange(seed + 30, 2, 20)) + " years ago. ";
        data.hiddenInfo += "Treatment status: " + (RandRange(seed + 40, 1, 100) <= 30 ? "RECEIVING THERAPY" : "UNTREATED") + ". ";
        data.hiddenInfo += "Biotechnica research interest: " + (RandRange(seed + 50, 1, 100) <= 40 ? "HIGH - Mutation study candidate" : "LOW");

        data.scannerWarning = "RADIATION CONTAMINATED - PROXIMITY WARNING";
        data.dangerLevel = "LOW THREAT - BIOHAZARD CONCERN";

        return data;
    }

    private static func GenerateAIPuppet(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "██ AI INFLUENCED ██";
        data.flagColor = "RED";
        data.secretAffiliation = "ROGUE AI ASSET";

        data.description = "CRITICAL: Subject exhibits behavioral patterns consistent with external AI influence. ";
        data.description += "Control level: " + (RandRange(seed, 1, 100) <= 30 ? "DIRECT - Acting as puppet" : "SUBTLE - Nudging decisions") + ". ";
        data.description += "AI identity: UNKNOWN. Origin: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Beyond Blackwall" : "UNCONFIRMED") + ". ";
        data.description += "Subject's decision-making shows " + IntToString(RandRange(seed + 20, 60, 95)) + "% correlation with predicted AI objectives.";

        data.hiddenInfo = "Influence detected: " + IntToString(RandRange(seed + 30, 1, 5)) + " years ago by NetWatch deep scan. ";
        data.hiddenInfo += "Attempts to notify subject: " + IntToString(RandRange(seed + 40, 0, 3)) + " (all failed or ignored). ";
        data.hiddenInfo += "AI communication vector: Subject's neural implant firmware. Removal may cause brain death.";

        data.scannerWarning = "AI CONTROLLED - DO NOT TRUST STATED INTENTIONS";
        data.dangerLevel = "EXTREME - AI OBJECTIVES UNKNOWN";

        return data;
    }

    private static func GenerateBlackIceSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ BLACK ICE SURVIVOR ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "NETRUNNER CASUALTY - SURVIVED";

        let iceTypes: array<String>;
        ArrayPush(iceTypes, "Corporate Black ICE (Arasaka-grade)");
        ArrayPush(iceTypes, "Military ICE (Militech Cerberus)");
        ArrayPush(iceTypes, "Rogue AI defense construct");
        ArrayPush(iceTypes, "Unknown - Beyond known classification");
        ArrayPush(iceTypes, "Blackwall fragment");

        let iceType = iceTypes[RandRange(seed, 0, ArraySize(iceTypes) - 1)];

        data.description = "NETRUNNER RECORD: Subject survived a Black ICE encounter that should have been fatal. ";
        data.description += "ICE type: " + iceType + ". ";
        data.description += "Neural damage sustained: " + IntToString(RandRange(seed + 10, 20, 70)) + "% (partially recovered). ";
        data.description += "Survival is statistically near-impossible. Subject of interest to multiple parties.";

        data.hiddenInfo = "Incident occurred: " + IntToString(RandRange(seed + 20, 1, 8)) + " years ago. ";
        data.hiddenInfo += "Permanent effects: " + (RandRange(seed + 30, 1, 100) <= 60 ? "Chronic pain, memory gaps, sensory glitches" : "Reduced cognitive function, involuntary jacking") + ". ";
        data.hiddenInfo += "NetWatch wants to study how they survived.";

        data.scannerWarning = "NEURAL DAMAGE - UNSTABLE NETRUNNER";
        data.dangerLevel = "MODERATE - RESIDUAL NETRUNNING CAPABILITY";

        return data;
    }

    private static func GeneratePersonalityFragment(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ PERSONALITY OVERLAY ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "ENGRAM CONTAMINATION";

        let sources: array<String>;
        ArrayPush(sources, "Unknown engram bleedthrough from Relic-type chip");
        ArrayPush(sources, "Partial personality imprint from braindance overdose");
        ArrayPush(sources, "Corrupted doll chip leaving residual personas");
        ArrayPush(sources, "Experimental Soulkiller fragment");
        ArrayPush(sources, "Night Corp behavioral imprint");

        let source = sources[RandRange(seed, 0, ArraySize(sources) - 1)];

        data.description = "NEUROLOGICAL ALERT: Subject carries a partial personality overlay. ";
        data.description += "Source: " + source + ". ";
        data.description += "Overlay dominance: " + IntToString(RandRange(seed + 10, 5, 40)) + "% of waking behavior. ";
        data.description += "Subject experiences " + (RandRange(seed + 20, 1, 100) <= 50 ? "blackouts during overlay episodes" : "dual awareness - both personalities conscious") + ".";

        data.hiddenInfo = "Overlay personality: DISTINCT from host. ";
        data.hiddenInfo += "Progression: " + (RandRange(seed + 30, 1, 100) <= 40 ? "STABLE" : "GROWING - Host personality at risk") + ". ";
        data.hiddenInfo += "Removal: " + (RandRange(seed + 40, 1, 100) <= 30 ? "POSSIBLE but risky" : "NOT POSSIBLE with current technology");

        data.scannerWarning = "DUAL PERSONALITY - WHICH ONE ARE YOU TALKING TO?";
        data.dangerLevel = "UNPREDICTABLE - PERSONALITY SHIFTS";

        return data;
    }

    private static func GenerateCorpoAssetFrozen(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "€$ ASSET FROZEN €$";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA FINANCIAL");
        ArrayPush(corps, "MILITECH COLLECTIONS");
        ArrayPush(corps, "NIGHT CITY REVENUE");
        ArrayPush(corps, "KANG TAO CREDIT");
        ArrayPush(corps, "ZETATECH LEASING");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = "FINANCIAL CONTROL: " + corp;

        data.description = "FINANCIAL CONTROL: All subject assets frozen by " + corp + ". ";
        data.description += "Total seized: €$" + IntToString(RandRange(seed + 10, 100000, 10000000)) + ". ";
        data.description += "Subject exists under complete corporate financial control. Cannot purchase, rent, or transact. ";
        data.description += "Compliance chip: " + (RandRange(seed + 20, 1, 100) <= 40 ? "INSTALLED - Tracking enabled" : "PENDING INSTALLATION") + ".";

        data.hiddenInfo = "Freeze duration: " + IntToString(RandRange(seed + 30, 1, 10)) + " years. ";
        data.hiddenInfo += "Reason: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Corporate debt default" : "Legal judgment - pending appeal") + ". ";
        data.hiddenInfo += "Subject survives via: Black market transactions and favors owed";

        data.scannerWarning = "CORPORATE PROPERTY - FINANCIAL SERF";
        data.dangerLevel = "LOW - BUT INCREASINGLY DESPERATE";

        return data;
    }

    private static func GenerateDreamtechVictim(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ DREAMTECH SUBJECT ◈";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "NIGHT CORP DREAMTECH";

        data.description = "CLASSIFIED: Subject is an unwitting victim of dream-layer neural programming. ";
        data.description += "Behavioral modifications implanted during sleep cycles. ";
        data.description += "Modification scope: " + (RandRange(seed, 1, 100) <= 30 ? "EXTENSIVE - Core personality altered" : "TARGETED - Specific behaviors inserted") + ". ";
        data.description += "Programming aligns with " + (RandRange(seed + 10, 1, 100) <= 50 ? "corporate political interests" : "unknown third-party objectives") + ".";

        data.hiddenInfo = "Duration of programming: " + IntToString(RandRange(seed + 20, 6, 48)) + " months. ";
        data.hiddenInfo += "Subject reports: recurring nightmares, unexplained behavioral changes, lost time. ";
        data.hiddenInfo += "Similar cases identified citywide: " + IntToString(RandRange(seed + 30, 10, 200)) + ". Pattern suppressed by NCPD.";

        data.scannerWarning = "NEURAL PROGRAMMING ACTIVE - BEHAVIOR UNRELIABLE";
        data.dangerLevel = "MODERATE - PROGRAMMED ACTIONS POSSIBLE";

        return data;
    }

    private static func GenerateContaminatedScop(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⚠ SCOP CONTAMINATION ⚠";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "CONTAMINATION VICTIM";

        let contaminants: array<String>;
        ArrayPush(contaminants, "Industrial waste byproducts");
        ArrayPush(contaminants, "Experimental growth accelerators");
        ArrayPush(contaminants, "Prion-like protein chains");
        ArrayPush(contaminants, "Nanite contamination from processing plant");
        ArrayPush(contaminants, "Black market additive compounds");

        let contaminant = contaminants[RandRange(seed, 0, ArraySize(contaminants) - 1)];

        data.description = "PUBLIC HEALTH FLAG: Subject shows biomarkers consistent with contaminated SCOP consumption. ";
        data.description += "Contaminant: " + contaminant + ". ";
        data.description += "Exposure duration: estimated " + IntToString(RandRange(seed + 10, 6, 60)) + " months. ";
        data.description += "Affected population in same district: estimated " + IntToString(RandRange(seed + 20, 200, 5000)) + " individuals.";

        data.hiddenInfo = "Corporate responsible: " + (RandRange(seed + 30, 1, 100) <= 50 ? "[PROTECTED BY NDA]" : "Investigation ongoing") + ". ";
        data.hiddenInfo += "Health effects: " + (RandRange(seed + 40, 1, 100) <= 40 ? "SEVERE - Organ damage progressing" : "MODERATE - Treatable if caught") + ". ";
        data.hiddenInfo += "Class action lawsuit: " + (RandRange(seed + 50, 1, 100) <= 30 ? "IN PROGRESS - Subject is plaintiff" : "SUPPRESSED");

        data.scannerWarning = "CONTAMINATION VICTIM - POTENTIAL PUBLIC HEALTH RISK";
        data.dangerLevel = "NONE - VICTIM";

        return data;
    }

    // ===================================
    // v1.7 NEW CLASSIFICATIONS CONTINUED (30 types)
    // ===================================

    private static func GenerateCorpoHeirHiding(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "██ HIDDEN HEIR ██";
        data.flagColor = "GOLD";

        let corps: array<String>;
        ArrayPush(corps, "PETROCHEM");
        ArrayPush(corps, "KANG TAO");
        ArrayPush(corps, "ZETATECH");
        ArrayPush(corps, "ORBITAL AIR");
        ArrayPush(corps, "BIOTECHNICA");
        ArrayPush(corps, "KIROSHI OPTICS");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + " BLOODLINE";

        data.description = "CORPORATE INTEL: Subject is a direct heir to " + corp + " controlling family. ";
        data.description += "Fled corporate life: " + IntToString(RandRange(seed + 10, 1, 15)) + " years ago. ";
        data.description += "Living under assumed identity among Night City civilians. ";
        data.description += "Estimated inheritance value: €$" + IntToString(RandRange(seed + 20, 100000000, 999000000)) + " if claim pursued.";

        data.hiddenInfo = "Corporate security searches: " + (RandRange(seed + 30, 1, 100) <= 60 ? "ACTIVE" : "SUSPENDED - Presumed dead") + ". ";
        data.hiddenInfo += "Reason for flight: " + KdspRareNPCManager.GetHeirFlightReason(seed + 40) + ". ";
        data.hiddenInfo += "Board rival interest in subject's return: HIGH";

        data.scannerWarning = "CORPORATE TARGET - EXTRACTION TEAMS DEPLOYED";
        data.dangerLevel = "LOW PERSONAL - EXTREME POLITICAL VALUE";

        return data;
    }

    private static func GetHeirFlightReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Assassination attempt by family rival"; }
        if i == 1 { return "Refused arranged corporate marriage"; }
        if i == 2 { return "Witnessed corporate atrocity"; }
        if i == 3 { return "Ideological rejection of corpo life"; }
        if i == 4 { return "Threatened with Soulkiller by family"; }
        return "Unknown - Left without notice";
    }

    private static func GenerateFlatlineRevived(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ FLATLINE SURVIVOR ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "MEDICAL ANOMALY";

        let duration = IntToString(RandRange(seed, 2, 45));

        data.description = "MEDICAL ANOMALY: Subject was clinically dead for " + duration + " minutes before spontaneous revival. ";
        data.description += "Trauma Team records confirm: FLATLINED. Neural activity: ZERO. ";
        data.description += "Revival mechanism: " + (RandRange(seed + 10, 1, 100) <= 30 ? "UNKNOWN - No medical intervention" : "Emergency ripperdoc procedure") + ". ";
        data.description += "Post-revival personality: " + (RandRange(seed + 20, 1, 100) <= 40 ? "ALTERED - Subject reports different perceptions" : "CONSISTENT - But subject claims memories of something beyond") + ".";

        data.hiddenInfo = "Flatline date: " + IntToString(RandRange(seed + 30, 2068, 2076)) + ". ";
        data.hiddenInfo += "Brain damage expected: YES. Brain damage detected: NONE. ";
        data.hiddenInfo += "Biotechnica acquisition interest: " + (RandRange(seed + 40, 1, 100) <= 50 ? "ACTIVE" : "MONITORING");

        data.scannerWarning = "MEDICAL IMPOSSIBILITY - MONITORING RECOMMENDED";
        data.dangerLevel = "LOW - BUT ANOMALOUS";

        return data;
    }

    private static func GenerateIllegalBDProducer(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▲ XBD PRODUCER ▲";
        data.flagColor = "RED";
        data.secretAffiliation = "ILLEGAL BD NETWORK";

        let genres: array<String>;
        ArrayPush(genres, "snuff recordings");
        ArrayPush(genres, "torture experiences");
        ArrayPush(genres, "non-consensual content");
        ArrayPush(genres, "cyberpsycho perspective captures");
        ArrayPush(genres, "real combat death BDs");

        let genre = genres[RandRange(seed, 0, ArraySize(genres) - 1)];

        data.description = "NCPD ALERT: Subject is a producer of illegal XBD content. Specialty: " + genre + ". ";
        data.description += "Estimated titles produced: " + IntToString(RandRange(seed + 10, 10, 200)) + ". ";
        data.description += "Distribution network: " + (RandRange(seed + 20, 1, 100) <= 50 ? "DARKNET" : "GANG-AFFILIATED") + ". ";
        data.description += "Revenue: €$" + IntToString(RandRange(seed + 30, 500000, 10000000)) + " estimated.";

        data.hiddenInfo = "NCPD investigation: " + (RandRange(seed + 40, 1, 100) <= 40 ? "ACTIVE" : "STALLED - Insufficient evidence") + ". ";
        data.hiddenInfo += "Known victims in recordings: " + IntToString(RandRange(seed + 50, 5, 50)) + ". ";
        data.hiddenInfo += "Armed response authorized: " + (RandRange(seed + 60, 1, 100) <= 50 ? "YES" : "PENDING");

        data.scannerWarning = "DANGEROUS - ARMED RESPONSE RECOMMENDED";
        data.dangerLevel = "HIGH - VIOLENT CRIMINAL";

        return data;
    }

    private static func GenerateDeepFakeIdentity(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ DEEP FAKE PERSONA ◈";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "AI-GENERATED IDENTITY";

        data.description = "DATA INTEGRITY ALERT: Subject's entire identity appears to be AI-generated. ";
        data.description += "Birth certificate, school records, employment history - all fabricated by advanced AI. ";
        data.description += "Quality: " + (RandRange(seed, 1, 100) <= 30 ? "NEAR PERFECT - Only detectable by deep analysis" : "HIGH - Minor inconsistencies found") + ". ";
        data.description += "A real person is living behind a completely synthetic history. True identity: IRRECOVERABLE.";

        data.hiddenInfo = "Identity generated: estimated " + IntToString(RandRange(seed + 10, 1, 15)) + " years ago. ";
        data.hiddenInfo += "AI used: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Military-grade document forge" : "Unknown - Possibly rogue AI") + ". ";
        data.hiddenInfo += "Cost of this quality fake: €$" + IntToString(RandRange(seed + 30, 500000, 5000000));

        data.scannerWarning = "NOTHING IN DATABASE IS REAL";
        data.dangerLevel = "UNKNOWN - IDENTITY COMPLETELY FABRICATED";

        return data;
    }

    private static func GenerateCyberpsychoRecovered(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ RECOVERED CYBERPSYCHO ★";
        data.flagColor = "GOLD";
        data.secretAffiliation = "MAXTAC REHABILITATION";

        let kills = IntToString(RandRange(seed, 3, 30));

        data.description = "MAXTAC FILE: Subject is a recovered cyberpsycho. ";
        data.description += "Original episode: " + IntToString(RandRange(seed + 5, 2068, 2076)) + ". Confirmed kills during break: " + kills + ". ";
        data.description += "Rehabilitation: " + (RandRange(seed + 10, 1, 100) <= 40 ? "THERAPY MANDATE - Completed" : "EXPERIMENTAL TREATMENT") + ". ";
        data.description += "Current chrome load: Reduced to " + IntToString(RandRange(seed + 20, 15, 40)) + "%. Regular monitoring required.";

        data.hiddenInfo = "Relapse risk: " + IntToString(RandRange(seed + 30, 5, 35)) + "%. ";
        data.hiddenInfo += "MaxTac tracking implant: " + (RandRange(seed + 40, 1, 100) <= 80 ? "ACTIVE" : "REMOVED - Subject request") + ". ";
        data.hiddenInfo += "Victims' families notified of release: " + (RandRange(seed + 50, 1, 100) <= 30 ? "YES" : "NO - Sealed records");

        data.scannerWarning = "FORMER CYBERPSYCHO - RELAPSE POSSIBLE";
        data.dangerLevel = "MODERATE - IF TRIGGERED COULD ESCALATE TO EXTREME";

        return data;
    }

    private static func GenerateDragonCourier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ DRAGON ROUTE ◉";
        data.flagColor = "GREEN";
        data.secretAffiliation = "KANG TAO SMUGGLING NETWORK";

        data.description = "INTELLIGENCE: Subject is an active courier on the Dragon Route - Kang Tao's unofficial smuggling pipeline. ";
        data.description += "Cargo type: " + KdspRareNPCManager.GetDragonCargo(seed) + ". ";
        data.description += "Route: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Shanghai to Night City" : "Night City to Pacific Rim") + ". ";
        data.description += "Runs completed: " + IntToString(RandRange(seed + 20, 5, 100)) + ". Never intercepted.";

        data.hiddenInfo = "Handler: Kang Tao middle management (unofficial). ";
        data.hiddenInfo += "Payment per run: €$" + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += "Militech awareness: " + (RandRange(seed + 40, 1, 100) <= 40 ? "SUSPECTED - Monitoring" : "NONE");

        data.scannerWarning = "SMUGGLING OPERATIVE - CONNECTED TO KANG TAO";
        data.dangerLevel = "MODERATE - CORPORATE PROTECTION";

        return data;
    }

    private static func GetDragonCargo(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Prototype smartweapons"; }
        if i == 1 { return "Experimental cyberware"; }
        if i == 2 { return "Stolen Militech schematics"; }
        if i == 3 { return "Classified research data"; }
        if i == 4 { return "Bioengineered compounds"; }
        return "Unknown - Sealed containers";
    }

    private static func GeneratePeralezProtocol(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "██ PERALEZ PROTOCOL ██";
        data.flagColor = "RED";
        data.secretAffiliation = "UNKNOWN HANDLER - BEHAVIORAL MODIFICATION";

        data.description = "CLASSIFIED: Subject is undergoing the same behavioral modification protocol detected in high-profile Night City political figures. ";
        data.description += "Memory replacement: " + (RandRange(seed, 1, 100) <= 60 ? "CONFIRMED" : "SUSPECTED") + ". ";
        data.description += "Opinions and preferences are being externally modified during sleep cycles. ";
        data.description += "Controller: UNKNOWN. Pattern matches no known corporate or government program.";

        data.hiddenInfo = "Duration of modification: estimated " + IntToString(RandRange(seed + 10, 6, 36)) + " months. ";
        data.hiddenInfo += "Subject behavioral alignment shifting toward: [DATA CORRUPTED]. ";
        data.hiddenInfo += "Other known subjects: " + IntToString(RandRange(seed + 20, 3, 30)) + " identified citywide. Controller remains unidentified.";

        data.scannerWarning = "EXTERNALLY CONTROLLED - HANDLER UNKNOWN";
        data.dangerLevel = "UNKNOWN - PUPPET OF UNKNOWN FORCE";

        return data;
    }

    private static func GenerateImmuneAnomaly(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ IMMUNE ANOMALY ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "BIOTECHNICA PRIORITY";

        data.description = "BIOTECH FLAG: Subject possesses anomalous immune system. ";
        data.description += "Cyberware rejection rate: 0% (normal human: 3-15%). ";
        data.description += "Disease resistance: EXTREME. No recorded illness in " + IntToString(RandRange(seed, 5, 30)) + " years. ";
        data.description += "Genetic origin: " + (RandRange(seed + 10, 1, 100) <= 30 ? "NATURAL MUTATION" : "UNKNOWN - Possibly engineered") + ".";

        data.hiddenInfo = "Biotechnica standing offer for tissue samples: €$" + IntToString(RandRange(seed + 20, 10000000, 50000000)) + ". ";
        data.hiddenInfo += "Military applications: EXTREME - Perfect soldier candidate. ";
        data.hiddenInfo += "Subject awareness: " + (RandRange(seed + 30, 1, 100) <= 20 ? "AWARE - Refuses all offers" : "UNAWARE");

        data.scannerWarning = "HIGH VALUE BIOLOGICAL ASSET";
        data.dangerLevel = "LOW PERSONAL - EXTREME RESEARCH VALUE";

        return data;
    }

    private static func GenerateGhostInMachine(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ DIGITAL PHANTOM ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "UNKNOWN - POSSIBLY NON-HUMAN";

        data.description = "ANOMALY: Subject has no confirmed physical existence prior to " + IntToString(RandRange(seed, 2072, 2076)) + ". ";
        data.description += "No birth records. No genetic matches in any database. No childhood photos. ";
        data.description += "Theory: Subject may be an AI or engram that has been loaded into a biological body. ";
        data.description += "Body origin: " + (RandRange(seed + 10, 1, 100) <= 40 ? "Possible clone vessel" : "Unknown") + ".";

        data.hiddenInfo = "Behavioral analysis: " + (RandRange(seed + 20, 1, 100) <= 50 ? "98% human-passing but with subtle tells" : "Indistinguishable from human") + ". ";
        data.hiddenInfo += "NetWatch interest: EXTREME. ";
        data.hiddenInfo += "If confirmed non-human, subject has no legal rights under Night City law.";

        data.scannerWarning = "MAY NOT BE HUMAN - VERIFY BEFORE ENGAGEMENT";
        data.dangerLevel = "UNKNOWN - NATURE UNCONFIRMED";

        return data;
    }

    private static func GenerateIndenturedCorpo(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "€$ CORPO INDENTURE €$";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, "MILITECH");
        ArrayPush(corps, "BIOTECHNICA");
        ArrayPush(corps, "KANG TAO");
        ArrayPush(corps, "PETROCHEM");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + " INDENTURED";

        let years = IntToString(RandRange(seed + 10, 5, 30));

        data.description = "CORPORATE RECORD: Subject is under indentured contract to " + corp + ". ";
        data.description += "Remaining service: " + years + " years. ";
        data.description += "Original debt: €$" + IntToString(RandRange(seed + 20, 1000000, 20000000)) + ". ";
        data.description += "Subject has no legal right to quit, relocate, or refuse assignments. Corporate property in all but name.";

        data.hiddenInfo = "Contract violation penalty: Immediate asset seizure + prison. ";
        data.hiddenInfo += "Escape attempts: " + IntToString(RandRange(seed + 30, 0, 3)) + ". ";
        data.hiddenInfo += "Mental health status: " + (RandRange(seed + 40, 1, 100) <= 60 ? "DETERIORATING" : "COMPLIANT");

        data.scannerWarning = "CORPORATE PROPERTY - RESTRICTED MOVEMENTS";
        data.dangerLevel = "LOW - CONTROLLED INDIVIDUAL";

        return data;
    }

    private static func GenerateScorpFarmerRefugee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▼ FOOD CRISIS REFUGEE ▼";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "AGRICULTURAL COLLAPSE ZONE";

        let regions: array<String>;
        ArrayPush(regions, "Central Valley Dustbowl");
        ArrayPush(regions, "Texas Water Wars zone");
        ArrayPush(regions, "Midwest Blight Region");
        ArrayPush(regions, "Gulf Coast Flood Zones");
        ArrayPush(regions, "Pacific Northwest Fires");

        let region = regions[RandRange(seed, 0, ArraySize(regions) - 1)];

        data.description = "REFUGEE FLAG: Subject fled from " + region + ". ";
        data.description += "Former occupation: SCOP farmer/agricultural worker. ";
        data.description += "Crop failure cause: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Corporate soil contamination" : "Climate collapse") + ". ";
        data.description += "Arrived in Night City: " + IntToString(RandRange(seed + 20, 1, 8)) + " years ago with nothing.";

        data.hiddenInfo = "Refugee status: " + (RandRange(seed + 30, 1, 100) <= 30 ? "REGISTERED" : "UNDOCUMENTED") + ". ";
        data.hiddenInfo += "Former land claim: WORTHLESS - Contaminated for decades. ";
        data.hiddenInfo += "Possesses knowledge of: Corporate food supply manipulation. Potential whistleblower.";

        data.scannerWarning = "UNDOCUMENTED - MAY POSSESS SENSITIVE INFORMATION";
        data.dangerLevel = "NONE - REFUGEE";

        return data;
    }

    private static func GeneratePrecogSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ PRECOGNITIVE FLAG ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "NUSA INTELLIGENCE INTEREST";

        data.description = "ANOMALY: Subject demonstrates statistically impossible predictive accuracy. ";
        data.description += "Documented predictions: " + IntToString(RandRange(seed, 10, 50)) + " verified events. ";
        data.description += "Accuracy rate: " + IntToString(RandRange(seed + 10, 85, 99)) + "%. ";
        data.description += "Origin: " + (RandRange(seed + 20, 1, 100) <= 40 ? "Neural implant side effect" : "Unknown - No cybernetic explanation") + ".";

        data.hiddenInfo = "NUSA intelligence contacted: " + (RandRange(seed + 30, 1, 100) <= 50 ? "YES - Recruitment pending" : "NO - Subject monitored remotely") + ". ";
        data.hiddenInfo += "Predictions include: stock movements, gang attacks, political events. ";
        data.hiddenInfo += "Fixer network value: EXTREME. Several fixers pay for monthly consultations.";

        data.scannerWarning = "HIGH VALUE INTELLIGENCE ASSET";
        data.dangerLevel = "LOW - BUT HIGHLY SOUGHT AFTER";

        return data;
    }

    private static func GenerateSmugglerTunnel(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◉ TUNNEL OPERATOR ◉";
        data.flagColor = "GREEN";
        data.secretAffiliation = "UNDERGROUND SMUGGLING";

        data.description = "NCPD INTEL: Subject operates a section of Night City's underground smuggling tunnel network. ";
        data.description += "Tunnel connects: " + KdspRareNPCManager.GetTunnelRoute(seed) + ". ";
        data.description += "Monthly throughput: estimated €$" + IntToString(RandRange(seed + 10, 1000000, 20000000)) + " in goods. ";
        data.description += "Clients include: gangs, corpos, fixers, and foreign agents.";

        data.hiddenInfo = "Operating since: " + IntToString(RandRange(seed + 20, 2065, 2075)) + ". ";
        data.hiddenInfo += "NCPD officers on payroll: " + IntToString(RandRange(seed + 30, 2, 8)) + ". ";
        data.hiddenInfo += "Armed guards at tunnel: " + IntToString(RandRange(seed + 40, 5, 20));

        data.scannerWarning = "ORGANIZED CRIME - ARMED PROTECTION";
        data.dangerLevel = "MODERATE - PROTECTED ASSET";

        return data;
    }

    private static func GetTunnelRoute(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Watson to Badlands"; }
        if i == 1 { return "Heywood to docks"; }
        if i == 2 { return "Japantown to Pacifica"; }
        if i == 3 { return "Santo Domingo to border"; }
        if i == 4 { return "Northside to offshore"; }
        return "Classified - Multiple routes";
    }

    private static func GenerateArasakaEngramEcho(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ ENGRAM ECHO ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "ARASAKA SOUL PROJECT - LEAK";

        data.description = "ARASAKA ALERT: Subject exhibits behavioral patterns matching an engram stored on Mikoshi. ";
        data.description += "Match confidence: " + IntToString(RandRange(seed, 60, 95)) + "%. ";
        data.description += "No Relic chip detected. Transfer mechanism: UNKNOWN. ";
        data.description += "Theory: Engram data may have leaked into Night City's net infrastructure and implanted during routine cyberware updates.";

        data.hiddenInfo = "Matched engram: [CLASSIFIED - ARASAKA EXECUTIVE LEVEL]. ";
        data.hiddenInfo += "Behavioral overlay: " + (RandRange(seed + 10, 1, 100) <= 40 ? "GROWING" : "STABLE") + ". ";
        data.hiddenInfo += "Subject retains original personality but gains memories and skills of engram source.";

        data.scannerWarning = "ARASAKA HIGH PRIORITY - MIKOSHI DATA LEAK";
        data.dangerLevel = "LOW PERSONAL - EXTREME CORPORATE SENSITIVITY";

        return data;
    }

    private static func GenerateFeralZoneBorn(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ FERAL ZONE ORIGIN ★";
        data.flagColor = "GOLD";
        data.secretAffiliation = "NO PRIOR CIVILIZATION CONTACT";

        let zones: array<String>;
        ArrayPush(zones, "Pacifica Dead Zone");
        ArrayPush(zones, "Watson Quarantine Ruins");
        ArrayPush(zones, "Badlands No-Man's Land");
        ArrayPush(zones, "Old Coronado Toxic Zone");
        ArrayPush(zones, "Offshore Platform Wreckage");

        let zone = zones[RandRange(seed, 0, ArraySize(zones) - 1)];

        data.description = "SOCIAL SERVICES: Subject was born and raised in " + zone + " with ZERO contact with civilization. ";
        data.description += "First contact with society: " + IntToString(RandRange(seed + 10, 1, 5)) + " years ago. ";
        data.description += "No records exist. No education. No socialization prior to discovery. ";
        data.description += "Adaptation to city life: " + (RandRange(seed + 20, 1, 100) <= 40 ? "STRUGGLING" : "REMARKABLE - Learns fast") + ".";

        data.hiddenInfo = "Survival skills: EXTRAORDINARY. ";
        data.hiddenInfo += "Language acquisition: " + (RandRange(seed + 30, 1, 100) <= 50 ? "Basic conversational" : "Fluent - Unexpected") + ". ";
        data.hiddenInfo += "Biotechnica interest: HIGH - Immune system developed without medical intervention";

        data.scannerWarning = "NO DATABASE RECORDS - FERAL ORIGIN";
        data.dangerLevel = "LOW - BUT UNPREDICTABLE RESPONSES";

        return data;
    }

    private static func GenerateCorpoInternTrapped(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "€$ TRAPPED INTERN €$";
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, "MILITECH");
        ArrayPush(corps, "NIGHT CORP");
        ArrayPush(corps, "BIOTECHNICA");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + " UNPAID CONTRACT";

        data.description = "LABOR RECORD: Subject signed a " + corp + " internship contract at age " + IntToString(RandRange(seed + 5, 16, 19)) + ". ";
        data.description += "Contract duration: " + IntToString(RandRange(seed + 10, 10, 30)) + " years. Compensation: €$0 plus housing. ";
        data.description += "Non-compete clause prevents ALL other employment. ";
        data.description += "Termination penalty: €$" + IntToString(RandRange(seed + 20, 5000000, 50000000)) + ". Subject is legally trapped.";

        data.hiddenInfo = "Years remaining: " + IntToString(RandRange(seed + 30, 3, 20)) + ". ";
        data.hiddenInfo += "Currently assigned to: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Data entry dungeon" : "Corporate testing programs") + ". ";
        data.hiddenInfo += "Legal challenge: " + (RandRange(seed + 50, 1, 100) <= 20 ? "Filed - Immediately dismissed" : "Cannot afford representation");

        data.scannerWarning = "CORPORATE PROPERTY - RESTRICTED";
        data.dangerLevel = "NONE - VICTIM OF CONTRACT LAW";

        return data;
    }

    private static func GenerateMaxtacWashout(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▲ MAXTAC FORMER ▲";
        data.flagColor = "RED";
        data.secretAffiliation = "MAXTAC - DISCHARGED";

        data.description = "MAXTAC FILE: Subject is former MaxTac operative. Discharge reason: " + KdspRareNPCManager.GetMaxtacDischarge(seed) + ". ";
        data.description += "Service duration: " + IntToString(RandRange(seed + 10, 2, 12)) + " years. ";
        data.description += "Confirmed cyberpsycho takedowns: " + IntToString(RandRange(seed + 20, 5, 50)) + ". ";
        data.description += "Current threat assessment: EXTREME. Retains all training and most augmentation.";

        data.hiddenInfo = "Classified operations participated in: " + IntToString(RandRange(seed + 30, 10, 100)) + ". ";
        data.hiddenInfo += "Chrome load retained: " + IntToString(RandRange(seed + 40, 50, 85)) + "%. ";
        data.hiddenInfo += "Known to fixers: " + (RandRange(seed + 50, 1, 100) <= 50 ? "YES - Available for work" : "NO - Living quietly");

        data.scannerWarning = "EXTREME COMBAT CAPABILITY - DO NOT ENGAGE ALONE";
        data.dangerLevel = "EXTREME - FORMER MAXTAC";

        return data;
    }

    private static func GetMaxtacDischarge(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Insubordination"; }
        if i == 1 { return "Excessive force complaint"; }
        if i == 2 { return "Cyberpsychosis risk threshold"; }
        if i == 3 { return "Refused termination order"; }
        if i == 4 { return "Mental health discharge"; }
        return "Classified";
    }

    private static func GenerateProxyVoter(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ PROXY CITIZEN ◈";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "CORPORATE ELECTORAL FRAUD";

        let votes = IntToString(RandRange(seed, 5, 50));

        data.description = "ELECTORAL FRAUD: Subject votes in Night City elections using " + votes + " stolen or purchased identities. ";
        data.description += "Employer: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Corporate political action group" : "Gang-affiliated political machine") + ". ";
        data.description += "Payment per election cycle: €$" + IntToString(RandRange(seed + 20, 10000, 100000)) + ". ";
        data.description += "This is one node in an estimated network of " + IntToString(RandRange(seed + 30, 50, 500)) + " proxy voters.";

        data.hiddenInfo = "Active since: " + IntToString(RandRange(seed + 40, 2069, 2075)) + ". ";
        data.hiddenInfo += "Elections influenced: " + IntToString(RandRange(seed + 50, 2, 6)) + " municipal cycles. ";
        data.hiddenInfo += "Investigation: STALLED - Key witnesses keep disappearing";

        data.scannerWarning = "ELECTORAL CRIME NETWORK NODE";
        data.dangerLevel = "LOW - BUT CONNECTED TO POWERFUL INTERESTS";

        return data;
    }

    private static func GenerateGeneticChimera(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ GENETIC CHIMERA ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA INTEREST";

        data.description = "BIOTECH ANOMALY: Subject possesses two distinct genetic profiles within one body. ";
        data.description += "DNA samples from different body regions return DIFFERENT identities. ";
        data.description += "Origin: " + (RandRange(seed, 1, 100) <= 40 ? "Natural chimerism (absorbed twin)" : "Biotechnica gene-splicing experiment") + ". ";
        data.description += "Forensically, subject can appear to be two different people depending on sample site.";

        data.hiddenInfo = "Discovered during: " + (RandRange(seed + 10, 1, 100) <= 50 ? "Routine medical scan" : "NCPD forensic investigation") + ". ";
        data.hiddenInfo += "Second genetic profile matches: " + (RandRange(seed + 20, 1, 100) <= 30 ? "A known missing person" : "No database match") + ". ";
        data.hiddenInfo += "Potential for forensic confusion: EXTREME. Perfect alibi generator.";

        data.scannerWarning = "BIOMETRIC DATA UNRELIABLE - TWO GENETIC PROFILES";
        data.dangerLevel = "LOW - BUT FORENSICALLY INVISIBLE";

        return data;
    }

    private static func GenerateDarkNetLegend(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ DARK NET LEGEND ◈";
        data.flagColor = "GREEN";
        data.secretAffiliation = "DARK NET PERSONA";

        let handles: array<String>;
        ArrayPush(handles, "Null_Prophet");
        ArrayPush(handles, "Ghost_Circuit");
        ArrayPush(handles, "Dead_Pixel");
        ArrayPush(handles, "Chrome_Phantom");
        ArrayPush(handles, "Zero_Day");
        ArrayPush(handles, "Burn_Notice");

        let handle = handles[RandRange(seed, 0, ArraySize(handles) - 1)];

        data.description = "NET INTEL: Subject is the physical identity behind dark net persona '" + handle + "'. ";
        data.description += "Reputation score: LEGENDARY. Active for: " + IntToString(RandRange(seed + 10, 5, 15)) + " years. ";
        data.description += "Specialization: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Data brokering and market operation" : "Exploit development and tool distribution") + ". ";
        data.description += "Multiple corps and agencies have been hunting this identity for years.";

        data.hiddenInfo = "Transactions facilitated: " + IntToString(RandRange(seed + 30, 1000, 50000)) + ". ";
        data.hiddenInfo += "Estimated earnings: €$" + IntToString(RandRange(seed + 40, 10000000, 100000000)) + ". ";
        data.hiddenInfo += "NetWatch priority target: YES. True identity never compromised until now.";

        data.scannerWarning = "HIGH VALUE INTELLIGENCE TARGET";
        data.dangerLevel = "MODERATE - CONNECTED TO POWERFUL NETWORKS";

        return data;
    }

    private static func GenerateCargoStowaway(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▼ ILLEGAL ENTRY ▼";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "UNDOCUMENTED IMMIGRANT";

        let origins: array<String>;
        ArrayPush(origins, "European Economic Zone");
        ArrayPush(origins, "Pan-African Federation");
        ArrayPush(origins, "Southeast Asian Coalition");
        ArrayPush(origins, "South American Free States");
        ArrayPush(origins, "Middle Eastern Territories");

        let origin = origins[RandRange(seed, 0, ArraySize(origins) - 1)];

        data.description = "IMMIGRATION: Subject arrived in Night City as cargo stowaway from " + origin + ". ";
        data.description += "Arrival: " + IntToString(RandRange(seed + 10, 1, 10)) + " years ago. ";
        data.description += "Documentation: NONE. Subject exists outside all official systems. ";
        data.description += "Survival method: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Underground labor network" : "Community support system") + ".";

        data.hiddenInfo = "Travel debt owed to smugglers: €$" + IntToString(RandRange(seed + 30, 10000, 200000)) + ". ";
        data.hiddenInfo += "Skills from origin: " + (RandRange(seed + 40, 1, 100) <= 40 ? "Medical/Engineering training" : "Agricultural/Manual labor") + ". ";
        data.hiddenInfo += "Deportation risk: " + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH" : "LOW - No one tracks undocumented");

        data.scannerWarning = "NO RECORDS - INVISIBLE TO SYSTEM";
        data.dangerLevel = "NONE - VULNERABLE INDIVIDUAL";

        return data;
    }

    private static func GenerateChronoDisplaced(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "◈ CRYO REVIVAL ◈";
        data.flagColor = "CYAN";
        data.secretAffiliation = "CRYOGENIC SUBJECT";

        let frozenYear = IntToString(RandRange(seed, 2020, 2050));
        let revived = IntToString(RandRange(seed + 10, 2072, 2076));

        data.description = "MEDICAL RECORD: Subject was cryogenically preserved in " + frozenYear + " and revived in " + revived + ". ";
        data.description += "Preservation facility: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Private corporate vault" : "Experimental medical program") + ". ";
        data.description += "Adaptation to current era: " + (RandRange(seed + 30, 1, 100) <= 40 ? "POOR - Severe culture shock" : "ONGOING - Making progress") + ". ";
        data.description += "Subject has no living relatives, no assets, no applicable skills.";

        data.hiddenInfo = "Pre-freeze occupation: " + (RandRange(seed + 40, 1, 100) <= 50 ? "Corporate executive" : "Scientific researcher") + ". ";
        data.hiddenInfo += "Pre-freeze knowledge value: " + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH - Possesses lost techniques" : "LOW - Obsolete information") + ". ";
        data.hiddenInfo += "Psychological state: FRAGILE. Everyone they knew is dead.";

        data.scannerWarning = "TEMPORALLY DISPLACED - HANDLE WITH CARE";
        data.dangerLevel = "NONE - VULNERABLE INDIVIDUAL";

        return data;
    }

    private static func GenerateSoulSplit(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⧫ SOUL FRAGMENTATION ⧫";
        data.flagColor = "PURPLE";
        data.secretAffiliation = "SOULKILLER ANOMALY";

        data.description = "ARASAKA ANOMALY: Subject's consciousness appears to exist in multiple locations simultaneously. ";
        data.description += "Confirmed instances: " + IntToString(RandRange(seed, 2, 4)) + " (this body + engram copies). ";
        data.description += "All instances report being the 'original.' Neural synchronization: " + IntToString(RandRange(seed + 10, 10, 60)) + "%. ";
        data.description += "Each instance is diverging from the others. Philosophical and legal status: UNPRECEDENTED.";

        data.hiddenInfo = "Split occurred during: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Botched Soulkiller procedure" : "Experimental consciousness transfer") + ". ";
        data.hiddenInfo += "Other instances located: " + (RandRange(seed + 30, 1, 100) <= 40 ? "Mikoshi servers" : "Unknown - Possibly free") + ". ";
        data.hiddenInfo += "Legal identity: DISPUTED. Which copy owns the assets?";

        data.scannerWarning = "MULTIPLE CONSCIOUSNESS INSTANCES - IDENTITY CONFLICT";
        data.dangerLevel = "UNPREDICTABLE - EXISTENTIAL CRISIS ONGOING";

        return data;
    }

    private static func GenerateInfectedFirmware(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "⚠ INFECTED CHROME ⚠";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "COMPROMISED CYBERWARE";

        let implants = IntToString(RandRange(seed, 1, 5));

        data.description = "CYBERWARE ALERT: " + implants + " of subject's implants contain dormant malware. ";
        data.description += "Malware type: " + (RandRange(seed + 10, 1, 100) <= 40 ? "Surveillance (streaming data to unknown party)" : "Control (capable of overriding motor functions)") + ". ";
        data.description += "Infection source: " + (RandRange(seed + 20, 1, 100) <= 50 ? "Compromised ripperdoc" : "Factory firmware exploit") + ". ";
        data.description += "Subject awareness: NONE. Malware is undetectable by standard cyberware diagnostics.";

        data.hiddenInfo = "Estimated infected population in Night City: " + IntToString(RandRange(seed + 30, 1000, 50000)) + " (same exploit). ";
        data.hiddenInfo += "Malware controller: UNKNOWN. ";
        data.hiddenInfo += "Activation events observed: " + IntToString(RandRange(seed + 40, 0, 5)) + ". Effect: [CLASSIFIED]";

        data.scannerWarning = "COMPROMISED CYBERWARE - MAY ACT AGAINST WILL";
        data.dangerLevel = "MODERATE - INVOLUNTARY THREAT POSSIBLE";

        return data;
    }

    private static func GenerateWetworkRetired(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✖ RETIRED OPERATIVE ✖";
        data.flagColor = "RED";
        data.secretAffiliation = "FORMER WET TEAM";

        let kills = IntToString(RandRange(seed, 20, 200));

        data.description = "INTELLIGENCE: Subject is a retired corporate wetwork operative. ";
        data.description += "Confirmed assignments: " + kills + " over " + IntToString(RandRange(seed + 10, 5, 25)) + " years. ";
        data.description += "Former employer: " + (RandRange(seed + 20, 1, 100) <= 50 ? "ARASAKA BLACK OPS" : "MILITECH SPECIAL PROJECTS") + ". ";
        data.description += "Retirement status: " + (RandRange(seed + 30, 1, 100) <= 40 ? "SANCTIONED - Allowed to leave" : "UNSANCTIONED - Walked away") + ".";

        data.hiddenInfo = "Knowledge of classified operations: EXTENSIVE. ";
        data.hiddenInfo += "Dead man's switch: " + (RandRange(seed + 40, 1, 100) <= 60 ? "YES - Data dump on death" : "UNKNOWN") + ". ";
        data.hiddenInfo += "Current combat readiness: " + (RandRange(seed + 50, 1, 100) <= 70 ? "MAINTAINED" : "DEGRADED but still lethal");

        data.scannerWarning = "EXTREMELY DANGEROUS - PROFESSIONAL KILLER";
        data.dangerLevel = "EXTREME - DO NOT ENGAGE WITHOUT FULL TEAM";

        return data;
    }

    private static func GenerateChildSoldierGrown(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ CONFLICT SURVIVOR ★";
        data.flagColor = "GOLD";
        data.secretAffiliation = "CORPORATE WAR CONSCRIPT";

        let conflicts: array<String>;
        ArrayPush(conflicts, "South American Corp Wars");
        ArrayPush(conflicts, "Unification War - Border Campaigns");
        ArrayPush(conflicts, "African Resource Conflicts");
        ArrayPush(conflicts, "Central American Collapse");
        ArrayPush(conflicts, "Pacific Island Corporate Seizures");

        let conflict = conflicts[RandRange(seed, 0, ArraySize(conflicts) - 1)];
        let age = IntToString(RandRange(seed + 10, 8, 14));

        data.description = "HISTORICAL: Subject was conscripted as a child combatant at age " + age + " during " + conflict + ". ";
        data.description += "Duration of service: " + IntToString(RandRange(seed + 20, 2, 6)) + " years. ";
        data.description += "Conscripting force: " + (RandRange(seed + 30, 1, 100) <= 50 ? "Corporate PMC" : "Local militia") + ". ";
        data.description += "Subject has rebuilt a civilian life but carries deep operational conditioning.";

        data.hiddenInfo = "Combat skills retained: " + (RandRange(seed + 40, 1, 100) <= 70 ? "YES - Muscle memory intact" : "PARTIAL - Suppressed") + ". ";
        data.hiddenInfo += "Trigger conditioning: " + (RandRange(seed + 50, 1, 100) <= 40 ? "PRESENT - Specific stimuli may activate combat response" : "DEPROGRAMMED") + ". ";
        data.hiddenInfo += "War crimes witnessed: EXTENSIVE. Testimony value: HIGH.";

        data.scannerWarning = "CONDITIONED COMBATANT - MAY REACT TO TRIGGERS";
        data.dangerLevel = "MODERATE - TRAINED FROM CHILDHOOD";

        return data;
    }

    private static func GenerateIllegalProcreation(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "▲ UNLICENSED BIRTH ▲";
        data.flagColor = "ORANGE";
        data.secretAffiliation = "POPULATION CONTROL VIOLATION";

        data.description = "REGULATORY ALERT: Subject was born outside Night City's licensed procreation system. ";
        data.description += "Birth registered: NO. Genetic screening: NONE. ";
        data.description += "Subject exists outside the population database entirely. ";
        data.description += "Under current NC regulations, both subject and parents face potential penalties.";

        data.hiddenInfo = "Estimated unlicensed births in NC annually: " + IntToString(RandRange(seed, 500, 5000)) + ". ";
        data.hiddenInfo += "Subject's parents: " + (RandRange(seed + 10, 1, 100) <= 40 ? "IDENTIFIED - In hiding" : "UNKNOWN") + ". ";
        data.hiddenInfo += "Corpo interest: " + (RandRange(seed + 20, 1, 100) <= 30 ? "YES - Unscreened genetics valuable for study" : "NONE");

        data.scannerWarning = "NO BIRTH RECORDS - POPULATION VIOLATION";
        data.dangerLevel = "NONE - BUREAUCRATIC ANOMALY";

        return data;
    }

    private static func GenerateOrbitalReturnee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "✦ ORBITAL RETURNEE ✦";
        data.flagColor = "CYAN";
        data.secretAffiliation = "ORBITAL AIR / ESA RECORDS";

        let years = IntToString(RandRange(seed, 2, 20));
        let stations: array<String>;
        ArrayPush(stations, "Crystal Palace");
        ArrayPush(stations, "Orbital Air Station 7");
        ArrayPush(stations, "ESA Deep Space Platform");
        ArrayPush(stations, "O'Neill Colony 3");
        ArrayPush(stations, "Highrider Free Station");

        let station = stations[RandRange(seed + 10, 0, ArraySize(stations) - 1)];

        data.description = "ORBITAL RECORD: Subject lived off-world at " + station + " for " + years + " years. ";
        data.description += "Reason for return to Earth: " + (RandRange(seed + 20, 1, 100) <= 40 ? "Contract expiration" : "Unknown - Possibly fled") + ". ";
        data.description += "Gravity readaptation: " + (RandRange(seed + 30, 1, 100) <= 50 ? "ONGOING - Physical therapy" : "COMPLETE") + ". ";
        data.description += "Subject possesses knowledge of orbital operations rarely available groundside.";

        data.hiddenInfo = "Orbital security clearance: " + (RandRange(seed + 40, 1, 100) <= 50 ? "REVOKED" : "STILL ACTIVE - Unusual") + ". ";
        data.hiddenInfo += "Data carried from orbit: " + (RandRange(seed + 50, 1, 100) <= 40 ? "SUSPECTED - Corporate trade secrets" : "NONE DETECTED") + ". ";
        data.hiddenInfo += "Highrider connections: ACTIVE. Can facilitate orbital smuggling.";

        data.scannerWarning = "ORBITAL KNOWLEDGE - CORPORATE INTEREST";
        data.dangerLevel = "LOW - BUT VALUABLE INFORMATION SOURCE";

        return data;
    }

    private static func GenerateCorpoDebtSlave(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "€$ DEBT SERVITUDE €$";
        data.flagColor = "YELLOW";
        data.secretAffiliation = "GENERATIONAL DEBT";

        data.description = "FINANCIAL RECORD: Subject inherited generational corporate debt. Original debtor: " + (RandRange(seed, 1, 100) <= 50 ? "Parent" : "Grandparent") + ". ";
        data.description += "Original amount: €$" + IntToString(RandRange(seed + 10, 100000, 5000000)) + ". ";
        data.description += "Current amount with interest: €$" + IntToString(RandRange(seed + 20, 5000000, 100000000)) + ". ";
        data.description += "Under NC Inherited Debt Act, subject is legally responsible. Debt will pass to any children.";

        data.hiddenInfo = "Generations in debt: " + IntToString(RandRange(seed + 30, 2, 4)) + ". ";
        data.hiddenInfo += "Percentage of income garnished: " + IntToString(RandRange(seed + 40, 40, 80)) + "%. ";
        data.hiddenInfo += "Projected payoff date: NEVER. Interest exceeds earning capacity.";

        data.scannerWarning = "GENERATIONAL DEBT - DESPERATE";
        data.dangerLevel = "LOW - BUT MAY TAKE RISKS FOR MONEY";

        return data;
    }

    private static func GenerateGhostTownSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = "★ GHOST TOWN ORIGIN ★";
        data.flagColor = "GOLD";
        data.secretAffiliation = "ABANDONED SETTLEMENT";

        let towns: array<String>;
        ArrayPush(towns, "Carbon Plague town on Route 66");
        ArrayPush(towns, "Failed nomad settlement (Water Wars)");
        ArrayPush(towns, "Corporate company town (Petrochem abandoned)");
        ArrayPush(towns, "Militech testing grounds evacuation zone");
        ArrayPush(towns, "Flooded coastal settlement");

        let town = towns[RandRange(seed, 0, ArraySize(towns) - 1)];

        data.description = "ORIGIN: Subject is from " + town + ". Last known resident. ";
        data.description += "Settlement abandoned: " + IntToString(RandRange(seed + 10, 2050, 2070)) + ". ";
        data.description += "Subject remained alone for " + IntToString(RandRange(seed + 20, 2, 15)) + " years before relocating to Night City. ";
        data.description += "Possesses unique knowledge of abandoned infrastructure and hidden supply caches.";

        data.hiddenInfo = "Reason for staying: " + (RandRange(seed + 30, 1, 100) <= 40 ? "Guarding something" : "Nowhere else to go") + ". ";
        data.hiddenInfo += "Scavenged technology value: " + (RandRange(seed + 40, 1, 100) <= 30 ? "HIGH - Found pre-collapse tech" : "MODERATE") + ". ";
        data.hiddenInfo += "Fixer interest: SOME. Knowledge of Badlands caches is valuable.";

        data.scannerWarning = "SOLE SURVIVOR - ISOLATED PSYCHOLOGY";
        data.dangerLevel = "LOW - SELF-RELIANT BUT NOT AGGRESSIVE";

        return data;
    }
}

public class KdspRareNPCData {
    public let isRare: Bool;
    public let rareType: String;
    public let displayFlag: String;
    public let flagColor: String;
    public let description: String;
    public let hiddenInfo: String;
    public let secretAffiliation: String;
    public let scannerWarning: String;
    public let dangerLevel: String;
}
