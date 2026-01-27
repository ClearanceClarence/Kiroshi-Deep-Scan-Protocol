// Upbringing and family origins
public abstract class TextUpbringing {
    // === POSITIVE/STABLE ===
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
    public static func ORD_HOME_F() -> String { return "Grew up in an ordinary home. "; }
    public static func ORD_HOME_M() -> String { return ""; }
    public static func STABLE_MIDDLE_F() -> String { return "Raised in a stable middle-class family. "; }
    public static func STABLE_MIDDLE_M() -> String { return ""; }
    public static func TWO_MOMS_F() -> String { return "Raised by two mothers. "; }
    public static func TWO_MOMS_M() -> String { return ""; }
    public static func TWO_DADS_F() -> String { return "Raised by two fathers. "; }
    public static func TWO_DADS_M() -> String { return ""; }
    public static func EXTENDED_FAM_F() -> String { return "Raised in a large extended family household. "; }
    public static func EXTENDED_FAM_M() -> String { return ""; }
    public static func COMMUNE_F() -> String { return "Raised in a communal living arrangement. "; }
    public static func COMMUNE_M() -> String { return ""; }
    public static func RELIGIOUS_F() -> String { return "Raised in a deeply religious household. "; }
    public static func RELIGIOUS_M() -> String { return ""; }
    public static func MILITARY_BRAT_F() -> String { return "Raised as a military brat, moving frequently. "; }
    public static func MILITARY_BRAT_M() -> String { return ""; }
    public static func IMMIGRANT_F() -> String { return "Raised by immigrant parents seeking a better life. "; }
    public static func IMMIGRANT_M() -> String { return ""; }

    // === CORPORATE ===
    public static func ADPT_CRP_BRD_F() -> String { return "Adopted into a luxury corpo breeding program. "; }
    public static func ADPT_CRP_BRD_M() -> String { return ""; }
    public static func CORPO_CHILD_F() -> String { return "Raised in a corporate family with strict expectations. "; }
    public static func CORPO_CHILD_M() -> String { return ""; }
    public static func CORPO_HOUSING_F() -> String { return "Raised in corporate-provided family housing. "; }
    public static func CORPO_HOUSING_M() -> String { return ""; }
    public static func ARASAKA_FAM_F() -> String { return "Raised in an Arasaka loyalist family. "; }
    public static func ARASAKA_FAM_M() -> String { return ""; }
    public static func MILITECH_FAM_F() -> String { return "Raised in a Militech employee family. "; }
    public static func MILITECH_FAM_M() -> String { return ""; }
    public static func CORPO_BOARDING_F() -> String { return "Sent to corporate boarding school at age six. "; }
    public static func CORPO_BOARDING_M() -> String { return ""; }
    public static func EXEC_CHILD_F() -> String { return "Raised as the child of a corporate executive. "; }
    public static func EXEC_CHILD_M() -> String { return ""; }
    public static func CORPO_DYNASTY_F() -> String { return "Born into a corporate dynasty stretching back generations. "; }
    public static func CORPO_DYNASTY_M() -> String { return ""; }

    // === NEUTRAL/MIXED ===
    public static func SNGL_MOT_F() -> String { return "Raised by a single mother. "; }
    public static func SNGL_MOT_M() -> String { return ""; }
    public static func SNGL_FAT_F() -> String { return "Raised by a single father. "; }
    public static func SNGL_FAT_M() -> String { return ""; }
    public static func HLCPT_PRNTS_F() -> String { return "Grew up with helicopter parents. "; }
    public static func HLCPT_PRNTS_M() -> String { return ""; }
    public static func UNCR_PRNTS_F() -> String { return "Grew up with uncaring parents. "; }
    public static func UNCR_PRNTS_M() -> String { return ""; }
    public static func WORKAHOLIC_F() -> String { return "Raised by workaholic parents who were rarely home. "; }
    public static func WORKAHOLIC_M() -> String { return ""; }
    public static func LATCHKEY_F() -> String { return "Was a latchkey kid, coming home to an empty apartment. "; }
    public static func LATCHKEY_M() -> String { return ""; }
    public static func SHARED_CUSTODY_F() -> String { return "Raised in a shared custody arrangement. "; }
    public static func SHARED_CUSTODY_M() -> String { return ""; }
    public static func OLDER_SIBLING_F() -> String { return "Primarily raised by an older sibling. "; }
    public static func OLDER_SIBLING_M() -> String { return ""; }
    public static func NANNY_RAISED_F() -> String { return "Raised primarily by a hired nanny. "; }
    public static func NANNY_RAISED_M() -> String { return ""; }
    public static func BD_HD_PRNTS_F() -> String { return "Raised by absent BD-head parents. "; }
    public static func BD_HD_PRNTS_M() -> String { return ""; }
    public static func CHEM_ADDICT_F() -> String { return "Raised by a chem-addicted parent. "; }
    public static func CHEM_ADDICT_M() -> String { return ""; }
    public static func GANG_FAM_F() -> String { return "Raised in a family with gang affiliations. "; }
    public static func GANG_FAM_M() -> String { return ""; }

    // === NOMAD ===
    public static func RGH_NOMAD_F() -> String { return "Raised in a rough Nomad pack. "; }
    public static func RGH_NOMAD_M() -> String { return ""; }
    public static func ALDECALDOS_F() -> String { return "Raised in the Aldecaldos clan. "; }
    public static func ALDECALDOS_M() -> String { return ""; }
    public static func WRAITH_CHILD_F() -> String { return "Raised among the Wraiths in the badlands. "; }
    public static func WRAITH_CHILD_M() -> String { return ""; }
    public static func NOMAD_CONVOY_F() -> String { return "Spent childhood moving with a nomad convoy. "; }
    public static func NOMAD_CONVOY_M() -> String { return ""; }
    public static func RAFFEN_SHIV_F() -> String { return "Raised by Raffen Shiv outcasts. "; }
    public static func RAFFEN_SHIV_M() -> String { return ""; }
    public static func BAKKERS_F() -> String { return "Raised in the Bakkers clan. "; }
    public static func BAKKERS_M() -> String { return ""; }
    public static func SNAKE_NATION_F() -> String { return "Raised in the Snake Nation. "; }
    public static func SNAKE_NATION_M() -> String { return ""; }
    public static func JODES_F() -> String { return "Raised in the Jodes family. "; }
    public static func JODES_M() -> String { return ""; }

    // === NEGATIVE/TRAUMATIC ===
    public static func UNWLNG_GPRNTS_F() -> String { return "Unwillingly raised by her grandparents. "; }
    public static func UNWLNG_GPRNTS_M() -> String { return "Unwillingly raised by his grandparents. "; }
    public static func UNWLNG_RLTIVS_F() -> String { return "Unwillingly raised by her relatives. "; }
    public static func UNWLNG_RLTIVS_M() -> String { return "Unwillingly raised by his relatives. "; }
    public static func MDCRE_FOSTER_F() -> String { return "Raised in a series of mediocre foster homes. "; }
    public static func MDCRE_FOSTER_M() -> String { return ""; }
    public static func MDCRE_ORPHN_F() -> String { return "Raised in a mediocre orphanage until she came of age. "; }
    public static func MDCRE_ORPHN_M() -> String { return "Raised in a mediocre orphanage until he came of age. "; }
    public static func ABSV_FOSTER_F() -> String { return "Raised in a series of abusive foster homes. "; }
    public static func ABSV_FOSTER_M() -> String { return ""; }
    public static func TRB_ORPHN_F() -> String { return "Raised in a terrible orphanage until she came of age. "; }
    public static func TRB_ORPHN_M() -> String { return "Raised in a terrible orphanage until he came of age. "; }
    public static func ABON_CHILD_F() -> String { return "Abandoned as a child. "; }
    public static func ABON_CHILD_M() -> String { return ""; }
    public static func STRTS_NOPRNTS_F() -> String { return "Grew up on the street, never knew her parents. "; }
    public static func STRTS_NOPRNTS_M() -> String { return "Grew up on the street, never knew his parents. "; }
    public static func SLD_BY_PRNTS_F() -> String { return "Parents sold her for money. "; }
    public static func SLD_BY_PRNTS_M() -> String { return "Parents sold him for money. "; }
    public static func TRD_FOR_CHEM_F() -> String { return "Parents traded her for chems. "; }
    public static func TRD_FOR_CHEM_M() -> String { return "Parents traded him for chems. "; }
    public static func VLNT_MGTWR_F() -> String { return "Grew up in the dark corners of a violent megatower. "; }
    public static func VLNT_MGTWR_M() -> String { return ""; }
    public static func GRP_SCAVS_F() -> String { return "Raised by a group of scavengers. "; }
    public static func GRP_SCAVS_M() -> String { return ""; }
    public static func CHILD_SOLDIER_F() -> String { return "Raised as a child soldier in the corporate wars. "; }
    public static func CHILD_SOLDIER_M() -> String { return ""; }
    public static func TRAFFICKING_F() -> String { return "Rescued from a human trafficking ring as a child. "; }
    public static func TRAFFICKING_M() -> String { return ""; }
    public static func CULT_RAISED_F() -> String { return "Raised in an isolated cult compound. "; }
    public static func CULT_RAISED_M() -> String { return ""; }
    public static func ABUSIVE_HOME_F() -> String { return "Raised in an abusive household. "; }
    public static func ABUSIVE_HOME_M() -> String { return ""; }

    // === EXPERIMENTAL/UNUSUAL ===
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
    public static func CLONE_CHILD_F() -> String { return "Was cloned from a deceased corporate executive. "; }
    public static func CLONE_CHILD_M() -> String { return ""; }
    public static func CYBORG_BABY_F() -> String { return "Received cybernetic implants before age two. "; }
    public static func CYBORG_BABY_M() -> String { return ""; }
    public static func EXPERIMENT_F() -> String { return "Raised as part of a corporate experimental program. "; }
    public static func EXPERIMENT_M() -> String { return ""; }
    public static func ACCEL_GROWTH_F() -> String { return "Subjected to accelerated growth treatments as an infant. "; }
    public static func ACCEL_GROWTH_M() -> String { return ""; }

    // === PARENT STATUS ===
    public static func PAT_AVRG_CTZN_F() -> String { return "Parents were average citizens. "; }
    public static func PAT_AVRG_CTZN_M() -> String { return ""; }
    public static func PAT_WLTH_CTZN_F() -> String { return "Parents became wealthy citizens. "; }
    public static func PAT_WLTH_CTZN_M() -> String { return ""; }
    public static func PARENT_FIXER_F() -> String { return "Parent was a well-known fixer. "; }
    public static func PARENT_FIXER_M() -> String { return ""; }
    public static func PARENT_MERC_F() -> String { return "Parent was a successful mercenary. "; }
    public static func PARENT_MERC_M() -> String { return ""; }
    public static func PARENT_NETRUNNER_F() -> String { return "Parent was a legendary netrunner. "; }
    public static func PARENT_NETRUNNER_M() -> String { return ""; }
    public static func PARENT_RIPPER_F() -> String { return "Parent was a respected ripperdoc. "; }
    public static func PARENT_RIPPER_M() -> String { return ""; }
    public static func PRNTS_CRSH_F() -> String { return "Parents died in a car crash. "; }
    public static func PRNTS_CRSH_M() -> String { return ""; }
    public static func MOT_ANSA_F() -> String { return "Mother has amnesia and doesn't remember her. "; }
    public static func MOT_ANSA_M() -> String { return "Mother has amnesia and doesn't remember him. "; }
    public static func FAT_ANSA_F() -> String { return "Father has amnesia and doesn't remember her. "; }
    public static func FAT_ANSA_M() -> String { return "Father has amnesia and doesn't remember him. "; }
    public static func FAM_KLD_NCPD_F() -> String { return "Parents and extended family killed by NCPD. "; }
    public static func FAM_KLD_NCPD_M() -> String { return ""; }
    public static func PAT_GNG_WRFR_F() -> String { return "Parents killed in gang warfare. "; }
    public static func PAT_GNG_WRFR_M() -> String { return ""; }
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
    public static func PARENT_CYBER_F() -> String { return "Parent went cyberpsycho when she was young. "; }
    public static func PARENT_CYBER_M() -> String { return "Parent went cyberpsycho when he was young. "; }
    public static func PARENT_SOULKILL_F() -> String { return "Parent was soulkilled by Arasaka. "; }
    public static func PARENT_SOULKILL_M() -> String { return ""; }

    // === EXPANDED: FAMILY STRUCTURE ===
    public static func ONLY_CHILD_F() -> String { return "Grew up as an only child. "; }
    public static func ONLY_CHILD_M() -> String { return ""; }
    public static func MANY_SIBLINGS_F() -> String { return "Grew up with many siblings in a crowded household. "; }
    public static func MANY_SIBLINGS_M() -> String { return ""; }
    public static func TWIN_F() -> String { return "Has a twin sibling. "; }
    public static func TWIN_M() -> String { return ""; }
    public static func TRIPLET_F() -> String { return "Born as one of triplets. "; }
    public static func TRIPLET_M() -> String { return ""; }
    public static func OLDEST_SIBLING_F() -> String { return "Eldest of several siblings, had to grow up fast. "; }
    public static func OLDEST_SIBLING_M() -> String { return ""; }
    public static func MIDDLE_CHILD_F() -> String { return "Middle child, often overlooked growing up. "; }
    public static func MIDDLE_CHILD_M() -> String { return ""; }
    public static func YOUNGEST_SIBLING_F() -> String { return "Baby of the family, spoiled by older siblings. "; }
    public static func YOUNGEST_SIBLING_M() -> String { return ""; }
    public static func STEP_FAMILY_F() -> String { return "Raised by a step-parent after remarriage. "; }
    public static func STEP_FAMILY_M() -> String { return ""; }
    public static func BLENDED_FAM_F() -> String { return "Grew up in a blended family with step-siblings. "; }
    public static func BLENDED_FAM_M() -> String { return ""; }
    public static func ADOPTED_LATE_F() -> String { return "Adopted at an older age after years in the system. "; }
    public static func ADOPTED_LATE_M() -> String { return ""; }

    // === EXPANDED: PARENTAL OCCUPATIONS ===
    public static func PARENT_NCPD_F() -> String { return "Parent served in the NCPD. "; }
    public static func PARENT_NCPD_M() -> String { return ""; }
    public static func PARENT_TEACHER_F() -> String { return "Parent was a teacher in the public school system. "; }
    public static func PARENT_TEACHER_M() -> String { return ""; }
    public static func PARENT_DOCTOR_F() -> String { return "Parent worked as a medical professional. "; }
    public static func PARENT_DOCTOR_M() -> String { return ""; }
    public static func PARENT_JOYTOY_F() -> String { return "Parent worked as a joytoy to support the family. "; }
    public static func PARENT_JOYTOY_M() -> String { return ""; }
    public static func PARENT_DEALER_F() -> String { return "Parent dealt drugs to make ends meet. "; }
    public static func PARENT_DEALER_M() -> String { return ""; }
    public static func PARENT_MILITARY_F() -> String { return "Parent served in the military. "; }
    public static func PARENT_MILITARY_M() -> String { return ""; }
    public static func PARENT_GANG_LEADER_F() -> String { return "Parent was a gang leader. "; }
    public static func PARENT_GANG_LEADER_M() -> String { return ""; }

    // === EXPANDED: PARENTAL TRAUMA ===
    public static func PARENT_SUICIDE_F() -> String { return "Parent committed suicide when she was young. "; }
    public static func PARENT_SUICIDE_M() -> String { return "Parent committed suicide when he was young. "; }
    public static func PARENT_OVERDOSE_F() -> String { return "Parent died of an overdose. "; }
    public static func PARENT_OVERDOSE_M() -> String { return ""; }
    public static func PARENT_ABUSER_F() -> String { return "Raised by an abusive parent. "; }
    public static func PARENT_ABUSER_M() -> String { return ""; }
    public static func WITNESSED_PARENT_DEATH_F() -> String { return "Witnessed a parent's death as a child. "; }
    public static func WITNESSED_PARENT_DEATH_M() -> String { return ""; }
    public static func SIBLING_DEATH_CHILD_F() -> String { return "Lost a sibling during childhood. "; }
    public static func SIBLING_DEATH_CHILD_M() -> String { return ""; }
    public static func HOME_INVASION_F() -> String { return "Survived a home invasion as a child. "; }
    public static func HOME_INVASION_M() -> String { return ""; }
    public static func KIDNAPPED_CHILD_F() -> String { return "Was kidnapped as a child. "; }
    public static func KIDNAPPED_CHILD_M() -> String { return ""; }
    public static func FIRE_SURVIVOR_CHILD_F() -> String { return "Survived a fire that destroyed her childhood home. "; }
    public static func FIRE_SURVIVOR_CHILD_M() -> String { return "Survived a fire that destroyed his childhood home. "; }

    // === EXPANDED: WEALTH/STATUS ===
    public static func BORN_RICH_F() -> String { return "Born into wealth and privilege. "; }
    public static func BORN_RICH_M() -> String { return ""; }
    public static func BORN_POOR_F() -> String { return "Born into poverty, struggled from the start. "; }
    public static func BORN_POOR_M() -> String { return ""; }
    public static func LOST_WEALTH_F() -> String { return "Family lost everything when she was young. "; }
    public static func LOST_WEALTH_M() -> String { return "Family lost everything when he was young. "; }
    public static func TRUST_FUND_F() -> String { return "Inherited a trust fund from a wealthy relative. "; }
    public static func TRUST_FUND_M() -> String { return ""; }
    public static func BORN_DEBT_F() -> String { return "Born into a family crushed by corporate debt. "; }
    public static func BORN_DEBT_M() -> String { return ""; }
    public static func FAMILY_BUSINESS_F() -> String { return "Grew up working in the family business. "; }
    public static func FAMILY_BUSINESS_M() -> String { return ""; }
    public static func FAMILY_CRIME_F() -> String { return "Family ran a criminal enterprise. "; }
    public static func FAMILY_CRIME_M() -> String { return ""; }

    // === EXPANDED: SPECIAL ORIGINS ===
    public static func LAB_BORN_F() -> String { return "Born in a corporate laboratory. "; }
    public static func LAB_BORN_M() -> String { return ""; }
    public static func TEST_TUBE_F() -> String { return "Test tube baby, never knew biological parents. "; }
    public static func TEST_TUBE_M() -> String { return ""; }
    public static func CLONE_F() -> String { return "Clone of a wealthy individual. "; }
    public static func CLONE_M() -> String { return ""; }
    public static func BORN_CULT_F() -> String { return "Born into a religious cult. "; }
    public static func BORN_CULT_M() -> String { return ""; }
    public static func RAISED_CULT_F() -> String { return "Raised in an isolated cult compound. "; }
    public static func RAISED_CULT_M() -> String { return ""; }
    public static func ESCAPED_CULT_F() -> String { return "Escaped from a cult as a teenager. "; }
    public static func ESCAPED_CULT_M() -> String { return ""; }
    public static func COMMUNE_RAISED_F() -> String { return "Raised in an off-grid commune. "; }
    public static func COMMUNE_RAISED_M() -> String { return ""; }
    public static func REFUGEE_CHILD_F() -> String { return "Came to Night City as a refugee child. "; }
    public static func REFUGEE_CHILD_M() -> String { return ""; }
    public static func IMMIGRANT_CHILD_F() -> String { return "Child of immigrants, grew up between two cultures. "; }
    public static func IMMIGRANT_CHILD_M() -> String { return ""; }

    // === EXPANDED: FAMILY DYNAMICS ===
    public static func CHILD_PRODIGY_FAM_F() -> String { return "Was considered a child prodigy by her family. "; }
    public static func CHILD_PRODIGY_FAM_M() -> String { return "Was considered a child prodigy by his family. "; }
    public static func BLACK_SHEEP_F() -> String { return "Always the black sheep of the family. "; }
    public static func BLACK_SHEEP_M() -> String { return ""; }
    public static func GOLDEN_CHILD_F() -> String { return "The golden child who could do no wrong. "; }
    public static func GOLDEN_CHILD_M() -> String { return ""; }
    public static func UNWANTED_CHILD_F() -> String { return "Born unwanted, raised with resentment. "; }
    public static func UNWANTED_CHILD_M() -> String { return ""; }
    public static func FAMILY_SECRET_F() -> String { return "Family kept a dark secret throughout her childhood. "; }
    public static func FAMILY_SECRET_M() -> String { return "Family kept a dark secret throughout his childhood. "; }

}
