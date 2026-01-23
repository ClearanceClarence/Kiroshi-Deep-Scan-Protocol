public class CrowdScannerEvents {

    // Upbringing
    public static func LVG_MOT_FAT() -> ref<LifePathEvent> { return LPE(Text.LVG_MOT_FAT_F(), Text.LVG_MOT_FAT_M()).SetWealthMod(10).SetIntMod(10).SetCoolMod(10); }
    public static func ADPT_LVG_HOM() -> ref<LifePathEvent> { return LPE(Text.ADPT_LVG_HOM_F(), Text.ADPT_LVG_HOM_M()).SetIntMod(10).SetWealthMod(10).SetCoolMod(5); }
    public static func LVG_GPRNTS() -> ref<LifePathEvent> { return LPE(Text.LVG_GPRNTS_F(), Text.LVG_GPRNTS_M()).SetIntMod(10).SetWealthMod(15).SetCoolMod(5); }
    public static func LVG_RLTIVS() -> ref<LifePathEvent> { return LPE(Text.LVG_RLTIVS_F(), Text.LVG_RLTIVS_M()).SetIntMod(10).SetWealthMod(5); }
    public static func TGT_NOMAD() -> ref<LifePathEvent> { return LPE(Text.TGT_NOMAD_F(), Text.TGT_NOMAD_M()).SetBodyMod(10).SetTechMod(20); }
    public static func TGT_MGTOWR() -> ref<LifePathEvent> { return LPE(Text.TGT_MGTOWR_F(), Text.TGT_MGTOWR_M()).SetReflexMod(10).SetBodyMod(10); }
    public static func ADPT_CRP_BRD() -> ref<LifePathEvent> { return LPE(Text.ADPT_CRP_BRD_F(), Text.ADPT_CRP_BRD_M()).SetIntMod(20).SetWealthMod(20).SetCoolMod(20); }
    public static func UNCR_PRNTS() -> ref<LifePathEvent> { return LPE(Text.UNCR_PRNTS_F(), Text.UNCR_PRNTS_M()).SetIntMod(5).SetWealthMod(10); }
    public static func ORD_HOME() -> ref<LifePathEvent> { return LPE(Text.ORD_HOME_F(), Text.ORD_HOME_M()).SetIntMod(5).SetWealthMod(5); }
    public static func HLCPT_PRNTS() -> ref<LifePathEvent> { return LPE(Text.HLCPT_PRNTS_F(), Text.HLCPT_PRNTS_M()).SetIntMod(15).SetWealthMod(10); }
    public static func RGH_NOMAD() -> ref<LifePathEvent> { return LPE(Text.RGH_NOMAD_F(), Text.RGH_NOMAD_M()).SetBodyMod(20).SetTechMod(10); }
    public static func UNWLNG_GPRNTS() -> ref<LifePathEvent> { return LPE(Text.UNWLNG_GPRNTS_F(), Text.UNWLNG_GPRNTS_M()).SetIntMod(5).SetWealthMod(15); }
    public static func UNWLNG_RLTIVS() -> ref<LifePathEvent> { return LPE(Text.UNWLNG_RLTIVS_F(), Text.UNWLNG_RLTIVS_M()).SetIntMod(5).SetWealthMod(5); }
    public static func MDCRE_FOSTER() -> ref<LifePathEvent> { return LPE(Text.MDCRE_FOSTER_F(), Text.MDCRE_FOSTER_M()).SetIntMod(5).SetReflexMod(5); }
    public static func MDCRE_ORPHN() -> ref<LifePathEvent> { return LPE(Text.MDCRE_ORPHN_F(), Text.MDCRE_ORPHN_M()).SetIntMod(5).SetReflexMod(5).SetBodyMod(5); }
    public static func SNGL_MOT() -> ref<LifePathEvent> { return LPE(Text.SNGL_MOT_F(), Text.SNGL_MOT_M()).SetReflexMod(5).SetWealthMod(5); }
    public static func SNGL_FAT() -> ref<LifePathEvent> { return LPE(Text.SNGL_FAT_F(), Text.SNGL_FAT_M()).SetBodyMod(5).SetWealthMod(5); }
    public static func BD_HD_PRNTS() -> ref<LifePathEvent> { return LPE(Text.BD_HD_PRNTS_F(), Text.BD_HD_PRNTS_M()).SetTechMod(10).SetWealthMod(5); }
    public static func STRTS_NOPRNTS() -> ref<LifePathEvent> { return LPE(Text.STRTS_NOPRNTS_F(), Text.STRTS_NOPRNTS_M()).SetReflexMod(10); }
    public static func SLD_BY_PRNTS() -> ref<LifePathEvent> { return LPE(Text.SLD_BY_PRNTS_F(), Text.SLD_BY_PRNTS_M()).SetReflexMod(5); }
    public static func TRD_FOR_CHEM() -> ref<LifePathEvent> { return LPE(Text.TRD_FOR_CHEM_F(), Text.TRD_FOR_CHEM_M()).SetBodyMod(5); }
    public static func PRNTS_CRSH() -> ref<LifePathEvent> { return LPE(Text.PRNTS_CRSH_F(), Text.PRNTS_CRSH_M()).SetCoolMod(5); }
    public static func MOT_ANSA() -> ref<LifePathEvent> { return LPE(Text.MOT_ANSA_F(), Text.MOT_ANSA_M()).SetBodyMod(5).SetWealthMod(5); }
    public static func FAT_ANSA() -> ref<LifePathEvent> { return LPE(Text.FAT_ANSA_F(), Text.FAT_ANSA_M()).SetReflexMod(5).SetWealthMod(5); }
    public static func ABSV_FOSTER() -> ref<LifePathEvent> { return LPE(Text.ABSV_FOSTER_F(), Text.ABSV_FOSTER_M()).SetBodyMod(5); }
    public static func TRB_ORPHN() -> ref<LifePathEvent> { return LPE(Text.TRB_ORPHN_F(), Text.TRB_ORPHN_M()).SetReflexMod(5); }
    public static func ABON_CHILD() -> ref<LifePathEvent> { return LPE(Text.ABON_CHILD_F(), Text.ABON_CHILD_M()); }
    public static func VLNT_MGTWR() -> ref<LifePathEvent> { return LPE(Text.VLNT_MGTWR_F(), Text.VLNT_MGTWR_M()).SetReflexMod(5).SetCoolMod(5); }
    public static func GRP_SCAVS() -> ref<LifePathEvent> { return LPE(Text.GRP_SCAVS_F(), Text.GRP_SCAVS_M()).SetTechMod(5); }
    public static func VTGRN_LAB() -> ref<LifePathEvent> { return LPE(Text.VTGRN_LAB_F(), Text.VTGRN_LAB_F()).SetBodyMod(20).SetReflexMod(20); }
    public static func RAISED_BY_AI() -> ref<LifePathEvent> { return LPE(Text.RAISED_BY_AI_F(), Text.RAISED_BY_AI_M()).SetIntMod(20).SetTechMod(20); }
    public static func GENE_ALTER() -> ref<LifePathEvent> { return LPE(Text.GENE_ALTER_F(), Text.GENE_ALTER_M()).SetBodyMod(20).SetCoolMod(20); }
    public static func CONGT_DEFECT() -> ref<LifePathEvent> { return LPE(Text.CONGT_DEFECT_F(), Text.CONGT_DEFECT_M()); }
    public static func CORPO_DEBT() -> ref<LifePathEvent> { return LPE(Text.CORPO_DEBT_F(), Text.CORPO_DEBT_M()); }
    public static func FAM_KLD_NCPD() -> ref<LifePathEvent> { return LPE(Text.FAM_KLD_NCPD_F(), Text.FAM_KLD_NCPD_M()); }
    public static func PAT_GNG_WRFR() -> ref<LifePathEvent> { return LPE(Text.PAT_GNG_WRFR_F(), Text.PAT_GNG_WRFR_M()); }
    public static func PAT_AVRG_CTZN() -> ref<LifePathEvent> { return LPE(Text.PAT_AVRG_CTZN_F(), Text.PAT_AVRG_CTZN_M()); }
    public static func PAT_WLTH_CTZN() -> ref<LifePathEvent> { return LPE(Text.PAT_WLTH_CTZN_F(), Text.PAT_WLTH_CTZN_M()); }
    public static func MOT_UNID() -> ref<LifePathEvent> { return LPE(Text.MOT_UNID_F(), Text.MOT_UNID_M()); }
    public static func FAT_UNID() -> ref<LifePathEvent> { return LPE(Text.FAT_UNID_F(), Text.FAT_UNID_M()); }
    public static func MOT_KLD_NCPD() -> ref<LifePathEvent> { return LPE(Text.MOT_KLD_NCPD_F(), Text.MOT_KLD_NCPD_M()); }
    public static func FAT_KLD_NCPD() -> ref<LifePathEvent> { return LPE(Text.FAT_KLD_NCPD_F(), Text.FAT_KLD_NCPD_M()); }
    public static func MOT_KLD_MXTC() -> ref<LifePathEvent> { return LPE(Text.MOT_KLD_MXTC_F(), Text.MOT_KLD_MXTC_M()); }
    public static func FAT_KLD_MXTC() -> ref<LifePathEvent> { return LPE(Text.FAT_KLD_MXTC_F(), Text.FAT_KLD_MXTC_M()); }
    public static func MOT_POW() -> ref<LifePathEvent> { return LPE(Text.MOT_POW_F(), Text.MOT_POW_M()); }
    public static func FAT_POW() -> ref<LifePathEvent> { return LPE(Text.FAT_POW_F(), Text.FAT_POW_M()); }
    public static func MOT_INCR() -> ref<LifePathEvent> { return LPE(Text.MOT_INCR_F(), Text.MOT_INCR_M()); }
    public static func FAT_INCR() -> ref<LifePathEvent> { return LPE(Text.FAT_INCR_F(), Text.FAT_INCR_M()); }
    public static func MOT_DIE_NAT() -> ref<LifePathEvent> { return LPE(Text.MOT_DIE_NAT_F(), Text.MOT_DIE_NAT_M()); }
    public static func FAT_DIE_NAT() -> ref<LifePathEvent> { return LPE(Text.FAT_DIE_NAT_F(), Text.FAT_DIE_NAT_M()); }
    public static func MOT_WRK_CRP() -> ref<LifePathEvent> { return LPE(Text.MOT_WRK_CRP_F(), Text.MOT_WRK_CRP_M()); }
    public static func FAT_WRK_CRP() -> ref<LifePathEvent> { return LPE(Text.FAT_WRK_CRP_F(), Text.FAT_WRK_CRP_M()); }
    public static func MOT_MRD_CRP() -> ref<LifePathEvent> { return LPE(Text.MOT_MRD_CRP_F(), Text.MOT_MRD_CRP_M()); }
    public static func FAT_MRD_CRP() -> ref<LifePathEvent> { return LPE(Text.FAT_MRD_CRP_F(), Text.FAT_MRD_CRP_M()); }
    public static func MOT_KLD_WAR() -> ref<LifePathEvent> { return LPE(Text.MOT_KLD_WAR_F(), Text.MOT_KLD_WAR_M()); }
    public static func FAT_KLD_WAR() -> ref<LifePathEvent> { return LPE(Text.FAT_KLD_WAR_F(), Text.FAT_KLD_WAR_M()); }
    public static func MOT_DIED_ACC() -> ref<LifePathEvent> { return LPE(Text.MOT_DIED_ACC_F(), Text.MOT_DIED_ACC_M()); }
    public static func FAT_DIED_ACC() -> ref<LifePathEvent> { return LPE(Text.FAT_DIED_ACC_F(), Text.FAT_DIED_ACC_M()); }
    public static func MOT_HIDING() -> ref<LifePathEvent> { return LPE(Text.MOT_HIDING_F(), Text.MOT_HIDING_M()); }
    public static func FAT_HIDING() -> ref<LifePathEvent> { return LPE(Text.FAT_HIDING_F(), Text.FAT_HIDING_M()); }
    public static func MOT_MISSING() -> ref<LifePathEvent> { return LPE(Text.MOT_MISSING_F(), Text.MOT_MISSING_M()); }
    public static func FAT_MISSING() -> ref<LifePathEvent> { return LPE(Text.FAT_MISSING_F(), Text.FAT_MISSING_M()); }

    // Home
    public static func LIVED_ALLEY() -> ref<LifePathEvent> { return LPE(Text.LIVED_ALLEY_F(), Text.LIVED_ALLEY_M()); }
    public static func LIVED_DMPSTR() -> ref<LifePathEvent> { return LPE(Text.LIVED_DMPSTR_F(), Text.LIVED_DMPSTR_M()); }
    public static func LIVED_DRNPIPE() -> ref<LifePathEvent> { return LPE(Text.LIVED_DRNPIPE_F(), Text.LIVED_DRNPIPE_M()); }
    public static func LIVED_GUTTR() -> ref<LifePathEvent> { return LPE(Text.LIVED_GUTTR_F(), Text.LIVED_GUTTR_M()); }
    public static func LIVED_SEWER() -> ref<LifePathEvent> { return LPE(Text.LIVED_SEWER_F(), Text.LIVED_SEWER_M()); }
    public static func LIVED_ABN_CAR() -> ref<LifePathEvent> { return LPE(Text.LIVED_ABN_CAR_F(), Text.LIVED_ABN_CAR_M()); }
    public static func LIVED_VAN() -> ref<LifePathEvent> { return LPE(Text.LIVED_VAN_F(), Text.LIVED_VAN_M()); }
    public static func LIVED_BOX() -> ref<LifePathEvent> { return LPE(Text.LIVED_BOX_F(), Text.LIVED_BOX_M()); }
    public static func LIVED_COMBAT_ZONE() -> ref<LifePathEvent> { return LPE(Text.LIVED_COMBAT_ZONE_F(), Text.LIVED_COMBAT_ZONE_M()); }
    public static func LIVED_TENT_FRWY() -> ref<LifePathEvent> { return LPE(Text.LIVED_TENT_FRWY_F(), Text.LIVED_TENT_FRWY_M()); }
    public static func LIVED_UDR_BRIDGE() -> ref<LifePathEvent> { return LPE(Text.LIVED_UDR_BRIDGE_F(), Text.LIVED_UDR_BRIDGE_M()); }
    public static func LIVED_CHEM_DEN() -> ref<LifePathEvent> { return LPE(Text.LIVED_CHEM_DEN_F(), Text.LIVED_CHEM_DEN_M()); }
    public static func LIVED_TENT_WASTES() -> ref<LifePathEvent> { return LPE(Text.LIVED_TENT_WASTES_F(), Text.LIVED_TENT_WASTES_M()); }
    public static func LIVED_APT_MGTWR() -> ref<LifePathEvent> { return LPE(Text.LIVED_APT_MGTWR_F(), Text.LIVED_APT_MGTWR_M()); }
    public static func LIVED_JNTR_MGTWR() -> ref<LifePathEvent> { return LPE(Text.LIVED_JNTR_MGTWR_F(), Text.LIVED_JNTR_MGTWR_M()); }
    public static func LIVED_APT_MGTWR() -> ref<LifePathEvent> { return LPE(Text.LIVED_APT_MGTWR_F(), Text.LIVED_APT_MGTWR_M()); }
    public static func LIVED_SHED_INDSTR() -> ref<LifePathEvent> { return LPE(Text.LIVED_SHED_INDSTR_F(), Text.LIVED_SHED_INDSTR_M()); }
    public static func LIVED_SHANTY() -> ref<LifePathEvent> { return LPE(Text.LIVED_SHANTY_F(), Text.LIVED_SHANTY_M()); }
    public static func LIVED_CRAP_TWNHME() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRAP_TWNHME_F(), Text.LIVED_CRAP_TWNHME_M()); }
    public static func LIVED_RANCHO_HOUSE() -> ref<LifePathEvent> { return LPE(Text.LIVED_RANCHO_HOUSE_F(), Text.LIVED_RANCHO_HOUSE_M()); }
    public static func LIVED_SMLL_TOWN() -> ref<LifePathEvent> { return LPE(Text.LIVED_SMLL_TOWN_F(), Text.LIVED_SMLL_TOWN_M()); }
    public static func LIVED_DECAY_HOOD() -> ref<LifePathEvent> { return LPE(Text.LIVED_DECAY_HOOD_F(), Text.LIVED_DECAY_HOOD_M()); }
    public static func LIVED_CRM_HOOD() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRM_HOOD_F(), Text.LIVED_CRM_HOOD_M()); }
    public static func LIVED_ABV_LAUND() -> ref<LifePathEvent> { return LPE(Text.LIVED_ABV_LAUND_F(), Text.LIVED_ABV_LAUND_M()); }
    public static func LIVED_ABV_BAR() -> ref<LifePathEvent> { return LPE(Text.LIVED_ABV_BAR_F(), Text.LIVED_ABV_BAR_M()); }
    public static func LIVED_MHOME_FRWY() -> ref<LifePathEvent> { return LPE(Text.LIVED_MHOME_FRWY_F(), Text.LIVED_MHOME_FRWY_M()); }
    public static func LIVED_LUDDITE() -> ref<LifePathEvent> { return LPE(Text.LIVED_LUDDITE_F(), Text.LIVED_LUDDITE_M()); }
    public static func LIVED_NOMAD_PACK() -> ref<LifePathEvent> { return LPE(Text.LIVED_NOMAD_PACK_F(), Text.LIVED_NOMAD_PACK_M()); }
    public static func LIVED_GNG_BANDIT() -> ref<LifePathEvent> { return LPE(Text.LIVED_GNG_BANDIT_F(), Text.LIVED_GNG_BANDIT_M()); }
    public static func LIVED_EUROPE() -> ref<LifePathEvent> { return LPE(Text.LIVED_EUROPE_F(), Text.LIVED_EUROPE_M()); }
    public static func LIVED_LXR_MGTWR() -> ref<LifePathEvent> { return LPE(Text.LIVED_LXR_MGTWR_F(), Text.LIVED_LXR_MGTWR_M()); }
    public static func LIVED_CRP_SBRB() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRP_SBRB_F(), Text.LIVED_CRP_SBRB_M()); }
    public static func LIVED_CRP_ZONE() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRP_ZONE_F(), Text.LIVED_CRP_ZONE_M()); }
    public static func LIVED_CRP_RSRCH() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRP_RSRCH_F(), Text.LIVED_CRP_RSRCH_M()); }
    public static func LIVED_CRP_FARM() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRP_FARM_F(), Text.LIVED_CRP_FARM_M()); }
    public static func LIVED_CRP_PNTHSE() -> ref<LifePathEvent> { return LPE(Text.LIVED_CRP_PNTHSE_F(), Text.LIVED_CRP_PNTHSE_M()); }
    public static func LIVED_LXR_PNTHSE() -> ref<LifePathEvent> { return LPE(Text.LIVED_LXR_PNTHSE_F(), Text.LIVED_LXR_PNTHSE_M()); }
    public static func LIVED_MNSION() -> ref<LifePathEvent> { return LPE(Text.LIVED_MNSION_F(), Text.LIVED_MNSION_M()); }
    public static func LIVED_NICE_TWNHME() -> ref<LifePathEvent> { return LPE(Text.LIVED_NICE_TWNHME_F(), Text.LIVED_NICE_TWNHME_M()); }
    public static func LIVED_RDS_CAR() -> ref<LifePathEvent> { return LPE(Text.LIVED_RDS_CAR_F(), Text.LIVED_RDS_CAR_M()); }
    public static func LIVED_RSRCH_FCLY() -> ref<LifePathEvent> { return LPE(Text.LIVED_RSRCH_FCLY_F(), Text.LIVED_RSRCH_FCLY_M()); }
    public static func LIVED_GTD_CRP() -> ref<LifePathEvent> { return LPE(Text.LIVED_GTD_CRP_F(), Text.LIVED_GTD_CRP_M()); }
    public static func LIVED_VILLAGE() -> ref<LifePathEvent> { return LPE(Text.LIVED_VILLAGE_F(), Text.LIVED_VILLAGE_M()); }
    public static func LIVED_SHACK() -> ref<LifePathEvent> { return LPE(Text.LIVED_SHACK_F(), Text.LIVED_SHACK_M()); }

    // Childhood
    public static func JOINED_GANG() -> ref<LifePathEvent> { return LPE(Text.JOINED_GANG_F(), Text.JOINED_GANG_M()); }
    public static func RAN_AWAY() -> ref<LifePathEvent> { return LPE(Text.RAN_AWAY_F(), Text.RAN_AWAY_M()); }
    public static func KIDNPPD_SCAVS() -> ref<LifePathEvent> { return LPE(Text.KIDNPPD_SCAVS_F(), Text.KIDNPPD_SCAVS_M()); }
    public static func USNG_CHEMS() -> ref<LifePathEvent> { return LPE(Text.USNG_CHEMS_F(), Text.USNG_CHEMS_M()); }
    public static func BULLIED_RLNTLSLY() -> ref<LifePathEvent> { return LPE(Text.BULLIED_RLNTLSLY_F(), Text.BULLIED_RLNTLSLY_M()); }
    public static func STOLE_CAR() -> ref<LifePathEvent> { return LPE(Text.STOLE_CAR_F(), Text.STOLE_CAR_M()); }
    public static func SELLING_CHEMS() -> ref<LifePathEvent> { return LPE(Text.SELLING_CHEMS_F(), Text.SELLING_CHEMS_M()); }
    public static func JOINED_BAND() -> ref<LifePathEvent> { return LPE(Text.JOINED_BAND_F(), Text.JOINED_BAND_M()); }
    public static func AVERAGE_ATHLETE() -> ref<LifePathEvent> { return LPE(Text.AVERAGE_ATHLETE_F(), Text.AVERAGE_ATHLETE_M()); }
    public static func BAD_ATHLETE() -> ref<LifePathEvent> { return LPE(Text.BAD_ATHLETE_F(), Text.BAD_ATHLETE_M()); }
    public static func GOOD_ATHLETE() -> ref<LifePathEvent> { return LPE(Text.GOOD_ATHLETE_F(), Text.GOOD_ATHLETE_M()); }
    public static func SPNT_TIME_NET() -> ref<LifePathEvent> { return LPE(Text.SPNT_TIME_NET_F(), Text.SPNT_TIME_NET_M()); }
    public static func TINKER_ELTRNICS() -> ref<LifePathEvent> { return LPE(Text.TINKER_ELTRNICS_F(), Text.TINKER_ELTRNICS_M()); }
    public static func RADICALIZED() -> ref<LifePathEvent> { return LPE(Text.RADICALIZED_F(), Text.RADICALIZED_M()); }
    public static func INTRST_IN_GUNS() -> ref<LifePathEvent> { return LPE(Text.INTRST_IN_GUNS_F(), Text.INTRST_IN_GUNS_M()); }
    public static func INTRST_IN_SWORDS() -> ref<LifePathEvent> { return LPE(Text.INTRST_IN_SWORDS_F(), Text.INTRST_IN_SWORDS_M()); }
    public static func INTRST_IN_CYBER() -> ref<LifePathEvent> { return LPE(Text.INTRST_IN_CYBER_F(), Text.INTRST_IN_CYBER_M()); }
    public static func ANTI_CORPO_FRM() -> ref<LifePathEvent> { return LPE(Text.ANTI_CORPO_FRM_F(), Text.ANTI_CORPO_FRM_M()); }
    public static func HACK_SM_DB() -> ref<LifePathEvent> { return LPE(Text.HACK_SM_DB_F(), Text.HACK_SM_DB_M()); }
    public static func HACK_LG_DB() -> ref<LifePathEvent> { return LPE(Text.HACK_LG_DB_F(), Text.HACK_LG_DB_M()); }
    public static func HACK_ICONIC_CORPO() -> ref<LifePathEvent> { return LPE(Text.HACK_ICONIC_CORPO_F(), Text.HACK_ICONIC_CORPO_M()); }
    public static func READ_CLASSIC_LIT() -> ref<LifePathEvent> { return LPE(Text.READ_CLASSIC_LIT_F(), Text.READ_CLASSIC_LIT_M()); }
    public static func READ_NGHTY_MAG() -> ref<LifePathEvent> { return LPE(Text.READ_NGHTY_MAG_F(), Text.READ_NGHTY_MAG_M()); }
    public static func READ_PULP_SCI() -> ref<LifePathEvent> { return LPE(Text.READ_PULP_SCI_F(), Text.READ_PULP_SCI_M()); }
    public static func SCROLLING_BD() -> ref<LifePathEvent> { return LPE(Text.SCROLLING_BD_F(), Text.SCROLLING_BD_M()); }
    public static func WATCH_BD() -> ref<LifePathEvent> { return LPE(Text.WATCH_BD_F(), Text.WATCH_BD_M()); }
    public static func MANDARIN_LSSN() -> ref<LifePathEvent> { return LPE(Text.MANDARIN_LSSN_F(), Text.MANDARIN_LSSN_M()); }
    public static func SPANISH_LSSN() -> ref<LifePathEvent> { return LPE(Text.SPANISH_LSSN_F(), Text.SPANISH_LSSN_M()); }
    public static func CHILD_PRODIGY() -> ref<LifePathEvent> { return LPE(Text.CHILD_PRODIGY_F(), Text.CHILD_PRODIGY_M()); }
    public static func PLAY_GUITAR() -> ref<LifePathEvent> { return LPE(Text.PLAY_GUITAR_F(), Text.PLAY_GUITAR_M()); }
    public static func PLAY_VIOLIN() -> ref<LifePathEvent> { return LPE(Text.PLAY_VIOLIN_F(), Text.PLAY_VIOLIN_M()); }
    public static func CHILD_SPY() -> ref<LifePathEvent> { return LPE(Text.CHILD_SPY_F(), Text.CHILD_SPY_M()); }
    public static func NET_RUN_IMPLANTS() -> ref<LifePathEvent> { return LPE(Text.NET_RUN_IMPLANTS_F(), Text.NET_RUN_IMPLANTS_M()); }
    public static func FIRST_CW() -> ref<LifePathEvent> { return LPE(Text.FIRST_CW_F(), Text.FIRST_CW_M()); }
    public static func CYBERDECK_INST() -> ref<LifePathEvent> { return LPE(Text.CYBERDECK_INST_F(), Text.CYBERDECK_INST_M()); }
    public static func TINKER_CAR() -> ref<LifePathEvent> { return LPE(Text.TINKER_CAR_F(), Text.TINKER_CAR_M()); }
    public static func TALENT_ART() -> ref<LifePathEvent> { return LPE(Text.TALENT_ART_F(), Text.TALENT_ART_M()); }
    public static func PICK_POCKETS() -> ref<LifePathEvent> { return LPE(Text.PICK_POCKETS_F(), Text.PICK_POCKETS_M()); }
    public static func SOLD_CIG() -> ref<LifePathEvent> { return LPE(Text.SOLD_CIG_F(), Text.SOLD_CIG_M()); }
    public static func SPACE_CMP() -> ref<LifePathEvent> { return LPE(Text.SPACE_CMP_F(), Text.SPACE_CMP_M()); }
    public static func FIXER_COURIER() -> ref<LifePathEvent> { return LPE(Text.FIXER_COURIER_F(), Text.FIXER_COURIER_M()); }
    public static func CHILD_ADV() -> ref<LifePathEvent> { return LPE(Text.CHILD_ADV_F(), Text.CHILD_ADV_M()); }
    public static func INTRST_BOTANY() -> ref<LifePathEvent> { return LPE(Text.INTRST_BOTANY_F(), Text.INTRST_BOTANY_M()); }
    public static func HMEBRW_BEER() -> ref<LifePathEvent> { return LPE(Text.HMEBRW_BEER_F(), Text.HMEBRW_BEER_M()); }
    public static func SYNTH_CHEMS() -> ref<LifePathEvent> { return LPE(Text.SYNTH_CHEMS_F(), Text.SYNTH_CHEMS_M()); }
    public static func CHEM_MULE() -> ref<LifePathEvent> { return LPE(Text.CHEM_MULE_F(), Text.CHEM_MULE_M()); }
    public static func WORK_SWTSHOP() -> ref<LifePathEvent> { return LPE(Text.WORK_SWTSHOP_F(), Text.WORK_SWTSHOP_M()); }
    public static func WORK_FRMHAND() -> ref<LifePathEvent> { return LPE(Text.WORK_FRMHAND_F(), Text.WORK_FRMHAND_M()); }
    public static func EXPLR_SEWER() -> ref<LifePathEvent> { return LPE(Text.EXPLR_SEWER_F(), Text.EXPLR_SEWER_M()); }
    public static func BRK_CORPO_SYSTEM() -> ref<LifePathEvent> { return LPE(Text.BRK_CORPO_SYSTEM_F(), Text.BRK_CORPO_SYSTEM_M()); }
    public static func RBLD_SCRP_CAR() -> ref<LifePathEvent> { return LPE(Text.RBLD_SCRP_CAR_F(), Text.RBLD_SCRP_CAR_M()); }
    public static func SCVG_STRP_CAR() -> ref<LifePathEvent> { return LPE(Text.SCVG_STRP_CAR_F(), Text.SCVG_STRP_CAR_M()); }
    public static func PLAY_MUS_INST() -> ref<LifePathEvent> { return LPE(Text.PLAY_MUS_INST_F(), Text.PLAY_MUS_INST_M()); }
    public static func VNDL_PUB_PRPTY() -> ref<LifePathEvent> { return LPE(Text.VNDL_PUB_PRPTY_F(), Text.VNDL_PUB_PRPTY_M()); }
    public static func CDG_HKS_NET() -> ref<LifePathEvent> { return LPE(Text.CDG_HKS_NET_F(), Text.CDG_HKS_NET_M()); }
    public static func HACK_CRP_STL() -> ref<LifePathEvent> { return LPE(Text.HACK_CRP_STL_F(), Text.HACK_CRP_STL_M()); }
    public static func SPENT_NO_SUPV() -> ref<LifePathEvent> { return LPE(Text.SPENT_NO_SUPV_F(), Text.SPENT_NO_SUPV_M()); }

    // First Job
    public static func JOB_LOCAL_FIXER() -> ref<LifePathEvent> { return LPE(Text.JOB_LOCAL_FIXER_F(), Text.JOB_LOCAL_FIXER_M()); }
    public static func JOB_WAGE_BODEGA() -> ref<LifePathEvent> { return LPE(Text.JOB_WAGE_BODEGA_F(), Text.JOB_WAGE_BODEGA_M()); }
    public static func JOB_WAGE_DEPT() -> ref<LifePathEvent> { return LPE(Text.JOB_WAGE_DEPT_F(), Text.JOB_WAGE_DEPT_M()); }
    public static func JOB_BOUNCER() -> ref<LifePathEvent> { return LPE(Text.JOB_BOUNCER_F(), Text.JOB_BOUNCER_M()); }
    public static func JOB_HOMELESS() -> ref<LifePathEvent> { return LPE(Text.JOB_HOMELESS_F(), Text.JOB_HOMELESS_M()); }
    public static func JOB_WAGE_GAS() -> ref<LifePathEvent> { return LPE(Text.JOB_WAGE_GAS_F(), Text.JOB_WAGE_GAS_M()); }
    public static func JOB_ROB_APT() -> ref<LifePathEvent> { return LPE(Text.JOB_ROB_APT_F(), Text.JOB_ROB_APT_M()); }
    public static func JOB_JOYTOY_CHEAP() -> ref<LifePathEvent> { return LPE(Text.JOB_JOYTOY_CHEAP_F(), Text.JOB_JOYTOY_CHEAP_M()); }
    public static func JOB_JOYTOY_EXP() -> ref<LifePathEvent> { return LPE(Text.JOB_JOYTOY_EXP_F(), Text.JOB_JOYTOY_EXP_M()); }
    public static func JOB_SECURITY() -> ref<LifePathEvent> { return LPE(Text.JOB_SECURITY_F(), Text.JOB_SECURITY_M()); }
    public static func JOB_RECEPTION() -> ref<LifePathEvent> { return LPE(Text.JOB_RECEPTION_F(), Text.JOB_RECEPTION_M()); }
    public static func JOB_DESK_JOCKEY() -> ref<LifePathEvent> { return LPE(Text.JOB_DESK_JOCKEY_F(), Text.JOB_DESK_JOCKEY_M()); }
    public static func JOB_WAGESLAVE() -> ref<LifePathEvent> { return LPE(Text.JOB_WAGESLAVE_F(), Text.JOB_WAGESLAVE_M()); }
    public static func JOB_CORPO_MANAGER() -> ref<LifePathEvent> { return LPE(Text.JOB_CORPO_MANAGER_F(), Text.JOB_CORPO_MANAGER_M()); }
    public static func JOB_CORPO_EXEC() -> ref<LifePathEvent> { return LPE(Text.JOB_CORPO_EXEC_F(), Text.JOB_CORPO_EXEC_M()); }
    public static func JOB_DAY_LABOR() -> ref<LifePathEvent> { return LPE(Text.JOB_DAY_LABOR_F(), Text.JOB_DAY_LABOR_M()); }
    public static func JOB_FOOD_VNDR() -> ref<LifePathEvent> { return LPE(Text.JOB_FOOD_VNDR_F(), Text.JOB_FOOD_VNDR_M()); }
    public static func JOB_SEX_TRADER() -> ref<LifePathEvent> { return LPE(Text.JOB_SEX_TRADER_F(), Text.JOB_SEX_TRADER_M()); }
    public static func JOB_JOYTOY_BURAN() -> ref<LifePathEvent> { return LPE(Text.JOB_JOYTOY_BURAN_F(), Text.JOB_JOYTOY_BURAN_M()); }
    public static func JOB_KIDNAP_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_KIDNAP_CRP_F(), Text.JOB_KIDNAP_CRP_M()); }
    public static func JOB_DRUG_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_DRUG_CRP_F(), Text.JOB_DRUG_CRP_M()); }
    public static func JOB_SPORT_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_SPORT_CRP_F(), Text.JOB_SPORT_CRP_M()); }
    public static func JOB_SWORD() -> ref<LifePathEvent> { return LPE(Text.JOB_SWORD_F(), Text.JOB_SWORD_M()); }
    public static func JOB_GUNS() -> ref<LifePathEvent> { return LPE(Text.JOB_GUNS_F(), Text.JOB_GUNS_M()); }
    public static func JOB_DELIVER() -> ref<LifePathEvent> { return LPE(Text.JOB_DELIVER_F(), Text.JOB_DELIVER_M()); }
    public static func JOB_SPY_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_SPY_CRP_F(), Text.JOB_SPY_CRP_M()); }
    public static func JOB_TEACHER() -> ref<LifePathEvent> { return LPE(Text.JOB_TEACHER_F(), Text.JOB_TEACHER_M()); }
    public static func JOB_DOC_ASSIST() -> ref<LifePathEvent> { return LPE(Text.JOB_DOC_ASSIST_F(), Text.JOB_DOC_ASSIST_M()); }
    public static func JOB_BARTEND() -> ref<LifePathEvent> { return LPE(Text.JOB_BARTEND_F(), Text.JOB_BARTEND_M()); }
    public static func JOB_BOOTLEGGER() -> ref<LifePathEvent> { return LPE(Text.JOB_BOOTLEGGER_F(), Text.JOB_BOOTLEGGER_M()); }
    public static func JOB_DRUG_RUNNER() -> ref<LifePathEvent> { return LPE(Text.JOB_DRUG_RUNNER_F(), Text.JOB_DRUG_RUNNER_M()); }
    public static func JOB_ARMS_DEALER() -> ref<LifePathEvent> { return LPE(Text.JOB_ARMS_DEALER_F(), Text.JOB_ARMS_DEALER_M()); }
    public static func JOB_SWEAT_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_SWEAT_CRP_F(), Text.JOB_SWEAT_CRP_M()); }
    public static func JOB_CYBER_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_CYBER_CRP_F(), Text.JOB_CYBER_CRP_M()); }
    public static func JOB_MAG_STAND() -> ref<LifePathEvent> { return LPE(Text.JOB_MAG_STAND_F(), Text.JOB_MAG_STAND_M()); }
    public static func JOB_BD_CRP() -> ref<LifePathEvent> { return LPE(Text.JOB_BD_CRP_F(), Text.JOB_BD_CRP_M()); }

    // Adulthood
    public static func LOST_GAMBLE() -> ref<LifePathEvent> { return LPE(Text.LOST_GAMBLE_F(), Text.LOST_GAMBLE_M()); }
    public static func INST_NEW_AUG() -> ref<LifePathEvent> { return LPE(Text.INST_NEW_AUG_F(), Text.INST_NEW_AUG_M()); }
    public static func RADIO_JOCKEY() -> ref<LifePathEvent> { return LPE(Text.RADIO_JOCKEY_F(), Text.RADIO_JOCKEY_M()); }
    public static func CAR_ACCIDENT() -> ref<LifePathEvent> { return LPE(Text.CAR_ACCIDENT_F(), Text.CAR_ACCIDENT_M()); }
    public static func BCME_CHEMHEAD() -> ref<LifePathEvent> { return LPE(Text.BCME_CHEMHEAD_F(), Text.BCME_CHEMHEAD_M()); }
    public static func IMPRISONED() -> ref<LifePathEvent> { return LPE(Text.IMPRISONED_F(), Text.IMPRISONED_M()); }
    public static func STOLE_EQP() -> ref<LifePathEvent> { return LPE(Text.STOLE_EQP_F(), Text.STOLE_EQP_M()); }
    public static func ROB_BODEGA() -> ref<LifePathEvent> { return LPE(Text.ROB_BODEGA_F(), Text.ROB_BODEGA_M()); }
    public static func JOIN_NEW_BAND() -> ref<LifePathEvent> { return LPE(Text.JOIN_NEW_BAND_F(), Text.JOIN_NEW_BAND_M()); }
    public static func COMPLETED_JOB() -> ref<LifePathEvent> { return LPE(Text.COMPLETED_JOB_F(), Text.COMPLETED_JOB_M()); }
    public static func RUN_CHEMS() -> ref<LifePathEvent> { return LPE(Text.RUN_CHEMS_F(), Text.RUN_CHEMS_M()); }
    public static func WON_LOTTERY() -> ref<LifePathEvent> { return LPE(Text.WON_LOTTERY_F(), Text.WON_LOTTERY_M()); }
    public static func BOUGHT_CAR() -> ref<LifePathEvent> { return LPE(Text.BOUGHT_CAR_F(), Text.BOUGHT_CAR_M()); }
    public static func NEW_APT() -> ref<LifePathEvent> { return LPE(Text.NEW_APT_F(), Text.NEW_APT_M()); }
    public static func BOUGHT_GUN() -> ref<LifePathEvent> { return LPE(Text.BOUGHT_GUN_F(), Text.BOUGHT_GUN_M()); }
    public static func BOUGHT_SWORD() -> ref<LifePathEvent> { return LPE(Text.BOUGHT_SWORD_F(), Text.BOUGHT_SWORD_M()); }
    public static func JOINED_RIOT() -> ref<LifePathEvent> { return LPE(Text.JOINED_RIOT_F(), Text.JOINED_RIOT_M()); }
    public static func KILLED_CHOOM() -> ref<LifePathEvent> { return LPE(Text.KILLED_CHOOM_F(), Text.KILLED_CHOOM_M()); }
    public static func LOST_JOB() -> ref<LifePathEvent> { return LPE(Text.LOST_JOB_F(), Text.LOST_JOB_M()); }
    public static func INDUSTRIAL_ACC() -> ref<LifePathEvent> { return LPE(Text.INDUSTRIAL_ACC_F(), Text.INDUSTRIAL_ACC_M()); }
    public static func CODED_BOTNETS() -> ref<LifePathEvent> { return LPE(Text.CODED_BOTNETS_F(), Text.CODED_BOTNETS_M()); }
    public static func ROB_VENDOR() -> ref<LifePathEvent> { return LPE(Text.ROB_VENDOR_F(), Text.ROB_VENDOR_M()); }
    public static func TOB_CONSUMER() -> ref<LifePathEvent> { return LPE(Text.TOB_CONSUMER_F(), Text.TOB_CONSUMER_M()); }
    public static func AL_BEV_CONSUMER() -> ref<LifePathEvent> { return LPE(Text.AL_BEV_CONSUMER_F(), Text.AL_BEV_CONSUMER_M()); }
    public static func WATER_CONSUMER() -> ref<LifePathEvent> { return LPE(Text.WATER_CONSUMER_F(), Text.WATER_CONSUMER_M()); }
    public static func JOYTOY_CONSUMER() -> ref<LifePathEvent> { return LPE(Text.JOYTOY_CONSUMER_F(), Text.JOYTOY_CONSUMER_M()); }
    public static func BD_CONSUMER() -> ref<LifePathEvent> { return LPE(Text.BD_CONSUMER_F(), Text.BD_CONSUMER_M()); }
    public static func BD_ADDICT() -> ref<LifePathEvent> { return LPE(Text.BD_ADDICT_F(), Text.BD_ADDICT_M()); }
    public static func RELIC_ASPIRANT() -> ref<LifePathEvent> { return LPE(Text.RELIC_ASPIRANT_F(), Text.RELIC_ASPIRANT_M()); }
    public static func BOUGHT_SHARD() -> ref<LifePathEvent> { return LPE(Text.BOUGHT_SHARD_F(), Text.BOUGHT_SHARD_M()); }
    public static func BOUGHT_CYBER() -> ref<LifePathEvent> { return LPE(Text.BOUGHT_CYBER_F(), Text.BOUGHT_CYBER_M()); }
    public static func TWO_AM_CLUB() -> ref<LifePathEvent> { return LPE(Text.TWO_AM_CLUB_F(), Text.TWO_AM_CLUB_M()); }
    public static func ROBOT_DEST() -> ref<LifePathEvent> { return LPE(Text.ROBOT_DEST_F(), Text.ROBOT_DEST_M()); }
    public static func CANCEL_TTI() -> ref<LifePathEvent> { return LPE(Text.CANCEL_TTI_F(), Text.CANCEL_TTI_M()); }
    public static func FILED_FRD_INS() -> ref<LifePathEvent> { return LPE(Text.FILED_FRD_INS_F(), Text.FILED_FRD_INS_M()); }
    public static func ASST_SZD_CRP() -> ref<LifePathEvent> { return LPE(Text.ASST_SZD_CRP_F(), Text.ASST_SZD_CRP_M()); }
    public static func CHRG_BK_DBTR() -> ref<LifePathEvent> { return LPE(Text.CHRG_BK_DBTR_F(), Text.CHRG_BK_DBTR_M()); }
    public static func CHRG_MED_DBT() -> ref<LifePathEvent> { return LPE(Text.CHRG_MED_DBT_F(), Text.CHRG_MED_DBT_M()); }
    public static func INDEBT_CRP_INDVL() -> ref<LifePathEvent> { return LPE(Text.INDEBT_CRP_INDVL_F(), Text.INDEBT_CRP_INDVL_M()); }
    public static func CRP_LBLTY_DFDT() -> ref<LifePathEvent> { return LPE(Text.CRP_LBLTY_DFDT_F(), Text.CRP_LBLTY_DFDT_M()); }
    public static func CRP_POL_VIO() -> ref<LifePathEvent> { return LPE(Text.CRP_POL_VIO_F(), Text.CRP_POL_VIO_M()); }
    public static func HAB_CRP_DBTR() -> ref<LifePathEvent> { return LPE(Text.HAB_CRP_DBTR_F(), Text.HAB_CRP_DBTR_M()); }
    public static func ARMED_DANGER() -> ref<LifePathEvent> { return LPE(Text.ARMED_DANGER_F(), Text.ARMED_DANGER_M()); }
    public static func FLSLY_ACC_MRDR() -> ref<LifePathEvent> { return LPE(Text.FLSLY_ACC_MRDR_F(), Text.FLSLY_ACC_MRDR_M()); }
    public static func FREE_CRP_MRDR() -> ref<LifePathEvent> { return LPE(Text.FREE_CRP_MRDR_F(), Text.FREE_CRP_MRDR_M()); }
    public static func VAC_AFRICA() -> ref<LifePathEvent> { return LPE(Text.VAC_AFRICA_F(), Text.VAC_AFRICA_M()); }
    public static func JUMP_TRAFFIC() -> ref<LifePathEvent> { return LPE(Text.JUMP_TRAFFIC_F(), Text.JUMP_TRAFFIC_M()); }
    public static func BUILD_BOMB() -> ref<LifePathEvent> { return LPE(Text.BUILD_BOMB_F(), Text.BUILD_BOMB_M()); }
    public static func EMAIL_GOV() -> ref<LifePathEvent> { return LPE(Text.EMAIL_GOV_F(), Text.EMAIL_GOV_M()); }
    public static func FREE_TTI() -> ref<LifePathEvent> { return LPE(Text.FREE_TTI_F(), Text.FREE_TTI_M()); }
}

public static func UpbringingEvents(
    POS_OUTCOME_WGT: Int32, 
    NEU_OUTCOME_WGT: Int32, 
    NEG_OUTCOME_WGT: Int32, 
    CORPO_MOD: Int32, 
    NOMAD_MOD: Int32, 
    JUNKIE_MOD: Int32,
    GANGER_MOD: Int32
) -> array<ref<LifePathEvent>> {
    let events: array<ref<LifePathEvent>>;
    PushWeightedLifeEvent(events, CrowdScannerEvents.LVG_MOT_FAT(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ADPT_LVG_HOM(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LVG_GPRNTS(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LVG_RLTIVS(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TGT_NOMAD(), POS_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TGT_MGTOWR(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ADPT_CRP_BRD(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.UNCR_PRNTS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ORD_HOME(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HLCPT_PRNTS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RGH_NOMAD(), NEU_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.UNWLNG_GPRNTS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.UNWLNG_RLTIVS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MDCRE_FOSTER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MDCRE_ORPHN(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SNGL_MOT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SNGL_FAT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BD_HD_PRNTS(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SLD_BY_PRNTS(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SLD_BY_PRNTS(), NEG_OUTCOME_WGT + JUNKIE_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TRD_FOR_CHEM(), NEG_OUTCOME_WGT + JUNKIE_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PRNTS_CRSH(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_ANSA(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_ANSA(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ABSV_FOSTER(), NEG_OUTCOME_WGT + JUNKIE_MOD + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TRB_ORPHN(), NEG_OUTCOME_WGT + JUNKIE_MOD + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ABON_CHILD(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.VLNT_MGTWR(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.GRP_SCAVS(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.VTGRN_LAB(), 1 + CORPO_MOD / 5);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RAISED_BY_AI(), 1 + CORPO_MOD / 5);
    PushWeightedLifeEvent(events, CrowdScannerEvents.GENE_ALTER(), 1 + CORPO_MOD / 5);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CONGT_DEFECT(), 1);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CORPO_DEBT(), 1 + JUNKIE_MOD/ 2);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAM_KLD_NCPD(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PAT_GNG_WRFR(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PAT_AVRG_CTZN(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PAT_WLTH_CTZN(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_UNID(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_UNID(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_KLD_NCPD(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_KLD_NCPD(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_KLD_MXTC(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_KLD_MXTC(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_POW(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_POW(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_INCR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_INCR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_DIE_NAT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_DIE_NAT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_WRK_CRP(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_WRK_CRP(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_MRD_CRP(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_MRD_CRP(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_KLD_WAR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_KLD_WAR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_DIED_ACC(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_DIED_ACC(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_HIDING(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_HIDING(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MOT_MISSING(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FAT_MISSING(), NEG_OUTCOME_WGT);
    return events;
}

public static func HomeEvents(
    POS_OUTCOME_WGT: Int32, 
    NEU_OUTCOME_WGT: Int32, 
    NEG_OUTCOME_WGT: Int32, 
    CORPO_MOD: Int32, 
    NOMAD_MOD: Int32, 
    JUNKIE_MOD: Int32,
    GANGER_MOD: Int32,
    HOMELESS_MOD: Int32
) -> array<ref<LifePathEvent>> {
    let events: array<ref<LifePathEvent>>;
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_ALLEY(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_DMPSTR(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_DRNPIPE(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_GUTTR(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_SEWER(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_ABN_CAR(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_VAN(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_BOX(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_COMBAT_ZONE(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_TENT_FRWY(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_UDR_BRIDGE(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CHEM_DEN(), NEG_OUTCOME_WGT + JUNKIE_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_TENT_WASTES(), NEG_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_APT_MGTWR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_JNTR_MGTWR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_APT_MGTWR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_SHED_INDSTR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_SHANTY(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRAP_TWNHME(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_RANCHO_HOUSE(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_SMLL_TOWN(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_DECAY_HOOD(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRM_HOOD(), NEU_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_ABV_LAUND(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_ABV_BAR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_MHOME_FRWY(), NEU_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_LUDDITE(), 1);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_NOMAD_PACK(), NEU_OUTCOME_WGT + (NOMAD_MOD * 10));
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_GNG_BANDIT(), NEU_OUTCOME_WGT + NOMAD_MOD + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_EUROPE(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_LXR_MGTWR(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRP_SBRB(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRP_ZONE(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRP_RSRCH(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRP_FARM(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_CRP_PNTHSE(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_LXR_PNTHSE(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_MNSION(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_NICE_TWNHME(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_RDS_CAR(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_RSRCH_FCLY(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_GTD_CRP(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_VILLAGE(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LIVED_SHACK(), NEU_OUTCOME_WGT + NOMAD_MOD);
    return events;
}

public static func ChildhoodEvents(
    POS_OUTCOME_WGT: Int32,
    NEU_OUTCOME_WGT: Int32, 
    NEG_OUTCOME_WGT: Int32, 
    CORPO_MOD: Int32, 
    NOMAD_MOD: Int32, 
    JUNKIE_MOD: Int32,
    GANGER_MOD: Int32,
    HOMELESS_MOD: Int32
) -> array<ref<LifePathEvent>>  {
    let events: array<ref<LifePathEvent>>;
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOINED_GANG(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RAN_AWAY(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.KIDNPPD_SCAVS(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.USNG_CHEMS(), NEG_OUTCOME_WGT + JUNKIE_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BULLIED_RLNTLSLY(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.STOLE_CAR(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SELLING_CHEMS(), NEG_OUTCOME_WGT + JUNKIE_MOD + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOINED_BAND(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.AVERAGE_ATHLETE(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BAD_ATHLETE(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.GOOD_ATHLETE(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SPNT_TIME_NET(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TINKER_ELTRNICS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RADICALIZED(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INTRST_IN_GUNS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INTRST_IN_SWORDS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INTRST_IN_CYBER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ANTI_CORPO_FRM(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HACK_SM_DB(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HACK_LG_DB(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HACK_ICONIC_CORPO(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.READ_CLASSIC_LIT(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.READ_NGHTY_MAG(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.READ_PULP_SCI(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SCROLLING_BD(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.WATCH_BD(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.MANDARIN_LSSN(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SPANISH_LSSN(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CHILD_PRODIGY(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PLAY_GUITAR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PLAY_VIOLIN(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CHILD_SPY(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.NET_RUN_IMPLANTS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FIRST_CW(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CYBERDECK_INST(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TINKER_CAR(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TALENT_ART(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PICK_POCKETS(), NEG_OUTCOME_WGT + GANGER_MOD + JUNKIE_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SOLD_CIG(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SPACE_CMP(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FIXER_COURIER(), NEU_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CHILD_ADV(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INTRST_BOTANY(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HMEBRW_BEER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SYNTH_CHEMS(), NEG_OUTCOME_WGT + JUNKIE_MOD + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CHEM_MULE(), NEG_OUTCOME_WGT + JUNKIE_MOD + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.WORK_SWTSHOP(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.WORK_FRMHAND(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.EXPLR_SEWER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BRK_CORPO_SYSTEM(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RBLD_SCRP_CAR(), POS_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SCVG_STRP_CAR(), POS_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.PLAY_MUS_INST(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.VNDL_PUB_PRPTY(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CDG_HKS_NET(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HACK_CRP_STL(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.SPENT_NO_SUPV(), NEG_OUTCOME_WGT + GANGER_MOD + HOMELESS_MOD  + JUNKIE_MOD);

    return events;
}

public static func JobEvents(
    POS_OUTCOME_WGT: Int32,
    NEU_OUTCOME_WGT: Int32, 
    NEG_OUTCOME_WGT: Int32, 
    CORPO_MOD: Int32, 
    NOMAD_MOD: Int32, 
    JUNKIE_MOD: Int32,
    GANGER_MOD: Int32,
    HOMELESS_MOD: Int32
) -> array<ref<LifePathEvent>>  {
    let events: array<ref<LifePathEvent>>;
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_LOCAL_FIXER(), NEU_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_WAGE_BODEGA(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_WAGE_DEPT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_BOUNCER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_HOMELESS(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_WAGE_GAS(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_ROB_APT(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_JOYTOY_CHEAP(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_JOYTOY_EXP(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_SECURITY(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_RECEPTION(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_DESK_JOCKEY(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_WAGESLAVE(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_CORPO_MANAGER(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_CORPO_EXEC(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_DAY_LABOR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_FOOD_VNDR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_SEX_TRADER(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_JOYTOY_BURAN(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_KIDNAP_CRP(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_DRUG_CRP(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_SPORT_CRP(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_SWORD(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_GUNS(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_DELIVER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_SPY_CRP(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_TEACHER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_DOC_ASSIST(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_BARTEND(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_BOOTLEGGER(), NEU_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_DRUG_RUNNER(), NEU_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_ARMS_DEALER(), NEU_OUTCOME_WGT + NOMAD_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_SWEAT_CRP(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_CYBER_CRP(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_MAG_STAND(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOB_BD_CRP(), NEG_OUTCOME_WGT + CORPO_MOD);
    return events;
}

public static func AdultEvents(
    POS_OUTCOME_WGT: Int32,
    NEU_OUTCOME_WGT: Int32, 
    NEG_OUTCOME_WGT: Int32, 
    CORPO_MOD: Int32, 
    NOMAD_MOD: Int32, 
    JUNKIE_MOD: Int32,
    GANGER_MOD: Int32,
    HOMELESS_MOD: Int32
) -> array<ref<LifePathEvent>>  {
    let events: array<ref<LifePathEvent>>;
    PushWeightedLifeEvent(events, CrowdScannerEvents.LOST_GAMBLE(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INST_NEW_AUG(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RADIO_JOCKEY(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CAR_ACCIDENT(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BCME_CHEMHEAD(), NEG_OUTCOME_WGT + JUNKIE_MOD + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.IMPRISONED(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.STOLE_EQP(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ROB_BODEGA(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOIN_NEW_BAND(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.COMPLETED_JOB(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RUN_CHEMS(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.WON_LOTTERY(), 5);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BOUGHT_CAR(), POS_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.NEW_APT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BOUGHT_GUN(), NEU_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BOUGHT_SWORD(), NEU_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOINED_RIOT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.KILLED_CHOOM(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.LOST_JOB(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INDUSTRIAL_ACC(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CODED_BOTNETS(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ROB_VENDOR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TOB_CONSUMER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.AL_BEV_CONSUMER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.WATER_CONSUMER(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JOYTOY_CONSUMER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BD_CONSUMER(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BD_ADDICT(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.RELIC_ASPIRANT(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BOUGHT_SHARD(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BOUGHT_CYBER(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.TWO_AM_CLUB(), NEU_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ROBOT_DEST(), NEU_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CANCEL_TTI(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FILED_FRD_INS(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ASST_SZD_CRP(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CHRG_BK_DBTR(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CHRG_MED_DBT(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.INDEBT_CRP_INDVL(), NEG_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CRP_LBLTY_DFDT(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.CRP_POL_VIO(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.HAB_CRP_DBTR(), NEG_OUTCOME_WGT + HOMELESS_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.ARMED_DANGER(), NEG_OUTCOME_WGT + GANGER_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FLSLY_ACC_MRDR(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FREE_CRP_MRDR(), NEU_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.VAC_AFRICA(), POS_OUTCOME_WGT + CORPO_MOD);
    PushWeightedLifeEvent(events, CrowdScannerEvents.JUMP_TRAFFIC(), NEG_OUTCOME_WGT);
    PushWeightedLifeEvent(events, CrowdScannerEvents.BUILD_BOMB(), NEG_OUTCOME_WGT/2);
    PushWeightedLifeEvent(events, CrowdScannerEvents.EMAIL_GOV(), 10);
    PushWeightedLifeEvent(events, CrowdScannerEvents.FREE_TTI(), 10);

    return events;
}

public func PushWeightedLifeEvent(out to: array<ref<LifePathEvent>>, lifePathEvent: ref<LifePathEvent>, weight: Int32) {
    lifePathEvent.weight = weight;
    ArrayPush(to, lifePathEvent);
}