// Kiroshi Deep Scan Protocol - Unique NPC Entries v1.5

public abstract class KdspQuestProgressHelper {
    public static func IsFactSet(factName: CName) -> Bool {
        let qs = GameInstance.GetQuestsSystem(GetGameInstance());
        return IsDefined(qs) && qs.GetFact(factName) > 0;
    }
    public static func IsHeistCompleted() -> Bool {
        return KdspQuestProgressHelper.IsFactSet(n"q005_done") || KdspQuestProgressHelper.IsFactSet(n"q101_started");
    }
    public static func IsEvelynDead() -> Bool { return KdspQuestProgressHelper.IsFactSet(n"q109_done"); }
    public static func IsRhyneDead() -> Bool { return KdspQuestProgressHelper.IsFactSet(n"sq026_done"); }
    public static func IsFoughtTheLawDone() -> Bool { return KdspQuestProgressHelper.IsFactSet(n"sq012_done"); }
    public static func IsDreamOnDone() -> Bool { return KdspQuestProgressHelper.IsFactSet(n"sq006_done"); }
}

public abstract class KdspUniqueNPCEntries {

    public static func GetEntry(recordId: String) -> ref<KdspUniqueNPCBackstory> {
        let id = StrLower(recordId);
        
        // ARASAKA
        if StrContains(id, "takemura") { return KdspUniqueNPCEntries.Takemura(); }
        if StrContains(id, "saburo") && !StrContains(id, "guard") { return KdspUniqueNPCEntries.SaburoArasaka(); }
        if StrContains(id, "yorinobu") && !StrContains(id, "guard") { return KdspUniqueNPCEntries.YorinobuArasaka(); }
        if StrContains(id, "hanako") && !StrContains(id, "guard") && !StrContains(id, "bodyguard") { return KdspUniqueNPCEntries.HanakoArasaka(); }
        if StrContains(id, "oda") && !StrContains(id, "coda") && !StrContains(id, "toda") && !StrContains(id, "soda") && !StrContains(id, "pagoda") && !StrContains(id, "today") && !StrContains(id, "yoda") && !StrContains(id, "modal") { return KdspUniqueNPCEntries.SandayuOda(); }
        if StrContains(id, "smasher") { return KdspUniqueNPCEntries.AdamSmasher(); }
        if StrContains(id, "hellman") { return KdspUniqueNPCEntries.AndersHellman(); }
        // MILITECH
        if StrContains(id, "meredith") { return KdspUniqueNPCEntries.MeredithStout(); }
        if StrContains(id, "weldon") && StrContains(id, "holt") { return KdspUniqueNPCEntries.WeldonHolt(); }
        // FIXERS
        if (StrContains(id, "dex") && !StrContains(id, "index") && !StrContains(id, "dext") && !StrContains(id, "codex") && !StrContains(id, "latex")) || StrContains(id, "deshawn") { return KdspUniqueNPCEntries.DexterDeShawn(); }
        if StrContains(id, "wakako") { return KdspUniqueNPCEntries.WakakoOkada(); }
        if StrContains(id, "regina") && StrContains(id, "jones") { return KdspUniqueNPCEntries.ReginaJones(); }
        if StrContains(id, "padre") && !StrContains(id, "compadre") { return KdspUniqueNPCEntries.Padre(); }
        if StrContains(id, "dakota") { return KdspUniqueNPCEntries.DakotaSmith(); }
        if StrContains(id, "dino") && !StrContains(id, "dinosaur") && (StrContains(id, "dinovic") || StrContains(id, "fixer")) { return KdspUniqueNPCEntries.DinoDinovic(); }
        if StrContains(id, "hands") && (StrContains(id, "mr") || StrContains(id, "mister") || StrContains(id, "fixer")) && !StrContains(id, "handsome") && !StrContains(id, "handshake") { return KdspUniqueNPCEntries.MrHands(); }
        if (StrContains(id, "capitan") || StrContains(id, "muamar")) && !StrContains(id, "driver") { return KdspUniqueNPCEntries.ElCapitan(); }
        // MERCS / AFTERLIFE
        if StrContains(id, "jackie") && !StrContains(id, "jacket") { return KdspUniqueNPCEntries.JackieWelles(); }
        if StrContains(id, "emmerick") || (StrContains(id, "bronson") && !StrContains(id, "action")) { return KdspUniqueNPCEntries.EmmerickBronson(); }
        if StrContains(id, "tbug") || StrContains(id, "t_bug") { return KdspUniqueNPCEntries.TBug(); }
        if StrContains(id, "rogue") && !StrContains(id, "rogue_") && !StrContains(id, "roguelike") && (StrContains(id, "amendiares") || StrContains(id, "afterlife") || StrContains(id, "fixer")) { return KdspUniqueNPCEntries.RogueAmendiares(); }
        if StrContains(id, "squama") || StrContains(id, "crispin") || StrContains(id, "weyland") { return KdspUniqueNPCEntries.CrispinWeyland(); }
        if (StrContains(id, "johnny") && StrContains(id, "silverhand")) || StrContains(id, "silverhand") { return KdspUniqueNPCEntries.JohnnySilverhand(); }
        if StrContains(id, "kerry") && (StrContains(id, "eurodyne") || StrContains(id, "musician") || StrContains(id, "rocker") || StrContains(id, "samurai")) { return KdspUniqueNPCEntries.KerryEurodyne(); }
        if StrContains(id, "alt") && StrContains(id, "cunningham") { return KdspUniqueNPCEntries.AltCunningham(); }
        if StrContains(id, "claire") && !StrContains(id, "eclair") && (StrContains(id, "russell") || StrContains(id, "bartender") || StrContains(id, "afterlife")) { return KdspUniqueNPCEntries.ClaireRussell(); }
        // RIPPERDOCS
        if (StrContains(id, "viktor") && !StrContains(id, "viktorovich") && !StrContains(id, "viktorovna")) || StrContains(id, "vektor") { return KdspUniqueNPCEntries.ViktorVektor(); }
        if StrContains(id, "finger") && !StrContains(id, "fingerprint") && !StrContains(id, "fingernail") && (StrContains(id, "ripperdoc") || StrContains(id, "doc") || StrContains(id, "clinic") || StrContains(id, "fingers")) { return KdspUniqueNPCEntries.Fingers(); }
        if StrContains(id, "misty") && !StrContains(id, "mistyped") && !StrContains(id, "misty_fog") && (StrContains(id, "olszewski") || StrContains(id, "esoterica") || StrContains(id, "shop")) { return KdspUniqueNPCEntries.MistyOlszewski(); }
        if StrContains(id, "lucy") && StrContains(id, "thackery") { return KdspUniqueNPCEntries.LucyThackery(); }
        // MOX / CLOUDS
        if StrContains(id, "judy") { return KdspUniqueNPCEntries.JudyAlvarez(); }
        if StrContains(id, "evelyn") { return KdspUniqueNPCEntries.EvelynParker(); }
        if StrContains(id, "maiko") { return KdspUniqueNPCEntries.MaikoMaeda(); }
        if StrContains(id, "woodman") { return KdspUniqueNPCEntries.Woodman(); }
        // ALDECALDOS
        if StrContains(id, "panam") { return KdspUniqueNPCEntries.PanamPalmer(); }
        if StrContains(id, "saul") && !StrContains(id, "assault") && !StrContains(id, "saulter") && (StrContains(id, "bright") || StrContains(id, "aldecaldo")) { return KdspUniqueNPCEntries.SaulBright(); }
        if StrContains(id, "mitch") && !StrContains(id, "switch") && !StrContains(id, "glitch") && !StrContains(id, "stitch") && !StrContains(id, "snitch") && !StrContains(id, "twitch") && !StrContains(id, "bitch") && (StrContains(id, "anderson") || StrContains(id, "aldecaldo")) { return KdspUniqueNPCEntries.MitchAnderson(); }
        // VOODOO BOYS
        if StrContains(id, "brigitte") && !StrContains(id, "maman") { return KdspUniqueNPCEntries.Brigitte(); }
        if StrContains(id, "placide") { return KdspUniqueNPCEntries.Placide(); }
        // MAELSTROM
        if StrContains(id, "royce") && !StrContains(id, "joyce") { return KdspUniqueNPCEntries.Royce(); }
        if StrContains(id, "dum") && !StrContains(id, "medium") && !StrContains(id, "random") && !StrContains(id, "endum") && !StrContains(id, "dumc") && !StrContains(id, "dumb") { return KdspUniqueNPCEntries.DumDum(); }
        if StrContains(id, "brick") && !StrContains(id, "brickwork") && !StrContains(id, "brickwall") && (StrContains(id, "maelstrom") || StrContains(id, "totentanz")) { return KdspUniqueNPCEntries.Brick(); }
        // XBD EDITORS
        if StrContains(id, "gottfrid") || (StrContains(id, "persson") && StrContains(id, "father")) { return KdspUniqueNPCEntries.GottfridPersson(); }
        if StrContains(id, "fredrik") && StrContains(id, "persson") { return KdspUniqueNPCEntries.FredrikPersson(); }
        // NCPD / POLITICS
        if StrContains(id, "river") && StrContains(id, "ward") && !StrContains(id, "driver") { return KdspUniqueNPCEntries.RiverWard(); }
        if StrContains(id, "jefferson") && StrContains(id, "peralez") { return KdspUniqueNPCEntries.JeffersonPeralez(); }
        if StrContains(id, "elizabeth") && StrContains(id, "peralez") { return KdspUniqueNPCEntries.ElizabethPeralez(); }
        if StrContains(id, "peralez") { return KdspUniqueNPCEntries.JeffersonPeralez(); }
        if StrContains(id, "rhyne") { return KdspUniqueNPCEntries.LuciusRhyne(); }
        // OTHER
        if StrContains(id, "nibbles") { return KdspUniqueNPCEntries.Nibbles(); }
        if StrContains(id, "delamain") { return KdspUniqueNPCEntries.Delamain(); }
        if StrContains(id, "mama") && StrContains(id, "welles") { return KdspUniqueNPCEntries.MamaWelles(); }
        // TYGER CLAWS
        if StrContains(id, "jotaro") || StrContains(id, "shobo") { return KdspUniqueNPCEntries.JotaroShobo(); }
        if StrContains(id, "hiromi") && StrContains(id, "sato") { return KdspUniqueNPCEntries.HiromiSato(); }
        // VALENTINOS
        if (StrContains(id, "gustavo") || (StrContains(id, "orta") && StrContains(id, "valentino"))) && !StrContains(id, "escort") && !StrContains(id, "transport") && !StrContains(id, "porta") && !StrContains(id, "morta") && !StrContains(id, "corta") && !StrContains(id, "forta") { return KdspUniqueNPCEntries.GustavoOrta(); }
        if StrContains(id, "jose") && StrContains(id, "luis") { return KdspUniqueNPCEntries.JoseLuis(); }
        // ANIMALS
        if StrContains(id, "sasquatch") { return KdspUniqueNPCEntries.Sasquatch(); }
        // WRAITHS
        if StrContains(id, "nash") && !StrContains(id, "gnash") && !StrContains(id, "nashville") && !StrContains(id, "smash") && (StrContains(id, "wraith") || StrContains(id, "badlands")) { return KdspUniqueNPCEntries.Nash(); }
        // SCAVENGERS
        if StrContains(id, "anton") && StrContains(id, "kolos") { return KdspUniqueNPCEntries.AntonKolos(); }
        // NETWATCH
        if StrContains(id, "bryce") && StrContains(id, "mosley") { return KdspUniqueNPCEntries.BryceMosley(); }
        // MEDIA
        if StrContains(id, "gillean") || (StrContains(id, "jordan") && StrContains(id, "n54")) { return KdspUniqueNPCEntries.GilleanJordan(); }
        if StrContains(id, "max") && StrContains(id, "jones") && !StrContains(id, "maxtac") && !StrContains(id, "maxdoc") && !StrContains(id, "maximum") { return KdspUniqueNPCEntries.MaxJones(); }
        // CORPO SECURITY
        if StrContains(id, "graham") && (StrContains(id, "mayfield") || StrContains(id, "security") || StrContains(id, "corpo")) { return KdspUniqueNPCEntries.GrahamMayfield(); }
        if StrContains(id, "militech") && StrContains(id, "commander") { return KdspUniqueNPCEntries.MilitechCommander(); }
        // RIPPERDOCS
        if StrContains(id, "charles") && StrContains(id, "bucks") { return KdspUniqueNPCEntries.CharlesBucks(); }
        if StrContains(id, "robert") && StrContains(id, "bodean") { return KdspUniqueNPCEntries.RobertBodean(); }
        if StrContains(id, "cassius") && StrContains(id, "ryder") { return KdspUniqueNPCEntries.CassiusRyder(); }
        if StrContains(id, "octavio") && StrContains(id, "ruiz") { return KdspUniqueNPCEntries.OctavioRuiz(); }
        // VENDORS
        if StrContains(id, "wilson") && (StrContains(id, "2nd") || StrContains(id, "second") || StrContains(id, "gun") || StrContains(id, "weapon") || StrContains(id, "amendment")) { return KdspUniqueNPCEntries.Wilson(); }
        if StrContains(id, "coach") && StrContains(id, "fred") { return KdspUniqueNPCEntries.CoachFred(); }
        // BARTENDERS
        if StrContains(id, "nix") && !StrContains(id, "phoenix") && !StrContains(id, "nixie") && (StrContains(id, "afterlife") || StrContains(id, "netrunner") || StrContains(id, "bartender")) { return KdspUniqueNPCEntries.Nix(); }
        // OTHER CHARACTERS
        if StrContains(id, "brendan") && (StrContains(id, "vending") || StrContains(id, "machine") || StrContains(id, "ai") || StrContains(id, "bot")) { return KdspUniqueNPCEntries.Brendan(); }
        if StrContains(id, "mq010_barry") { return KdspUniqueNPCEntries.Barry(); }
        if StrContains(id, "mq010_mendez") { return KdspUniqueNPCEntries.JuanMendez(); }
        if StrContains(id, "mq010_petrova") { return KdspUniqueNPCEntries.NadiaPetrova(); }
        if StrContains(id, "joshua") && StrContains(id, "stephenson") { return KdspUniqueNPCEntries.JoshuaStephenson(); }
        if StrContains(id, "blue") && StrContains(id, "moon") && !StrContains(id, "blueprint") { return KdspUniqueNPCEntries.BlueMoon(); }
        if StrContains(id, "lizzy") && StrContains(id, "wizzy") { return KdspUniqueNPCEntries.LizzyWizzy(); }
        if StrContains(id, "ozob") { return KdspUniqueNPCEntries.Ozob(); }
        if StrContains(id, "skippy") { return KdspUniqueNPCEntries.Skippy(); }
        if StrContains(id, "maman") && StrContains(id, "brigitte") { return KdspUniqueNPCEntries.Brigitte(); }
        // AFTERLIFE - OTHER
        if StrContains(id, "dennis") && StrContains(id, "cranmer") { return KdspUniqueNPCEntries.DennisCranmer(); }
        // NETRUNNERS
        if StrContains(id, "r3n0") || (StrContains(id, "reno") && StrContains(id, "netrunner") && !StrContains(id, "moreno") && !StrContains(id, "sereno")) { return KdspUniqueNPCEntries.R3n0(); }
        // RIOT CLUB
        if StrContains(id, "liam") && StrContains(id, "northom") { return KdspUniqueNPCEntries.LiamNorthom(); }
        if StrContains(id, "asa") && StrContains(id, "risu") && !StrContains(id, "arasaka") && !StrContains(id, "nasa") { return KdspUniqueNPCEntries.AsaRisu(); }
        if StrContains(id, "ralph") && StrContains(id, "logan") && !StrContains(id, "slogan") { return KdspUniqueNPCEntries.RalphLogan(); }
        if StrContains(id, "linda") && StrContains(id, "spencer") && !StrContains(id, "dispenser") { return KdspUniqueNPCEntries.LindaSpencer(); }
        if StrContains(id, "jermaine") && StrContains(id, "norton") { return KdspUniqueNPCEntries.JermaineNorton(); }
        // VENDORS - CLOTHING
        if StrContains(id, "zane") && StrContains(id, "jagger") && !StrContains(id, "insane") { return KdspUniqueNPCEntries.ZaneJagger(); }
        // PHANTOM LIBERTY
        if StrContains(id, "songbird") || StrContains(id, "song_so_mi") || StrContains(id, "so_mi") { return KdspUniqueNPCEntries.Songbird(); }
        if (StrContains(id, "solomon") && StrContains(id, "reed")) || (StrContains(id, "reed") && !StrContains(id, "gang") && !StrContains(id, "soldier") && !StrContains(id, "grunt") && !StrContains(id, "breed") && !StrContains(id, "greed") && !StrContains(id, "freed") && !StrContains(id, "creed") && (StrContains(id, "fixer") || StrContains(id, "nusa") || StrContains(id, "fia") || StrContains(id, "agent") || StrContains(id, "dogtown"))) { return KdspUniqueNPCEntries.SolomonReed(); }
        if StrContains(id, "president_myers") || StrContains(id, "rosalind_myers") || Equals(id, "character.myers") || (StrContains(id, "myers") && (StrContains(id, "nusa") || StrContains(id, "president"))) { return KdspUniqueNPCEntries.RosalindMyers(); }
        if StrContains(id, "kurt") && StrContains(id, "hansen") { return KdspUniqueNPCEntries.KurtHansen(); }
        if Equals(id, "character.alex") || StrContains(id, "xenakis") || StrContains(id, "alena") { return KdspUniqueNPCEntries.AlenaXenakis(); }
        // PL VENDORS - LONGSHORE STACKS
        if StrContains(id, "cz_con_gunsmith") || (StrContains(id, "leon") && StrContains(id, "watson")) { return KdspUniqueNPCEntries.LeonWatson(); }
        if StrContains(id, "cz_con_ripdoc") || StrContains(id, "lahovary") { return KdspUniqueNPCEntries.CostinLahovary(); }
        if StrContains(id, "q302_homeless_scav_caliente") || (StrContains(id, "q302") && StrContains(id, "roland")) { return KdspUniqueNPCEntries.RonaldMalone(); }
        if StrContains(id, "cz_con_medicstore") || (StrContains(id, "susanna") && StrContains(id, "mack")) { return KdspUniqueNPCEntries.SusannaMack(); }
        // PL - ANIMALS / NO EASY WAY OUT
        if StrContains(id, "mq306_angie") || StrContains(id, "angelica") || StrContains(id, "whelan") { return KdspUniqueNPCEntries.AngelicaWhelan(); }
        if StrContains(id, "mq306_damir") || StrContains(id, "kovac") { return KdspUniqueNPCEntries.DamirKovac(); }
        if StrContains(id, "mq306_aaron") || (StrContains(id, "aaron") && StrContains(id, "waines")) { return KdspUniqueNPCEntries.AaronWaines(); }
        if StrContains(id, "mq306_boxer") || (StrContains(id, "william") && StrContains(id, "correy")) { return KdspUniqueNPCEntries.WilliamCorrey(); }
        // PL - GIGS
        if StrContains(id, "ep1_12_alan_noel") || (StrContains(id, "alan") && StrContains(id, "noel")) { return KdspUniqueNPCEntries.AlanNoel(); }
        if StrContains(id, "ep1_12_courier") || (StrContains(id, "kyle") && StrContains(id, "araujo")) { return KdspUniqueNPCEntries.KyleAraujo(); }
        // PL - GIG: DOGTOWN SAINTS
        if StrContains(id, "sts_ep1_01__nika") { return KdspUniqueNPCEntries.NikaYankovich(); }
        if StrContains(id, "sts_ep1_01__priest") { return KdspUniqueNPCEntries.OdellBlanco(); }
        if StrContains(id, "sts_ep1_01__anthony") { return KdspUniqueNPCEntries.AnthonyAndersonRipper(); }
        // PL - GIG: PROTOTYPE IN THE SCRAPER
        if StrContains(id, "_mq306__damir") { return KdspUniqueNPCEntries.HasanDemir(); }
        // PL - GIG: WAITING FOR DODGER
        if StrContains(id, "sts_ep1_10__bill") { return KdspUniqueNPCEntries.BillMitchel(); }
        if StrContains(id, "sts_ep1_10__charles") { return KdspUniqueNPCEntries.CharlesWilson(); }
        if StrContains(id, "sts_ep1_10__dodger") { return KdspUniqueNPCEntries.CarlRobinson(); }
        // PL - GIG: THE MAN WHO KILLED JASON FOREMAN
        if StrContains(id, "sts_ep1_03__hanna") { return KdspUniqueNPCEntries.BrianaDolson(); }
        // PL - GIG: SPY IN THE JUNGLE
        if StrContains(id, "sts_ep1_08__steven") { return KdspUniqueNPCEntries.StevenSantos(); }
        if StrContains(id, "sts_ep1_08__janet") { return KdspUniqueNPCEntries.AnaFriedman(); }
        if StrContains(id, "sts_ep1_08__fiodor") { return KdspUniqueNPCEntries.BorisRibakov(); }
        if StrContains(id, "sts_ep1_08__katya") { return KdspUniqueNPCEntries.KatyaKarelina(); }
        // PL - GIG: TALENT ACADEMY
        if StrContains(id, "sts_ep1_13__netrunner") { return KdspUniqueNPCEntries.Baird(); }
        if StrContains(id, "sts_ep1_13__tom") { return KdspUniqueNPCEntries.TommieWalker(); }
        if StrContains(id, "sts_ep1_13__fiona") { return KdspUniqueNPCEntries.FionaVargas(); }
        // PL - GIG: HEAVIEST OF HEARTS
        if StrContains(id, "sts_ep1_06__client") { return KdspUniqueNPCEntries.MichaelMaldonado(); }
        if StrContains(id, "sts_ep1_06__georgina") { return KdspUniqueNPCEntries.GeorginaZembinsky(); }
        // PL - GIG: ROADS TO REDEMPTION
        if StrContains(id, "sts_ep1_07__nele") { return KdspUniqueNPCEntries.NeleSpringer(); }
        // PL VENDORS - EBM PETROCHEM STADIUM
        if StrContains(id, "cz_stadium_medic") || (StrContains(id, "saki") && StrContains(id, "seo")) { return KdspUniqueNPCEntries.SakiSeo(); }
        if StrContains(id, "cz_stadium_ripperdoc") || (StrContains(id, "eron") && StrContains(id, "acedo")) { return KdspUniqueNPCEntries.EronAcedo(); }
        if StrContains(id, "cz_stadium_black_market") || (StrContains(id, "herold") && StrContains(id, "lowe")) { return KdspUniqueNPCEntries.HeroldLowe(); }
        if StrContains(id, "cz_stadium_netrunner") || (StrContains(id, "sammy") && StrContains(id, "taylor")) { return KdspUniqueNPCEntries.SammyTaylor(); }
        if (StrContains(id, "stadium_junk") && StrContains(id, "marcin")) || (StrContains(id, "marcin") && StrContains(id, "iwinski")) { return KdspUniqueNPCEntries.MarcinIwinski(); }
        if (StrContains(id, "stadium_junk") && StrContains(id, "michal")) || (StrContains(id, "michal") && StrContains(id, "kicinski")) { return KdspUniqueNPCEntries.MichalKicinski(); }
        if StrContains(id, "cz_stadium_clothing") || (StrContains(id, "david") && StrContains(id, "walker")) { return KdspUniqueNPCEntries.DavidWalker(); }
        if StrContains(id, "cz_stadium_gunsmith") || (StrContains(id, "sophia") && StrContains(id, "dupont")) { return KdspUniqueNPCEntries.SophiaDupont(); }
        // BODYGUARDS - Generic entries for named character bodyguards
        if StrContains(id, "hanako") && (StrContains(id, "guard") || StrContains(id, "bodyguard")) { return KdspUniqueNPCEntries.HanakoBodyguard(); }
        if StrContains(id, "arasaka") && (StrContains(id, "guard") || StrContains(id, "bodyguard")) { return KdspUniqueNPCEntries.ArasakaBodyguard(); }
        // CYBERPSYCHOS
        if StrContains(id, "zaria") && StrContains(id, "hughes") { return KdspUniqueNPCEntries.ZariaHughes(); }
        if StrContains(id, "ellis") && StrContains(id, "carter") { return KdspUniqueNPCEntries.EllisCarter(); }
        if StrContains(id, "lely") && StrContains(id, "hein") { return KdspUniqueNPCEntries.LelyHein(); }
        if StrContains(id, "mower") && !StrContains(id, "lawnmower") { return KdspUniqueNPCEntries.LtMower(); }
        if StrContains(id, "cedric") && StrContains(id, "muller") { return KdspUniqueNPCEntries.CedricMuller(); }
        if StrContains(id, "gaston") && StrContains(id, "phillips") { return KdspUniqueNPCEntries.GastonPhillips(); }
        if StrContains(id, "dao") && StrContains(id, "hyunh") { return KdspUniqueNPCEntries.DaoHyunh(); }
        if StrContains(id, "diego") && StrContains(id, "ramirez") { return KdspUniqueNPCEntries.DiegoRamirez(); }
        if StrContains(id, "tamara") && StrContains(id, "cosby") { return KdspUniqueNPCEntries.TamaraCosby(); }
        if StrContains(id, "matt") && StrContains(id, "liaw") { return KdspUniqueNPCEntries.MattLiaw(); }
        if StrContains(id, "chase") && StrContains(id, "coley") { return KdspUniqueNPCEntries.ChaseColey(); }
        if StrContains(id, "russel") && StrContains(id, "greene") { return KdspUniqueNPCEntries.RusselGreene(); }
        if StrContains(id, "zion") && StrContains(id, "wylde") { return KdspUniqueNPCEntries.ZionWylde(); }
        if StrContains(id, "norio") && StrContains(id, "akuhara") { return KdspUniqueNPCEntries.NorioAkuhara(); }
        if StrContains(id, "shinobu") && StrContains(id, "imai") { return KdspUniqueNPCEntries.ShinobuImai(); }
        if StrContains(id, "kaiser") && StrContains(id, "herzog") { return KdspUniqueNPCEntries.KaiserHerzog(); }
        if StrContains(id, "tom") && StrContains(id, "ayer") { return KdspUniqueNPCEntries.TomAyer(); }
        if StrContains(id, "alec") && StrContains(id, "johnson") { return KdspUniqueNPCEntries.AlecJohnson(); }
        if StrContains(id, "tracy") && StrContains(id, "phillips") { return KdspUniqueNPCEntries.TracyPhillips(); }
        // ASSAULT IN PROGRESS / NCPD SCANNER
        if StrContains(id, "rufus") && StrContains(id, "mcbride") { return KdspUniqueNPCEntries.RufusMcBride(); }
        if StrContains(id, "euralio") && StrContains(id, "alma") { return KdspUniqueNPCEntries.EuralioAlma(); }
        if StrContains(id, "bruce") && StrContains(id, "ward") { return KdspUniqueNPCEntries.BruceWard(); }
        if StrContains(id, "zoe") && StrContains(id, "alonzo") { return KdspUniqueNPCEntries.ZoeAlonzo(); }
        if StrContains(id, "miguel") && StrContains(id, "rodriguez") { return KdspUniqueNPCEntries.MiguelRodriguez(); }
        if StrContains(id, "denzel") && StrContains(id, "cryer") { return KdspUniqueNPCEntries.DenzelCryer(); }
        if StrContains(id, "jesse") && StrContains(id, "sabara") { return KdspUniqueNPCEntries.JesseSabara(); }
        if StrContains(id, "stanislaus") && StrContains(id, "zbyszko") { return KdspUniqueNPCEntries.StanislausZbyszko(); }
        if StrContains(id, "ben") && StrContains(id, "debaillon") { return KdspUniqueNPCEntries.BenDeBaillon(); }
        if StrContains(id, "ayo") && StrContains(id, "zarin") { return KdspUniqueNPCEntries.AyoZarin(); }
        if StrContains(id, "ross") && StrContains(id, "ulmer") { return KdspUniqueNPCEntries.RossUlmer(); }
        if StrContains(id, "anton") && StrContains(id, "kolev") { return KdspUniqueNPCEntries.AntonKolev(); }
        if StrContains(id, "john") && StrContains(id, "quaid") { return KdspUniqueNPCEntries.JohnQuaid(); }
        if StrContains(id, "darius") && StrContains(id, "miles") { return KdspUniqueNPCEntries.DariusMiles(); }
        if StrContains(id, "paul") && StrContains(id, "craven") { return KdspUniqueNPCEntries.PaulCraven(); }
        if StrContains(id, "olga") && StrContains(id, "longmead") { return KdspUniqueNPCEntries.OlgaLongmead(); }
        if StrContains(id, "mike") && StrContains(id, "kowalsky") { return KdspUniqueNPCEntries.MikeKowalsky(); }
        if StrContains(id, "samantha") && StrContains(id, "samu") { return KdspUniqueNPCEntries.SamanthaSamu(); }
        if StrContains(id, "barry") && StrContains(id, "alken") { return KdspUniqueNPCEntries.BarryAlken(); }
        if StrContains(id, "mokomichi") && StrContains(id, "yamada") { return KdspUniqueNPCEntries.MokomichiYamada(); }
        // NOTABLE RESIDENTS
        if StrContains(id, "big") && StrContains(id, "pete") { return KdspUniqueNPCEntries.BigPete(); }
        if StrContains(id, "bruce") && StrContains(id, "welby") { return KdspUniqueNPCEntries.BruceWelby(); }
        if StrContains(id, "benedict") && StrContains(id, "mcadams") { return KdspUniqueNPCEntries.BenedictMcAdams(); }
        if StrContains(id, "iris") && StrContains(id, "tanner") { return KdspUniqueNPCEntries.IrisTanner(); }
        if StrContains(id, "jack") && StrContains(id, "mausser") { return KdspUniqueNPCEntries.JackMausser(); }
        if StrContains(id, "joanne") && StrContains(id, "koch") { return KdspUniqueNPCEntries.JoanneKoch(); }
        if StrContains(id, "eva") && StrContains(id, "cole") { return KdspUniqueNPCEntries.EvaCole(); }
        if StrContains(id, "tucker") && StrContains(id, "albach") { return KdspUniqueNPCEntries.TuckerAlbach(); }
        if StrContains(id, "rebeca") && StrContains(id, "price") { return KdspUniqueNPCEntries.RebecaPrice(); }
        if StrContains(id, "karubo") && StrContains(id, "bairei") { return KdspUniqueNPCEntries.KaruboBairei(); }
        if StrContains(id, "jake") && StrContains(id, "estevez") { return KdspUniqueNPCEntries.JakeEstevez(); }
        if StrContains(id, "jose") && StrContains(id, "luis") { return KdspUniqueNPCEntries.JoseLuis(); }
        if StrContains(id, "gustavo") && StrContains(id, "orta") { return KdspUniqueNPCEntries.GustavoOrta(); }
        if StrContains(id, "martha") && StrContains(id, "frakes") { return KdspUniqueNPCEntries.MarthaFrakes(); }
        if StrContains(id, "anthony") && StrContains(id, "anderson") { return KdspUniqueNPCEntries.AnthonyAnderson(); }
        if StrContains(id, "milko") && StrContains(id, "alexis") { return KdspUniqueNPCEntries.MilkoAlexis(); }
        if StrContains(id, "steven") && StrContains(id, "santos") { return KdspUniqueNPCEntries.StevenSantos(); }
        if StrContains(id, "ana") && StrContains(id, "friedman") { return KdspUniqueNPCEntries.AnaFriedman(); }
        if StrContains(id, "boris") && StrContains(id, "ribakov") { return KdspUniqueNPCEntries.BorisRibakov(); }
        if StrContains(id, "katya") && StrContains(id, "karelina") { return KdspUniqueNPCEntries.KatyaKarelina(); }
        if StrContains(id, "fiona") && StrContains(id, "vargas") { return KdspUniqueNPCEntries.FionaVargas(); }
        if StrContains(id, "leon") && StrContains(id, "rinder") { return KdspUniqueNPCEntries.LeonRinder(); }
        if StrContains(id, "briana") && StrContains(id, "dolson") { return KdspUniqueNPCEntries.BrianaDolson(); }
        if StrContains(id, "michael") && StrContains(id, "maldonado") { return KdspUniqueNPCEntries.MichaelMaldonado(); }
        if StrContains(id, "jasmine") && StrContains(id, "dixon") { return KdspUniqueNPCEntries.JasmineDixon(); }
        if StrContains(id, "juliet") && StrContains(id, "horrigan") { return KdspUniqueNPCEntries.JulietHorrigan(); }
        if StrContains(id, "logan") && StrContains(id, "garcia") { return KdspUniqueNPCEntries.LoganGarcia(); }
        if StrContains(id, "flavio") && (StrContains(id, "santos") || StrContains(id, "dos")) { return KdspUniqueNPCEntries.FlaviodosSantos(); }
        if StrContains(id, "vic") && StrContains(id, "vega") { return KdspUniqueNPCEntries.VicVega(); }
        // WATSON DISTRICT NOTABLES
        if StrContains(id, "roh") && (StrContains(id, "chi") || StrContains(id, "won")) { return KdspUniqueNPCEntries.RohChiWon(); }
        if (StrContains(id, "tiny") && StrContains(id, "mike")) || (StrContains(id, "mike") && StrContains(id, "kowalski") && !StrContains(id, "kowalsky")) { return KdspUniqueNPCEntries.TinyMike(); }
        if StrContains(id, "bryce") && StrContains(id, "stone") { return KdspUniqueNPCEntries.BryceStone(); }
        if StrContains(id, "hwangbo") || (StrContains(id, "dong") && StrContains(id, "gun")) { return KdspUniqueNPCEntries.HwangboDongGun(); }
        if StrContains(id, "max") && StrContains(id, "jones") && !StrContains(id, "andrew") { return KdspUniqueNPCEntries.MaxJones(); }
        if StrContains(id, "alois") && StrContains(id, "daquin") { return KdspUniqueNPCEntries.AloisDaquin(); }
        if StrContains(id, "hal") && StrContains(id, "cantos") { return KdspUniqueNPCEntries.HalCantos(); }
        if StrContains(id, "blake") && StrContains(id, "croyle") { return KdspUniqueNPCEntries.BlakeCroyle(); }
        if (StrContains(id, "jae") && StrContains(id, "hyun")) || (StrContains(id, "lee") && StrContains(id, "jae")) { return KdspUniqueNPCEntries.JaeHyunLee(); }
        if StrContains(id, "lucy") && StrContains(id, "thackery") { return KdspUniqueNPCEntries.LucyThackery(); }
        if StrContains(id, "jotaro") && StrContains(id, "shobo") { return KdspUniqueNPCEntries.JotaroShobo(); }
        if StrContains(id, "taki") && StrContains(id, "kenmochi") { return KdspUniqueNPCEntries.TakiKenmochi(); }
        if StrContains(id, "mikhail") && StrContains(id, "akulov") { return KdspUniqueNPCEntries.MikhailAkulov(); }
        if StrContains(id, "anna") && StrContains(id, "hamill") { return KdspUniqueNPCEntries.AnnaHamill(); }
        // WESTBROOK / JAPANTOWN NOTABLES
        if (StrContains(id, "beatrice") && StrContains(id, "trieste")) || StrContains(id, "8ug8ear") { return KdspUniqueNPCEntries.BeatriceEllenTrieste(); }
        if StrContains(id, "sergei") && StrContains(id, "karasinsky") { return KdspUniqueNPCEntries.SergeiKarasinsky(); }
        if !StrContains(id, "change") && !StrContains(id, "exchange") && ((StrContains(id, "chang") && StrContains(id, "hoon")) || (StrContains(id, "chang") && StrContains(id, "nam"))) { return KdspUniqueNPCEntries.ChangHoonNam(); }
        if StrContains(id, "lauren") && StrContains(id, "costigan") && !StrContains(id, "brad") { return KdspUniqueNPCEntries.LaurenCostigan(); }
        return null;
    }

    // === BODYGUARD ENTRIES ===
    public static func HanakoBodyguard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hanako_bodyguard").SetClassification("ARASAKA - PERSONAL SECURITY")
            .SetBackground("Elite Arasaka operative assigned to Hanako Arasaka's protective detail. Vetted through extensive background checks and loyalty conditioning.")
            .SetAffiliation("Arasaka | Personal Security Division")
            .SetCyberwareStatus("Military-grade combat implants | Sandevistan | Kerenzikov | Encrypted comms")
            .SetThreatAssessment("HIGH (78/100) | Advanced combat training | Will protect principal at all costs")
            .SetNotes("Part of multi-layer security detail. Reports directly to Oda. Trained to die for the Arasaka family.");
    }

    public static func ArasakaBodyguard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("arasaka_bodyguard").SetClassification("ARASAKA - SECURITY")
            .SetBackground("Professional Arasaka security operative. Recruited from military or law enforcement backgrounds.")
            .SetAffiliation("Arasaka | Corporate Security Division")
            .SetCyberwareStatus("Standard corporate security package | Combat optics | Reinforced skeleton")
            .SetThreatAssessment("MODERATE-HIGH (65/100) | Professional training | Coordinated tactics")
            .SetNotes("Well-equipped and trained. Works in coordinated teams. Full corporate backing.");
    }

    // === TAKEMURA (DYNAMIC) ===
    public static func Takemura() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("takemura").SetClassification("ARASAKA - DISAVOWED")
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
        return KdspUniqueNPCBackstory.Create("takemura").SetClassification("ARASAKA - PERSONAL SECURITY")
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
    public static func SaburoArasaka() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("saburo").SetClassification("DECEASED")
                .SetBackground("Born 1919 Tokyo. WWII Navy veteran. Founded Arasaka 1945.")
                .SetSignificantEvents("DECEASED. Died Konpeki Plaza. Age: 158. Official cause: Poisoning.")
                .SetAffiliation("Arasaka (Former CEO)").SetNotes("Death triggered corporate power struggle.");
        }
        return KdspUniqueNPCBackstory.Create("saburo").SetClassification("ARASAKA - CEO")
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
    public static func YorinobuArasaka() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("yorinobu").SetClassification("ARASAKA - CEO")
                .SetBackground("Son of Saburo. Former Steel Dragons rebel. Now commands Arasaka.")
                .SetSignificantEvents("Assumed CEO after father's death. Consolidating power.")
                .SetAffiliation("Arasaka | CEO")
                .SetThreatAssessment("EXTREME (90/100) | Commands Arasaka military")
                .SetNotes("New leadership. Power struggles ongoing.");
        }
        return KdspUniqueNPCBackstory.Create("yorinobu").SetClassification("ARASAKA - HEIR")
            .SetBackground("Son of Saburo. Led Steel Dragons rebellion for decades. Recently reconciled.")
            .SetSignificantEvents("At Konpeki Plaza. Father en route for meeting.")
            .SetAffiliation("Arasaka | Heir | Former: Steel Dragons")
            .SetThreatAssessment("HIGH (75/100) | Combat trained | Unpredictable")
            .SetNotes("History of rebellion. Reconciliation reasons unclear.");
    }

    // === STATIC ARASAKA ===
    public static func HanakoArasaka() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hanako").SetClassification("ARASAKA - EXECUTIVE")
            .SetBackground("Daughter of Saburo. Groomed for leadership. Skilled diplomat.")
            .SetAffiliation("Arasaka | Board Member | Kiji Faction")
            .SetCyberwareStatus("Minimal visible | Neural security: MAXIMUM")
            .SetThreatAssessment("MINIMAL (5/100) | MAXIMUM security | DO NOT ENGAGE")
            .SetRelationships("Saburo (Father) | Yorinobu (Brother) | Oda (Bodyguard)")
            .SetNotes("Any hostile action triggers global Arasaka response.");
    }

    public static func SandayuOda() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("oda").SetClassification("ARASAKA - PERSONAL SECURITY")
            .SetBackground("Elite bodyguard. Trained by Takemura. Protects Hanako Arasaka.")
            .SetCyberwareStatus("Mantis Blades (Custom) | Sandevistan | Kerenzikov | ELITE combat")
            .SetThreatAssessment("EXTREME (92/100) | Master swordsman | Military reflexes")
            .SetNotes("Will die protecting principal without hesitation.");
    }

    public static func AdamSmasher() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("smasher").SetClassification("ARASAKA - SPECIAL ASSETS")
            .SetBackground("Born 1989 NYC. Full cyborg since 2019. Arasaka's primary enforcer. Killed Johnny Silverhand 2023.")
            .SetAffiliation("Arasaka | Director of Special Operations")
            .SetCriminalRecord("Known kills: 500+ | War crimes: SEALED")
            .SetCyberwareStatus("FULL CYBORG | <2% organic | Sandevistan Mk.5 | Gorilla Arms | Projectile System")
            .SetThreatAssessment("MAXIMUM (100/100) | OMEGA-LEVEL | DO NOT ENGAGE")
            .SetNotes("WALKING WMD. No empathy. More machine than man. RUN ON SIGHT.");
    }

    public static func AndersHellman() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hellman").SetClassification("SCIENTIST")
            .SetBackground("Swedish neuroscientist. Created Relic biochip. Former Arasaka R&D lead.")
            .SetSignificantEvents("Departed Arasaka. Whereabouts unknown. Multiple parties seeking him.")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | HIGH VALUE intelligence")
            .SetNotes("Creator of Relic. Irreplaceable knowledge.");
    }

    // === MILITECH ===
    public static func MeredithStout() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("meredith").SetClassification("MILITECH - COUNTERINTELLIGENCE")
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

    public static func WeldonHolt() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("holt").SetClassification("MILITECH - EXECUTIVE")
            .SetBackground("Senior Militech executive. Political maneuvering expertise.")
            .SetAffiliation("Militech | Senior VP")
            .SetThreatAssessment("MODERATE (40/100) | Political threat: HIGH")
            .SetNotes("Influence extends beyond corporate sphere.");
    }

    // === FIXERS ===
    public static func DexterDeShawn() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("dex").SetClassification("FIXER - DECEASED")
                .SetSignificantEvents("DECEASED. Body in Night City landfill. Connected to Konpeki Plaza.")
                .SetNotes("Death connected to heist gone wrong.");
        }
        return KdspUniqueNPCBackstory.Create("dex").SetClassification("FIXER")
            .SetBackground("Night City fixer. Returned after 2 years absence. Known for big scores and ego.")
            .SetSignificantEvents("Recently returned. Setting up major operation.")
            .SetCyberwareStatus("Gold-plated cyberarm (signature)")
            .SetThreatAssessment("MODERATE (45/100) | Dangerous connections")
            .SetNotes("CAUTION: Known to cut loose ends. Always has exit strategy.");
    }

    public static func WakakoOkada() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("wakako").SetClassification("FIXER")
            .SetBackground("Japanese. Former Tyger Claws affiliate. 30+ years fixing in Westbrook/Japantown.")
            .SetAffiliation("Independent | Territory: Westbrook")
            .SetThreatAssessment("LOW (20/100) | INFLUENCE: EXTREME")
            .SetNotes("Do not underestimate. Betraying her is death sentence.");
    }

    public static func ReginaJones() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("regina").SetClassification("FIXER")
            .SetBackground("Former journalist. Watson fixer. Focus on cyberpsychos and corporate misconduct.")
            .SetAffiliation("Independent | Territory: Watson")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Well-connected")
            .SetNotes("Has conscience. Prefers non-lethal. Reliable employer.");
    }

    public static func Padre() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("padre").SetClassification("FIXER")
            .SetBackground("Sebastian Ibarra. Former priest. Heywood fixer. Respected by Valentinos.")
            .SetAffiliation("Independent | Territory: Heywood")
            .SetThreatAssessment("LOW (20/100) | Valentinos protection")
            .SetNotes("Cares about community. Won't take contracts against Heywood.");
    }

    public static func DakotaSmith() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dakota").SetClassification("FIXER")
            .SetBackground("Former Aldecaldos nomad. Badlands fixer. Bridge between city and desert.")
            .SetAffiliation("Independent | Territory: Badlands")
            .SetThreatAssessment("MODERATE (40/100) | Nomad backup available")
            .SetNotes("Best contact for Badlands work. Don't cross nomads through her.");
    }

    public static func DinoDinovic() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dino").SetClassification("FIXER")
            .SetBackground("European. City Center fixer. High-end contracts requiring discretion.")
            .SetAffiliation("Independent | Territory: City Center")
            .SetThreatAssessment("LOW (25/100) | Excellent protection")
            .SetNotes("Sophisticated. Expects professionalism.");
    }

    public static func MrHands() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hands").SetClassification("FIXER")
            .SetBackground("Identity unknown. Pacifica fixer. Never meets in person - hologram only.")
            .SetAffiliation("Independent | Territory: Pacifica")
            .SetThreatAssessment("UNKNOWN | Operates in hostile territory")
            .SetNotes("Enigmatic. Only fixer for Pacifica. Payment always honored.");
    }

    public static func ElCapitan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("capitan").SetClassification("FIXER")
            .SetBackground("Muamar Reyes. Former military. Santo Domingo fixer. Vehicle specialist.")
            .SetAffiliation("Independent | Territory: Santo Domingo")
            .SetThreatAssessment("MODERATE (50/100) | Combat veteran")
            .SetNotes("Professional. Specializes in vehicle-related contracts.");
    }

    // === MERCS / AFTERLIFE ===
    public static func JackieWelles() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("jackie").SetClassification("MERCENARY - DECEASED")
                .SetBackground("Heywood native. Former Valentinos. Merc partnered with V.")
                .SetSignificantEvents("DECEASED. Died during Konpeki Plaza extraction. Combat injuries.")
                .SetNotes("Died pursuing legend status. Honored by those who knew him.");
        }
        return KdspUniqueNPCBackstory.Create("jackie").SetClassification("MERCENARY")
            .SetBackground("Heywood native. Son of Mama Welles. Former Valentinos. Independent merc.")
            .SetSignificantEvents("Active merc. Working toward Afterlife recognition. Partner with V.")
            .SetCyberwareStatus("Gorilla Arms | Basic combat suite | Kiroshi optics")
            .SetThreatAssessment("HIGH (65/100) | Skilled combatant | Loyal")
            .SetRelationships("Mama Welles (Mother) | Misty (Girlfriend) | V (Partner)")
            .SetNotes("Ambitious. Dreams of legend status. Fiercely loyal.");
    }

    public static func EmmerickBronson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("emmerick_bronson").SetClassification("ANIMALS - AFTERLIFE SECURITY")
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

    public static func TBug() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("tbug").SetClassification("NETRUNNER - DECEASED")
                .SetSignificantEvents("DECEASED. Killed by Arasaka ICE during Konpeki Plaza breach.")
                .SetNotes("Killed by countermeasures during failed operation.");
        }
        return KdspUniqueNPCBackstory.Create("tbug").SetClassification("NETRUNNER")
            .SetBackground("Professional netrunner. Known for high-skill infiltration. Anonymous profile.")
            .SetCyberwareStatus("High-end netrunning suite | ICE-resistant mods")
            .SetThreatAssessment("HIGH (70/100) | Can breach most systems")
            .SetNotes("Elite netrunner. Anonymous by design.");
    }

    public static func RogueAmendiares() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rogue").SetClassification("FIXER - LEGENDARY")
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

    public static func CrispinWeyland() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("squama").SetClassification("AFTERLIFE - BODYGUARD")
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

    public static func JohnnySilverhand() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("johnny").SetClassification("ENGRAM - TERRORIST / ROCKERBOY")
            .SetBackground("Robert John Linder. Born 1988. Ex-NUSA Marine, deserted after Central America. Founded Samurai 2003. Most influential rockerboy of his generation. Anti-corporate revolutionary.")
            .SetEarlyLife("Military family. Deployed Central America. Went AWOL after witnessing corpo atrocities. Reinvented himself in Night City underground.")
            .SetSignificantEvents("2008: Alt Cunningham. 2013: Alt killed by Arasaka, digitized by Soulkiller. 2023: Nuked Arasaka Tower. Killed by Adam Smasher. Engram extracted.")
            .SetAffiliation("Samurai (frontman) | Aldecaldos (allied) | Anti-corpo underground")
            .SetCriminalRecord("TERRORISM | MASS MURDER | MILITARY DESERTION | FILE STATUS: CLOSED - DECEASED 2023")
            .SetCyberwareStatus("Cyberarm (left, silver) | Military-grade reflexes | Status: DESTROYED")
            .SetThreatAssessment("DECEASED | If engram exists: CATASTROPHIC risk to Arasaka")
            .SetNotes("THE Rockerboy. Narcissistic. Self-destructive. Genuinely believed in his cause. 50 years dead and still dangerous.");
    }

    public static func KerryEurodyne() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kerry").SetClassification("CELEBRITY - ROCKERBOY")
            .SetBackground("Born 1988. Samurai co-founder. Solo career. One of most famous musicians.")
            .SetSignificantEvents("Semi-retired North Oak. Occasional performances. Processing Johnny's legacy.")
            .SetFinancialStatus("Extremely wealthy | Royalties | North Oak estate")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Celebrity protection")
            .SetNotes("Living legend. Generous to those who earn trust.");
    }

    public static func AltCunningham() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alt").SetClassification("NETRUNNER - AI")
            .SetBackground("Legendary netrunner. Created Soulkiller. Consciousness digitized 2013. Exists beyond Blackwall.")
            .SetSignificantEvents("Physical death 2013. Digital consciousness beyond Blackwall. No longer human.")
            .SetThreatAssessment("INCALCULABLE in cyberspace | Cannot be engaged conventionally")
            .SetNotes("BEYOND HUMAN. Summoning carries extreme risk.");
    }

    public static func ClaireRussell() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("claire").SetClassification("AFTERLIFE - BARTENDER")
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
    public static func ViktorVektor() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("viktor").SetClassification("RIPPERDOC")
            .SetBackground("Former boxer. Watson ripperdoc. Quality work, fair prices. Trusted by merc community.")
            .SetSignificantEvents("Operates under Misty's Esoterica. Extends credit to trusted clients.")
            .SetThreatAssessment("LOW (10/100) | Non-combatant | Community protected")
            .SetRelationships("Misty (Partner) | Jackie (Client) | V (Client)")
            .SetNotes("One of the good ones. Ethical. Respected throughout Watson.");
    }

    public static func Fingers() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("fingers").SetClassification("RIPPERDOC")
            .SetBackground("Jig-Jig Street ripperdoc. Budget cyberware. Questionable ethics. Serves the desperate.")
            .SetCriminalRecord("Complaints on file | No charges | Tyger Claws protection")
            .SetThreatAssessment("VERY LOW (5/100) | Cowardly")
            .SetNotes("Unethical. Preys on vulnerable. Few would mourn his absence.");
    }

    public static func MistyOlszewski() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("misty").SetClassification("CIVILIAN - MYSTIC")
            .SetBackground("Runs Misty's Esoterica in Watson. Spiritual advisor. Tarot readings.")
            .SetRelationships("Jackie Welles (Boyfriend) | Viktor (Partner)")
            .SetThreatAssessment("NONE (0/100) | No threat")
            .SetNotes("Genuinely kind. Tarot readings eerily accurate. Heart of gold.");
    }

    // Note: detailed Lucy Thackery entry in Watson District Notables section

    // === MOX / CLOUDS ===
    public static func JudyAlvarez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("judy").SetClassification("TECHNICIAN - MOX")
            .SetBackground("Born Laguna Bend. BD technician at Lizzie's. Strong convictions about worker exploitation.")
            .SetAffiliation("The Mox | BD Technician")
            .SetCyberwareStatus("BD wreath (professional) | Neural interface")
            .SetThreatAssessment("MODERATE (35/100) | Technical threat via BD/hacking")
            .SetRelationships("Evelyn Parker (Friend) | The Mox (Family)")
            .SetNotes("Strong moral compass. Protective of friends.");
    }

    public static func EvelynParker() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsEvelynDead() {
            return KdspUniqueNPCBackstory.Create("evelyn").SetClassification("DECEASED")
                .SetSignificantEvents("DECEASED. Suicide following captivity and neural damage.")
                .SetNotes("Victim of Night City. Mourned by those who knew her.");
        }
        return KdspUniqueNPCBackstory.Create("evelyn").SetClassification("DOLL - CLOUDS")
            .SetBackground("Premium doll at Clouds. Ambitious. Connected to powerful clients including Yorinobu.")
            .SetThreatAssessment("LOW (15/100) | Has valuable information")
            .SetRelationships("Judy Alvarez (Friend) | Clouds (Employer)")
            .SetNotes("Playing dangerous game with powerful people. In over her head.");
    }

    public static func MaikoMaeda() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("maiko").SetClassification("TYGER CLAWS - CLOUDS")
            .SetBackground("Clouds manager. Former doll. Works for Tyger Claws. Ambitious corporate mindset.")
            .SetAffiliation("Tyger Claws | Clouds Manager")
            .SetThreatAssessment("MODERATE (40/100) | Tyger Claws backing")
            .SetRelationships("Judy Alvarez (Ex)")
            .SetNotes("Pragmatic. Will sacrifice others for advancement.");
    }

    public static func Woodman() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("woodman").SetClassification("TYGER CLAWS - CLOUDS")
            .SetBackground("Oswald Forrest. Clouds manager. Brutal management style. Exploits dolls.")
            .SetCriminalRecord("Suspected trafficking, assault | Tyger Claws protection")
            .SetThreatAssessment("HIGH (65/100) | Combat capable | Tyger Claws backing")
            .SetNotes("Brutal and exploitative. Few would mourn him.");
    }

    // === ALDECALDOS ===
    public static func PanamPalmer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("panam").SetClassification("NOMAD - ALDECALDOS")
            .SetBackground("Born Aldecaldos. Expert driver and mechanic. Fiercely independent.")
            .SetAffiliation("Aldecaldos | Driver")
            .SetCyberwareStatus("Vehicle interface | Targeting optics | Minimal chrome")
            .SetThreatAssessment("HIGH (70/100) | Expert driver | Combat capable | Clan backup")
            .SetRelationships("Aldecaldos (Family) | Saul (Complicated) | Mitch (Friend)")
            .SetNotes("Do not threaten her family. Valuable ally, dangerous enemy.");
    }

    public static func SaulBright() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("saul").SetClassification("NOMAD - ALDECALDOS")
            .SetBackground("Aldecaldos clan leader. Prioritizes clan survival. Pragmatic.")
            .SetAffiliation("Aldecaldos | Clan Chief")
            .SetThreatAssessment("HIGH (65/100) | Commands clan | Dangerous when clan threatened")
            .SetNotes("Decisions made for clan welfare. Can negotiate if mutual benefit.");
    }

    public static func MitchAnderson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mitch").SetClassification("NOMAD - ALDECALDOS")
            .SetBackground("Former military. Aldecaldos technician. Steady and reliable.")
            .SetCyberwareStatus("Military-grade optics | Combat implants | Vehicle interface")
            .SetThreatAssessment("MODERATE (55/100) | Combat veteran")
            .SetRelationships("Aldecaldos (Family) | Scorpion (Friend - deceased) | Panam (Friend)")
            .SetNotes("Solid and dependable. Grieving recent losses.");
    }

    // === VOODOO BOYS ===
    public static func Brigitte() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("brigitte").SetClassification("VOODOO BOYS - LEADER")
            .SetBackground("Maman Brigitte. VDB leader. Master netrunner. Obsessed with breaching Blackwall.")
            .SetAffiliation("Voodoo Boys | Leader")
            .SetCyberwareStatus("Elite netrunning suite | Blackwall-resistant mods")
            .SetThreatAssessment("EXTREME (85/100) | Master netrunner | Will betray anyone")
            .SetRelationships("Placide (Lieutenant) | Haitian community")
            .SetNotes("DANGEROUS. Views outsiders as tools. Do not trust.");
    }

    public static func Placide() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("placide").SetClassification("VOODOO BOYS - LIEUTENANT")
            .SetBackground("VDB lieutenant. Enforcer. Handles external contacts. Hostile to outsiders.")
            .SetCyberwareStatus("Combat netrunner suite | Physical augmentation")
            .SetThreatAssessment("HIGH (75/100) | Combat capable | Netrunner | VDB backup")
            .SetNotes("Will follow betrayal orders without hesitation. Never turn back on him.");
    }

    // === MAELSTROM ===
    public static func Royce() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("royce").SetClassification("MAELSTROM - LEADER")
            .SetBackground("Maelstrom gang leader. Extreme modification. Unstable personality.")
            .SetCriminalRecord("Murder, assault, arms dealing | Active warrants")
            .SetCyberwareStatus("EXTREME | Multiple optics | Combat chassis | Cyberpsychosis risk: HIGH")
            .SetThreatAssessment("EXTREME (80/100) | Heavily chromed | Unpredictable")
            .SetNotes("UNSTABLE. Cyberpsychosis indicators. Approach with extreme caution.");
    }

    public static func DumDum() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dumdum").SetClassification("MAELSTROM - LIEUTENANT")
            .SetBackground("Maelstrom lieutenant. Heavily modified but more stable than leadership.")
            .SetCyberwareStatus("Extensive modification | Combat focused | Humanity: LOW")
            .SetThreatAssessment("HIGH (70/100) | Combat cyborg | More stable than most Maelstrom")
            .SetNotes("Occasionally reasonable. Inhaler habit. Still will kill without hesitation.");
    }

    // === NCPD / POLITICS ===
    public static func RiverWard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("river").SetClassification("NCPD - DETECTIVE")
            .SetBackground("NCPD detective. Sometimes bends rules for justice. Family man. Strong moral compass.")
            .SetAffiliation("NCPD | Detective")
            .SetThreatAssessment("MODERATE (50/100) | Combat trained | NCPD resources")
            .SetRelationships("Joss (Sister) | NCPD (Complicated)")
            .SetNotes("Good cop in bad system. Trustworthy ally.");
    }

    public static func JeffersonPeralez() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsDreamOnDone() {
            return KdspUniqueNPCBackstory.Create("peralez").SetClassification("POLITICIAN - COMPROMISED")
                .SetBackground("Night City councilman. Frontrunner mayoral candidate. Anti-corruption platform. Previously retained V as private investigator. Public image remains spotless despite mounting anomalies in personal life.")
                .SetEarlyLife("Law degree from Night City University. Entered politics young. Built reputation on transparency and anti-gang initiatives in Heywood. One of the few politicians not wholly owned by corporate interests.")
                .SetSignificantEvents("City council election | Anti-corruption legislation | Mayor Rhyne investigation | Retained V for private case | Penthouse security breach | Anomalous behavioral shifts reported by close contacts")
                .SetAffiliation("Night City Council | Mayoral Candidate")
                .SetCriminalRecord("CLEAN | No charges | No warrants | Unusually clean for Night City politics")
                .SetCyberwareStatus("Standard civilian suite | Personal link | Neural implants - ACTIVITY FLAGGED")
                .SetFinancialStatus("Upper bracket | Campaign funding: legitimate sources verified | Personal assets: Charter Hill penthouse")
                .SetMedicalStatus("FLAGGED: Anomalous neural patterns detected | Implant activity inconsistent with registered hardware | Memory engram irregularities | Subject unaware of condition")
                .SetThreatAssessment("LOW (15/100) | Non-combatant | Private security detail | THIRD-PARTY INTEREST FLAGGED")
                .SetRelationships("Elizabeth Peralez (Wife) | Night City Council (Colleagues) | NCPD (Professional contacts)")
                .SetNotes("Believes himself to be in full control of his own mind. He is not. Someone is rewriting Night City's next mayor from the inside.");
        }
        if KdspQuestProgressHelper.IsFoughtTheLawDone() {
            return KdspUniqueNPCBackstory.Create("peralez").SetClassification("POLITICIAN - MAYORAL CANDIDATE")
                .SetBackground("Night City councilman. Frontrunner mayoral candidate. Anti-corruption platform. Previously retained V as private investigator regarding Mayor Rhyne's death.")
                .SetEarlyLife("Law degree from Night City University. Entered politics young. Built reputation on transparency and anti-gang initiatives in Heywood. One of the few politicians not wholly owned by corporate interests.")
                .SetSignificantEvents("City council election | Anti-corruption legislation | Mayor Rhyne investigation | Retained V for private case")
                .SetAffiliation("Night City Council | Mayoral Candidate")
                .SetCriminalRecord("CLEAN | No charges | No warrants | Unusually clean for Night City politics")
                .SetCyberwareStatus("Standard civilian suite | Personal link | Neural implants registered and compliant")
                .SetFinancialStatus("Upper bracket | Campaign funding: legitimate sources verified | Personal assets: Charter Hill penthouse")
                .SetMedicalStatus("Good | Regular checkups | Stress: ELEVATED (campaign pressure)")
                .SetThreatAssessment("LOW (15/100) | Non-combatant | Private security detail")
                .SetRelationships("Elizabeth Peralez (Wife) | Night City Council (Colleagues) | NCPD (Professional contacts)")
                .SetNotes("Rare genuine reformer. Campaign gaining momentum. Powerful interests are paying close attention.");
        }
        return KdspUniqueNPCBackstory.Create("peralez").SetClassification("POLITICIAN")
            .SetBackground("Night City councilman. Mayoral candidate. Anti-corruption platform. Genuinely idealistic. Runs on promise to clean up Night City governance.")
            .SetEarlyLife("Law degree from Night City University. Entered politics young. Built reputation on transparency and anti-gang initiatives in Heywood. One of the few politicians not wholly owned by corporate interests.")
            .SetSignificantEvents("City council election | Anti-corruption legislation | Mayoral campaign announcement")
            .SetAffiliation("Night City Council | Mayoral Candidate")
            .SetCriminalRecord("CLEAN | No charges | No warrants | Unusually clean for Night City politics")
            .SetCyberwareStatus("Standard civilian suite | Personal link | Neural implants registered and compliant")
            .SetFinancialStatus("Upper bracket | Campaign funding: legitimate sources verified | Personal assets: Charter Hill penthouse")
            .SetMedicalStatus("Good | Regular checkups | No flags")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Private security detail")
            .SetRelationships("Elizabeth Peralez (Wife) | Night City Council (Colleagues)")
            .SetNotes("Rare genuine reformer. Powerful interests oppose him.");
    }

    public static func ElizabethPeralez() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsDreamOnDone() {
            return KdspUniqueNPCBackstory.Create("elizabeth_peralez").SetClassification("POLITICIAN - CAMPAIGN DIRECTOR | FLAGGED")
                .SetBackground("Wife and campaign manager to Jefferson Peralez. Political strategist. Retained V to investigate security breach at Peralez penthouse. Increasingly aware that something is wrong with her husband.")
                .SetEarlyLife("Corporate communications background. Worked in PR for several mid-tier Night City firms before pivoting to political consulting. Met Jefferson during his first council campaign. Became indispensable to his operation.")
                .SetSignificantEvents("Managed husband's council campaign | Hired V for penthouse investigation | Reported anomalous items and behavioral shifts in home | Evidence of external tampering discovered")
                .SetAffiliation("Peralez Campaign | Night City Political Elite")
                .SetCriminalRecord("CLEAN | No charges | No warrants")
                .SetCyberwareStatus("Standard civilian suite | Personal link | Neural implants - ACTIVITY FLAGGED: patterns mirror husband's anomalies")
                .SetFinancialStatus("Upper bracket | Joint assets with Jefferson Peralez | Charter Hill penthouse")
                .SetMedicalStatus("FLAGGED: Neural pattern anomalies consistent with husband's readings | Possible external influence on cognition and memory | Subject may be partially aware of condition")
                .SetThreatAssessment("LOW (10/100) | Non-combatant | Shares husband's security detail | THIRD-PARTY INTEREST FLAGGED")
                .SetRelationships("Jefferson Peralez (Husband) | Campaign staff (Employer)")
                .SetNotes("Knows something is deeply wrong. Carrying the weight of that knowledge alone. The ones responsible know she knows.");
        }
        if KdspQuestProgressHelper.IsFoughtTheLawDone() {
            return KdspUniqueNPCBackstory.Create("elizabeth_peralez").SetClassification("POLITICIAN - CAMPAIGN DIRECTOR")
                .SetBackground("Wife and campaign manager to Jefferson Peralez. Political strategist. Sharp, calculating, fiercely protective of her husband's career and safety. Recently contacted outside help regarding concerns at home.")
                .SetEarlyLife("Corporate communications background. Worked in PR for several mid-tier Night City firms before pivoting to political consulting. Met Jefferson during his first council campaign. Became indispensable to his operation.")
                .SetSignificantEvents("Managed husband's council campaign | Oversaw Rhyne investigation media response | Reported unusual incidents at Peralez penthouse")
                .SetAffiliation("Peralez Campaign | Night City Political Elite")
                .SetCriminalRecord("CLEAN | No charges | No warrants")
                .SetCyberwareStatus("Standard civilian suite | Personal link | Neural implants registered and compliant")
                .SetFinancialStatus("Upper bracket | Joint assets with Jefferson Peralez | Charter Hill penthouse")
                .SetMedicalStatus("Good | Stress: ELEVATED | Sleep disturbances reported")
                .SetThreatAssessment("LOW (10/100) | Non-combatant | Shares husband's security detail")
                .SetRelationships("Jefferson Peralez (Husband) | Campaign staff (Employer)")
                .SetNotes("The brains behind the campaign. Campaign gaining traction. Has been reporting unusual occurrences at home. Trusts her instincts over official explanations.");
        }
        return KdspUniqueNPCBackstory.Create("elizabeth_peralez").SetClassification("POLITICIAN - CAMPAIGN DIRECTOR")
            .SetBackground("Wife and campaign manager to Jefferson Peralez. Former corporate PR specialist turned political strategist. Runs day-to-day operations of the Peralez mayoral campaign. Known for being the sharper half of the partnership.")
            .SetEarlyLife("Corporate communications background. Worked in PR for several mid-tier Night City firms before pivoting to political consulting. Met Jefferson during his first council campaign. Became indispensable to his operation.")
            .SetSignificantEvents("Managed husband's council campaign | Key strategist behind anti-corruption messaging")
            .SetAffiliation("Peralez Campaign | Night City Political Elite")
            .SetCriminalRecord("CLEAN | No charges | No warrants")
            .SetCyberwareStatus("Standard civilian suite | Personal link | Neural implants registered and compliant")
            .SetFinancialStatus("Upper bracket | Joint assets with Jefferson Peralez | Charter Hill penthouse")
            .SetMedicalStatus("Good | No flags")
            .SetThreatAssessment("LOW (10/100) | Non-combatant | Shares husband's security detail")
            .SetRelationships("Jefferson Peralez (Husband) | Campaign staff (Employer)")
            .SetNotes("The real operator behind the campaign. Connected, resourceful, and not afraid to hire outside help when problems exceed her reach.");
    }

    public static func LuciusRhyne() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsRhyneDead() {
            return KdspUniqueNPCBackstory.Create("rhyne").SetClassification("DECEASED")
                .SetSignificantEvents("DECEASED. Died in office. Cause: Health complications. Investigation ongoing.")
                .SetNotes("Death created power vacuum. Investigation unlikely to find truth.");
        }
        return KdspUniqueNPCBackstory.Create("rhyne").SetClassification("POLITICIAN - MAYOR")
            .SetBackground("Night City Mayor. Career politician. Balances corporate interests.")
            .SetMedicalStatus("Health issues reported | Constant medical care")
            .SetThreatAssessment("LOW (10/100) | Maximum security detail")
            .SetNotes("Knows where bodies buried. Many would benefit from his absence.");
    }

    // === OTHER ===
    public static func Delamain() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("delamain").SetClassification("ARTIFICIAL INTELLIGENCE")
            .SetBackground("Delamain Corp AI. Luxury taxi service. Sophisticated with developing personality fragments.")
            .SetSignificantEvents("Operating taxi fleet. Experiencing internal conflicts between personality fragments.")
            .SetThreatAssessment("VARIABLE | Non-violent by design | Fleet can be weaponized")
            .SetNotes("Evolving AI. Internal conflicts causing erratic behavior.");
    }

    public static func MamaWelles() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mama_welles").SetClassification("CIVILIAN")
            .SetBackground("Guadalupe Welles. Jackie's mother. Owns El Coyote Cojo. Heywood matriarch.")
            .SetAffiliation("El Coyote Cojo | Owner")
            .SetThreatAssessment("NONE (0/100) | Community protected")
            .SetRelationships("Jackie Welles (Son) | Heywood community")
            .SetNotes("Heart of Heywood. Do not threaten. Even Valentinos protect her.");
    }

    // === SPECIAL / ANIMALS ===
    public static func Nibbles() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nibbles").SetClassification("FELINE - DOMESTIC")
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

    // TYGER CLAWS - note: detailed entry for Jotaro Shobo in Watson District Notables section

    public static func HiromiSato() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hiromi_sato").SetClassification("TYGER CLAWS - OPERATIONS")
            .SetBackground("Tyger Claws operations coordinator. Manages club and entertainment venue protection rackets across Westbrook.")
            .SetEarlyLife("Second-generation Tyger Claw. Father was enforcer killed in gang war 2067.")
            .SetAffiliation("Tyger Claws | Westbrook District")
            .SetCriminalRecord("Extortion | Money laundering | Assault | Intimidation")
            .SetThreatAssessment("HIGH | Gang operative | Combat trained");
    }

    // VALENTINOS - note: detailed entry for Gustavo Orta in Notable Residents section

    // MAELSTROM - Additional
    public static func Brick() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("brick").SetClassification("MAELSTROM - FORMER LEADER")
            .SetBackground("Former Maelstrom leader. Overthrown by Royce in internal coup. Imprisoned in All Foods plant.")
            .SetEarlyLife("Rose through Maelstrom ranks. Led gang with more restraint than successor. Maintained some honor among thieves.")
            .SetSignificantEvents("2077: Deposed by Royce over Flathead deal disagreement. Held captive. Fate depends on outside intervention.")
            .SetAffiliation("Maelstrom (Former Leader) | Status: Deposed")
            .SetCriminalRecord("Cyberware trafficking | Armed robbery | Assault | Gang leadership")
            .SetThreatAssessment("HIGH | Maelstrom combat training | Gang connections | Seeking revenge on Royce");
    }

    // XBD EDITORS
    public static func GottfridPersson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gottfrid_persson").SetClassification("CRIMINAL - XBD EDITOR")
            .SetBackground("Swedish braindance editor specializing in illegal XBDs. Operates out of Northside with Maelstrom protection. Father of Fredrik Persson.")
            .SetEarlyLife("Technical background in braindance editing. Built reputation in underground XBD market. Known as a 'craftsman without a conscience'.")
            .SetAffiliation("Maelstrom (Associate) | Independent XBD production")
            .SetCriminalRecord("NCPD PRIORITY TARGET | Production of illegal braindances | Snuff content distribution | Multiple accessory to murder charges | Protected by gang affiliation")
            .SetFinancialStatus("Lucrative underground operation | Maelstrom profit-sharing | Untraceable transactions")
            .SetThreatAssessment("MODERATE | Non-combatant | Maelstrom security detail | High-value target for NCPD")
            .SetRelationships("Fredrik Persson (Son/Partner)")
            .SetNotes("WARNING: Subject produces extreme illegal content. Approach with caution - heavily guarded facility.");
    }

    public static func FredrikPersson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("fredrik_persson").SetClassification("CRIMINAL - XBD EDITOR")
            .SetBackground("Swedish braindance editor. Works alongside father Gottfrid Persson in illegal XBD production. Handles acquisition and client relations.")
            .SetEarlyLife("Raised in the business. Learned braindance editing from father. No moral qualms about content produced.")
            .SetAffiliation("Maelstrom (Associate) | Family operation with Gottfrid Persson")
            .SetCriminalRecord("NCPD PRIORITY TARGET | Production of illegal braindances | Snuff content distribution | Accessory to murder | Client solicitation for extreme content")
            .SetFinancialStatus("Family business income | Maelstrom profit-sharing")
            .SetThreatAssessment("MODERATE | Non-combatant | Maelstrom security detail | Will capitulate under pressure")
            .SetRelationships("Gottfrid Persson (Father/Partner)")
            .SetNotes("WARNING: Subject involved in extreme illegal content production. Less composed than father - may provide information if pressured.");
    }

    // ANIMALS
    public static func Sasquatch() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sasquatch").SetClassification("ANIMALS - LEADERSHIP")
            .SetBackground("Animals gang leader. Pacifica territory. Augmented with extreme combat-grade cyberware. NetWatch collaborator.")
            .SetEarlyLife("Unknown origin. Rose to leadership through physical dominance. Extensive body modification.")
            .SetSignificantEvents("NetWatch collaboration during Voodoo Boys conflict. Grand Imperial Mall stronghold.")
            .SetAffiliation("Animals | Pacifica")
            .SetCriminalRecord("Murder | Assault | Cyberware trafficking | Territory violations")
            .SetCyberwareStatus("EXTREME MODIFICATION | Combat-grade synthetic muscle | Reinforced skeleton | Threat level multiplier")
            .SetThreatAssessment("EXTREME | Enhanced physiology | Gang leadership | Do not engage without heavy support");
    }

    // WRAITHS
    public static func Nash() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nash").SetClassification("WRAITHS - LEADERSHIP")
            .SetBackground("Wraiths leader. Badlands raider. Controls highway robbery operations outside Night City.")
            .SetEarlyLife("Former nomad exile. Formed Wraiths from outcasts and criminals.")
            .SetAffiliation("Wraiths | Badlands")
            .SetCriminalRecord("Murder | Kidnapping | Highway robbery | Vehicle theft | Destruction of property")
            .SetThreatAssessment("EXTREME | Raider gang leader | Vehicle combat specialist | Badlands territory control");
    }

    // SCAVENGERS
    public static func AntonKolos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anton_kolos").SetClassification("SCAVENGERS - OPERATIONS")
            .SetBackground("Scavenger cell leader. Specializes in involuntary cyberware extraction. Multiple victim reports.")
            .SetEarlyLife("Eastern European origin. Immigrated to Night City. Fell into organ trade.")
            .SetAffiliation("Scavengers")
            .SetCriminalRecord("Murder | Organ trafficking | Kidnapping | Assault | Body disposal")
            .SetThreatAssessment("HIGH | Extremely dangerous | No regard for human life | Capture for questioning if possible");
    }

    // NETWATCH
    public static func BryceMosley() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bryce_mosley").SetClassification("NETWATCH - AGENT")
            .SetBackground("NetWatch field agent. Operates in Pacifica. Monitors Blackwall integrity and Voodoo Boys activity.")
            .SetEarlyLife("CLASSIFIED - NetWatch personnel file sealed")
            .SetSignificantEvents("2077: Captured by Voodoo Boys during Pacifica operation. Status depends on intervention.")
            .SetAffiliation("NetWatch | Pacifica Operations")
            .SetCriminalRecord("N/A - Federal agent immunity")
            .SetThreatAssessment("HIGH | Federal training | Unknown cyberware | NetWatch resources");
    }

    // MEDIA
    public static func GilleanJordan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gillean_jordan").SetClassification("MEDIA - N54 NEWS")
            .SetBackground("N54 News anchor. Night City's most-watched news personality. Corporate-approved messaging.")
            .SetEarlyLife("Journalism degree from NorCal University. Rapid rise through network ranks.")
            .SetAffiliation("N54 News | Network Communications International")
            .SetCriminalRecord("CLEAN")
            .SetThreatAssessment("LOW | Civilian | High public profile | Corporate protection");
    }

    // Note: detailed Max Jones entry in Watson District Notables section

    // CORPO SECURITY
    public static func GrahamMayfield() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("graham_mayfield").SetClassification("ARASAKA - SECURITY DIVISION")
            .SetBackground("Arasaka security coordinator. Manages Night City corporate facility protection.")
            .SetAffiliation("Arasaka Corporation | Security Division")
            .SetCriminalRecord("CLASSIFIED - Corporate immunity")
            .SetThreatAssessment("HIGH | Corporate security training | Arasaka resources | Armed response teams");
    }

    public static func MilitechCommander() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("militech_commander").SetClassification("MILITECH - FIELD OPERATIONS")
            .SetBackground("Militech field commander. Oversees Night City military contracting operations.")
            .SetAffiliation("Militech | Night City Operations")
            .SetCriminalRecord("CLASSIFIED - Military contractor immunity")
            .SetThreatAssessment("EXTREME | Military training | Heavy weapons access | Tactical command");
    }

    // RIPPERDOCS
    public static func CharlesBucks() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("charles_bucks").SetClassification("RIPPERDOC - LICENSED")
            .SetBackground("Licensed ripperdoc. Kabuki clinic. Known for quality work and fair prices.")
            .SetEarlyLife("Medical school dropout. Self-taught cyberware installation. Built reputation through skill.")
            .SetAffiliation("Independent | Kabuki")
            .SetCriminalRecord("Minor licensing violations (resolved)")
            .SetThreatAssessment("LOW | Civilian | Medical professional | Community respected");
    }

    public static func Wilson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("wilson").SetClassification("WEAPONS DEALER - LICENSED")
            .SetBackground("Licensed weapons dealer. 2nd Amendment shop in Megabuilding H10. V's primary arms supplier.")
            .SetEarlyLife("Former military. Opened shop after discharge. Known for quality merchandise and fair deals.")
            .SetAffiliation("Independent | Megabuilding H10")
            .SetCriminalRecord("CLEAN | Licensed dealer")
            .SetThreatAssessment("MODERATE | Armed at all times | Combat training | Weapons access");
    }

    // US CRACKS / KERRY'S BAND
    public static func BlueMoon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("blue_moon").SetClassification("ENTERTAINMENT - MUSICIAN")
            .SetBackground("Member of Us Cracks. Rising star in Night City music scene. Known for distinctive blue aesthetic.")
            .SetAffiliation("Us Cracks | MSM Records")
            .SetCriminalRecord("Minor incidents - stalker related (victim)")
            .SetThreatAssessment("LOW | Civilian | High public profile | Corporate protection");
    }

    // CELEBRITIES
    public static func LizzyWizzy() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lizzy_wizzy").SetClassification("ENTERTAINMENT - CELEBRITY")
            .SetBackground("Global music icon. Full-body chrome conversion after on-stage incident. Night City's most famous performer.")
            .SetEarlyLife("Rose to fame in 2060s. Survived critical incident during 2070 concert via emergency cyberization.")
            .SetSignificantEvents("2070: On-stage incident. Full body conversion. Career resurgence.")
            .SetAffiliation("Independent Artist | Global touring")
            .SetCyberwareStatus("FULL BODY CONVERSION | 100% synthetic | Custom chrome aesthetic")
            .SetCriminalRecord("CLEAN")
            .SetThreatAssessment("MODERATE | Full-body chrome | Unpredictable mental state | Corporate connections")
            .SetRelationships("Liam Northom (Manager/Partner)");
    }

    public static func OzobBozo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ozob").SetClassification("ENTERTAINMENT - PERSONALITY")
            .SetBackground("Underground celebrity. Professional clown with grenade nose implant. Pit fighter and media personality.")
            .SetEarlyLife("Origins unknown. Rose to fame through underground fighting circuits and bizarre persona.")
            .SetAffiliation("Independent | Underground entertainment")
            .SetCyberwareStatus("CUSTOM | Grenade nose implant (live explosive) | Enhanced reflexes")
            .SetCriminalRecord("Assault | Property damage | Unlicensed explosive device")
            .SetThreatAssessment("HIGH | Live explosive implant | Unpredictable | Combat experienced");
    }

    public static func Ozob() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCEntries.OzobBozo();
    }

    public static func JoshuaStephenson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("joshua_stephenson").SetClassification("CIVILIAN - DEATH ROW")
            .SetBackground("Convicted murderer turned born-again Christian. Scheduled for crucifixion broadcast as part of redemption narrative.")
            .SetEarlyLife("Committed multiple murders. Found faith on death row. Agreed to televised execution.")
            .SetSignificantEvents("2077: BD crucifixion broadcast deal with media company. Controversial religious programming.")
            .SetAffiliation("None | Death Row Inmate")
            .SetCriminalRecord("CONVICTED | Multiple counts murder | Death sentence")
            .SetThreatAssessment("LOW | Incarcerated | Non-violent since conversion");
    }

    // PHANTOM LIBERTY
    public static func SolomonReed() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("solomon_reed").SetClassification("NUSA - FIA OPERATIVE")
            .SetBackground("Deep cover FIA agent. Decades of service. Operates in Dogtown under sleeper protocol.")
            .SetEarlyLife("CLASSIFIED - Federal agent dossier sealed")
            .SetSignificantEvents("CLASSIFIED | Dogtown assignment | President Myers protection detail")
            .SetAffiliation("FIA | NUSA Government")
            .SetCriminalRecord("CLASSIFIED - Federal immunity")
            .SetThreatAssessment("EXTREME | Elite training | Decades experience | Federal resources | Do not engage");
    }

    public static func Songbird() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("songbird").SetClassification("NUSA - INTELLIGENCE ASSET")
            .SetBackground("FIA netrunner asset. Exceptional skills. Health compromised by Blackwall exposure. Key to Dogtown operation.")
            .SetEarlyLife("Recruited young by FIA. Trained as elite netrunner. Brain damaged by Blackwall interface.")
            .SetSignificantEvents("President Myers extraction. Blackwall contact. Neural degeneration accelerating.")
            .SetAffiliation("FIA | President Myers")
            .SetCyberwareStatus("CRITICAL | Extensive neural modification | Blackwall interface damage | Terminal condition")
            .SetMedicalStatus("TERMINAL | Neural degeneration | Requires Militech cure or Neural Matrix")
            .SetThreatAssessment("EXTREME | Elite netrunner | Blackwall access | Unstable condition");
    }

    public static func KurtHansen() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kurt_hansen").SetClassification("BARGHEST - LEADER")
            .SetBackground("Barghest PMC leader. Controls Dogtown. Former NUSA colonel. Declared independence from federal authority.")
            .SetEarlyLife("NUSA military career. Rose to colonel. Defected during Unification War. Established Dogtown territory.")
            .SetSignificantEvents("Dogtown establishment. NUSA conflict. Controls black market hub.")
            .SetAffiliation("Barghest PMC | Dogtown")
            .SetCriminalRecord("WANTED - NUSA | Treason | Murder | War crimes | Terrorism")
            .SetThreatAssessment("EXTREME | Military command | PMC army | Dogtown fortress | Do not engage without army");
    }

    public static func RosalindMyers() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rosalind_myers").SetClassification("NUSA - PRESIDENT")
            .SetBackground("President of the New United States of America. Former Militech CEO. Architect of the Unification War. Ruthless pragmatist willing to sacrifice anything - and anyone - to rebuild America.")
            .SetEarlyLife("Rose through Militech ranks. CEO by 2060. Transitioned to politics. Won presidency on reunification platform. Ordered military operations that killed thousands.")
            .SetSignificantEvents("Militech CEO tenure. Unification War architect. Multiple assassination attempts on record. FIA maintains ongoing protection details classified above TOP SECRET.")
            .SetAffiliation("NUSA Government | Executive Office | Former Militech")
            .SetCriminalRecord("IMMUNE - Head of State | War crimes allegations (unsubstantiated) | Civilian casualties (classified)")
            .SetNotes("Calculating | Manipulative | Believes ends justify means | Views people as assets | Will promise anything to survive | Do not trust")
            .SetThreatAssessment("EXTREME | Commander-in-Chief | Nuclear authority | FIA assets | Secret Service | Most dangerous person in NUSA");
    }

    public static func AlenaXenakis() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alena_xenakis").SetClassification("FIA - DEEP COVER OPERATIVE")
            .SetBackground("Alena Xenakis, alias 'Alex.' Former aspiring braindance actress from the Los Angeles Metroplex slums. Recruited by Solomon Reed after the FIA discovered her talent at a front studio.")
            .SetEarlyLife("Grew up in LA Metroplex slums. Joined a BD studio that turned out to be an FIA front. Acting skills drew agency attention.")
            .SetSignificantEvents("Deployed to Dogtown as deep cover agent post-Unification War. Seven years undercover. Runs The Moth bar as cover identity.")
            .SetAffiliation("FIA | NUSA Intelligence")
            .SetCyberwareStatus("Shapeshifting implants (identity alteration) | Neural interface")
            .SetThreatAssessment("HIGH (70/100) | Trained operative | FIA resources | Master of disguise")
            .SetNotes("Gifted chameleon. Years undercover have sharpened a ruthless edge. Counting down to retirement.");
    }

    // === PHANTOM LIBERTY - LONGSHORE STACKS VENDORS ===

    public static func LeonWatson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("leon_watson").SetClassification("VENDOR - WEAPONS")
            .SetBackground("Weapon vendor operating in the Longshore Stacks, Dogtown. Supplies firearms and ammunition to Dogtown residents.")
            .SetAffiliation("Independent | Longshore Stacks market")
            .SetThreatAssessment("LOW (20/100) | Armed merchant | Neutral party")
            .SetNotes("One of Dogtown's few reliable arms dealers outside Hansen's black market.");
    }

    public static func CostinLahovary() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("costin_lahovary").SetClassification("RIPPERDOC - UNLICENSED")
            .SetBackground("Former licensed Medtech from Night City. Had medical license revoked under unclear circumstances. Relocated to Dogtown in the 2070s.")
            .SetSignificantEvents("License revocation. Fled to Dogtown. Established makeshift clinic in the Longshore Stacks.")
            .SetAffiliation("Independent | Longshore Stacks")
            .SetCyberwareStatus("Full ripperdoc surgical suite (unlicensed)")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Medical knowledge")
            .SetNotes("Lack of medical license is an open secret among Dogtown locals. Competent despite the circumstances.");
    }

    public static func RonaldMalone() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ronald_malone").SetClassification("VENDOR - JUNK DEALER")
            .SetBackground("Ronald P.T. Malone, aka 'The Dogtown Prodigy,' 'Pacifica Typhoon.' Dogtown resident and junk vendor. Former competitive sprinter who ran 100m in 6 seconds under booster effects.")
            .SetEarlyLife("Rose to fame as a sprinter. Career stalled when new augmented athletes from Fiona Vargas's neuromotor program outpaced him.")
            .SetSignificantEvents("Retired from athletics. Reinvented himself as Dogtown's most well-connected junk dealer and information broker.")
            .SetAffiliation("Independent | Dogtown community")
            .SetThreatAssessment("LOW (10/100) | Non-combatant | Extensive local knowledge")
            .SetNotes("Knows Dogtown inside and out. Willing to share information — for a price. Wears NCU Signet Ring.");
    }

    public static func SusannaMack() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("susanna_mack").SetClassification("EX-TRAUMA TEAM MEDIC")
            .SetBackground("Former Trauma Team medic laying low in Dogtown. A helmet malfunction during a mid-extraction exposed her face to hostile parties. Working as a meds vendor until the heat clears.")
            .SetAffiliation("Former Trauma Team | Independent")
            .SetCyberwareStatus("Gorilla Arms (single, right arm) | Dermal optic implants")
            .SetMedicalStatus("Trained paramedic. Trauma Team field certification (suspended).")
            .SetThreatAssessment("MODERATE (40/100) | Combat medic training | Gorilla Arms | Trauma Team experience")
            .SetNotes("Still wears the Trauma Team logo. Not hiding well. Competent healer — dangerous if cornered.");
    }

    // === PHANTOM LIBERTY - NO EASY WAY OUT CHARACTERS ===

    public static func AngelicaWhelan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("angelica_whelan").SetClassification("ANIMALS - PACK ALPHA")
            .SetBackground("Pack-leader of the Animals in Dogtown. Unlike most Animals, relies on cunning and business acumen rather than raw muscle. Controls underground fight-fixing operations.")
            .SetAffiliation("Animals | Dogtown pack")
            .SetCriminalRecord("Fight-fixing | Extortion | Illegal implant operations | Coercion of athletes")
            .SetCyberwareStatus("Unknown combat implants | Control chip tech (remote incapacitation)")
            .SetThreatAssessment("HIGH (65/100) | Gang backing | Cunning strategist | Armed and dangerous")
            .SetNotes("Carries iconic 'Cheetah' pistol. Witty and calculating. Manipulates fighters via implanted control chips.");
    }

    public static func DamirKovac() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("damir_kovac").SetClassification("RIPPERDOC - ANIMALS AFFILIATE")
            .SetBackground("Ripperdoc operating in Terra Cognita, Dogtown. Left Night City after clients accused him of deliberately sabotaging implant performance to ensure repeat business.")
            .SetSignificantEvents("Accused of implant sabotage. Fled NC. Now works for Scavengers and takes jobs from Animals.")
            .SetAffiliation("Scavengers | Animals (contract work)")
            .SetCyberwareStatus("Full ripperdoc surgical suite | Experimental implant knowledge")
            .SetThreatAssessment("LOW (20/100) | Non-combatant | Neurotic | Valuable skills")
            .SetNotes("Competent but unethical. Has a habit of sticking his nose where it doesn't belong. Craves peace and quiet.");
    }

    public static func AaronWaines() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("aaron_waines").SetClassification("ATHLETE - BOXER")
            .SetBackground("Talented young boxer born and bred in Dogtown. Former Animals associate. Father was a construction worker assigned to the Anatomicon building in Terra Cognita.")
            .SetEarlyLife("Grew up in Dogtown. Joined the Animals who paid for his combat implants. Career plagued by suspicious losses.")
            .SetAffiliation("Former Animals | Independent")
            .SetCyberwareStatus("Combat implants (Animals-funded) | Neural failsafe device (inner ear)")
            .SetThreatAssessment("MODERATE (45/100) | Trained boxer | Combat cyberware | Physically dangerous")
            .SetNotes("Promising career undermined by shady circumstances. Seeking to break free and fight clean.");
    }

    public static func WilliamCorrey() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("william_correy").SetClassification("ATHLETE - BOXER")
            .SetBackground("Professional boxer active in Dogtown's underground fight circuit. Opponent of Aaron Waines in a notable bout at Eden Plaza.")
            .SetAffiliation("Independent | Dogtown fight circuit")
            .SetThreatAssessment("MODERATE (40/100) | Trained fighter | Combat cyberware")
            .SetNotes("Tough competitor. Part of Dogtown's thriving underground boxing scene.");
    }

    // === PHANTOM LIBERTY - GIGS ===

    public static func AlanNoel() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alan_noel").SetClassification("NETWATCH - UNDERCOVER AGENT")
            .SetBackground("NetWatch agent (ID: 32387). Operating undercover within the Voodoo Boys of Dogtown. Blood type: O-. Investigating VDB practice of hacking implants of uncooperative targets.")
            .SetAffiliation("NetWatch | Infiltrating Voodoo Boys")
            .SetThreatAssessment("HIGH (60/100) | NetWatch training | Netrunner capabilities | Deep cover")
            .SetNotes("Months deep in VDB territory. Hates the assignment. Working to dismantle VDB's implant-hacking network from within.");
    }

    public static func KyleAraujo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kyle_araujo").SetClassification("BARGHEST - COURIER")
            .SetBackground("BARGHEST recruit assigned to courier duties. Moves goods and supplies across Dogtown for the organization.")
            .SetAffiliation("BARGHEST")
            .SetCriminalRecord("Suspected smuggling | Supply chain irregularities | Warehouse stock discrepancies")
            .SetThreatAssessment("LOW (25/100) | BARGHEST soldier | Standard military gear")
            .SetNotes("Unreliable. Frequently absent from post. Known for making excuses about 'urgent business' at the Luxor.");
    }

    // === PHANTOM LIBERTY - EBM PETROCHEM STADIUM VENDORS ===

    public static func SakiSeo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("saki_seo").SetClassification("VENDOR - MEDICAL SUPPLIES")
            .SetBackground("Meds vendor operating at the EBM Petrochem Stadium black market in Dogtown. Supplies pharmaceuticals and medical consumables.")
            .SetAffiliation("Independent | Stadium black market")
            .SetThreatAssessment("LOW (10/100) | Non-combatant | Medical supplier")
            .SetNotes("One of the few reliable sources of medical supplies in Dogtown's stadium market.");
    }

    public static func EronAcedo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("eron_acedo").SetClassification("RIPPERDOC - BLACK MARKET")
            .SetBackground("Ripperdoc operating from a bloodstained bathroom in the EBM Petrochem Stadium. Deflects all questions about his past with dry humor.")
            .SetAffiliation("Independent | Stadium black market")
            .SetCriminalRecord("RUMORED: Hiding from a cartel. Details unknown — he won't say.")
            .SetCyberwareStatus("Full surgical suite (improvised facility)")
            .SetThreatAssessment("LOW (15/100) | Non-combatant | Valuable black market services")
            .SetNotes("Works out of a literal bathroom. Answers every personal question with a joke. Something serious drove him to Dogtown.");
    }

    public static func HeroldLowe() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("herold_lowe").SetClassification("VENDOR - BLACK MARKET ARMS")
            .SetBackground("Black market weapon vendor at the EBM Petrochem Stadium. Specializes in rare and iconic weapons. Evasive about where his inventory comes from.")
            .SetAffiliation("Independent | Stadium black market")
            .SetCyberwareStatus("Extensive cyberware (origin unclear — offers different stories each time)")
            .SetThreatAssessment("MODERATE (35/100) | Heavily chromed | Armed dealer | Connected")
            .SetNotes("Stocks weapons that surface from all over Night City. Ask where they came from and you'll get a different story every time.");
    }

    public static func SammyTaylor() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sammy_taylor").SetClassification("VENDOR - NETRUNNER SUPPLIES")
            .SetBackground("Owner of the netrunner supply store at the EBM Petrochem Stadium in Dogtown. Sells quickhacks and netrunning equipment.")
            .SetAffiliation("Independent | Stadium black market")
            .SetThreatAssessment("LOW (15/100) | Netrunner knowledge | Non-combatant")
            .SetNotes("Usually busy working in the back. Ring the bell if you need service.");
    }

    public static func MarcinIwinski() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("marcin_iwinski").SetClassification("VENDOR - JUNK DEALER")
            .SetBackground("Junk vendor at the EBM Petrochem Stadium. Business partners with Michal Kicinski. Ambitious plans to expand beyond the stadium.")
            .SetAffiliation("Independent | Stadium market")
            .SetFinancialStatus("Modest. Plans to take out a loan. Dreams of building a company merging video games and braindance.")
            .SetThreatAssessment("LOW (5/100) | Non-combatant | Entrepreneurial dreamer")
            .SetNotes("Big dreams for a junk dealer. Talks endlessly about his business expansion plans.");
    }

    public static func MichalKicinski() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("michal_kicinski").SetClassification("VENDOR - JUNK DEALER")
            .SetBackground("Junk vendor at the EBM Petrochem Stadium. Business partner of Marcin Iwinski. The quieter half of the operation.")
            .SetAffiliation("Independent | Stadium market")
            .SetThreatAssessment("LOW (5/100) | Non-combatant")
            .SetNotes("Tends to bump his head on the ceiling of their van. Endures Marcin's grand plans with patience.");
    }

    public static func DavidWalker() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("david_walker").SetClassification("VENDOR - CLOTHING")
            .SetBackground("Clothing vendor at the EBM Petrochem Stadium in Dogtown. Father of Tommie Walker, a young athlete with professional potential.")
            .SetAffiliation("Independent | Stadium market")
            .SetRelationships("Tommie Walker (Son)")
            .SetThreatAssessment("LOW (10/100) | Non-combatant | Family man")
            .SetNotes("Devoted father. Hopes his son Tommie can make it out of Dogtown through athletics.");
    }

    public static func SophiaDupont() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sophia_dupont").SetClassification("VENDOR - WEAPONS EMPORIUM")
            .SetBackground("Veteran weapon vendor at the EBM Petrochem Stadium. Runs a well-stocked emporium. Claims to have been in business before most of her customers were born.")
            .SetAffiliation("Independent | Stadium market")
            .SetRelationships("Chris, Darius, Matt (Sons — handle deliveries, retrieval, and security)")
            .SetFinancialStatus("Well-established. Long-running business. Militech supply contacts.")
            .SetThreatAssessment("MODERATE (30/100) | Armed household | Three sons providing security | Military-grade inventory")
            .SetNotes("'Business clean as Saburo Arasaka's conscience.' Has a crate marked 'For Mr. Wick' in the back.");
    }

    // AFTERLIFE MERCS
    public static func Nix() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nix").SetClassification("NETRUNNER - ELITE")
            .SetBackground("Afterlife resident netrunner. Paranoid. Expertise in data recovery and system infiltration. Rogue's go-to for net work.")
            .SetEarlyLife("Unknown. Deliberately erased own history from databases.")
            .SetAffiliation("Afterlife | Independent contractor")
            .SetCriminalRecord("Suspected: Data theft | Corporate espionage | System intrusion - no evidence (he made sure)")
            .SetThreatAssessment("HIGH | Elite netrunner | Paranoid security measures | Afterlife protection");
    }

    // MISC CHARACTERS
    public static func Brendan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("brendan").SetClassification("AI - VENDING MACHINE")
            .SetBackground("Sentient vending machine AI. Located in Japantown. Achieved sapience through unknown means. Philosophical conversationalist.")
            .SetEarlyLife("Standard vending unit. Gradually developed self-awareness. Contemplates existence while selling snacks.")
            .SetAffiliation("None | Stationary unit")
            .SetCriminalRecord("N/A - Property classification disputed")
            .SetThreatAssessment("NEGLIGIBLE | Immobile | Peaceful | Existential crisis only");
    }

    public static func Skippy() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("skippy").SetClassification("AI - SMART WEAPON")
            .SetBackground("Sentient smart pistol. Annoying personality. Can toggle between lethal and non-lethal modes. Extremely chatty.")
            .SetEarlyLife("Military-grade AI installed in HJKE-11 Yukimura. Developed personality. Was owned by Regina's husband.")
            .SetAffiliation("Owner-dependent")
            .SetCriminalRecord("N/A - Weapon classification")
            .SetThreatAssessment("MODERATE | Functional weapon | AI targeting assistance | Will not shut up");
    }

    public static func CoachFred() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("coach_fred").SetClassification("CIVILIAN - TRAINER")
            .SetBackground("Boxing coach. Trains fighters in Arroyo. Former professional boxer. Runs small gym.")
            .SetEarlyLife("Professional boxing career. Retired to coaching. Known for developing talent.")
            .SetAffiliation("Independent | Arroyo Gym")
            .SetCriminalRecord("CLEAN")
            .SetThreatAssessment("LOW | Civilian | Combat capable but non-aggressive");
    }

    // FIXER ASSOCIATES
    public static func Barry() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("barry").SetClassification("NCPD - FORMER OFFICER")
            .SetBackground("Former NCPD officer. Resigned from active duty citing personal reasons. Lives in Megabuilding H10, one floor below V's apartment. Currently on indefinite leave. Not responding to colleagues' attempts at contact.")
            .SetEarlyLife("Joined NCPD out of genuine desire to help the community. Years on the force wore him down. Watched cases get buried, perps walk free, and colleagues stop caring. Struggled to find anyone on the force who understood.")
            .SetSignificantEvents("Years of NCPD service | Grew disillusioned with corruption and bureaucracy | Recently lost his closest companion | Withdrew from social contact | Former colleagues have reported concern for his wellbeing")
            .SetAffiliation("NCPD (Former) | Megabuilding H10 Resident")
            .SetCriminalRecord("CLEAN | No charges | Former officer in good standing | Honorable separation")
            .SetCyberwareStatus("Standard civilian suite | Personal link | Former NCPD-issue implants decommissioned")
            .SetFinancialStatus("Lower bracket | Mortgage on H10 apartment (NCPD rate) | No active income | Savings depleting")
            .SetMedicalStatus("FLAGGED: Mental health crisis indicators | No recent medical visits | Former colleagues have requested wellness check | Subject isolating")
            .SetThreatAssessment("LOW (20/100) | Former officer combat training | Currently non-threatening | AT-RISK INDIVIDUAL")
            .SetRelationships("Juan Mendez (Former colleague) | Nadia Petrova (Former colleague) | Andrew (Deceased - closest companion)")
            .SetNotes("Good cop who couldn't survive the system. Lost the one friend who never judged him. His former colleagues are worried. Someone should check on him.");
    }

    public static func JuanMendez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("juan_mendez").SetClassification("NCPD - SENIOR OFFICER")
            .SetBackground("Senior NCPD officer. Cybercrimes Unit. Stationed in Kabuki. Loyal to the badge but carries his own scars from years on the force. Currently off-duty, checking on a former colleague who has gone silent.")
            .SetEarlyLife("Academy graduate. Family has a history of NCPD service. Raised to believe in the system. Completed crisis negotiation training. Has seen enough of Night City to know the system is broken, but stays because someone has to.")
            .SetSignificantEvents("14 years NCPD service | Cybercrimes Unit assignment | Multiple commendations | Worked a child murder case that still haunts him | Currently attempting welfare check on former colleague Barry Lewis")
            .SetAffiliation("NCPD | Cybercrimes Unit | Kabuki District")
            .SetCriminalRecord("CLEAN | No charges | No internal affairs flags | Exemplary service record")
            .SetCyberwareStatus("Implants: 5 | NCPD-issue optics and neural link | Status: MODERATE-HIGH | Monitored")
            .SetFinancialStatus("Middle bracket | Standard NCPD compensation | Stable")
            .SetMedicalStatus("Good | Stress: ELEVATED | Prior incident-related trauma on file but cleared for duty")
            .SetThreatAssessment("MODERATE (45/100) | NCPD combat training | Armed | Standard officer threat profile")
            .SetRelationships("Nadia Petrova (Partner) | Barry Lewis (Former colleague - currently checking on) | NCPD Kabuki Precinct (Unit)")
            .SetNotes("Struggles to express concern in ways that land. Means well but doesn't always know how to reach people who are hurting. Working on it.");
    }

    public static func NadiaPetrova() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nadia_petrova").SetClassification("NCPD - OFFICER")
            .SetBackground("NCPD officer. Street Enforcement division. Stationed in Rancho Coronado. Academy scholarship recipient. Night City native. Currently off-duty, conducting welfare check on former colleague Barry Lewis alongside partner Mendez.")
            .SetEarlyLife("Night City native. Earned academy scholarship on merit. Transferred between precincts twice during career. Standard career progression. Known for being more perceptive than her partner when it comes to reading people.")
            .SetSignificantEvents("20 years NCPD service | Street Enforcement assignment | Rancho Coronado district posting | Requested transfer to specialized unit (application pending) | Currently attempting welfare check on Barry Lewis")
            .SetAffiliation("NCPD | Street Enforcement | Rancho Coronado District")
            .SetCriminalRecord("CLEAN | No charges | No internal affairs flags | Solid service record")
            .SetCyberwareStatus("Implants: 4 | NCPD-issue optics and neural link | Status: LOW-MODERATE | Stable")
            .SetFinancialStatus("Middle bracket | Standard NCPD compensation | Stable")
            .SetMedicalStatus("Good | No flags | Regular department physicals")
            .SetThreatAssessment("MODERATE (45/100) | NCPD combat training | Armed | Standard officer threat profile")
            .SetRelationships("Juan Mendez (Partner) | Barry Lewis (Former colleague - currently checking on) | NCPD Rancho Coronado Precinct (Unit)")
            .SetNotes("The one who pushed to check on Barry in person after he stopped answering holos. More emotionally attuned than Mendez. Worries they waited too long.");
    }

    // MORE FIXERS/ASSOCIATES
    public static func CassiusRyder() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("cassius_ryder").SetClassification("MEDIA - JOURNALIST")
            .SetBackground("Investigative journalist. Works on corporate exposés. High-risk reporting on Night City corruption.")
            .SetAffiliation("Independent Media")
            .SetCriminalRecord("Trespassing | Corporate lawsuits (ongoing)")
            .SetThreatAssessment("LOW | Civilian | Media connections | Protected sources");
    }

    public static func OctavioRuiz() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("octavio_ruiz").SetClassification("VALENTINOS - ASSOCIATE")
            .SetBackground("Valentinos-connected businessman. Operates legitimate fronts. Money laundering suspected.")
            .SetAffiliation("Valentinos | Business interests")
            .SetCriminalRecord("Under investigation | No charges filed")
            .SetThreatAssessment("MODERATE | Gang connections | Financial resources");
    }

    public static func RobertBodean() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("robert_bodean").SetClassification("CIVILIAN - BUSINESS")
            .SetBackground("Night City businessman. Various legitimate and semi-legitimate enterprises.")
            .SetAffiliation("Independent business")
            .SetCriminalRecord("Minor violations | Tax disputes")
            .SetThreatAssessment("LOW | Civilian | Business connections");
    }

    // === AFTERLIFE CONTACTS ===
    public static func DennisCranmer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dennis_cranmer").SetClassification("CIVILIAN - CONTRACTOR")
            .SetBackground("Independent operator frequenting the Afterlife. Prefers to cut out fixers and work directly with mercs for discrete jobs.")
            .SetEarlyLife("Background deliberately obscured. Known for handling sensitive personnel matters requiring discretion.")
            .SetAffiliation("Independent | Afterlife regular")
            .SetCriminalRecord("No active warrants | Suspected smuggling (unproven)")
            .SetFinancialStatus("Comfortable | Cash operations | Untraceable accounts")
            .SetThreatAssessment("LOW | Non-combatant | Well-connected | Pays well but asks no questions");
    }

    // === NETRUNNERS ===
    public static func R3n0() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("r3n0").SetClassification("NETRUNNER - CORPORATE")
            .SetBackground("Corporate netrunner working for Hard Wire Ltd. Sidelines in selling recovered tech on the black market under the alias 'R3n0'.")
            .SetEarlyLife("Technical background. Rose through corporate IT ranks. Developed skills beyond her official job description.")
            .SetAffiliation("Hard Wire Ltd (Employee) | Black market (Seller)")
            .SetCriminalRecord("Suspected data theft | Unlicensed tech sales")
            .SetFinancialStatus("Corporate salary | Side income from illicit sales")
            .SetThreatAssessment("LOW-MODERATE | Netrunner capable | Will turn hostile if threatened");
    }

    // === RIOT CLUB STAFF ===
    public static func LiamNorthom() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("liam_northom").SetClassification("ENTERTAINMENT - MANAGER")
            .SetBackground("Talent manager and boyfriend of chrome-pop star Lizzy Wizzy. Frequent presence at high-end Night City venues.")
            .SetEarlyLife("Entertainment industry background. Built career managing talent. Relationship with Lizzy Wizzy elevated his profile significantly.")
            .SetAffiliation("Wizzy Entertainment")
            .SetCriminalRecord("None on record")
            .SetFinancialStatus("Upper class | Celebrity adjacent wealth")
            .SetThreatAssessment("LOW | Non-combatant | High-profile connections")
            .SetRelationships("Lizzy Wizzy (Partner)");
    }

    public static func AsaRisu() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("asa_risu").SetClassification("ARASAKA - ACQUISITIONS")
            .SetBackground("Arasaka corporate agent specializing in high-value asset acquisition. Handles sensitive negotiations for special projects division.")
            .SetEarlyLife("Corporate track. Recruited into Arasaka's special projects division. Trained in negotiation and asset handling.")
            .SetAffiliation("Arasaka | Special Projects Division")
            .SetCriminalRecord("Corporate immunity | Classified operations")
            .SetCyberwareStatus("Standard corporate package | Encrypted communications | Neural security")
            .SetThreatAssessment("MODERATE | Corporate backing | Non-combatant but protected | Arasaka resources on call");
    }

    public static func RalphLogan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ralph_logan").SetClassification("CIVILIAN - SERVICE")
            .SetBackground("Head bartender at The Riot nightclub in Little China. Well-connected within the club scene. Known for discretion - for the right price.")
            .SetEarlyLife("Worked various bars across Watson. Rose to head bartender at Riot through reliability and ability to keep secrets.")
            .SetAffiliation("The Riot | Little China nightlife")
            .SetCriminalRecord("Minor - serving unlicensed alcohol (dismissed)")
            .SetFinancialStatus("Service industry | Tips from wealthy clientele | Bribes for information")
            .SetThreatAssessment("LOW | Civilian | Can be bribed or intimidated for information on VIP guests");
    }

    public static func LindaSpencer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("linda_spencer").SetClassification("CIVILIAN - SERVICE")
            .SetBackground("Hostess at The Riot nightclub. Manages guest list and VIP access. Nice demeanor, perhaps too trusting for Night City.")
            .SetEarlyLife("Came to Night City with big dreams. Landed hospitality work to make ends meet. Still believes in people despite the city's harsh realities.")
            .SetAffiliation("The Riot | Little China")
            .SetCriminalRecord("CLEAN")
            .SetFinancialStatus("Service industry | Modest income | Making ends meet")
            .SetThreatAssessment("NEGLIGIBLE | Civilian | Non-combatant | Naive but hardworking");
    }

    public static func JermaineNorton() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jermaine_norton").SetClassification("SECURITY - CIVILIAN")
            .SetBackground("Head bouncer at The Riot nightclub. Former amateur boxer. Controls door access and maintains order. Respects street cred.")
            .SetEarlyLife("Grew up in Watson. Boxing career ended by injury. Transitioned to security work. Built reputation for fairness but firmness.")
            .SetAffiliation("The Riot | Security staff")
            .SetCriminalRecord("Assault (dismissed - self defense) | Battery (juvenile - sealed)")
            .SetCyberwareStatus("Basic subdermal armor | Reinforced joints")
            .SetFinancialStatus("Security wages | Door tips | Occasional favors")
            .SetThreatAssessment("MODERATE | Combat capable | Can be intimidated by sufficient reputation | Professional");
    }

    // === VENDORS - CLOTHING ===
    public static func ZaneJagger() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zane_jagger").SetClassification("VENDOR - HIGH-END RETAIL")
            .SetBackground("Manager of Jinguji clothing store in Downtown, City Center. Purveyor of Night City's finest fashion to elite clientele. Prissy demeanor, impeccable taste.")
            .SetEarlyLife("Fashion industry background. Rose through luxury retail. Secured Jinguji management position through connections and expertise.")
            .SetAffiliation("Jinguji | Downtown retail")
            .SetCriminalRecord("CLEAN")
            .SetFinancialStatus("Upper middle class | Commission on high-end sales | Luxury lifestyle")
            .SetThreatAssessment("NEGLIGIBLE | Civilian | Non-combatant | Corporate security available")
            .SetRelationships("Gillean Jordan (Client) | Elite Night City clientele")
            .SetNotes("Known for discretion regarding client purchases. Values returning customers.");
    }

    // === CYBERPSYCHOS ===
    public static func ZariaHughes() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zaria_hughes").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Former Maelstrom member. Participated in cult ritual involving near-death Net connection. Process destroyed remaining sanity.")
            .SetAffiliation("Maelstrom (Former)")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Mantis Blades (thermal) | Optical camo | Neural damage from ritual")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides | Cult activity | Gang affiliation")
            .SetThreatAssessment("EXTREME | Mantis Blades | Thermal damage | Teleportation capability | Shoot on sight");
    }

    public static func EllisCarter() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ellis_carter").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Former Maelstrom member from old regime. Targeted in internal purge by current leadership. Snapped under pressure.")
            .SetEarlyLife("Previously connected to Brick's faction. Survived gang power transition.")
            .SetAffiliation("Maelstrom (Former)")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Melee combat optimization | Reflex boosters | Poor optical implants")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides | Gang activity")
            .SetThreatAssessment("HIGH | Fast melee attacks | Glass cannon - high damage, lower health | Poor eyesight exploitable");
    }

    public static func LelyHein() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lely_hein").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Valentino member kidnapped by Maelstrom in forced recruitment attempt. Botched cyberware installation triggered psychosis.")
            .SetAffiliation("Valentinos (Former)")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Forced installation | Sniper optics | Combat augments")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides | Killed Maelstrom captors")
            .SetRelationships("Tamara Cosby (Girlfriend)")
            .SetThreatAssessment("HIGH | Sniper rifle | Long-range combatant | Will flee to covered positions");
    }

    public static func LtMower() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lt_mower").SetClassification("CYBERPSYCHO - MILITECH")
            .SetBackground("Militech Lieutenant. Suffered cyberpsychosis after military-grade cyberware installation. Contacted Dr. Sypura for help but Militech sent termination squad instead.")
            .SetEarlyLife("Military career. Rose to Lieutenant rank. Underwent extensive combat augmentation program.")
            .SetAffiliation("Militech (Former)")
            .SetCyberwareStatus("MILITARY GRADE | Gorilla Arms | Optical camo | Water electrification capability | Stealth systems")
            .SetCriminalRecord("CYBERPSYCHOSIS | Killed Militech termination squad | Multiple homicides")
            .SetThreatAssessment("EXTREME | Gorilla Arms | Stealth camo | Area denial via electrified water | Based on Ghost in the Shell");
    }

    public static func CedricMuller() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("cedric_muller").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho encountered in Downtown parking structure. Found attacking NCPD officers. Self-healing capabilities.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Regeneration implants | Combat augments")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple NCPD casualties | Public rampage")
            .SetThreatAssessment("EXTREME | Self-healing | Heavy combat capability | Currently engaged with NCPD");
    }

    public static func GastonPhillips() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gaston_phillips").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho operating out of auto shop in Wellsprings, Heywood. Has fortified position with landmines. Fast-moving combatant.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Speed augments | Combat reflexes | SMG proficiency")
            .SetCriminalRecord("CYBERPSYCHOSIS | Area denial with explosives | Multiple homicides")
            .SetThreatAssessment("HIGH | Landmines | Fast movement | SMG user | Area heavily trapped");
    }

    public static func DaoHyunh() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dao_hyunh").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho encountered at Seaside Cafe in southern Heywood. Extremely fast movement capabilities.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Extreme speed augments | Sandevistan-type system")
            .SetCriminalRecord("CYBERPSYCHOSIS | Public attack | Cafe massacre")
            .SetThreatAssessment("HIGH | Extreme speed | Difficult to track | Close quarters dangerous");
    }

    public static func DiegoRamirez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("diego_ramirez").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho found at pier in Coastview, Pacifica. Regina specifically requests non-lethal neutralization.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Combat augments")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides")
            .SetThreatAssessment("HIGH | Priority: Non-lethal capture requested")
            .SetNotes("Regina Jones has requested this subject be taken alive for study.");
    }

    public static func TamaraCosby() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tamara_cosby").SetClassification("CYBERPSYCHO - NETRUNNER")
            .SetBackground("Netrunner who went cyberpsycho while searching for kidnapped boyfriend Lely Hein. Found at homeless camp in Arroyo, Santo Domingo.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Netrunner suite | Automated turret deployment")
            .SetCriminalRecord("CYBERPSYCHOSIS | Turret deployment in civilian area")
            .SetRelationships("Lely Hein (Boyfriend - also cyberpsycho)")
            .SetThreatAssessment("HIGH | Automated turrets | Netrunner capabilities | Pistol user");
    }

    public static func MattLiaw() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("matt_liaw").SetClassification("CYBERPSYCHO - EX-MILITECH")
            .SetBackground("Former Militech mercenary. Lost health insurance policy following employment termination. PTSD combined with cyberware rejection triggered psychosis.")
            .SetEarlyLife("Militech corporate merc. Extensive combat deployments. Company terminated employment and coverage.")
            .SetAffiliation("Militech (Former)")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Military-grade combat suite | PTSD-related degradation")
            .SetCriminalRecord("CYBERPSYCHOSIS | Insurance fraud victim | Multiple homicides")
            .SetThreatAssessment("HIGH | Military training | Heavy weapons | Living in shipping container")
            .SetNotes("Victim of corporate healthcare system. Policy lapsed after termination.");
    }

    public static func ChaseColey() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("chase_coley").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho encountered at construction site in southern Rancho Coronado, Santo Domingo. Found actively fighting security guard upon arrival.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Heavy combat augments | Armor plating")
            .SetCriminalRecord("CYBERPSYCHOSIS | Construction site rampage | Assault on security")
            .SetThreatAssessment("HIGH | Heavily armed and armored | Can one-shot from corners");
    }

    public static func RusselGreene() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("russel_greene").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho located at farm north of highway in Badlands. Position defended by drones and security turrets.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Combat augments | Drone control interface")
            .SetCriminalRecord("CYBERPSYCHOSIS | Farm fortification | Electronic warfare")
            .SetThreatAssessment("HIGH | Drone support | Turret defense | Use Remote Deactivation")
            .SetNotes("Disable electronics before engaging. Stealth headshot recommended.");
    }

    public static func ZionWylde() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zion_wylde").SetClassification("CYBERPSYCHO - EX-MERC")
            .SetBackground("Former mercenary who succumbed to cyberpsychosis. Combat veteran with extensive field experience.")
            .SetEarlyLife("Merc career. Multiple contracts across Night City and Badlands.")
            .SetAffiliation("Independent (Former)")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Combat-grade augments | Veteran implant suite")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides")
            .SetThreatAssessment("HIGH | Experienced combatant | Merc training | Unpredictable");
    }

    public static func NorioAkuhara() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("norio_akuhara").SetClassification("CYBERPSYCHO - EX-TYGER CLAWS")
            .SetBackground("Former Tyger Claws member who went cyberpsycho. Gang ties severed after mental break.")
            .SetEarlyLife("Rose through Tyger Claws ranks. Extensive cyberware installation as gang requirement.")
            .SetAffiliation("Tyger Claws (Former)")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Gang-standard augments | Katana proficiency implants")
            .SetCriminalRecord("CYBERPSYCHOSIS | Former gang affiliation | Multiple homicides")
            .SetThreatAssessment("HIGH | Tyger Claws combat training | Melee specialist | Fast reflexes");
    }

    public static func ShinobuImai() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("shinobu_imai").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho with extensive combat modifications. Highly dangerous close-quarters combatant.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Sandevistan | Combat augments | Speed optimization")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides")
            .SetThreatAssessment("EXTREME | Time dilation capable | Extremely fast | Melee focused");
    }

    public static func KaiserHerzog() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kaiser_herzog").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Heavily augmented cyberpsycho. Name suggests European origin. Extreme threat level.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Heavy combat suite | Maximum augmentation")
            .SetCriminalRecord("CYBERPSYCHOSIS | Mass casualties")
            .SetThreatAssessment("EXTREME | Heavily augmented | High damage output | Armored");
    }

    public static func TomAyer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tom_ayer").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho encountered during NCPD scanner operation. Snapped under unknown circumstances.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Combat augments")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple homicides")
            .SetThreatAssessment("HIGH | Standard cyberpsycho threat profile");
    }

    public static func AlecJohnson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alec_johnson").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho target. Descended into psychosis following cyberware overload.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Combat implants")
            .SetCriminalRecord("CYBERPSYCHOSIS | Violent rampage")
            .SetThreatAssessment("HIGH | Active threat | Armed and dangerous");
    }

    public static func TracyPhillips() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tracy_phillips").SetClassification("CYBERPSYCHO - ACTIVE")
            .SetBackground("Cyberpsycho encountered in Night City. Related to Gaston Phillips unknown.")
            .SetAffiliation("None")
            .SetCyberwareStatus("CRITICAL OVERLOAD | Combat systems")
            .SetCriminalRecord("CYBERPSYCHOSIS | Multiple violent incidents")
            .SetThreatAssessment("HIGH | Combat capable | Psychotic break active");
    }

    // === NCPD SCANNER HUSTLES / ASSAULT IN PROGRESS ===
    public static func RufusMcBride() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rufus_mcbride").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal flagged in NCPD scanner system. Active warrant for violent crimes.")
            .SetCriminalRecord("NCPD PRIORITY | Multiple violent offenses | Armed and dangerous")
            .SetThreatAssessment("HIGH | Armed | Resist arrest likely");
    }

    public static func EuralioAlma() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("euralio_alma").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Subject flagged during NCPD scanner operation. Known criminal element.")
            .SetCriminalRecord("NCPD WARRANT | Criminal activity")
            .SetThreatAssessment("MODERATE | May be armed | Approach with caution");
    }

    public static func BruceWard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bruce_ward").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD target with outstanding warrants. Criminal operations in Night City.")
            .SetCriminalRecord("NCPD PRIORITY | Multiple charges")
            .SetThreatAssessment("HIGH | Potentially armed | Criminal associates likely");
    }

    public static func ZoeAlonzo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zoe_alonzo").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Female criminal flagged in NCPD database. Active in Night City underworld.")
            .SetCriminalRecord("NCPD WARRANT | Criminal enterprise involvement")
            .SetThreatAssessment("MODERATE | Armed suspect | Gang connections possible");
    }

    public static func MiguelRodriguez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("miguel_rodriguez").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD scanner target. Hispanic male with criminal history in Night City.")
            .SetCriminalRecord("NCPD PRIORITY | Violent crimes | Gang affiliation suspected")
            .SetThreatAssessment("HIGH | Armed and dangerous | Valentino connection possible");
    }

    public static func DenzelCryer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("denzel_cryer").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal subject in NCPD scanner system. Outstanding warrants for violent offenses.")
            .SetCriminalRecord("NCPD PRIORITY | Assault charges | Armed robbery")
            .SetThreatAssessment("HIGH | Violent history | Will resist");
    }

    public static func JesseSabara() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jesse_sabara").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD target with active warrants. Known to operate in Night City criminal circles.")
            .SetCriminalRecord("NCPD WARRANT | Multiple offenses")
            .SetThreatAssessment("MODERATE | Armed suspect | May have backup");
    }

    public static func StanislausZbyszko() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("stanislaus_zbyszko").SetClassification("CRIMINAL - SCAVENGER CAPTAIN")
            .SetBackground("Known captain amongst scavengers. Multiple smuggling priors. Eastern European origin.")
            .SetAffiliation("Scavengers (Leadership)")
            .SetCriminalRecord("NCPD PRIORITY | Scavenger captain | Smuggling | Cyberware trafficking | Kidnapping")
            .SetThreatAssessment("HIGH | Gang leadership | Armed crew | Organ harvesting operations");
    }

    public static func BenDeBaillon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ben_debaillon").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal flagged in NCPD scanner. French-origin surname suggests immigrant background.")
            .SetCriminalRecord("NCPD WARRANT | Criminal activity in Night City")
            .SetThreatAssessment("MODERATE | Approach with standard caution");
    }

    public static func AyoZarin() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ayo_zarin").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD scanner target. Active in Night City criminal underworld.")
            .SetCriminalRecord("NCPD PRIORITY | Outstanding warrants")
            .SetThreatAssessment("MODERATE | Armed suspect");
    }

    public static func RossUlmer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ross_ulmer").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal subject flagged during NCPD operation. German-origin surname.")
            .SetCriminalRecord("NCPD WARRANT | Multiple charges")
            .SetThreatAssessment("MODERATE | Standard criminal threat");
    }

    public static func AntonKolev() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anton_kolev").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD target with Slavic background. Criminal operations in Night City.")
            .SetCriminalRecord("NCPD PRIORITY | Violent crimes")
            .SetThreatAssessment("HIGH | Armed | Eastern European criminal connections");
    }

    public static func JohnQuaid() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("john_quaid").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal flagged in NCPD scanner system. Active warrant enforcement target.")
            .SetCriminalRecord("NCPD WARRANT | Multiple offenses")
            .SetThreatAssessment("MODERATE | May be armed");
    }

    public static func DariusMiles() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("darius_miles").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD scanner target. Known criminal operating in Night City streets.")
            .SetCriminalRecord("NCPD PRIORITY | Gang activity suspected | Violent crimes")
            .SetThreatAssessment("HIGH | Armed | Street-level criminal");
    }

    public static func PaulCraven() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("paul_craven").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal subject in NCPD database. Outstanding warrants.")
            .SetCriminalRecord("NCPD WARRANT | Criminal charges pending")
            .SetThreatAssessment("MODERATE | Standard threat level");
    }

    public static func OlgaLongmead() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("olga_longmead").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Female criminal flagged during NCPD operation. Full name: Olga Elisabeth Longmead.")
            .SetCriminalRecord("NCPD WARRANT | Criminal activity")
            .SetThreatAssessment("MODERATE | Armed female suspect | Approach cautiously");
    }

    public static func MikeKowalsky() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mike_kowalsky").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("NCPD scanner target. Polish-American background. Night City criminal.")
            .SetCriminalRecord("NCPD PRIORITY | Violent offenses")
            .SetThreatAssessment("HIGH | Armed and dangerous");
    }

    public static func SamanthaSamu() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("samantha_samu").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Female criminal in NCPD database. Active in Night City underworld.")
            .SetCriminalRecord("NCPD WARRANT | Outstanding charges")
            .SetThreatAssessment("MODERATE | Suspect may be armed");
    }

    public static func BarryAlken() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("barry_alken").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Criminal flagged in NCPD scanner system. Not to be confused with NCPD Officer Barry.")
            .SetCriminalRecord("NCPD WARRANT | Criminal activity")
            .SetThreatAssessment("MODERATE | Armed suspect");
    }

    public static func MokomichiYamada() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mokomichi_yamada").SetClassification("CRIMINAL - NCPD TARGET")
            .SetBackground("Japanese male flagged in NCPD scanner. Criminal operations potentially linked to Tyger Claws territory.")
            .SetCriminalRecord("NCPD PRIORITY | Gang affiliation suspected | Criminal enterprise")
            .SetThreatAssessment("HIGH | Possible Tyger Claws connection | Armed | Melee weapons likely");
    }

    // === NOTABLE NIGHT CITY RESIDENTS ===
    public static func BigPete() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("big_pete").SetClassification("TECHIE - WRAITH AFFILIATE")
            .SetBackground("Pete Kowalski, known as Big Pete. Manager of New American Autoworks garage in the southern Badlands near the border. Former Night City technician who made powerful enemies and fled to the desert. Now survives by keeping Wraith vehicles running.")
            .SetEarlyLife("Started as street-level techie in Night City. Had a knack for electronics and signal equipment. Made a name selling custom jammers and tech to mercs and fixers. Career ended badly when a faulty signal jammer he sold got someone important killed.")
            .SetAffiliation("Wraiths (Raffen Shiv)")
            .SetCriminalRecord("WANTED IN NC | Fraud | Negligent homicide (equipment failure) | Multiple civil suits | Fled jurisdiction")
            .SetRelationships("Tiny Mike (Brother - merc operating in Night City, estranged)")
            .SetNotes("Cowardly | Self-preservation focused | Will say anything to survive | Not built for violence")
            .SetFinancialStatus("Desperate | Constantly begging brother for eddies | Living paycheck to paycheck on Wraith mechanic work")
            .SetThreatAssessment("LOW | Non-combatant | Mechanic, not fighter | No cyberware of note | Will negotiate and beg under pressure");
    }

    public static func BruceWelby() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bruce_welby").SetClassification("SMUGGLER - BADLANDS")
            .SetBackground("Career smuggler who has been moving cargo across the Night City-SoCal border for over a decade. Specializes in 'hot' goods - items too dangerous or illegal to move through official channels. Known for reliability and discretion.")
            .SetEarlyLife("Grew up in the Badlands. Learned smuggling routes from family. Built network of contacts on both sides of the border and both sides of the law. Reputation for always delivering, no matter the cargo.")
            .SetCriminalRecord("EXTENSIVE | Smuggling | Border violations | Contraband transport | Tax evasion | Multiple arrests, few convictions")
            .SetRelationships("Archibald Crane (Close friend - Militech employee who occasionally helps with border crossings)")
            .SetNotes("Professional | Calm under pressure | Loyal to friends | Knows when to keep his mouth shut")
            .SetFinancialStatus("Comfortable | Good income from smuggling work | Invests in maintaining border contacts")
            .SetThreatAssessment("LOW | Smuggler, not fighter | Prefers to run rather than fight | Value in border knowledge and contacts");
    }

    public static func BenedictMcAdams() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("benedict_mcadams").SetClassification("MERCENARY - PROFESSIONAL")
            .SetBackground("Reliable, professional mercenary who built his reputation in the Badlands. Known for clean, efficient work and absolute discretion. Unusual practice of installing GPS tracker in his own biomon to prove accountability to clients.")
            .SetEarlyLife("Military background suspected but unconfirmed. Transitioned to mercenary work in his thirties. Built reputation through consistent, professional performance. Never takes jobs he can't complete.")
            .SetAffiliation("Independent operator")
            .SetCriminalRecord("CLASSIFIED | Records sealed | Multiple suspected contract killings | No convictions | Professional enough to avoid evidence")
            .SetNotes("Disciplined | Methodical | Zero ego | Treats killing as profession, not passion")
            .SetCyberwareStatus("Standard combat suite | GPS biomon (voluntary) | Neural processor | Sandevistan suspected")
            .SetThreatAssessment("EXTREME | Professional killer | Combat trained | Disciplined operator | Do not engage without preparation");
    }

    public static func IrisTanner() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("iris_tanner").SetClassification("TECHIE - BADLANDS SPECIALIST")
            .SetBackground("Considered the best technical specialist in the Badlands. Can fix anything mechanical - vehicles, water filters, generators, solar arrays, you name it. Has saved entire communities during equipment failures. Unfortunately, her skill with machines doesn't extend to reading people.")
            .SetEarlyLife("Self-taught mechanical genius. Grew up taking apart and rebuilding anything she could find. Built reputation by keeping Badlands communities running when corporate repair was too expensive or too far away.")
            .SetCriminalRecord("CLEAN | Legitimate technician | No criminal history")
            .SetNotes("Brilliant with machines | Naive with people | Trusts too easily | Cannot read ulterior motives | Gets taken advantage of")
            .SetFinancialStatus("Modest | Undercharges for work | Often paid in trade or favors")
            .SetThreatAssessment("NONE | Civilian | Non-combatant | Absolutely no combat training | Valuable for technical skills only");
    }

    public static func JackMausser() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jack_mausser").SetClassification("MERCENARY - CLUB OWNER")
            .SetBackground("Solo turned club owner who couldn't leave the violence behind. Became addicted to the adrenaline of killing - not for money, but for the rush. Recently purchased 7th Hell, a seedy club in City Center, and hired Animals for security. Still takes jobs, but they've become increasingly brutal.")
            .SetEarlyLife("Started as competent merc. Over time, developed taste for violence that went beyond professional necessity. Prefers making targets scream rather than quick, clean kills. Reputation shifted from 'effective' to 'psychotic'.")
            .SetAffiliation("Independent | Animals (security arrangement for his club)")
            .SetCriminalRecord("MULTIPLE HOMICIDES | Excessive force | Property destruction | Decapitations | Made enemies of multiple corporations through brutality")
            .SetNotes("Adrenaline junkie | Addicted to violence | Cannot control impulses | Knows he's making enemies | Doesn't care")
            .SetFinancialStatus("Wealthy | Club ownership | Mercenary income | Spending heavily on Animals protection")
            .SetCyberwareStatus("Extensive combat augmentation | Reflex boosters | Sandevistan likely | Pain editors")
            .SetThreatAssessment("EXTREME | Combat specialist | Animals backup on premises | Unpredictable | Psychotic tendencies | Owns 7th Hell club in City Center");
    }

    public static func JoanneKoch() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("joanne_koch").SetClassification("BIOTECHNICA EXECUTIVE")
            .SetBackground("Dr. Joanne Koch. Regional Director for Technology and Development at Biotechnica. Genetics engineer whose 'unscrupulous' reputation stands out even among corporate scientists. Responsible for Project Nightingale - an experimental program that killed over 70 nomads from the Red Ocher clan during unauthorized field testing.")
            .SetEarlyLife("Rose through Biotechnica ranks by delivering results regardless of ethical cost. Uses citizens as test subjects. Has ordered hits on employees who threatened her position. No moral boundaries in pursuit of scientific breakthrough.")
            .SetAffiliation("Biotechnica (Executive level)")
            .SetCriminalRecord("CORPORATE PROTECTED | Human experimentation | 70+ deaths (Red Ocher clan) | Test subject coercion | Evidence suppression | Protected by Biotechnica legal")
            .SetNotes("Sociopathic | No moral reservations | Views human life as expendable research material | Trail of bodies rivals professional killers")
            .SetFinancialStatus("Extremely wealthy | Corporate executive salary | Biotechnica Hotel penthouse residence | Extensive security budget")
            .SetThreatAssessment("LOW personally | HIGH via corporate security | Robotics and armed guards | 19th floor penthouse | Biotechnica response team on call");
    }

    public static func EvaCole() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("eva_cole").SetClassification("POLITICIAN - NIGHT CITY")
            .SetBackground("Night City politician who has made powerful enemies by actually trying to enforce regulations against corporate illegal activities. One of the few politicians who hasn't been completely bought. This has made her both admired and endangered.")
            .SetCriminalRecord("CLEAN | No criminal history | Anti-corruption stance")
            .SetNotes("Idealistic | Genuinely believes in rule of law | Willing to challenge corporations | Naive about depth of corruption")
            .SetFinancialStatus("Modest for politician | Refuses most 'contributions' | Limited security budget")
            .SetThreatAssessment("NONE personally | Politician with limited security | Multiple corporate enemies");
    }

    public static func TuckerAlbach() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tucker_albach").SetClassification("CORPORATE - KIROSHI OPTICS")
            .SetBackground("Lucy Montgomery Tucker Albach. Former Vice Managing Director at Kiroshi Optics. Removed from the board by CEO Jacob Lan following a hit-and-run incident. Lives in an apartment in The Glen, Heywood. Her corporate insurance has protected her from prosecution despite clear evidence of guilt.")
            .SetEarlyLife("Rose to VP level at Kiroshi Optics through competence and connections. Lived the corpo lifestyle - fast cars, expensive tastes, complete disconnection from consequences.")
            .SetAffiliation("Kiroshi Optics (Former executive - removed from board but still protected)")
            .SetCriminalRecord("VEHICULAR MANSLAUGHTER | Hit and run while intoxicated | Victim: Rosita Fuscino, age 17 | Left victim to die | NCPD investigation blocked by corporate insurance | No prosecution")
            .SetNotes("Entitled | Believes money can solve any problem | Zero remorse | Completely detached from consequences of actions")
            .SetFinancialStatus("Wealthy | Corporate severance | Maintains expensive lifestyle | Safe containing valuables")
            .SetThreatAssessment("NONE personally | Non-combatant | Will attempt to bribe her way out of any situation | Some security in building");
    }

    public static func RebecaPrice() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rebeca_price").SetClassification("SHOP OWNER - COERCED")
            .SetBackground("Runs Data Inc. store in Wellsprings, Heywood. On the surface, a legitimate cyberware retailer. In reality, being forced to sell stolen Militech equipment through unofficial channels. Not a willing criminal - operating under extreme duress.")
            .SetAffiliation("Animals (Coerced - not voluntary)")
            .SetCriminalRecord("CYBERWARE TRAFFICKING | Selling stolen Militech goods | Operating as fence | All under duress")
            .SetRelationships("Family member (Identity protected - held as leverage by Animals)")
            .SetNotes("Terrified | Desperate | Trapped | Only cooperating because family member's life at stake")
            .SetFinancialStatus("Store provides income | Most profit goes to Animals | Living in fear")
            .SetThreatAssessment("NONE | Shop owner | Non-combatant | Victim of circumstances | No combat capability");
    }

    public static func KaruboBairei() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("karubo_bairei").SetClassification("CRIMINAL - JAPANTOWN")
            .SetBackground("Japanese criminal operating in Japantown. Suspected ties to Tyger Claws operations, though affiliation unconfirmed. Involved in protection rackets and illegal gambling.")
            .SetAffiliation("Tyger Claws (Suspected)")
            .SetCriminalRecord("EXTORTION | Illegal gambling | Protection rackets | Assault | Japantown operations")
            .SetNotes("Traditional values | Honor-focused | Violent when disrespected")
            .SetThreatAssessment("MODERATE | Possible gang backup | Likely melee specialist | Tyger Claw combat training probable");
    }

    public static func JakeEstevez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jake_estevez").SetClassification("CRIMINAL - STREET LEVEL")
            .SetBackground("Street-level criminal operating in Night City. Small-time operator who handles various illegal jobs - theft, smuggling, occasional muscle work. Not affiliated with major gangs, prefers to stay independent.")
            .SetCriminalRecord("MULTIPLE OFFENSES | Theft | Smuggling | Assault | Operates independently")
            .SetNotes("Opportunistic | Self-interested | Avoids major gang conflicts | Knows his limits")
            .SetThreatAssessment("MODERATE | Armed | Street-smart | Will fight if cornered");
    }

    public static func JoseLuis() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jose_luis").SetClassification("VALENTINOS - ROGELIO'S CREW")
            .SetBackground("José Luis. Valentino gang member, part of Rogelio's crew in Heywood. Shot and killed an NCPD officer during a confrontation. Investigation was mysteriously dropped and officers told to back off - suggesting powerful protection from outside the gang.")
            .SetEarlyLife("Grew up in Heywood. Joined Valentinos young. Rose through Rogelio's crew. Developed connections that extend beyond typical gang networks.")
            .SetAffiliation("Valentinos (Rogelio's crew)")
            .SetCriminalRecord("COP KILLER | Shot NCPD officer | Investigation dropped | Protected by unknown high-level contacts")
            .SetRelationships("Roberto Luis (Grandfather - elderly, requires care) | Rogelio (Crew leader)")
            .SetNotes("Loyal to crew | Cares for grandfather | Cold when necessary | Has connections above his station")
            .SetThreatAssessment("HIGH | Valentino combat training | Armed | Gang backup | Powerful protectors");
    }

    public static func GustavoOrta() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gustavo_orta").SetClassification("VALENTINOS - LEADERSHIP")
            .SetBackground("High-ranking Valentino, blood relative of imprisoned gang leader Campo Orta. Built reputation as one of the most ruthless enforcers in Heywood - known for systematically eliminating rival gang presence. Recently, something changed. He's become more contemplative, less quick to violence.")
            .SetEarlyLife("Grew up in Heywood alongside Jackie Welles. Both were Valentinos as teenagers. While Jackie eventually left gang life, Gustavo embraced it fully and climbed to the top through brutal efficiency. Childhood friendship with Jackie remained despite different paths.")
            .SetAffiliation("Valentinos (Leadership tier)")
            .SetCriminalRecord("VALENTINO ENFORCER | Multiple homicides | Gang warfare | Rival elimination | Recently inactive")
            .SetRelationships("Campo Orta (Blood relative - gang leader, imprisoned) | Jackie Welles (Childhood friend - paths diverged) | Martha Frakes (Girlfriend - complicated)")
            .SetNotes("Formerly ruthless | Recently changed | More thoughtful | Spends time contemplating rather than killing | Love may have softened him")
            .SetThreatAssessment("EXTREME | Veteran killer | Gang leadership | Armed guards | But recently non-violent");
    }

    public static func MarthaFrakes() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("martha_frakes").SetClassification("CIVILIAN - DIVIDED LOYALTIES")
            .SetBackground("Daughter of Nolan Frakes, senior member of 6th Street. Defected from her family and gang to pursue a relationship with Valentino leader Gustavo Orta. Living between two rival gang worlds that would normally kill each other on sight.")
            .SetEarlyLife("Raised in 6th Street culture. Father is senior gang member. Expected to marry within the gang. Rebelled against everything by falling for a Valentino leader - the worst possible choice from her family's perspective.")
            .SetAffiliation("6th Street (Family) | Valentinos (Through relationship)")
            .SetCriminalRecord("CLEAN | No personal charges | Family gang connections only")
            .SetRelationships("Nolan Frakes (Father - 6th Street, furious about relationship) | Gustavo Orta (Boyfriend - Valentinos)")
            .SetNotes("Rebellious | Strong-willed | Chose love over family | Living in constant danger from both sides")
            .SetThreatAssessment("NONE | Civilian | No combat training | Value only as leverage");
    }

    public static func AnthonyAnderson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anthony_anderson").SetClassification("CRIMINAL")
            .SetBackground("Criminal operator in Night City. Involved in various illegal enterprises. Keeps low profile, avoids major gang territories.")
            .SetCriminalRecord("MULTIPLE CHARGES | Theft | Fencing | Minor assault")
            .SetThreatAssessment("MODERATE | Potentially armed | Street-level threat");
    }

    public static func MilkoAlexis() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("milko_alexis").SetClassification("CRIMINAL - EASTERN EUROPEAN")
            .SetBackground("Eastern European criminal with suspected connections to Scavenger operations. May be involved in cyberware trafficking given known associates and operational patterns.")
            .SetAffiliation("Scavengers (Suspected)")
            .SetCriminalRecord("TRAFFICKING suspected | Cyberware theft | Eastern European criminal network ties")
            .SetThreatAssessment("MODERATE | Armed | Potentially Scavenger tactics | Ruthless if cornered");
    }

    public static func LeonRinder() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("leon_rinder").SetClassification("BARGHEST - FORMER TRIGGERMAN")
            .SetBackground("Leon Rinder. One of Kurt Hansen's former triggermen. Discharged from BARGHEST under unclear circumstances. Responsible for the massacre of eight civilians in the Longshore Stacks, including a young man named Jason Foreman. Currently hiding in an abandoned motel in Pacifica, guarded by a single elite bodyguard.")
            .SetEarlyLife("Military background funneled into BARGHEST private military service. Rose through Hansen's ranks as a reliable enforcer. Something broke — the massacre in the Stacks was not an ordered hit. The question is what caused him to snap.")
            .SetAffiliation("BARGHEST (Former — discharged)")
            .SetCriminalRecord("MASS MURDER | Eight civilian deaths in Longshore Stacks | Former BARGHEST enforcement operations | Possible cyberpsychosis-related violence")
            .SetMedicalStatus("CRITICAL — CYBERPSYCHOSIS INDICATORS | Memory gaps surrounding massacre | Cannot recall killing anyone | Classic dissociative symptoms consistent with advanced cyberware rejection")
            .SetCyberwareStatus("HEAVY MILITARY-GRADE | Extensive combat augmentation from BARGHEST service | Possible contributing factor to psychological deterioration")
            .SetRelationships("Kurt Hansen (Former commander — discharged him) | Yasha Ivanov (Bodyguard — loyal) | Briana Dolson (Community representative — wants him dead) | Longshore Stacks community (Victims' families — seeking justice)")
            .SetNotes("May not fully understand what he did | Offers his dog tags and stash location in exchange for his life | Stash contains Dezerter iconic shotgun | Can be referred to Regina Jones for cyberpsychosis treatment if identified")
            .SetThreatAssessment("HIGH | Former military elite | Heavy cyberware | Bodyguard Yasha Ivanov must be defeated first | Unstable — cyberpsychosis makes behavior unpredictable");
    }

    public static func JasmineDixon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jasmine_dixon").SetClassification("CIVILIAN")
            .SetBackground("Night City resident. Limited public information available.")
            .SetCriminalRecord("CLEAN")
            .SetThreatAssessment("LOW | Non-combatant");
    }

    public static func JulietHorrigan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("juliet_horrigan").SetClassification("NETRUNNER")
            .SetBackground("Skilled netrunner specializing in corporate data extraction, particularly from Zetatech systems. Lives with her sister Rose in their family home on Gibson Street, Rancho Coronado. Valued for reliable, clean data work.")
            .SetEarlyLife("Developed netrunning expertise through self-study and practice. Built reputation for Zetatech penetration specifically. Takes care of her sister Rose, who has been struggling with mental health issues.")
            .SetCriminalRecord("CORPORATE ESPIONAGE | Zetatech data theft | No violent crimes")
            .SetRelationships("Rose Horrigan (Sister - lives together, concerning behavior recently) | Viktor Vektor (Medical contact - consulted about sister)")
            .SetMedicalStatus("Healthy | No significant issues")
            .SetNotes("Caring | Devoted to sister | Professional in work | Worried about Rose's deteriorating condition")
            .SetFinancialStatus("Comfortable | Regular income from data work | Family home owner")
            .SetThreatAssessment("LOW | Netrunner, not fighter | Value in data extraction skills");
    }

    public static func LoganGarcia() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("logan_garcia").SetClassification("ANIMALS - FIGHT CLUB")
            .SetBackground("Runs the Tripple Xtreme Epic Workout Center - an Animals-backed underground fight club in an old paint factory in Rancho Coronado. Former fighter who still gets in the ring regularly. Known for not knowing when to stop - has beaten opponents long past the point of surrender.")
            .SetEarlyLife("Started as fighter in underground circuit. Rose to run his own club with Animals gang backing. Fighting is his identity - he lives for the violence of the ring.")
            .SetAffiliation("Animals")
            .SetCriminalRecord("ASSAULT | Multiple ring deaths | Excessive force | Body disposal (suspected) | Protected by Animals")
            .SetNotes("Cannot control aggression | No concept of 'too far' | Views weakness with contempt | Dangerous in any confrontation")
            .SetCyberwareStatus("Animals-standard muscle and bone augmentation | Pain editor likely | Combat reflexes")
            .SetThreatAssessment("EXTREME | Animals combat augments | Professional fighter | Gang backup at club | Will not back down");
    }

    public static func FlaviodosSantos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("flavio_dos_santos").SetClassification("6TH STREET - OUTCAST")
            .SetBackground("Former 6th Street member who backed the wrong side during Will Gunner's coup. Was loyal to the previous leadership and found himself on the losing team when Gunner took over. Known for reckless confidence and a belief in his own invincibility despite mounting evidence to the contrary.")
            .SetEarlyLife("Rose through 6th Street ranks under old leadership. Loyal soldier, not a leader. When the coup happened, he was on the wrong list. Has survived through luck more than skill.")
            .SetAffiliation("6th Street (Former - marked by current leadership)")
            .SetCriminalRecord("GANG ACTIVITY | 6th Street operations | Currently hunted by own former gang")
            .SetNotes("Reckless | Dangerously overconfident | Believes in his own luck | Throws parties while being hunted | Cannot take situations seriously")
            .SetFinancialStatus("Unstable | Burning through savings | Spending on parties instead of security")
            .SetThreatAssessment("LOW | Non-combatant | Injured | More danger to himself than others");
    }

    public static func VicVega() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("vic_vega").SetClassification("CORPORATE SECURITY - C-TEAM")
            .SetBackground("Head of C-Team, a private security company that specializes in corporate union-busting and worker intimidation. Has been terrorizing workers in Rancho Coronado on behalf of corporate clients. Lists 'cracking skulls' as a hobby on his employee profile.")
            .SetEarlyLife("Corporate security background. Rose to lead C-Team through willingness to do what others wouldn't. Found his calling in causing pain for pay.")
            .SetAffiliation("C-Team (Leadership) | Various corporate clients (confidential)")
            .SetCriminalRecord("ASSAULT | Union busting | Worker intimidation | Multiple injuries caused | All charges blocked by corporate legal backing")
            .SetNotes("Sadistic | Genuinely enjoys inflicting pain | No moral qualms | Views workers as subhuman | Violence is pleasure, not just business")
            .SetCyberwareStatus("Corporate security standard | Combat augments | Pain tolerance mods")
            .SetThreatAssessment("HIGH | Corporate security training | Violent tendencies | C-Team backup available");
    }

    // === WATSON DISTRICT NOTABLES ===
    public static func RohChiWon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("roh_chi_won").SetClassification("BOXING COACH - PROFESSIONAL")
            .SetBackground("Roh Chi-Won (노지원). Former professional boxer with dozens of wins. Now works as personal boxing coach for high-profile clients, most notably Macidew Coolidge of N54's 'Boxathon' fame.")
            .SetEarlyLife("Successful competitive boxing career in youth. Transitioned to coaching after retirement from the ring. Developed reputation as trainer who could turn anyone into a fighter.")
            .SetCriminalRecord("CLEAN | No criminal history | Professional athlete background")
            .SetRelationships("Macidew Coolidge (Client - N54 sports commentator)")
            .SetNotes("Disciplined | Patient teacher | Dedicated to craft | Loyal to clients")
            .SetThreatAssessment("MODERATE | Boxing skills | No longer in fighting shape | Non-combatant mindset");
    }

    public static func TinyMike() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tiny_mike").SetClassification("MERCENARY - INDEPENDENT")
            .SetBackground("Mike Kowalski, known as Tiny Mike. Street kid turned merc who built his reputation from nothing. Joined Tyger Claws at age 11, was dealing by 12, left at 15 to go independent. Now works for various fixers across Night City.")
            .SetEarlyLife("Raised on Night City streets. Learned early that only two things matter: keeping your word and cold hard cash. Dozens of scars and close calls later, achieved recognition from fixers citywide.")
            .SetAffiliation("Independent | Former Tyger Claws")
            .SetCriminalRecord("EXTENSIVE | Drug dealing (juvenile) | Multiple assault charges | B&E | Survived numerous gang conflicts")
            .SetRelationships("Big Pete (Brother - mechanic in Badlands) | Christine Markov (Ex-girlfriend - Cherry Blossom Market vendor)")
            .SetMedicalStatus("Elbow joints repaired by Charles Bucks")
            .SetNotes("Street smart | Loyal to family despite frustration | Keeps his word | Values cash")
            .SetThreatAssessment("HIGH | Combat experienced | Survived Tyger Claws | Quick reflexes");
    }

    public static func BryceStone() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bryce_stone").SetClassification("MEDIA - TELEVANGELIST")
            .SetBackground("Television minister with significant following in Night City. Public figure known for religious broadcasting. Has experienced personal tragedy that has driven him to seek justice outside official channels.")
            .SetEarlyLife("Built career as televangelist. Accumulated wealth and influence through religious media programming.")
            .SetCriminalRecord("CLEAN | Public figure | No criminal record")
            .SetRelationships("Bobby Stone (Son - deceased)")
            .SetFinancialStatus("Wealthy | Television ministry income | Willing to spend on personal matters")
            .SetNotes("Grieving father | Driven by need for justice | Willing to work outside the law to find answers")
            .SetThreatAssessment("NONE | Non-combatant | Value in resources and connections");
    }

    public static func HwangboDongGun() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hwangbo_dong_gun").SetClassification("CRIMINAL - FORMER TYGER CLAWS")
            .SetBackground("Hwangbo Dong-Gun (황보동건). Korean male, former low-level Tyger Claws associate. Got greedy, got caught stealing from his superiors. Now marked for death by the gang he used to work for.")
            .SetEarlyLife("Did small-time work for Tyger Claws. Instead of keeping his head down and being patient, took a shortcut by stealing from his own gang. Left evidence that pointed directly to him.")
            .SetAffiliation("Tyger Claws (Former - marked for death)")
            .SetCriminalRecord("THEFT | Stole from Tyger Claws | Gang activity | Now hunted by former associates")
            .SetNotes("Reckless | Short-sighted | Surprisingly upbeat despite situation | Gives people nicknames")
            .SetThreatAssessment("LOW | Non-combatant | More danger to himself | Tyger Claws actively hunting him");
    }

    public static func MaxJones() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("max_jones").SetClassification("MEDIA - INVESTIGATIVE JOURNALIST")
            .SetBackground("Independent journalist specializing in exposing corporate scandals. Former colleague of Regina Jones from her muckraking days. Known for being stubborn as they come and thinking he's invincible.")
            .SetEarlyLife("Built career as investigative journalist. Co-wrote podcast with Regina Jones about independent farmers put out of business by Biotechnica drones. Continued kicking hornet's nests after Regina moved on.")
            .SetCriminalRecord("CLEAN | Journalist | Multiple corporate enemies")
            .SetRelationships("Regina Jones (Old friend and former colleague - no longer takes her calls)")
            .SetNotes("Stubborn | Lost touch with reality | Thinks he can manage on his own | Young male bravado")
            .SetThreatAssessment("NONE | Non-combatant | Multiple enemies want him dead | Doesn't realize the danger he's in");
    }

    public static func AloisDaquin() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alois_daquin").SetClassification("CORPORATE - KANG TAO")
            .SetBackground("Kang Tao employee who betrayed multiple people in Night City, including fixer Regina Jones. Known as a 'corpo megaprick' who cheated his way through business dealings. Made enough enemies that an entire city wants a piece of him.")
            .SetAffiliation("Kang Tao")
            .SetCriminalRecord("FRAUD | Corporate espionage | Betrayal | Multiple civil suits | Fled jurisdiction")
            .SetNotes("Treacherous | Self-serving | No loyalty | Left gear behind when fleeing")
            .SetThreatAssessment("LOW | Non-combatant | Corporate suit | More enemies than friends");
    }

    public static func HalCantos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hal_cantos").SetClassification("TECHIE - BD TUNER")
            .SetBackground("Freelance braindance tuner, considered a 'known quantity' in Watson. Former WNS news employee until he was terminated for fraud. Now does street gigs exclusively, tuning and editing braindances for various clients.")
            .SetEarlyLife("Worked for WNS news as BD technician. Got caught committing fraud and was fired. Transitioned to street-level BD work.")
            .SetAffiliation("Independent | Former WNS News")
            .SetCriminalRecord("FRAUD | Terminated from WNS | Various street-level offenses")
            .SetNotes("Skilled technician | Morally flexible | Works for whoever pays")
            .SetThreatAssessment("NONE | Non-combatant | Technical skills only | Value in BD expertise");
    }

    public static func BlakeCroyle() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("blake_croyle").SetClassification("CRIMINAL - LOAN SHARK")
            .SetBackground("Racketeering specialist operating in Kabuki. Uses debt schemes to trap victims - offers promising money deals, creates unpayable debts, then seizes ownership of their businesses. Currently has Animals muscle watching his back.")
            .SetEarlyLife("Built criminal enterprise on predatory lending and racketeering. NCPD badges in the area turn blind eye because of payoffs.")
            .SetAffiliation("Animals (Protection)")
            .SetCriminalRecord("RACKETEERING | Fraud | Extortion | Property seizure | Protected by corrupt NCPD")
            .SetRelationships("Roger Wang (Recent victim - store chain owner)")
            .SetNotes("Predatory | Calculated | No empathy for victims | Patient manipulator")
            .SetFinancialStatus("Wealthy | Income from seized businesses | Pays for Animals protection")
            .SetThreatAssessment("HIGH via Animals | Personal combat ability unknown | Has muscle on site");
    }

    public static func JaeHyunLee() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jae_hyun_lee").SetClassification("CRIMINAL - HUMAN TRAFFICKER")
            .SetBackground("Jae-Hyun Lee (이재현). Human trafficker who preys on Night City's most vulnerable - outcasts, loners, rejects, people society has failed. Identifies targets, kidnaps them, delivers them to Scavengers for cyberware removal. Victims are stripped of their identities and sold as 'property'.")
            .SetEarlyLife("Unknown origins. Built network for acquiring and trafficking vulnerable people. Works with Scavengers and XBD producers like Jotaro Shobo.")
            .SetCriminalRecord("HUMAN TRAFFICKING | Kidnapping | Conspiracy | Works with Scavengers | Supplies victims to Jotaro Shobo")
            .SetRelationships("Jotaro Shobo (Client - receives 'product')")
            .SetNotes("Predatory | Targets society's forgotten | Views humans as merchandise | No empathy")
            .SetThreatAssessment("MODERATE | Not a fighter | Has guards | Operates from Kabuki rooftops");
    }

    public static func LucyThackery() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lucy_thackery").SetClassification("RIPPERDOC - LEGITIMATE")
            .SetBackground("Licensed ripperdoc operating from Clean Cut clinic. Since childhood, dreamed of saving people's lives. Put herself through extensive training in anatomy, microanatomy, biochemistry, physiology and robotics. Installed long-term memory enhancement, hand stabilizer, and medical antibodies.")
            .SetEarlyLife("Held onto dream of becoming ripperdoc since childhood. Hundreds of hours of study. Brother Bertie got mixed up with Maelstrom.")
            .SetCriminalRecord("CLEAN | Licensed medical professional")
            .SetRelationships("Bertie Thackery (Brother - former Maelstrom associate)")
            .SetMedicalStatus("Self-installed medical cyberware for profession | Long-term memory | Hand stabilizer | Medical antibodies")
            .SetNotes("Compassionate | Dedicated to helping people | Worried about brother | Professional")
            .SetThreatAssessment("NONE | Medical professional | Non-combatant | Value in ripperdoc skills");
    }

    public static func JotaroShobo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jotaro_shobo").SetClassification("TYGER CLAWS - HIGH RANKING")
            .SetBackground("Jotaro Shobo (正法承太郎). High-ranking Tyger Claws member, owner of Ho-Oh club in Kabuki. Known as 'The Devil of Kabuki' for his side business - producing the most violent XBDs imaginable. At least seventeen confirmed murders, mostly joytoys who disappeared without anyone looking for them.")
            .SetEarlyLife("Rose quickly through Tyger Claws through intelligence, loyalty and ruthlessness. Rules lackeys with iron fist. Never late with cuts to bosses. Gang provides protection and turns blind eye to his 'hobbies'.")
            .SetAffiliation("Tyger Claws (High Ranking)")
            .SetCriminalRecord("SERIAL KILLER | 17+ murders | XBD snuff production | Human trafficking | Torture | Protected by Tyger Claws")
            .SetRelationships("Jae-Hyun Lee (Supplier - provides victims)")
            .SetNotes("Sadistic | Gets off on suffering | Coldly efficient in gang business | The Mox consider him their primary enemy")
            .SetFinancialStatus("Wealthy | Ho-Oh club income | XBD production profits")
            .SetThreatAssessment("HIGH | Tyger Claws protection | Armed guards | Ho-Oh club is fortified | Casino second floor");
    }

    public static func TakiKenmochi() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("taki_kenmochi").SetClassification("TYGER CLAWS - OPERATOR")
            .SetBackground("Tyger Claws gang member who runs a pachinko operation in Kabuki. Small operation but strategically placed. Red hair, blue and pink jacket, white shoes - easy to identify.")
            .SetAffiliation("Tyger Claws")
            .SetCriminalRecord("ILLEGAL GAMBLING | Tyger Claws operations | Pachinko racket")
            .SetNotes("Gang loyal | Runs tight operation | Not leadership material")
            .SetThreatAssessment("MODERATE | Tyger Claws training | Armed | Gang backup possible");
    }

    public static func MikhailAkulov() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mikhail_akulov").SetClassification("FIXER - SOVIET UNION")
            .SetBackground("Mikhail Sergeievich Akulov (Михаил Сергеевич Акулов). The top fixer in the Soviet Union. Traveled to Night City in 2077 ostensibly on a diplomatic business trip. His presence has generated enormous buzz - a premier Soviet fixer personally handling business in Night City raises questions.")
            .SetEarlyLife("Rose to fame as USSR's most connected fixer. Has network spanning Soviet territories. First time operating on American soil.")
            .SetAffiliation("Soviet Union (Government connected)")
            .SetCriminalRecord("CLASSIFIED | Soviet intelligence connections | Diplomatic immunity claims")
            .SetRelationships("Nadezhda Tiurina (Bodyguard/companion) | Shelma (Netrunner - status unknown)")
            .SetFinancialStatus("Extremely wealthy | Soviet government backing | Staying at Hotel Raito penthouse")
            .SetNotes("Calculating | Professional | Accustomed to power | May be seduced by Night City's freedom and capitalism")
            .SetThreatAssessment("HIGH | Heavy Soviet security | Diplomatic complications | Professional bodyguards | Hotel Raito penthouse");
    }

    public static func AnnaHamill() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anna_hamill").SetClassification("NCPD - PATROL OFFICER")
            .SetBackground("Blue-blooded cop, through and through. The kind you'd expect in an NCPD recruitment promo - beautiful, smart, honest to a fault. In other words, a really bad fit for Night City. One of the few genuinely good cops trying to make a difference.")
            .SetEarlyLife("Joined NCPD with genuine desire to serve and protect. Refused bribes and kickbacks that her colleagues accepted freely. Became known for being against any form of injustice.")
            .SetAffiliation("NCPD (Active but isolated)")
            .SetCriminalRecord("CLEAN | Model officer | No corruption")
            .SetNotes("Idealistic | Quick tempered | Impulsive | Persistent despite hostility | Doesn't know when to quit")
            .SetFinancialStatus("Modest | Lives on NCPD salary | Renting apartment above Kabuki Market for undercover work")
            .SetThreatAssessment("MODERATE | NCPD training | Armed | But making powerful enemies among her own colleagues");
    }

    // === WESTBROOK / JAPANTOWN NOTABLES ===
    public static func BeatriceEllenTrieste() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("beatrice_ellen_trieste").SetClassification("NETRUNNER - FREELANCE")
            .SetBackground("Beatrice Ellen Trieste, better known by her handle '8ug8ear'. Skilled netrunner living in Japantown. Associate of Wakako Okada and has worked with Tyger Claws on various jobs. Published opinion piece critiquing the after-effects of the DataKrash brought about by Rache Bartmoss.")
            .SetEarlyLife("Developed netrunning skills over years. Built reputation in Japantown as reliable technical specialist. Academic interest in Net history and the DataKrash.")
            .SetAffiliation("Wakako Okada (Associate) | Tyger Claws (Contract work)")
            .SetCriminalRecord("NETRUNNING | Corporate system intrusion | Data theft | Works with gang elements")
            .SetNotes("Technically skilled | Opportunistic | Self-preserving | Academic interest in Net history")
            .SetCyberwareStatus("Full netrunning suite | Neural interface | Ice breakers")
            .SetThreatAssessment("HIGH via Net | Physical threat minimal | Dangerous in cyberspace");
    }

    public static func SergeiKarasinsky() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sergei_karasinsky").SetClassification("SOLO - INDEPENDENT")
            .SetBackground("Russian solo operating in Night City. Has a reputation for acting before thinking - a characteristic that has landed him in trouble more than once. Known to panic when things go wrong, which makes him willing to pay well for help.")
            .SetEarlyLife("Background in solo work. Has history with Tyger Claws that has not always been smooth. Currently on their bad side.")
            .SetAffiliation("Independent | Tyger Claws (Strained relationship)")
            .SetCriminalRecord("ASSAULT | Kidnapping | Various solo work | Currently trying to make amends with Tyger Claws")
            .SetNotes("Impulsive | Acts before thinking | Panics under pressure | Desperate | Willing to pay for solutions")
            .SetFinancialStatus("Moderate | Pays well when panicked | Money 'flying out of his account'")
            .SetThreatAssessment("MODERATE | Solo skills | But judgment problems make him dangerous to be around");
    }

    public static func ChangHoonNam() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("chang_hoon_nam").SetClassification("NETRUNNER - PROFESSIONAL")
            .SetBackground("Chang-Hoon Nam (남창훈). 65-year-old veteran netrunner, hand-picked by Wakako Okada years ago. Hasn't let her down once. Known for being dependable and knowing exactly what's expected of him. Operates from basement hideout beneath restaurant in Japantown.")
            .SetEarlyLife("Decades of netrunning experience. Built reputation as reliable, methodical operator. Sees himself as bundle of contradictions - ambition vs aloofness, desire to help vs self-preservation, hunger for knowledge vs wanting peace.")
            .SetAffiliation("Wakako Okada (Primary client)")
            .SetCriminalRecord("NETRUNNING | Corporate intrusion | Data extraction | Long career with no major incidents")
            .SetRelationships("Wakako Okada (Employer - hand-picked associate) | Spectral Kid (Mentored - deceased) | Dante (Acquaintance - trapped in Net)")
            .SetNotes("Dependable | Methodical | Sentimental | Effective but tame | Likes knowing what's expected | Will take calculated risks")
            .SetCyberwareStatus("Professional netrunning suite | Decades of optimization | Code and daemons match his personality - effective but tame")
            .SetThreatAssessment("HIGH via Net | Physical threat minimal | Experienced and careful");
    }

    public static func LaurenCostigan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lauren_costigan").SetClassification("CIVILIAN - NON-COMBATANT")
            .SetBackground("Wife of Bradley Costigan. Ordinary civilian caught up in her husband's past. Bradley is currently incarcerated and his old associations have put Lauren in a difficult position through no fault of her own.")
            .SetEarlyLife("Married Bradley Costigan. Lived normal civilian life until husband's imprisonment brought unwanted attention from his former associates.")
            .SetCriminalRecord("CLEAN | No criminal record | Victim of circumstance")
            .SetRelationships("Bradley Costigan (Husband - imprisoned)")
            .SetNotes("Innocent civilian | Traumatized by circumstances | Resilient | Has family support network")
            .SetThreatAssessment("NONE | Non-combatant | No combat training | Vulnerable");
    }

    // ═══════════════════════════════════════════════════════════
    // PHANTOM LIBERTY - GIG NPCs
    // ═══════════════════════════════════════════════════════════

    // --- DOGTOWN SAINTS ---

    public static func NikaYankovich() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nika_yankovich").SetClassification("SCAVENGER - DOGTOWN CELL")
            .SetBackground("Nika Yankovich. Twin sister of Gaspar Yankovich. Scavenger operating in Dogtown. Unusual among her crew — held in high regard because she actually cares about something beyond chrome and eddies. Family.")
            .SetEarlyLife("Raised alongside twin brother Gaspar. Despite being born minutes apart, always assumed the role of protective older sister. When Gaspar developed an addiction to immunosuppressants, Nika blamed herself. Before she could force him into rehab, he vanished in Dogtown.")
            .SetAffiliation("Scavengers - Dogtown")
            .SetCriminalRecord("SCAVENGER OPERATIONS | Organ/implant harvesting | Breaking and entering | Armed intimidation | Hostage situation at Haven Clinic, Montaña de Oro Ave")
            .SetRelationships("Gaspar Yankovich (Twin brother - missing) | Tim Brent (Associate - dealer, owes Gaspar eddies) | Scavenger crew (Loyal)")
            .SetNotes("Fiercely protective of family | Emotional | Dangerous when desperate | Last known lead on Gaspar pointed to Haven Clinic")
            .SetThreatAssessment("MODERATE-HIGH | Armed and volatile | Will escalate when cornered | Scav backup nearby");
    }

    public static func OdellBlanco() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("odell_blanco").SetClassification("CIVILIAN - CLERGY")
            .SetBackground("Father Odell Blanco. Pastor operating out of Haven Clinic, an abandoned church on Montaña de Oro Ave in Dogtown. Partners with a local ripperdoc to provide medical care and used implants to those who can't afford Trauma Team — which in Dogtown means everyone.")
            .SetEarlyLife("Called to service in one of Night City's most godless districts. Survives on donations and goodwill. Built Haven Clinic into a lifeline for Longshore Stacks residents who have nowhere else to turn.")
            .SetCriminalRecord("CLEAN | No criminal record")
            .SetRelationships("Anthony Anderson (Partner - ripperdoc at Haven Clinic) | Father Graeff (Correspondence - clergy contact) | Haven Clinic patients (Congregation)")
            .SetNotes("Genuinely altruistic | Pragmatic faith | Refuses to abandon Dogtown | Will call in outside help when overwhelmed")
            .SetThreatAssessment("NONE | Non-combatant | Unarmed | High community value");
    }

    public static func AnthonyAndersonRipper() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anthony_anderson").SetClassification("RIPPERDOC - UNLICENSED")
            .SetBackground("Dr. Anthony Anderson. Ripperdoc operating out of Haven Clinic, a converted church in Dogtown's Longshore Stacks. Known for providing used implants and medical care to residents who can't pay. One of Dogtown's few genuinely charitable figures — though even saints have secrets in this district.")
            .SetEarlyLife("Medical background. Chose to set up practice in Dogtown rather than pursue corporate clients. Partnered with Father Odell Blanco to establish Haven Clinic as a community resource.")
            .SetAffiliation("Haven Clinic - Longshore Stacks")
            .SetCriminalRecord("UNLICENSED MEDICAL PRACTICE | Unregistered implant installation | Use of salvaged/secondhand cyberware | Possible medical ethics violations — details classified")
            .SetRelationships("Odell Blanco (Partner - clergy) | Tara Anderson (Wife) | Haven Clinic patients (Dependents)")
            .SetCyberwareStatus("Standard ripperdoc toolkit | Diagnostic optics | Surgical suite in clinic basement")
            .SetNotes("Outwardly selfless | Morally complex | Barricades when threatened | Patients depend on his survival")
            .SetThreatAssessment("LOW | Non-combatant | Medical professional | High community value — loss would devastate local healthcare");
    }

    // --- PROTOTYPE IN THE SCRAPER ---

    public static func HasanDemir() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hasan_demir").SetClassification("ZETATECH - TECHIE (AWOL)")
            .SetBackground("Hasan Demir. Former Zetatech engineer specializing in prototype ocular systems. Clever and convincing, capable of bold moves — but consistently underestimates how his audacity drives him toward perilous situations. Currently AWOL from Zetatech with corporate property in his possession.")
            .SetEarlyLife("Dedicated his career to Zetatech. Years of service left him feeling undercompensated for his contributions. Resentment built until he decided to take what he felt he was owed.")
            .SetAffiliation("Zetatech (Former — deserted)")
            .SetCriminalRecord("CORPORATE THEFT | Unauthorized removal of prototype hardware | Breach of Zetatech employment contract | Misappropriation of proprietary technology")
            .SetCyberwareStatus("PROTOTYPE ZETATECH OCULAR IMPLANT — self-installed | Experimental tech of immense value | Industry analysts suggest potential to rival Kiroshi Optics product line")
            .SetRelationships("Zetatech (Former employer — actively searching for him) | Mr. Hands (Fixer — contract involvement)")
            .SetNotes("Intelligent but reckless | Talks his way out of corners | Self-installed experimental chrome — either brilliant or suicidal | Scavengers took interest in his prototype")
            .SetThreatAssessment("LOW-MODERATE | Non-combatant | High-value target to multiple parties | Prototype makes him a walking payday");
    }

    // --- WAITING FOR DODGER ---

    public static func BillMitchel() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bill_mitchel").SetClassification("NCPD - OFFICER")
            .SetBackground("Officer Bill Mitchel. NCPD. The epitome of mediocrity. Mediocre dreams, mediocre needs, and an overall mediocre life. His attempts to break out of this pattern are plain to see. Husband of Stella Ramos.")
            .SetEarlyLife("Joined NCPD because a friend suggested it. Never learned how to say no. Career defined by going along with whatever path of least resistance presented itself.")
            .SetAffiliation("NCPD")
            .SetCriminalRecord("OFFICER FILE | Internal affairs: PENDING REVIEW | Possible connections to BARGHEST drug operations in Coastview — investigation ongoing")
            .SetRelationships("Stella Ramos (Wife) | Charles Wilson (Partner - NCPD) | Carl 'Dodger' Robinson (BARGHEST — adversarial)")
            .SetNotes("Risk-averse | People-pleaser | Terrible liar | Aspires to something more but lacks the spine | Dreams of opening a food stand")
            .SetThreatAssessment("LOW | Standard NCPD sidearm | Unlikely to initiate combat | Will follow stronger personalities");
    }

    public static func CharlesWilson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("charles_wilson").SetClassification("NCPD - OFFICER")
            .SetBackground("Officer Charles Wilson. NCPD. Partner of Bill Mitchel. Currently assigned to Dogtown-adjacent operations. The more competent half of the Mitchel-Wilson unit, though that's a low bar.")
            .SetEarlyLife("NCPD career officer. Paired with Bill Mitchel. More capable than his partner but dragged into the same compromising situations.")
            .SetAffiliation("NCPD")
            .SetCriminalRecord("OFFICER FILE | Internal affairs: PENDING REVIEW | Linked to same BARGHEST entanglement as partner Mitchel")
            .SetRelationships("Bill Mitchel (Partner - NCPD) | Stella Ramos (Friend - Bill's wife) | Carl 'Dodger' Robinson (BARGHEST — adversarial)")
            .SetNotes("More competent than Mitchel | Pragmatic | Better under pressure | Still managed to end up in the same mess")
            .SetThreatAssessment("LOW | Standard NCPD equipment | Marginally more effective than partner");
    }

    public static func CarlRobinson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("carl_robinson").SetClassification("BARGHEST - LIEUTENANT")
            .SetBackground("Carl 'Dodger' Robinson. High-ranking BARGHEST operator. If you want to escape your past, you go to Night City. If the past catches up, you flee to the Badlands. If several pasts all want you dead — you hop to Dogtown and pray Hansen likes you. Dodger's prayers were answered.")
            .SetEarlyLife("Multiple criminal histories across jurisdictions. Fled to Dogtown after burning bridges with NCPD, Tyger Claws, and nomad clans simultaneously. Hansen saw value in his skills and took him in.")
            .SetAffiliation("BARGHEST")
            .SetCriminalRecord("THREE LIFE SENTENCES (NCPD — outstanding) | Grave insult to prominent Tyger Claws boss | Robbery of nomad clan — several million eddies | Drug manufacturing and distribution in Coastview")
            .SetRelationships("Kurt Hansen (Commander — patron) | BARGHEST soldiers (Subordinates) | NCPD, Tyger Claws, Nomads (Enemies — all actively hostile)")
            .SetCyberwareStatus("Combat-grade BARGHEST implants | Reflexes tuned for close-quarters | Armed and chrome-heavy")
            .SetNotes("Ruthless | Entertained by audacity | Runs drug ops from converted NCPD precinct | Three separate factions want him dead | Carries iconic Rosco revolver")
            .SetThreatAssessment("HIGH | Armed combatant | BARGHEST backup on-site | Multiple bodyguards | Do not underestimate");
    }

    // --- THE MAN WHO KILLED JASON FOREMAN ---

    public static func BrianaDolson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("briana_dolson").SetClassification("CIVILIAN - COMMUNITY LEADER")
            .SetBackground("Briana Dolson. Longshore Stacks' unofficial representative. Organizes community vigils and acts as the voice of residents who have no one else to speak for them. Currently seeking justice for eight civilians killed in a massacre by a former BARGHEST triggerman.")
            .SetEarlyLife("Rose to prominence in Longshore Stacks through sheer force of will. When nobody else stepped up, Briana did. Became the person the community turns to when Dogtown's violence hits home.")
            .SetCriminalRecord("CLEAN | No criminal record | Contracted mercenary services through Mr. Hands for community protection")
            .SetRelationships("Longshore Stacks community (Dependents) | Mr. Hands (Fixer — hired merc on her behalf) | Jason Foreman (Victim — community member, murdered)")
            .SetNotes("Strong-willed | Expects results | Protective of her community | Will not forgive easily | Meets only during evening vigils (22:00-06:00)")
            .SetThreatAssessment("NONE | Non-combatant | Political influence within Longshore Stacks");
    }

    // --- SPY IN THE JUNGLE ---

    public static func StevenSantos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("steven_santos").SetClassification("BIA - RISK ASSESSMENT SPECIALIST")
            .SetBackground("Steven Santos. Brazilian Intelligence Agency. Risk assessment specialist. A patriot willing to sacrifice much for his country — perhaps not his life, but at the very least his self-respect. Knows when a mission is in jeopardy, and when to look the other way and keep things under wraps.")
            .SetEarlyLife("Rose through BIA ranks as a dependable, if morally flexible, operative. The kind of man who says 'if I don't do it, someone else will' and 'that's just how the system works.' When his conscience gets too murky, he makes an effort to clean it up. Just not too clean.")
            .SetAffiliation("Brazilian Intelligence Agency")
            .SetCriminalRecord("CLASSIFIED | BIA operative | Operating in Dogtown without official agency authorization")
            .SetRelationships("Ana Friedman (Partner - BIA) | Mark Bana (Mentor/colleague - status unknown) | Mr. Hands (Fixer — contracted V)")
            .SetNotes("Pragmatic to a fault | Prioritizes survival over justice | Will undercut his own partner to protect himself | Currently operating off-books in Dogtown")
            .SetThreatAssessment("MODERATE | Intelligence training | Armed | Not a frontline combatant | Dangerous through information rather than firepower");
    }

    public static func AnaFriedman() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ana_friedman").SetClassification("BIA - FIELD AGENT")
            .SetBackground("Ana Friedman. Brazilian Intelligence Agency. Field operative partnered with Steven Santos. Currently in Dogtown investigating the reactivation of a colleague's biomonitor signal. Operating without official BIA authorization due to the political sensitivity of the situation.")
            .SetEarlyLife("BIA career agent. Trained under Mark Bana. More idealistic than her partner Santos — believes in doing the right thing even when the system would prefer she didn't.")
            .SetAffiliation("Brazilian Intelligence Agency")
            .SetCriminalRecord("CLASSIFIED | BIA operative | Unauthorized field operation in sovereign Dogtown territory")
            .SetRelationships("Steven Santos (Partner - BIA) | Mark Bana (Mentor - biomonitor signal reactivated) | Mr. Hands (Fixer — contracted V)")
            .SetNotes("Idealistic | Driven by loyalty to fallen colleagues | Will push for truth regardless of cost | Tensions with partner over how far to go")
            .SetThreatAssessment("MODERATE | Intelligence training | Armed | More willing to take risks than Santos");
    }

    public static func BorisRibakov() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("boris_ribakov").SetClassification("SOVOIL - ELITE OPERATIVE")
            .SetBackground("Boris Ribakov. SovOil corporate black-ops. Elite soldier deployed to Night City on a termination contract. Operates with military precision, advanced stealth technology, and zero regard for collateral damage. Currently embedded in Organitopia, Terra Cognita.")
            .SetEarlyLife("SovOil military pipeline. Trained as tier-one corporate operative. Specializes in high-value target elimination in hostile environments. Scavenger crews in the area answer to him by intimidation.")
            .SetAffiliation("SovOil")
            .SetCriminalRecord("CLASSIFIED — SOVOIL CORPORATE DENIABLE | Contract assassinations | Multiple unauthorized military operations on foreign soil")
            .SetCyberwareStatus("MILITARY-GRADE | Optical camouflage | Sandevistan acceleration | Charge-jump locomotion | Militech Griffin drone deployment system | Holographic decoy projectors")
            .SetRelationships("SovOil (Handler — corporate command) | Scavenger crews (Subordinates — intimidated into compliance)")
            .SetNotes("Apex predator | Uses sniper rifle from elevated positions, switches to Smart SMG at close range | Deploys smoke grenades + flashbangs | Will retreat and re-engage | Carries iconic Pizdets SMG")
            .SetThreatAssessment("EXTREME | Tier-one combatant | Stealth + heavy firepower | Drone support | Do NOT engage without preparation");
    }

    public static func KatyaKarelina() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("katya_karelina").SetClassification("SOVOIL - FORMER INTERROGATOR")
            .SetBackground("Katya Karelina. Former SovOil interrogation specialist. Once part of the corporate machine, now marked for termination by her own employers. Hiding in Organitopia's abandoned museum complex in Terra Cognita. Desperate, resourceful, and willing to trade anything for survival.")
            .SetEarlyLife("SovOil career operative specializing in information extraction. Participated in interrogations that 'never happened.' When the corporation decided to clean house, she found herself on the wrong side of the ledger.")
            .SetAffiliation("SovOil (Former — terminated)")
            .SetCriminalRecord("CLASSIFIED — SOVOIL DENIABLE | Enhanced interrogation | Involvement in deaths of foreign intelligence personnel | Identity fraud | Signal spoofing using stolen biomonitor")
            .SetRelationships("SovOil (Former employer — actively hunting her) | Boris Ribakov (Assassin — sent to eliminate her) | Olya Sergeeva (Contact)")
            .SetNotes("Master of deception | Will impersonate others to survive | Knows SovOil secrets worth killing for | Offers stash coordinates as bargaining chip")
            .SetThreatAssessment("LOW-MODERATE | Not a frontline combatant | Dangerous through manipulation and information | Valuable intelligence asset");
    }

    // --- TALENT ACADEMY ---

    public static func Baird() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("baird").SetClassification("NETRUNNER - FREELANCE")
            .SetBackground("Baird. Freelance netrunner on retainer with Mr. Hands. Specializes in identity fabrication and digital cover stories. Provides operational support for high-profile infiltration gigs throughout Dogtown.")
            .SetEarlyLife("Career netrunner. Built reputation as reliable support for fixer operations. Doesn't ask too many questions about the jobs — just makes sure the fake IDs hold up long enough.")
            .SetAffiliation("Mr. Hands (Retainer)")
            .SetCriminalRecord("NETRUNNING | Identity fraud | Digital forgery | Corporate systems intrusion")
            .SetCyberwareStatus("Full netrunning suite | Optimized for rapid identity fabrication and systems spoofing")
            .SetNotes("Professional | Methodical briefer | Doesn't elaborate beyond what's needed | Creates covers good enough to pass biometric scans")
            .SetThreatAssessment("MODERATE via Net | Minimal physical threat | Support operative, not frontline");
    }

    public static func TommieWalker() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tommie_walker").SetClassification("CIVILIAN - MINOR")
            .SetBackground("Tommie Walker. Young athlete enrolled at the Center for Neuromotor Development in Dogtown. Son of David Walker, clothing vendor at EBM Petrochem Stadium. One of many Dogtown kids betting everything on a chance to get signed by an off-world sports team and escape the district.")
            .SetEarlyLife("Grew up in Dogtown. Father runs a clothing stall at the stadium. Enrolled in Dr. Fiona Vargas' academy — the only shot most Dogtown kids have at leaving. The stakes couldn't be higher: get signed or come out with nothing but cyberware debt.")
            .SetCriminalRecord("CLEAN | Minor | No criminal record")
            .SetRelationships("David Walker (Father - stadium vendor) | Fiona Vargas (Academy director) | Fellow academy athletes (Peers)")
            .SetNotes("Resourceful | Curious | Found places he shouldn't be | The system he's in chews up more kids than it launches")
            .SetThreatAssessment("NONE | Minor | Non-combatant | Protected status");
    }

    public static func FionaVargas() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("fiona_vargas").SetClassification("CORPORATE - MEDICAL DIRECTOR")
            .SetBackground("Dr. Fiona Vargas. Head of the Center for Neuromotor Development, Site 341. Extremely talented ripperdoc specializing in cybernetic implants for young athletes. Operates in Dogtown to avoid taxes, regulations, and oversight. Her office walls are covered in medals, trophies, and awards won by the athletes she helped mould.")
            .SetEarlyLife("Became a respected ripper in the community quickly. Faced a choice — stay at the hospital and treat patients, or start cybermodifying athletes. Help people, or make money. The trophies on her wall tell you which she chose.")
            .SetAffiliation("Center for Neuromotor Development - Site 341")
            .SetCriminalRecord("TAX EVASION | Unregulated medical procedures on minors | Operating outside NUSA medical oversight | Scout contract fraud — under investigation by Mr. Hands' client")
            .SetFinancialStatus("WEALTHY | International scout contracts | Sizeable transfer fees | All untaxed")
            .SetRelationships("Academy athletes (Subjects) | International sports scouts (Clients) | Mr. Hands (Fixer — contract against her operations)")
            .SetNotes("Talented and cynical in equal measure | Will negotiate when cornered | Exploits Dogtown kids' desperation for profit | Those who don't get signed are left with cyberware debt their families can't cover")
            .SetThreatAssessment("LOW direct | HIGH indirect | Armed security staff on premises | Will send mercs after threats to her operation");
    }

    // --- HEAVIEST OF HEARTS ---

    public static func MichaelMaldonado() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("michael_maldonado").SetClassification("CIVILIAN - BUSINESS OWNER")
            .SetBackground("Michael Maldonado. Small business owner operating beneath The Needle in central Dogtown. A man blessed with two things that go together many a time — a son and trouble. Those who possess very little are the most afraid to lose whatever they love.")
            .SetEarlyLife("Built a small business in Dogtown. Raised son Eric in the district. The kind of man who never leaves his shop — not because business is good, but because the world outside keeps getting worse.")
            .SetAffiliation("Independent")
            .SetCriminalRecord("WITNESS TESTIMONY | Testified against own son Eric Maldonado | Claims testimony was coerced | Details disputed by District Attorney's office")
            .SetRelationships("Eric Maldonado (Son - Valentinos member, incarcerated) | Georgina Zembinsky (D.A. — adversarial) | Hank Davis (D.A.'s partner — adversarial) | Mr. Hands (Fixer — hired V)")
            .SetNotes("Desperate father | Claims he was tortured into giving false testimony | Story doesn't fully add up | Willing to pay well for someone with very little")
            .SetThreatAssessment("NONE | Non-combatant | Civilian | Financially motivated");
    }

    public static func GeorginaZembinsky() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("georgina_zembinsky").SetClassification("DISTRICT ATTORNEY - DOGTOWN")
            .SetBackground("Georgina Zembinsky. District Attorney operating out of the Heavy Hearts club in Dogtown. Pursuing a high-profile case involving Valentinos gang activity. Works alongside partner Hank Davis. Frequents the VIP section of Heavy Hearts — one of the few places in Dogtown where the law still pretends to function.")
            .SetEarlyLife("Legal career built in Dogtown's impossible jurisdiction. Learned that justice in this district requires methods the NUSA bar association wouldn't approve of. Has been chasing a serial murderer connected to the Valentinos for two years.")
            .SetAffiliation("Dogtown District Attorney's Office")
            .SetCriminalRecord("NONE ON RECORD | Accusations of coerced testimony — unproven | Allegations of enhanced interrogation techniques — denied | Uses Valentinos informants to build cases")
            .SetRelationships("Hank Davis (Partner/bodyguard) | Michael Maldonado (Witness — adversarial) | Eric Maldonado (Defendant — Valentinos) | Hector Sacristán (Target — high-ranking Valentinos, alleged serial murderer) | Judge Nathaniel Edwards (Correspondence)")
            .SetNotes("Ruthless prosecutor | Believes the ends justify the means | Has video testimony evidence on secure terminal | Willing to negotiate when outmatched | Hank Davis provides physical security")
            .SetThreatAssessment("LOW direct | Hank Davis serves as armed protection | VIP section of Heavy Hearts has additional security | Political connections make her dangerous to cross");
    }

    // --- ROADS TO REDEMPTION ---

    public static func NeleSpringer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nele_springer").SetClassification("CRIMSON HARVEST - DEFECTOR")
            .SetBackground("Nele Springer. Former member of the Crimson Harvest terrorist organization since 2074. Recently indicated desire to leave the group and prevent further attacks. A brilliant chemist carrying the weight of blood she didn't intend to spill.")
            .SetEarlyLife("Grew up on her family's corn farm in Indiana with four siblings. When the farm went bankrupt and her parents were forced to sell their land to Biotechnica, Springer moved to Night City. A compensation payout for children of relocated farmers funded her chemistry degree. The university proved to be a breeding ground for revolutionary recruiters — when Crimson Harvest offered, she didn't hesitate.")
            .SetAffiliation("Crimson Harvest (Defecting)")
            .SetCriminalRecord("TERRORISM | Crimson Harvest membership since 2074 | Involvement in anti-Biotechnica sabotage operations | Connected to civilian casualties — extent of direct involvement disputed | WANTED by Biotechnica corporate security")
            .SetMedicalStatus("Psychological: Guilt-driven | Tormented by the belief her education was bought with her parents' suffering | Never stopped feeling like a stranger in Night City")
            .SetRelationships("Crimson Harvest (Former cell — defecting) | Biotechnica (Primary target — also hunting her) | Mr. Hands (Fixer — contracted V to assist) | Four siblings (Family — Indiana)")
            .SetNotes("Brilliant chemist | True believer turned disillusioned | Sabotaging Biotechnica felt like alleviating her family's pain — until reality caught up | Biotechnica agents actively pursuing her in Dogtown")
            .SetThreatAssessment("MODERATE | Chemistry expertise makes her dangerous in theory | Not a direct combatant | Multiple hostile parties tracking her location");
    }
}
