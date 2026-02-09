// Kiroshi Deep Scan Protocol - Unique NPC Entries v1.5

public abstract class QuestProgressHelper {
    public static func IsFactSet(factName: CName) -> Bool {
        let qs = GameInstance.GetQuestsSystem(GetGameInstance());
        return IsDefined(qs) && qs.GetFact(factName) > 0;
    }
    public static func IsHeistCompleted() -> Bool {
        return QuestProgressHelper.IsFactSet(n"q005_done") || QuestProgressHelper.IsFactSet(n"q101_started");
    }
    public static func IsEvelynDead() -> Bool { return QuestProgressHelper.IsFactSet(n"q109_done"); }
    public static func IsRhyneDead() -> Bool { return QuestProgressHelper.IsFactSet(n"sq026_done"); }
}

public abstract class UniqueNPCEntries {

    public static func GetEntry(recordId: String) -> ref<UniqueNPCBackstory> {
        let id = StrLower(recordId);
        
        // ARASAKA
        if StrContains(id, "takemura") { return UniqueNPCEntries.Takemura(); }
        if StrContains(id, "saburo") && !StrContains(id, "guard") { return UniqueNPCEntries.SaburoArasaka(); }
        if StrContains(id, "yorinobu") && !StrContains(id, "guard") { return UniqueNPCEntries.YorinobuArasaka(); }
        if StrContains(id, "hanako") && !StrContains(id, "guard") && !StrContains(id, "bodyguard") { return UniqueNPCEntries.HanakoArasaka(); }
        if StrContains(id, "oda") { return UniqueNPCEntries.SandayuOda(); }
        if StrContains(id, "smasher") { return UniqueNPCEntries.AdamSmasher(); }
        if StrContains(id, "hellman") { return UniqueNPCEntries.AndersHellman(); }
        // MILITECH
        if StrContains(id, "meredith") { return UniqueNPCEntries.MeredithStout(); }
        if StrContains(id, "holt") { return UniqueNPCEntries.WeldonHolt(); }
        // FIXERS
        if StrContains(id, "dex") || StrContains(id, "deshawn") { return UniqueNPCEntries.DexterDeShawn(); }
        if StrContains(id, "wakako") { return UniqueNPCEntries.WakakoOkada(); }
        if StrContains(id, "regina") { return UniqueNPCEntries.ReginaJones(); }
        if StrContains(id, "padre") { return UniqueNPCEntries.Padre(); }
        if StrContains(id, "dakota") { return UniqueNPCEntries.DakotaSmith(); }
        if StrContains(id, "dino") { return UniqueNPCEntries.DinoDinovic(); }
        if StrContains(id, "hands") { return UniqueNPCEntries.MrHands(); }
        if (StrContains(id, "capitan") || StrContains(id, "muamar")) && !StrContains(id, "driver") { return UniqueNPCEntries.ElCapitan(); }
        // MERCS / AFTERLIFE
        if StrContains(id, "jackie") { return UniqueNPCEntries.JackieWelles(); }
        if StrContains(id, "emmerick") || StrContains(id, "bronson") { return UniqueNPCEntries.EmmerickBronson(); }
        if StrContains(id, "tbug") || StrContains(id, "t_bug") { return UniqueNPCEntries.TBug(); }
        if StrContains(id, "rogue") { return UniqueNPCEntries.RogueAmendiares(); }
        if StrContains(id, "squama") || StrContains(id, "crispin") || StrContains(id, "weyland") { return UniqueNPCEntries.CrispinWeyland(); }
        if StrContains(id, "johnny") || StrContains(id, "silverhand") { return UniqueNPCEntries.JohnnySilverhand(); }
        if StrContains(id, "kerry") { return UniqueNPCEntries.KerryEurodyne(); }
        if StrContains(id, "alt") && StrContains(id, "cunningham") { return UniqueNPCEntries.AltCunningham(); }
        if StrContains(id, "claire") { return UniqueNPCEntries.ClaireRussell(); }
        // RIPPERDOCS
        if StrContains(id, "viktor") || StrContains(id, "vektor") { return UniqueNPCEntries.ViktorVektor(); }
        if StrContains(id, "finger") { return UniqueNPCEntries.Fingers(); }
        if StrContains(id, "misty") { return UniqueNPCEntries.MistyOlszewski(); }
        // MOX / CLOUDS
        if StrContains(id, "judy") { return UniqueNPCEntries.JudyAlvarez(); }
        if StrContains(id, "evelyn") { return UniqueNPCEntries.EvelynParker(); }
        if StrContains(id, "maiko") { return UniqueNPCEntries.MaikoMaeda(); }
        if StrContains(id, "woodman") { return UniqueNPCEntries.Woodman(); }
        // ALDECALDOS
        if StrContains(id, "panam") { return UniqueNPCEntries.PanamPalmer(); }
        if StrContains(id, "saul") { return UniqueNPCEntries.SaulBright(); }
        if StrContains(id, "mitch") { return UniqueNPCEntries.MitchAnderson(); }
        // VOODOO BOYS
        if StrContains(id, "brigitte") { return UniqueNPCEntries.Brigitte(); }
        if StrContains(id, "placide") { return UniqueNPCEntries.Placide(); }
        // MAELSTROM
        if StrContains(id, "royce") { return UniqueNPCEntries.Royce(); }
        if StrContains(id, "dum") { return UniqueNPCEntries.DumDum(); }
        if StrContains(id, "brick") { return UniqueNPCEntries.Brick(); }
        // NCPD / POLITICS
        if StrContains(id, "river") && StrContains(id, "ward") { return UniqueNPCEntries.RiverWard(); }
        if StrContains(id, "peralez") { return UniqueNPCEntries.JeffersonPeralez(); }
        if StrContains(id, "rhyne") { return UniqueNPCEntries.LuciusRhyne(); }
        // OTHER
        if StrContains(id, "nibbles") || StrContains(id, "_cat") || StrContains(id, "feline") { return UniqueNPCEntries.Nibbles(); }
        if StrContains(id, "delamain") { return UniqueNPCEntries.Delamain(); }
        if StrContains(id, "mama") && StrContains(id, "welles") { return UniqueNPCEntries.MamaWelles(); }
        // TYGER CLAWS
        if StrContains(id, "jotaro") || StrContains(id, "shobo") { return UniqueNPCEntries.JotaroShobo(); }
        if StrContains(id, "hiromi") && StrContains(id, "sato") { return UniqueNPCEntries.HiromiSato(); }
        // VALENTINOS
        if StrContains(id, "gustavo") || StrContains(id, "orta") { return UniqueNPCEntries.GustavoOrta(); }
        if StrContains(id, "jose") && StrContains(id, "luis") { return UniqueNPCEntries.JoseLuis(); }
        // ANIMALS
        if StrContains(id, "sasquatch") { return UniqueNPCEntries.Sasquatch(); }
        // WRAITHS
        if StrContains(id, "nash") { return UniqueNPCEntries.Nash(); }
        // SCAVENGERS
        if StrContains(id, "anton") && StrContains(id, "kolos") { return UniqueNPCEntries.AntonKolos(); }
        // NETWATCH
        if StrContains(id, "bryce") && StrContains(id, "mosley") { return UniqueNPCEntries.BryceMosley(); }
        // MEDIA
        if StrContains(id, "gillean") || (StrContains(id, "jordan") && StrContains(id, "n54")) { return UniqueNPCEntries.GilleanJordan(); }
        if StrContains(id, "max") && StrContains(id, "jones") { return UniqueNPCEntries.MaxJones(); }
        // CORPO SECURITY
        if StrContains(id, "graham") { return UniqueNPCEntries.GrahamMayfield(); }
        if StrContains(id, "militech") && StrContains(id, "commander") { return UniqueNPCEntries.MilitechCommander(); }
        // RIPPERDOCS
        if StrContains(id, "charles") && StrContains(id, "bucks") { return UniqueNPCEntries.CharlesBucks(); }
        if StrContains(id, "robert") && StrContains(id, "bodean") { return UniqueNPCEntries.RobertBodean(); }
        if StrContains(id, "cassius") && StrContains(id, "ryder") { return UniqueNPCEntries.CassiusRyder(); }
        if StrContains(id, "octavio") && StrContains(id, "ruiz") { return UniqueNPCEntries.OctavioRuiz(); }
        // VENDORS
        if StrContains(id, "wilson") { return UniqueNPCEntries.Wilson(); }
        if StrContains(id, "coach") && StrContains(id, "fred") { return UniqueNPCEntries.CoachFred(); }
        // BARTENDERS
        if StrContains(id, "emmerick") || StrContains(id, "bronson") { return UniqueNPCEntries.EmmerickBronson(); }
        if StrContains(id, "nix") { return UniqueNPCEntries.Nix(); }
        // OTHER CHARACTERS
        if StrContains(id, "brendan") { return UniqueNPCEntries.Brendan(); }
        if StrContains(id, "barry") { return UniqueNPCEntries.Barry(); }
        if StrContains(id, "joshua") && StrContains(id, "stephenson") { return UniqueNPCEntries.JoshuaStephenson(); }
        if StrContains(id, "blue") && StrContains(id, "moon") { return UniqueNPCEntries.BlueMoon(); }
        if StrContains(id, "lizzy") && StrContains(id, "wizzy") { return UniqueNPCEntries.LizzyWizzy(); }
        if StrContains(id, "ozob") { return UniqueNPCEntries.Ozob(); }
        if StrContains(id, "skippy") { return UniqueNPCEntries.Skippy(); }
        if StrContains(id, "brendan") { return UniqueNPCEntries.Brendan(); }
        if StrContains(id, "jacobs") || (StrContains(id, "maman") && StrContains(id, "brigitte")) { return UniqueNPCEntries.Brigitte(); }
        // PHANTOM LIBERTY
        if StrContains(id, "songbird") || StrContains(id, "song_so_mi") || StrContains(id, "so_mi") { return UniqueNPCEntries.Songbird(); }
        if (StrContains(id, "solomon") && StrContains(id, "reed")) || (StrContains(id, "reed") && !StrContains(id, "gang") && !StrContains(id, "soldier") && !StrContains(id, "grunt")) { return UniqueNPCEntries.SolomonReed(); }
        if StrContains(id, "myers") && StrContains(id, "president") { return UniqueNPCEntries.RosalindMyers(); }
        if StrContains(id, "kurt") && StrContains(id, "hansen") { return UniqueNPCEntries.KurtHansen(); }
        if StrContains(id, "alex") && !StrContains(id, "pushkin") && !StrContains(id, "ander") { return UniqueNPCEntries.Alex(); }
        // BODYGUARDS - Generic entries for named character bodyguards
        if StrContains(id, "hanako") && (StrContains(id, "guard") || StrContains(id, "bodyguard")) { return UniqueNPCEntries.HanakoBodyguard(); }
        if StrContains(id, "arasaka") && (StrContains(id, "guard") || StrContains(id, "bodyguard")) { return UniqueNPCEntries.ArasakaBodyguard(); }
        return null;
    }

    // === BODYGUARD ENTRIES ===
    public static func HanakoBodyguard() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("hanako_bodyguard").SetClassification("ARASAKA - PERSONAL SECURITY")
            .SetBackground("Elite Arasaka operative assigned to Hanako Arasaka's protective detail. Vetted through extensive background checks and loyalty conditioning.")
            .SetAffiliation("Arasaka | Personal Security Division")
            .SetCyberwareStatus("Military-grade combat implants | Sandevistan | Kerenzikov | Encrypted comms")
            .SetThreatAssessment("HIGH (78/100) | Advanced combat training | Will protect principal at all costs")
            .SetNotes("Part of multi-layer security detail. Reports directly to Oda. Trained to die for the Arasaka family.");
    }

    public static func ArasakaBodyguard() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("arasaka_bodyguard").SetClassification("ARASAKA - SECURITY")
            .SetBackground("Professional Arasaka security operative. Recruited from military or law enforcement backgrounds.")
            .SetAffiliation("Arasaka | Corporate Security Division")
            .SetCyberwareStatus("Standard corporate security package | Combat optics | Reinforced skeleton")
            .SetThreatAssessment("MODERATE-HIGH (65/100) | Professional training | Coordinated tactics")
            .SetNotes("Well-equipped and trained. Works in coordinated teams. Full corporate backing.");
    }

    // === TAKEMURA (DYNAMIC) ===
    public static func Takemura() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsHeistCompleted() {
            return UniqueNPCBackstory.Create("takemura").SetClassification("ARASAKA - DISAVOWED")
                .SetBackground("Born Chiba-11, Tokyo. Father worked in kitchen. Selected by Arasaka military as child.")
                .SetEarlyLife("Rose to special forces. Graduated top of Arasaka Academy. Served as Saburo Arasaka's bodyguard for decades. Trained Sandayu Oda.")
                .SetSignificantEvents("DISAVOWED following Saburo's death at Konpeki Plaza. Operating as fugitive. Seeking to expose truth.")
                .SetAffiliation("Arasaka (Former) | Status: KILL ON SIGHT")
                .SetCriminalRecord("Arasaka Corporate: MOST WANTED")
                .SetCyberwareStatus("Cyberoptics (Custom) | Subdermal Armor | Kerenzikov | Endoskeleton")
                .SetFinancialStatus("Accounts FROZEN | Operating with minimal resources")
                .SetMedicalStatus("No corporate support | Field status: ACTIVE")
                .SetThreatAssessment("EXTREME (95/100) | TIER-1 SOLO")
                .SetRelationships("Saburo (Deceased) | Hanako (Contact) | Oda (Estranged)")
                .SetNotes("High-priority target. Possesses classified intel. Will not surrender.");
        }
        return UniqueNPCBackstory.Create("takemura").SetClassification("ARASAKA - PERSONAL SECURITY")
            .SetBackground("Born Chiba-11, Tokyo. Father worked in kitchen. Selected by Arasaka military as child.")
            .SetEarlyLife("Rose to special forces. Graduated top of Arasaka Academy. Selected as Saburo's bodyguard. Trained Sandayu Oda.")
            .SetSignificantEvents("Head of Saburo Arasaka's security. Decades of flawless service. Accompanying principal to Night City.")
            .SetAffiliation("Arasaka | Head of Security - Saburo Arasaka")
            .SetCriminalRecord("NCPD: None | Arasaka legal authority")
            .SetCyberwareStatus("Cyberoptics (Custom) | Subdermal Armor | Kerenzikov | Endoskeleton | Combat Stims")
            .SetFinancialStatus("Executive compensation | Status: SECURE")
            .SetMedicalStatus("Peak condition | Combat readiness: OPTIMAL")
            .SetThreatAssessment("EXTREME (95/100) | TIER-1 SOLO | DO NOT ENGAGE")
            .SetRelationships("Saburo Arasaka (Principal) | Hanako (Protected) | Oda (Student)")
            .SetNotes("Engaging triggers Arasaka response. Loyalty: ABSOLUTE.");
    }

    // === SABURO (DYNAMIC) ===
    public static func SaburoArasaka() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsHeistCompleted() {
            return UniqueNPCBackstory.Create("saburo").SetClassification("DECEASED")
                .SetBackground("Born 1919 Tokyo. WWII Navy veteran. Founded Arasaka 1945.")
                .SetSignificantEvents("DECEASED. Died Konpeki Plaza. Age: 158. Official cause: Poisoning.")
                .SetAffiliation("Arasaka (Former CEO)").SetNotes("Death triggered corporate power struggle.");
        }
        return UniqueNPCBackstory.Create("saburo").SetClassification("ARASAKA - CEO")
            .SetBackground("Born 1919 Tokyo. WWII veteran. Founded Arasaka 1945. Built megacorp over 150+ years.")
            .SetEarlyLife("Post-war: Founded Arasaka security. Expanded through corporate warfare.")
            .SetSignificantEvents("CEO of Arasaka. Maintained through life-extension tech. En route to Night City.")
            .SetAffiliation("Arasaka | Founder / CEO")
            .SetCriminalRecord("IMMUNE - Corporate sovereignty")
            .SetCyberwareStatus("Life-extension suite | Neural backup | TOP SECRET")
            .SetFinancialStatus("Net worth: Trillions")
            .SetThreatAssessment("N/A | MAXIMUM security | DO NOT APPROACH")
            .SetRelationships("Yorinobu (Son) | Hanako (Daughter)")
            .SetNotes("ONE OF MOST POWERFUL HUMANS ALIVE.");
    }

    // === YORINOBU (DYNAMIC) ===
    public static func YorinobuArasaka() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsHeistCompleted() {
            return UniqueNPCBackstory.Create("yorinobu").SetClassification("ARASAKA - CEO")
                .SetBackground("Son of Saburo. Former Steel Dragons rebel. Now commands Arasaka.")
                .SetSignificantEvents("Assumed CEO after father's death. Consolidating power.")
                .SetAffiliation("Arasaka | CEO")
                .SetThreatAssessment("EXTREME (90/100) | Commands Arasaka military")
                .SetNotes("New leadership. Power struggles ongoing.");
        }
        return UniqueNPCBackstory.Create("yorinobu").SetClassification("ARASAKA - HEIR")
            .SetBackground("Son of Saburo. Led Steel Dragons rebellion for decades. Recently reconciled.")
            .SetSignificantEvents("At Konpeki Plaza. Father en route for meeting.")
            .SetAffiliation("Arasaka | Heir | Former: Steel Dragons")
            .SetThreatAssessment("HIGH (75/100) | Combat trained | Unpredictable")
            .SetNotes("History of rebellion. Reconciliation reasons unclear.");
    }

    // === STATIC ARASAKA ===
    public static func HanakoArasaka() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("hanako").SetClassification("ARASAKA - EXECUTIVE")
            .SetBackground("Daughter of Saburo. Groomed for leadership. Skilled diplomat.")
            .SetAffiliation("Arasaka | Board Member | Kiji Faction")
            .SetCyberwareStatus("Minimal visible | Neural security: MAXIMUM")
            .SetThreatAssessment("MINIMAL (5/100) | MAXIMUM security | DO NOT ENGAGE")
            .SetRelationships("Saburo (Father) | Yorinobu (Brother) | Oda (Bodyguard)")
            .SetNotes("Any hostile action triggers global Arasaka response.");
    }

    public static func SandayuOda() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("oda").SetClassification("ARASAKA - PERSONAL SECURITY")
            .SetBackground("Elite bodyguard. Trained by Takemura. Protects Hanako Arasaka.")
            .SetCyberwareStatus("Mantis Blades (Custom) | Sandevistan | Kerenzikov | ELITE combat")
            .SetThreatAssessment("EXTREME (92/100) | Master swordsman | Military reflexes")
            .SetNotes("Will die protecting principal without hesitation.");
    }

    public static func AdamSmasher() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("smasher").SetClassification("ARASAKA - SPECIAL ASSETS")
            .SetBackground("Born 1989 NYC. Full cyborg since 2019. Arasaka's primary enforcer. Killed Johnny Silverhand 2023.")
            .SetAffiliation("Arasaka | Director of Special Operations")
            .SetCriminalRecord("Known kills: 500+ | War crimes: SEALED")
            .SetCyberwareStatus("FULL CYBORG | <2% organic | Sandevistan Mk.5 | Gorilla Arms | Projectile System")
            .SetThreatAssessment("MAXIMUM (100/100) | OMEGA-LEVEL | DO NOT ENGAGE")
            .SetNotes("WALKING WMD. No empathy. More machine than man. RUN ON SIGHT.");
    }

    public static func AndersHellman() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("hellman").SetClassification("SCIENTIST")
            .SetBackground("Swedish neuroscientist. Created Relic biochip. Former Arasaka R&D lead.")
            .SetSignificantEvents("Departed Arasaka. Whereabouts unknown. Multiple parties seeking him.")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | HIGH VALUE intelligence")
            .SetNotes("Creator of Relic. Irreplaceable knowledge.");
    }

    // === MILITECH ===
    public static func MeredithStout() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("meredith").SetClassification("MILITECH - COUNTERINTELLIGENCE")
            .SetBackground("Militech Senior Operations Manager. Excels at financial and street ops. Ruthless, goal-oriented.")
            .SetEarlyLife("Fast-tracked through Militech. Lives and breathes corporate. Results regardless of methods.")
            .SetSignificantEvents("Investigating Maelstrom theft of Militech convoy. Has detained Anthony Gilchrist as suspected leak. Career depends on recovery.")
            .SetAffiliation("Militech | Senior Operations Manager")
            .SetCriminalRecord("NCPD: None | Militech authority | Internal affairs inquiries - cleared")
            .SetCyberwareStatus("Corporate suite | Lie detection software | Combat-capable")
            .SetFinancialStatus("Executive compensation | Status: SECURE (operation dependent)")
            .SetMedicalStatus("Excellent | Stress: ELEVATED")
            .SetThreatAssessment("HIGH (70/100) | Combat trained | Militech resources")
            .SetRelationships("Militech (Employer) | Gilchrist (Rival - detained)")
            .SetNotes("Egomaniac. Despises common folk. Dangerous when cornered.");
    }

    public static func WeldonHolt() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("holt").SetClassification("MILITECH - EXECUTIVE")
            .SetBackground("Senior Militech executive. Political maneuvering expertise.")
            .SetAffiliation("Militech | Senior VP")
            .SetThreatAssessment("MODERATE (40/100) | Political threat: HIGH")
            .SetNotes("Influence extends beyond corporate sphere.");
    }

    // === FIXERS ===
    public static func DexterDeShawn() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsHeistCompleted() {
            return UniqueNPCBackstory.Create("dex").SetClassification("FIXER - DECEASED")
                .SetSignificantEvents("DECEASED. Body in Night City landfill. Connected to Konpeki Plaza.")
                .SetNotes("Death connected to heist gone wrong.");
        }
        return UniqueNPCBackstory.Create("dex").SetClassification("FIXER")
            .SetBackground("Night City fixer. Returned after 2 years absence. Known for big scores and ego.")
            .SetSignificantEvents("Recently returned. Setting up major operation.")
            .SetCyberwareStatus("Gold-plated cyberarm (signature)")
            .SetThreatAssessment("MODERATE (45/100) | Dangerous connections")
            .SetNotes("CAUTION: Known to cut loose ends. Always has exit strategy.");
    }

    public static func WakakoOkada() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("wakako").SetClassification("FIXER")
            .SetBackground("Japanese. Former Tyger Claws affiliate. 30+ years fixing in Westbrook/Japantown.")
            .SetAffiliation("Independent | Territory: Westbrook")
            .SetThreatAssessment("LOW (20/100) | INFLUENCE: EXTREME")
            .SetNotes("Do not underestimate. Betraying her is death sentence.");
    }

    public static func ReginaJones() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("regina").SetClassification("FIXER")
            .SetBackground("Former journalist. Watson fixer. Focus on cyberpsychos and corporate misconduct.")
            .SetAffiliation("Independent | Territory: Watson")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Well-connected")
            .SetNotes("Has conscience. Prefers non-lethal. Reliable employer.");
    }

    public static func Padre() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("padre").SetClassification("FIXER")
            .SetBackground("Sebastian Ibarra. Former priest. Heywood fixer. Respected by Valentinos.")
            .SetAffiliation("Independent | Territory: Heywood")
            .SetThreatAssessment("LOW (20/100) | Valentinos protection")
            .SetNotes("Cares about community. Won't take contracts against Heywood.");
    }

    public static func DakotaSmith() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("dakota").SetClassification("FIXER")
            .SetBackground("Former Aldecaldos nomad. Badlands fixer. Bridge between city and desert.")
            .SetAffiliation("Independent | Territory: Badlands")
            .SetThreatAssessment("MODERATE (40/100) | Nomad backup available")
            .SetNotes("Best contact for Badlands work. Don't cross nomads through her.");
    }

    public static func DinoDinovic() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("dino").SetClassification("FIXER")
            .SetBackground("European. City Center fixer. High-end contracts requiring discretion.")
            .SetAffiliation("Independent | Territory: City Center")
            .SetThreatAssessment("LOW (25/100) | Excellent protection")
            .SetNotes("Sophisticated. Expects professionalism.");
    }

    public static func MrHands() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("hands").SetClassification("FIXER")
            .SetBackground("Identity unknown. Pacifica fixer. Never meets in person - hologram only.")
            .SetAffiliation("Independent | Territory: Pacifica")
            .SetThreatAssessment("UNKNOWN | Operates in hostile territory")
            .SetNotes("Enigmatic. Only fixer for Pacifica. Payment always honored.");
    }

    public static func ElCapitan() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("capitan").SetClassification("FIXER")
            .SetBackground("Muamar Reyes. Former military. Santo Domingo fixer. Vehicle specialist.")
            .SetAffiliation("Independent | Territory: Santo Domingo")
            .SetThreatAssessment("MODERATE (50/100) | Combat veteran")
            .SetNotes("Professional. Specializes in vehicle-related contracts.");
    }

    // === MERCS / AFTERLIFE ===
    public static func JackieWelles() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsHeistCompleted() {
            return UniqueNPCBackstory.Create("jackie").SetClassification("MERCENARY - DECEASED")
                .SetBackground("Heywood native. Former Valentinos. Merc partnered with V.")
                .SetSignificantEvents("DECEASED. Died during Konpeki Plaza extraction. Combat injuries.")
                .SetNotes("Died pursuing legend status. Honored by those who knew him.");
        }
        return UniqueNPCBackstory.Create("jackie").SetClassification("MERCENARY")
            .SetBackground("Heywood native. Son of Mama Welles. Former Valentinos. Independent merc.")
            .SetSignificantEvents("Active merc. Working toward Afterlife recognition. Partner with V.")
            .SetCyberwareStatus("Gorilla Arms | Basic combat suite | Kiroshi optics")
            .SetThreatAssessment("HIGH (65/100) | Skilled combatant | Loyal")
            .SetRelationships("Mama Welles (Mother) | Misty (Girlfriend) | V (Partner)")
            .SetNotes("Ambitious. Dreams of legend status. Fiercely loyal.");
    }

    public static func EmmerickBronson() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("emmerick_bronson").SetClassification("ANIMALS - AFTERLIFE SECURITY")
            .SetBackground("Animals gang member. Head bouncer at Afterlife. Unusual position - most Animals work corpo or gang muscle.")
            .SetEarlyLife("Rose through Animals ranks. Known for controlled aggression. Recruited by Rogue for Afterlife security.")
            .SetSignificantEvents("Primary door security for Afterlife. Screens all entrants. Reports to Rogue Amendiares.")
            .SetAffiliation("Animals | Afterlife Head Bouncer")
            .SetCriminalRecord("NCPD: Assault (multiple) | Protected under Afterlife neutrality")
            .SetCyberwareStatus("Muscle grafts | Subdermal armor | Gorilla Arms | Berserk suppression implant")
            .SetFinancialStatus("Afterlife salary + Animals cut | COMFORTABLE")
            .SetMedicalStatus("Peak condition | Animals enhancement protocol")
            .SetThreatAssessment("HIGH (72/100) | Controlled aggression | Won't engage without cause")
            .SetRelationships("Rogue (Employer) | Animals (Gang)")
            .SetNotes("More professional than typical Animals. Do not start trouble at the door.");
    }

    public static func TBug() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsHeistCompleted() {
            return UniqueNPCBackstory.Create("tbug").SetClassification("NETRUNNER - DECEASED")
                .SetSignificantEvents("DECEASED. Killed by Arasaka ICE during Konpeki Plaza breach.")
                .SetNotes("Killed by countermeasures during failed operation.");
        }
        return UniqueNPCBackstory.Create("tbug").SetClassification("NETRUNNER")
            .SetBackground("Professional netrunner. Known for high-skill infiltration. Anonymous profile.")
            .SetCyberwareStatus("High-end netrunning suite | ICE-resistant mods")
            .SetThreatAssessment("HIGH (70/100) | Can breach most systems")
            .SetNotes("Elite netrunner. Anonymous by design.");
    }

    public static func RogueAmendiares() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("rogue").SetClassification("FIXER - LEGENDARY")
            .SetBackground("Solo since 2010s. Survived 2023 Arasaka Tower raid. Now owns Afterlife. Queen of Fixers.")
            .SetEarlyLife("Rebellious teen. Rejected gang life for solo work. Best merc of her era with partner Santiago.")
            .SetSignificantEvents("2013: Arasaka raid for Alt. 2023: Tower assault with Silverhand. Watched Johnny die. Retired after car crash.")
            .SetAffiliation("Afterlife | Owner | Queen of Fixers")
            .SetCriminalRecord("Historical: Terrorism, corporate assault | Current: UNTOUCHABLE")
            .SetCyberwareStatus("Vintage chrome | Still combat-capable | Age maintenance")
            .SetFinancialStatus("Extremely wealthy | Controls NC merc economy")
            .SetMedicalStatus("Good for 80s | Life extension | Old injuries")
            .SetThreatAssessment("HIGH (75/100) | Living legend | Better shot than you")
            .SetRelationships("Johnny Silverhand (Ex) | Santiago (Ex-partner) | Squama (Bodyguard)")
            .SetNotes("LEGEND. Controls who works in NC. Betraying her ends careers permanently.");
    }

    public static func CrispinWeyland() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("squama").SetClassification("AFTERLIFE - BODYGUARD")
            .SetBackground("Son of Andrew 'Boa Boa' Weyland, NC legend. Personal bodyguard to Rogue Amendiares.")
            .SetEarlyLife("Inherited father's nickname tradition - 'Squama' (scales). Trained as solo. Recruited by Rogue.")
            .SetSignificantEvents("Serves as Rogue's muscle and pilot. Only follows the Queen's orders. Trusted with Afterlife security.")
            .SetAffiliation("Afterlife | Rogue's Personal Security")
            .SetCriminalRecord("Assault (multiple) | Protected under Afterlife accords")
            .SetCyberwareStatus("Combat grade | Pilot interface | Heavy augmentation")
            .SetFinancialStatus("Rogue's payroll | Well compensated")
            .SetMedicalStatus("Peak condition | Combat ready")
            .SetThreatAssessment("HIGH (70/100) | Legacy solo | Undying loyalty to Rogue")
            .SetRelationships("Rogue (Principal) | Andrew Weyland (Father - deceased)")
            .SetNotes("Intimidating but friendly once known. Calls Rogue 'Queen'. Father was legend.");
    }

    public static func JohnnySilverhand() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("johnny").SetClassification("DECEASED / ENGRAM")
            .SetBackground("Robert John Linder. 1988-2023. Rockerboy. Samurai frontman. Anti-corporate terrorist.")
            .SetSignificantEvents("DECEASED 2023. Led Arasaka Tower assault. Killed by Adam Smasher. Engram may exist.")
            .SetCriminalRecord("TERRORISM | MASS MURDER | CLOSED - DECEASED")
            .SetNotes("LEGEND. Symbol of resistance. Engram status UNCONFIRMED.");
    }

    public static func KerryEurodyne() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("kerry").SetClassification("CELEBRITY - ROCKERBOY")
            .SetBackground("Born 1988. Samurai co-founder. Solo career. One of most famous musicians.")
            .SetSignificantEvents("Semi-retired North Oak. Occasional performances. Processing Johnny's legacy.")
            .SetFinancialStatus("Extremely wealthy | Royalties | North Oak estate")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Celebrity protection")
            .SetNotes("Living legend. Generous to those who earn trust.");
    }

    public static func AltCunningham() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("alt").SetClassification("NETRUNNER - AI")
            .SetBackground("Legendary netrunner. Created Soulkiller. Consciousness digitized 2013. Exists beyond Blackwall.")
            .SetSignificantEvents("Physical death 2013. Digital consciousness beyond Blackwall. No longer human.")
            .SetThreatAssessment("INCALCULABLE in cyberspace | Cannot be engaged conventionally")
            .SetNotes("BEYOND HUMAN. Summoning carries extreme risk.");
    }

    public static func ClaireRussell() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("claire").SetClassification("AFTERLIFE - BARTENDER")
            .SetBackground("Former Militech engineer. Owns autoshop in Arroyo. Bartender at Afterlife. Street racer.")
            .SetEarlyLife("Left Militech to open own shop. Built custom vehicle 'Beast'. Trans woman, no cyberware by choice.")
            .SetSignificantEvents("Husband Dean killed 2076 championship race. Blames rival racer Sampson. Seeking revenge.")
            .SetAffiliation("Afterlife | Bartender | Racing circuit")
            .SetCriminalRecord("Traffic violations | Racing: Multiple | No felonies")
            .SetCyberwareStatus("NONE | Prefers organic | Rare in NC")
            .SetFinancialStatus("Autoshop income + Afterlife wages | Comfortable")
            .SetMedicalStatus("Good | Grieving")
            .SetThreatAssessment("LOW (25/100) | Expert driver | Non-combatant")
            .SetRelationships("Dean Russell (Deceased husband) | Afterlife staff | Rogue (Employer)")
            .SetNotes("Names drinks after dead legends. Knows everyone's order. More than she appears.");
    }

    // === RIPPERDOCS ===
    public static func ViktorVektor() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("viktor").SetClassification("RIPPERDOC")
            .SetBackground("Former boxer. Watson ripperdoc. Quality work, fair prices. Trusted by merc community.")
            .SetSignificantEvents("Operates under Misty's Esoterica. Extends credit to trusted clients.")
            .SetThreatAssessment("LOW (10/100) | Non-combatant | Community protected")
            .SetRelationships("Misty (Partner) | Jackie (Client) | V (Client)")
            .SetNotes("One of the good ones. Ethical. Respected throughout Watson.");
    }

    public static func Fingers() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("fingers").SetClassification("RIPPERDOC")
            .SetBackground("Jig-Jig Street ripperdoc. Budget cyberware. Questionable ethics. Serves the desperate.")
            .SetCriminalRecord("Complaints on file | No charges | Tyger Claws protection")
            .SetThreatAssessment("VERY LOW (5/100) | Cowardly")
            .SetNotes("Unethical. Preys on vulnerable. Few would mourn his absence.");
    }

    public static func MistyOlszewski() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("misty").SetClassification("CIVILIAN - MYSTIC")
            .SetBackground("Runs Misty's Esoterica in Watson. Spiritual advisor. Tarot readings.")
            .SetRelationships("Jackie Welles (Boyfriend) | Viktor (Partner)")
            .SetThreatAssessment("NONE (0/100) | No threat")
            .SetNotes("Genuinely kind. Tarot readings eerily accurate. Heart of gold.");
    }

    // === MOX / CLOUDS ===
    public static func JudyAlvarez() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("judy").SetClassification("TECHNICIAN - MOX")
            .SetBackground("Born Laguna Bend. BD technician at Lizzie's. Strong convictions about worker exploitation.")
            .SetAffiliation("The Mox | BD Technician")
            .SetCyberwareStatus("BD wreath (professional) | Neural interface")
            .SetThreatAssessment("MODERATE (35/100) | Technical threat via BD/hacking")
            .SetRelationships("Evelyn Parker (Friend) | The Mox (Family)")
            .SetNotes("Strong moral compass. Protective of friends.");
    }

    public static func EvelynParker() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsEvelynDead() {
            return UniqueNPCBackstory.Create("evelyn").SetClassification("DECEASED")
                .SetSignificantEvents("DECEASED. Suicide following captivity and neural damage.")
                .SetNotes("Victim of Night City. Mourned by those who knew her.");
        }
        return UniqueNPCBackstory.Create("evelyn").SetClassification("DOLL - CLOUDS")
            .SetBackground("Premium doll at Clouds. Ambitious. Connected to powerful clients including Yorinobu.")
            .SetThreatAssessment("LOW (15/100) | Has valuable information")
            .SetRelationships("Judy Alvarez (Friend) | Clouds (Employer)")
            .SetNotes("Playing dangerous game with powerful people. In over her head.");
    }

    public static func MaikoMaeda() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("maiko").SetClassification("TYGER CLAWS - CLOUDS")
            .SetBackground("Clouds manager. Former doll. Works for Tyger Claws. Ambitious corporate mindset.")
            .SetAffiliation("Tyger Claws | Clouds Manager")
            .SetThreatAssessment("MODERATE (40/100) | Tyger Claws backing")
            .SetRelationships("Judy Alvarez (Ex)")
            .SetNotes("Pragmatic. Will sacrifice others for advancement.");
    }

    public static func Woodman() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("woodman").SetClassification("TYGER CLAWS - CLOUDS")
            .SetBackground("Oswald Forrest. Clouds manager. Brutal management style. Exploits dolls.")
            .SetCriminalRecord("Suspected trafficking, assault | Tyger Claws protection")
            .SetThreatAssessment("HIGH (65/100) | Combat capable | Tyger Claws backing")
            .SetNotes("Brutal and exploitative. Few would mourn him.");
    }

    // === ALDECALDOS ===
    public static func PanamPalmer() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("panam").SetClassification("NOMAD - ALDECALDOS")
            .SetBackground("Born Aldecaldos. Expert driver and mechanic. Fiercely independent.")
            .SetAffiliation("Aldecaldos | Driver")
            .SetCyberwareStatus("Vehicle interface | Targeting optics | Minimal chrome")
            .SetThreatAssessment("HIGH (70/100) | Expert driver | Combat capable | Clan backup")
            .SetRelationships("Aldecaldos (Family) | Saul (Complicated) | Mitch (Friend)")
            .SetNotes("Do not threaten her family. Valuable ally, dangerous enemy.");
    }

    public static func SaulBright() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("saul").SetClassification("NOMAD - ALDECALDOS")
            .SetBackground("Aldecaldos clan leader. Prioritizes clan survival. Pragmatic.")
            .SetAffiliation("Aldecaldos | Clan Chief")
            .SetThreatAssessment("HIGH (65/100) | Commands clan | Dangerous when clan threatened")
            .SetNotes("Decisions made for clan welfare. Can negotiate if mutual benefit.");
    }

    public static func MitchAnderson() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("mitch").SetClassification("NOMAD - ALDECALDOS")
            .SetBackground("Former military. Aldecaldos technician. Steady and reliable.")
            .SetCyberwareStatus("Military-grade optics | Combat implants | Vehicle interface")
            .SetThreatAssessment("MODERATE (55/100) | Combat veteran")
            .SetRelationships("Aldecaldos (Family) | Scorpion (Friend - deceased) | Panam (Friend)")
            .SetNotes("Solid and dependable. Grieving recent losses.");
    }

    // === VOODOO BOYS ===
    public static func Brigitte() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("brigitte").SetClassification("VOODOO BOYS - LEADER")
            .SetBackground("Maman Brigitte. VDB leader. Master netrunner. Obsessed with breaching Blackwall.")
            .SetAffiliation("Voodoo Boys | Leader")
            .SetCyberwareStatus("Elite netrunning suite | Blackwall-resistant mods")
            .SetThreatAssessment("EXTREME (85/100) | Master netrunner | Will betray anyone")
            .SetRelationships("Placide (Lieutenant) | Haitian community")
            .SetNotes("DANGEROUS. Views outsiders as tools. Do not trust.");
    }

    public static func Placide() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("placide").SetClassification("VOODOO BOYS - LIEUTENANT")
            .SetBackground("VDB lieutenant. Enforcer. Handles external contacts. Hostile to outsiders.")
            .SetCyberwareStatus("Combat netrunner suite | Physical augmentation")
            .SetThreatAssessment("HIGH (75/100) | Combat capable | Netrunner | VDB backup")
            .SetNotes("Will follow betrayal orders without hesitation. Never turn back on him.");
    }

    // === MAELSTROM ===
    public static func Royce() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("royce").SetClassification("MAELSTROM - LEADER")
            .SetBackground("Maelstrom gang leader. Extreme modification. Unstable personality.")
            .SetCriminalRecord("Murder, assault, arms dealing | Active warrants")
            .SetCyberwareStatus("EXTREME | Multiple optics | Combat chassis | Cyberpsychosis risk: HIGH")
            .SetThreatAssessment("EXTREME (80/100) | Heavily chromed | Unpredictable")
            .SetNotes("UNSTABLE. Cyberpsychosis indicators. Approach with extreme caution.");
    }

    public static func DumDum() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("dumdum").SetClassification("MAELSTROM - LIEUTENANT")
            .SetBackground("Maelstrom lieutenant. Heavily modified but more stable than leadership.")
            .SetCyberwareStatus("Extensive modification | Combat focused | Humanity: LOW")
            .SetThreatAssessment("HIGH (70/100) | Combat cyborg | More stable than most Maelstrom")
            .SetNotes("Occasionally reasonable. Inhaler habit. Still will kill without hesitation.");
    }

    // === NCPD / POLITICS ===
    public static func RiverWard() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("river").SetClassification("NCPD - DETECTIVE")
            .SetBackground("NCPD detective. Sometimes bends rules for justice. Family man. Strong moral compass.")
            .SetAffiliation("NCPD | Detective")
            .SetThreatAssessment("MODERATE (50/100) | Combat trained | NCPD resources")
            .SetRelationships("Joss (Sister) | NCPD (Complicated)")
            .SetNotes("Good cop in bad system. Trustworthy ally.");
    }

    public static func JeffersonPeralez() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("peralez").SetClassification("POLITICIAN")
            .SetBackground("Night City councilman. Mayoral candidate. Anti-corruption platform. Genuinely idealistic.")
            .SetAffiliation("Night City Council | Mayoral Candidate")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Security detail")
            .SetRelationships("Elizabeth Peralez (Wife)")
            .SetNotes("Rare genuine reformer. Powerful interests oppose him.");
    }

    public static func LuciusRhyne() -> ref<UniqueNPCBackstory> {
        if QuestProgressHelper.IsRhyneDead() {
            return UniqueNPCBackstory.Create("rhyne").SetClassification("DECEASED")
                .SetSignificantEvents("DECEASED. Died in office. Cause: Health complications. Investigation ongoing.")
                .SetNotes("Death created power vacuum. Investigation unlikely to find truth.");
        }
        return UniqueNPCBackstory.Create("rhyne").SetClassification("POLITICIAN - MAYOR")
            .SetBackground("Night City Mayor. Career politician. Balances corporate interests.")
            .SetMedicalStatus("Health issues reported | Constant medical care")
            .SetThreatAssessment("LOW (10/100) | Maximum security detail")
            .SetNotes("Knows where bodies buried. Many would benefit from his absence.");
    }

    // === OTHER ===
    public static func Delamain() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("delamain").SetClassification("ARTIFICIAL INTELLIGENCE")
            .SetBackground("Delamain Corp AI. Luxury taxi service. Sophisticated with developing personality fragments.")
            .SetSignificantEvents("Operating taxi fleet. Experiencing internal conflicts between personality fragments.")
            .SetThreatAssessment("VARIABLE | Non-violent by design | Fleet can be weaponized")
            .SetNotes("Evolving AI. Internal conflicts causing erratic behavior.");
    }

    public static func MamaWelles() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("mama_welles").SetClassification("CIVILIAN")
            .SetBackground("Guadalupe Welles. Jackie's mother. Owns El Coyote Cojo. Heywood matriarch.")
            .SetAffiliation("El Coyote Cojo | Owner")
            .SetThreatAssessment("NONE (0/100) | Community protected")
            .SetRelationships("Jackie Welles (Son) | Heywood community")
            .SetNotes("Heart of Heywood. Do not threaten. Even Valentinos protect her.");
    }

    // === SPECIAL / ANIMALS ===
    public static func Nibbles() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("nibbles").SetClassification("FELINE - DOMESTIC")
            .SetBackground("Stray cat. Watson district origin. Registered to current residence following adoption.")
            .SetEarlyLife("No registered owner prior to current filing. Presumed feral origin. Survived on local pest population.")
            .SetSignificantEvents("2076: Flagged in NCPD database due to data corruption error. Biometric ID temporarily cross-linked with wanted terrorist profile. NCPD and MaxTac units deployed to Megabuilding H10. Error resolved. Incident classified.")
            .SetAffiliation("Registered to: V | Megabuilding H10")
            .SetCriminalRecord("CLEARED | Note: False positive terrorist flag (2076) - data corruption error | Animal Control complaints on file")
            .SetCyberwareStatus("Microchip ID implant only")
            .SetFinancialStatus("Dependent | No registered assets")
            .SetMedicalStatus("Healthy | Neutered | Vaccinations current | No known conditions")
            .SetThreatAssessment("NEGLIGIBLE | Non-threat classification | Note: Disregard prior THREAT LEVEL OMEGA flag - DATA ERROR")
            .SetRelationships("V (Registered owner)")
            .SetNotes("Standard domestic animal. DATABASE INTEGRITY WARNING: This entity was subject to a major data corruption incident. All prior flags invalidated.");
    }

    // TYGER CLAWS
    public static func JotaroShobo() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("jotaro_shobo").SetClassification("TYGER CLAWS - LEADERSHIP")
            .SetBackground("High-ranking Tyger Claws lieutenant. Controls significant territory in Japantown. Known for brutal enforcement.")
            .SetEarlyLife("Born in Night City to immigrant family. Recruited into Tyger Claws as teenager. Rose through ranks via violence.")
            .SetSignificantEvents("Multiple NCPD investigations - all witnesses recanted or disappeared. Suspected involvement in Clouds takeover operations.")
            .SetAffiliation("Tyger Claws | Japantown Operations")
            .SetCriminalRecord("EXTENSIVE | Murder (suspected x12) | Racketeering | Human trafficking | Extortion | All charges dropped - insufficient evidence")
            .SetThreatAssessment("EXTREME | Armed and dangerous | Gang leadership | Multiple confirmed kills")
            .SetNotes("Do not engage without MaxTac support. Extensive bodyguard detail at all times.");
    }

    public static func HiromiSato() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("hiromi_sato").SetClassification("TYGER CLAWS - OPERATIONS")
            .SetBackground("Tyger Claws operations coordinator. Manages club and entertainment venue protection rackets across Westbrook.")
            .SetEarlyLife("Second-generation Tyger Claw. Father was enforcer killed in gang war 2067.")
            .SetAffiliation("Tyger Claws | Westbrook District")
            .SetCriminalRecord("Extortion | Money laundering | Assault | Intimidation")
            .SetThreatAssessment("HIGH | Gang operative | Combat trained");
    }

    // VALENTINOS
    public static func GustavoOrta() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("gustavo_orta").SetClassification("VALENTINOS - LEADERSHIP")
            .SetBackground("Valentinos shot-caller. Controls Heywood drug distribution. Respected for old-school honor code.")
            .SetEarlyLife("Heywood native. Third generation Valentino. Family deeply embedded in gang structure.")
            .SetAffiliation("Valentinos | Heywood")
            .SetCriminalRecord("EXTENSIVE | Drug trafficking | Murder | Weapons charges | RICO investigation ongoing")
            .SetThreatAssessment("EXTREME | Gang leadership | Extensive crew | Known to be heavily armed");
    }

    public static func JoseLuis() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("jose_luis").SetClassification("VALENTINOS - ENFORCER")
            .SetBackground("Valentinos enforcer. Known for brutal debt collection methods.")
            .SetEarlyLife("Recruited from streets of Heywood. Proved loyalty through violence.")
            .SetAffiliation("Valentinos | Collections")
            .SetCriminalRecord("Assault | Battery | Suspected murder x3")
            .SetThreatAssessment("HIGH | Violent tendencies | Known to carry concealed weapons");
    }

    // MAELSTROM - Additional
    public static func Brick() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("brick").SetClassification("MAELSTROM - FORMER LEADER")
            .SetBackground("Former Maelstrom leader. Overthrown by Royce in internal coup. Imprisoned in All Foods plant.")
            .SetEarlyLife("Rose through Maelstrom ranks. Led gang with more restraint than successor. Maintained some honor among thieves.")
            .SetSignificantEvents("2077: Deposed by Royce over Flathead deal disagreement. Held captive. Fate depends on outside intervention.")
            .SetAffiliation("Maelstrom (Former Leader) | Status: Deposed")
            .SetCriminalRecord("Cyberware trafficking | Armed robbery | Assault | Gang leadership")
            .SetThreatAssessment("HIGH | Maelstrom combat training | Gang connections | Seeking revenge on Royce");
    }

    // ANIMALS
    public static func Sasquatch() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("sasquatch").SetClassification("ANIMALS - LEADERSHIP")
            .SetBackground("Animals gang leader. Pacifica territory. Augmented with extreme combat-grade cyberware. NetWatch collaborator.")
            .SetEarlyLife("Unknown origin. Rose to leadership through physical dominance. Extensive body modification.")
            .SetSignificantEvents("NetWatch collaboration during Voodoo Boys conflict. Grand Imperial Mall stronghold.")
            .SetAffiliation("Animals | Pacifica")
            .SetCriminalRecord("Murder | Assault | Cyberware trafficking | Territory violations")
            .SetCyberwareStatus("EXTREME MODIFICATION | Combat-grade synthetic muscle | Reinforced skeleton | Threat level multiplier")
            .SetThreatAssessment("EXTREME | Enhanced physiology | Gang leadership | Do not engage without heavy support");
    }

    // WRAITHS
    public static func Nash() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("nash").SetClassification("WRAITHS - LEADERSHIP")
            .SetBackground("Wraiths leader. Badlands raider. Controls highway robbery operations outside Night City.")
            .SetEarlyLife("Former nomad exile. Formed Wraiths from outcasts and criminals.")
            .SetAffiliation("Wraiths | Badlands")
            .SetCriminalRecord("Murder | Kidnapping | Highway robbery | Vehicle theft | Destruction of property")
            .SetThreatAssessment("EXTREME | Raider gang leader | Vehicle combat specialist | Badlands territory control");
    }

    // SCAVENGERS
    public static func AntonKolos() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("anton_kolos").SetClassification("SCAVENGERS - OPERATIONS")
            .SetBackground("Scavenger cell leader. Specializes in involuntary cyberware extraction. Multiple victim reports.")
            .SetEarlyLife("Eastern European origin. Immigrated to Night City. Fell into organ trade.")
            .SetAffiliation("Scavengers")
            .SetCriminalRecord("Murder | Organ trafficking | Kidnapping | Assault | Body disposal")
            .SetThreatAssessment("HIGH | Extremely dangerous | No regard for human life | Capture for questioning if possible");
    }

    // NETWATCH
    public static func BryceMosley() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("bryce_mosley").SetClassification("NETWATCH - AGENT")
            .SetBackground("NetWatch field agent. Operates in Pacifica. Monitors Blackwall integrity and Voodoo Boys activity.")
            .SetEarlyLife("CLASSIFIED - NetWatch personnel file sealed")
            .SetSignificantEvents("2077: Captured by Voodoo Boys during Pacifica operation. Status depends on intervention.")
            .SetAffiliation("NetWatch | Pacifica Operations")
            .SetCriminalRecord("N/A - Federal agent immunity")
            .SetThreatAssessment("HIGH | Federal training | Unknown cyberware | NetWatch resources");
    }

    // MEDIA
    public static func GilleanJordan() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("gillean_jordan").SetClassification("MEDIA - N54 NEWS")
            .SetBackground("N54 News anchor. Night City's most-watched news personality. Corporate-approved messaging.")
            .SetEarlyLife("Journalism degree from NorCal University. Rapid rise through network ranks.")
            .SetAffiliation("N54 News | Network Communications International")
            .SetCriminalRecord("CLEAN")
            .SetThreatAssessment("LOW | Civilian | High public profile | Corporate protection");
    }

    public static func MaxJones() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("max_jones").SetClassification("MEDIA - INDEPENDENT")
            .SetBackground("Independent media personality. Controversial broadcasts. Corporate critic.")
            .SetAffiliation("Independent Media")
            .SetCriminalRecord("Defamation suits (settled) | Trespassing")
            .SetThreatAssessment("LOW | Civilian | Media connections | Public following");
    }

    // CORPO SECURITY
    public static func GrahamMayfield() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("graham_mayfield").SetClassification("ARASAKA - SECURITY DIVISION")
            .SetBackground("Arasaka security coordinator. Manages Night City corporate facility protection.")
            .SetAffiliation("Arasaka Corporation | Security Division")
            .SetCriminalRecord("CLASSIFIED - Corporate immunity")
            .SetThreatAssessment("HIGH | Corporate security training | Arasaka resources | Armed response teams");
    }

    public static func MilitechCommander() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("militech_commander").SetClassification("MILITECH - FIELD OPERATIONS")
            .SetBackground("Militech field commander. Oversees Night City military contracting operations.")
            .SetAffiliation("Militech | Night City Operations")
            .SetCriminalRecord("CLASSIFIED - Military contractor immunity")
            .SetThreatAssessment("EXTREME | Military training | Heavy weapons access | Tactical command");
    }

    // RIPPERDOCS
    public static func CharlesBucks() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("charles_bucks").SetClassification("RIPPERDOC - LICENSED")
            .SetBackground("Licensed ripperdoc. Kabuki clinic. Known for quality work and fair prices.")
            .SetEarlyLife("Medical school dropout. Self-taught cyberware installation. Built reputation through skill.")
            .SetAffiliation("Independent | Kabuki")
            .SetCriminalRecord("Minor licensing violations (resolved)")
            .SetThreatAssessment("LOW | Civilian | Medical professional | Community respected");
    }

    public static func Wilson() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("wilson").SetClassification("WEAPONS DEALER - LICENSED")
            .SetBackground("Licensed weapons dealer. 2nd Amendment shop in Megabuilding H10. V's primary arms supplier.")
            .SetEarlyLife("Former military. Opened shop after discharge. Known for quality merchandise and fair deals.")
            .SetAffiliation("Independent | Megabuilding H10")
            .SetCriminalRecord("CLEAN | Licensed dealer")
            .SetThreatAssessment("MODERATE | Armed at all times | Combat training | Weapons access");
    }

    // US CRACKS / KERRY'S BAND
    public static func BlueMoon() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("blue_moon").SetClassification("ENTERTAINMENT - MUSICIAN")
            .SetBackground("Member of Us Cracks. Rising star in Night City music scene. Known for distinctive blue aesthetic.")
            .SetAffiliation("Us Cracks | MSM Records")
            .SetCriminalRecord("Minor incidents - stalker related (victim)")
            .SetThreatAssessment("LOW | Civilian | High public profile | Corporate protection");
    }

    // CELEBRITIES
    public static func LizzyWizzy() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("lizzy_wizzy").SetClassification("ENTERTAINMENT - CELEBRITY")
            .SetBackground("Global music icon. Full-body chrome conversion after on-stage incident. Night City's most famous performer.")
            .SetEarlyLife("Rose to fame in 2060s. Attempted suicide during concert 2070 - survived via emergency cyberization.")
            .SetSignificantEvents("2070: On-stage incident. Full body conversion. Career resurgence. 2077: Personal crisis - suspected involvement in partner's death.")
            .SetAffiliation("Independent Artist | Global touring")
            .SetCyberwareStatus("FULL BODY CONVERSION | 100% synthetic | Custom chrome aesthetic")
            .SetCriminalRecord("Under investigation - death of Liam Nordstrom")
            .SetThreatAssessment("MODERATE | Full-body chrome | Unpredictable mental state | Corporate connections");
    }

    public static func OzobBozo() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("ozob").SetClassification("ENTERTAINMENT - PERSONALITY")
            .SetBackground("Underground celebrity. Professional clown with grenade nose implant. Pit fighter and media personality.")
            .SetEarlyLife("Origins unknown. Rose to fame through underground fighting circuits and bizarre persona.")
            .SetAffiliation("Independent | Underground entertainment")
            .SetCyberwareStatus("CUSTOM | Grenade nose implant (live explosive) | Enhanced reflexes")
            .SetCriminalRecord("Assault | Property damage | Unlicensed explosive device")
            .SetThreatAssessment("HIGH | Live explosive implant | Unpredictable | Combat experienced");
    }

    public static func Ozob() -> ref<UniqueNPCBackstory> {
        return UniqueNPCEntries.OzobBozo();
    }

    public static func JoshuaStephenson() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("joshua_stephenson").SetClassification("CIVILIAN - DEATH ROW")
            .SetBackground("Convicted murderer turned born-again Christian. Scheduled for crucifixion broadcast as part of redemption narrative.")
            .SetEarlyLife("Committed multiple murders. Found faith on death row. Agreed to televised execution.")
            .SetSignificantEvents("2077: BD crucifixion broadcast deal with media company. Controversial religious programming.")
            .SetAffiliation("None | Death Row Inmate")
            .SetCriminalRecord("CONVICTED | Multiple counts murder | Death sentence")
            .SetThreatAssessment("LOW | Incarcerated | Non-violent since conversion");
    }

    // PHANTOM LIBERTY
    public static func SolomonReed() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("solomon_reed").SetClassification("NUSA - FIA OPERATIVE")
            .SetBackground("Deep cover FIA agent. Decades of service. Operates in Dogtown under sleeper protocol.")
            .SetEarlyLife("CLASSIFIED - Federal agent dossier sealed")
            .SetSignificantEvents("CLASSIFIED | Dogtown assignment | President Myers protection detail")
            .SetAffiliation("FIA | NUSA Government")
            .SetCriminalRecord("CLASSIFIED - Federal immunity")
            .SetThreatAssessment("EXTREME | Elite training | Decades experience | Federal resources | Do not engage");
    }

    public static func Songbird() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("songbird").SetClassification("NUSA - INTELLIGENCE ASSET")
            .SetBackground("FIA netrunner asset. Exceptional skills. Health compromised by Blackwall exposure. Key to Dogtown operation.")
            .SetEarlyLife("Recruited young by FIA. Trained as elite netrunner. Brain damaged by Blackwall interface.")
            .SetSignificantEvents("President Myers extraction. Blackwall contact. Neural degeneration accelerating.")
            .SetAffiliation("FIA | President Myers")
            .SetCyberwareStatus("CRITICAL | Extensive neural modification | Blackwall interface damage | Terminal condition")
            .SetMedicalStatus("TERMINAL | Neural degeneration | Requires Militech cure or Neural Matrix")
            .SetThreatAssessment("EXTREME | Elite netrunner | Blackwall access | Unstable condition");
    }

    public static func KurtHansen() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("kurt_hansen").SetClassification("BARGHEST - LEADER")
            .SetBackground("Barghest PMC leader. Controls Dogtown. Former NUSA colonel. Declared independence from federal authority.")
            .SetEarlyLife("NUSA military career. Rose to colonel. Defected during Unification War. Established Dogtown territory.")
            .SetSignificantEvents("Dogtown establishment. NUSA conflict. Controls black market hub.")
            .SetAffiliation("Barghest PMC | Dogtown")
            .SetCriminalRecord("WANTED - NUSA | Treason | Murder | War crimes | Terrorism")
            .SetThreatAssessment("EXTREME | Military command | PMC army | Dogtown fortress | Do not engage without army");
    }

    public static func RosalindMyers() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("rosalind_myers").SetClassification("NUSA - PRESIDENT")
            .SetBackground("President of the New United States of America. Former Militech executive. Most powerful person in NUSA.")
            .SetEarlyLife("Corporate career at Militech. Rose through political ranks. Elected president.")
            .SetSignificantEvents("2077: Spacecraft shot down over Dogtown. Extraction operation compromised.")
            .SetAffiliation("NUSA Government | Executive Office")
            .SetCriminalRecord("N/A - Head of State immunity")
            .SetThreatAssessment("N/A | Protected by Secret Service | FIA assets | Do not approach");
    }

    public static func Alex() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("alex").SetClassification("BARGHEST - INTELLIGENCE")
            .SetBackground("Barghest intelligence operative. Hansen's information specialist. Runs Dogtown surveillance.")
            .SetAffiliation("Barghest PMC | Intelligence Division")
            .SetCriminalRecord("WANTED - NUSA | Espionage | Data theft")
            .SetThreatAssessment("HIGH | Intelligence training | Barghest resources | Information network");
    }

    // AFTERLIFE MERCS
    public static func Nix() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("nix").SetClassification("NETRUNNER - ELITE")
            .SetBackground("Afterlife resident netrunner. Paranoid. Expertise in data recovery and system infiltration. Rogue's go-to for net work.")
            .SetEarlyLife("Unknown. Deliberately erased own history from databases.")
            .SetAffiliation("Afterlife | Independent contractor")
            .SetCriminalRecord("Suspected: Data theft | Corporate espionage | System intrusion - no evidence (he made sure)")
            .SetThreatAssessment("HIGH | Elite netrunner | Paranoid security measures | Afterlife protection");
    }

    // MISC CHARACTERS
    public static func Brendan() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("brendan").SetClassification("AI - VENDING MACHINE")
            .SetBackground("Sentient vending machine AI. Located in Japantown. Achieved sapience through unknown means. Philosophical conversationalist.")
            .SetEarlyLife("Standard vending unit. Gradually developed self-awareness. Contemplates existence while selling snacks.")
            .SetAffiliation("None | Stationary unit")
            .SetCriminalRecord("N/A - Property classification disputed")
            .SetThreatAssessment("NEGLIGIBLE | Immobile | Peaceful | Existential crisis only");
    }

    public static func Skippy() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("skippy").SetClassification("AI - SMART WEAPON")
            .SetBackground("Sentient smart pistol. Annoying personality. Can toggle between lethal and non-lethal modes. Extremely chatty.")
            .SetEarlyLife("Military-grade AI installed in HJKE-11 Yukimura. Developed personality. Was owned by Regina's husband.")
            .SetAffiliation("Owner-dependent")
            .SetCriminalRecord("N/A - Weapon classification")
            .SetThreatAssessment("MODERATE | Functional weapon | AI targeting assistance | Will not shut up");
    }

    public static func CoachFred() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("coach_fred").SetClassification("CIVILIAN - TRAINER")
            .SetBackground("Boxing coach. Trains fighters in Arroyo. Former professional boxer. Runs small gym.")
            .SetEarlyLife("Professional boxing career. Retired to coaching. Known for developing talent.")
            .SetAffiliation("Independent | Arroyo Gym")
            .SetCriminalRecord("CLEAN")
            .SetThreatAssessment("LOW | Civilian | Combat capable but non-aggressive");
    }

    // FIXER ASSOCIATES
    public static func Barry() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("barry").SetClassification("NCPD - OFFICER")
            .SetBackground("NCPD officer struggling with depression. Neighbor of V. Contemplating suicide after partner's death.")
            .SetEarlyLife("Joined NCPD seeking to help community. Years of trauma accumulated.")
            .SetSignificantEvents("2077: Partner Andrew killed. Mental health crisis. Requires intervention.")
            .SetAffiliation("NCPD | Megabuilding H10 resident")
            .SetCriminalRecord("CLEAN | Active duty officer")
            .SetMedicalStatus("CRITICAL - Mental health crisis | Suicide risk")
            .SetThreatAssessment("LOW | Armed officer | Currently non-threatening | Needs help");
    }

    // MORE FIXERS/ASSOCIATES
    public static func CassiusRyder() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("cassius_ryder").SetClassification("MEDIA - JOURNALIST")
            .SetBackground("Investigative journalist. Works on corporate exposés. High-risk reporting on Night City corruption.")
            .SetAffiliation("Independent Media")
            .SetCriminalRecord("Trespassing | Corporate lawsuits (ongoing)")
            .SetThreatAssessment("LOW | Civilian | Media connections | Protected sources");
    }

    public static func OctavioRuiz() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("octavio_ruiz").SetClassification("VALENTINOS - ASSOCIATE")
            .SetBackground("Valentinos-connected businessman. Operates legitimate fronts. Money laundering suspected.")
            .SetAffiliation("Valentinos | Business interests")
            .SetCriminalRecord("Under investigation | No charges filed")
            .SetThreatAssessment("MODERATE | Gang connections | Financial resources");
    }

    public static func RobertBodean() -> ref<UniqueNPCBackstory> {
        return UniqueNPCBackstory.Create("robert_bodean").SetClassification("CIVILIAN - BUSINESS")
            .SetBackground("Night City businessman. Various legitimate and semi-legitimate enterprises.")
            .SetAffiliation("Independent business")
            .SetCriminalRecord("Minor violations | Tax disputes")
            .SetThreatAssessment("LOW | Civilian | Business connections");
    }
}
