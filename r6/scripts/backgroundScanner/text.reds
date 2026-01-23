/*
* Defines all of the text strings to be used for the events in the mod.
*
* Usage:
* Each string requires at minimum a female-variant to be defined. If the string is not gender-neutral both a male and female string should be defined seperately.
*
* Tokens:
* Text strings support token replacement, which will be replaced by a randomized value in the character generation process. 
* Ex. Hired by the %corp% Corporation out of college.
*
* The available tokens are as follows: 
* %corp% - Picks a random corporation to insert into the string
* %eddies% - Picks a random dollar amount to insert into the string
* %year% - Picks a random year (date) to insert into the string
* %years% - Picks a random amount of years to insert into the string
* %young_age% - Picks a random age within childhood/teenage years
*/
public class Text {

    // Static Scanner Texts
    public static func SCANNER_BACKGROUND() -> String { return "Background"; }
    public static func SCANNER_CHILDHOOD() -> String { return "Early Life"; }
    public static func SCANNER_SIG_EVENTS() -> String { return "Significant Events"; }
    public static func SCANNER_FOOTER() -> String { return "© InfoComp 2077. All rights reserved."; }

    // Corpos
    public static func NIPPON_NETWORK() -> String { return "Nippon Network"; }
    public static func DIVERSE_MEDIA() -> String { return "Diverse Media Systems"; }
    public static func WORLD_NEWS() -> String { return "World News Service"; }
    public static func AKAROMI() -> String { return "Akaromi BioCorp"; }
    public static func CONAG() -> String { return "ConAg"; }
    public static func NN54() -> String { return "Network News 54"; }
    public static func PETROCHEM() -> String { return "Petrochem"; }
    public static func SOVOIL() -> String { return "SovOil"; }
    public static func ARASAKA() -> String { return "Arasaka"; }
    public static func KANG_TAO() -> String { return "Kang Tao"; }
    public static func Militech() -> String { return "Militech"; }
    public static func MITSU_SUGO() -> String { return "Mitsubishi-Sugo"; }
    public static func SEG_ATARI() -> String { return "SegAtari"; }
    public static func TDS() -> String { return "Tsunami Defense Systems"; }
    public static func AHI() -> String { return "Akari Heavy Industries"; }
    public static func EBM() -> String { return "Euro Business Machines"; }
    public static func IEC() -> String { return "IEC"; }
    public static func MICROTECH() -> String { return "Microtech"; }
    public static func ZETATECH() -> String { return "Zetatech"; }
    public static func ADREK_ROBO() -> String { return "Adrek Robotics"; }
    public static func AKAGI_SYS() -> String { return "Akagi Systems"; }
    public static func BAKU_CHIPMASTERS() -> String { return "Bakumatsu Chipmasters"; }
    public static func BIOTECHNICA() -> String { return "Biotechnica"; }
    public static func CYPHIRE() -> String { return "Cyphire Cyberware"; }
    public static func DAKAI() -> String { return "Dakai Soundsystems"; }
    public static func DYNALAR() -> String { return "Dynalar Technologies"; }
    public static func KENJIRI() -> String { return "Kenjiri Technology"; }
    public static func KIROSHI() -> String { return "Kiroshi Opticals"; }
    public static func TTI() -> String { return "Trauma Team International"; }
    public static func MAF() -> String { return "Merrill, Asukaga, & Finch"; }
    public static func TOYOTA() -> String { return "Toyota Motor"; }
    public static func FUYUTSUKI() -> String { return "Fuyutsuki Electronics"; }
    public static func ORBITAL_AIR() -> String { return "Orbital Air"; }
    public static func WORLDSAT() -> String { return "WorldSat Communications Network"; }
    public static func EUROBANK() -> String { return "EuroBank"; }
    public static func FUJIWARA() -> String { return "Fujiwara"; }
    public static func INFOCOMP() -> String { return "InfoComp"; }
    public static func BAKENEKO() -> String { return "Bakeneko"; }

    // Upbringing
    public static func LVG_MOT_FAT_F() -> String { return "Grew up with a loving mother and father. "; }
    public static func LVG_MOT_FAT_M() -> String { return ""; }

    public static func ADPT_LVG_HOM_F() -> String { return "Adopted into a loving home. "; }
    public static func ADPT_LVG_HOM_M() -> String { return ""; }

    public static func LVG_GPRNTS_F() -> String { return "Raised by her loving grandparents. "; }
    public static func LVG_GPRNTS_M() -> String { return "Raised by his loving grandparents. "; }

    public static func LVG_RLTIVS_F() -> String { return "Raised by a group of loving relatives. "; }
    public static func LVG_RLTIVS_M() -> String { return ""; }

    public static func TGT_NOMAD_F() -> String { return "Grew up in a tightly-knit Nomad pack. "; }
    public static func TGT_NOMAD_M() -> String { return ""; }

    public static func TGT_MGTOWR_F() -> String { return "Raised by a tightly-knit community in a Megatower. "; }
    public static func TGT_MGTOWR_M() -> String { return ""; }

    public static func ADPT_CRP_BRD_F() -> String { return "Adopted into a luxury corpo breeding program. "; } 
    public static func ADPT_CRP_BRD_M() -> String { return ""; } 

    public static func UNCR_PRNTS_F() -> String { return "Grew up with uncaring parents. "; }
    public static func UNCR_PRNTS_M() -> String { return ""; }

    public static func ORD_HOME_F() -> String { return "Grew up in an ordinary home. "; }
    public static func ORD_HOME_M() -> String { return ""; }

    public static func HLCPT_PRNTS_F() -> String { return "Grew up with helicopter parents. "; }
    public static func HLCPT_PRNTS_M() -> String { return ""; }

    public static func RGH_NOMAD_F() -> String { return "Raised in a rough Nomad pack. "; }
    public static func RGH_NOMAD_M() -> String { return ""; }

    public static func UNWLNG_GPRNTS_F() -> String { return "Unwillingly raised by her grandparents. "; }
    public static func UNWLNG_GPRNTS_M() -> String { return "Unwillingly raised by his grandparents. "; }

    public static func UNWLNG_RLTIVS_F() -> String { return "Unwillingly raised by her relatives. "; }
    public static func UNWLNG_RLTIVS_M() -> String { return "Unwillingly raised by his relatives. "; }

    public static func MDCRE_FOSTER_F() -> String { return "Raised in a series of mediocre foster homes. "; }
    public static func MDCRE_FOSTER_M() -> String { return ""; }

    public static func MDCRE_ORPHN_F() -> String { return "Raised in a mediocre orphanage until she came of age. "; }
    public static func MDCRE_ORPHN_M() -> String { return "Raised in a mediocre orphanage until he came of age. "; }

    public static func SNGL_MOT_F() -> String { return "Raised by a single mother. "; }
    public static func SNGL_MOT_M() -> String { return ""; }

    public static func SNGL_FAT_F() -> String { return "Raised by a single father. "; }
    public static func SNGL_FAT_M() -> String { return ""; }

    public static func BD_HD_PRNTS_F() -> String { return "Raised by absent BD-head parents. "; }
    public static func BD_HD_PRNTS_M() -> String { return ""; }

    public static func STRTS_NOPRNTS_F() -> String { return "Grew up on the street, never knew her parents. "; }
    public static func STRTS_NOPRNTS_M() -> String { return "Grew up on the street, never knew his parents. "; }

    public static func SLD_BY_PRNTS_F() -> String { return "Parents sold her for money. "; }
    public static func SLD_BY_PRNTS_M() -> String { return "Parents sold him for money. "; }

    public static func TRD_FOR_CHEM_F() -> String { return "Parents traded her for chems. "; }
    public static func TRD_FOR_CHEM_M() -> String { return "Parents traded him for chems. "; }

    public static func PRNTS_CRSH_F() -> String { return "Parents died in a car crash. "; }
    public static func PRNTS_CRSH_M() -> String { return ""; }

    public static func MOT_ANSA_F() -> String { return "Mother has amnesia and doesn't remember her. "; }
    public static func MOT_ANSA_M() -> String { return "Mother has amnesia and doesn't remember him. "; }

    public static func FAT_ANSA_F() -> String { return "Father has amnesia and doesn't remember her. "; }
    public static func FAT_ANSA_M() -> String { return "Father has amnesia and doesn't remember him. "; }

    public static func ABSV_FOSTER_F() -> String { return "Raised in a series of abusive foster homes. "; }
    public static func ABSV_FOSTER_M() -> String { return ""; }

    public static func TRB_ORPHN_F() -> String { return "Raised in a terrible orphanage until she came of age. "; }
    public static func TRB_ORPHN_M() -> String { return "Raised in a terrible orphanage until he came of age. "; }

    public static func ABON_CHILD_F() -> String { return "Abandoned as a child. "; }
    public static func ABON_CHILD_M() -> String { return ""; }

    public static func VLNT_MGTWR_F() -> String { return "Grew up in the dark corners of a violent megatower. "; }
    public static func VLNT_MGTWR_M() -> String { return ""; }

    public static func GRP_SCAVS_F() -> String { return "Raised by a group of scavengers. "; }
    public static func GRP_SCAVS_M() -> String { return ""; }

    public static func VTGRN_LAB_F() -> String { return "Was vatgrown in a lab and raised by scientists. "; }
    public static func VTGRN_LAB_M() -> String { return ""; }

    public static func RAISED_BY_AI_F() -> String { return "Raised by an artificial intelligence in a corpo research facility. "; }
    public static func RAISED_BY_AI_M() -> String { return ""; }

    public static func GENE_ALTER_F() -> String { return "Underwent genetic alterations during fetal development. "; }
    public static func GENE_ALTER_M() -> String { return ""; }

    public static func CONGT_DEFECT_F() -> String { return "Born in %year% with a congenital defect and was cryo-preserved until a cure was developed. "; }
    public static func CONGT_DEFECT_M() -> String { return ""; }

    public static func CORPO_DEBT_F() -> String { return "Born into corpo debt of millions of eddies. "; }
    public static func CORPO_DEBT_M() -> String { return ""; }

    public static func FAM_KLD_NCPD_F() -> String { return "Parents and extended family killed by NCPD. "; }
    public static func FAM_KLD_NCPD_M() -> String { return ""; }

    public static func PAT_GNG_WRFR_F() -> String { return "Parents killed in gang warfare. "; }
    public static func PAT_GNG_WRFR_M() -> String { return ""; }

    public static func PAT_AVRG_CTZN_F() -> String { return "Parents were average citizens. "; }
    public static func PAT_AVRG_CTZN_M() -> String { return ""; }

    public static func PAT_WLTH_CTZN_F() -> String { return "Parents became wealthy citizens. "; }
    public static func PAT_WLTH_CTZN_M() -> String { return ""; }

    public static func MOT_UNID_F() -> String { return "Mother unidentified. "; }
    public static func MOT_UNID_M() -> String { return ""; }

    public static func FAT_UNID_F() -> String { return "Father unidentified. "; }
    public static func FAT_UNID_M() -> String { return ""; }

    public static func MOT_KLD_NCPD_F() -> String { return "Mother killed by NCPD. "; }
    public static func MOT_KLD_NCPD_M() -> String { return ""; }

    public static func FAT_KLD_NCPD_F() -> String { return "Father killed by NCPD. "; }
    public static func FAT_KLD_NCPD_M() -> String { return ""; }

    public static func MOT_KLD_MXTC_F() -> String { return "Mother killed by Max-Tac. "; }
    public static func MOT_KLD_MXTC_M() -> String { return ""; }

    public static func FAT_KLD_MXTC_F() -> String { return "Father killed by Max-Tac. "; }
    public static func FAT_KLD_MXTC_M() -> String { return ""; }

    public static func MOT_POW_F() -> String { return "Mother is a prisoner of war. "; }
    public static func MOT_POW_M() -> String { return ""; }

    public static func FAT_POW_F() -> String { return "Father is a prisoner of war. "; }
    public static func FAT_POW_M() -> String { return ""; }

    public static func MOT_INCR_F() -> String { return "Mother is incarcerated. "; }
    public static func MOT_INCR_M() -> String { return ""; }

    public static func FAT_INCR_F() -> String { return "Father is incarcerated. "; }
    public static func FAT_INCR_M() -> String { return ""; }

    public static func MOT_DIE_NAT_F() -> String { return "Mother died of natural causes. "; }
    public static func MOT_DIE_NAT_M() -> String { return ""; }

    public static func FAT_DIE_NAT_F() -> String { return "Father died of natural causes. "; }
    public static func FAT_DIE_NAT_M() -> String { return ""; }

    public static func MOT_WRK_CRP_F() -> String { return "Mother worked for the %corp% Corporation. "; }
    public static func MOT_WRK_CRP_M() -> String { return ""; }

    public static func FAT_WRK_CRP_F() -> String { return "Father worked for the %corp% Corporation. "; }
    public static func FAT_WRK_CRP_M() -> String { return ""; }

    public static func MOT_MRD_CRP_F() -> String { return "Mother murdered by the %corp% Corporation. "; }
    public static func MOT_MRD_CRP_M() -> String { return ""; }

    public static func FAT_MRD_CRP_F() -> String { return "Father murdered by the %corp% Corporation. "; }
    public static func FAT_MRD_CRP_M() -> String { return ""; }

    public static func MOT_KLD_WAR_F() -> String { return "Mother killed in warfare. "; }
    public static func MOT_KLD_WAR_M() -> String { return ""; }

    public static func FAT_KLD_WAR_F() -> String { return "Father killed in warfare. "; }
    public static func FAT_KLD_WAR_M() -> String { return ""; }

    public static func MOT_DIED_ACC_F() -> String { return "Mother died in an accident. "; }
    public static func MOT_DIED_ACC_M() -> String { return ""; }

    public static func FAT_DIED_ACC_F() -> String { return "Father died in an accident. "; }
    public static func FAT_DIED_ACC_M() -> String { return ""; }

    public static func MOT_HIDING_F() -> String { return "Mother is in hiding. "; }
    public static func MOT_HIDING_M() -> String { return ""; }

    public static func FAT_HIDING_F() -> String { return "Father is in hiding. "; }
    public static func FAT_HIDING_M() -> String { return ""; }

    public static func MOT_MISSING_F() -> String { return "Mother is missing and presumed deceased. "; }
    public static func MOT_MISSING_M() -> String { return ""; }

    public static func FAT_MISSING_F() -> String { return "Father is missing and presumed deceased. "; }
    public static func FAT_MISSING_M() -> String { return ""; }

    // Home
    public static func LIVED_ALLEY_F() -> String { return "Lived in an alley. "; }
    public static func LIVED_ALLEY_M() -> String { return ""; }

    public static func LIVED_DMPSTR_F() -> String { return "Lived in a dumpster. "; }
    public static func LIVED_DMPSTR_M() -> String { return ""; }

    public static func LIVED_DRNPIPE_F() -> String { return "Lived in a drainpipe. "; }
    public static func LIVED_DRNPIPE_M() -> String { return ""; }

    public static func LIVED_GUTTR_F() -> String { return "Lived in a gutter. "; }
    public static func LIVED_GUTTR_M() -> String { return ""; }

    public static func LIVED_SEWER_F() -> String { return "Lived in a sewer. "; }
    public static func LIVED_SEWER_M() -> String { return ""; }

    public static func LIVED_ABN_CAR_F() -> String { return "Lived in an abandoned car. "; }
    public static func LIVED_ABN_CAR_M() -> String { return ""; }

    public static func LIVED_VAN_F() -> String { return "Lived in a van. "; }
    public static func LIVED_VAN_M() -> String { return ""; }

    public static func LIVED_BOX_F() -> String { return "Lived in a cardboard box. "; }
    public static func LIVED_BOX_M() -> String { return ""; }

    public static func LIVED_COMBAT_ZONE_F() -> String { return "Lived in the heart of the Combat Zone. "; }
    public static func LIVED_COMBAT_ZONE_M() -> String { return ""; }

    public static func LIVED_TENT_FRWY_F() -> String { return "Lived in a tent under the freeway. "; }
    public static func LIVED_TENT_FRWY_M() -> String { return ""; }

    public static func LIVED_UDR_BRIDGE_F() -> String { return "Lived under a bridge. "; }
    public static func LIVED_UDR_BRIDGE_M() -> String { return ""; }

    public static func LIVED_CHEM_DEN_F() -> String { return "Lived in a chem den. "; }
    public static func LIVED_CHEM_DEN_M() -> String { return ""; }

    public static func LIVED_TENT_WASTES_F() -> String { return "Lived in a tent in the wastes. "; }
    public static func LIVED_TENT_WASTES_M() -> String { return ""; }

    public static func LIVED_APT_MGTWR_F() -> String { return "Lived in an apartment in a megatower. "; }
    public static func LIVED_APT_MGTWR_M() -> String { return ""; }

    public static func LIVED_JNTR_MGTWR_F() -> String { return "Lived in a janitor's closet in a megatower. "; }
    public static func LIVED_JNTR_MGTWR_M() -> String { return ""; }

    public static func LIVED_APT_MGTWR_F() -> String { return "Lived in a multi-family home in Night City. "; }
    public static func LIVED_APT_MGTWR_M() -> String { return ""; }

    public static func LIVED_SHED_INDSTR_F() -> String { return "Lived in a shed in an industrial district. "; }
    public static func LIVED_SHED_INDSTR_M() -> String { return ""; }

    public static func LIVED_SHANTY_F() -> String { return "Lived in a favela shanty in Night City. "; }
    public static func LIVED_SHANTY_M() -> String { return ""; }

    public static func LIVED_CRAP_TWNHME_F() -> String { return "Lived in a crummy townhome apartment in Night City. "; }
    public static func LIVED_CRAP_TWNHME_M() -> String { return ""; }

    public static func LIVED_RANCHO_HOUSE_F() -> String { return "Lived in a run-down house in Rancho Coronado. "; }
    public static func LIVED_RANCHO_HOUSE_M() -> String { return ""; }

    public static func LIVED_SMLL_TOWN_F() -> String { return "Lived in a small town far from the city. "; }
    public static func LIVED_SMLL_TOWN_M() -> String { return ""; }

    public static func LIVED_DECAY_HOOD_F() -> String { return "Lived in a decaying, once upscale neighborhood. "; }
    public static func LIVED_DECAY_HOOD_M() -> String { return ""; }

    public static func LIVED_CRM_HOOD_F() -> String { return "Lived in a crime-ridden neighborhood in Night City. "; }
    public static func LIVED_CRM_HOOD_M() -> String { return ""; }

    public static func LIVED_ABV_LAUND_F() -> String { return "Lived above a laundromat in Night City. "; }
    public static func LIVED_ABV_LAUND_M() -> String { return ""; }

    public static func LIVED_ABV_BAR_F() -> String { return "Lived above a bar in Night City. "; }
    public static func LIVED_ABV_BAR_M() -> String { return ""; }

    public static func LIVED_MHOME_FRWY_F() -> String { return "Lived in a mobile home along the freeway. "; }
    public static func LIVED_MHOME_FRWY_M() -> String { return ""; }

    public static func LIVED_LUDDITE_F() -> String { return "Moved into a luddite commune. "; }
    public static func LIVED_LUDDITE_M() -> String { return ""; }

    public static func LIVED_NOMAD_PACK_F() -> String { return "Lived in a nomad pack moving from city to city. "; }
    public static func LIVED_NOMAD_PACK_M() -> String { return ""; }

    public static func LIVED_GNG_BANDIT_F() -> String { return "Lived among a gang of bandits. "; }
    public static func LIVED_GNG_BANDIT_M() -> String { return ""; }

    public static func LIVED_EUROPE_F() -> String { return "Lived in Europe. "; }
    public static func LIVED_EUROPE_M() -> String { return ""; }

    public static func LIVED_LXR_MGTWR_F() -> String { return "Lived in a luxury megatower. "; }
    public static func LIVED_LXR_MGTWR_M() -> String { return ""; }

    public static func LIVED_CRP_SBRB_F() -> String { return "Lived in a safe corpo suburbia. "; }
    public static func LIVED_CRP_SBRB_M() -> String { return ""; }

    public static func LIVED_CRP_ZONE_F() -> String { return "Lived in a defended corpo zone in Night City. "; }
    public static func LIVED_CRP_ZONE_M() -> String { return ""; }

    public static func LIVED_CRP_RSRCH_F() -> String { return "Lived in a corpo controlled research facility. "; }
    public static func LIVED_CRP_RSRCH_M() -> String { return ""; }

    public static func LIVED_CRP_FARM_F() -> String { return "Lived on a corpo controlled farm. "; }
    public static func LIVED_CRP_FARM_M() -> String { return ""; }

    public static func LIVED_CRP_PNTHSE_F() -> String { return "Lived in a corpo provided penthouse. "; }
    public static func LIVED_CRP_PNTHSE_M() -> String { return ""; }

    public static func LIVED_LXR_PNTHSE_F() -> String { return "Lived in a luxury penthouse. "; }
    public static func LIVED_LXR_PNTHSE_M() -> String { return ""; }

    public static func LIVED_MNSION_F() -> String { return "Lived in a mansion in Los Angeles. "; }
    public static func LIVED_MNSION_M() -> String { return ""; }

    public static func LIVED_NICE_TWNHME_F() -> String { return "Lived in a nice townhouse in Night City. "; }
    public static func LIVED_NICE_TWNHME_M() -> String { return ""; }

    public static func LIVED_RDS_CAR_F() -> String { return "Lived in a car on the roadside. "; }
    public static func LIVED_RDS_CAR_M() -> String { return ""; }

    public static func LIVED_RSRCH_FCLY_F() -> String { return "Lived in a classified research facility. "; }
    public static func LIVED_RSRCH_FCLY_M() -> String { return ""; }

    public static func LIVED_GTD_CRP_F() -> String { return "Lived in a gated %corp% Corporation compound. "; }
    public static func LIVED_GTD_CRP_M() -> String { return ""; }

    public static func LIVED_VILLAGE_F() -> String { return "Lived in a village far from the city. "; }
    public static func LIVED_VILLAGE_M() -> String { return ""; }

    public static func LIVED_SHACK_F() -> String { return "Lived in a tar-paper shack in the burning badlands far from the city. "; }
    public static func LIVED_SHACK_M() -> String { return ""; }

    // Childhood
    public static func JOINED_GANG_F() -> String { return "Joined a gang at an early age. "; }
    public static func JOINED_GANG_M() -> String { return ""; }

    public static func RAN_AWAY_F() -> String { return "Ran away from home. "; }
    public static func RAN_AWAY_M() -> String { return ""; }

    public static func KIDNPPD_SCAVS_F() -> String { return "Was kidnapped by Scavvers. "; }
    public static func KIDNPPD_SCAVS_M() -> String { return ""; }

    public static func USNG_CHEMS_F() -> String { return "Started using chems at ten years old. "; }
    public static func USNG_CHEMS_M() -> String { return ""; }

    public static func BULLIED_RLNTLSLY_F() -> String { return "Was bullied relentlessly. "; }
    public static func BULLIED_RLNTLSLY_M() -> String { return ""; }

    public static func STOLE_CAR_F() -> String { return "Stole a car at thirteen years old. "; }
    public static func STOLE_CAR_M() -> String { return ""; }

    public static func SELLING_CHEMS_F() -> String { return "Started selling chems for a local gang. "; }
    public static func SELLING_CHEMS_M() -> String { return ""; }

    public static func JOINED_BAND_F() -> String { return "Joined a band. "; }
    public static func JOINED_BAND_M() -> String { return ""; }

    public static func AVERAGE_ATHLETE_F() -> String { return "Was an average athlete on a sports team. "; }
    public static func AVERAGE_ATHLETE_M() -> String { return ""; }

    public static func BAD_ATHLETE_F() -> String { return "Was a terrible athlete on a sports team. "; }
    public static func BAD_ATHLETE_M() -> String { return ""; }

    public static func GOOD_ATHLETE_F() -> String { return "Was an exceptional athlete on a sports team. "; }
    public static func GOOD_ATHLETE_M() -> String { return ""; }

    public static func SPNT_TIME_NET_F() -> String { return "Spent most of her time on the net. "; }
    public static func SPNT_TIME_NET_M() -> String { return "Spent most of his time on the net. "; }

    public static func TINKER_ELTRNICS_F() -> String { return "Began tinkering with electronics. "; }
    public static func TINKER_ELTRNICS_M() -> String { return ""; }

    public static func RADICALIZED_F() -> String { return "Was radicalized by extremists on the net. "; }
    public static func RADICALIZED_M() -> String { return ""; }

    public static func INTRST_IN_GUNS_F() -> String { return "Developed an interest in guns. "; }
    public static func INTRST_IN_GUNS_M() -> String { return ""; }

    public static func INTRST_IN_SWORDS_F() -> String { return "Developed an interest in swords. "; }
    public static func INTRST_IN_SWORDS_M() -> String { return ""; }

    public static func INTRST_IN_CYBER_F() -> String { return "Developed an interest in cybernetics. "; }
    public static func INTRST_IN_CYBER_M() -> String { return ""; }

    public static func ANTI_CORPO_FRM_F() -> String { return "Joined an anti-corpo Net forum. "; }
    public static func ANTI_CORPO_FRM_M() -> String { return ""; }

    public static func HACK_SM_DB_F() -> String { return "Hacked into a small corpo database. "; }
    public static func HACK_SM_DB_M() -> String { return ""; }

    public static func HACK_LG_DB_F() -> String { return "Hacked into a large corpo database. "; }
    public static func HACK_LG_DB_M() -> String { return ""; }

    public static func HACK_ICONIC_CORPO_F() -> String { return "Hacked into a %corp%'s database and retrieved confidential data. "; }
    public static func HACK_ICONIC_CORPO_M() -> String { return ""; }

    public static func READ_CLASSIC_LIT_F() -> String { return "Began reading classic literature. "; }
    public static func READ_CLASSIC_LIT_M() -> String { return ""; }

    public static func READ_NGHTY_MAG_F() -> String { return "Began reading naughty magazines. "; }
    public static func READ_NGHTY_MAG_M() -> String { return ""; }

    public static func READ_PULP_SCI_F() -> String { return "Began reading pulpy sci-fi books. "; }
    public static func READ_PULP_SCI_M() -> String { return ""; }
    
    public static func SCROLLING_BD_F() -> String { return "Started scrolling BD's for fun. "; }
    public static func SCROLLING_BD_M() -> String { return ""; }
    
    public static func WATCH_BD_F() -> String { return "Spent all her time watching BD's. "; }
    public static func WATCH_BD_M() -> String { return "Spent all his time watching BD's. "; }
    
    public static func MANDARIN_LSSN_F() -> String { return "Attended Mandarin lessons. "; }
    public static func MANDARIN_LSSN_M() -> String { return ""; }
    
    public static func SPANISH_LSSN_F() -> String { return "Attended Spanish lessons. "; }
    public static func SPANISH_LSSN_M() -> String { return ""; }
    
    public static func CHILD_PRODIGY_F() -> String { return "Was a child prodigy in school. "; }
    public static func CHILD_PRODIGY_M() -> String { return ""; }

    public static func PLAY_GUITAR_F() -> String { return "Began playing the guitar. "; }
    public static func PLAY_GUITAR_M() -> String { return ""; }

    public static func PLAY_VIOLIN_F() -> String { return "Began playing the violin. "; }
    public static func PLAY_VIOLIN_M() -> String { return ""; }

    public static func CHILD_SPY_F() -> String { return "Hired by a corpo to act as a child spy. "; }
    public static func CHILD_SPY_M() -> String { return ""; }

    public static func NET_RUN_IMPLANTS_F() -> String { return "Had black market netrunning implants installed. "; }
    public static func NET_RUN_IMPLANTS_M() -> String { return ""; }

    public static func FIRST_CW_F() -> String { return "Installed her first cyberware at %young_age% years old. "; }
    public static func FIRST_CW_M() -> String { return "Installed his first cyberware at %young_age% years old. "; }

    public static func CYBERDECK_INST_F() -> String { return "Had a cyberdeck installed at %young_age% years old. "; }
    public static func CYBERDECK_INST_M() -> String { return ""; }

    public static func TINKER_CAR_F() -> String { return "Began tinkering with cars. "; }
    public static func TINKER_CAR_M() -> String { return ""; }

    public static func TALENT_ART_F() -> String { return "Had a talent for art. "; }
    public static func TALENT_ART_M() -> String { return ""; }

    public static func PICK_POCKETS_F() -> String { return "Began picking pockets on the street. "; }
    public static func PICK_POCKETS_M() -> String { return ""; }

    public static func SOLD_CIG_F() -> String { return "Sold knockoff cigs to older kids. "; }
    public static func SOLD_CIG_M() -> String { return ""; }

    public static func SPACE_CMP_F() -> String { return "Went to space camp. "; }
    public static func SPACE_CMP_M() -> String { return ""; }

    public static func FIXER_COURIER_F() -> String { return "Served as a courier for a local fixer. "; }
    public static func FIXER_COURIER_M() -> String { return ""; }

    public static func CHILD_ADV_F() -> String { return "Ran far from home on an adventure. "; }
    public static func CHILD_ADV_M() -> String { return ""; }

    public static func INTRST_BOTANY_F() -> String { return "Took an interest in plants. "; }
    public static func INTRST_BOTANY_M() -> String { return ""; }

    public static func HMEBRW_BEER_F() -> String { return "Learned how to homebrew beer. "; }
    public static func HMEBRW_BEER_M() -> String { return ""; }

    public static func SYNTH_CHEMS_F() -> String { return "Learned how to synthesize chems at home. "; }
    public static func SYNTH_CHEMS_M() -> String { return ""; }

    public static func CHEM_MULE_F() -> String { return "Served as a chem mule for a local gang. "; }
    public static func CHEM_MULE_M() -> String { return ""; }

    public static func WORK_SWTSHOP_F() -> String { return "Worked in an illegal sweatshop. "; }
    public static func WORK_SWTSHOP_M() -> String { return ""; }

    public static func WORK_FRMHAND_F() -> String { return "Worked as a farmhand outside of Night City. "; }
    public static func WORK_FRMHAND_M() -> String { return ""; }

    public static func EXPLR_SEWER_F() -> String { return "Explored and mapped the sewers of Night City. "; }
    public static func EXPLR_SEWER_M() -> String { return ""; }

    public static func BRK_CORPO_SYSTEM_F() -> String { return "Installed a cyberdeck as a youth and began breaking into corporate systems. "; }
    public static func BRK_CORPO_SYSTEM_M() -> String { return ""; }

    public static func RBLD_SCRP_CAR_F() -> String { return "Began rebuilding scrapped cars. "; }
    public static func RBLD_SCRP_CAR_M() -> String { return ""; }

    public static func SCVG_STRP_CAR_F() -> String { return "Began scavenging and stripping cars for parts. "; }
    public static func SCVG_STRP_CAR_M() -> String { return ""; }

    public static func PLAY_MUS_INST_F() -> String { return "Began playing a musical instrument. "; }
    public static func PLAY_MUS_INST_M() -> String { return ""; }

    public static func VNDL_PUB_PRPTY_F() -> String { return "Vandalized public property. "; }
    public static func VNDL_PUB_PRPTY_M() -> String { return ""; }

    public static func CDG_HKS_NET_F() -> String { return "Began coding hacks on the net. "; }
    public static func CDG_HKS_NET_M() -> String { return ""; }

    public static func HACK_CRP_STL_F() -> String { return "Hacked a %corp% Corporation access point, stealing €$%eddies% Eurodollars. "; }
    public static func HACK_CRP_STL_M() -> String { return ""; }

    public static func SPENT_NO_SUPV_F() -> String { return "Spent time on the streets with no adult supervision. "; }
    public static func SPENT_NO_SUPV_M() -> String { return ""; }

    // First Job
    public static func JOB_LOCAL_FIXER_F() -> String { return "Started doing jobs for a local fixer. "; }
    public static func JOB_LOCAL_FIXER_M() -> String { return ""; }

    public static func JOB_WAGE_BODEGA_F() -> String { return "Started working as a wageslave for a bodega. "; }
    public static func JOB_WAGE_BODEGA_M() -> String { return ""; }

    public static func JOB_WAGE_DEPT_F() -> String { return "Started working as a department store wageslave. "; }
    public static func JOB_WAGE_DEPT_M() -> String { return ""; }

    public static func JOB_BOUNCER_F() -> String { return "Got a job as a bouncer at a nightclub. "; }
    public static func JOB_BOUNCER_M() -> String { return ""; }

    public static func JOB_HOMELESS_F() -> String { return "Began begging for money in the street. "; }
    public static func JOB_HOMELESS_M() -> String { return ""; }

    public static func JOB_WAGE_GAS_F() -> String { return "Started working as a gas station wageslave. "; }
    public static func JOB_WAGE_GAS_M() -> String { return ""; }

    public static func JOB_ROB_APT_F() -> String { return "Started robbing apartments for cash. "; }
    public static func JOB_ROB_APT_M() -> String { return ""; }

    public static func JOB_JOYTOY_CHEAP_F() -> String { return "Started working as a Joytoy on Jig Jig Street. "; }
    public static func JOB_JOYTOY_CHEAP_M() -> String { return ""; }

    public static func JOB_JOYTOY_EXP_F() -> String { return "Started working as a high-end Joytoy for corpo executives. "; }
    public static func JOB_JOYTOY_EXP_M() -> String { return ""; }

    public static func JOB_SECURITY_F() -> String { return "Started working as Security for %corp%. "; }
    public static func JOB_SECURITY_M() -> String { return ""; }

    public static func JOB_RECEPTION_F() -> String { return "Started working as a receptionist for %corp%. "; }
    public static func JOB_RECEPTION_M() -> String { return ""; }

    public static func JOB_DESK_JOCKEY_F() -> String { return "Started working as a desk jockey for %corp%. "; }
    public static func JOB_DESK_JOCKEY_M() -> String { return ""; }

    public static func JOB_WAGESLAVE_F() -> String { return "Started working as a wageslave for %corp%. "; }
    public static func JOB_WAGESLAVE_M() -> String { return ""; }

    public static func JOB_CORPO_MANAGER_F() -> String { return "Got a position working as a corporate manager for %corp%. "; }
    public static func JOB_CORPO_MANAGER_M() -> String { return ""; }

    public static func JOB_CORPO_EXEC_F() -> String { return "Got a position working as a corporate executive for %corp%. "; }
    public static func JOB_CORPO_EXEC_M() -> String { return ""; }

    public static func JOB_DAY_LABOR_F() -> String { return "Started working as a temporary day laborer. "; }
    public static func JOB_DAY_LABOR_M() -> String { return ""; }

    public static func JOB_FOOD_VNDR_F() -> String { return "Started working as a wageslave for a street food vendor. "; }
    public static func JOB_FOOD_VNDR_M() -> String { return ""; }

    public static func JOB_SEX_TRADER_F() -> String { return "Began trading sex for money in the street. "; }
    public static func JOB_SEX_TRADER_M() -> String { return ""; }

    public static func JOB_JOYTOY_BURAN_F() -> String { return "Started working as a Joytoy on Buran Street. "; }
    public static func JOB_JOYTOY_BURAN_M() -> String { return ""; }

    public static func JOB_KIDNAP_CRP_F() -> String { return "Started coordinating kidnapping and ransom transfers for the %corp% Corporation. "; }
    public static func JOB_KIDNAP_CRP_M() -> String { return ""; }

    public static func JOB_DRUG_CRP_F() -> String { return "Started working at a designer drug chemlab for the %corp% Corporation. "; }
    public static func JOB_DRUG_CRP_M() -> String { return ""; }

    public static func JOB_SPORT_CRP_F() -> String { return "Started playing professional sports for a team owned by the %corp% Corporation. "; }
    public static func JOB_SPORT_CRP_M() -> String { return ""; }

    public static func JOB_SWORD_F() -> String { return "Started work as a swordsmith for the %corp% Corporation. "; }
    public static func JOB_SWORD_M() -> String { return ""; }

    public static func JOB_GUNS_F() -> String { return "Started work as a gunsmith for the %corp% Corporation. "; }
    public static func JOB_GUNS_M() -> String { return ""; }

    public static func JOB_DELIVER_F() -> String { return "Started work as a delivery driver for vending machines. "; }
    public static func JOB_DELIVER_M() -> String { return ""; }

    public static func JOB_SPY_CRP_F() -> String { return "Started working in espionage for the %corp% Corporation. "; }
    public static func JOB_SPY_CRP_M() -> String { return ""; }

    public static func JOB_TEACHER_F() -> String { return "Started teaching schoolchildren. "; }
    public static func JOB_TEACHER_M() -> String { return ""; }

    public static func JOB_DOC_ASSIST_F() -> String { return "Started a job assisting a Ripperdoc in cyberware installations. "; }
    public static func JOB_DOC_ASSIST_M() -> String { return ""; }

    public static func JOB_BARTEND_F() -> String { return "Started work tending bar. "; }
    public static func JOB_BARTEND_M() -> String { return ""; }

    public static func JOB_BOOTLEGGER_F() -> String { return "Started working as a whiskey bootlegger for nomads. "; }
    public static func JOB_BOOTLEGGER_M() -> String { return ""; }

    public static func JOB_DRUG_RUNNER_F() -> String { return "Started working as a drug runner for nomads. "; }
    public static func JOB_DRUG_RUNNER_M() -> String { return ""; }

    public static func JOB_ARMS_DEALER_F() -> String { return "Started working as an arms dealer for nomads. "; }
    public static func JOB_ARMS_DEALER_M() -> String { return ""; }

    public static func JOB_SWEAT_CRP_F() -> String { return "Started working as a sweat shop overseer for the %corp% Corporation. "; }
    public static func JOB_SWEAT_CRP_M() -> String { return ""; }

    public static func JOB_CYBER_CRP_F() -> String { return "Started assembling cyberware for the %corp% Corporation. "; }
    public static func JOB_CYBER_CRP_M() -> String { return ""; }

    public static func JOB_MAG_STAND_F() -> String { return "Started working at a magazine stand. "; }
    public static func JOB_MAG_STAND_M() -> String { return ""; }

    public static func JOB_BD_CRP_F() -> String { return "Started working in Braindance productions for the %corp% Corporation. "; }
    public static func JOB_BD_CRP_M() -> String { return ""; }

    // Adulthood
    public static func LOST_GAMBLE_F() -> String { return "Lost €$%eddies% Eurodollars gambling. "; }
    public static func LOST_GAMBLE_M() -> String { return ""; }

    public static func INST_NEW_AUG_F() -> String { return "Installed a new cybernetic augmentation. "; }
    public static func INST_NEW_AUG_M() -> String { return ""; }

    public static func RADIO_JOCKEY_F() -> String { return "Moonlighted as a radio jockey. "; }
    public static func RADIO_JOCKEY_M() -> String { return ""; }

    public static func CAR_ACCIDENT_F() -> String { return "Was in a car accident. "; }
    public static func CAR_ACCIDENT_M() -> String { return ""; }

    public static func BCME_CHEMHEAD_F() -> String { return "Became a chemhead. "; }
    public static func BCME_CHEMHEAD_M() -> String { return ""; }

    public static func IMPRISONED_F() -> String { return "Was imprisoned for %years% years. "; }
    public static func IMPRISONED_M() -> String { return ""; }

    public static func STOLE_EQP_F() -> String { return "Stole some high-tech equipment from %corp%. "; }
    public static func STOLE_EQP_M() -> String { return ""; }

    public static func ROB_BODEGA_F() -> String { return "Was involved in a robbery at a bodega. "; }
    public static func ROB_BODEGA_M() -> String { return ""; }

    public static func JOIN_NEW_BAND_F() -> String { return "Joined a new band. "; }
    public static func JOIN_NEW_BAND_M() -> String { return ""; }

    public static func COMPLETED_JOB_F() -> String { return "Completed a job for a fixer and received a €$%eddies% payout. "; }
    public static func COMPLETED_JOB_M() -> String { return ""; }

    public static func RUN_CHEMS_F() -> String { return "Began running chems for a local gang. "; }
    public static func RUN_CHEMS_M() -> String { return ""; }

    public static func WON_LOTTERY_F() -> String { return "Won a scratch-off. "; }
    public static func WON_LOTTERY_M() -> String { return ""; }

    public static func BOUGHT_CAR_F() -> String { return "Bought a car. "; }
    public static func BOUGHT_CAR_M() -> String { return ""; }

    public static func NEW_APT_F() -> String { return "Moved into a new apartment. "; }
    public static func NEW_APT_M() -> String { return ""; }

    public static func BOUGHT_GUN_F() -> String { return "Bought a firearm. "; }
    public static func BOUGHT_GUN_M() -> String { return ""; }

    public static func BOUGHT_SWORD_F() -> String { return "Bought a sword. "; }
    public static func BOUGHT_SWORD_M() -> String { return ""; }

    public static func JOINED_RIOT_F() -> String { return "Was involved in a riot. "; }
    public static func JOINED_RIOT_M() -> String { return ""; }

    public static func KILLED_CHOOM_F() -> String { return "Killed an unlucky choom. "; }
    public static func KILLED_CHOOM_M() -> String { return ""; }

    public static func LOST_JOB_F() -> String { return "Lost her job. "; }
    public static func LOST_JOB_M() -> String { return "Lost his job. "; }

    public static func INDUSTRIAL_ACC_F() -> String { return "Was in an industrial accident. "; }
    public static func INDUSTRIAL_ACC_M() -> String { return ""; }

    public static func CODED_BOTNETS_F() -> String { return "Coded synchronized botnets to attack the %corp% Corporation access points, stealing €$%eddies% Eurodollars. "; }
    public static func CODED_BOTNETS_M() -> String { return ""; }

    public static func ROB_VENDOR_F() -> String { return "Was involved in a robbery at a street food vendor. "; }
    public static func ROB_VENDOR_M() -> String { return ""; }

    public static func TOB_CONSUMER_F() -> String { return "Tobacco consumer. "; }
    public static func TOB_CONSUMER_M() -> String { return ""; }

    public static func AL_BEV_CONSUMER_F() -> String { return "Alcoholic beverage consumer. "; }
    public static func AL_BEV_CONSUMER_M() -> String { return ""; }

    public static func WATER_CONSUMER_F() -> String { return "Real Water subscriber. "; }
    public static func WATER_CONSUMER_M() -> String { return ""; }

    public static func JOYTOY_CONSUMER_F() -> String { return "Joytoy customer. "; }
    public static func JOYTOY_CONSUMER_M() -> String { return ""; }

    public static func BD_CONSUMER_F() -> String { return "Braindance customer. "; }
    public static func BD_CONSUMER_M() -> String { return ""; }

    public static func BD_ADDICT_F() -> String { return "Braindance addict. "; }
    public static func BD_ADDICT_M() -> String { return ""; }

    public static func RELIC_ASPIRANT_F() -> String { return "Relic aspirant. "; }
    public static func RELIC_ASPIRANT_M() -> String { return ""; }

    public static func BOUGHT_SHARD_F() -> String { return "Bought a shard. "; }
    public static func BOUGHT_SHARD_M() -> String { return ""; }

    public static func BOUGHT_CYBER_F() -> String { return "Bought cybernetics. "; }
    public static func BOUGHT_CYBER_M() -> String { return ""; }

    public static func TWO_AM_CLUB_F() -> String { return "2nd Amendment club member. "; }
    public static func TWO_AM_CLUB_M() -> String { return ""; }

    public static func ROBOT_DEST_F() -> String { return "Was involved in the destruction of one Arasaka Robot R MK.2. "; }
    public static func ROBOT_DEST_M() -> String { return ""; }

    public static func CANCEL_TTI_F() -> String { return "Canceled her Trauma Team Insurance. "; }
    public static func CANCEL_TTI_M() -> String { return "Canceled his Trauma Team Insurance. "; }

    public static func FILED_FRD_INS_F() -> String { return "Filed a fraudulent insurance claim. "; }
    public static func FILED_FRD_INS_M() -> String { return ""; }

    public static func ASST_SZD_CRP_F() -> String { return "All assets were seized by the %corp% Corporation. "; }
    public static func ASST_SZD_CRP_M() -> String { return ""; }

    public static func CHRG_BK_DBTR_F() -> String { return "Charged as a bankrupt debtor. "; }
    public static func CHRG_BK_DBTR_M() -> String { return ""; }

    public static func CHRG_MED_DBT_F() -> String { return "Charged as a medical debtor. "; }
    public static func CHRG_MED_DBT_M() -> String { return ""; }

    public static func INDEBT_CRP_INDVL_F() -> String { return "Indebted to the %corp% Corporation. Individual reassigned as a corporate asset. "; }
    public static func INDEBT_CRP_INDVL_M() -> String { return ""; }

    public static func CRP_LBLTY_DFDT_F() -> String { return "Charged as a corporate liability defendant. "; }
    public static func CRP_LBLTY_DFDT_M() -> String { return ""; }

    public static func CRP_POL_VIO_F() -> String { return "Charged as a corporate policies violator. "; }
    public static func CRP_POL_VIO_M() -> String { return ""; }

    public static func HAB_CRP_DBTR_F() -> String { return "Charged as a habitual corporate debtor. "; }
    public static func HAB_CRP_DBTR_M() -> String { return ""; }

    public static func ARMED_DANGER_F() -> String { return "Notoriously armed and dangerous. "; }
    public static func ARMED_DANGER_M() -> String { return ""; }

    public static func FLSLY_ACC_MRDR_F() -> String { return "Was falsely accused of murder and imprisoned for %years% horrifying years. "; }
    public static func FLSLY_ACC_MRDR_M() -> String { return ""; }

    public static func FREE_CRP_MRDR_F() -> String { return "Was accused of corporate-sanctioned murders with video evidence, but charges were dismissed on technicalities. "; }
    public static func FREE_CRP_MRDR_M() -> String { return ""; }

    public static func VAC_AFRICA_F() -> String { return "Vacationed in sunny Africa. "; }
    public static func VAC_AFRICA_M() -> String { return ""; }

    public static func JUMP_TRAFFIC_F() -> String { return "Jumps into traffic daily at heights and crosswalks. "; }
    public static func JUMP_TRAFFIC_M() -> String { return ""; }

    public static func BUILD_BOMB_F() -> String { return "Meets with known terrorists, while building a dirty bomb with scavenged ordinance and electronics. "; }
    public static func BUILD_BOMB_M() -> String { return ""; }

    public static func EMAIL_GOV_F() -> String { return "Composes hopeless policy emails to government officials. Deletes her eloquent manifesto in despair without sending. InfoComp retains backup copies."; }
    public static func EMAIL_GOV_M() -> String { return "Composes hopeless policy emails to government officials. Deletes his eloquent manifesto in despair without sending. InfoComp retains backup copies. "; }

    public static func FREE_TTI_F() -> String { return "Signed up as a human guinea pig receiving injections in stem cell chimera trials. Earned a voucher for one free month of Trauma Team Premium. "; }
    public static func FREE_TTI_M() -> String { return ""; }

}
