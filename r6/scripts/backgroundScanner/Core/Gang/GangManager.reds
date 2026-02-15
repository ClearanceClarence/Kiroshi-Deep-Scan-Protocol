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
        if Equals(affiliation, "TYGER_CLAWS") { return "Tyger Claws"; }
        if Equals(affiliation, "MAELSTROM") { return "Maelstrom"; }
        if Equals(affiliation, "VALENTINOS") { return "Valentinos"; }
        if Equals(affiliation, "6TH_STREET") { return "6th Street"; }
        if Equals(affiliation, "ANIMALS") { return "Animals"; }
        if Equals(affiliation, "VOODOO_BOYS") { return "Voodoo Boys"; }
        if Equals(affiliation, "MOXES") { return "The Moxes"; }
        if Equals(affiliation, "SCAVENGERS") { return "Scavengers"; }
        if Equals(affiliation, "WRAITHS") { return "Wraiths"; }
        if Equals(affiliation, "ALDECALDOS") { return "Aldecaldos"; }
        if Equals(affiliation, "BARGHEST") { return "Barghest Militia"; }
        return "Unknown Gang";
    }

    private static func GetGangTerritory(affiliation: String) -> String {
        if Equals(affiliation, "TYGER_CLAWS") { return "Westbrook (Japantown), Watson (Kabuki)"; }
        if Equals(affiliation, "MAELSTROM") { return "Watson (Northside, All Foods Plant)"; }
        if Equals(affiliation, "VALENTINOS") { return "Heywood (Vista del Rey, The Glen)"; }
        if Equals(affiliation, "6TH_STREET") { return "Santo Domingo (Arroyo, Rancho Coronado)"; }
        if Equals(affiliation, "ANIMALS") { return "Pacifica (Grand Imperial Mall)"; }
        if Equals(affiliation, "VOODOO_BOYS") { return "Pacifica (Coastview)"; }
        if Equals(affiliation, "MOXES") { return "Watson (Lizzie's Bar area)"; }
        if Equals(affiliation, "SCAVENGERS") { return "Various (Underground operations)"; }
        if Equals(affiliation, "WRAITHS") { return "Badlands (Highways, Fuel Stations)"; }
        if Equals(affiliation, "ALDECALDOS") { return "Badlands (Rocky Ridge Camp)"; }
        return "Unknown";
    }

    private static func GetGangLeadership(affiliation: String) -> String {
        if Equals(affiliation, "TYGER_CLAWS") { return "Multiple bosses under Arasaka protection"; }
        if Equals(affiliation, "MAELSTROM") { return "Royce (Current), formerly Brick"; }
        if Equals(affiliation, "VALENTINOS") { return "Gustavo Orta and local captains"; }
        if Equals(affiliation, "6TH_STREET") { return "Decentralized veteran leadership"; }
        if Equals(affiliation, "ANIMALS") { return "Sasquatch (Pacifica operations)"; }
        if Equals(affiliation, "VOODOO_BOYS") { return "Brigitte and the netrunner council"; }
        if Equals(affiliation, "MOXES") { return "Collective leadership, no single boss"; }
        if Equals(affiliation, "SCAVENGERS") { return "Cell-based, no central leadership"; }
        if Equals(affiliation, "WRAITHS") { return "Unknown warlord structure"; }
        if Equals(affiliation, "ALDECALDOS") { return "Saul Bright (Clan leader)"; }
        return "Unknown";
    }

    private static func GetGangActivities(affiliation: String) -> array<String> {
        let activities: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(activities, "Prostitution/Braindance");
            ArrayPush(activities, "Protection Rackets");
            ArrayPush(activities, "Gambling Operations");
            ArrayPush(activities, "Drug Distribution");
            ArrayPush(activities, "Human Trafficking");
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(activities, "Cyberware Theft");
            ArrayPush(activities, "Illegal Modifications");
            ArrayPush(activities, "Arms Dealing");
            ArrayPush(activities, "Kidnapping");
            ArrayPush(activities, "Organ Harvesting");
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(activities, "Drug Trade");
            ArrayPush(activities, "Car Theft");
            ArrayPush(activities, "Protection Rackets");
            ArrayPush(activities, "Contract Killing");
            ArrayPush(activities, "Honor-based Operations");
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(activities, "Arms Dealing");
            ArrayPush(activities, "Vigilante Justice");
            ArrayPush(activities, "Protection Services");
            ArrayPush(activities, "Military Equipment Trade");
            ArrayPush(activities, "Community Defense");
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(activities, "Muscle for Hire");
            ArrayPush(activities, "Underground Fighting");
            ArrayPush(activities, "Security Services");
            ArrayPush(activities, "Steroid Distribution");
            ArrayPush(activities, "Intimidation");
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(activities, "Netrunning");
            ArrayPush(activities, "Data Theft");
            ArrayPush(activities, "Blackmail");
            ArrayPush(activities, "AI Contact");
            ArrayPush(activities, "Information Brokering");
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(activities, "Sex Worker Protection");
            ArrayPush(activities, "Braindance Production");
            ArrayPush(activities, "Community Defense");
            ArrayPush(activities, "Anti-Trafficking");
        } else if Equals(affiliation, "SCAVENGERS") {
            ArrayPush(activities, "Organ Harvesting");
            ArrayPush(activities, "Cyberware Theft");
            ArrayPush(activities, "Kidnapping");
            ArrayPush(activities, "Black Market Surgery");
        } else if Equals(affiliation, "WRAITHS") {
            ArrayPush(activities, "Highway Robbery");
            ArrayPush(activities, "Vehicle Theft");
            ArrayPush(activities, "Smuggling");
            ArrayPush(activities, "Kidnapping");
        } else if Equals(affiliation, "ALDECALDOS") {
            ArrayPush(activities, "Smuggling");
            ArrayPush(activities, "Transport Services");
            ArrayPush(activities, "Mercenary Work");
            ArrayPush(activities, "Vehicle Modification");
        }

        return activities;
    }

    private static func GetGangAllies(affiliation: String) -> array<String> {
        let allies: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(allies, "Arasaka Corporation");
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(allies, "Militech (Informal)");
            ArrayPush(allies, "NUSA Veterans");
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(allies, "Local Heywood Community");
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(allies, "Lizzie's Bar Patrons");
        }

        if ArraySize(allies) == 0 {
            ArrayPush(allies, "None Documented");
        }

        return allies;
    }

    private static func GetGangEnemies(affiliation: String) -> array<String> {
        let enemies: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(enemies, "Maelstrom");
            ArrayPush(enemies, "Moxes");
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(enemies, "Tyger Claws");
            ArrayPush(enemies, "NCPD");
            ArrayPush(enemies, "Militech");
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(enemies, "6th Street");
            ArrayPush(enemies, "Animals");
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(enemies, "Valentinos");
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(enemies, "Voodoo Boys");
            ArrayPush(enemies, "Valentinos");
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(enemies, "NetWatch");
            ArrayPush(enemies, "Animals");
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(enemies, "Tyger Claws");
        } else if Equals(affiliation, "SCAVENGERS") {
            ArrayPush(enemies, "Everyone");
        } else if Equals(affiliation, "WRAITHS") {
            ArrayPush(enemies, "Aldecaldos");
            ArrayPush(enemies, "Other Nomad Clans");
        } else if Equals(affiliation, "ALDECALDOS") {
            ArrayPush(enemies, "Wraiths");
            ArrayPush(enemies, "Militech");
        }

        return enemies;
    }

    private static func GenerateMemberRank(seed: Int32, affiliation: String) -> String {
        let ranks: array<String>;

        // Standard hierarchy
        ArrayPush(ranks, "Street-level Member");
        ArrayPush(ranks, "Trusted Soldier");
        ArrayPush(ranks, "Enforcer");
        ArrayPush(ranks, "Lieutenant");
        ArrayPush(ranks, "Captain");

        // Weighted towards lower ranks
        let roll = RandRange(seed, 1, 100);
        if roll <= 40 { return ranks[0]; }
        if roll <= 70 { return ranks[1]; }
        if roll <= 85 { return ranks[2]; }
        if roll <= 95 { return ranks[3]; }
        return ranks[4];
    }

    private static func GenerateConfirmedKills(seed: Int32, rank: String) -> Int32 {
        if Equals(rank, "Street-level Member") { return RandRange(seed, 0, 2); }
        if Equals(rank, "Trusted Soldier") { return RandRange(seed, 0, 5); }
        if Equals(rank, "Enforcer") { return RandRange(seed, 2, 12); }
        if Equals(rank, "Lieutenant") { return RandRange(seed, 5, 20); }
        if Equals(rank, "Captain") { return RandRange(seed, 10, 35); }
        return 0;
    }

    private static func GenerateSpecialization(seed: Int32, affiliation: String) -> String {
        let specs: array<String>;

        if Equals(affiliation, "MAELSTROM") {
            ArrayPush(specs, "Cyberware Installation");
            ArrayPush(specs, "Heavy Weapons");
            ArrayPush(specs, "Intimidation");
            ArrayPush(specs, "Tech Specialist");
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(specs, "Netrunner");
            ArrayPush(specs, "Data Analysis");
            ArrayPush(specs, "Social Engineering");
            ArrayPush(specs, "Surveillance");
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(specs, "Close Combat");
            ArrayPush(specs, "Security");
            ArrayPush(specs, "Intimidation");
            ArrayPush(specs, "Training");
        } else {
            ArrayPush(specs, "Street Soldier");
            ArrayPush(specs, "Driver");
            ArrayPush(specs, "Lookout");
            ArrayPush(specs, "Dealer");
            ArrayPush(specs, "Enforcer");
            ArrayPush(specs, "Recruiter");
        }

        return specs[RandRange(seed, 0, ArraySize(specs) - 1)];
    }

    private static func GenerateLoyaltyRating(seed: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        if roll <= 20 { return "UNVERIFIED"; }
        if roll <= 50 { return "MODERATE"; }
        if roll <= 80 { return "HIGH"; }
        if roll <= 95 { return "BLOOD OATH"; }
        return "FANATIC";
    }

    private static func GenerateGangTattoos(seed: Int32, affiliation: String) -> array<String> {
        let tattoos: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            if RandRange(seed, 1, 100) <= 80 {
                ArrayPush(tattoos, "Luminous tiger stripes (back/arms)");
            }
            if RandRange(seed + 10, 1, 100) <= 60 {
                ArrayPush(tattoos, "Japanese kanji (neck)");
            }
        } else if Equals(affiliation, "VALENTINOS") {
            if RandRange(seed, 1, 100) <= 85 {
                ArrayPush(tattoos, "Santa Muerte imagery");
            }
            if RandRange(seed + 10, 1, 100) <= 70 {
                ArrayPush(tattoos, "Golden heart with thorns");
            }
        } else if Equals(affiliation, "MAELSTROM") {
            if RandRange(seed, 1, 100) <= 60 {
                ArrayPush(tattoos, "Circuitry patterns");
            }
            // Maelstrom prefers chrome to ink
        } else if Equals(affiliation, "6TH_STREET") {
            if RandRange(seed, 1, 100) <= 90 {
                ArrayPush(tattoos, "American flag imagery");
            }
            if RandRange(seed + 10, 1, 100) <= 70 {
                ArrayPush(tattoos, "Military unit insignia");
            }
        }

        if ArraySize(tattoos) == 0 {
            ArrayPush(tattoos, "Gang identification marks (various)");
        }

        return tattoos;
    }

    private static func GenerateKnownHangouts(seed: Int32, affiliation: String) -> array<String> {
        let hangouts: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(hangouts, "Dark Matter Club");
            ArrayPush(hangouts, "Japantown Pachinko Parlors");
            ArrayPush(hangouts, "Clouds");
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(hangouts, "El Coyote Cojo");
            ArrayPush(hangouts, "Vista del Rey Streets");
            ArrayPush(hangouts, "Local Churches");
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(hangouts, "Totentanz");
            ArrayPush(hangouts, "All Foods Plant");
            ArrayPush(hangouts, "Northside Warehouses");
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(hangouts, "Red Dirt Bar");
            ArrayPush(hangouts, "Arroyo Gun Ranges");
            ArrayPush(hangouts, "Veterans Meeting Halls");
        } else if Equals(affiliation, "MOXES") {
            ArrayPush(hangouts, "Lizzie's Bar");
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(hangouts, "Batty's Hotel");
            ArrayPush(hangouts, "Pacifica Chapel");
        }

        return hangouts;
    }

    private static func GenerateGangBackstory(seed: Int32, affiliation: String, rank: String) -> String {
        let backstories: array<String>;

        if Equals(affiliation, "TYGER_CLAWS") {
            ArrayPush(backstories, "Recruited from Japantown youth. Trained in traditional yakuza codes. ");
            ArrayPush(backstories, "Former Arasaka security, found better opportunities with the Claws. ");
            ArrayPush(backstories, "Born into a family with Tyger Claw ties. Expected to join. ");
        } else if Equals(affiliation, "VALENTINOS") {
            ArrayPush(backstories, "Grew up in Heywood, joined for family protection. Devotee of Santa Muerte. ");
            ArrayPush(backstories, "Third-generation Valentino. The gang is everything. ");
            ArrayPush(backstories, "Sought belonging after losing family. Found it with the Valentinos. ");
        } else if Equals(affiliation, "MAELSTROM") {
            ArrayPush(backstories, "Cyberpsychosis survivor. Found acceptance among the similarly augmented. ");
            ArrayPush(backstories, "Former corpo techie gone rogue. Now installs illegal chrome. ");
            ArrayPush(backstories, "Obsessed with transcending flesh. Maelstrom offered the path. ");
        } else if Equals(affiliation, "6TH_STREET") {
            ArrayPush(backstories, "Veteran of the Unification War. Couldn't adjust to civilian life. ");
            ArrayPush(backstories, "Believes in protecting the community from corp exploitation. ");
            ArrayPush(backstories, "Lost family to gang violence. Joined 6th Street for revenge and order. ");
        } else if Equals(affiliation, "ANIMALS") {
            ArrayPush(backstories, "Former athlete turned muscle. The juice keeps flowing. ");
            ArrayPush(backstories, "Respects only strength. Animals offer the ultimate test. ");
        } else if Equals(affiliation, "VOODOO_BOYS") {
            ArrayPush(backstories, "Haitian descent, grew up in Pacifica. The Net is the only way forward. ");
            ArrayPush(backstories, "Netrunner seeking answers beyond the Blackwall. ");
        }

        if ArraySize(backstories) == 0 {
            return "Gang member with standard recruitment background. ";
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
