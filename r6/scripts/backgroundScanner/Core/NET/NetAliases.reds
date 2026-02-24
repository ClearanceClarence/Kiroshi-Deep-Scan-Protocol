// Kiroshi Deep Scan - NET Alias Generator
// Procedural online handle/alias generation for NET Profile section

public abstract class KdspNetAliases {

    // Main entry point — returns a formatted alias string or empty if roll fails
    public static func GenerateAlias(seed: Int32) -> String {
        // Pick from 10 style categories, then variant within
        let style = RandRange(seed, 0, 9);

        if style == 0 { return KdspNetAliases.HackerHandle(seed + 10); }
        if style == 1 { return KdspNetAliases.GamerTag(seed + 10); }
        if style == 2 { return KdspNetAliases.EdgeRunner(seed + 10); }
        if style == 3 { return KdspNetAliases.CorpoLeak(seed + 10); }
        if style == 4 { return KdspNetAliases.StreetSlang(seed + 10); }
        if style == 5 { return KdspNetAliases.Netrunner(seed + 10); }
        if style == 6 { return KdspNetAliases.Weeb(seed + 10); }
        if style == 7 { return KdspNetAliases.Paranoid(seed + 10); }
        if style == 8 { return KdspNetAliases.Pretentious(seed + 10); }
        return KdspNetAliases.NumberCrunch(seed + 10);
    }

    // ── HACKER HANDLES ── l33tspeak, classic hacker culture
    private static func HackerHandle(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Gh0st_" + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 1 { return "ZeroC00l"; }
        if i == 2 { return "r00tAccess"; }
        if i == 3 { return "Null_Pointer"; }
        if i == 4 { return "x0r_Blaze"; }
        if i == 5 { return "Sn1ff3r_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 6 { return "Ph4nt0m_Thread"; }
        if i == 7 { return "Ac1d_Burn"; }
        if i == 8 { return "Crash0verride"; }
        if i == 9 { return "D3adL1nk"; }
        if i == 10 { return "K3rnel_Pan1c"; }
        if i == 11 { return "Zer0Day_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 12 { return "Tr0jan_H0rse"; }
        if i == 13 { return "H4ckSaw"; }
        if i == 14 { return "ByteMe_" + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 15 { return "R3kt_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 16 { return "Ov3rfl0w"; }
        if i == 17 { return "Sp00f_Master"; }
        if i == 18 { return "BlueScr33n"; }
        if i == 19 { return "Mal_ware"; }
        if i == 20 { return "Brut3F0rc3"; }
        if i == 21 { return "L0g1c_B0mb"; }
        if i == 22 { return "W0rm_H0le"; }
        if i == 23 { return "D4rk_Fib3r"; }
        if i == 24 { return "Tcp_Fl00d"; }
        if i == 25 { return "Pr0xy_Gh0st"; }
        if i == 26 { return "F1r3Wall_Down"; }
        if i == 27 { return "D4t4_Wr4ith"; }
        if i == 28 { return "Spl01t_K1d"; }
        return "3xpl01t_" + IntToString(RandRange(seed + 1, 100, 999));
    }

    // ── GAMER TAGS ── xX format, competitive gaming culture
    private static func GamerTag(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "xX_Shadow_Xx"; }
        if i == 1 { return "CyberFreak2077"; }
        if i == 2 { return "xX_DeathWish_Xx"; }
        if i == 3 { return "N00bSlayer_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 4 { return "L3gendary_V"; }
        if i == 5 { return "HeadshotKing" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 6 { return "xXx_Blaz3r_xXx"; }
        if i == 7 { return "Qu1ckSc0pe"; }
        if i == 8 { return "F4talFr4me"; }
        if i == 9 { return "Kill_Str34k"; }
        if i == 10 { return "MVP_Always"; }
        if i == 11 { return "G0dM0de_ON"; }
        if i == 12 { return "AimB0t_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 13 { return "xX_Pr3dat0r_Xx"; }
        if i == 14 { return "Camp3r_Life"; }
        if i == 15 { return "Respawn_K1ng"; }
        if i == 16 { return "NoSc0pe360"; }
        if i == 17 { return "PwnStar_NC"; }
        if i == 18 { return "FragOut_" + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 19 { return "B0ss_Fight"; }
        if i == 20 { return "GlitchH0p"; }
        if i == 21 { return "Lag_Lord"; }
        if i == 22 { return "R4ge_Quit"; }
        if i == 23 { return "T0xic_Main"; }
        if i == 24 { return "Sp4wn_Trap"; }
        if i == 25 { return "Cr1t_H1t"; }
        if i == 26 { return "xDarkAngelx"; }
        if i == 27 { return "W1peOut_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 28 { return "EZ_Cl4p"; }
        return "Try_Hard_" + IntToString(RandRange(seed + 1, 100, 999));
    }

    // ── EDGERUNNER ── Night City street culture, merc references
    private static func EdgeRunner(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Neon_Drifter"; }
        if i == 1 { return "Chrome_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 2 { return "NightCity_Runner"; }
        if i == 3 { return "Eddies_Only"; }
        if i == 4 { return "Gig_Rat"; }
        if i == 5 { return "Solo_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 6 { return "FixerLink"; }
        if i == 7 { return "BrainDance_Fiend"; }
        if i == 8 { return "Watson_Kid"; }
        if i == 9 { return "Heywood_Heat"; }
        if i == 10 { return "Kabuki_Knife"; }
        if i == 11 { return "Jig_Jig_Regular"; }
        if i == 12 { return "Afterlife_Dreamer"; }
        if i == 13 { return "Scav_Hunter_NC"; }
        if i == 14 { return "Iron_and_Chrome"; }
        if i == 15 { return "Flatline_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 16 { return "Preem_Gonk"; }
        if i == 17 { return "Nova_Hot"; }
        if i == 18 { return "Delta_Soon"; }
        if i == 19 { return "Meat_and_Chrome"; }
        if i == 20 { return "Zeroed_Out"; }
        if i == 21 { return "Choom4Life"; }
        if i == 22 { return "Ripperdoc_Fan"; }
        if i == 23 { return "BD_Addict_NC"; }
        if i == 24 { return "Corpo_Dropout"; }
        if i == 25 { return "Nomad_Heart"; }
        if i == 26 { return "Streetkid_Soul"; }
        if i == 27 { return "MaxTac_Dodger"; }
        if i == 28 { return "Cyberdeck_Cowboy"; }
        return "Night_City_" + IntToString(RandRange(seed + 1, 2040, 2077));
    }

    // ── CORPO LEAK ── corporate culture, office worker handles
    private static func CorpoLeak(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "DataMiner_NC"; }
        if i == 1 { return "Whistlebl0wer_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 2 { return "CorpoRat_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 3 { return "Synergy_Solutions"; }
        if i == 4 { return "Offshore_Account"; }
        if i == 5 { return "NDA_Breaker"; }
        if i == 6 { return "HR_Nightmare"; }
        if i == 7 { return "Quarterly_Loss"; }
        if i == 8 { return "Golden_Parachute"; }
        if i == 9 { return "Merger_Pending"; }
        if i == 10 { return "Board_Leak"; }
        if i == 11 { return "Insider_Trad3r"; }
        if i == 12 { return "PowerPoint_Warrior"; }
        if i == 13 { return "TPS_Report_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 14 { return "Corner_Office"; }
        if i == 15 { return "Stock_Dump"; }
        if i == 16 { return "Exit_Strategy"; }
        if i == 17 { return "Hostile_Takeover"; }
        if i == 18 { return "Due_Diligence"; }
        if i == 19 { return "Slush_Fund"; }
        if i == 20 { return "Expense_Report_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 21 { return "Glass_Ceiling"; }
        if i == 22 { return "Severance_" + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 23 { return "Arasaka_Reject"; }
        if i == 24 { return "Militech_Mole"; }
        if i == 25 { return "Kang_Tao_Leaks"; }
        if i == 26 { return "Corpo_Plaza_Ghost"; }
        if i == 27 { return "C_Suite_Snitch"; }
        if i == 28 { return "Bottom_Line"; }
        return "Restructured_" + IntToString(RandRange(seed + 1, 1, 99));
    }

    // ── STREET SLANG ── gang adjacent, street culture
    private static func StreetSlang(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "BiGsMoKe_NC"; }
        if i == 1 { return "TrapStar_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 2 { return "StrapUp_Daily"; }
        if i == 3 { return "Block_Captain"; }
        if i == 4 { return "Corner_Boy_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return "OG_Status"; }
        if i == 6 { return "Hood_Rich"; }
        if i == 7 { return "No_Snitchin"; }
        if i == 8 { return "Posted_Up"; }
        if i == 9 { return "Set_Trippin"; }
        if i == 10 { return "Turf_Wars"; }
        if i == 11 { return "Burner_Phone"; }
        if i == 12 { return "Re_Up_King"; }
        if i == 13 { return "Plug_Walk"; }
        if i == 14 { return "Cliq_Shotta"; }
        if i == 15 { return "Bread_Winner"; }
        if i == 16 { return "RackCity_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 17 { return "Bag_Chaser"; }
        if i == 18 { return "Six_Up"; }
        if i == 19 { return "GlockBoy_NC"; }
        if i == 20 { return "Slide_Thru"; }
        if i == 21 { return "No_Lackin"; }
        if i == 22 { return "Drip_God"; }
        if i == 23 { return "2Toned_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 24 { return "Ice_Cold_V"; }
        if i == 25 { return "Blicky_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 26 { return "HotBoy_Season"; }
        if i == 27 { return "Real_Stepper"; }
        if i == 28 { return "Main_Opps"; }
        return "Street_Certified_" + IntToString(RandRange(seed + 1, 1, 99));
    }

    // ── NETRUNNER ── deep net culture, ICE references, Old Net nostalgia
    private static func Netrunner(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "ICE_Breaker_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 1 { return "Daemon_Seed"; }
        if i == 2 { return "Black_ICE_Surfer"; }
        if i == 3 { return "Subnet_Crawler"; }
        if i == 4 { return "BitRot_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return "Deep_Dive_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 6 { return "R4M_Dump"; }
        if i == 7 { return "Bartmoss_Fan"; }
        if i == 8 { return "Old_Net_Ghost"; }
        if i == 9 { return "Deck_Jockey"; }
        if i == 10 { return "Quickhack_Queen"; }
        if i == 11 { return "Soulk1ller_Copy"; }
        if i == 12 { return "DataFort_Diver"; }
        if i == 13 { return "NetWatch_Snitch"; }
        if i == 14 { return "Ping_Flood"; }
        if i == 15 { return "Blackwall_Tourist"; }
        if i == 16 { return "Rogue_AI_Fan"; }
        if i == 17 { return "Packet_Storm"; }
        if i == 18 { return "Voodoo_Signal"; }
        if i == 19 { return "Cyberdeck_Junkie"; }
        if i == 20 { return "Daemon_Upload"; }
        if i == 21 { return "Trace_Route_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 22 { return "Memory_Leak"; }
        if i == 23 { return "Stack_Overflow"; }
        if i == 24 { return "Buffer_Run"; }
        if i == 25 { return "Alt_Tab_" + IntToString(RandRange(seed + 1, 10, 99)); }
        if i == 26 { return "Null_Sec"; }
        if i == 27 { return "P0rt_Scan"; }
        if i == 28 { return "Virtuality_" + IntToString(RandRange(seed + 1, 1, 50)); }
        return "R3d_Data_" + IntToString(RandRange(seed + 1, 100, 999));
    }

    // ── WEEB ── anime/manga culture, Japanese-influenced handles
    private static func Weeb(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Kawaii_Chrome"; }
        if i == 1 { return "Senpai_Notice_Me"; }
        if i == 2 { return "Mecha_Otaku_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 3 { return "Neko_Netrunner"; }
        if i == 4 { return "Oni_Mask_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return "SakuraPetal"; }
        if i == 6 { return "TsundereV"; }
        if i == 7 { return "Akira_Slide"; }
        if i == 8 { return "GitS_Fan_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 9 { return "Bushido_Blade"; }
        if i == 10 { return "Ronin_NC"; }
        if i == 11 { return "Katana_Dreamer"; }
        if i == 12 { return "Baka_Gaijin"; }
        if i == 13 { return "UwU_Chrome"; }
        if i == 14 { return "Naruto_Runner_NC"; }
        if i == 15 { return "FullMetal_V"; }
        if i == 16 { return "Evangelion_Unit_" + IntToString(RandRange(seed + 1, 0, 13)); }
        if i == 17 { return "BD_Waifu"; }
        if i == 18 { return "Shonen_Hero"; }
        if i == 19 { return "Kitsune_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 20 { return "Yakuza_Otaku"; }
        if i == 21 { return "Mango_Reader"; }
        if i == 22 { return "Cyber_Samurai_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 23 { return "Itadakimasu_V"; }
        if i == 24 { return "Sugoi_Desu"; }
        if i == 25 { return "Waifu_Laifu"; }
        if i == 26 { return "Tenshi_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 27 { return "Yandere_Type"; }
        if i == 28 { return "Moe_Moe_" + IntToString(RandRange(seed + 1, 1, 50)); }
        return "Isekai_Dreamer";
    }

    // ── PARANOID ── conspiracy, surveillance fear, tinfoil
    private static func Paranoid(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "They_Watch_Us"; }
        if i == 1 { return "Anonymous_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 2 { return "Tinfoil_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 3 { return "Off_Grid_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 4 { return "No_Camera_Zone"; }
        if i == 5 { return "Signal_Noise"; }
        if i == 6 { return "Burner_Only"; }
        if i == 7 { return "Wake_Up_Sheeple"; }
        if i == 8 { return "Dead_Drop_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 9 { return "Faraday_Cage"; }
        if i == 10 { return "TrustN01"; }
        if i == 11 { return "Throwaway_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 12 { return "Glowie_Detector"; }
        if i == 13 { return "VPN_Stacker"; }
        if i == 14 { return "Air_Gapped"; }
        if i == 15 { return "No_Chip_No_Track"; }
        if i == 16 { return "Surveillance_State"; }
        if i == 17 { return "Encrypt_Everything"; }
        if i == 18 { return "Darknet_Only"; }
        if i == 19 { return "Ghost_Protocol_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 20 { return "Tor_Node_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 21 { return "False_Flag_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 22 { return "Mind_Control_Resist"; }
        if i == 23 { return "RFID_Killer"; }
        if i == 24 { return "PGP_or_Death"; }
        if i == 25 { return "Deep_State_NC"; }
        if i == 26 { return "Pattern_Seeker"; }
        if i == 27 { return "No_Biometrics"; }
        if i == 28 { return "Plausible_Denial"; }
        return "Temp_Account_" + IntToString(RandRange(seed + 1, 100000, 999999));
    }

    // ── PRETENTIOUS ── pseudo-intellectual, philosophy, trying too hard
    private static func Pretentious(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Digital_Flneur"; }
        if i == 1 { return "Cogito_Ergo_Hack"; }
        if i == 2 { return "Nietzsche_Was_Right"; }
        if i == 3 { return "Post_Human_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 4 { return "Simulacra_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 5 { return "Void_Gazer"; }
        if i == 6 { return "Aesthetic_Violence"; }
        if i == 7 { return "Entropy_Garden"; }
        if i == 8 { return "Metamodern_V"; }
        if i == 9 { return "Liminal_Space"; }
        if i == 10 { return "Absurdist_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 11 { return "Sisyphus_Online"; }
        if i == 12 { return "Baudrillard_Boy"; }
        if i == 13 { return "Hyperreality_NC"; }
        if i == 14 { return "The_Ubermensch"; }
        if i == 15 { return "Amor_Fati"; }
        if i == 16 { return "Tabula_Rasa_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 17 { return "Eternal_Return"; }
        if i == 18 { return "Dialectic_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 19 { return "Kafkaesque"; }
        if i == 20 { return "Ouroboros_NC"; }
        if i == 21 { return "Solipsist"; }
        if i == 22 { return "Sublime_Object"; }
        if i == 23 { return "Rhizome_" + IntToString(RandRange(seed + 1, 1, 50)); }
        if i == 24 { return "Phenomenology_V"; }
        if i == 25 { return "Hauntology_" + IntToString(RandRange(seed + 1, 1, 99)); }
        if i == 26 { return "Lacanian_Mirror"; }
        if i == 27 { return "Will_To_Power"; }
        if i == 28 { return "Death_of_Author"; }
        return "Panopticon_" + IntToString(RandRange(seed + 1, 1, 99));
    }

    // ── NUMBER CRUNCH ── generic, auto-generated feeling, default accounts
    private static func NumberCrunch(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "User_" + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 1 { return "NCitizen_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 2 { return "Account_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 3 { return "Guest_" + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 4 { return "Temp_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 5 { return "NC_Resident_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 6 { return "Default_User_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 7 { return "Newbie_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 8 { return "Test_" + IntToString(RandRange(seed + 1, 1, 999)); }
        if i == 9 { return "Placeholder_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 10 { return "ID_" + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 11 { return "Citizen_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 12 { return "Profile_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 13 { return "Node_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 14 { return "Terminal_" + IntToString(RandRange(seed + 1, 1, 500)); }
        if i == 15 { return "Anon_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 16 { return "NC" + IntToString(RandRange(seed + 1, 100000, 999999)); }
        if i == 17 { return "Handle_Pending_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 18 { return "Unregistered_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 19 { return "Lurker_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 20 { return "Inactive_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 21 { return "Suspended_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 22 { return "Deleted_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 23 { return "Banned_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 24 { return "Recovered_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 25 { return "Flagged_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        if i == 26 { return "Archived_" + IntToString(RandRange(seed + 1, 1000, 9999)); }
        if i == 27 { return "Migrated_" + IntToString(RandRange(seed + 1, 100, 999)); }
        if i == 28 { return "Legacy_" + IntToString(RandRange(seed + 1, 10000, 99999)); }
        return "Unknown_" + IntToString(RandRange(seed + 1, 100000, 999999));
    }
}
