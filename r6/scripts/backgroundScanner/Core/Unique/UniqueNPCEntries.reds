// Kiroshi Deep Scan Protocol - Unique NPC Entries

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
    public static func IsBothSidesNowDone() -> Bool { return KdspQuestProgressHelper.IsFactSet(n"q110_done"); }
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
        if StrContains(id, "bodyguard_dex") { return KdspUniqueNPCEntries.Oleg(); }
        if (StrContains(id, "dex") && !StrContains(id, "index") && !StrContains(id, "dext") && !StrContains(id, "codex") && !StrContains(id, "latex") && !StrContains(id, "bodyguard")) || StrContains(id, "deshawn") { return KdspUniqueNPCEntries.DexterDeShawn(id); }
        if StrContains(id, "wakako") { return KdspUniqueNPCEntries.WakakoOkada(); }
        if StrContains(id, "regina") && StrContains(id, "jones") { return KdspUniqueNPCEntries.ReginaJones(); }
        if StrContains(id, "padre") && !StrContains(id, "compadre") { return KdspUniqueNPCEntries.Padre(); }
        if StrContains(id, "dakota") { return KdspUniqueNPCEntries.DakotaSmith(); }
        if StrContains(id, "dino") && !StrContains(id, "dinosaur") && (StrContains(id, "dinovic") || StrContains(id, "fixer")) { return KdspUniqueNPCEntries.DinoDinovic(); }
        if StrContains(id, "hands") && (StrContains(id, "mr") || StrContains(id, "mister") || StrContains(id, "fixer")) && !StrContains(id, "handsome") && !StrContains(id, "handshake") { return KdspUniqueNPCEntries.MrHands(); }
        if (StrContains(id, "muamar") || StrContains(id, "capitan")) && StrContains(id, "driver") { return KdspUniqueNPCEntries.Mickey(); }
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
        if StrContains(id, "nina_kraviz") || (StrContains(id, "wbr_hil_ripdoc") && !StrContains(id, "uncle")) { return KdspUniqueNPCEntries.NinaKraviz(); }
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
        if StrContains(id, "mq040_wife") || (StrContains(id, "cynthia") && StrContains(id, "najarro")) { return KdspUniqueNPCEntries.CynthiaNajarro(); }
        if StrContains(id, "elcoyote_barman") || StrContains(id, "pepe_najarro") || (StrContains(id, "pepe") && StrContains(id, "najarro")) { return KdspUniqueNPCEntries.PepeNajarro(); }
        if StrContains(id, "mq040_ripperdoc") || StrContains(id, "mq040__black_market_ripperdoc") { return KdspUniqueNPCEntries.ShadyRipperdocMQ040(); }
        if StrContains(id, "mq014_master") || StrContains(id, "zen_master") { return KdspUniqueNPCEntries.ZenMaster(); }
        if StrContains(id, "mq025_twin_01") { return KdspUniqueNPCEntries.CertoEsquerdo(); }
        if StrContains(id, "mq025_twin_02") { return KdspUniqueNPCEntries.EsquerdoCerto(); }
        if StrContains(id, "corpo_friend") || (StrContains(id, "q000") && StrContains(id, "frank")) { return KdspUniqueNPCEntries.FrankNostra(); }
        if StrContains(id, "elcoyote_barman") || (StrContains(id, "pepe") && StrContains(id, "najarro")) { return KdspUniqueNPCEntries.PepeNajarro(); }
        // TYGER CLAWS
        if StrContains(id, "jotaro") || StrContains(id, "shobo") { return KdspUniqueNPCEntries.JotaroShobo(); }
        if StrContains(id, "hiromi") && StrContains(id, "sato") { return KdspUniqueNPCEntries.HiromiSato(); }
        // VALENTINOS
        if (StrContains(id, "gustavo") || (StrContains(id, "orta") && StrContains(id, "valentino"))) && !StrContains(id, "escort") && !StrContains(id, "transport") && !StrContains(id, "porta") && !StrContains(id, "morta") && !StrContains(id, "corta") && !StrContains(id, "forta") { return KdspUniqueNPCEntries.GustavoOrta(); }
        if StrContains(id, "jose") && StrContains(id, "luis") { return KdspUniqueNPCEntries.JoseLuis(); }
        if StrContains(id, "miguel_rodrigez") || StrContains(id, "mq_hey_rey_06_outpost_miniboss") { return KdspUniqueNPCEntries.MiguelRodriguez(); }
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
        if StrContains(id, "wilson") && !StrContains(id, "charles") && !StrContains(id, "sts_ep1") && (StrContains(id, "default") || StrContains(id, "2nd") || StrContains(id, "second") || StrContains(id, "gun") || StrContains(id, "weapon") || StrContains(id, "amendment")) { return KdspUniqueNPCEntries.Wilson(); }
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
        // PL - BLACK SAPPHIRE PARTY (q303 - You Know My Name)
        if StrContains(id, "paradise_jago") || StrContains(id, "mq304__jago") { return KdspUniqueNPCEntries.JagoSzabo(); }
        if StrContains(id, "paradise_bennett") || StrContains(id, "mq304_bennett") { return KdspUniqueNPCEntries.ChesterBennett(); }
        if StrContains(id, "mq304_jago_bodyguard") { return KdspUniqueNPCEntries.CharlesGraham(); }
        if StrContains(id, "azegami") || StrContains(id, "paradise_tc_leader_01") { return KdspUniqueNPCEntries.JunAzegami(); }
        if (StrContains(id, "ichida") && !StrContains(id, "uchida")) || StrContains(id, "paradise_tc_leader_02") { return KdspUniqueNPCEntries.MarcusIchida(); }
        if StrContains(id, "paradise_ruth") || StrContains(id, "ruth_dzeng") { return KdspUniqueNPCEntries.RuthDzeng(); }
        if StrContains(id, "paradise_reverend") || (StrContains(id, "colver") && StrContains(id, "priest")) { return KdspUniqueNPCEntries.ReverendColver(); }
        if Equals(id, "character.bello") || StrContains(id, "bello_default") { return KdspUniqueNPCEntries.AuroreCassel(); }
        if Equals(id, "character.theo") || StrContains(id, "theo_default") { return KdspUniqueNPCEntries.AymericCassel(); }
        if StrContains(id, "paradise_ziggy") || StrContains(id, "ziggy_q") { return KdspUniqueNPCEntries.ZiggyQ(); }
        if StrContains(id, "paradise_iqbal") || StrContains(id, "arif_iqbal") { return KdspUniqueNPCEntries.ArifIqbal(); }
        if StrContains(id, "paradise_kavorkin") || StrContains(id, "kavorkin") { return KdspUniqueNPCEntries.JoshKavorkin(); }
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
        return KdspUniqueNPCBackstory.Create("hanako_bodyguard").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoBodyguard-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoBodyguard-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoBodyguard-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoBodyguard-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoBodyguard-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoBodyguard-Notes"));
    }

    public static func ArasakaBodyguard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("arasaka_bodyguard").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ArasakaBodyguard-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ArasakaBodyguard-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ArasakaBodyguard-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ArasakaBodyguard-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ArasakaBodyguard-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ArasakaBodyguard-Notes"));
    }

    // === TAKEMURA (DYNAMIC) ===
    public static func Takemura() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("takemura").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Background"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-EarlyLife"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-SignificantEvents"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Affiliation"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-CriminalRecord"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-CyberwareStatus"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-FinancialStatus"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-MedicalStatus"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-ThreatAssessment"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Relationships"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("takemura").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Background-1"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-EarlyLife-1"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-SignificantEvents-1"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Affiliation-1"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-CriminalRecord-1"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-CyberwareStatus-1"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-FinancialStatus-1"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-MedicalStatus-1"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-ThreatAssessment-1"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Relationships-1"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Takemura-Notes-1"));
    }

    // === SABURO (DYNAMIC) ===
    public static func SaburoArasaka() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("saburo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Background"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-SignificantEvents"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Affiliation")).SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("saburo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Background-1"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-SignificantEvents-1"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Affiliation-1"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SaburoArasaka-Notes-1"));
    }

    // === YORINOBU (DYNAMIC) ===
    public static func YorinobuArasaka() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("yorinobu").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Background"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-SignificantEvents"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Affiliation"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-ThreatAssessment"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("yorinobu").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Background-1"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-SignificantEvents-1"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Affiliation-1"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-ThreatAssessment-1"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-YorinobuArasaka-Notes-1"));
    }

    // === STATIC ARASAKA ===
    public static func HanakoArasaka() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hanako").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-HanakoArasaka-Notes"));
    }

    public static func SandayuOda() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("oda").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SandayuOda-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SandayuOda-Background"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SandayuOda-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SandayuOda-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SandayuOda-Notes"));
    }

    public static func AdamSmasher() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("smasher").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AdamSmasher-Notes"));
    }

    public static func AndersHellman() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hellman").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AndersHellman-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AndersHellman-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-AndersHellman-SignificantEvents"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AndersHellman-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AndersHellman-Notes"));
    }

    // === MILITECH ===
    public static func MeredithStout() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("meredith").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MeredithStout-Notes"));
    }

    public static func WeldonHolt() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("holt").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-WeldonHolt-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-WeldonHolt-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-WeldonHolt-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-WeldonHolt-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-WeldonHolt-Notes"));
    }

    // === FIXERS ===
    public static func Oleg() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bodyguard_dex_default").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Oleg-Notes"));
    }

    public static func DexterDeShawn(id: String) -> ref<KdspUniqueNPCBackstory> {
        // Post-Heist: Beaten state
        if StrContains(id, "dex_beaten") {
            return KdspUniqueNPCBackstory.Create("dex_dex_beaten").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Background"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-EarlyLife"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-SignificantEvents"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Affiliation"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-CriminalRecord"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-CyberwareStatus"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-FinancialStatus"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-MedicalStatus"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-ThreatAssessment"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Relationships"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Notes"));
        }
        // Post-Heist: Shot/dead state
        if StrContains(id, "dex_shot") {
            return KdspUniqueNPCBackstory.Create("dex_dex_shot").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Classification-1"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Background-1"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-EarlyLife-1"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-SignificantEvents-1"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Affiliation-1"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-CriminalRecord-1"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-CyberwareStatus-1"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-FinancialStatus-1"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-MedicalStatus-1"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-ThreatAssessment-1"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Relationships-1"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Notes-1"));
        }
        // Default: Pre-Heist
        return KdspUniqueNPCBackstory.Create("dex_default").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Classification-2"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Background-2"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-EarlyLife-2"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-SignificantEvents-2"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Affiliation-2"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-CriminalRecord-2"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-CyberwareStatus-2"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-FinancialStatus-2"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-MedicalStatus-2"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-ThreatAssessment-2"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Relationships-2"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DexterDeShawn-Notes-2"));
    }

    public static func WakakoOkada() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("wakako").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-WakakoOkada-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-WakakoOkada-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-WakakoOkada-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-WakakoOkada-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-WakakoOkada-Notes"));
    }

    public static func ReginaJones() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("regina").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ReginaJones-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ReginaJones-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ReginaJones-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ReginaJones-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ReginaJones-Notes"));
    }

    public static func Padre() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("padre").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Padre-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Padre-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Padre-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Padre-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Padre-Notes"));
    }

    public static func DakotaSmith() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dakota").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DakotaSmith-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DakotaSmith-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DakotaSmith-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DakotaSmith-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DakotaSmith-Notes"));
    }

    public static func DinoDinovic() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dino").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DinoDinovic-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DinoDinovic-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DinoDinovic-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DinoDinovic-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DinoDinovic-Notes"));
    }

    public static func MrHands() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hands").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MrHands-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MrHands-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MrHands-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MrHands-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MrHands-Notes"));
    }

    public static func ElCapitan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("capitan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ElCapitan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ElCapitan-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ElCapitan-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ElCapitan-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ElCapitan-Notes"));
    }

    public static func Mickey() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mickey").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Mickey-Notes"));
    }

    // === MERCS / AFTERLIFE ===
    public static func JackieWelles() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("jackie").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Background"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-SignificantEvents"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("jackie").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Background-1"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-SignificantEvents-1"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JackieWelles-Notes-1"));
    }

    public static func EmmerickBronson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("emmerick_bronson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-EmmerickBronson-Notes"));
    }

    public static func TBug() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsHeistCompleted() {
            return KdspUniqueNPCBackstory.Create("tbug").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-Classification"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-SignificantEvents"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("tbug").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-Background"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-TBug-Notes-1"));
    }

    public static func RogueAmendiares() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rogue").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RogueAmendiares-Notes"));
    }

    public static func CrispinWeyland() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("squama").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CrispinWeyland-Notes"));
    }

    public static func JohnnySilverhand() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("johnny").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JohnnySilverhand-Notes"));
    }

    public static func KerryEurodyne() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kerry").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-KerryEurodyne-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-KerryEurodyne-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-KerryEurodyne-SignificantEvents"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-KerryEurodyne-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-KerryEurodyne-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-KerryEurodyne-Notes"));
    }

    public static func AltCunningham() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alt").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AltCunningham-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AltCunningham-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-AltCunningham-SignificantEvents"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AltCunningham-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AltCunningham-Notes"));
    }

    public static func ClaireRussell() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("claire").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ClaireRussell-Notes"));
    }

    // === RIPPERDOCS ===
    public static func ViktorVektor() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("viktor").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ViktorVektor-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ViktorVektor-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ViktorVektor-SignificantEvents"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ViktorVektor-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ViktorVektor-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ViktorVektor-Notes"));
    }

    public static func Fingers() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("fingers").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Fingers-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Fingers-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Fingers-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Fingers-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Fingers-Notes"));
    }

    public static func MistyOlszewski() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("misty").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MistyOlszewski-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MistyOlszewski-Background"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MistyOlszewski-Relationships"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MistyOlszewski-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MistyOlszewski-Notes"));
    }

    // Note: detailed Lucy Thackery entry in Watson District Notables section

    // === MOX / CLOUDS ===
    public static func JudyAlvarez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("judy").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JudyAlvarez-Notes"));
    }

    public static func EvelynParker() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsEvelynDead() {
            return KdspUniqueNPCBackstory.Create("evelyn").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-Classification"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-SignificantEvents"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("evelyn").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-Background"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-EvelynParker-Notes-1"));
    }

    public static func MaikoMaeda() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("maiko").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MaikoMaeda-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MaikoMaeda-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MaikoMaeda-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MaikoMaeda-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MaikoMaeda-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MaikoMaeda-Notes"));
    }

    public static func Woodman() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("woodman").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Woodman-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Woodman-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Woodman-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Woodman-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Woodman-Notes"));
    }

    // === ALDECALDOS ===
    public static func PanamPalmer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("panam").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-PanamPalmer-Notes"));
    }

    public static func SaulBright() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("saul").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SaulBright-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SaulBright-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SaulBright-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SaulBright-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SaulBright-Notes"));
    }

    public static func MitchAnderson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mitch").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MitchAnderson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MitchAnderson-Background"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MitchAnderson-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MitchAnderson-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MitchAnderson-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MitchAnderson-Notes"));
    }

    // === VOODOO BOYS ===
    public static func Brigitte() -> ref<KdspUniqueNPCBackstory> {
        // Before q110 (Both Sides, Now): scanner glitch hides identity
        if !KdspQuestProgressHelper.IsBothSidesNowDone() {
            return KdspUniqueNPCBackstory.Create("brigitte").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Background"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-SignificantEvents"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-ThreatAssessment"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("brigitte").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Background-1"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-ThreatAssessment-1"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Brigitte-Notes-1"));
    }

    public static func Placide() -> ref<KdspUniqueNPCBackstory> {
        // Before q110 (Both Sides, Now): scanner glitch hides rank/affiliation
        if !KdspQuestProgressHelper.IsBothSidesNowDone() {
            return KdspUniqueNPCBackstory.Create("placide").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-Background"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-ThreatAssessment"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("placide").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-Background-1"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-ThreatAssessment-1"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Placide-Notes-1"));
    }

    // === MAELSTROM ===
    public static func Royce() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("royce").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Royce-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Royce-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Royce-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Royce-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Royce-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Royce-Notes"));
    }

    public static func DumDum() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dumdum").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DumDum-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DumDum-Background"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DumDum-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DumDum-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DumDum-Notes"));
    }

    // === NCPD / POLITICS ===
    public static func RiverWard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("river").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RiverWard-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RiverWard-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RiverWard-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RiverWard-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-RiverWard-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RiverWard-Notes"));
    }

    public static func JeffersonPeralez() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsDreamOnDone() {
            return KdspUniqueNPCBackstory.Create("peralez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Background"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-EarlyLife"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-SignificantEvents"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Affiliation"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-CriminalRecord"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-CyberwareStatus"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-FinancialStatus"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-MedicalStatus"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-ThreatAssessment"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Relationships"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Notes"));
        }
        if KdspQuestProgressHelper.IsFoughtTheLawDone() {
            return KdspUniqueNPCBackstory.Create("peralez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Classification-1"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Background-1"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-EarlyLife-1"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-SignificantEvents-1"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Affiliation-1"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-CriminalRecord-1"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-CyberwareStatus-1"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-FinancialStatus-1"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-MedicalStatus-1"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-ThreatAssessment-1"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Relationships-1"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Notes-1"));
        }
        return KdspUniqueNPCBackstory.Create("peralez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Classification-2"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Background-2"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-EarlyLife-2"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-SignificantEvents-2"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Affiliation-2"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-CriminalRecord-2"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-CyberwareStatus-2"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-FinancialStatus-2"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-MedicalStatus-2"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-ThreatAssessment-2"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Relationships-2"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JeffersonPeralez-Notes-2"));
    }

    public static func ElizabethPeralez() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsDreamOnDone() {
            return KdspUniqueNPCBackstory.Create("elizabeth_peralez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Classification"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Background"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-EarlyLife"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-SignificantEvents"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Affiliation"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-CriminalRecord"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-CyberwareStatus"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-FinancialStatus"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-MedicalStatus"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-ThreatAssessment"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Relationships"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Notes"));
        }
        if KdspQuestProgressHelper.IsFoughtTheLawDone() {
            return KdspUniqueNPCBackstory.Create("elizabeth_peralez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Classification-1"))
                .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Background-1"))
                .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-EarlyLife-1"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-SignificantEvents-1"))
                .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Affiliation-1"))
                .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-CriminalRecord-1"))
                .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-CyberwareStatus-1"))
                .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-FinancialStatus-1"))
                .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-MedicalStatus-1"))
                .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-ThreatAssessment-1"))
                .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Relationships-1"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Notes-1"));
        }
        return KdspUniqueNPCBackstory.Create("elizabeth_peralez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Classification-2"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Background-2"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-EarlyLife-2"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-SignificantEvents-2"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Affiliation-2"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-CriminalRecord-2"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-CyberwareStatus-2"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-FinancialStatus-2"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-MedicalStatus-2"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-ThreatAssessment-2"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Relationships-2"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ElizabethPeralez-Notes-2"));
    }

    public static func LuciusRhyne() -> ref<KdspUniqueNPCBackstory> {
        if KdspQuestProgressHelper.IsRhyneDead() {
            return KdspUniqueNPCBackstory.Create("rhyne").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-Classification"))
                .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-SignificantEvents"))
                .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-Notes"));
        }
        return KdspUniqueNPCBackstory.Create("rhyne").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-Background"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LuciusRhyne-Notes-1"));
    }

    // === OTHER ===
    public static func Delamain() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("delamain").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Delamain-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Delamain-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Delamain-SignificantEvents"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Delamain-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Delamain-Notes"));
    }

    public static func MamaWelles() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mama_welles").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MamaWelles-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MamaWelles-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MamaWelles-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MamaWelles-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MamaWelles-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MamaWelles-Notes"));
    }

    public static func CynthiaNajarro() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mq040_wife").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CynthiaNajarro-Notes"));
    }

    public static func PepeNajarro() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("elcoyote_barman").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Notes"));
    }

    public static func ShadyRipperdocMQ040() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mq040_ripperdoc").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ShadyRipperdocMQ040-Notes"));
    }

    // --- BEAT ON THE BRAT: KABUKI TWINS (mq025) ---
    public static func CertoEsquerdo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mq025_twin_01").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CertoEsquerdo-Notes"));
    }

    public static func EsquerdoCerto() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mq025_twin_02").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-EsquerdoCerto-Notes"));
    }

    public static func FrankNostra() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("corpo_friend").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-FrankNostra-Notes"));
    }

    public static func PepeNajarro() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("elcoyote_barman").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Background-1"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-EarlyLife-1"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-SignificantEvents-1"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Affiliation-1"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-CriminalRecord-1"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-FinancialStatus-1"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-MedicalStatus-1"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-ThreatAssessment-1"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Relationships-1"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-PepeNajarro-Notes-1"));
    }

    // === SPECIAL / ANIMALS ===
    public static func Nibbles() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nibbles").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Nibbles-Notes"));
    }

    // TYGER CLAWS - note: detailed entry for Jotaro Shobo in Watson District Notables section

    public static func HiromiSato() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hiromi_sato").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HiromiSato-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HiromiSato-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-HiromiSato-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HiromiSato-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-HiromiSato-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HiromiSato-ThreatAssessment"));
    }

    // VALENTINOS - note: detailed entry for Gustavo Orta in Notable Residents section

    public static func MiguelRodriguez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mq_hey_rey_06_outpost_miniboss").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Notes"));
    }

    // MAELSTROM - Additional
    public static func Brick() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("brick").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Brick-ThreatAssessment"));
    }

    // XBD EDITORS
    public static func GottfridPersson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gottfrid_persson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-GottfridPersson-Notes"));
    }

    public static func FredrikPersson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("fredrik_persson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-FredrikPersson-Notes"));
    }

    // ANIMALS
    public static func Sasquatch() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sasquatch").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Sasquatch-ThreatAssessment"));
    }

    // WRAITHS
    public static func Nash() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nash").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Nash-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Nash-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Nash-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Nash-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Nash-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Nash-ThreatAssessment"));
    }

    // SCAVENGERS
    public static func AntonKolos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anton_kolos").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolos-ThreatAssessment"));
    }

    // NETWATCH
    public static func BryceMosley() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bryce_mosley").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BryceMosley-ThreatAssessment"));
    }

    // MEDIA
    public static func GilleanJordan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gillean_jordan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-GilleanJordan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-GilleanJordan-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-GilleanJordan-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-GilleanJordan-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-GilleanJordan-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-GilleanJordan-ThreatAssessment"));
    }

    // Note: detailed Max Jones entry in Watson District Notables section

    // CORPO SECURITY
    public static func GrahamMayfield() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("graham_mayfield").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-GrahamMayfield-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-GrahamMayfield-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-GrahamMayfield-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-GrahamMayfield-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-GrahamMayfield-ThreatAssessment"));
    }

    public static func MilitechCommander() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("militech_commander").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MilitechCommander-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MilitechCommander-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MilitechCommander-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MilitechCommander-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MilitechCommander-ThreatAssessment"));
    }

    // RIPPERDOCS
    public static func CharlesBucks() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("charles_bucks").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesBucks-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesBucks-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesBucks-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesBucks-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesBucks-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesBucks-ThreatAssessment"));
    }

    public static func Wilson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("wilson_default").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Wilson-Notes"));
    }

    // US CRACKS / KERRY'S BAND
    public static func BlueMoon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("blue_moon").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BlueMoon-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BlueMoon-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BlueMoon-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BlueMoon-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BlueMoon-ThreatAssessment"));
    }

    // CELEBRITIES
    public static func LizzyWizzy() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lizzy_wizzy").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-LizzyWizzy-Relationships"));
    }

    public static func OzobBozo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ozob").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-OzobBozo-ThreatAssessment"));
    }

    public static func Ozob() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCEntries.OzobBozo();
    }

    public static func JoshuaStephenson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("joshua_stephenson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JoshuaStephenson-ThreatAssessment"));
    }

    // PHANTOM LIBERTY
    public static func SolomonReed() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("solomon_reed").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SolomonReed-ThreatAssessment"));
    }

    public static func Songbird() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("songbird").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-CyberwareStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Songbird-ThreatAssessment"));
    }

    public static func KurtHansen() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kurt_hansen").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-KurtHansen-ThreatAssessment"));
    }

    public static func RosalindMyers() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rosalind_myers").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RosalindMyers-ThreatAssessment"));
    }

    public static func AlenaXenakis() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alena_xenakis").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AlenaXenakis-Notes"));
    }

    // === PHANTOM LIBERTY - LONGSHORE STACKS VENDORS ===

    public static func LeonWatson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("leon_watson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LeonWatson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LeonWatson-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LeonWatson-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LeonWatson-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LeonWatson-Notes"));
    }

    public static func CostinLahovary() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("costin_lahovary").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CostinLahovary-Notes"));
    }

    public static func RonaldMalone() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ronald_malone").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RonaldMalone-Notes"));
    }

    public static func SusannaMack() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("susanna_mack").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-CyberwareStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SusannaMack-Notes"));
    }

    // === PHANTOM LIBERTY - NO EASY WAY OUT CHARACTERS ===

    public static func AngelicaWhelan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("angelica_whelan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AngelicaWhelan-Notes"));
    }

    public static func DamirKovac() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("damir_kovac").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-Background"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DamirKovac-Notes"));
    }

    public static func AaronWaines() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("aaron_waines").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AaronWaines-Notes"));
    }

    public static func WilliamCorrey() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("william_correy").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-WilliamCorrey-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-WilliamCorrey-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-WilliamCorrey-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-WilliamCorrey-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-WilliamCorrey-Notes"));
    }

    // === PHANTOM LIBERTY - GIGS ===

    public static func AlanNoel() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alan_noel").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AlanNoel-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AlanNoel-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AlanNoel-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AlanNoel-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AlanNoel-Notes"));
    }

    public static func KyleAraujo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kyle_araujo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-KyleAraujo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-KyleAraujo-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-KyleAraujo-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-KyleAraujo-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-KyleAraujo-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-KyleAraujo-Notes"));
    }

    // === PHANTOM LIBERTY - EBM PETROCHEM STADIUM VENDORS ===

    public static func SakiSeo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("saki_seo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SakiSeo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SakiSeo-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SakiSeo-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SakiSeo-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SakiSeo-Notes"));
    }

    public static func EronAcedo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("eron_acedo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-EronAcedo-Notes"));
    }

    public static func HeroldLowe() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("herold_lowe").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HeroldLowe-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HeroldLowe-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HeroldLowe-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-HeroldLowe-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HeroldLowe-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-HeroldLowe-Notes"));
    }

    public static func SammyTaylor() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sammy_taylor").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SammyTaylor-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SammyTaylor-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SammyTaylor-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SammyTaylor-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SammyTaylor-Notes"));
    }

    public static func MarcinIwinski() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("marcin_iwinski").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MarcinIwinski-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MarcinIwinski-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MarcinIwinski-Affiliation"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MarcinIwinski-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MarcinIwinski-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MarcinIwinski-Notes"));
    }

    public static func MichalKicinski() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("michal_kicinski").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MichalKicinski-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MichalKicinski-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MichalKicinski-Affiliation"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MichalKicinski-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MichalKicinski-Notes"));
    }

    public static func DavidWalker() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("david_walker").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DavidWalker-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DavidWalker-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DavidWalker-Affiliation"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-DavidWalker-Relationships"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DavidWalker-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DavidWalker-Notes"));
    }

    public static func SophiaDupont() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sophia_dupont").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-Affiliation"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-Relationships"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SophiaDupont-Notes"));
    }

    // AFTERLIFE MERCS
    public static func Nix() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nix").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Nix-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Nix-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Nix-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Nix-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Nix-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Nix-ThreatAssessment"));
    }

    // MISC CHARACTERS
    public static func Brendan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("brendan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Brendan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Brendan-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Brendan-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Brendan-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Brendan-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Brendan-ThreatAssessment"));
    }

    public static func Skippy() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("skippy").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Skippy-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Skippy-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Skippy-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Skippy-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Skippy-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Skippy-ThreatAssessment"));
    }

    public static func CoachFred() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("coach_fred").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CoachFred-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CoachFred-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CoachFred-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CoachFred-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CoachFred-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CoachFred-ThreatAssessment"));
    }

    // FIXER ASSOCIATES
    public static func Barry() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("barry").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Barry-Notes"));
    }

    public static func JuanMendez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("juan_mendez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JuanMendez-Notes"));
    }

    public static func NadiaPetrova() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nadia_petrova").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-NadiaPetrova-Notes"));
    }

    // MORE FIXERS/ASSOCIATES
    public static func CassiusRyder() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("cassius_ryder").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CassiusRyder-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CassiusRyder-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CassiusRyder-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CassiusRyder-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CassiusRyder-ThreatAssessment"));
    }

    public static func OctavioRuiz() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("octavio_ruiz").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-OctavioRuiz-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-OctavioRuiz-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-OctavioRuiz-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-OctavioRuiz-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-OctavioRuiz-ThreatAssessment"));
    }

    public static func RobertBodean() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("robert_bodean").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RobertBodean-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RobertBodean-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RobertBodean-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RobertBodean-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RobertBodean-ThreatAssessment"));
    }

    // === AFTERLIFE CONTACTS ===
    public static func DennisCranmer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dennis_cranmer").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DennisCranmer-ThreatAssessment"));
    }

    // === NETRUNNERS ===
    public static func R3n0() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("r3n0").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-R3n0-ThreatAssessment"));
    }

    // === RIOT CLUB STAFF ===
    public static func LiamNorthom() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("liam_northom").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-LiamNorthom-Relationships"));
    }

    public static func AsaRisu() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("asa_risu").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AsaRisu-ThreatAssessment"));
    }

    public static func RalphLogan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ralph_logan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RalphLogan-ThreatAssessment"));
    }

    public static func LindaSpencer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("linda_spencer").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LindaSpencer-ThreatAssessment"));
    }

    public static func JermaineNorton() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jermaine_norton").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JermaineNorton-ThreatAssessment"));
    }

    // === VENDORS - CLOTHING ===
    public static func ZaneJagger() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zane_jagger").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ZaneJagger-Notes"));
    }

    // === CYBERPSYCHOS ===
    public static func ZariaHughes() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zaria_hughes").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ZariaHughes-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ZariaHughes-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ZariaHughes-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZariaHughes-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ZariaHughes-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ZariaHughes-ThreatAssessment"));
    }

    public static func EllisCarter() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ellis_carter").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EllisCarter-ThreatAssessment"));
    }

    public static func LelyHein() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lely_hein").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-Relationships"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LelyHein-ThreatAssessment"));
    }

    public static func LtMower() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lt_mower").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LtMower-ThreatAssessment"));
    }

    public static func CedricMuller() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("cedric_muller").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CedricMuller-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CedricMuller-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CedricMuller-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CedricMuller-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CedricMuller-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CedricMuller-ThreatAssessment"));
    }

    public static func GastonPhillips() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gaston_phillips").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-GastonPhillips-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-GastonPhillips-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-GastonPhillips-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-GastonPhillips-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-GastonPhillips-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-GastonPhillips-ThreatAssessment"));
    }

    public static func DaoHyunh() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("dao_hyunh").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DaoHyunh-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DaoHyunh-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DaoHyunh-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DaoHyunh-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DaoHyunh-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DaoHyunh-ThreatAssessment"));
    }

    public static func DiegoRamirez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("diego_ramirez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-DiegoRamirez-Notes"));
    }

    public static func TamaraCosby() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tamara_cosby").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-Relationships"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TamaraCosby-ThreatAssessment"));
    }

    public static func MattLiaw() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("matt_liaw").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MattLiaw-Notes"));
    }

    public static func ChaseColey() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("chase_coley").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ChaseColey-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ChaseColey-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ChaseColey-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ChaseColey-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ChaseColey-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ChaseColey-ThreatAssessment"));
    }

    public static func RusselGreene() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("russel_greene").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-ThreatAssessment"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RusselGreene-Notes"));
    }

    public static func ZionWylde() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zion_wylde").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ZionWylde-ThreatAssessment"));
    }

    public static func NorioAkuhara() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("norio_akuhara").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-NorioAkuhara-ThreatAssessment"));
    }

    public static func ShinobuImai() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("shinobu_imai").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ShinobuImai-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ShinobuImai-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ShinobuImai-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ShinobuImai-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ShinobuImai-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ShinobuImai-ThreatAssessment"));
    }

    public static func KaiserHerzog() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("kaiser_herzog").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-KaiserHerzog-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-KaiserHerzog-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-KaiserHerzog-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-KaiserHerzog-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-KaiserHerzog-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-KaiserHerzog-ThreatAssessment"));
    }

    public static func TomAyer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tom_ayer").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TomAyer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TomAyer-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-TomAyer-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-TomAyer-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TomAyer-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TomAyer-ThreatAssessment"));
    }

    public static func AlecJohnson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alec_johnson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AlecJohnson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AlecJohnson-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AlecJohnson-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AlecJohnson-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AlecJohnson-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AlecJohnson-ThreatAssessment"));
    }

    public static func TracyPhillips() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tracy_phillips").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-Affiliation"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-CyberwareStatus"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TracyPhillips-ThreatAssessment"));
    }

    // === NCPD SCANNER HUSTLES / ASSAULT IN PROGRESS ===
    public static func RufusMcBride() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rufus_mcbride").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RufusMcBride-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RufusMcBride-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RufusMcBride-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RufusMcBride-ThreatAssessment"));
    }

    public static func EuralioAlma() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("euralio_alma").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EuralioAlma-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EuralioAlma-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-EuralioAlma-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EuralioAlma-ThreatAssessment"));
    }

    public static func BruceWard() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bruce_ward").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWard-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWard-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWard-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWard-ThreatAssessment"));
    }

    public static func ZoeAlonzo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("zoe_alonzo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ZoeAlonzo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ZoeAlonzo-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ZoeAlonzo-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ZoeAlonzo-ThreatAssessment"));
    }

    public static func MiguelRodriguez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("miguel_rodriguez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Classification-1"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-Background-1"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-CriminalRecord-1"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MiguelRodriguez-ThreatAssessment-1"));
    }

    public static func DenzelCryer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("denzel_cryer").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DenzelCryer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DenzelCryer-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DenzelCryer-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DenzelCryer-ThreatAssessment"));
    }

    public static func JesseSabara() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jesse_sabara").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JesseSabara-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JesseSabara-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JesseSabara-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JesseSabara-ThreatAssessment"));
    }

    public static func StanislausZbyszko() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("stanislaus_zbyszko").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-StanislausZbyszko-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-StanislausZbyszko-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-StanislausZbyszko-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-StanislausZbyszko-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-StanislausZbyszko-ThreatAssessment"));
    }

    public static func BenDeBaillon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ben_debaillon").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BenDeBaillon-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BenDeBaillon-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BenDeBaillon-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BenDeBaillon-ThreatAssessment"));
    }

    public static func AyoZarin() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ayo_zarin").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AyoZarin-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AyoZarin-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AyoZarin-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AyoZarin-ThreatAssessment"));
    }

    public static func RossUlmer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ross_ulmer").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RossUlmer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RossUlmer-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RossUlmer-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RossUlmer-ThreatAssessment"));
    }

    public static func AntonKolev() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anton_kolev").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolev-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolev-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolev-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AntonKolev-ThreatAssessment"));
    }

    public static func JohnQuaid() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("john_quaid").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JohnQuaid-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JohnQuaid-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JohnQuaid-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JohnQuaid-ThreatAssessment"));
    }

    public static func DariusMiles() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("darius_miles").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-DariusMiles-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-DariusMiles-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-DariusMiles-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-DariusMiles-ThreatAssessment"));
    }

    public static func PaulCraven() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("paul_craven").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-PaulCraven-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-PaulCraven-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-PaulCraven-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-PaulCraven-ThreatAssessment"));
    }

    public static func OlgaLongmead() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("olga_longmead").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-OlgaLongmead-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-OlgaLongmead-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-OlgaLongmead-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-OlgaLongmead-ThreatAssessment"));
    }

    public static func MikeKowalsky() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mike_kowalsky").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MikeKowalsky-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MikeKowalsky-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MikeKowalsky-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MikeKowalsky-ThreatAssessment"));
    }

    public static func SamanthaSamu() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("samantha_samu").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SamanthaSamu-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SamanthaSamu-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-SamanthaSamu-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SamanthaSamu-ThreatAssessment"));
    }

    public static func BarryAlken() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("barry_alken").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BarryAlken-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BarryAlken-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BarryAlken-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BarryAlken-ThreatAssessment"));
    }

    public static func MokomichiYamada() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mokomichi_yamada").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MokomichiYamada-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MokomichiYamada-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MokomichiYamada-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MokomichiYamada-ThreatAssessment"));
    }

    // === NOTABLE NIGHT CITY RESIDENTS ===
    public static func BigPete() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("big_pete").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BigPete-ThreatAssessment"));
    }

    public static func BruceWelby() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bruce_welby").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BruceWelby-ThreatAssessment"));
    }

    public static func BenedictMcAdams() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("benedict_mcadams").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-Notes"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BenedictMcAdams-ThreatAssessment"));
    }

    public static func IrisTanner() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("iris_tanner").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-IrisTanner-ThreatAssessment"));
    }

    public static func JackMausser() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jack_mausser").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-FinancialStatus"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JackMausser-ThreatAssessment"));
    }

    public static func JoanneKoch() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("joanne_koch").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JoanneKoch-ThreatAssessment"));
    }

    public static func EvaCole() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("eva_cole").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-EvaCole-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-EvaCole-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-EvaCole-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-EvaCole-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-EvaCole-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-EvaCole-ThreatAssessment"));
    }

    public static func TuckerAlbach() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tucker_albach").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TuckerAlbach-ThreatAssessment"));
    }

    public static func RebecaPrice() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("rebeca_price").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RebecaPrice-ThreatAssessment"));
    }

    public static func KaruboBairei() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("karubo_bairei").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-KaruboBairei-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-KaruboBairei-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-KaruboBairei-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-KaruboBairei-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-KaruboBairei-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-KaruboBairei-ThreatAssessment"));
    }

    public static func JakeEstevez() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jake_estevez").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JakeEstevez-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JakeEstevez-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JakeEstevez-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JakeEstevez-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JakeEstevez-ThreatAssessment"));
    }

    public static func JoseLuis() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jose_luis").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JoseLuis-ThreatAssessment"));
    }

    public static func GustavoOrta() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("gustavo_orta").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-GustavoOrta-ThreatAssessment"));
    }

    public static func MarthaFrakes() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("martha_frakes").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MarthaFrakes-ThreatAssessment"));
    }

    public static func AnthonyAnderson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anthony_anderson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAnderson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAnderson-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAnderson-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAnderson-ThreatAssessment"));
    }

    public static func MilkoAlexis() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("milko_alexis").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MilkoAlexis-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MilkoAlexis-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MilkoAlexis-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MilkoAlexis-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MilkoAlexis-ThreatAssessment"));
    }

    public static func LeonRinder() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("leon_rinder").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-CriminalRecord"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-MedicalStatus"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-CyberwareStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LeonRinder-ThreatAssessment"));
    }

    public static func JasmineDixon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jasmine_dixon").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JasmineDixon-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JasmineDixon-Background"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JasmineDixon-CriminalRecord"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JasmineDixon-ThreatAssessment"));
    }

    public static func JulietHorrigan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("juliet_horrigan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-Relationships"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-MedicalStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JulietHorrigan-ThreatAssessment"));
    }

    public static func LoganGarcia() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("logan_garcia").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-Notes"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LoganGarcia-ThreatAssessment"));
    }

    public static func FlaviodosSantos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("flavio_dos_santos").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-FlaviodosSantos-ThreatAssessment"));
    }

    public static func VicVega() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("vic_vega").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-Notes"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-VicVega-ThreatAssessment"));
    }

    // === WATSON DISTRICT NOTABLES ===
    public static func RohChiWon() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("roh_chi_won").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RohChiWon-ThreatAssessment"));
    }

    public static func TinyMike() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tiny_mike").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-Relationships"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-MedicalStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TinyMike-ThreatAssessment"));
    }

    public static func BryceStone() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bryce_stone").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-Relationships"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-FinancialStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BryceStone-ThreatAssessment"));
    }

    public static func HwangboDongGun() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hwangbo_dong_gun").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HwangboDongGun-ThreatAssessment"));
    }

    public static func MaxJones() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("max_jones").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MaxJones-ThreatAssessment"));
    }

    public static func AloisDaquin() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("alois_daquin").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AloisDaquin-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AloisDaquin-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AloisDaquin-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AloisDaquin-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AloisDaquin-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AloisDaquin-ThreatAssessment"));
    }

    public static func HalCantos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hal_cantos").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HalCantos-ThreatAssessment"));
    }

    public static func BlakeCroyle() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("blake_croyle").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BlakeCroyle-ThreatAssessment"));
    }

    public static func JaeHyunLee() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jae_hyun_lee").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JaeHyunLee-ThreatAssessment"));
    }

    public static func LucyThackery() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lucy_thackery").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-Relationships"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-MedicalStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LucyThackery-ThreatAssessment"));
    }

    public static func NinaKraviz() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("wbr_hil_ripdoc_01").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-MedicalStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-ThreatAssessment"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-NinaKraviz-Notes"));
    }

    public static func JotaroShobo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jotaro_shobo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JotaroShobo-ThreatAssessment"));
    }

    public static func TakiKenmochi() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("taki_kenmochi").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Background"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TakiKenmochi-ThreatAssessment"));
    }

    public static func MikhailAkulov() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mikhail_akulov").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-Relationships"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-FinancialStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MikhailAkulov-ThreatAssessment"));
    }

    public static func AnnaHamill() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anna_hamill").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AnnaHamill-ThreatAssessment"));
    }

    // === WESTBROOK / JAPANTOWN NOTABLES ===
    public static func BeatriceEllenTrieste() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("beatrice_ellen_trieste").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-Notes"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BeatriceEllenTrieste-ThreatAssessment"));
    }

    public static func SergeiKarasinsky() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("sergei_karasinsky").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-CriminalRecord"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-Notes"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-FinancialStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-SergeiKarasinsky-ThreatAssessment"));
    }

    public static func ChangHoonNam() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("chang_hoon_nam").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-Notes"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-CyberwareStatus"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ChangHoonNam-ThreatAssessment"));
    }

    public static func LaurenCostigan() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("lauren_costigan").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-LaurenCostigan-ThreatAssessment"));
    }

    // ═══════════════════════════════════════════════════════════
    // PHANTOM LIBERTY - GIG NPCs
    // ═══════════════════════════════════════════════════════════

    // --- DOGTOWN SAINTS ---

    public static func NikaYankovich() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nika_yankovich").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-NikaYankovich-ThreatAssessment"));
    }

    public static func OdellBlanco() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("odell_blanco").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-OdellBlanco-ThreatAssessment"));
    }

    public static func AnthonyAndersonRipper() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("anthony_anderson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-Relationships"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-CyberwareStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AnthonyAndersonRipper-ThreatAssessment"));
    }

    // --- PROTOTYPE IN THE SCRAPER ---

    public static func HasanDemir() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("hasan_demir").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-CyberwareStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-HasanDemir-ThreatAssessment"));
    }

    // --- WAITING FOR DODGER ---

    public static func BillMitchel() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("bill_mitchel").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BillMitchel-ThreatAssessment"));
    }

    public static func CharlesWilson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("charles_wilson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesWilson-ThreatAssessment"));
    }

    public static func CarlRobinson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("carl_robinson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-Relationships"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-CyberwareStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CarlRobinson-ThreatAssessment"));
    }

    // --- THE MAN WHO KILLED JASON FOREMAN ---

    public static func BrianaDolson() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("briana_dolson").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BrianaDolson-ThreatAssessment"));
    }

    // --- SPY IN THE JUNGLE ---

    public static func StevenSantos() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("steven_santos").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-StevenSantos-ThreatAssessment"));
    }

    public static func AnaFriedman() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ana_friedman").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AnaFriedman-ThreatAssessment"));
    }

    public static func BorisRibakov() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("boris_ribakov").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-CyberwareStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-BorisRibakov-ThreatAssessment"));
    }

    public static func KatyaKarelina() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("katya_karelina").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-KatyaKarelina-ThreatAssessment"));
    }

    // --- TALENT ACADEMY ---

    public static func Baird() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("baird").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-CyberwareStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-Baird-ThreatAssessment"));
    }

    public static func TommieWalker() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("tommie_walker").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-EarlyLife"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-TommieWalker-ThreatAssessment"));
    }

    public static func FionaVargas() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("fiona_vargas").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-CriminalRecord"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-FionaVargas-ThreatAssessment"));
    }

    // --- HEAVIEST OF HEARTS ---

    public static func MichaelMaldonado() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("michael_maldonado").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MichaelMaldonado-ThreatAssessment"));
    }

    public static func GeorginaZembinsky() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("georgina_zembinsky").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-CriminalRecord"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-GeorginaZembinsky-ThreatAssessment"));
    }

    // === PHANTOM LIBERTY - BLACK SAPPHIRE PARTY (q303 - You Know My Name) ===

    // --- BARGHEST ---

    public static func JagoSzabo() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jago_szabo").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JagoSzabo-ThreatAssessment"));
    }

    public static func ChesterBennett() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("chester_bennett").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ChesterBennett-ThreatAssessment"));
    }

    public static func CharlesGraham() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("charles_graham").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-CyberwareStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-CharlesGraham-ThreatAssessment"));
    }

    // --- TYGER CLAWS ---

    public static func JunAzegami() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("jun_azegami").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JunAzegami-ThreatAssessment"));
    }

    public static func MarcusIchida() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("marcus_ichida").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-MarcusIchida-ThreatAssessment"));
    }

    // --- MEDIA / TV HOSTS ---

    public static func RuthDzeng() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ruth_dzeng").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-RuthDzeng-ThreatAssessment"));
    }

    public static func ZiggyQ() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("ziggy_q").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-FinancialStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ZiggyQ-ThreatAssessment"));
    }

    public static func ArifIqbal() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("arif_iqbal").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-FinancialStatus"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ArifIqbal-ThreatAssessment"));
    }

    public static func JoshKavorkin() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("josh_kavorkin").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-JoshKavorkin-ThreatAssessment"));
    }

    // --- PARTY GUESTS ---

    public static func ReverendColver() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("reverend_colver").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ReverendColver-ThreatAssessment"));
    }

    public static func AuroreCassel() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("aurore_cassel").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AuroreCassel-ThreatAssessment"));
    }

    public static func AymericCassel() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("aymeric_cassel").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-FinancialStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-AymericCassel-ThreatAssessment"));
    }

    // --- ROADS TO REDEMPTION ---

    public static func NeleSpringer() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("nele_springer").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-EarlyLife"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-CriminalRecord"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-MedicalStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-NeleSpringer-ThreatAssessment"));
    }

    // --- ZEN MASTER (mq014 quest chain: Imagine / Stairway to Heaven / Poem of the Atoms / Meetings Along the Edge) ---

    public static func ZenMaster() -> ref<KdspUniqueNPCBackstory> {
        return KdspUniqueNPCBackstory.Create("mq014_zen_master").SetClassification(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-Classification"))
            .SetBackground(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-Background"))
            .SetEarlyLife(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-EarlyLife"))
            .SetSignificantEvents(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-SignificantEvents"))
            .SetAffiliation(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-Affiliation"))
            .SetCriminalRecord(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-CriminalRecord"))
            .SetCyberwareStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-CyberwareStatus"))
            .SetFinancialStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-FinancialStatus"))
            .SetMedicalStatus(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-MedicalStatus"))
            .SetRelationships(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-Relationships"))
            .SetNotes(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-Notes"))
            .SetThreatAssessment(GetLocalizedTextByKey(n"Kdsp-Npc-ZenMaster-ThreatAssessment"));
    }
}
