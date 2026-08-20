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
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        
        let agencies: array<String>;
        ArrayPush(agencies, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T0"));
        ArrayPush(agencies, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T1"));
        ArrayPush(agencies, "NETWATCH");
        ArrayPush(agencies, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T2"));
        ArrayPush(agencies, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T3"));
        ArrayPush(agencies, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T4"));

        data.secretAffiliation = agencies[RandRange(seed, 0, ArraySize(agencies) - 1)];
        
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S2") + (RandRange(seed + 10, 1, 100) <= 30 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T5")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S3");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S4");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S5") + IntToString(RandRange(seed + 20, 2, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S7") + KdspRareNPCManager.GetSleeperMission(seed + 30);

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T6");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T7");

        return data;
    }

    private static func GetSleeperMission(seed: Int32) -> String {
        let missions: array<String>;
        ArrayPush(missions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T8"));
        ArrayPush(missions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T9"));
        ArrayPush(missions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T10"));
        ArrayPush(missions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T11"));
        ArrayPush(missions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T12"));
        ArrayPush(missions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T13"));
        
        return missions[RandRange(seed, 0, ArraySize(missions) - 1)];
    }

    private static func GeneratePreCyberpsycho(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S8");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");

        let stage = RandRange(seed, 1, 5);
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T14");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S9");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S10") + IntToString(stage) + "/5. ";
        
        let symptoms: array<String>;
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S11"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S12"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S13"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S14"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T15"));
        ArrayPush(symptoms, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T16"));
        
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S15") + symptoms[RandRange(seed + 10, 0, ArraySize(symptoms) - 1)] + ", ";
        data.description += symptoms[RandRange(seed + 20, 0, ArraySize(symptoms) - 1)] + ". ";
        
        if stage >= 4 {
            data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S16");
            data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T17");
        } else {
            data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S17");
            data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T18");
        }

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S18") + IntToString(RandRange(seed + 30, 6, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S19");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S20") + IntToString(RandRange(seed + 40, 75, 98)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S21") + IntToString(RandRange(seed + 50, 1, 5));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T19");

        return data;
    }

    private static func GenerateLegacyCharacter(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S22");
        data.flagColor = "GOLD";

        let connections: array<String>;
        let details: array<String>;

        ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T20"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S23"));
        
        ArrayPush(connections, "ARASAKA");
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S24"));
        
        ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T21"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S25"));
        
        ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T22"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S26"));
        
        ArrayPush(connections, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T23"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S27"));

        let index = RandRange(seed, 0, ArraySize(connections) - 1);
        data.secretAffiliation = connections[index] + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T24");
        data.description = details[index];
        
        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S28");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S29") + (RandRange(seed + 10, 1, 100) <= 50 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T25")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S30") + (RandRange(seed + 20, 1, 100) <= 30 ? "LIKELY" : "UNKNOWN");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T26");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T27");

        return data;
    }

    private static func GenerateTimeAnomaly(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S31");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T29");

        // Generate impossible dates
        let birthYear = RandRange(seed, 2085, 2120); // Future birth
        let deathYear = RandRange(seed + 10, 2040, 2065); // Past death

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S32");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S33") + IntToString(birthYear) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T30");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S34") + IntToString(deathYear) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T31");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S35");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S36");

        let theories: array<String>;
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S37"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S38"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S39"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S40"));
        ArrayPush(theories, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T32"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S41");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S42") + theories[RandRange(seed + 20, 0, ArraySize(theories) - 1)] + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S43");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S44");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T33");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T34");

        return data;
    }

    private static func GenerateGhost(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S45");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T35");

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T36");

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

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T37");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T38");

        return data;
    }

    private static func GenerateWitness(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S60");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T1");

        let cases: array<String>;
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S61"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S62"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S63"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S64"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S65"));
        ArrayPush(cases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S66"));

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T39");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S67");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S68") + cases[RandRange(seed, 0, ArraySize(cases) - 1)] + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S69");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S70") + IntToString(RandRange(seed + 10, 2070, 2076)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S71");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S72") + IntToString(RandRange(seed + 20, 1, 4)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S73");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S74") + IntToString(RandRange(seed + 30, 50000, 500000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T40");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T41");

        return data;
    }

    private static func GenerateHunted(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S75");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");

        let hunters: array<String>;
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S76"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T42"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S77"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S78"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S79"));
        ArrayPush(hunters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S80"));

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T43");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S81");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S82") + hunters[RandRange(seed, 0, ArraySize(hunters) - 1)] + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S83") + IntToString(RandRange(seed + 10, 100000, 2000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S84") + IntToString(RandRange(seed + 20, 30, 500)) + ".";

        let reasons: array<String>;
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S85"));
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S86"));
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S87"));
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T44"));
        ArrayPush(reasons, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S88"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S89") + reasons[RandRange(seed + 30, 0, ArraySize(reasons) - 1)] + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S90") + IntToString(RandRange(seed + 40, 2, 8)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S91") + (RandRange(seed + 50, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T45") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T44"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T45");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T46");

        return data;
    }

    private static func GenerateAIContact(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S92");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T47");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S93");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S94") + (RandRange(seed, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T48") : "UNKNOWN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S95") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T12") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T40")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S96");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S97");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S98");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S99");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S100") + (RandRange(seed + 20, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T49") : GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T55"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T50");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T51");

        return data;
    }

    private static func GenerateWhistleblower(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S101");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");

        let corps: array<String>;
        ArrayPush(corps, "Arasaka");
        ArrayPush(corps, "Militech");
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-Corpo-BIOTECHNICA"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-Corpo-KANG_TAO"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-Corpo-ZETATECH"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T52"));

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T53") + corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T54");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S102") + corp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S103") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T34") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T55")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S104") + KdspRareNPCManager.GetLeakedData(seed + 20) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S105");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S106") + KdspRareNPCManager.GetCorpoPosition(seed + 30) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S107") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T56") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T57")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S108") + IntToString(RandRange(seed + 50, 100000, 5000000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T58");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T59");

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
        ArrayPush(positions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T60"));
        ArrayPush(positions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T61"));
        ArrayPush(positions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T62"));
        ArrayPush(positions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T63"));
        ArrayPush(positions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T64"));
        
        return positions[RandRange(seed, 0, ArraySize(positions) - 1)];
    }

    private static func GenerateHiddenNetrunner(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S116");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T65");

        let aliases: array<String>;
        ArrayPush(aliases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T66"));
        ArrayPush(aliases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T67"));
        ArrayPush(aliases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T68"));
        ArrayPush(aliases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T69"));
        ArrayPush(aliases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T70"));
        ArrayPush(aliases, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T71"));

        let alias = aliases[RandRange(seed, 0, ArraySize(aliases) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S117") + alias + "'. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S118") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T72") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T73")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S119");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S120") + IntToString(RandRange(seed + 20, 50000, 500000)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S121") + IntToString(RandRange(seed + 30, 1, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S122");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S123") + IntToString(RandRange(seed + 40, 1, 100)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S124");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S125") + (RandRange(seed + 50, 1, 100) <= 40 ? "HIGH" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T74"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T75");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T76");

        return data;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED FLAGGED INDIVIDUAL TYPES
    // ═══════════════════════════════════════════════════════════════════════

    private static func GenerateUndercoverCop(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S126");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T1");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T77");

        let units: array<String>;
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S127"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T78"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S128"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T12"));
        ArrayPush(units, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T79"));

        let unit = units[RandRange(seed, 0, ArraySize(units) - 1)];
        let years = IntToString(RandRange(seed + 10, 1, 8));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S129") + unit + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S130") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S131");
        data.description += "WARNING: Blowing cover could result in officer death and case collapse.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S132");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S133") + KdspRareNPCManager.GetUndercoverTarget(seed + 20);

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T80");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T81");

        return data;
    }

    private static func GetUndercoverTarget(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T82"); }
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

        ArrayPush(professions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T83"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S140") + IntToString(RandRange(seed, 50, 200)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S141"));

        ArrayPush(professions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T84"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S142"));

        ArrayPush(professions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T85"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S143") + KdspRareNPCManager.GetDistrict(seed) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S144"));

        ArrayPush(professions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T86"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S145"));

        ArrayPush(professions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T87"));
        ArrayPush(details, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S146"));

        let index = RandRange(seed, 0, ArraySize(professions) - 1);
        data.secretAffiliation = professions[index];
        data.description = details[index];

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S147") + IntToString(RandRange(seed + 10, 0, 12)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S148");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S149");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T88");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T89");

        return data;
    }

    private static func GetDistrict(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T26"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T27"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T29"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T30"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T31"); }
        return GetLocalizedTextByKey(n"Kdsp-NCPDNameGenera-T28");
    }

    private static func GenerateCloneSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S150");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T90");

        let generation = RandRange(seed, 2, 7);
        let original = RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T91") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T92");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S151") + IntToString(generation) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S152");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S153") + original + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S154");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S155") + (RandRange(seed + 20, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T93") : GetLocalizedTextByKey(n"Kdsp-MedicalHistory-T196")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S156");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S157") + IntToString(RandRange(seed + 30, 1, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S158") + IntToString(RandRange(seed + 40, 0, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S159") + IntToString(RandRange(seed + 50, 0, 30)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S160") + (RandRange(seed + 60, 1, 100) <= 50 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T94"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T95");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T96");

        return data;
    }

    private static func GenerateMaxtacTarget(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S161");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T97");

        let priority = RandRange(seed, 1, 5);
        let reason = KdspRareNPCManager.GetMaxtacReason(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S162") + IntToString(priority) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S163");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + reason + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S165") + (priority <= 2 ? GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T117") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T98")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S166") + (priority <= 2 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T99") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T100")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S167") + IntToString(RandRange(seed + 20, 0, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S168") + IntToString(RandRange(seed + 30, 0, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S169") + IntToString(RandRange(seed + 40, 100000, 1000000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T101");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T102");

        return data;
    }

    private static func GetMaxtacReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T103"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S170"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T104"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T105"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S171"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S172");
    }

    private static func GenerateWitnessProtection(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S173");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T1");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T106");

        let witnessed = KdspRareNPCManager.GetWitnessedEvent(seed);
        let years = IntToString(RandRange(seed + 10, 1, 15));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S174");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S175") + witnessed + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S176") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S177");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S178");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S179");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S180") + IntToString(RandRange(seed + 20, 500000, 5000000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T107");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T108");

        return data;
    }

    private static func GetWitnessedEvent(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S181"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S182"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S183"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T109"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S184"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T110");
    }

    private static func GenerateEngramCandidate(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S185");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T111");

        let compatibility = IntToString(RandRange(seed, 85, 99));
        let status = RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T112") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S186");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S187") + compatibility + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + status + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S189");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S190") + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S191");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S192") + (RandRange(seed + 30, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T114") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T40"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T115");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T116");

        return data;
    }

    private static func GenerateCorpoDefector(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S193");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T273"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T281"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T282"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T285"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T283"));

        let fromCorp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        let toCorp = corps[RandRange(seed + 10, 0, ArraySize(corps) - 1)];

        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T117") + fromCorp;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S194") + fromCorp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S195") + toCorp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S196") + (RandRange(seed + 20, 1, 100) <= 70 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T114") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T40")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S197") + fromCorp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T118");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S198") + toCorp + ": " + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T114") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T119"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S199") + KdspRareNPCManager.GetCorpoPosition(seed + 40) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S200") + IntToString(RandRange(seed + 50, 10000000, 100000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S201") + IntToString(RandRange(seed + 60, 1, 8));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T120");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T121");

        return data;
    }

    private static func GenerateGangInfiltrator(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S202");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");

        let gangs: array<String>;
        ArrayPush(gangs, "MAELSTROM");
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T268"));
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T269"));
        ArrayPush(gangs, "VALENTINOS");
        ArrayPush(gangs, "ANIMALS");
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T270"));

        let infiltrated = gangs[RandRange(seed, 0, ArraySize(gangs) - 1)];
        let employer = RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T122") : "CORPORATE";

        data.secretAffiliation = employer + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T123") + infiltrated;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S203") + infiltrated + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S204") + employer + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S205") + IntToString(RandRange(seed + 20, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S206") + KdspRareNPCManager.GetGangPosition(seed + 30) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S207");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S208");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S209") + IntToString(RandRange(seed + 40, 3, 14)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S210");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S211") + (RandRange(seed + 50, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T124") : "NONE");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T125");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T126");

        return data;
    }

    private static func GetGangPosition(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return "Lieutenant"; }
        if i == 1 { return "Enforcer"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T127"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T128"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T129");
    }

    private static func GenerateTraumaTeamMarked(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S212");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T130");

        let reason = KdspRareNPCManager.GetTraumaReason(seed);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S213");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + reason + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S214");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S215");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S216");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S217") + IntToString(RandRange(seed + 10, 1, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S218") + IntToString(RandRange(seed + 20, 0, 3));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T131");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T132");

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
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T70");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T133");

        let role = KdspRareNPCManager.GetFixerRole(seed);
        let fixer = KdspRareNPCManager.GetFixerName(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S225") + fixer + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S226") + role + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S227");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S228");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S229") + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S230") + IntToString(RandRange(seed + 30, 10, 200)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S231");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T134");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T135");

        return data;
    }

    private static func GetFixerRole(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T136"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S232"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T137"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T138"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T139"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T140");
    }

    private static func GetFixerName(seed: Int32) -> String {
        let i = RandRange(seed, 0, 7);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T141"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T142"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T143"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T144"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T145"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T146"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T147"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T148");
    }

    private static func GenerateBlackmailVictim(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S233");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T149");

        let secret = KdspRareNPCManager.GetBlackmailSecret(seed);
        let blackmailer = KdspRareNPCManager.GetBlackmailerType(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S234");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S235") + secret + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S236") + blackmailer + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S237");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S238") + IntToString(RandRange(seed + 20, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S239") + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S240") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T34") : "HIGH");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T150");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T26");

        return data;
    }

    private static func GetBlackmailSecret(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S241"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S242"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S243"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T151"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S244"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T152");
    }

    private static func GetBlackmailerType(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T153"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T154"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T155"); }
        if i == 3 { return "Netrunner"; }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T156");
    }

    private static func GenerateMilitaryAwol(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S245");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");

        let branches: array<String>;
        ArrayPush(branches, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T157"));
        ArrayPush(branches, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T158"));
        ArrayPush(branches, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T159"));
        ArrayPush(branches, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T160"));
        ArrayPush(branches, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T161"));

        let branch = branches[RandRange(seed, 0, ArraySize(branches) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T162") + branch;

        let rank = KdspRareNPCManager.GetMilitaryRank(seed + 10);
        let years = IntToString(RandRange(seed + 20, 1, 10));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S246") + branch + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S247") + rank + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S248") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S250") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T99") : GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T48")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S251");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S252");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S253") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T163") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T164")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S169") + IntToString(RandRange(seed + 50, 50000, 500000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T165");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T166");

        return data;
    }

    private static func GetMilitaryRank(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T22"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T23"); }
        if i == 2 { return "Sergeant"; }
        if i == 3 { return "Lieutenant"; }
        if i == 4 { return "Captain"; }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S254");
    }

    private static func GenerateExperimentalSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S255");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");

        let experiments: array<String>;
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T167"));
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T168"));
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T169"));
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S256"));
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T170"));
        ArrayPush(experiments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T171"));

        let experiment = experiments[RandRange(seed, 0, ArraySize(experiments) - 1)];
        let corp = RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T282") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T172");
        data.secretAffiliation = corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T173");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S257") + experiment + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S258");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S259") + IntToString(RandRange(seed + 20, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S260");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S261") + (RandRange(seed + 30, 1, 100) <= 50 ? "HIGH" : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T44"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S262") + IntToString(RandRange(seed + 40, 100, 999)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S263") + IntToString(RandRange(seed + 50, 1, 5)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S264") + IntToString(RandRange(seed + 60, 1, 8)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S265") + (RandRange(seed + 70, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T174") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T175"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T176");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T177");

        return data;
    }

    private static func GenerateDebtCollection(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S266");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T178");

        let creditor = KdspRareNPCManager.GetCreditor(seed);
        let amount = IntToString(RandRange(seed + 10, 100000, 5000000));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S267") + amount + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S268") + creditor + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S269");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S270") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T179") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T180")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S271") + (RandRange(seed + 30, 1, 100) <= 30 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T25"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S272") + IntToString(RandRange(seed + 40, 10000, 500000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S273");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S274") + IntToString(RandRange(seed + 50, 1, 10)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S275") + IntToString(RandRange(seed + 60, 10000, 100000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T181");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T182");

        return data;
    }

    private static func GetCreditor(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T327"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S276"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S277"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T183"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T184"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T185");
    }

    private static func GenerateOrganMarked(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S278");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T186");

        let organs: array<String>;
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S279"));
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S280"));
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T187"));
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S281"));
        ArrayPush(organs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T188"));

        let organ = organs[RandRange(seed, 0, ArraySize(organs) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S282") + organ + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S283") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T189") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T190")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S284") + IntToString(RandRange(seed + 20, 50000, 500000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 30, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T112") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S285") + IntToString(RandRange(seed + 40, 0, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S286") + IntToString(RandRange(seed + 50, 1, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S287") + KdspRareNPCManager.GetHarvestOpportunity(seed + 60);

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T191");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T192");

        return data;
    }

    private static func GetHarvestOpportunity(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T193"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S288"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T194"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T195"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T196");
    }

    private static func GenerateCultEscapee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S289");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");

        let cults: array<String>;
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S290"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S291"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T197"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T198"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S292"));
        ArrayPush(cults, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S293"));

        let cult = cults[RandRange(seed, 0, ArraySize(cults) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T199") + cult;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S294") + cult + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S295") + IntToString(RandRange(seed + 10, 2, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S296") + (RandRange(seed + 20, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T27") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T200")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S297");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S298");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S299") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-MedicalHistory-T196") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T93")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S300") + (RandRange(seed + 40, 1, 100) <= 70 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T114") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T40"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T201");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T202");

        return data;
    }

    private static func GenerateRelicCompatible(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S301");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T203");

        let compatibility = IntToString(RandRange(seed, 90, 99));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S302") + compatibility + "%). ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S303");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 10, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T112") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S304");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S305");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S306") + IntToString(RandRange(seed + 20, 50000000, 200000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S307") + (RandRange(seed + 30, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T89") : GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T90"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T204");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T205");

        return data;
    }

    private static func GenerateDataCourier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S308");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T70");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T206");

        let dataType = KdspRareNPCManager.GetCourierData(seed);
        let client = KdspRareNPCManager.GetCourierClient(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S309") + dataType + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S310") + client + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S311");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S312") + IntToString(RandRange(seed + 20, 100000, 10000000));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S313") + IntToString(RandRange(seed + 30, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S314") + IntToString(RandRange(seed + 40, 50, 500)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S315") + IntToString(RandRange(seed + 50, 0, 20));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T207");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T208");

        return data;
    }

    private static func GetCourierData(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T209"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T210"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T211"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T212"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T213"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S316");
    }

    private static func GetCourierClient(seed: Int32) -> String {
        let i = RandRange(seed, 0, 4);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T214"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T215"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T216"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T156"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T217");
    }

    private static func GenerateDoubleAgent(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S317");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");

        let org1 = KdspRareNPCManager.GetAgentOrg(seed);
        let org2 = KdspRareNPCManager.GetAgentOrg(seed + 10);
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T218") + org1 + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T219") + org2;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S318");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S319") + org1 + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S320") + org2 + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S321");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S322");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S323") + IntToString(RandRange(seed + 20, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S324") + IntToString(RandRange(seed + 30, 5, 50)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S325") + IntToString(RandRange(seed + 40, 0, 20));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T220");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T221");

        return data;
    }

    private static func GetAgentOrg(seed: Int32) -> String {
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "ARASAKA"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T273"); }
        if i == 2 { return "NETWATCH"; }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T222"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T223"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T133"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T224"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T225");
    }

    private static func GenerateNomadExile(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S326");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");

        let clans: array<String>;
        ArrayPush(clans, "ALDECALDOS");
        ArrayPush(clans, "WRAITHS");
        ArrayPush(clans, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T226"));
        ArrayPush(clans, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T227"));
        ArrayPush(clans, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T228"));

        let clan = clans[RandRange(seed, 0, ArraySize(clans) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T229") + clan;

        let reason = KdspRareNPCManager.GetExileReason(seed + 10);

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S327") + clan + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S328");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + reason + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S329") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T230") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T231")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S330");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S331") + IntToString(RandRange(seed + 30, 5, 25)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S332");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S333") + IntToString(RandRange(seed + 40, 10000, 100000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T232");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T233");

        return data;
    }

    private static func GetExileReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S334"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S335"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S336"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S337"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S338"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T234");
    }

    // ===================================
    // NEW CLASSIFICATIONS (30 types)
    // ===================================

    private static func GenerateBraindanceAddict(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S339");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T14");

        let hours = IntToString(RandRange(seed, 14, 22));
        let genres: array<String>;
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T235"));
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
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S352") + (RandRange(seed + 40, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T55") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T44")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S353");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T236");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T237");

        return data;
    }

    private static func GenerateNightCorpSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S354");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T238");

        let phase = RandRange(seed, 1, 4);
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S355");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S356") + IntToString(phase) + "/4. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S357") + (phase >= 3 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T73") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T239")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S358");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S359") + IntToString(RandRange(seed + 10, 2070, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S360") + IntToString(RandRange(seed + 20, 2, 15)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S361");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T240");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T241");

        return data;
    }

    private static func GenerateDollChipSleeper(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S362");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T242");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S363");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S364") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T243") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T5")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S365") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T244") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T245")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S366");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S367") + IntToString(RandRange(seed + 20, 1, 8)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S368") + IntToString(RandRange(seed + 30, 0, 12)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S369");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T246");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T247");

        return data;
    }

    private static func GenerateSoulkillerSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S370");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T111");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S371");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S372") + (RandRange(seed, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T248") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T249")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S373");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S374") + IntToString(RandRange(seed + 10, 40, 85)) + "%.";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S375") + IntToString(RandRange(seed + 20, 2060, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S376");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S377");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T250");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T251");

        return data;
    }

    private static func GenerateBlackwallTouched(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S378");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T252");

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

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T50");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T253");

        return data;
    }

    private static func GenerateSignalCarrier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S394");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T70");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T254");

        let freq = IntToString(RandRange(seed, 100, 999));
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S395") + freq + "." + IntToString(RandRange(seed + 5, 10, 99)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S396");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S397") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T255") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T256")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S398");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S399");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S400") + IntToString(RandRange(seed + 20, 1, 24)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S19");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S401") + IntToString(RandRange(seed + 30, 3, 20)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S402");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S403");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T257");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T258");

        return data;
    }

    private static func GenerateMemoryWiped(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S404");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T259");

        let years = IntToString(RandRange(seed, 2, 20));
        let wipers: array<String>;
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S405"));
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T260"));
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S406"));
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S407"));
        ArrayPush(wipers, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T261"));

        let wiper = wipers[RandRange(seed + 10, 0, ArraySize(wipers) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S408");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S409") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S410");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S411") + wiper + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S412");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S413");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S414") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S415") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S416")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S417") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T262") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S418"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T263");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T264");

        return data;
    }

    private static func GenerateIdentityStolen(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S419");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T265");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S420");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S421") + (RandRange(seed, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T266") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T267")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S422") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S423") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S424")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S425");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S426") + IntToString(RandRange(seed + 20, 1, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S427") + IntToString(RandRange(seed + 30, 0, 3)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S428");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S429") + KdspRareNPCManager.GetIdentityTheftReason(seed + 40);

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T268");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T269");

        return data;
    }

    private static func GetIdentityTheftReason(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S430"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S431"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S432"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S433"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T270"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S434");
    }

    private static func GenerateMissingPerson(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S435");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T271");

        let years = IntToString(RandRange(seed, 1, 20));
        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S436") + (RandRange(seed + 5, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Classification") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T272")) + " " + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += "Official case status: CLOSED. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S437") + IntToString(RandRange(seed + 10, 92, 99)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S438");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S439") + KdspRareNPCManager.GetDisappearanceCase(seed + 20) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S440") + IntToString(RandRange(seed + 30, 50000, 2000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S441");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T33");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T273");

        return data;
    }

    private static func GetDisappearanceCase(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T274"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S442"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S443"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S444"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T275"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T276");
    }

    private static func GenerateActiveBounty(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S445");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");

        let amount = IntToString(RandRange(seed, 50000, 5000000));
        let posters: array<String>;
        ArrayPush(posters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T277"));
        ArrayPush(posters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T278"));
        ArrayPush(posters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T223"));
        ArrayPush(posters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T279"));
        ArrayPush(posters, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T280"));

        let poster = posters[RandRange(seed + 10, 0, ArraySize(posters) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T281");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S446") + amount + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S447") + poster + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S448") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T282") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T283")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S449") + IntToString(RandRange(seed + 30, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S450");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S451") + IntToString(RandRange(seed + 40, 1, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S453") + IntToString(RandRange(seed + 50, 0, 4)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 60, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S454") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T284");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T285");

        return data;
    }

    private static func GenerateUnregisteredChrome(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S455");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T286");

        let loadPct = IntToString(RandRange(seed, 65, 95));
        let milGrade = RandRange(seed + 10, 1, 100) <= 40;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S456") + loadPct + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S457");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S458") + (milGrade ? GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T12") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T287")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S459");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S460") + (milGrade ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T288") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T289")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S461") + IntToString(RandRange(seed + 20, 500000, 5000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S462") + (RandRange(seed + 30, 1, 100) <= 50 ? "ELEVATED" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S463")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S464") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T290") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S465"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T291");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T292");

        return data;
    }

    private static func GeneratePoliticalDissident(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S466");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");

        let causes: array<String>;
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T293"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S467"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S468"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S469"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T294"));
        ArrayPush(causes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S470"));

        let cause = causes[RandRange(seed, 0, ArraySize(causes) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T295");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S471") + cause + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S472") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T296") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T297")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S473") + (RandRange(seed + 20, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T298") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T299")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S474") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T114") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T40"));

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S475") + IntToString(RandRange(seed + 40, 2068, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S476") + IntToString(RandRange(seed + 50, 5, 50)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S477") + (RandRange(seed + 60, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T300") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T301"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T302");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T303");

        return data;
    }

    private static func GenerateNeuralDivergent(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S478");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T304");

        let resistance = IntToString(RandRange(seed, 85, 99));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S479");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S480") + resistance + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S481");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S482") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T305") : "UNKNOWN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S483");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S484");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S485");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S486") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T112") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T306");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T307");

        return data;
    }

    private static func GenerateSyntheticSleeper(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S487");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T90");

        let synthPct = IntToString(RandRange(seed, 30, 80));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S488") + synthPct + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S489");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S490");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 10, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T112") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S492") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T308")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S493") + IntToString(RandRange(seed + 30, 5, 25)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S494") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T309") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T310")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S495") + IntToString(RandRange(seed + 50, 1, 15)) + "%";

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T311");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T312");

        return data;
    }

    private static func GenerateBuriedPast(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S496");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T313");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S497") + IntToString(RandRange(seed, 2065, 2075)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S498");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S499") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S500") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S501")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S502");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S503") + IntToString(RandRange(seed + 20, 1000000, 10000000)) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S504") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S505") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S506")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S507") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S508") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T314")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S509");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T315");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T316");

        return data;
    }

    private static func GenerateCombatZoneSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S510");
        data.flagColor = "GOLD";
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T317");

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

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S521") + (RandRange(seed + 30, 1, 100) <= 70 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T318") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T319")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S522") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S523") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S524")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S525");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T320");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T321");

        return data;
    }

    private static func GenerateArasakaBloodline(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S526");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T322");

        let relation = RandRange(seed, 1, 100);
        let relationType: String;
        if relation <= 30 { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S527"); }
        else if relation <= 60 { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S528"); }
        else if relation <= 80 { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S529"); }
        else { relationType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S530"); }

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S531") + relationType + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S532");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S533") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T323") : "UNKNOWN") + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S534") + (RandRange(seed + 20, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T324") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T325")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S535");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S536") + IntToString(RandRange(seed + 30, 94, 99)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S537");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S538") + (RandRange(seed + 40, 1, 100) <= 60 ? "HIGH" : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T44"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T326");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T327");

        return data;
    }

    private static func GenerateBioplagueCarrier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S539");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T328");

        let agents: array<String>;
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S540"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S541"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S542"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S543"));
        ArrayPush(agents, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T329"));

        let agent = agents[RandRange(seed, 0, ArraySize(agents) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S544") + agent + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S545") + (RandRange(seed + 10, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T330") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S546")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S547") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S548")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S549") + (RandRange(seed + 30, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T331") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T332")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S550") + IntToString(RandRange(seed + 40, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S551") + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH" : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T45")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S552");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T333");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T334");

        return data;
    }

    private static func GenerateReaperContract(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S553");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T335");

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
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S564") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T336") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T337") + IntToString(RandRange(seed + 35, 2, 4))) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S565") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T338") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T339"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T340") + IntToString(timeframe) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T341");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T342");

        return data;
    }

    private static func GenerateDelaminGlitch(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S566");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T343");

        let fragments: array<String>;
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S567"));
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S568"));
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S569"));
        ArrayPush(fragments, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T344"));
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

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T345");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T346");

        return data;
    }

    private static func GenerateImplantBomb(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S581");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T347");

        let yield = RandRange(seed, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S582") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T348") + IntToString(RandRange(seed + 5, 5, 20)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S583");
        let trigger = RandRange(seed + 10, 1, 100);
        let triggerType: String;
        if trigger <= 30 { triggerType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T349"); }
        else if trigger <= 60 { triggerType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S584"); }
        else if trigger <= 80 { triggerType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T350"); }
        else { triggerType = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S585"); }

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S586");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S587") + yield + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S588") + triggerType + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S589") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S590")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S591") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T351") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S592")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S593") + IntToString(RandRange(seed + 40, 10, 40)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S594");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T88");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T352");

        return data;
    }

    private static func GenerateNCPDInformant(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S595");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T1");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T353");

        let gangs: array<String>;
        ArrayPush(gangs, "Maelstrom");
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation"));
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-Shared-C33"));
        ArrayPush(gangs, "Valentinos");
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T354"));
        ArrayPush(gangs, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T355"));

        let infiltrating = gangs[RandRange(seed, 0, ArraySize(gangs) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S596");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S597") + infiltrating + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S598") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T356") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T357") + IntToString(RandRange(seed + 15, 1000, 9999))) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S599") + IntToString(RandRange(seed + 20, 5, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T358");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S600") + IntToString(RandRange(seed + 30, 2069, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S601") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S602") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T359")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S603") + (RandRange(seed + 50, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S604") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T360"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T361");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T362");

        return data;
    }

    private static func GenerateTechnoNecro(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S605");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T363");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S606");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S607") + KdspRareNPCManager.GetNecroActivity(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S608") + IntToString(RandRange(seed + 10, 2, 20)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S609");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S610") + IntToString(RandRange(seed + 20, 2070, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S611") + IntToString(RandRange(seed + 30, 5, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S612");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S613") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S614") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S615"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T364");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T365");

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
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T366");

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
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S634") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T367") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T368")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S635") + (RandRange(seed + 50, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S636") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T45"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T369");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T370");

        return data;
    }

    private static func GenerateAIPuppet(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S637");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T371");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S638");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S639") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S640") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S641")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S642") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T372") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T373")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S643") + IntToString(RandRange(seed + 20, 60, 95)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S644");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S645") + IntToString(RandRange(seed + 30, 1, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S646");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S647") + IntToString(RandRange(seed + 40, 0, 3)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S648");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S649");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T374");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T375");

        return data;
    }

    private static func GenerateBlackIceSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S650");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T376");

        let iceTypes: array<String>;
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S651"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S652"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S653"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S654"));
        ArrayPush(iceTypes, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T377"));

        let iceType = iceTypes[RandRange(seed, 0, ArraySize(iceTypes) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S655");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S656") + iceType + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S657") + IntToString(RandRange(seed + 10, 20, 70)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S658");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S659");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S660") + IntToString(RandRange(seed + 20, 1, 8)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S661") + (RandRange(seed + 30, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S662") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S663")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S664");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T378");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T379");

        return data;
    }

    private static func GeneratePersonalityFragment(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S665");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T380");

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
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T381");

        return data;
    }

    private static func GenerateCorpoAssetFrozen(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S684");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");

        let corps: array<String>;
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T382"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T383"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T384"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T385"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T386"));

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T387") + corp;

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S685") + corp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S686") + IntToString(RandRange(seed + 10, 100000, 10000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S687");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S688") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S689") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T388")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S690") + IntToString(RandRange(seed + 30, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S164") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S691") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S692")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S693");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T389");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T390");

        return data;
    }

    private static func GenerateDreamtechVictim(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S694");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T391");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S695");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S696");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S697") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S698") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S699")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S700") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S701") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S702")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S703") + IntToString(RandRange(seed + 20, 6, 48)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S704");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S705") + IntToString(RandRange(seed + 30, 10, 200)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S706");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T392");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T393");

        return data;
    }

    private static func GenerateContaminatedScop(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S707");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T394");

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
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S716") + IntToString(RandRange(seed + 20, 200, 5000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T395");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S717") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T396") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T397")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S718") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S719") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S720")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S721") + (RandRange(seed + 50, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S722") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T398"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T399");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T400");

        return data;
    }

    // ===================================
    // NEW CLASSIFICATIONS CONTINUED (30 types)
    // ===================================

    private static func GenerateCorpoHeirHiding(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S723");
        data.flagColor = "GOLD";

        let corps: array<String>;
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T285"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T281"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T283"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T401"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T282"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T402"));

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T403");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S724") + corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S725");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S726") + IntToString(RandRange(seed + 10, 1, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S727");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S728") + IntToString(RandRange(seed + 20, 100000000, 999000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S729");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S730") + (RandRange(seed + 30, 1, 100) <= 60 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S731")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S732") + KdspRareNPCManager.GetHeirFlightReason(seed + 40) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S733");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T58");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T327");

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
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T404");

        let duration = IntToString(RandRange(seed, 2, 45));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S741") + duration + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S742");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S743");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S744") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S745") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S746")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S747") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S748") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S749")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S750") + IntToString(RandRange(seed + 30, 2068, 2076)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S751");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S752") + (RandRange(seed + 40, 1, 100) <= 50 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T405"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T406");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T407");

        return data;
    }

    private static func GenerateIllegalBDProducer(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S753");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T408");

        let genres: array<String>;
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T409"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T410"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T411"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S754"));
        ArrayPush(genres, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S755"));

        let genre = genres[RandRange(seed, 0, ArraySize(genres) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S756") + genre + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S757") + IntToString(RandRange(seed + 10, 10, 200)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S758") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T412") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T413")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S759") + IntToString(RandRange(seed + 30, 500000, 10000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T414");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S760") + (RandRange(seed + 40, 1, 100) <= 40 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S761")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S762") + IntToString(RandRange(seed + 50, 5, 50)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S763") + (RandRange(seed + 60, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T99") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T300"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T415");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T416");

        return data;
    }

    private static func GenerateDeepFakeIdentity(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S764");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T417");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S765");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S766");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S767") + (RandRange(seed, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S768") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S769")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S770");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S771") + IntToString(RandRange(seed + 10, 1, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S772") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S773") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S774")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S775") + IntToString(RandRange(seed + 30, 500000, 5000000));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T418");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T419");

        return data;
    }

    private static func GenerateCyberpsychoRecovered(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S776");
        data.flagColor = "GOLD";
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T420");

        let kills = IntToString(RandRange(seed, 3, 30));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S777");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S778") + IntToString(RandRange(seed + 5, 2068, 2076)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S779") + kills + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S780") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S781") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T421")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S782") + IntToString(RandRange(seed + 20, 15, 40)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S783");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S784") + IntToString(RandRange(seed + 30, 5, 35)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S785") + (RandRange(seed + 40, 1, 100) <= 80 ? "ACTIVE" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S786")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S787") + (RandRange(seed + 50, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T99") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S788"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T422");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T423");

        return data;
    }

    private static func GenerateDragonCourier(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S789");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T70");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T424");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S790");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S791") + KdspRareNPCManager.GetDragonCargo(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S792") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S793") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S794")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S795") + IntToString(RandRange(seed + 20, 5, 100)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S796");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S797");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S798") + IntToString(RandRange(seed + 30, 50000, 500000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S799") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S800") : "NONE");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T425");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T426");

        return data;
    }

    private static func GetDragonCargo(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T427"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T428"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S801"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S802"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T429"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S803");
    }

    private static func GeneratePeralezProtocol(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S804");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T430");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S805");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S806") + (RandRange(seed, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T114") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T40")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S807");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S808");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S809") + IntToString(RandRange(seed + 10, 6, 36)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S452");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S810");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S811") + IntToString(RandRange(seed + 20, 3, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S812");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T431");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T432");

        return data;
    }

    private static func GenerateImmuneAnomaly(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S813");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T433");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S814");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S815");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S816") + IntToString(RandRange(seed, 5, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S817") + (RandRange(seed + 10, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T434") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S818")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S819") + IntToString(RandRange(seed + 20, 10000000, 50000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S820");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S188") + (RandRange(seed + 30, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S821") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T113"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T435");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T436");

        return data;
    }

    private static func GenerateGhostInMachine(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S822");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T437");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S823") + IntToString(RandRange(seed, 2072, 2076)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S824");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S825");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S826") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S827") : GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S828") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S829") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S830")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S831");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S832");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T438");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T439");

        return data;
    }

    private static func GenerateIndenturedCorpo(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S833");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T273"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T282"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T281"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T285"));

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T440");

        let years = IntToString(RandRange(seed + 10, 5, 30));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S834") + corp + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S835") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S272") + IntToString(RandRange(seed + 20, 1000000, 20000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S836");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S837");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S838") + IntToString(RandRange(seed + 30, 0, 3)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S839") + (RandRange(seed + 40, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T175") : GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T259"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T441");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T442");

        return data;
    }

    private static func GenerateScorpFarmerRefugee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S840");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T443");

        let regions: array<String>;
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S841"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S842"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S843"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S844"));
        ArrayPush(regions, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S845"));

        let region = regions[RandRange(seed, 0, ArraySize(regions) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S846") + region + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S847");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S848") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S849") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T444")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S850") + IntToString(RandRange(seed + 20, 1, 8)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S851");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S852") + (RandRange(seed + 30, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T445") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T446")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S853");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S854");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T447");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T448");

        return data;
    }

    private static func GeneratePrecogSubject(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S855");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T449");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S856");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S857") + IntToString(RandRange(seed, 10, 50)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S858");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S859") + IntToString(RandRange(seed + 10, 85, 99)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S860") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S861")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S862") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S863") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S864")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S865");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S866");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T450");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T451");

        return data;
    }

    private static func GenerateSmugglerTunnel(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S867");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T70");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T452");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S868");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S869") + KdspRareNPCManager.GetTunnelRoute(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S870") + IntToString(RandRange(seed + 10, 1000000, 20000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S871");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S872");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S610") + IntToString(RandRange(seed + 20, 2065, 2075)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S873") + IntToString(RandRange(seed + 30, 2, 8)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S874") + IntToString(RandRange(seed + 40, 5, 20));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T453");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T454");

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
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T455");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S882");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S437") + IntToString(RandRange(seed, 60, 95)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S883");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S884");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S885");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S886") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T456") : "STABLE") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S887");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T457");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T458");

        return data;
    }

    private static func GenerateFeralZoneBorn(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S888");
        data.flagColor = "GOLD";
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T459");

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
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S901") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T460") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S902")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S903");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T461");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T462");

        return data;
    }

    private static func GenerateCorpoInternTrapped(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S904");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");

        let corps: array<String>;
        ArrayPush(corps, "ARASAKA");
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T273"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T463"));
        ArrayPush(corps, GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T282"));

        let corp = corps[RandRange(seed, 0, ArraySize(corps) - 1)];
        data.secretAffiliation = corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T464");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S905") + corp + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S906") + IntToString(RandRange(seed + 5, 16, 19)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S907") + IntToString(RandRange(seed + 10, 10, 30)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S908");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S909");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S910") + IntToString(RandRange(seed + 20, 5000000, 50000000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S911");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S912") + IntToString(RandRange(seed + 30, 3, 20)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S913") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S914") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S915")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S916") + (RandRange(seed + 50, 1, 100) <= 20 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S917") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S918"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T465");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T466");

        return data;
    }

    private static func GenerateMaxtacWashout(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S919");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T467");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S920") + KdspRareNPCManager.GetMaxtacDischarge(seed) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S921") + IntToString(RandRange(seed + 10, 2, 12)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S922") + IntToString(RandRange(seed + 20, 5, 50)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S923");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S924") + IntToString(RandRange(seed + 30, 10, 100)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S925") + IntToString(RandRange(seed + 40, 50, 85)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S926") + (RandRange(seed + 50, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S927") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S928"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T468");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T469");

        return data;
    }

    private static func GetMaxtacDischarge(seed: Int32) -> String {
        let i = RandRange(seed, 0, 5);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T470"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S929"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S930"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S931"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S932"); }
        return GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T471");
    }

    private static func GenerateProxyVoter(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S933");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T472");

        let votes = IntToString(RandRange(seed, 5, 50));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S934") + votes + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S935");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S204") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S936") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S937")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S938") + IntToString(RandRange(seed + 20, 10000, 100000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S939") + IntToString(RandRange(seed + 30, 50, 500)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S940");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S941") + IntToString(RandRange(seed + 40, 2069, 2075)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S942") + IntToString(RandRange(seed + 50, 2, 6)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S943");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S944");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T473");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T474");

        return data;
    }

    private static func GenerateGeneticChimera(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S945");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T475");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S946");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S947");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S491") + (RandRange(seed, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S948") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S949")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S950");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S951") + (RandRange(seed + 10, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S952") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S953")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S954") + (RandRange(seed + 20, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S955") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S956")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S957");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T476");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T477");

        return data;
    }

    private static func GenerateDarkNetLegend(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S958");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T70");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T478");

        let handles: array<String>;
        ArrayPush(handles, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T479"));
        ArrayPush(handles, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T480"));
        ArrayPush(handles, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T481"));
        ArrayPush(handles, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T482"));
        ArrayPush(handles, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T483"));
        ArrayPush(handles, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T484"));

        let handle = handles[RandRange(seed, 0, ArraySize(handles) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S959") + handle + "'. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S960") + IntToString(RandRange(seed + 10, 5, 15)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S961") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S962") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S963")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S964");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S965") + IntToString(RandRange(seed + 30, 1000, 50000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S966") + IntToString(RandRange(seed + 40, 10000000, 100000000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S967");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T485");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T486");

        return data;
    }

    private static func GenerateCargoStowaway(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S968");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T487");

        let origins: array<String>;
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S969"));
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T488"));
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S970"));
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S971"));
        ArrayPush(origins, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S972"));

        let origin = origins[RandRange(seed, 0, ArraySize(origins) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S973") + origin + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S974") + IntToString(RandRange(seed + 10, 1, 10)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S249");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S975");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S976") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S977") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S978")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S979") + IntToString(RandRange(seed + 30, 10000, 200000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S980") + (RandRange(seed + 40, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T489") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T490")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S981") + (RandRange(seed + 50, 1, 100) <= 30 ? "HIGH" : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S982"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T491");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T492");

        return data;
    }

    private static func GenerateChronoDisplaced(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S983");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T493");

        let frozenYear = IntToString(RandRange(seed, 2020, 2050));
        let revived = IntToString(RandRange(seed + 10, 2072, 2076));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S984") + frozenYear + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S985") + revived + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S986") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S987") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S988")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S989") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S990") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S991")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S992");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S993") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T494") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T495")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S994") + (RandRange(seed + 50, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S995") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S996")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S997");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T496");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T492");

        return data;
    }

    private static func GenerateSoulSplit(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S998");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T28");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T497");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S999");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1000") + IntToString(RandRange(seed, 2, 4)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1001");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1002") + IntToString(RandRange(seed + 10, 10, 60)) + "%. ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1003");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1004") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1005") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1006")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1007") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T498") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1008")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1009");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T499");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T500");

        return data;
    }

    private static func GenerateInfectedFirmware(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1010");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T501");

        let implants = IntToString(RandRange(seed, 1, 5));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T502") + implants + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1011");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1012") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1013") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1014")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1015") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T503") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1016")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1017");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1018") + IntToString(RandRange(seed + 30, 1000, 50000)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1019");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1020");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1021") + IntToString(RandRange(seed + 40, 0, 5)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1022");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T504");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T505");

        return data;
    }

    private static func GenerateWetworkRetired(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1023");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T8");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T506");

        let kills = IntToString(RandRange(seed, 20, 200));

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1024");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1025") + kills + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1026") + IntToString(RandRange(seed + 10, 5, 25)) + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1027") + (RandRange(seed + 20, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T507") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T508")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1028") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1029") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1030")) + ".";

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1031");
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T509") + (RandRange(seed + 40, 1, 100) <= 60 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T510") : "UNKNOWN") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1032") + (RandRange(seed + 50, 1, 100) <= 70 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T511") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1033"));

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T512");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T513");

        return data;
    }

    private static func GenerateChildSoldierGrown(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1034");
        data.flagColor = "GOLD";
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T514");

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
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1043") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T515") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T516")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1044");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1045") + (RandRange(seed + 40, 1, 100) <= 70 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1046") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1047")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1048") + (RandRange(seed + 50, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1049") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T517")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1050");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T518");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T519");

        return data;
    }

    private static func GenerateIllegalProcreation(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1051");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T49");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T520");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1052");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1053");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1054");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1055");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1056") + IntToString(RandRange(seed, 500, 5000)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1057") + (RandRange(seed + 10, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1058") : "UNKNOWN") + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1059") + (RandRange(seed + 20, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1060") : "NONE");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T521");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T522");

        return data;
    }

    private static func GenerateOrbitalReturnee(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1061");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T34");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T523");

        let years = IntToString(RandRange(seed, 2, 20));
        let stations: array<String>;
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T524"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1062"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1063"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1064"));
        ArrayPush(stations, GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1065"));

        let station = stations[RandRange(seed + 10, 0, ArraySize(stations) - 1)];

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1066") + station + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1067") + years + GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S6");
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1068") + (RandRange(seed + 20, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T525") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1069")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1070") + (RandRange(seed + 30, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1071") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T93")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1072");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1073") + (RandRange(seed + 40, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T372") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1074")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1075") + (RandRange(seed + 50, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1076") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T13")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1077");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T526");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T527");

        return data;
    }

    private static func GenerateCorpoDebtSlave(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1078");
        data.flagColor = GetLocalizedTextByKey(n"Kdsp-PsychProfileMa-T47");
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T528");

        data.description = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1079") + (RandRange(seed, 1, 100) <= 50 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T529") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T530")) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1080") + IntToString(RandRange(seed + 10, 100000, 5000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1081") + IntToString(RandRange(seed + 20, 5000000, 100000000)) + ". ";
        data.description += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1082");

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1083") + IntToString(RandRange(seed + 30, 2, 4)) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1084") + IntToString(RandRange(seed + 40, 40, 80)) + "%. ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1085");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T531");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T532");

        return data;
    }

    private static func GenerateGhostTownSurvivor(seed: Int32, data: ref<KdspRareNPCData>) -> ref<KdspRareNPCData> {
        data.displayFlag = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1086");
        data.flagColor = "GOLD";
        data.secretAffiliation = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T533");

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

        data.hiddenInfo = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1098") + (RandRange(seed + 30, 1, 100) <= 40 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T534") : GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1099")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1100") + (RandRange(seed + 40, 1, 100) <= 30 ? GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1101") : GetLocalizedTextByKey(n"Kdsp-DatabaseSource-T44")) + ". ";
        data.hiddenInfo += GetLocalizedTextByKey(n"Kdsp-RareNPCManager-S1102");

        data.scannerWarning = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T535");
        data.dangerLevel = GetLocalizedTextByKey(n"Kdsp-RareNPCManager-T536");

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
