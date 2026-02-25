// Upbringing and family origins
public abstract class KdspTextUpbringing {
    // === POSITIVE/STABLE ===
    public static func LVG_MOT_FAT() -> String { return "Grew up with a loving mother and father. "; }
    public static func ADPT_LVG_HOM() -> String { return "Adopted into a loving home. "; }
    public static func LVG_GPRNTS() -> String { return "Raised by %his% loving grandparents. "; }
    public static func LVG_RLTIVS() -> String { return "Raised by a group of loving relatives. "; }
    public static func TGT_NOMAD() -> String { return "Grew up in a tightly-knit Nomad pack. "; }
    public static func TGT_MGTOWR() -> String { return "Raised by a tightly-knit community in a Megatower. "; }
    public static func ORD_HOME() -> String { return "Grew up in an ordinary home. "; }
    public static func STABLE_MIDDLE() -> String { return "Raised in a stable middle-class family. "; }
    public static func TWO_MOMS() -> String { return "Raised by two mothers. "; }
    public static func TWO_DADS() -> String { return "Raised by two fathers. "; }
    public static func EXTENDED_FAM() -> String { return "Raised in a large extended family household. "; }
    public static func COMMUNE() -> String { return "Raised in a communal living arrangement. "; }
    public static func RELIGIOUS() -> String { return "Raised in a deeply religious household. "; }
    public static func MILITARY_BRAT() -> String { return "Raised as a military brat, moving frequently. "; }
    public static func IMMIGRANT() -> String { return "Raised by immigrant parents seeking a better life. "; }
    // === CORPORATE ===
    public static func ADPT_CRP_BRD() -> String { return "Adopted into a luxury corpo breeding program. "; }
    public static func CORPO_CHILD() -> String { return "Raised in a corporate family with strict expectations. "; }
    public static func CORPO_HOUSING() -> String { return "Raised in corporate-provided family housing. "; }
    public static func ARASAKA_FAM() -> String { return "Raised in an Arasaka loyalist family. "; }
    public static func MILITECH_FAM() -> String { return "Raised in a Militech employee family. "; }
    public static func CORPO_BOARDING() -> String { return "Sent to corporate boarding school at age six. "; }
    public static func EXEC_CHILD() -> String { return "Raised as the child of a corporate executive. "; }
    public static func CORPO_DYNASTY() -> String { return "Born into a corporate dynasty stretching back generations. "; }
    // === NEUTRAL/MIXED ===
    public static func SNGL_MOT() -> String { return "Raised by a single mother. "; }
    public static func SNGL_FAT() -> String { return "Raised by a single father. "; }
    public static func HLCPT_PRNTS() -> String { return "Grew up with helicopter parents. "; }
    public static func UNCR_PRNTS() -> String { return "Grew up with uncaring parents. "; }
    public static func WORKAHOLIC() -> String { return "Raised by workaholic parents who were rarely home. "; }
    public static func LATCHKEY() -> String { return "Was a latchkey kid, coming home to an empty apartment. "; }
    public static func SHARED_CUSTODY() -> String { return "Raised in a shared custody arrangement. "; }
    public static func OLDER_SIBLING() -> String { return "Primarily raised by an older sibling. "; }
    public static func NANNY_RAISED() -> String { return "Raised primarily by a hired nanny. "; }
    public static func BD_HD_PRNTS() -> String { return "Raised by absent BD-head parents. "; }
    public static func CHEM_ADDICT() -> String { return "Raised by a chem-addicted parent. "; }
    public static func GANG_FAM() -> String { return "Raised in a family with gang affiliations. "; }
    // === NOMAD ===
    public static func RGH_NOMAD() -> String { return "Raised in a rough Nomad pack. "; }
    public static func ALDECALDOS() -> String { return "Raised in the Aldecaldos clan. "; }
    public static func WRAITH_CHILD() -> String { return "Raised among the Wraiths in the badlands. "; }
    public static func NOMAD_CONVOY() -> String { return "Spent childhood moving with a nomad convoy. "; }
    public static func RAFFEN_SHIV() -> String { return "Raised by Raffen Shiv outcasts. "; }
    public static func BAKKERS() -> String { return "Raised in the Bakkers clan. "; }
    public static func SNAKE_NATION() -> String { return "Raised in the Snake Nation. "; }
    public static func JODES() -> String { return "Raised in the Jodes family. "; }
    // === NEGATIVE/TRAUMATIC ===
    public static func UNWLNG_GPRNTS() -> String { return "Unwillingly raised by %his% grandparents. "; }
    public static func UNWLNG_RLTIVS() -> String { return "Unwillingly raised by %his% relatives. "; }
    public static func MDCRE_FOSTER() -> String { return "Raised in a series of mediocre foster homes. "; }
    public static func MDCRE_ORPHN() -> String { return "Raised in a mediocre orphanage until %he% came of age. "; }
    public static func ABSV_FOSTER() -> String { return "Raised in a series of abusive foster homes. "; }
    public static func TRB_ORPHN() -> String { return "Raised in a terrible orphanage until %he% came of age. "; }
    public static func ABON_CHILD() -> String { return "Abandoned as a child. "; }
    public static func STRTS_NOPRNTS() -> String { return "Grew up on the street, never knew %his% parents. "; }
    public static func SLD_BY_PRNTS() -> String { return "Parents sold %him% for money. "; }
    public static func TRD_FOR_CHEM() -> String { return "Parents traded %him% for chems. "; }
    public static func VLNT_MGTWR() -> String { return "Grew up in the dark corners of a violent megatower. "; }
    public static func GRP_SCAVS() -> String { return "Raised by a group of scavengers. "; }
    public static func CHILD_SOLDIER() -> String { return "Raised as a child soldier in the corporate wars. "; }
    public static func TRAFFICKING() -> String { return "Rescued from a human trafficking ring as a child. "; }
    public static func CULT_RAISED() -> String { return "Raised in an isolated cult compound. "; }
    public static func ABUSIVE_HOME() -> String { return "Raised in an abusive household. "; }
    // === EXPERIMENTAL/UNUSUAL ===
    public static func VTGRN_LAB() -> String { return "Was vatgrown in a lab and raised by scientists. "; }
    public static func RAISED_BY_AI() -> String { return "Raised by an artificial intelligence in a corpo research facility. "; }
    public static func GENE_ALTER() -> String { return "Underwent genetic alterations during fetal development. "; }
    public static func CONGT_DEFECT() -> String { return "Born in %year% with a congenital defect and was cryo-preserved until a cure was developed. "; }
    public static func CORPO_DEBT() -> String { return "Born into corpo debt of millions of eddies. "; }
    public static func CLONE_CHILD() -> String { return "Was cloned from a deceased corporate executive. "; }
    public static func CYBORG_BABY() -> String { return "Received cybernetic implants before age two. "; }
    public static func EXPERIMENT() -> String { return "Raised as part of a corporate experimental program. "; }
    public static func ACCEL_GROWTH() -> String { return "Subjected to accelerated growth treatments as an infant. "; }
    // === PARENT STATUS ===
    public static func PAT_AVRG_CTZN() -> String { return "Parents were average citizens. "; }
    public static func PAT_WLTH_CTZN() -> String { return "Parents became wealthy citizens. "; }
    public static func PARENT_FIXER() -> String { return "Parent was a well-known fixer. "; }
    public static func PARENT_MERC() -> String { return "Parent was a successful mercenary. "; }
    public static func PARENT_NETRUNNER() -> String { return "Parent was a legendary netrunner. "; }
    public static func PARENT_RIPPER() -> String { return "Parent was a respected ripperdoc. "; }
    public static func PRNTS_CRSH() -> String { return "Parents died in a car crash. "; }
    public static func MOT_ANSA() -> String { return "Mother has amnesia and doesn't remember %him%. "; }
    public static func FAT_ANSA() -> String { return "Father has amnesia and doesn't remember %him%. "; }
    public static func FAM_KLD_NCPD() -> String { return "Parents and extended family killed by NCPD. "; }
    public static func PAT_GNG_WRFR() -> String { return "Parents killed in gang warfare. "; }
    public static func MOT_UNID() -> String { return "Mother unidentified. "; }
    public static func FAT_UNID() -> String { return "Father unidentified. "; }
    public static func MOT_KLD_NCPD() -> String { return "Mother killed by NCPD. "; }
    public static func FAT_KLD_NCPD() -> String { return "Father killed by NCPD. "; }
    public static func MOT_KLD_MXTC() -> String { return "Mother killed by Max-Tac. "; }
    public static func FAT_KLD_MXTC() -> String { return "Father killed by Max-Tac. "; }
    public static func MOT_POW() -> String { return "Mother is a prisoner of war. "; }
    public static func FAT_POW() -> String { return "Father is a prisoner of war. "; }
    public static func MOT_INCR() -> String { return "Mother is incarcerated. "; }
    public static func FAT_INCR() -> String { return "Father is incarcerated. "; }
    public static func MOT_DIE_NAT() -> String { return "Mother died of natural causes. "; }
    public static func FAT_DIE_NAT() -> String { return "Father died of natural causes. "; }
    public static func MOT_WRK_CRP() -> String { return "Mother worked for the %corp% Corporation. "; }
    public static func FAT_WRK_CRP() -> String { return "Father worked for the %corp% Corporation. "; }
    public static func MOT_MRD_CRP() -> String { return "Mother murdered by the %corp% Corporation. "; }
    public static func FAT_MRD_CRP() -> String { return "Father murdered by the %corp% Corporation. "; }
    public static func MOT_KLD_WAR() -> String { return "Mother killed in warfare. "; }
    public static func FAT_KLD_WAR() -> String { return "Father killed in warfare. "; }
    public static func MOT_DIED_ACC() -> String { return "Mother died in an accident. "; }
    public static func FAT_DIED_ACC() -> String { return "Father died in an accident. "; }
    public static func MOT_HIDING() -> String { return "Mother is in hiding. "; }
    public static func FAT_HIDING() -> String { return "Father is in hiding. "; }
    public static func MOT_MISSING() -> String { return "Mother is missing and presumed deceased. "; }
    public static func FAT_MISSING() -> String { return "Father is missing and presumed deceased. "; }
    public static func PARENT_CYBER() -> String { return "Parent went cyberpsycho when %he% was young. "; }
    public static func PARENT_SOULKILL() -> String { return "Parent was soulkilled by Arasaka. "; }
    // === EXPANDED: FAMILY STRUCTURE ===
    public static func ONLY_CHILD() -> String { return "Grew up as an only child. "; }
    public static func MANY_SIBLINGS() -> String { return "Grew up with many siblings in a crowded household. "; }
    public static func TWIN() -> String { return "Has a twin sibling. "; }
    public static func TRIPLET() -> String { return "Born as one of triplets. "; }
    public static func OLDEST_SIBLING() -> String { return "Eldest of several siblings, had to grow up fast. "; }
    public static func MIDDLE_CHILD() -> String { return "Middle child, often overlooked growing up. "; }
    public static func YOUNGEST_SIBLING() -> String { return "Baby of the family, spoiled by older siblings. "; }
    public static func STEP_FAMILY() -> String { return "Raised by a step-parent after remarriage. "; }
    public static func BLENDED_FAM() -> String { return "Grew up in a blended family with step-siblings. "; }
    public static func ADOPTED_LATE() -> String { return "Adopted at an older age after years in the system. "; }
    // === EXPANDED: PARENTAL OCCUPATIONS ===
    public static func PARENT_NCPD() -> String { return "Parent served in the NCPD. "; }
    public static func PARENT_TEACHER() -> String { return "Parent was a teacher in the public school system. "; }
    public static func PARENT_DOCTOR() -> String { return "Parent worked as a medical professional. "; }
    public static func PARENT_JOYTOY() -> String { return "Parent worked as a joytoy to support the family. "; }
    public static func PARENT_DEALER() -> String { return "Parent dealt drugs to make ends meet. "; }
    public static func PARENT_MILITARY() -> String { return "Parent served in the military. "; }
    public static func PARENT_GANG_LEADER() -> String { return "Parent was a gang leader. "; }
    // === EXPANDED: PARENTAL TRAUMA ===
    public static func PARENT_SUICIDE() -> String { return "Parent committed suicide when %he% was young. "; }
    public static func PARENT_OVERDOSE() -> String { return "Parent died of an overdose. "; }
    public static func PARENT_ABUSER() -> String { return "Raised by an abusive parent. "; }
    public static func WITNESSED_PARENT_DEATH() -> String { return "Witnessed a parent's death as a child. "; }
    public static func SIBLING_DEATH_CHILD() -> String { return "Lost a sibling during childhood. "; }
    public static func HOME_INVASION() -> String { return "Survived a home invasion as a child. "; }
    public static func KIDNAPPED_CHILD() -> String { return "Was kidnapped as a child. "; }
    public static func FIRE_SURVIVOR_CHILD() -> String { return "Survived a fire that destroyed %his% childhood home. "; }
    // === EXPANDED: WEALTH/STATUS ===
    public static func BORN_RICH() -> String { return "Born into wealth and privilege. "; }
    public static func BORN_POOR() -> String { return "Born into poverty, struggled from the start. "; }
    public static func LOST_WEALTH() -> String { return "Family lost everything when %he% was young. "; }
    public static func TRUST_FUND() -> String { return "Inherited a trust fund from a wealthy relative. "; }
    public static func BORN_DEBT() -> String { return "Born into a family crushed by corporate debt. "; }
    public static func FAMILY_BUSINESS() -> String { return "Grew up working in the family business. "; }
    public static func FAMILY_CRIME() -> String { return "Family ran a criminal enterprise. "; }
    // === EXPANDED: SPECIAL ORIGINS ===
    public static func LAB_BORN() -> String { return "Born in a corporate laboratory. "; }
    public static func TEST_TUBE() -> String { return "Test tube baby, never knew biological parents. "; }
    public static func CLONE() -> String { return "Clone of a wealthy individual. "; }
    public static func BORN_CULT() -> String { return "Born into a religious cult. "; }
    public static func RAISED_CULT() -> String { return "Raised in an isolated cult compound. "; }
    public static func ESCAPED_CULT() -> String { return "Escaped from a cult as a teenager. "; }
    public static func COMMUNE_RAISED() -> String { return "Raised in an off-grid commune. "; }
    public static func REFUGEE_CHILD() -> String { return "Came to Night City as a refugee child. "; }
    public static func IMMIGRANT_CHILD() -> String { return "Child of immigrants, grew up between two cultures. "; }
    // === EXPANDED: FAMILY DYNAMICS ===
    public static func CHILD_PRODIGY_FAM() -> String { return "Was considered a child prodigy by %his% family. "; }
    public static func BLACK_SHEEP() -> String { return "Always the black sheep of the family. "; }
    public static func GOLDEN_CHILD() -> String { return "The golden child who could do no wrong. "; }
    public static func UNWANTED_CHILD() -> String { return "Born unwanted, raised with resentment. "; }
    public static func FAMILY_SECRET() -> String { return "Family kept a dark secret throughout %his% childhood. "; }
    // === EXPANDED: URBAN ENVIRONMENTS ===
    public static func COMBAT_ZONE() -> String { return "Raised in a combat zone. "; }
    public static func MEGATOWER_POOR() -> String { return "Raised in the lower levels of a megatower. "; }
    public static func MEGATOWER_MID() -> String { return "Raised in the middle levels of a megatower. "; }
    public static func MEGATOWER_HIGH() -> String { return "Raised in the upper levels of a megatower. "; }
    public static func INDUSTRIAL_ZONE() -> String { return "Grew up near an industrial zone. "; }
    public static func PACIFICA() -> String { return "Raised in the abandoned zones of Pacifica. "; }
    public static func WATSON_POOR() -> String { return "Grew up poor in Watson. "; }
    public static func HEYWOOD() -> String { return "Raised in the neighborhoods of Heywood. "; }
    public static func GLEN() -> String { return "Grew up in the Glen area. "; }
    // === EXPANDED: CULTURAL BACKGROUNDS ===
    public static func JAPANESE_CULTURE() -> String { return "Raised in a traditional Japanese household. "; }
    public static func CHINESE_CULTURE() -> String { return "Raised in a traditional Chinese household. "; }
    public static func LATINO_CULTURE() -> String { return "Raised in a tight-knit Latino community. "; }
    public static func SLAVIC_CULTURE() -> String { return "Raised in an Eastern European immigrant community. "; }
    public static func AFRICAN_CULTURE() -> String { return "Raised with strong African cultural traditions. "; }
    public static func MIXED_HERITAGE() -> String { return "Raised with a rich mixed cultural heritage. "; }
    // === EXPANDED: UNUSUAL CIRCUMSTANCES ===
    public static func BOAT_CHILD() -> String { return "Spent childhood living on a boat. "; }
    public static func CARNIVAL() -> String { return "Raised traveling with a carnival. "; }
    public static func PERFORMER_FAMILY() -> String { return "Raised in a family of performers. "; }
    public static func UNDERGROUND() -> String { return "Raised in Night City's underground communities. "; }
    public static func BUNKER() -> String { return "Spent early years in an emergency bunker. "; }
    public static func HOSPITAL_CHILD() -> String { return "Spent much of childhood in hospitals. "; }
    public static func WITNESS_PROTECTION() -> String { return "Raised in witness protection. "; }
    // === EXPANDED: FAMILY STRUCTURE ===
    public static func POLYAMORY() -> String { return "Raised in a polyamorous family unit. "; }
    public static func SURROGATE() -> String { return "Born via surrogacy to wealthy parents. "; }
    public static func UNKNOWN_FATHER() -> String { return "Never knew who %his% father was. "; }
    public static func UNKNOWN_MOTHER() -> String { return "Never knew who %his% mother was. "; }
    public static func LARGE_FAMILY() -> String { return "One of many siblings in a large family. "; }
    // === EXPANDED: MORE PARENTAL SITUATIONS ===
    public static func WORKAHOLIC_PARENTS() -> String { return "Parents were workaholics, rarely home. "; }
    public static func HELICOPTER_PARENTS() -> String { return "Had overprotective helicopter parents. "; }
    public static func NEGLECTFUL_PARENTS() -> String { return "Parents were emotionally neglectful. "; }
    public static func CRIMINAL_PARENTS() -> String { return "Both parents were criminals. "; }
    public static func ADDICTED_PARENTS() -> String { return "Parents struggled with addiction. "; }
    public static func DISABLED_PARENT() -> String { return "Had a disabled parent. "; }
    public static func FAMOUS_PARENT() -> String { return "Had a locally famous parent. "; }
    public static func MILITARY_FAMILY() -> String { return "Raised in a strict military family. "; }
    public static func RELIGIOUS_FAMILY() -> String { return "Raised in a strictly religious household. "; }
    public static func ATHEIST_FAMILY() -> String { return "Raised in an atheist household. "; }
    // === EXPANDED: SIBLING SITUATIONS ===
    public static func SIBLING_RIVALRY() -> String { return "Had intense sibling rivalry. "; }
    public static func SIBLING_PROTECTOR() -> String { return "Protected by an older sibling. "; }
    public static func SIBLING_PROTECTED() -> String { return "Had to protect younger siblings. "; }
    public static func SIBLING_CRIMINAL() -> String { return "Had a sibling who turned to crime. "; }
    public static func SIBLING_DEATH_UP() -> String { return "Lost a sibling in childhood. "; }
    public static func SIBLING_DISAPPEARED() -> String { return "A sibling disappeared when %he% was young. "; }
    public static func HALF_SIBLINGS() -> String { return "Has multiple half-siblings from different parents. "; }
    public static func ESTRANGED_SIBLING() -> String { return "Estranged from siblings since childhood. "; }
    // === EXPANDED: ECONOMIC SITUATIONS ===
    public static func PAYCHECK_TO_PAYCHECK() -> String { return "Family lived paycheck to paycheck. "; }
    public static func FOOD_INSECURITY() -> String { return "Often went hungry as a child. "; }
    public static func WELFARE_KID() -> String { return "Grew up on welfare programs. "; }
    public static func LOTTERY_FAMILY() -> String { return "Family won the lottery and squandered it. "; }
    public static func BANKRUPTCY_FAM() -> String { return "Family went bankrupt when %he% was young. "; }
    public static func INHERITANCE_CHILD() -> String { return "Received inheritance as a child. "; }
    public static func EVICTED_CHILD() -> String { return "Family was evicted multiple times. "; }
    public static func HOMELESS_CHILD() -> String { return "Was homeless as a young child. "; }
    // === EXPANDED: TRAUMA ===
    public static func WITNESSED_VIOLENCE() -> String { return "Witnessed domestic violence. "; }
    public static func FAMILY_MURDER() -> String { return "A family member was murdered. "; }
    public static func FAMILY_ACCIDENT() -> String { return "Lost family in a terrible accident. "; }
    public static func NATURAL_DISASTER() -> String { return "Survived a natural disaster as a child. "; }
    public static func WAR_CHILD() -> String { return "Grew up during a war. "; }
    public static func KIDNAPPED_RANSOM() -> String { return "Was kidnapped for ransom as a child. "; }
    public static func HUMAN_TRAFFICKING() -> String { return "Was a victim of human trafficking. "; }
    public static func BULLIED_SEVERE() -> String { return "Severely bullied throughout childhood. "; }
    // === EXPANDED: POSITIVE CHILDHOOD ===
    public static func HAPPY_CHILDHOOD() -> String { return "Had a relatively happy childhood. "; }
    public static func LOVING_FAMILY() -> String { return "Raised in a loving family. "; }
    public static func STABLE_HOME() -> String { return "Had a stable home environment. "; }
    public static func GOOD_EDUCATION() -> String { return "Received a good education. "; }
    public static func SUPPORTIVE_PARENTS() -> String { return "Had supportive parents. "; }
    public static func OPPORTUNITIES() -> String { return "Had many opportunities growing up. "; }
    public static func TRAVELED() -> String { return "Traveled extensively as a child. "; }
    public static func PRIVILEGED() -> String { return "Had a privileged upbringing. "; }
    // === EXPANDED: NIGHT CITY SPECIFIC ===
    public static func NC_NATIVE() -> String { return "Born and raised in Night City. "; }
    public static func MEGABUILDING_RAISED() -> String { return "Grew up entirely inside a megabuilding. "; }
    public static func COMBAT_ZONE_RAISED() -> String { return "Raised in a combat zone. "; }
    public static func NOMAD_CAMP_RAISED() -> String { return "Raised in a nomad camp in the Badlands. "; }
    public static func CORPO_ENCLAVE() -> String { return "Grew up in a corporate residential enclave. "; }
    public static func PACIFICA_BORN() -> String { return "Born in Pacifica before the collapse. "; }
    // === EXPANDED: PARENTAL OCCUPATIONS ===
    public static func PARENT_SCAVENGER() -> String { return "Had a parent who scavenged for a living. "; }
    // === EXPANDED: EARLY EXPERIENCES ===
    public static func FIRST_GUN_YOUNG() -> String { return "Was given %his% first gun at age ten. "; }
    public static func LOCKDOWN_CHILDHOOD() -> String { return "Spent much of childhood in lockdown. "; }
    public static func CORPO_DAYCARE() -> String { return "Grew up in corporate daycare programs. "; }
    public static func RAISED_ON_KIBBLE() -> String { return "Grew up eating nothing but kibble. "; }
    public static func MUSIC_HOUSEHOLD() -> String { return "Grew up in a household full of music. "; }
    public static func VIOLENCE_NORMAL() -> String { return "Violence was a normal part of childhood. "; }
    // === EXPANDED: FAMILY SITUATIONS ===
    public static func ADOPTED_DIFFERENT() -> String { return "Was adopted by a family of different ethnicity. "; }
    public static func MIXED_GANG_FAMILY() -> String { return "Family members belonged to different gangs. "; }
}

