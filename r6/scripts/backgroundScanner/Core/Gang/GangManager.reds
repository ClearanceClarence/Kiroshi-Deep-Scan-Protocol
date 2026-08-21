// Gang Detection and Management System
public class KdspGangManager {

    public static func DetectGangAffiliation(appearanceName: String, district: String) -> String {
        // Check appearance name for gang indicators
        if StrContains(appearanceName, "tyger") || StrContains(appearanceName, "tiger") {
            return "TYGER_CLAWS";
        }
        if StrContains(appearanceName, "maelstrom") {
            return "MAELSTROM";
        }
        if StrContains(appearanceName, "valentino") {
            return "VALENTINOS";
        }
        if StrContains(appearanceName, "6th") || StrContains(appearanceName, "sixth") {
            return "6TH_STREET";
        }
        if StrContains(appearanceName, "animal") {
            return "ANIMALS";
        }
        if StrContains(appearanceName, "voodoo") || StrContains(appearanceName, "vdb") {
            return "VOODOO_BOYS";
        }
        if StrContains(appearanceName, "mox") || StrContains(appearanceName, "moxes") {
            return "MOXES";
        }
        if StrContains(appearanceName, "scav") {
            return "SCAVENGERS";
        }
        if StrContains(appearanceName, "wraith") {
            return "WRAITHS";
        }
        if StrContains(appearanceName, "aldecaldo") {
            return "ALDECALDOS";
        }
        // Barghest - Dogtown militia (Kurt Hansen's army)
        if StrContains(appearanceName, "barghest") || StrContains(appearanceName, "kurtz") {
            return "BARGHEST";
        }

        return "NONE";
    }

    public static func GenerateGangProfile(seed: Int32, gangAffiliation: String) -> ref<KdspGangProfileData> {
        let profile: ref<KdspGangProfileData> = new KdspGangProfileData();
        
        profile.gangName = KdspGangManager.GetFullGangName(gangAffiliation);
        profile.gangAffiliation = gangAffiliation;
        profile.territory = KdspGangManager.GetGangTerritory(gangAffiliation);
        profile.leadership = KdspGangManager.GetGangLeadership(gangAffiliation);
        profile.activities = KdspGangManager.GetGangActivities(gangAffiliation);
        profile.allies = KdspGangManager.GetGangAllies(gangAffiliation);
        profile.enemies = KdspGangManager.GetGangEnemies(gangAffiliation);
        
        // Member-specific info
        profile.memberRank = KdspGangManager.GenerateMemberRank(seed, gangAffiliation);
        profile.joinYear = RandRange(seed + 100, 2065, 2077);
        profile.confirmedKills = KdspGangManager.GenerateConfirmedKills(seed + 200, profile.memberRank);
        profile.specialization = KdspGangManager.GenerateSpecialization(seed + 300, gangAffiliation);
        profile.loyaltyRating = KdspGangManager.GenerateLoyaltyRating(seed + 400);
        profile.gangTattoos = KdspGangManager.GenerateGangTattoos(seed + 500, gangAffiliation);
        profile.knownHangouts = KdspGangManager.GenerateKnownHangouts(seed + 600, gangAffiliation);

        // Generate gang-specific backstory elements
        profile.gangBackstory = KdspGangManager.GenerateGangBackstory(seed + 700, gangAffiliation, profile.memberRank);

        return profile;
    }

    private static func GetFullGangName(affiliation: String) -> String {
        if Equals(affiliation, "TYGER_CLAWS") { return GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation"); }
        if Equals(affiliation, "MAELSTROM") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U0"); }
        if Equals(affiliation, "VALENTINOS") { return GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U11"); }
        if Equals(affiliation, "6TH_STREET") { return GetLocalizedTextByKey(n"Kdsp-Shared-C33"); }
        if Equals(affiliation, "ANIMALS") { return GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Affiliation"); }
        if Equals(affiliation, "VOODOO_BOYS") { return GetLocalizedTextByKey(n"Kdsp-Shared-C48"); }
        if Equals(affiliation, "MOXES") { return GetLocalizedTextByKey(n"Kdsp-Shared-C40"); }
        if Equals(affiliation, "SCAVENGERS") { return GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-Affiliation"); }
        if Equals(affiliation, "WRAITHS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U1"); }
        if Equals(affiliation, "ALDECALDOS") { return GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-U0"); }
        if Equals(affiliation, "BARGHEST") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U2"); }
        return GetLocalizedTextByKey(n"Kdsp-GangManager-T0");
    }

    private static func GetGangTerritory(affiliation: String) -> String {
        if Equals(affiliation, "TYGER_CLAWS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U3"); }
        if Equals(affiliation, "MAELSTROM") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U4"); }
        if Equals(affiliation, "VALENTINOS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U5"); }
        if Equals(affiliation, "6TH_STREET") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U6"); }
        if Equals(affiliation, "ANIMALS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U7"); }
        if Equals(affiliation, "VOODOO_BOYS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U8"); }
        if Equals(affiliation, "MOXES") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U9"); }
        if Equals(affiliation, "SCAVENGERS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U10"); }
        if Equals(affiliation, "WRAITHS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U11"); }
        if Equals(affiliation, "ALDECALDOS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U12"); }
        return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14");
    }

    private static func GetGangLeadership(affiliation: String) -> String {
        if Equals(affiliation, "TYGER_CLAWS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U13"); }
        if Equals(affiliation, "MAELSTROM") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U14"); }
        if Equals(affiliation, "VALENTINOS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U15"); }
        if Equals(affiliation, "6TH_STREET") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U16"); }
        if Equals(affiliation, "ANIMALS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U17"); }
        if Equals(affiliation, "VOODOO_BOYS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U18"); }
        if Equals(affiliation, "MOXES") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U19"); }
        if Equals(affiliation, "SCAVENGERS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U20"); }
        if Equals(affiliation, "WRAITHS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U21"); }
        if Equals(affiliation, "ALDECALDOS") { return GetLocalizedTextByKey(n"Kdsp-GangManager-U22"); }
        return GetLocalizedTextByKey(n"Kdsp-EthnicityDetec-T14");
    }

    private static func GetGangActivities(affiliation: String) -> array<String> {
        let activities: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-U23"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T1"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T2"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T3"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T4"));
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C43"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T5"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C52"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T6"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C46"));
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C49"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T7"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T1"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T8"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T9"));
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C52"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T10"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T11"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-S0"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T12"));
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-S0"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T11"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T13"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-AnimalsProfile-T13"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T14"));
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-U24"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T15"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T16"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T17"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T18"));
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-S1"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T19"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T12"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T20"));
        } else if Equals(affiliation, "SCAVENGERS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C46"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C43"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T6"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-S2"));
        } else if Equals(affiliation, "WRAITHS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-Shared-C51"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T21"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-U25"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T6"));
        } else if Equals(affiliation, "ALDECALDOS") {
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-U25"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T22"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T23"));
            ArrayPush(activities, GetLocalizedTextByKey(n"Kdsp-GangManager-T24"));
        }

        return activities;
    }

    private static func GetGangAllies(affiliation: String) -> array<String> {
        let allies: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(allies, GetLocalizedTextByKey(n"Kdsp-Shared-C6"));
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(allies, GetLocalizedTextByKey(n"Kdsp-Shared-C39"));
            ArrayPush(allies, GetLocalizedTextByKey(n"Kdsp-GangManager-T25"));
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(allies, GetLocalizedTextByKey(n"Kdsp-GangManager-S3"));
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(allies, GetLocalizedTextByKey(n"Kdsp-GangManager-S4"));
        }

        if ArraySize(allies) == 0 {
            ArrayPush(allies, GetLocalizedTextByKey(n"Kdsp-GangManager-T26"));
        }

        return allies;
    }

    private static func GetGangEnemies(affiliation: String) -> array<String> {
        let enemies: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-GangManager-U0"));
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-GangManager-U26"));
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation"));
            ArrayPush(enemies, "NCPD");
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Corpo-MILITECH"));
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Shared-C33"));
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Affiliation"));
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U11"));
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Shared-C48"));
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-CrowdDistrictM-U11"));
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Corpo-NETWATCH"));
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Affiliation"));
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation"));
        } else if Equals(affiliation, "SCAVENGERS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-GangManager-U27"));
        } else if Equals(affiliation, "WRAITHS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-U0"));
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-GangManager-S5"));
        } else if Equals(affiliation, "ALDECALDOS") {
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-GangManager-U1"));
            ArrayPush(enemies, GetLocalizedTextByKey(n"Kdsp-Corpo-MILITECH"));
        }

        return enemies;
    }

    private static func GenerateMemberRank(seed: Int32, affiliation: String) -> String {
        let ranks: array<String>;

        // Standard hierarchy
        ArrayPush(ranks, GetLocalizedTextByKey(n"Kdsp-Shared-C50"));
        ArrayPush(ranks, GetLocalizedTextByKey(n"Kdsp-Shared-C44"));
        ArrayPush(ranks, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-U2"));
        ArrayPush(ranks, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U3"));
        ArrayPush(ranks, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U2"));

        // Weighted towards lower ranks
        let roll = RandRange(seed, 1, 100);
        if roll <= 40 { return ranks[0]; }
        if roll <= 70 { return ranks[1]; }
        if roll <= 85 { return ranks[2]; }
        if roll <= 95 { return ranks[3]; }
        return ranks[4];
    }

    private static func GenerateConfirmedKills(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C50")) { return RandRange(seed, 0, 2); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-Shared-C44")) { return RandRange(seed, 0, 5); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-U2")) { return RandRange(seed, 2, 12); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U3")) { return RandRange(seed, 5, 20); }
        if Equals(rank, GetLocalizedTextByKey(n"Kdsp-BarghestProfil-U2")) { return RandRange(seed, 10, 35); }
        return 0;
    }

    private static func GenerateSpecialization(seed: Int32, affiliation: String) -> String {
        let specs: array<String>;

        if Equals(affiliation, "MAELSTROM") {
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C42"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T27"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T14"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-AldecaldosProf-T24"));
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-U28"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T28"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T29"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T30"));
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-Shared-C37"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T31"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T14"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T32"));
        } else {
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-T107"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T33"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T34"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T35"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-CriminalRecord-U2"));
            ArrayPush(specs, GetLocalizedTextByKey(n"Kdsp-GangManager-T36"));
        }

        return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
    }

    private static func GenerateLoyaltyRating(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 20 { return GetLocalizedTextByKey(n"Kdsp-GangManager-V0"); }
        if roll <= 50 { return GetLocalizedTextByKey(n"Kdsp-DatabaseSource-V10"); }
        if roll <= 80 { return "HIGH"; }
        if roll <= 95 { return GetLocalizedTextByKey(n"Kdsp-GangManager-T38"); }
        return GetLocalizedTextByKey(n"Kdsp-GangManager-V1");
    }

    private static func GenerateGangTattoos(seed: Int32, affiliation: String) -> array<String> {
        let tattoos: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            if RandRange(seed, 1, 100) <= 80 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S6"));
            }
            if RandRange(seed + 10, 1, 100) <= 60 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S7"));
            }
        } else if Equals(affiliation, "VALENTINOS") {
            if RandRange(seed, 1, 100) <= 85 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S8"));
            }
            if RandRange(seed + 10, 1, 100) <= 70 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S9"));
            }
        } else if Equals(affiliation, "MAELSTROM") {
            if RandRange(seed, 1, 100) <= 60 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-Shared-C41"));
            }
            // Maelstrom prefers chrome to ink
        } else if Equals(affiliation, "6TH_STREET") {
            if RandRange(seed, 1, 100) <= 90 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S10"));
            }
            if RandRange(seed + 10, 1, 100) <= 70 {
                ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S11"));
            }
        }

        if ArraySize(tattoos) == 0 {
            ArrayPush(tattoos, GetLocalizedTextByKey(n"Kdsp-GangManager-S12"));
        }

        return tattoos;
    }

    private static func GenerateKnownHangouts(seed: Int32, affiliation: String) -> array<String> {
        let hangouts: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S13"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S14"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-T40"));
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S15"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S16"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-T41"));
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-U29"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S17"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-T42"));
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S18"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S19"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-S20"));
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-Shared-C45"));
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-Shared-C47"));
            ArrayPush(hangouts, GetLocalizedTextByKey(n"Kdsp-GangManager-T43"));
        }

        return hangouts;
    }

    private static func GenerateGangBackstory(seed: Int32, affiliation: String, rank: String) -> String {
        let backstories: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S21"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S22"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S23"));
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S24"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S25"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S26"));
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S27"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S28"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S29"));
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S30"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S31"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S32"));
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S33"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S34"));
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S35"));
            ArrayPush(backstories, GetLocalizedTextByKey(n"Kdsp-GangManager-S36"));
        }

        if ArraySize(backstories) == 0 {
            return GetLocalizedTextByKey(n"Kdsp-GangManager-S37");
        }

        return backstories[RandRange(seed, 0, ArraySize(backstories) - 1)];
    }
}

public class KdspGangProfileData {
    public let gangName: String;
    public let gangAffiliation: String;
    public let territory: String;
    public let leadership: String;
    public let activities: array<String>;
    public let allies: array<String>;
    public let enemies: array<String>;
    public let memberRank: String;
    public let joinYear: Int32;
    public let confirmedKills: Int32;
    public let specialization: String;
    public let loyaltyRating: String;
    public let gangTattoos: array<String>;
    public let knownHangouts: array<String>;
    public let gangBackstory: String;
}
