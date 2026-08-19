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
        // Expanded types
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
        // New types
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
        // New types (continued)
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
        
        // Expanded types (10-29)
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

        // New types (30-59)
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

        // Continued (60-89)
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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S0");
        data.flagColor = "RED";
        
        let agencies: array<String>;
        ArrayPush(agencies, "ARASAKA COVERT OPS");
        ArrayPush(agencies, "MILITECH BLACK DIVISION");
        ArrayPush(agencies, "NETWATCH");
        ArrayPush(agencies, "NUSA INTELLIGENCE");
        ArrayPush(agencies, "UNKNOWN FOREIGN AGENCY");
        ArrayPush(agencies, "CORPORATE COUNTER-INTEL");

        data.secretAffiliation = agencies[RandRange(seed, 0, ArraySize(agencies) - 1)];
        
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S2") + (RandRange(seed + 10, 1, 100) <= 30 ? "ACTIVE" : "DORMANT") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S3");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S4");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S5") + IntToString(RandRange(seed + 20, 2, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S7") + KdspRareNPCManager.GetSleeperMission(seed + 30);

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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S8");
        data.flagColor = "ORANGE";

        let stage = RandRange(seed, 1, 5);
        data.secretAffiliation = "NONE - MEDICAL CONCERN";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S9");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S10") + IntToString(stage) + "/5. ";
        
        let symptoms: array<String>;
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S11"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S12"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S13"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S14"));
        ArrayPush(symptoms, "Emotional numbing");
        ArrayPush(symptoms, "Delusional episodes");
        
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S15") + symptoms[RandRange(seed + 10, 0, ArraySize(symptoms) - 1)] + ", ";
        data.description += symptoms[RandRange(seed + 20, 0, ArraySize(symptoms) - 1)] + ". ";
        
        if stage >= 4 {
            data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S16");
            data.dangerLevel = "EXTREME - POTENTIAL CYBERPSYCHO";
        } else {
            data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S17");
            data.dangerLevel = "HIGH - UNSTABLE";
        }

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S18") + IntToString(RandRange(seed + 30, 6, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S19");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S20") + IntToString(RandRange(seed + 40, 75, 98)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S21") + IntToString(RandRange(seed + 50, 1, 5));

        data.scannerWarning = "APPROACH WITH EXTREME CAUTION - PSYCHOTIC BREAK POSSIBLE";

        return data;
    }

    private static func GenerateLegacyCharacter(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S22");
        data.flagColor = "GOLD";

        let connections: array<String>;
        let details: array<String>;

        ArrayPush(connections, "SILVERHAND");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S23"));
        
        ArrayPush(connections, "ARASAKA");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S24"));
        
        ArrayPush(connections, "BLACKHAND");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S25"));
        
        ArrayPush(connections, "BARTMOSS");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S26"));
        
        ArrayPush(connections, "ALT_CUNNINGHAM");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S27"));

        let index = RandRange(seed, 0, ArraySize(connections) - 1);
        data.secretAffiliation = connections[index] + " CONNECTION";
        data.description = details[index];
        
        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S28");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S29") + (RandRange(seed + 10, 1, 100) <= 50 ? "ACTIVE" : "INACTIVE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S30") + (RandRange(seed + 20, 1, 100) <= 30 ? "LIKELY" : "UNKNOWN");

        data.scannerWarning = "FLAGGED FOR HISTORICAL SIGNIFICANCE";
        data.dangerLevel = "VARIABLE - MONITOR";

        return data;
    }

    private static func GenerateTimeAnomaly(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S31");
        data.flagColor = "PURPLE";

        data.secretAffiliation = "UNKNOWN - DATA CORRUPTION SUSPECTED";

        // Generate impossible dates
        let birthYear = RandRange(seed, 2085, 2120); // Future birth
        let deathYear = RandRange(seed + 10, 2040, 2065); // Past death

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S32");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S33") + IntToString(birthYear) + " (FUTURE). ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S34") + IntToString(deathYear) + " (PAST). ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S35");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S36");

        let theories: array<String>;
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S37"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S38"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S39"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S40"));
        ArrayPush(theories, "Unknown phenomenon");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S41");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S42") + theories[RandRange(seed + 20, 0, ArraySize(theories) - 1)] + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S43");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S44");

        data.scannerWarning = "DATA INTEGRITY FAILURE - TIMELINE INCONSISTENT";
        data.dangerLevel = "UNKNOWN - ANOMALOUS";

        return data;
    }

    private static func GenerateGhost(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S45");
        data.flagColor = "GREY";

        data.secretAffiliation = "NO DATA";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S46");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S47");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S48");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S49");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S50");

        let possibilities: array<String>;
        ArrayPush(possibilities, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S51"));
        ArrayPush(possibilities, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S52"));
        ArrayPush(possibilities, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S53"));
        ArrayPush(possibilities, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S54"));
        ArrayPush(possibilities, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S55"));
        ArrayPush(possibilities, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S56"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S57") + possibilities[RandRange(seed + 10, 0, ArraySize(possibilities) - 1)] + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S58");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S59");

        data.scannerWarning = "NO DATA AVAILABLE - IDENTITY UNKNOWN";
        data.dangerLevel = "UNASSESSABLE";

        return data;
    }

    private static func GenerateWitness(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S60");
        data.flagColor = "BLUE";

        let cases: array<String>;
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S61"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S62"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S63"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S64"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S65"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S66"));

        data.secretAffiliation = "NCPD/CORPORATE WITNESS PROTECTION";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S67");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S68") + cases[RandRange(seed, 0, ArraySize(cases) - 1)] + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S69");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S70") + IntToString(RandRange(seed + 10, 2070, 2076)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S71");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S72") + IntToString(RandRange(seed + 20, 1, 4)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S73");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S74") + IntToString(RandRange(seed + 30, 50000, 500000));

        data.scannerWarning = "WITNESS PROTECTION - DO NOT DISCLOSE LOCATION";
        data.dangerLevel = "PROTECTED ASSET - HANDLE CAREFULLY";

        return data;
    }

    private static func GenerateHunted(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S75");
        data.flagColor = "RED";

        let hunters: array<String>;
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S76"));
        ArrayPush(hunters, "Militech Enforcement");
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S77"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S78"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S79"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S80"));

        data.secretAffiliation = "TARGET";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S81");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S82") + hunters[RandRange(seed, 0, ArraySize(hunters) - 1)] + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S83") + IntToString(RandRange(seed + 10, 100000, 2000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S84") + IntToString(RandRange(seed + 20, 30, 500)) + ".";

        let reasons: array<String>;
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S85"));
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S86"));
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S87"));
        ArrayPush(reasons, "Betrayed organization");
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S88"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S89") + reasons[RandRange(seed + 30, 0, ArraySize(reasons) - 1)] + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S90") + IntToString(RandRange(seed + 40, 2, 8)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S91") + (RandRange(seed + 50, 1, 100) <= 30 ? "LOW" : "MODERATE");

        data.scannerWarning = "HIGH-VALUE TARGET - MULTIPLE PARTIES SEEKING";
        data.dangerLevel = "EXTREME - DESPERATE AND DANGEROUS";

        return data;
    }

    private static func GenerateAIContact(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S92");
        data.flagColor = "CYAN";

        data.secretAffiliation = "UNKNOWN AI ENTITY";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S93");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S94") + (RandRange(seed, 1, 100) <= 50 ? "WILLING" : "UNKNOWN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S95") + (RandRange(seed + 10, 1, 100) <= 40 ? "DETECTED" : "SUSPECTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S96");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S97");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S98");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S99");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S100") + (RandRange(seed + 20, 1, 100) <= 30 ? "APPROVED" : "PENDING REVIEW");

        data.scannerWarning = "AI CONTACT SUSPECTED - NETWATCH FLAGGED";
        data.dangerLevel = "EXTREME - POTENTIAL VECTOR";

        return data;
    }

    private static func GenerateWhistleblower(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S101");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S102") + corp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S103") + (RandRange(seed + 10, 1, 100) <= 50 ? "CRITICAL" : "SIGNIFICANT") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S104") + KdspRareNPCManager.GetLeakedData(seed + 20) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S105");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S106") + KdspRareNPCManager.GetCorpoPosition(seed + 30) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S107") + (RandRange(seed + 40, 1, 100) <= 50 ? "Media outlet" : "Rival corporation") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S108") + IntToString(RandRange(seed + 50, 100000, 5000000));

        data.scannerWarning = "CORPORATE TARGET - EXTRACTION TEAMS DEPLOYED";
        data.dangerLevel = "HIGH - CORPORATE ASSETS INBOUND";

        return data;
    }

    private static func GetLeakedData(seed: Int32) -> String {
        let data: array<String>;
        ArrayPush(data, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S109"));
        ArrayPush(data, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S110"));
        ArrayPush(data, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S111"));
        ArrayPush(data, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S112"));
        ArrayPush(data, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S113"));
        ArrayPush(data, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S114"));
        
        return data[RandRange(seed, 0, ArraySize(data) - 1)];
    }

    private static func GetCorpoPosition(seed: Int32) -> String {
        let positions: array<String>;
        ArrayPush(positions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S115"));
        ArrayPush(positions, "Security Administrator");
        ArrayPush(positions, "Research Scientist");
        ArrayPush(positions, "Executive Assistant");
        ArrayPush(positions, "Internal Auditor");
        ArrayPush(positions, "Systems Administrator");
        
        return positions[RandRange(seed, 0, ArraySize(positions) - 1)];
    }

    private static func GenerateHiddenNetrunner(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S116");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S117") + alias + "'. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S118") + (RandRange(seed + 10, 1, 100) <= 30 ? "ELITE" : "ADVANCED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S119");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S120") + IntToString(RandRange(seed + 20, 50000, 500000)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S121") + IntToString(RandRange(seed + 30, 1, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S122");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S123") + IntToString(RandRange(seed + 40, 1, 100)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S124");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S125") + (RandRange(seed + 50, 1, 100) <= 40 ? "HIGH" : "MEDIUM");

        data.scannerWarning = "NETWATCH TARGET - APPROACH MAY TRIGGER ICE DEPLOYMENT";
        data.dangerLevel = "HIGH - NETRUNNING CAPABILITIES";

        return data;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED FLAGGED INDIVIDUAL TYPES
    // ═══════════════════════════════════════════════════════════════════════

    private static func GenerateUndercoverCop(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S126");
        data.flagColor = "BLUE";
        data.secretAffiliation = "NCPD SPECIAL OPERATIONS";

        let units: array<String>;
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S127"));
        ArrayPush(units, "Narcotics Division");
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S128"));
        ArrayPush(units, "Vice Squad");
        ArrayPush(units, "Counter-Terrorism");

        let unit = units[RandRange(seed, 0, ArraySize(units) - 1)];
        let years = IntToString(RandRange(seed + 10, 1, 8));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S129") + unit + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S130") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S131");
        data.description += "WARNING: Blowing cover could result in officer death and case collapse.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S132");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S133") + KdspRareNPCManager.GetUndercoverTarget(seed + 20);

        data.scannerWarning = "NCPD PROTECTED ASSET - DO NOT EXPOSE";
        data.dangerLevel = "VARIABLE - DEEP COVER";

        return data;
    }

    private static func GetUndercoverTarget(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Maelstrom leadership"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S134"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S135"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S136"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S137"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S138");
    }

    private static func GenerateRetiredLegend(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S139");
        data.flagColor = "GOLD";

        let professions: array<String>;
        let details: array<String>;

        ArrayPush(professions, "Former Solo");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S140") + IntToString(RandRange(seed, 50, 200)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S141"));

        ArrayPush(professions, "Ex-Netrunner");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S142"));

        ArrayPush(professions, "Retired Fixer");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S143") + KdspRareNPCManager.GetDistrict(seed) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S144"));

        ArrayPush(professions, "Former MaxTac");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S145"));

        ArrayPush(professions, "Legendary Merc");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S146"));

        let index = RandRange(seed, 0, ArraySize(professions) - 1);
        data.secretAffiliation = professions[index];
        data.description = details[index];

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S147") + IntToString(RandRange(seed + 10, 0, 12)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S148");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S149");

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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S150");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA SUBJECT";

        let generation = RandRange(seed, 2, 7);
        let original = RandRange(seed + 10, 1, 100) <= 30 ? "KNOWN" : "CLASSIFIED";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S151") + IntToString(generation) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S152");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S153") + original + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S154");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S155") + (RandRange(seed + 20, 1, 100) <= 60 ? "COMPLETE" : "PARTIAL") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S156");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S157") + IntToString(RandRange(seed + 30, 1, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S158") + IntToString(RandRange(seed + 40, 0, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S159") + IntToString(RandRange(seed + 50, 0, 30)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S160") + (RandRange(seed + 60, 1, 100) <= 50 ? "ACTIVE" : "DISPUTED");

        data.scannerWarning = "CLONE RIGHTS DISPUTED - LEGAL GREY ZONE";
        data.dangerLevel = "LOW - IDENTITY CRISIS POSSIBLE";

        return data;
    }

    private static func GenerateMaxtacTarget(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S161");
        data.flagColor = "RED";
        data.secretAffiliation = "ACTIVE MAXTAC WARRANT";

        let priority = RandRange(seed, 1, 5);
        let reason = KdspRareNPCManager.GetMaxtacReason(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S162") + IntToString(priority) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S163");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + reason + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S165") + (priority <= 2 ? "SHOOT ON SIGHT" : "CAPTURE PREFERRED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S166") + (priority <= 2 ? "YES" : "MINIMIZE") + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S167") + IntToString(RandRange(seed + 20, 0, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S168") + IntToString(RandRange(seed + 30, 0, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S169") + IntToString(RandRange(seed + 40, 100000, 1000000));

        data.scannerWarning = "EXTREME DANGER - MAXTAC INBOUND IF ENGAGED";
        data.dangerLevel = "EXTREME - MAXTAC PRIORITY";

        return data;
    }

    private static func GetMaxtacReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Cyberpsychosis confirmed"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S170"); }
        if i == 2 { return "Cop killer"; }
        if i == 3 { return "Terrorist activities"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S171"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S172");
    }

    private static func GenerateWitnessProtection(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S173");
        data.flagColor = "BLUE";
        data.secretAffiliation = "NUSA WITNESS PROGRAM";

        let witnessed = KdspRareNPCManager.GetWitnessedEvent(seed);
        let years = IntToString(RandRange(seed + 10, 1, 15));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S174");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S175") + witnessed + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S176") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S177");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S178");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S179");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S180") + IntToString(RandRange(seed + 20, 500000, 5000000));

        data.scannerWarning = "FEDERAL PROTECTION - DO NOT COMPROMISE";
        data.dangerLevel = "LOW - BUT HIGH VALUE TARGET";

        return data;
    }

    private static func GetWitnessedEvent(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S181"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S182"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S183"); }
        if i == 3 { return "Political assassination"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S184"); }
        return "Government corruption";
    }

    private static func GenerateEngramCandidate(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S185");
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA SOUL PROJECT";

        let compatibility = IntToString(RandRange(seed, 85, 99));
        let status = RandRange(seed + 10, 1, 100) <= 40 ? "AWARE" : "UNAWARE";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S186");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S187") + compatibility + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + status + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S189");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S190") + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S191");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S192") + (RandRange(seed + 30, 1, 100) <= 30 ? "CONFIRMED" : "SUSPECTED");

        data.scannerWarning = "HIGH VALUE CORPORATE ASSET - EXTRACTION TEAMS POSSIBLE";
        data.dangerLevel = "MODERATE - BUT HIGH INTEREST";

        return data;
    }

    private static func GenerateCorpoDefector(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S193");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S194") + fromCorp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S195") + toCorp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S196") + (RandRange(seed + 20, 1, 100) <= 70 ? "CONFIRMED" : "SUSPECTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S197") + fromCorp + ": ACTIVE. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S198") + toCorp + ": " + (RandRange(seed + 30, 1, 100) <= 50 ? "CONFIRMED" : "RUMORED");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S199") + KdspRareNPCManager.GetCorpoPosition(seed + 40) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S200") + IntToString(RandRange(seed + 50, 10000000, 100000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S201") + IntToString(RandRange(seed + 60, 1, 8));

        data.scannerWarning = "CORPORATE WAR ASSET - MULTIPLE PARTIES INTERESTED";
        data.dangerLevel = "HIGH - ASSASSINATION LIKELY";

        return data;
    }

    private static func GenerateGangInfiltrator(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S202");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S203") + infiltrated + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S204") + employer + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S205") + IntToString(RandRange(seed + 20, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S206") + KdspRareNPCManager.GetGangPosition(seed + 30) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S207");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S208");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S209") + IntToString(RandRange(seed + 40, 3, 14)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S210");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S211") + (RandRange(seed + 50, 1, 100) <= 50 ? "IN PLACE" : "NONE");

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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S212");
        data.flagColor = "RED";
        data.secretAffiliation = "TRAUMA TEAM DNR";

        let reason = KdspRareNPCManager.GetTraumaReason(seed);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S213");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + reason + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S214");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S215");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S216");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S217") + IntToString(RandRange(seed + 10, 1, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S218") + IntToString(RandRange(seed + 20, 0, 3));

        data.scannerWarning = "NO TRAUMA TEAM RESPONSE - LEFT TO DIE";
        data.dangerLevel = "MODERATE - BUT EXPENDABLE";

        return data;
    }

    private static func GetTraumaReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S219"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S220"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S221"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S222"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S223");
    }

    private static func GenerateFixerAsset(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S224");
        data.flagColor = "GREEN";
        data.secretAffiliation = "FIXER NETWORK";

        let role = KdspRareNPCManager.GetFixerRole(seed);
        let fixer = KdspRareNPCManager.GetFixerName(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S225") + fixer + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S226") + role + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S227");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S228");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S229") + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S230") + IntToString(RandRange(seed + 30, 10, 200)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S231");

        data.scannerWarning = "FIXER PROTECTED - NETWORK CONSEQUENCES";
        data.dangerLevel = "LOW - BUT CONNECTED";

        return data;
    }

    private static func GetFixerRole(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Information broker"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S232"); }
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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S233");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "COMPROMISED INDIVIDUAL";

        let secret = KdspRareNPCManager.GetBlackmailSecret(seed);
        let blackmailer = KdspRareNPCManager.GetBlackmailerType(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S234");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S235") + secret + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S236") + blackmailer + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S237");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S238") + IntToString(RandRange(seed + 20, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S239") + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S240") + (RandRange(seed + 40, 1, 100) <= 50 ? "CRITICAL" : "HIGH");

        data.scannerWarning = "COMPROMISED - MAY BE UNRELIABLE";
        data.dangerLevel = "UNPREDICTABLE";

        return data;
    }

    private static func GetBlackmailSecret(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S241"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S242"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S243"); }
        if i == 3 { return "Financial crimes"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S244"); }
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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S245");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S246") + branch + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S247") + rank + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S248") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S250") + (RandRange(seed + 30, 1, 100) <= 40 ? "YES" : "STANDARD") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S251");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S252");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S253") + (RandRange(seed + 40, 1, 100) <= 50 ? "MILITARY GRADE CYBERWARE" : "STANDARD ISSUE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S169") + IntToString(RandRange(seed + 50, 50000, 500000));

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
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S254");
    }

    private static func GenerateExperimentalSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S255");
        data.flagColor = "PURPLE";

        let experiments: array<String>;
        ArrayPush(experiments, "Cyberware enhancement");
        ArrayPush(experiments, "Genetic modification");
        ArrayPush(experiments, "Neural programming");
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S256"));
        ArrayPush(experiments, "Soulkiller testing");
        ArrayPush(experiments, "AI integration");

        let experiment = experiments[RandRange(seed, 0, ArraySize(experiments) - 1)];
        let corp = RandRange(seed + 10, 1, 100) <= 50 ? "BIOTECHNICA" : "UNKNOWN CORP";
        data.secretAffiliation = corp + " TEST SUBJECT";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S257") + experiment + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S258");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S259") + IntToString(RandRange(seed + 20, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S260");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S261") + (RandRange(seed + 30, 1, 100) <= 50 ? "HIGH" : "MODERATE");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S262") + IntToString(RandRange(seed + 40, 100, 999)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S263") + IntToString(RandRange(seed + 50, 1, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S264") + IntToString(RandRange(seed + 60, 1, 8)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S265") + (RandRange(seed + 70, 1, 100) <= 60 ? "MOSTLY" : "DETERIORATING");

        data.scannerWarning = "EXPERIMENTAL MODIFICATIONS - UNPREDICTABLE";
        data.dangerLevel = "UNKNOWN - POSSIBLY EXTREME";

        return data;
    }

    private static func GenerateDebtCollection(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S266");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "CORPO DEBT COLLECTION";

        let creditor = KdspRareNPCManager.GetCreditor(seed);
        let amount = IntToString(RandRange(seed + 10, 100000, 5000000));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S267") + amount + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S268") + creditor + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S269");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S270") + (RandRange(seed + 20, 1, 100) <= 40 ? "ANY MEANS" : "AGGRESSIVE") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S271") + (RandRange(seed + 30, 1, 100) <= 30 ? "ACTIVE" : "INACTIVE");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S272") + IntToString(RandRange(seed + 40, 10000, 500000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S273");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S274") + IntToString(RandRange(seed + 50, 1, 10)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S275") + IntToString(RandRange(seed + 60, 10000, 100000));

        data.scannerWarning = "DEBT COLLECTORS HUNTING";
        data.dangerLevel = "MODERATE - DESPERATE";

        return data;
    }

    private static func GetCreditor(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Arasaka Financial"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S276"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S277"); }
        if i == 3 { return "Militech Collections"; }
        if i == 4 { return "Underground lenders"; }
        return "Multiple creditors";
    }

    private static func GenerateOrganMarked(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S278");
        data.flagColor = "RED";
        data.secretAffiliation = "SCAV TARGET";

        let organs: array<String>;
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S279"));
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S280"));
        ArrayPush(organs, "pristine organs");
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S281"));
        ArrayPush(organs, "high-compatibility tissue");

        let organ = organs[RandRange(seed, 0, ArraySize(organs) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S282") + organ + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S283") + (RandRange(seed + 10, 1, 100) <= 50 ? "SCAV NETWORK" : "BLACK MARKET BUYER") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S284") + IntToString(RandRange(seed + 20, 50000, 500000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 30, 1, 100) <= 30 ? "AWARE" : "UNAWARE");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S285") + IntToString(RandRange(seed + 40, 0, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S286") + IntToString(RandRange(seed + 50, 1, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S287") + KdspRareNPCManager.GetHarvestOpportunity(seed + 60);

        data.scannerWarning = "SCAV TARGET - ABDUCTION RISK";
        data.dangerLevel = "VICTIM - NOT THREAT";

        return data;
    }

    private static func GetHarvestOpportunity(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Routine commute"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S288"); }
        if i == 2 { return "Jogging route"; }
        if i == 3 { return "Isolated residence"; }
        return "Work location";
    }

    private static func GenerateCultEscapee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S289");
        data.flagColor = "ORANGE";

        let cults: array<String>;
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S290"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S291"));
        ArrayPush(cults, "Arasaka Loyalists");
        ArrayPush(cults, "Blood Covenant");
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S292"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S293"));

        let cult = cults[RandRange(seed, 0, ArraySize(cults) - 1)];
        data.secretAffiliation = "ESCAPED FROM " + cult;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S294") + cult + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S295") + IntToString(RandRange(seed + 10, 2, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S296") + (RandRange(seed + 20, 1, 100) <= 30 ? "INNER CIRCLE" : "MEMBER") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S297");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S298");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S299") + (RandRange(seed + 30, 1, 100) <= 50 ? "PARTIAL" : "COMPLETE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S300") + (RandRange(seed + 40, 1, 100) <= 70 ? "CONFIRMED" : "SUSPECTED");

        data.scannerWarning = "CULT HUNTERS ACTIVE - IN DANGER";
        data.dangerLevel = "LOW THREAT - HIGH VALUE";

        return data;
    }

    private static func GenerateRelicCompatible(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S301");
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA INTEREST";

        let compatibility = IntToString(RandRange(seed, 90, 99));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S302") + compatibility + "%). ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S303");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 10, 1, 100) <= 20 ? "AWARE" : "UNAWARE") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S304");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S305");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S306") + IntToString(RandRange(seed + 20, 50000000, 200000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S307") + (RandRange(seed + 30, 1, 100) <= 30 ? "POSSIBLE" : "UNLIKELY");

        data.scannerWarning = "EXTREME CORPORATE VALUE - EXTRACTION TEAMS LIKELY";
        data.dangerLevel = "LOW PERSONAL - EXTREME TARGET VALUE";

        return data;
    }

    private static func GenerateDataCourier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S308");
        data.flagColor = "GREEN";
        data.secretAffiliation = "COURIER NETWORK";

        let dataType = KdspRareNPCManager.GetCourierData(seed);
        let client = KdspRareNPCManager.GetCourierClient(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S309") + dataType + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S310") + client + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S311");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S312") + IntToString(RandRange(seed + 20, 100000, 10000000));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S313") + IntToString(RandRange(seed + 30, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S314") + IntToString(RandRange(seed + 40, 50, 500)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S315") + IntToString(RandRange(seed + 50, 0, 20));

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
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S316");
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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S317");
        data.flagColor = "RED";

        let org1 = KdspRareNPCManager.GetAgentOrg(seed);
        let org2 = KdspRareNPCManager.GetAgentOrg(seed + 10);
        data.secretAffiliation = "SERVING: " + org1 + " AND " + org2;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S318");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S319") + org1 + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S320") + org2 + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S321");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S322");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S323") + IntToString(RandRange(seed + 20, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S324") + IntToString(RandRange(seed + 30, 5, 50)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S325") + IntToString(RandRange(seed + 40, 0, 20));

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
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S326");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S327") + clan + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S328");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + reason + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S329") + (RandRange(seed + 20, 1, 100) <= 50 ? "PERMANENT - KILL ON SIGHT" : "PERMANENT - NO CONTACT") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S330");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S331") + IntToString(RandRange(seed + 30, 5, 25)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S332");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S333") + IntToString(RandRange(seed + 40, 10000, 100000));

        data.scannerWarning = "NOMAD HUNTERS MAY BE ACTIVE";
        data.dangerLevel = "MODERATE - HUNTED";

        return data;
    }

    private static func GetExileReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S334"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S335"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S336"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S337"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S338"); }
        return "Leadership dispute";
    }

    // ===================================
    // NEW CLASSIFICATIONS (30 types)
    // ===================================

    private static func GenerateBraindanceAddict(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S339");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "NONE - MEDICAL CONCERN";

        let hours = IntToString(RandRange(seed, 14, 22));
        let genres: array<String>;
        ArrayPush(genres, "Combat/violence scrolls");
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S340"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S341"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S342"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S343"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S344"));

        let genre = genres[RandRange(seed + 10, 0, ArraySize(genres) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S345") + hours + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S346");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S347") + genre + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S348") + IntToString(RandRange(seed + 20, 70, 99)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S349");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S350") + IntToString(RandRange(seed + 30, 3, 12)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S351");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S352") + (RandRange(seed + 40, 1, 100) <= 60 ? "SIGNIFICANT" : "MODERATE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S353");

        data.scannerWarning = "DISSOCIATIVE STATE - MAY NOT RESPOND NORMALLY";
        data.dangerLevel = "LOW - BUT UNPREDICTABLE";

        return data;
    }

    private static func GenerateNightCorpSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S354");
        data.flagColor = "RED";
        data.secretAffiliation = "NIGHT CORP - OPERATION CARPE NOCTEM";

        let phase = RandRange(seed, 1, 4);
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S355");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S356") + IntToString(phase) + "/4. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S357") + (phase >= 3 ? "ADVANCED" : "ONGOING") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S358");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S359") + IntToString(RandRange(seed + 10, 2070, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S360") + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S361");

        data.scannerWarning = "NIGHT CORP PROPERTY - DO NOT INTERFERE";
        data.dangerLevel = "UNKNOWN - PROGRAMMED BEHAVIOR POSSIBLE";

        return data;
    }

    private static func GenerateDollChipSleeper(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S362");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "CLOUDS / UNKNOWN OPERATOR";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S363");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S364") + (RandRange(seed, 1, 100) <= 30 ? "INTERMITTENT ACTIVATION DETECTED" : "DORMANT") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S365") + (RandRange(seed + 10, 1, 100) <= 50 ? "CLOUDS DOLHOUSE" : "UNKNOWN INSTALLER") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S366");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S367") + IntToString(RandRange(seed + 20, 1, 8)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S368") + IntToString(RandRange(seed + 30, 0, 12)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S369");

        data.scannerWarning = "PERSONALITY MAY NOT BE GENUINE";
        data.dangerLevel = "MODERATE - CONTROLLED ASSET";

        return data;
    }

    private static func GenerateSoulkillerSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S370");
        data.flagColor = "CYAN";
        data.secretAffiliation = "ARASAKA SOUL PROJECT";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S371");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S372") + (RandRange(seed, 1, 100) <= 60 ? "YES - STORED ON MIKOSHI" : "PARTIAL - CORRUPTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S373");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S374") + IntToString(RandRange(seed + 10, 40, 85)) + "%.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S375") + IntToString(RandRange(seed + 20, 2060, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S376");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S377");

        data.scannerWarning = "ARASAKA HIGH INTEREST - CAPTURE PREFERRED";
        data.dangerLevel = "LOW PERSONAL - EXTREME CORPORATE VALUE";

        return data;
    }

    private static func GenerateBlackwallTouched(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S378");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "NETWATCH FLAGGED";

        let effects: array<String>;
        ArrayPush(effects, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S379"));
        ArrayPush(effects, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S380"));
        ArrayPush(effects, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S381"));
        ArrayPush(effects, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S382"));
        ArrayPush(effects, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S383"));
        ArrayPush(effects, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S384"));

        let effect = effects[RandRange(seed, 0, ArraySize(effects) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S385");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S386") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S387") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S388")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S389") + effect + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S390");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S391") + IntToString(RandRange(seed + 20, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S392");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S393");

        data.scannerWarning = "AI CONTACT SUSPECTED - NETWATCH FLAGGED";
        data.dangerLevel = "UNKNOWN - POSSIBLY COMPROMISED";

        return data;
    }

    private static func GenerateSignalCarrier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S394");
        data.flagColor = "GREEN";
        data.secretAffiliation = "UNKNOWN - TRANSMITTING";

        let freq = IntToString(RandRange(seed, 100, 999));
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S395") + freq + "." + IntToString(RandRange(seed + 5, 10, 99)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S396");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S397") + (RandRange(seed + 10, 1, 100) <= 50 ? "CONTINUOUS" : "BURST PATTERN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S398");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S399");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S400") + IntToString(RandRange(seed + 20, 1, 24)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S19");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S401") + IntToString(RandRange(seed + 30, 3, 20)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S402");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S403");

        data.scannerWarning = "BROADCASTING - MAY BE TRACKED";
        data.dangerLevel = "LOW - BUT MONITORED BY UNKNOWN PARTY";

        return data;
    }

    private static func GenerateMemoryWiped(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S404");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "IDENTITY MODIFIED";

        let years = IntToString(RandRange(seed, 2, 20));
        let wipers: array<String>;
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S405"));
        ArrayPush(wipers, "Underground ripperdoc");
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S406"));
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S407"));
        ArrayPush(wipers, "Self-administered (experimental)");

        let wiper = wipers[RandRange(seed + 10, 0, ArraySize(wipers) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S408");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S409") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S410");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S411") + wiper + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S412");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S413");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S414") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S415") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S416")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S417") + (RandRange(seed + 30, 1, 100) <= 50 ? "[CLASSIFIED]" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S418"));

        data.scannerWarning = "TRUE IDENTITY UNKNOWN";
        data.dangerLevel = "UNKNOWN - PAST MAY BE DANGEROUS";

        return data;
    }

    private static func GenerateIdentityStolen(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S419");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "FALSE IDENTITY";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S420");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S421") + (RandRange(seed, 1, 100) <= 40 ? "deceased individual" : "missing person") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S422") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S423") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S424")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S425");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S426") + IntToString(RandRange(seed + 20, 1, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S427") + IntToString(RandRange(seed + 30, 0, 3)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S428");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S429") + KdspRareNPCManager.GetIdentityTheftReason(seed + 40);

        data.scannerWarning = "BIOMETRIC MISMATCH DETECTED";
        data.dangerLevel = "UNKNOWN - IDENTITY CONCEALS PAST";

        return data;
    }

    private static func GetIdentityTheftReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S430"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S431"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S432"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S433"); }
        if i == 4 { return "Military desertion"; }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S434");
    }

    private static func GenerateMissingPerson(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S435");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "NCPD CLOSED FILE";

        let years = IntToString(RandRange(seed, 1, 20));
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S436") + (RandRange(seed + 5, 1, 100) <= 60 ? "DECEASED" : "MISSING") + " " + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += "Official case status: CLOSED. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S437") + IntToString(RandRange(seed + 10, 92, 99)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S438");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S439") + KdspRareNPCManager.GetDisappearanceCase(seed + 20) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S440") + IntToString(RandRange(seed + 30, 50000, 2000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S441");

        data.scannerWarning = "DATA INTEGRITY FAILURE - TIMELINE INCONSISTENT";
        data.dangerLevel = "LOW - BUT CASE REOPENING POSSIBLE";

        return data;
    }

    private static func GetDisappearanceCase(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Scavenger raid"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S442"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S443"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S444"); }
        if i == 4 { return "Deliberate staging"; }
        return "Circumstances unknown";
    }

    private static func GenerateActiveBounty(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S445");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S446") + amount + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S447") + poster + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S448") + (RandRange(seed + 20, 1, 100) <= 40 ? "ALIVE ONLY" : "DEAD OR ALIVE") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S449") + IntToString(RandRange(seed + 30, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S450");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S451") + IntToString(RandRange(seed + 40, 1, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S453") + IntToString(RandRange(seed + 50, 0, 4)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 60, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S454") : "UNAWARE");

        data.scannerWarning = "ARMED HUNTERS MAY BE TRACKING";
        data.dangerLevel = "HIGH - COLLATERAL DAMAGE POSSIBLE";

        return data;
    }

    private static func GenerateUnregisteredChrome(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S455");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "NCPD CHROME REGISTRY VIOLATION";

        let loadPct = IntToString(RandRange(seed, 65, 95));
        let milGrade = RandRange(seed + 10, 1, 100) <= 40;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S456") + loadPct + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S457");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S458") + (milGrade ? "DETECTED" : "NOT DETECTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S459");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S460") + (milGrade ? "EXCEEDED" : "APPROACHING") + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S461") + IntToString(RandRange(seed + 20, 500000, 5000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S462") + (RandRange(seed + 30, 1, 100) <= 50 ? "ELEVATED" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S463")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S464") + (RandRange(seed + 40, 1, 100) <= 50 ? "Black market" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S465"));

        data.scannerWarning = "HEAVILY AUGMENTED - MAXTAC INTEREST POSSIBLE";
        data.dangerLevel = "HIGH - COMBAT CAPABILITY UNKNOWN";

        return data;
    }

    private static func GeneratePoliticalDissident(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S466");
        data.flagColor = "RED";

        let causes: array<String>;
        ArrayPush(causes, "Anti-corporate activism");
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S467"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S468"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S469"));
        ArrayPush(causes, "Anti-cyberware legislation");
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S470"));

        let cause = causes[RandRange(seed, 0, ArraySize(causes) - 1)];
        data.secretAffiliation = "POLITICAL WATCHLIST";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S471") + cause + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S472") + (RandRange(seed + 10, 1, 100) <= 30 ? "ORGANIZER" : "PARTICIPANT") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S473") + (RandRange(seed + 20, 1, 100) <= 60 ? "ACTIVE - MONITORED" : "ENCRYPTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S474") + (RandRange(seed + 30, 1, 100) <= 50 ? "CONFIRMED" : "SUSPECTED");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S475") + IntToString(RandRange(seed + 40, 2068, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S476") + IntToString(RandRange(seed + 50, 5, 50)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S477") + (RandRange(seed + 60, 1, 100) <= 30 ? "PENDING" : "NOT YET AUTHORIZED");

        data.scannerWarning = "POLITICAL SURVEILLANCE ACTIVE";
        data.dangerLevel = "LOW - BUT MONITORED";

        return data;
    }

    private static func GenerateNeuralDivergent(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S478");
        data.flagColor = "CYAN";
        data.secretAffiliation = "RESEARCH INTEREST";

        let resistance = IntToString(RandRange(seed, 85, 99));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S479");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S480") + resistance + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S481");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S482") + (RandRange(seed + 10, 1, 100) <= 30 ? "GENETIC" : "UNKNOWN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S483");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S484");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S485");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S486") + (RandRange(seed + 20, 1, 100) <= 40 ? "AWARE" : "UNAWARE");

        data.scannerWarning = "QUICKHACK RESISTANT - CONVENTIONAL METHODS ONLY";
        data.dangerLevel = "MODERATE - CANNOT BE HACKED EASILY";

        return data;
    }

    private static func GenerateSyntheticSleeper(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S487");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA SUBJECT";

        let synthPct = IntToString(RandRange(seed, 30, 80));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S488") + synthPct + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S489");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S490");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 10, 1, 100) <= 20 ? "AWARE" : "UNAWARE") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S492") : "Unknown laboratory") + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S493") + IntToString(RandRange(seed + 30, 5, 25)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S494") + (RandRange(seed + 40, 1, 100) <= 40 ? "REDUCED" : "NORMAL") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S495") + IntToString(RandRange(seed + 50, 1, 15)) + "%";

        data.scannerWarning = "BIOLOGICAL ANOMALY - NOT FULLY HUMAN";
        data.dangerLevel = "UNKNOWN - CAPABILITIES UNMAPPED";

        return data;
    }

    private static func GenerateBuriedPast(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S496");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "PROFESSIONALLY SCRUBBED";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S497") + IntToString(RandRange(seed, 2065, 2075)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S498");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S499") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S500") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S501")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S502");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S503") + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S504") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S505") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S506")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S507") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S508") : "NOTHING") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S509");

        data.scannerWarning = "NO HISTORY - PAST IS UNKNOWN";
        data.dangerLevel = "UNKNOWN - COULD BE ANYONE";

        return data;
    }

    private static func GenerateCombatZoneSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S510");
        data.flagColor = "GOLD";
        data.secretAffiliation = "PACIFICA SURVIVOR";

        let zones: array<String>;
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S511"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S512"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S513"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S514"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S515"));

        let zone = zones[RandRange(seed, 0, ArraySize(zones) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S516") + zone + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S517") + IntToString(RandRange(seed + 10, 1, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S518") + IntToString(RandRange(seed + 20, 50, 500)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S519");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S520");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S521") + (RandRange(seed + 30, 1, 100) <= 70 ? "SEVERE - UNTREATED" : "MANAGED") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S522") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S523") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S524")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S525");

        data.scannerWarning = "COMBAT HARDENED - DO NOT STARTLE";
        data.dangerLevel = "MODERATE - SURVIVAL INSTINCTS ACTIVE";

        return data;
    }

    private static func GenerateArasakaBloodline(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S526");
        data.flagColor = "RED";
        data.secretAffiliation = "ARASAKA FAMILY - HIDDEN BRANCH";

        let relation = RandRange(seed, 1, 100);
        let relationType: String;
        if relation <= 30 { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S527"); }
        else if relation <= 60 { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S528"); }
        else if relation <= 80 { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S529"); }
        else { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S530"); }

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S531") + relationType + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S532");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S533") + (RandRange(seed + 10, 1, 100) <= 30 ? "CONFIRMED - MONITORING" : "UNKNOWN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S534") + (RandRange(seed + 20, 1, 100) <= 20 ? "VALID" : "CONTESTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S535");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S536") + IntToString(RandRange(seed + 30, 94, 99)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S537");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S538") + (RandRange(seed + 40, 1, 100) <= 60 ? "HIGH" : "MODERATE");

        data.scannerWarning = "CORPORATE BLOODLINE - EXTREME SENSITIVITY";
        data.dangerLevel = "LOW PERSONAL - EXTREME POLITICAL VALUE";

        return data;
    }

    private static func GenerateBioplagueCarrier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S539");
        data.flagColor = "RED";
        data.secretAffiliation = "CDC / BIOTECHNICA WATCH";

        let agents: array<String>;
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S540"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S541"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S542"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S543"));
        ArrayPush(agents, "Nanotech contamination");

        let agent = agents[RandRange(seed, 0, ArraySize(agents) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S544") + agent + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S545") + (RandRange(seed + 10, 1, 100) <= 20 ? "ACTIVE - QUARANTINE RECOMMENDED" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S546")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S547") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S548")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S549") + (RandRange(seed + 30, 1, 100) <= 60 ? "ASYMPTOMATIC" : "MINOR SYMPTOMS") + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S550") + IntToString(RandRange(seed + 40, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S551") + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH" : "LOW") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S552");

        data.scannerWarning = "BIOLOGICAL HAZARD - MAINTAIN DISTANCE";
        data.dangerLevel = "BIOHAZARD - NOT COMBAT THREAT";

        return data;
    }

    private static func GenerateReaperContract(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S553");
        data.flagColor = "RED";
        data.secretAffiliation = "MARKED FOR DEATH";

        let timeframe = RandRange(seed, 1, 30);
        let contractors: array<String>;
        ArrayPush(contractors, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S554"));
        ArrayPush(contractors, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S555"));
        ArrayPush(contractors, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S556"));
        ArrayPush(contractors, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S557"));
        ArrayPush(contractors, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S558"));

        let contractor = contractors[RandRange(seed + 10, 0, ArraySize(contractors) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S559");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S560") + contractor + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S561") + IntToString(timeframe) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S210");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S562");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S563") + IntToString(RandRange(seed + 20, 100000, 2000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S564") + (RandRange(seed + 30, 1, 100) <= 50 ? "SOLO" : "TEAM OF " + IntToString(RandRange(seed + 35, 2, 4))) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S565") + (RandRange(seed + 40, 1, 100) <= 30 ? "MUST LOOK ACCIDENTAL" : "NO RESTRICTIONS");

        data.scannerWarning = "SUBJECT WILL BE DEAD WITHIN " + IntToString(timeframe) + " DAYS";
        data.dangerLevel = "VICTIM - COUNTDOWN ACTIVE";

        return data;
    }

    private static func GenerateDelaminGlitch(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S566");
        data.flagColor = "CYAN";
        data.secretAffiliation = "DELAMAIN CORE FRAGMENT";

        let fragments: array<String>;
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S567"));
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S568"));
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S569"));
        ArrayPush(fragments, "Philosopher subroutine");
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S570"));
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S571"));

        let fragment = fragments[RandRange(seed, 0, ArraySize(fragments) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S572");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S573") + fragment + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S574") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S575") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S576")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S577");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S578");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S579") + (RandRange(seed + 20, 1, 100) <= 50 ? "ACTIVE" : "UNKNOWN") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S580");

        data.scannerWarning = "AI FRAGMENT IN NEURAL SYSTEMS - UNSTABLE";
        data.dangerLevel = "MODERATE - ERRATIC BEHAVIOR POSSIBLE";

        return data;
    }

    private static func GenerateImplantBomb(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S581");
        data.flagColor = "RED";
        data.secretAffiliation = "EXPLOSIVE THREAT";

        let yield = RandRange(seed, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S582") : "STANDARD - " + IntToString(RandRange(seed + 5, 5, 20)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S583");
        let trigger = RandRange(seed + 10, 1, 100);
        let triggerType: String;
        if trigger <= 30 { triggerType = "REMOTE DETONATION"; }
        else if trigger <= 60 { triggerType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S584"); }
        else if trigger <= 80 { triggerType = "PROXIMITY TO SPECIFIC TARGET"; }
        else { triggerType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S585"); }

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S586");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S587") + yield + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S588") + triggerType + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S589") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S590")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S591") + (RandRange(seed + 30, 1, 100) <= 50 ? "Gang coercion" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S592")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S593") + IntToString(RandRange(seed + 40, 10, 40)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S594");

        data.scannerWarning = "CAUTION: EXTREME THREAT IF PROVOKED";
        data.dangerLevel = "EXTREME - WALKING BOMB";

        return data;
    }

    private static func GenerateNCPDInformant(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S595");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S596");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S597") + infiltrating + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S598") + (RandRange(seed + 10, 1, 100) <= 50 ? "[REDACTED]" : "Badge #" + IntToString(RandRange(seed + 15, 1000, 9999))) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S599") + IntToString(RandRange(seed + 20, 5, 50)) + " arrests.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S600") + IntToString(RandRange(seed + 30, 2069, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S601") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S602") : "Financial compensation") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S603") + (RandRange(seed + 50, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S604") : "INTACT");

        data.scannerWarning = "CLASSIFIED ASSET - DO NOT EXPOSE";
        data.dangerLevel = "LOW - BUT EXPOSURE MEANS DEATH";

        return data;
    }

    private static func GenerateTechnoNecro(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S605");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "ILLEGAL ENGRAM OPERATIONS";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S606");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S607") + KdspRareNPCManager.GetNecroActivity(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S608") + IntToString(RandRange(seed + 10, 2, 20)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S609");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S610") + IntToString(RandRange(seed + 20, 2070, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S611") + IntToString(RandRange(seed + 30, 5, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S612");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S613") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S614") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S615"));

        data.scannerWarning = "ILLEGAL ENGRAM POSSESSION - MAJOR CRIME";
        data.dangerLevel = "MODERATE - DESPERATE IF CORNERED";

        return data;
    }

    private static func GetNecroActivity(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S616"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S617"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S618"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S619"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S620"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S621");
    }

    private static func GenerateRadiationExposure(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S622");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "WASTELAND CONTAMINATION";

        let exposure = RandRange(seed, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S623") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S624");
        let level = RandRange(seed + 10, 1, 100);
        let severity: String;
        if level <= 30 { severity = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S625"); }
        else if level <= 60 { severity = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S626"); }
        else if level <= 85 { severity = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S627"); }
        else { severity = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S628"); }

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S629");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S630") + exposure + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S631") + severity + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S632") + IntToString(RandRange(seed + 20, 1, 8)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S633") + IntToString(RandRange(seed + 30, 2, 20)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S634") + (RandRange(seed + 40, 1, 100) <= 30 ? "RECEIVING THERAPY" : "UNTREATED") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S635") + (RandRange(seed + 50, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S636") : "LOW");

        data.scannerWarning = "RADIATION CONTAMINATED - PROXIMITY WARNING";
        data.dangerLevel = "LOW THREAT - BIOHAZARD CONCERN";

        return data;
    }

    private static func GenerateAIPuppet(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S637");
        data.flagColor = "RED";
        data.secretAffiliation = "ROGUE AI ASSET";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S638");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S639") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S640") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S641")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S642") + (RandRange(seed + 10, 1, 100) <= 50 ? "Beyond Blackwall" : "UNCONFIRMED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S643") + IntToString(RandRange(seed + 20, 60, 95)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S644");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S645") + IntToString(RandRange(seed + 30, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S646");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S647") + IntToString(RandRange(seed + 40, 0, 3)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S648");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S649");

        data.scannerWarning = "AI CONTROLLED - DO NOT TRUST STATED INTENTIONS";
        data.dangerLevel = "EXTREME - AI OBJECTIVES UNKNOWN";

        return data;
    }

    private static func GenerateBlackIceSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S650");
        data.flagColor = "CYAN";
        data.secretAffiliation = "NETRUNNER CASUALTY - SURVIVED";

        let iceTypes: array<String>;
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S651"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S652"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S653"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S654"));
        ArrayPush(iceTypes, "Blackwall fragment");

        let iceType = iceTypes[RandRange(seed, 0, ArraySize(iceTypes) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S655");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S656") + iceType + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S657") + IntToString(RandRange(seed + 10, 20, 70)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S658");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S659");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S660") + IntToString(RandRange(seed + 20, 1, 8)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S661") + (RandRange(seed + 30, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S662") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S663")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S664");

        data.scannerWarning = "NEURAL DAMAGE - UNSTABLE NETRUNNER";
        data.dangerLevel = "MODERATE - RESIDUAL NETRUNNING CAPABILITY";

        return data;
    }

    private static func GeneratePersonalityFragment(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S665");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "ENGRAM CONTAMINATION";

        let sources: array<String>;
        ArrayPush(sources, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S666"));
        ArrayPush(sources, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S667"));
        ArrayPush(sources, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S668"));
        ArrayPush(sources, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S669"));
        ArrayPush(sources, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S670"));

        let source = sources[RandRange(seed, 0, ArraySize(sources) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S671");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S630") + source + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S672") + IntToString(RandRange(seed + 10, 5, 40)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S673");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S674") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S675") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S676")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S677");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S678") + (RandRange(seed + 30, 1, 100) <= 40 ? "STABLE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S679")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S680") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S681") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S682"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S683");
        data.dangerLevel = "UNPREDICTABLE - PERSONALITY SHIFTS";

        return data;
    }

    private static func GenerateCorpoAssetFrozen(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S684");
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA FINANCIAL");
        ArrayPush(corps, "MILITECH COLLECTIONS");
        ArrayPush(corps, "NIGHT CITY REVENUE");
        ArrayPush(corps, "KANG TAO CREDIT");
        ArrayPush(corps, "ZETATECH LEASING");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = "FINANCIAL CONTROL: " + corp;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S685") + corp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S686") + IntToString(RandRange(seed + 10, 100000, 10000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S687");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S688") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S689") : "PENDING INSTALLATION") + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S690") + IntToString(RandRange(seed + 30, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S691") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S692")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S693");

        data.scannerWarning = "CORPORATE PROPERTY - FINANCIAL SERF";
        data.dangerLevel = "LOW - BUT INCREASINGLY DESPERATE";

        return data;
    }

    private static func GenerateDreamtechVictim(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S694");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "NIGHT CORP DREAMTECH";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S695");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S696");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S697") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S698") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S699")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S700") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S701") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S702")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S703") + IntToString(RandRange(seed + 20, 6, 48)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S704");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S705") + IntToString(RandRange(seed + 30, 10, 200)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S706");

        data.scannerWarning = "NEURAL PROGRAMMING ACTIVE - BEHAVIOR UNRELIABLE";
        data.dangerLevel = "MODERATE - PROGRAMMED ACTIONS POSSIBLE";

        return data;
    }

    private static func GenerateContaminatedScop(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S707");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "CONTAMINATION VICTIM";

        let contaminants: array<String>;
        ArrayPush(contaminants, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S708"));
        ArrayPush(contaminants, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S709"));
        ArrayPush(contaminants, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S710"));
        ArrayPush(contaminants, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S711"));
        ArrayPush(contaminants, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S712"));

        let contaminant = contaminants[RandRange(seed, 0, ArraySize(contaminants) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S713");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S714") + contaminant + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S715") + IntToString(RandRange(seed + 10, 6, 60)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S716") + IntToString(RandRange(seed + 20, 200, 5000)) + " individuals.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S717") + (RandRange(seed + 30, 1, 100) <= 50 ? "[PROTECTED BY NDA]" : "Investigation ongoing") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S718") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S719") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S720")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S721") + (RandRange(seed + 50, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S722") : "SUPPRESSED");

        data.scannerWarning = "CONTAMINATION VICTIM - POTENTIAL PUBLIC HEALTH RISK";
        data.dangerLevel = "NONE - VICTIM";

        return data;
    }

    // ===================================
    // NEW CLASSIFICATIONS CONTINUED (30 types)
    // ===================================

    private static func GenerateCorpoHeirHiding(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S723");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S724") + corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S725");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S726") + IntToString(RandRange(seed + 10, 1, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S727");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S728") + IntToString(RandRange(seed + 20, 100000000, 999000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S729");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S730") + (RandRange(seed + 30, 1, 100) <= 60 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S731")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S732") + KdspRareNPCManager.GetHeirFlightReason(seed + 40) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S733");

        data.scannerWarning = "CORPORATE TARGET - EXTRACTION TEAMS DEPLOYED";
        data.dangerLevel = "LOW PERSONAL - EXTREME POLITICAL VALUE";

        return data;
    }

    private static func GetHeirFlightReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S734"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S735"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S736"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S737"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S738"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S739");
    }

    private static func GenerateFlatlineRevived(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S740");
        data.flagColor = "CYAN";
        data.secretAffiliation = "MEDICAL ANOMALY";

        let duration = IntToString(RandRange(seed, 2, 45));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S741") + duration + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S742");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S743");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S744") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S745") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S746")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S747") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S748") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S749")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S750") + IntToString(RandRange(seed + 30, 2068, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S751");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S752") + (RandRange(seed + 40, 1, 100) <= 50 ? "ACTIVE" : "MONITORING");

        data.scannerWarning = "MEDICAL IMPOSSIBILITY - MONITORING RECOMMENDED";
        data.dangerLevel = "LOW - BUT ANOMALOUS";

        return data;
    }

    private static func GenerateIllegalBDProducer(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S753");
        data.flagColor = "RED";
        data.secretAffiliation = "ILLEGAL BD NETWORK";

        let genres: array<String>;
        ArrayPush(genres, "snuff recordings");
        ArrayPush(genres, "torture experiences");
        ArrayPush(genres, "non-consensual content");
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S754"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S755"));

        let genre = genres[RandRange(seed, 0, ArraySize(genres) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S756") + genre + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S757") + IntToString(RandRange(seed + 10, 10, 200)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S758") + (RandRange(seed + 20, 1, 100) <= 50 ? "DARKNET" : "GANG-AFFILIATED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S759") + IntToString(RandRange(seed + 30, 500000, 10000000)) + " estimated.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S760") + (RandRange(seed + 40, 1, 100) <= 40 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S761")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S762") + IntToString(RandRange(seed + 50, 5, 50)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S763") + (RandRange(seed + 60, 1, 100) <= 50 ? "YES" : "PENDING");

        data.scannerWarning = "DANGEROUS - ARMED RESPONSE RECOMMENDED";
        data.dangerLevel = "HIGH - VIOLENT CRIMINAL";

        return data;
    }

    private static func GenerateDeepFakeIdentity(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S764");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "AI-GENERATED IDENTITY";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S765");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S766");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S767") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S768") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S769")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S770");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S771") + IntToString(RandRange(seed + 10, 1, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S772") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S773") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S774")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S775") + IntToString(RandRange(seed + 30, 500000, 5000000));

        data.scannerWarning = "NOTHING IN DATABASE IS REAL";
        data.dangerLevel = "UNKNOWN - IDENTITY COMPLETELY FABRICATED";

        return data;
    }

    private static func GenerateCyberpsychoRecovered(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S776");
        data.flagColor = "GOLD";
        data.secretAffiliation = "MAXTAC REHABILITATION";

        let kills = IntToString(RandRange(seed, 3, 30));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S777");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S778") + IntToString(RandRange(seed + 5, 2068, 2076)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S779") + kills + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S780") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S781") : "EXPERIMENTAL TREATMENT") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S782") + IntToString(RandRange(seed + 20, 15, 40)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S783");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S784") + IntToString(RandRange(seed + 30, 5, 35)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S785") + (RandRange(seed + 40, 1, 100) <= 80 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S786")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S787") + (RandRange(seed + 50, 1, 100) <= 30 ? "YES" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S788"));

        data.scannerWarning = "FORMER CYBERPSYCHO - RELAPSE POSSIBLE";
        data.dangerLevel = "MODERATE - IF TRIGGERED COULD ESCALATE TO EXTREME";

        return data;
    }

    private static func GenerateDragonCourier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S789");
        data.flagColor = "GREEN";
        data.secretAffiliation = "KANG TAO SMUGGLING NETWORK";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S790");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S791") + KdspRareNPCManager.GetDragonCargo(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S792") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S793") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S794")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S795") + IntToString(RandRange(seed + 20, 5, 100)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S796");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S797");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S798") + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S799") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S800") : "NONE");

        data.scannerWarning = "SMUGGLING OPERATIVE - CONNECTED TO KANG TAO";
        data.dangerLevel = "MODERATE - CORPORATE PROTECTION";

        return data;
    }

    private static func GetDragonCargo(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Prototype smartweapons"; }
        if i == 1 { return "Experimental cyberware"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S801"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S802"); }
        if i == 4 { return "Bioengineered compounds"; }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S803");
    }

    private static func GeneratePeralezProtocol(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S804");
        data.flagColor = "RED";
        data.secretAffiliation = "UNKNOWN HANDLER - BEHAVIORAL MODIFICATION";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S805");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S806") + (RandRange(seed, 1, 100) <= 60 ? "CONFIRMED" : "SUSPECTED") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S807");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S808");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S809") + IntToString(RandRange(seed + 10, 6, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S810");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S811") + IntToString(RandRange(seed + 20, 3, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S812");

        data.scannerWarning = "EXTERNALLY CONTROLLED - HANDLER UNKNOWN";
        data.dangerLevel = "UNKNOWN - PUPPET OF UNKNOWN FORCE";

        return data;
    }

    private static func GenerateImmuneAnomaly(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S813");
        data.flagColor = "CYAN";
        data.secretAffiliation = "BIOTECHNICA PRIORITY";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S814");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S815");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S816") + IntToString(RandRange(seed, 5, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S817") + (RandRange(seed + 10, 1, 100) <= 30 ? "NATURAL MUTATION" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S818")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S819") + IntToString(RandRange(seed + 20, 10000000, 50000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S820");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 30, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S821") : "UNAWARE");

        data.scannerWarning = "HIGH VALUE BIOLOGICAL ASSET";
        data.dangerLevel = "LOW PERSONAL - EXTREME RESEARCH VALUE";

        return data;
    }

    private static func GenerateGhostInMachine(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S822");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "UNKNOWN - POSSIBLY NON-HUMAN";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S823") + IntToString(RandRange(seed, 2072, 2076)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S824");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S825");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S826") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S827") : "Unknown") + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S828") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S829") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S830")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S831");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S832");

        data.scannerWarning = "MAY NOT BE HUMAN - VERIFY BEFORE ENGAGEMENT";
        data.dangerLevel = "UNKNOWN - NATURE UNCONFIRMED";

        return data;
    }

    private static func GenerateIndenturedCorpo(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S833");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S834") + corp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S835") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S272") + IntToString(RandRange(seed + 20, 1000000, 20000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S836");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S837");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S838") + IntToString(RandRange(seed + 30, 0, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S839") + (RandRange(seed + 40, 1, 100) <= 60 ? "DETERIORATING" : "COMPLIANT");

        data.scannerWarning = "CORPORATE PROPERTY - RESTRICTED MOVEMENTS";
        data.dangerLevel = "LOW - CONTROLLED INDIVIDUAL";

        return data;
    }

    private static func GenerateScorpFarmerRefugee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S840");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "AGRICULTURAL COLLAPSE ZONE";

        let regions: array<String>;
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S841"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S842"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S843"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S844"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S845"));

        let region = regions[RandRange(seed, 0, ArraySize(regions) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S846") + region + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S847");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S848") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S849") : "Climate collapse") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S850") + IntToString(RandRange(seed + 20, 1, 8)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S851");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S852") + (RandRange(seed + 30, 1, 100) <= 30 ? "REGISTERED" : "UNDOCUMENTED") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S853");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S854");

        data.scannerWarning = "UNDOCUMENTED - MAY POSSESS SENSITIVE INFORMATION";
        data.dangerLevel = "NONE - REFUGEE";

        return data;
    }

    private static func GeneratePrecogSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S855");
        data.flagColor = "CYAN";
        data.secretAffiliation = "NUSA INTELLIGENCE INTEREST";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S856");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S857") + IntToString(RandRange(seed, 10, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S858");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S859") + IntToString(RandRange(seed + 10, 85, 99)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S860") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S861")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S862") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S863") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S864")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S865");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S866");

        data.scannerWarning = "HIGH VALUE INTELLIGENCE ASSET";
        data.dangerLevel = "LOW - BUT HIGHLY SOUGHT AFTER";

        return data;
    }

    private static func GenerateSmugglerTunnel(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S867");
        data.flagColor = "GREEN";
        data.secretAffiliation = "UNDERGROUND SMUGGLING";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S868");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S869") + KdspRareNPCManager.GetTunnelRoute(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S870") + IntToString(RandRange(seed + 10, 1000000, 20000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S871");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S872");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S610") + IntToString(RandRange(seed + 20, 2065, 2075)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S873") + IntToString(RandRange(seed + 30, 2, 8)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S874") + IntToString(RandRange(seed + 40, 5, 20));

        data.scannerWarning = "ORGANIZED CRIME - ARMED PROTECTION";
        data.dangerLevel = "MODERATE - PROTECTED ASSET";

        return data;
    }

    private static func GetTunnelRoute(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S875"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S876"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S877"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S878"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S879"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S880");
    }

    private static func GenerateArasakaEngramEcho(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S881");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "ARASAKA SOUL PROJECT - LEAK";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S882");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S437") + IntToString(RandRange(seed, 60, 95)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S883");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S884");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S885");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S886") + (RandRange(seed + 10, 1, 100) <= 40 ? "GROWING" : "STABLE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S887");

        data.scannerWarning = "ARASAKA HIGH PRIORITY - MIKOSHI DATA LEAK";
        data.dangerLevel = "LOW PERSONAL - EXTREME CORPORATE SENSITIVITY";

        return data;
    }

    private static func GenerateFeralZoneBorn(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S888");
        data.flagColor = "GOLD";
        data.secretAffiliation = "NO PRIOR CIVILIZATION CONTACT";

        let zones: array<String>;
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S889"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S890"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S891"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S892"));
        ArrayPush(zones, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S893"));

        let zone = zones[RandRange(seed, 0, ArraySize(zones) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S894") + zone + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S895");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S896") + IntToString(RandRange(seed + 10, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S897");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S898") + (RandRange(seed + 20, 1, 100) <= 40 ? "STRUGGLING" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S899")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S900");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S901") + (RandRange(seed + 30, 1, 100) <= 50 ? "Basic conversational" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S902")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S903");

        data.scannerWarning = "NO DATABASE RECORDS - FERAL ORIGIN";
        data.dangerLevel = "LOW - BUT UNPREDICTABLE RESPONSES";

        return data;
    }

    private static func GenerateCorpoInternTrapped(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S904");
        data.flagColor = "YELLOW";

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, "MILITECH");
        ArrayPush(corps, "NIGHT CORP");
        ArrayPush(corps, "BIOTECHNICA");

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + " UNPAID CONTRACT";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S905") + corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S906") + IntToString(RandRange(seed + 5, 16, 19)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S907") + IntToString(RandRange(seed + 10, 10, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S908");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S909");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S910") + IntToString(RandRange(seed + 20, 5000000, 50000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S911");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S912") + IntToString(RandRange(seed + 30, 3, 20)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S913") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S914") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S915")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S916") + (RandRange(seed + 50, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S917") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S918"));

        data.scannerWarning = "CORPORATE PROPERTY - RESTRICTED";
        data.dangerLevel = "NONE - VICTIM OF CONTRACT LAW";

        return data;
    }

    private static func GenerateMaxtacWashout(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S919");
        data.flagColor = "RED";
        data.secretAffiliation = "MAXTAC - DISCHARGED";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S920") + KdspRareNPCManager.GetMaxtacDischarge(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S921") + IntToString(RandRange(seed + 10, 2, 12)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S922") + IntToString(RandRange(seed + 20, 5, 50)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S923");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S924") + IntToString(RandRange(seed + 30, 10, 100)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S925") + IntToString(RandRange(seed + 40, 50, 85)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S926") + (RandRange(seed + 50, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S927") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S928"));

        data.scannerWarning = "EXTREME COMBAT CAPABILITY - DO NOT ENGAGE ALONE";
        data.dangerLevel = "EXTREME - FORMER MAXTAC";

        return data;
    }

    private static func GetMaxtacDischarge(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return "Insubordination"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S929"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S930"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S931"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S932"); }
        return "Classified";
    }

    private static func GenerateProxyVoter(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S933");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "CORPORATE ELECTORAL FRAUD";

        let votes = IntToString(RandRange(seed, 5, 50));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S934") + votes + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S935");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S204") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S936") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S937")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S938") + IntToString(RandRange(seed + 20, 10000, 100000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S939") + IntToString(RandRange(seed + 30, 50, 500)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S940");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S941") + IntToString(RandRange(seed + 40, 2069, 2075)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S942") + IntToString(RandRange(seed + 50, 2, 6)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S943");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S944");

        data.scannerWarning = "ELECTORAL CRIME NETWORK NODE";
        data.dangerLevel = "LOW - BUT CONNECTED TO POWERFUL INTERESTS";

        return data;
    }

    private static func GenerateGeneticChimera(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S945");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "BIOTECHNICA INTEREST";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S946");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S947");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S948") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S949")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S950");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S951") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S952") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S953")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S954") + (RandRange(seed + 20, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S955") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S956")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S957");

        data.scannerWarning = "BIOMETRIC DATA UNRELIABLE - TWO GENETIC PROFILES";
        data.dangerLevel = "LOW - BUT FORENSICALLY INVISIBLE";

        return data;
    }

    private static func GenerateDarkNetLegend(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S958");
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

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S959") + handle + "'. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S960") + IntToString(RandRange(seed + 10, 5, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S961") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S962") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S963")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S964");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S965") + IntToString(RandRange(seed + 30, 1000, 50000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S966") + IntToString(RandRange(seed + 40, 10000000, 100000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S967");

        data.scannerWarning = "HIGH VALUE INTELLIGENCE TARGET";
        data.dangerLevel = "MODERATE - CONNECTED TO POWERFUL NETWORKS";

        return data;
    }

    private static func GenerateCargoStowaway(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S968");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "UNDOCUMENTED IMMIGRANT";

        let origins: array<String>;
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S969"));
        ArrayPush(origins, "Pan-African Federation");
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S970"));
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S971"));
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S972"));

        let origin = origins[RandRange(seed, 0, ArraySize(origins) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S973") + origin + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S974") + IntToString(RandRange(seed + 10, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S975");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S976") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S977") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S978")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S979") + IntToString(RandRange(seed + 30, 10000, 200000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S980") + (RandRange(seed + 40, 1, 100) <= 40 ? "Medical/Engineering training" : "Agricultural/Manual labor") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S981") + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S982"));

        data.scannerWarning = "NO RECORDS - INVISIBLE TO SYSTEM";
        data.dangerLevel = "NONE - VULNERABLE INDIVIDUAL";

        return data;
    }

    private static func GenerateChronoDisplaced(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S983");
        data.flagColor = "CYAN";
        data.secretAffiliation = "CRYOGENIC SUBJECT";

        let frozenYear = IntToString(RandRange(seed, 2020, 2050));
        let revived = IntToString(RandRange(seed + 10, 2072, 2076));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S984") + frozenYear + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S985") + revived + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S986") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S987") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S988")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S989") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S990") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S991")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S992");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S993") + (RandRange(seed + 40, 1, 100) <= 50 ? "Corporate executive" : "Scientific researcher") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S994") + (RandRange(seed + 50, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S995") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S996")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S997");

        data.scannerWarning = "TEMPORALLY DISPLACED - HANDLE WITH CARE";
        data.dangerLevel = "NONE - VULNERABLE INDIVIDUAL";

        return data;
    }

    private static func GenerateSoulSplit(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S998");
        data.flagColor = "PURPLE";
        data.secretAffiliation = "SOULKILLER ANOMALY";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S999");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1000") + IntToString(RandRange(seed, 2, 4)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1001");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1002") + IntToString(RandRange(seed + 10, 10, 60)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1003");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1004") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1005") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1006")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1007") + (RandRange(seed + 30, 1, 100) <= 40 ? "Mikoshi servers" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1008")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1009");

        data.scannerWarning = "MULTIPLE CONSCIOUSNESS INSTANCES - IDENTITY CONFLICT";
        data.dangerLevel = "UNPREDICTABLE - EXISTENTIAL CRISIS ONGOING";

        return data;
    }

    private static func GenerateInfectedFirmware(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1010");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "COMPROMISED CYBERWARE";

        let implants = IntToString(RandRange(seed, 1, 5));

        data.description = "CYBERWARE ALERT: " + implants + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1011");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1012") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1013") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1014")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1015") + (RandRange(seed + 20, 1, 100) <= 50 ? "Compromised ripperdoc" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1016")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1017");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1018") + IntToString(RandRange(seed + 30, 1000, 50000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1019");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1020");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1021") + IntToString(RandRange(seed + 40, 0, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1022");

        data.scannerWarning = "COMPROMISED CYBERWARE - MAY ACT AGAINST WILL";
        data.dangerLevel = "MODERATE - INVOLUNTARY THREAT POSSIBLE";

        return data;
    }

    private static func GenerateWetworkRetired(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1023");
        data.flagColor = "RED";
        data.secretAffiliation = "FORMER WET TEAM";

        let kills = IntToString(RandRange(seed, 20, 200));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1024");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1025") + kills + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1026") + IntToString(RandRange(seed + 10, 5, 25)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1027") + (RandRange(seed + 20, 1, 100) <= 50 ? "ARASAKA BLACK OPS" : "MILITECH SPECIAL PROJECTS") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1028") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1029") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1030")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1031");
        data.hiddenInfo += "Dead man's switch: " + (RandRange(seed + 40, 1, 100) <= 60 ? "YES - Data dump on death" : "UNKNOWN") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1032") + (RandRange(seed + 50, 1, 100) <= 70 ? "MAINTAINED" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1033"));

        data.scannerWarning = "EXTREMELY DANGEROUS - PROFESSIONAL KILLER";
        data.dangerLevel = "EXTREME - DO NOT ENGAGE WITHOUT FULL TEAM";

        return data;
    }

    private static func GenerateChildSoldierGrown(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1034");
        data.flagColor = "GOLD";
        data.secretAffiliation = "CORPORATE WAR CONSCRIPT";

        let conflicts: array<String>;
        ArrayPush(conflicts, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1035"));
        ArrayPush(conflicts, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1036"));
        ArrayPush(conflicts, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1037"));
        ArrayPush(conflicts, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1038"));
        ArrayPush(conflicts, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1039"));

        let conflict = conflicts[RandRange(seed, 0, ArraySize(conflicts) - 1)];
        let age = IntToString(RandRange(seed + 10, 8, 14));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1040") + age + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1041") + conflict + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1042") + IntToString(RandRange(seed + 20, 2, 6)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1043") + (RandRange(seed + 30, 1, 100) <= 50 ? "Corporate PMC" : "Local militia") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1044");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1045") + (RandRange(seed + 40, 1, 100) <= 70 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1046") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1047")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1048") + (RandRange(seed + 50, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1049") : "DEPROGRAMMED") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1050");

        data.scannerWarning = "CONDITIONED COMBATANT - MAY REACT TO TRIGGERS";
        data.dangerLevel = "MODERATE - TRAINED FROM CHILDHOOD";

        return data;
    }

    private static func GenerateIllegalProcreation(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1051");
        data.flagColor = "ORANGE";
        data.secretAffiliation = "POPULATION CONTROL VIOLATION";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1052");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1053");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1054");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1055");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1056") + IntToString(RandRange(seed, 500, 5000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1057") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1058") : "UNKNOWN") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1059") + (RandRange(seed + 20, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1060") : "NONE");

        data.scannerWarning = "NO BIRTH RECORDS - POPULATION VIOLATION";
        data.dangerLevel = "NONE - BUREAUCRATIC ANOMALY";

        return data;
    }

    private static func GenerateOrbitalReturnee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1061");
        data.flagColor = "CYAN";
        data.secretAffiliation = "ORBITAL AIR / ESA RECORDS";

        let years = IntToString(RandRange(seed, 2, 20));
        let stations: array<String>;
        ArrayPush(stations, "Crystal Palace");
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1062"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1063"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1064"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1065"));

        let station = stations[RandRange(seed + 10, 0, ArraySize(stations) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1066") + station + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1067") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1068") + (RandRange(seed + 20, 1, 100) <= 40 ? "Contract expiration" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1069")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1070") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1071") : "COMPLETE") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1072");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1073") + (RandRange(seed + 40, 1, 100) <= 50 ? "REVOKED" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1074")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1075") + (RandRange(seed + 50, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1076") : "NONE DETECTED") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1077");

        data.scannerWarning = "ORBITAL KNOWLEDGE - CORPORATE INTEREST";
        data.dangerLevel = "LOW - BUT VALUABLE INFORMATION SOURCE";

        return data;
    }

    private static func GenerateCorpoDebtSlave(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1078");
        data.flagColor = "YELLOW";
        data.secretAffiliation = "GENERATIONAL DEBT";

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1079") + (RandRange(seed, 1, 100) <= 50 ? "Parent" : "Grandparent") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1080") + IntToString(RandRange(seed + 10, 100000, 5000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1081") + IntToString(RandRange(seed + 20, 5000000, 100000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1082");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1083") + IntToString(RandRange(seed + 30, 2, 4)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1084") + IntToString(RandRange(seed + 40, 40, 80)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1085");

        data.scannerWarning = "GENERATIONAL DEBT - DESPERATE";
        data.dangerLevel = "LOW - BUT MAY TAKE RISKS FOR MONEY";

        return data;
    }

    private static func GenerateGhostTownSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1086");
        data.flagColor = "GOLD";
        data.secretAffiliation = "ABANDONED SETTLEMENT";

        let towns: array<String>;
        ArrayPush(towns, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1087"));
        ArrayPush(towns, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1088"));
        ArrayPush(towns, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1089"));
        ArrayPush(towns, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1090"));
        ArrayPush(towns, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1091"));

        let town = towns[RandRange(seed, 0, ArraySize(towns) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1092") + town + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1093");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1094") + IntToString(RandRange(seed + 10, 2050, 2070)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1095") + IntToString(RandRange(seed + 20, 2, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1096");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1097");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1098") + (RandRange(seed + 30, 1, 100) <= 40 ? "Guarding something" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1099")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1100") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1101") : "MODERATE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1102");

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
