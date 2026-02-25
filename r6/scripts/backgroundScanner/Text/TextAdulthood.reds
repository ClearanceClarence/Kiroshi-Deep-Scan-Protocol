// Adult life events
public abstract class KdspTextAdulthood {
    // === FINANCIAL ===
    public static func LOST_GAMBLE() -> String { return "Lost €$%eddies% Eurodollars gambling. "; }
    public static func WON_LOTTERY() -> String { return "Won a scratch-off. "; }
    public static func BOUGHT_CAR() -> String { return "Bought a car. "; }
    public static func NEW_APT() -> String { return "Moved into a new apartment. "; }
    public static func ASST_SZD_CRP() -> String { return "All assets were seized by the %corp% Corporation. "; }
    public static func CHRG_BK_DBTR() -> String { return "Charged as a bankrupt debtor. "; }
    public static func CHRG_MED_DBT() -> String { return "Charged as a medical debtor. "; }
    public static func INDEBT_CRP_INDVL() -> String { return "Indebted to the %corp% Corporation. Individual reassigned as a corporate asset. "; }
    public static func HAB_CRP_DBTR() -> String { return "Charged as a habitual corporate debtor. "; }
    public static func INHERITANCE() -> String { return "Received a small inheritance. "; }
    public static func LOST_SAVINGS() -> String { return "Lost all savings in a market crash. "; }
    public static func CRYPTO() -> String { return "Got rich on cryptocurrency before losing it all. "; }
    public static func EVICTED() -> String { return "Was evicted from home. "; }
    public static func REPO_CAR() -> String { return "Had car repossessed. "; }
    // === CAREER ===
    public static func LOST_JOB() -> String { return "Lost %his% job. "; }
    public static func COMPLETED_JOB() -> String { return "Completed a job for a fixer and received a €$%eddies% payout. "; }
    public static func RADIO_JOCKEY() -> String { return "Moonlighted as a radio jockey. "; }
    public static func PROMOTION() -> String { return "Received a promotion. "; }
    public static func FIRED() -> String { return "Was fired for misconduct. "; }
    public static func BLACKLISTED() -> String { return "Was blacklisted from an industry. "; }
    public static func WHISTLEBLOWER() -> String { return "Became a corporate whistleblower. "; }
    public static func STARTED_BIZ() -> String { return "Started a small business. "; }
    public static func BIZ_FAILED() -> String { return "Business venture failed catastrophically. "; }
    public static func UNION() -> String { return "Became a union organizer. "; }
    public static func STRIKE() -> String { return "Participated in a workers' strike. "; }
    // === CRIMINAL / LEGAL ===
    public static func IMPRISONED() -> String { return "Was imprisoned for %years% years. "; }
    public static func ROB_BODEGA() -> String { return "Was involved in a robbery at a bodega. "; }
    public static func ROB_VENDOR() -> String { return "Was involved in a robbery at a street food vendor. "; }
    public static func RUN_CHEMS() -> String { return "Began running chems for a local gang. "; }
    public static func KILLED_CHOOM() -> String { return "Killed an unlucky choom. "; }
    public static func JOINED_RIOT() -> String { return "Was involved in a riot. "; }
    public static func CODED_BOTNETS() -> String { return "Coded synchronized botnets to attack the %corp% Corporation access points, stealing €$%eddies% Eurodollars. "; }
    public static func STOLE_EQP() -> String { return "Stole some high-tech equipment from %corp%. "; }
    public static func FILED_FRD_INS() -> String { return "Filed a fraudulent insurance claim. "; }
    public static func CRP_LBLTY_DFDT() -> String { return "Charged as a corporate liability defendant. "; }
    public static func CRP_POL_VIO() -> String { return "Charged as a corporate policies violator. "; }
    public static func ARMED_DANGER() -> String { return "Notoriously armed and dangerous. "; }
    public static func FLSLY_ACC_MRDR() -> String { return "Was falsely accused of murder and imprisoned for %years% horrifying years. "; }
    public static func FREE_CRP_MRDR() -> String { return "Was accused of corporate-sanctioned murders with video evidence, but charges were dismissed on technicalities. "; }
    public static func ROBOT_DEST() -> String { return "Was involved in the destruction of one Arasaka Robot R MK.2. "; }
    public static func BUILD_BOMB() -> String { return "Meets with known terrorists, while building a dirty bomb with scavenged ordinance and electronics. "; }
    public static func ARRESTED() -> String { return "Was arrested by NCPD. "; }
    public static func PAROLE() -> String { return "Currently on parole. "; }
    public static func BOUNTY() -> String { return "Has an active bounty. "; }
    public static func WITNESS_PROT() -> String { return "Entered witness protection briefly. "; }
    // === CYBERWARE / MEDICAL ===
    public static func INST_NEW_AUG() -> String { return "Installed a new cybernetic augmentation. "; }
    public static func BOUGHT_CYBER() -> String { return "Bought cybernetics. "; }
    public static func CANCEL_TTI() -> String { return "Canceled %his% Trauma Team Insurance. "; }
    public static func FREE_TTI() -> String { return "Signed up as a human guinea pig receiving injections in stem cell chimera trials. Earned a voucher for one free month of Trauma Team Premium. "; }
    // Expanded Adulthood - Career/Work
    public static func FREELANCE() -> String { return "Works as a freelancer, taking gigs where %he% can find them. "; }
    public static func CORPO_FIRED() -> String { return "Was fired from a corpo job under suspicious circumstances. "; }
    public static func CORPO_BURNOUT() -> String { return "Burned out from the corporate grind. "; }
    public static func SECOND_JOB() -> String { return "Works a second job just to make ends meet. "; }
    public static func THIRD_SHIFT() -> String { return "Works the third shift at a factory. "; }
    public static func GIG_ECONOMY() -> String { return "Survives on gig economy work. "; }
    public static func SCAB_WORKER() -> String { return "Worked as a scab during a labor strike. "; }
    public static func CORPO_LADDER() -> String { return "Climbed the corporate ladder through ruthless ambition. "; }
    public static func DEMOTED() -> String { return "Was demoted after a corporate restructuring. "; }
    public static func FIXER_REP() -> String { return "Has built a reputation with local fixers. "; }
    public static func SOLO_WORK() -> String { return "Does solo work for various clients. "; }
    public static func NETRUNNER_GIG() -> String { return "Takes netrunning gigs on the side. "; }
    public static func TECHIE_REP() -> String { return "Known for %his% technical expertise. "; }
    public static func MERC_CONTRACT() -> String { return "Completed a lucrative merc contract. "; }
    public static func BOTCHED_JOB() -> String { return "Botched a job and is still paying for it. "; }
    // Expanded Adulthood - Financial
    public static func LOAN_SHARK() -> String { return "Owes money to a dangerous loan shark. "; }
    public static func PAID_DEBT() -> String { return "Finally paid off a crushing debt. "; }
    public static func SCAMMED() -> String { return "Was scammed out of %his% life savings. "; }
    public static func SCAMMER() -> String { return "Runs scams to make a living. "; }
    public static func UNDERGROUND_CASINO() -> String { return "Lost big at an underground casino. "; }
    public static func BIG_SCORE() -> String { return "Pulled off a big score that set %him% up for years. "; }
    public static func LOST_SCORE() -> String { return "Lost a big score to betrayal. "; }
    public static func STOCK_CRASH() -> String { return "Lost everything in a stock market crash. "; }
    public static func INSURANCE_FRAUD() -> String { return "Committed insurance fraud to survive. "; }
    public static func TAX_EVASION() -> String { return "Under investigation for tax evasion. "; }
    public static func WIRE_TRANSFER() -> String { return "Received a mysterious wire transfer. "; }
    public static func MONEY_LAUNDERING() -> String { return "Involved in a money laundering operation. "; }
    // Expanded Adulthood - Criminal
    public static func HEIST() -> String { return "Participated in a high-profile heist. "; }
    public static func SMUGGLING() -> String { return "Does smuggling runs across borders. "; }
    public static func BLACKMAIL() -> String { return "Blackmails people for a living. "; }
    public static func BLACKMAILED() -> String { return "Is being blackmailed by an unknown party. "; }
    public static func FENCE() -> String { return "Works as a fence for stolen goods. "; }
    public static func CARJACKING() -> String { return "Has a history of carjacking. "; }
    public static func KIDNAPPING() -> String { return "Was involved in a kidnapping operation. "; }
    public static func KIDNAPPED() -> String { return "Was kidnapped and held for ransom. "; }
    public static func ARSON() -> String { return "Committed arson for hire. "; }
    public static func CONTRACT_KILL() -> String { return "Carried out a contract killing. "; }
    public static func WITNESS_KILL() -> String { return "Eliminated a witness to a crime. "; }
    public static func EVIDENCE_TAMPER() -> String { return "Tampered with evidence in a criminal case. "; }
    public static func BRIBED_NCPD() -> String { return "Has NCPD officers on the payroll. "; }
    public static func FRAMED() -> String { return "Was framed for a crime %he% didn't commit. "; }
    public static func PRISON_BREAK() -> String { return "Escaped from prison. "; }
    public static func PAROLE_VIOL() -> String { return "Violated parole and is on the run. "; }
    // Expanded Adulthood - Relationships
    public static func MARRIED() -> String { return "Is married. "; }
    public static func DIVORCED() -> String { return "Recently divorced. "; }
    public static func AFFAIR() -> String { return "Is having an affair. "; }
    public static func AFFAIR_VICTIM() -> String { return "Partner had an affair. "; }
    public static func HAD_CHILD() -> String { return "Has a child. "; }
    public static func LOST_CHILD() -> String { return "Lost a child to violence. "; }
    public static func CHILD_TAKEN() -> String { return "Child was taken by authorities. "; }
    public static func ORPHANED() -> String { return "Became an orphan as an adult. "; }
    public static func SIBLING_DEATH() -> String { return "Lost a sibling recently. "; }
    public static func REUNITED_FAM() -> String { return "Reunited with long-lost family. "; }
    public static func DISOWNED() -> String { return "Was disowned by %his% family. "; }
    public static func BEST_FRIEND_DEAD() -> String { return "Best friend was killed. "; }
    public static func BETRAYED_FRIEND() -> String { return "Was betrayed by a close friend. "; }
    public static func BETRAYED_SOMEONE() -> String { return "Betrayed someone close for personal gain. "; }
    public static func ROMANTIC() -> String { return "In a romantic relationship. "; }
    public static func HEARTBROKEN() -> String { return "Recovering from heartbreak. "; }
    // Expanded Adulthood - Cyberware/Tech
    public static func CHROME_ADDICTION() -> String { return "Addicted to getting new chrome. "; }
    public static func CYBER_REJECTION() -> String { return "Body rejected cyberware implants. "; }
    public static func BLACK_MARKET_CHROME() -> String { return "Running black market chrome. "; }
    public static func CYBERWARE_HACK() -> String { return "Had cyberware hacked by a netrunner. "; }
    public static func MALFUNC_CHROME() -> String { return "Suffering from malfunctioning chrome. "; }
    public static func CHEAP_RIPPER() -> String { return "Got bad chrome from a cheap ripper. "; }
    public static func PREMIUM_CHROME() -> String { return "Has premium military-grade chrome. "; }
    public static func CYBERPSYCHO_SCARE() -> String { return "Had a cyberpsychosis scare. "; }
    public static func LIMB_REPLACEMENT() -> String { return "Has a cybernetic limb replacement. "; }
    public static func EYE_REPLACEMENT() -> String { return "Has cybernetic eye replacements. "; }
    public static func NEURAL_DAMAGE() -> String { return "Suffering from neural interface damage. "; }
    public static func BRAINDANCE_DAMAGE() -> String { return "Has brain damage from BD addiction. "; }
    // Expanded Adulthood - Gang Related
    public static func JOINED_GANG() -> String { return "Joined a gang as an adult. "; }
    public static func LEFT_GANG() -> String { return "Left %his% gang and is marked for death. "; }
    public static func GANG_INITIATION() -> String { return "Passed a brutal gang initiation. "; }
    public static func GANG_PROMOTION() -> String { return "Was promoted within the gang hierarchy. "; }
    public static func GANG_EXILE() -> String { return "Exiled from %his% gang. "; }
    public static func TURF_WAR() -> String { return "Veteran of multiple turf wars. "; }
    public static func GANG_TATTOO() -> String { return "Has visible gang tattoos. "; }
    public static func GANG_DEBT() -> String { return "Owes a debt to a gang. "; }
    public static func PROTECTED() -> String { return "Under gang protection. "; }
    public static func PROTECTION_RACKET() -> String { return "Runs a protection racket. "; }
    // Expanded Adulthood - Violence/Trauma
    public static func TORTURE_VICTIM() -> String { return "Was tortured for information. "; }
    public static func TORTURE_PERPETRATOR() -> String { return "Has tortured others for information. "; }
    public static func AMBUSHED() -> String { return "Survived an ambush. "; }
    public static func CAR_BOMB() -> String { return "Survived a car bomb attack. "; }
    public static func HOSTAGE() -> String { return "Was held hostage. "; }
    public static func HOSTAGE_TAKER() -> String { return "Has taken hostages. "; }
    public static func COMBAT_VET() -> String { return "Combat veteran. "; }
    public static func PTSD() -> String { return "Suffers from PTSD. "; }
    public static func EXPLOSION() -> String { return "Survived an explosion. "; }
    public static func CHEMICAL_EXP() -> String { return "Was exposed to toxic chemicals. "; }
    public static func RADIATION_EXP() -> String { return "Was exposed to radiation. "; }
    // Expanded Adulthood - Misc Life Events
    public static func NEAR_DEATH() -> String { return "Had a near-death experience. "; }
    public static func FLATLINED() -> String { return "Flatlined and was resuscitated. "; }
    public static func COMA() -> String { return "Was in a coma for months. "; }
    public static func HOMELESS() -> String { return "Was homeless for a period. "; }
    public static func REFUGEE() -> String { return "Was a refugee from another city. "; }
    public static func ILLEGAL_IMMIGRANT() -> String { return "Illegal immigrant status. "; }
    public static func DEPORTATION() -> String { return "Facing deportation. "; }
    public static func CITIZENSHIP() -> String { return "Recently gained citizenship. "; }
    public static func FAMOUS() -> String { return "Briefly famous in Night City. "; }
    public static func VIRAL() -> String { return "Went viral on the net. "; }
    public static func SCANDAL() -> String { return "Involved in a public scandal. "; }
    public static func MEDIA_TARGET() -> String { return "Target of a media smear campaign. "; }
    public static func EDUCATED() -> String { return "Has a college education. "; }
    public static func DROPPED_OUT() -> String { return "Dropped out of college. "; }
    public static func MENTOR() -> String { return "Mentors younger people. "; }
    public static func MENTORED() -> String { return "Was mentored by a professional. "; }
    public static func CLUB_REGULAR() -> String { return "Regular at Night City clubs. "; }
    public static func LIZZIE_REGULAR() -> String { return "Regular at Lizzie's Bar. "; }
    public static func TOTENTANZ() -> String { return "Frequents Totentanz. "; }
    public static func EMBERS() -> String { return "VIP at Embers. "; }
    public static func CYBERPSYCHO_WIT() -> String { return "Witnessed a cyberpsycho attack. "; }
    public static func SURVIVED_MAXTAC() -> String { return "Survived a MaxTac encounter. "; }
    public static func CAR_ACCIDENT() -> String { return "Was in a car accident. "; }
    public static func INDUSTRIAL_ACC() -> String { return "Was in an industrial accident. "; }
    public static func CHROME_REJECT() -> String { return "Suffered chrome rejection and had implants removed. "; }
    public static func BOOTLEG_CHROME() -> String { return "Installed bootleg chrome that caused complications. "; }
    public static func SURGERY() -> String { return "Underwent major surgery. "; }
    public static func CHRONIC() -> String { return "Developed a chronic illness. "; }
    // === SUBSTANCES ===
    public static func BCME_CHEMHEAD() -> String { return "Became a chemhead. "; }
    public static func TOB_CONSUMER() -> String { return "Tobacco consumer. "; }
    public static func AL_BEV_CONSUMER() -> String { return "Alcoholic beverage consumer. "; }
    public static func BD_CONSUMER() -> String { return "Braindance customer. "; }
    public static func BD_ADDICT() -> String { return "Braindance addict. "; }
    public static func CLEAN() -> String { return "Got clean and sober. "; }
    public static func OVERDOSED() -> String { return "Overdosed and nearly died. "; }
    public static func REHAB() -> String { return "Went through rehabilitation. "; }
    // === CONSUMER / LIFESTYLE ===
    public static func WATER_CONSUMER() -> String { return "Real Water subscriber. "; }
    public static func JOYTOY_CONSUMER() -> String { return "Joytoy customer. "; }
    public static func RELIC_ASPIRANT() -> String { return "Relic aspirant. "; }
    public static func BOUGHT_SHARD() -> String { return "Bought a shard. "; }
    public static func BOUGHT_GUN() -> String { return "Bought a firearm. "; }
    public static func BOUGHT_SWORD() -> String { return "Bought a sword. "; }
    public static func TWO_AM_CLUB() -> String { return "2nd Amendment club member. "; }
    public static func VAC_AFRICA() -> String { return "Vacationed in sunny Africa. "; }
    public static func JUMP_TRAFFIC() -> String { return "Jumps into traffic daily at heights and crosswalks. "; }
    public static func EMAIL_GOV() -> String { return "Composes hopeless policy emails to government officials. Deletes %his% eloquent manifesto in despair without sending. InfoComp retains backup copies. "; }
    public static func GYM() -> String { return "Joined a gym. "; }
    public static func PILGRIMAGE() -> String { return "Went on a spiritual pilgrimage. "; }
    // === RELATIONSHIPS ===
    public static func PARTNER_DIED() -> String { return "Partner died tragically. "; }
    public static func BETRAYED() -> String { return "Was betrayed by a close friend. "; }
    public static func RECONNECT_FAM() -> String { return "Reconnected with estranged family. "; }
    public static func CUT_FAM() -> String { return "Cut off contact with family. "; }
    // === MUSIC / ENTERTAINMENT ===
    public static func JOIN_NEW_BAND() -> String { return "Joined a new band. "; }
    public static func BAND_BROKE() -> String { return "Band broke up. "; }
    public static func ALBUM() -> String { return "Released an album. "; }
    // === VIOLENCE / COMBAT ===
    public static func SURVIVED_ATK() -> String { return "Survived a violent attack. "; }
    public static func KILLED_DEFENSE() -> String { return "Killed someone in self-defense. "; }
    public static func GANG_WAR() -> String { return "Survived a gang war. "; }
    public static func SHOT() -> String { return "Was shot and survived. "; }
    public static func STABBED() -> String { return "Was stabbed and survived. "; }
    public static func LEFT_DEAD() -> String { return "Was left for dead but survived. "; }
    // === MISC ===
    public static func MOVED_NC() -> String { return "Moved to Night City. "; }
    public static func LEFT_NC() -> String { return "Left Night City temporarily. "; }
    public static func JOINED_CULT() -> String { return "Joined a cult. "; }
    public static func LEFT_CULT() -> String { return "Left a cult. "; }
    public static func BECAME_NOMAD() -> String { return "Left city life to become a nomad. "; }
    public static func LEFT_NOMADS() -> String { return "Left nomad life for the city. "; }
    public static func ID_CHANGE() -> String { return "Changed identity to escape past. "; }
    public static func WENT_MISSING() -> String { return "Went missing for several months. "; }
    public static func MEMORY_LOSS() -> String { return "Suffered partial memory loss. "; }
    public static func FOUND_FAITH() -> String { return "Found faith in a higher power. "; }
    public static func LOST_FAITH() -> String { return "Lost faith entirely. "; }
    public static func POLITICAL() -> String { return "Had a political awakening. "; }
    public static func ACTIVISM() -> String { return "Became involved in activism. "; }
    // === EXPANDED: RELATIONSHIPS ===
    public static func HEARTBROKEN_ADULT() -> String { return "Had %his% heart broken in adulthood. "; }
    // === EXPANDED: GANG INVOLVEMENT ===
    public static func JOINED_GANG_ADULT() -> String { return "Joined a gang later in life. "; }
    // === EXPANDED: MENTORSHIP ===
    public static func MENTORED_ADULT() -> String { return "Found a mentor who changed %his% life. "; }
    // === EXPANDED: NEAR-DEATH ===
    public static func NEAR_DEATH_ADULT() -> String { return "Nearly died as an adult. "; }
    // === EXPANDED: CAREER ===
    public static func PROMOTED() -> String { return "Got promoted at work. "; }
    public static func FIRED_UNFAIRLY() -> String { return "Was fired unfairly. "; }
    public static func STARTED_BUSINESS() -> String { return "Started a small business. "; }
    public static func BUSINESS_FAILED() -> String { return "Had a business venture fail. "; }
    public static func CAREER_CHANGE() -> String { return "Made a major career change. "; }
    // === EXPANDED: CRIME ===
    public static func FIRST_KILL() -> String { return "Committed %his% first kill. "; }
    public static func HITMAN_JOB() -> String { return "Took a job as a hitman. "; }
    public static func HEIST_SUCCESS() -> String { return "Pulled off a successful heist. "; }
    public static func HEIST_FAILED() -> String { return "Had a heist go wrong. "; }
    public static func INFORMANT() -> String { return "Became a police informant. "; }
    public static func WITNESS_PROTECTION() -> String { return "Entered witness protection. "; }
    // === EXPANDED: TRAUMA ===
    public static func MUGGED() -> String { return "Was violently mugged. "; }
    public static func HOME_INVASION() -> String { return "Survived a home invasion. "; }
    public static func TORTURED() -> String { return "Was tortured for information. "; }
    public static func BUILDING_COLLAPSE() -> String { return "Survived a building collapse. "; }
    // === EXPANDED: RELATIONSHIPS ===
    public static func GOT_MARRIED() -> String { return "Got married. "; }
    public static func GOT_DIVORCED() -> String { return "Got divorced. "; }
    public static func SPOUSE_DIED() -> String { return "Lost a spouse to violence. "; }
    public static func CHILD_DIED() -> String { return "Lost a child. "; }
    public static func CAUGHT_CHEATING() -> String { return "Was caught cheating. "; }
    public static func RECONCILED() -> String { return "Reconciled with estranged family. "; }
    // === EXPANDED: HEALTH ===
    public static func DIAGNOSED_ILLNESS() -> String { return "Was diagnosed with a serious illness. "; }
    public static func BEAT_ILLNESS() -> String { return "Beat a serious illness. "; }
    public static func CYBERWARE_REJECTION() -> String { return "Suffered cyberware rejection syndrome. "; }
    public static func ORGAN_REPLACEMENT() -> String { return "Had an organ replaced with cyberware. "; }
    public static func BRAIN_DAMAGE() -> String { return "Suffered brain damage from an accident. "; }
    public static func LOST_LIMB() -> String { return "Lost a limb and got a cybernetic replacement. "; }
    // === EXPANDED: SUCCESS ===
    public static func LOTTERY_WIN() -> String { return "Won a small lottery. "; }
    public static func FAMOUS_BRIEFLY() -> String { return "Was briefly famous. "; }
    public static func VIRAL_MOMENT() -> String { return "Had a viral moment on the net. "; }
    public static func SAVED_SOMEONE() -> String { return "Saved someone's life. "; }
    public static func AWARD() -> String { return "Won a professional award. "; }
    // === EXPANDED: MISC ===
    public static func WENT_CORPO() -> String { return "Went corporate after years on the street. "; }
    public static func LEFT_CORPO() -> String { return "Left the corporate world behind. "; }
    public static func MOVED_DISTRICT() -> String { return "Moved to a different district. "; }
    public static func HOMELESS_PERIOD() -> String { return "Spent time homeless. "; }
    public static func DEBT_CRISIS() -> String { return "Went through a severe debt crisis. "; }
    public static func IDENTITY_STOLEN() -> String { return "Had identity stolen. "; }
    // === EXPANDED: VIOLENCE ===
    public static func DRIVE_BY() -> String { return "Survived a drive-by shooting. "; }
    public static func GANG_BEATING() -> String { return "Received a gang beating. "; }
    public static func CARJACKED() -> String { return "Was carjacked at gunpoint. "; }
    // === EXPANDED: WORK DRAMA ===
    public static func WORKPLACE_AFFAIR() -> String { return "Had an affair at work. "; }
    public static func WORKPLACE_ENEMY() -> String { return "Made a bitter enemy at work. "; }
    public static func QUIT_DRAMATICALLY() -> String { return "Quit a job dramatically. "; }
    public static func CORPORATE_PURGE() -> String { return "Survived a corporate purge. "; }
    public static func LAYOFF() -> String { return "Was laid off unexpectedly. "; }
    public static func DEMOTION() -> String { return "Was demoted at work. "; }
    public static func TRANSFERRED() -> String { return "Was transferred against %his% will. "; }
    // === EXPANDED: PERSONAL GROWTH ===
    public static func LEARNED_LANGUAGE() -> String { return "Learned a new language. "; }
    public static func GOT_DEGREE() -> String { return "Earned a degree. "; }
    public static func NEW_SKILL() -> String { return "Learned a valuable new skill. "; }
    public static func SOBRIETY() -> String { return "Got sober after addiction. "; }
    public static func THERAPY() -> String { return "Started therapy. "; }
    public static func FITNESS() -> String { return "Got serious about fitness. "; }
    // === EXPANDED: FAMILY ===
    public static func LOST_CUSTODY() -> String { return "Lost custody of a child. "; }
    public static func MISCARRIAGE() -> String { return "Suffered a miscarriage. "; }
    public static func ESTRANGED_FAMILY() -> String { return "Became estranged from family. "; }
    public static func CARETAKER() -> String { return "Became a caretaker for a sick relative. "; }
    public static func PARENT_DIED() -> String { return "Lost a parent. "; }
    // === EXPANDED: LEGAL ===
    public static func SUED() -> String { return "Was sued in civil court. "; }
    public static func WON_LAWSUIT() -> String { return "Won a lawsuit. "; }
    public static func LOST_LAWSUIT() -> String { return "Lost a lawsuit badly. "; }
    public static func PROBATION() -> String { return "Was put on probation. "; }
    public static func CHARGES_DROPPED() -> String { return "Had charges dropped. "; }
    public static func WRONGFUL_ARREST() -> String { return "Was wrongfully arrested. "; }
    // === EXPANDED: UNDERWORLD ===
    public static func FIRST_FIXER_JOB() -> String { return "Completed first job for a fixer. "; }
    public static func DOUBLE_CROSSED() -> String { return "Was double-crossed on a job. "; }
    public static func SCORED_BIG() -> String { return "Scored big on a job. "; }
    public static func BURNED_FIXER() -> String { return "Burned a fixer and made enemies. "; }
    public static func REP_BOOST() -> String { return "Reputation increased significantly. "; }
    public static func REP_TANK() -> String { return "Reputation tanked after a failed job. "; }
    // === NET / TECH CULTURE ===
    public static func HACKED_BY_VDBS() -> String { return "Was hacked by the Voodoo Boys. Lost three days of memory. "; }
    public static func ICE_BREACH() -> String { return "Personal ICE was breached. Financial data compromised. "; }
    public static func SOLD_DATA() -> String { return "Sold personal data to a corp for quick eddies. "; }
    public static func DEEP_NET() -> String { return "Went deep into the Old Net. Came back different. "; }
    public static func SHARD_MALWARE() -> String { return "Slotted a shard loaded with malware. "; }
    public static func DATA_BROKER() -> String { return "Works as a data broker on the side. "; }
    public static func DAEMON_ATTACK() -> String { return "Survived a daemon attack through a public terminal. "; }
    public static func GHOST_PROFILE() -> String { return "Maintains a ghost profile — minimal net footprint. "; }
    // === CORPO INTRIGUE ===
    public static func CORPO_SABOTAGE() -> String { return "Was the target of corporate sabotage. "; }
    public static func CORPO_ESPIONAGE() -> String { return "Participated in corporate espionage. "; }
    public static func CORPO_RELOCATION() -> String { return "Was forcibly relocated by %his% employer. "; }
    public static func CORPO_BUYOUT() -> String { return "Survived a hostile corporate buyout. "; }
    public static func NDA_VIOLATION() -> String { return "Broke an NDA. Legal consequences pending. "; }
    public static func CORPO_EXPERIMENT() -> String { return "Was unknowingly part of a corporate experiment. "; }
    public static func GOLDEN_PARACHUTE() -> String { return "Left a corp with a generous severance package. "; }
    // === NIGHT CITY SURVIVAL ===
    public static func ACID_RAIN() -> String { return "Suffered chemical burns from acid rain exposure. "; }
    public static func BUILDING_FIRE() -> String { return "Lost everything in an apartment building fire. "; }
    public static func MEGABUILDING_LOCKDOWN() -> String { return "Survived a megabuilding lockdown. "; }
    public static func POWER_GRID() -> String { return "Went two weeks without power during a grid failure. "; }
    public static func CONTAMINATED_WATER() -> String { return "Was poisoned by contaminated water supply. "; }
    public static func SCAV_TARGET() -> String { return "Was targeted by Scavengers for organ harvesting. Escaped. "; }
    public static func CYBERPSYCHO_ATTACK() -> String { return "Caught in the crossfire of a cyberpsycho rampage. "; }
    public static func DELAMAIN_CRASH() -> String { return "Was in a Delamain cab during a system malfunction. "; }
    public static func NCART_MUGGED() -> String { return "Was mugged on the NCART. "; }
    public static func STRAY_BULLET() -> String { return "Was hit by a stray bullet during a street shootout. "; }
    // === MEDICAL / TRAUMA TEAM ===
    public static func TT_SAVED() -> String { return "Was saved by Trauma Team. Still paying the bill. "; }
    public static func TT_DENIED() -> String { return "Trauma Team refused service. Coverage had lapsed. "; }
    public static func BAD_RIPPER() -> String { return "Went to a back-alley ripperdoc. Got an infection. "; }
    public static func ORGAN_SOLD() -> String { return "Sold a kidney to pay off debts. "; }
    public static func CLONED_ORGAN() -> String { return "Received a cloned organ transplant. "; }
    public static func EXPERIMENTAL_DRUG() -> String { return "Volunteered for experimental drug trials. "; }
    public static func MISDIAGNOSED() -> String { return "Was misdiagnosed and received wrong treatment. "; }
    // === BRAINDANCE / MEDIA ===
    public static func BD_RECORDED() -> String { return "Was unknowingly recorded for a braindance. "; }
    public static func XBD_EXPOSURE() -> String { return "Was exposed to illegal XBDs. Still affected. "; }
    public static func MEDIA_INTERVIEW() -> String { return "Was interviewed by a media crew. Story was twisted. "; }
    public static func DEEPFAKE() -> String { return "Was the victim of a deepfake scandal. "; }
    public static func PIRATE_RADIO() -> String { return "Ran a pirate radio station. "; }
    // === DISPLACEMENT / MIGRATION ===
    public static func FLED_PACIFICA() -> String { return "Fled Pacifica after the collapse. "; }
    public static func CLIMATE_REFUGEE() -> String { return "Climate refugee from the Southwest droughts. "; }
    public static func CORPO_WAR_REFUGEE() -> String { return "Displaced by the Fourth Corporate War. "; }
    public static func SQUATTER() -> String { return "Squatting in an abandoned building. "; }
    public static func EVICTED_MEGA() -> String { return "Was evicted from a megabuilding for unpaid rent. "; }
    // === VIGILANTE / JUSTICE ===
    public static func VIGILANTE() -> String { return "Took justice into %his% own hands once. "; }
    public static func WRONGFUL_NCPD() -> String { return "Was beaten by NCPD during a false arrest. "; }
    public static func BRIBE_NCPD() -> String { return "Bribed NCPD to avoid charges. "; }
    public static func TURNED_IN_FRIEND() -> String { return "Turned in a friend for the bounty. "; }
    // === RIPPERDOC / CYBERWARE CULTURE ===
    public static func CHROME_JUNKIE() -> String { return "Gets new chrome every month. Can't stop upgrading. "; }
    public static func STRIPPED_CHROME() -> String { return "Had chrome forcibly stripped by Scavengers. "; }
    public static func SECONDHAND_CHROME() -> String { return "Running secondhand chrome pulled from a corpse. "; }
    public static func SANDEVISTAN_SIDE() -> String { return "Suffering side effects from Sandevistan overuse. "; }
    public static func KIROSHI_GLITCH() -> String { return "Kiroshi optics keep glitching. Can't afford a fix. "; }
    // === COMMUNITY / SOCIAL ===
    public static func BLOCK_PARTY() -> String { return "Organized a block party that turned into a brawl. "; }
    public static func NEIGHBORHOOD_WATCH() -> String { return "Started a neighborhood watch. "; }
    public static func FOOD_BANK() -> String { return "Volunteers at a food bank. "; }
    public static func STREET_PREACHER() -> String { return "Became a street preacher. "; }
    public static func UNDERGROUND_FIGHT() -> String { return "Competed in underground fights. "; }
    // === ROMANTIC / PERSONAL ===
    public static func JOYTOY_RELATIONSHIP() -> String { return "Fell in love with a joytoy. "; }
    public static func STALKED() -> String { return "Was stalked by an ex. "; }
    public static func CATFISHED() -> String { return "Was catfished through a dating service. "; }
    public static func PREGNANT_SCARE() -> String { return "Partner had a pregnancy scare that changed everything. "; }
    public static func ELOPED() -> String { return "Eloped. Family doesn't know. "; }
    // === TRANSPORTATION / VEHICLES ===
    public static func ROAD_RAGE() -> String { return "Was involved in a road rage incident on the highway. "; }
    public static func STOLEN_CAR() -> String { return "Had car stolen. Never recovered. "; }
    public static func ILLEGAL_RACING() -> String { return "Got into illegal street racing. "; }
    public static func SMUGGLER_RUN() -> String { return "Did a smuggling run through the Badlands. "; }
    // === ECONOMIC DESPERATION ===
    public static func SOLD_BLOOD() -> String { return "Sells blood regularly to make rent. "; }
    public static func DUMPSTER_DIVING() -> String { return "Survives partly on dumpster diving. "; }
    public static func PAYDAY_LOAN() -> String { return "Trapped in a cycle of payday loans. "; }
    public static func SOLD_POSSESSIONS() -> String { return "Sold everything of value to stay afloat. "; }
    public static func CORPO_INDENTURED() -> String { return "Signed an indentured labor contract with a corp. "; }
    // === FIXERS / MERC LIFE ===
    public static func FIXER_BLACKLIST() -> String { return "Was blacklisted by every fixer in Watson. "; }
    public static func BOTCHED_DELIVERY() -> String { return "Botched a delivery run. Package never made it. "; }
    public static func MERC_AMBUSH() -> String { return "Was set up on a gig. Barely walked away. "; }
    public static func SOLD_OUT_CLIENT() -> String { return "Sold out a client for double the payout. "; }
    public static func CLEAN_RECORD() -> String { return "Has a clean record with fixers. Always delivers. "; }
    public static func FIXER_FAVOR() -> String { return "Did a favor for a fixer. Has a marker to call in. "; }
    public static func CREW_WIPED() -> String { return "Entire crew was wiped on a job. Only survivor. "; }
    public static func STOLEN_GOODS() -> String { return "Sitting on stolen goods no fence will touch. "; }
    public static func DOUBLE_BOOKED() -> String { return "Took two gigs at once. Finished neither. "; }
    public static func MERC_RETIREMENT() -> String { return "Tried to retire from merc work. Got pulled back in. "; }
    // === ARASAKA / MILITECH / CORP SPECIFIC ===
    public static func ARASAKA_INTERVIEW() -> String { return "Was interviewed by Arasaka counterintelligence. "; }
    public static func MILITECH_CONTRACT() -> String { return "Signed a Militech security contractor agreement. "; }
    public static func BIOTECHNICA_TRIAL() -> String { return "Was a test subject in a Biotechnica pharmaceutical trial. "; }
    public static func KANG_TAO_DEBT() -> String { return "Owes a significant debt to Kang Tao. "; }
    public static func PETROCHEM_LAYOFF() -> String { return "Was laid off during Petrochem downsizing. "; }
    public static func ZETATECH_RECALL() -> String { return "Had Zetatech implants recalled. Still waiting for replacements. "; }
    public static func ORBITAL_AIR() -> String { return "Worked briefly for Orbital Air. Got altitude sickness. "; }
    public static func NIGHT_CORP_DREAM() -> String { return "Participated in a Night Corp sleep study. Has strange dreams since. "; }
    // === DISTRICT-SPECIFIC EVENTS ===
    public static func HEYWOOD_SHOOTOUT() -> String { return "Caught in a shootout in Heywood. "; }
    public static func WATSON_LOCKDOWN() -> String { return "Was trapped in Watson during a lockdown. "; }
    public static func KABUKI_RIPPER() -> String { return "Got discount chrome in Kabuki. Regrets it. "; }
    public static func JAPANTOWN_DEBT() -> String { return "Racked up a debt at a Japantown parlor. "; }
    public static func PACIFICA_SCAV() -> String { return "Nearly harvested by Scavs in Pacifica. "; }
    public static func RANCHO_FLOOD() -> String { return "Lost belongings to flooding in Rancho Coronado. "; }
    public static func DOGTOWN_HUSTLE() -> String { return "Ran a hustle out of Dogtown for a few months. "; }
    public static func CHARTER_HILL_MUGGED() -> String { return "Was mugged walking through Charter Hill at night. "; }
    public static func BADLANDS_BREAKDOWN() -> String { return "Car broke down in the Badlands. Walked for hours. "; }
    public static func CITY_CENTER_BOMBING() -> String { return "Was near a bombing in City Center. Still flinches at loud sounds. "; }
    // === SUBSTANCE ABUSE / ADDICTION ===
    public static func GLITTER_ADDICTION() -> String { return "Hooked on Glitter. Can't afford to quit. "; }
    public static func SYNTHCOKE() -> String { return "Has a synthcoke habit. "; }
    public static func BLACK_LACE() -> String { return "Tried Black Lace. Blacked out for three days. "; }
    public static func DEALER() -> String { return "Deals chems on the corner. "; }
    public static func SOBER_SPONSOR() -> String { return "Acts as a sobriety sponsor for others. "; }
    public static func RELAPSED() -> String { return "Relapsed after two years clean. "; }
    public static func BOOZE_DEPENDENCE() -> String { return "Functional alcoholic. Drinks to cope. "; }
    // === MILITARIZED / SECURITY ===
    public static func NCPD_BRUTALITY() -> String { return "Was brutalized during an NCPD sweep. "; }
    public static func MAXTAC_WITNESS() -> String { return "Witnessed MaxTac neutralize a cyberpsycho on %his% block. "; }
    public static func MILITECH_DRONE() -> String { return "Was nearly killed by an errant Militech security drone. "; }
    public static func PRIVATE_SECURITY() -> String { return "Worked private security for a corpo exec. "; }
    public static func ARASAKA_DETAINED() -> String { return "Was detained by Arasaka security for 72 hours without charges. "; }
    public static func EVENT_SECURITY() -> String { return "Worked event security at Afterlife. "; }
    // === AFTERLIFE / BARS / NIGHTLIFE ===
    public static func AFTERLIFE_REGULAR() -> String { return "Is a regular at the Afterlife. "; }
    public static func BARFIGHT() -> String { return "Broke a jaw in a bar fight. "; }
    public static func DRINK_NAMED() -> String { return "Had a drink named after %him% at a dive bar. "; }
    public static func BANNED_BAR() -> String { return "Banned from three different bars. "; }
    public static func UNDERGROUND_PARTY() -> String { return "Went to an underground party in an abandoned factory. Never talks about what happened. "; }
    public static func NIGHTCLUB_OD() -> String { return "Overdosed at a nightclub. Was revived on site. "; }
    // === PETS / ANIMALS ===
    public static func PET_CAT() -> String { return "Keeps a stray cat in %his% apartment. "; }
    public static func PET_DOG() -> String { return "Owns a dog. Only living thing that trusts %him%. "; }
    public static func PET_DIED() -> String { return "Lost a pet to a stray bullet. "; }
    public static func FEEDS_STRAYS() -> String { return "Feeds stray animals in the neighborhood. "; }
    // === GAMBLING / VICE ===
    public static func PACHINKO_DEBT() -> String { return "Has a crippling pachinko addiction. "; }
    public static func RIGGED_FIGHT() -> String { return "Bet on a rigged fight. Lost everything. "; }
    public static func CASINO_BANNED() -> String { return "Banned from multiple casinos for cheating. "; }
    public static func BOOKIE() -> String { return "Works as a bookie on the side. "; }
    public static func POKER_SHARK() -> String { return "Cleans out poker games regularly. "; }
    // === HOUSING / LIVING CONDITIONS ===
    public static func COFFIN_MOTEL() -> String { return "Lives in a coffin motel. "; }
    public static func ROOFTOP_SQUAT() -> String { return "Squats on a rooftop. "; }
    public static func ROOMMATE_HELL() -> String { return "Has a roommate from hell. "; }
    public static func UPGRADED_APT() -> String { return "Moved up to a nicer apartment. "; }
    public static func LIVES_IN_CAR() -> String { return "Lives out of a car. "; }
    public static func NOISE_COMPLAINT() -> String { return "Filed 47 noise complaints. None were addressed. "; }
    public static func APARTMENT_ROBBERY() -> String { return "Apartment was cleaned out while at work. "; }
    // === COMBAT ARENA / SPORTS ===
    public static func BOXING_AMATEUR() -> String { return "Fought amateur boxing matches for cash. "; }
    public static func FIGHT_CLUB() -> String { return "Member of an underground fight club. "; }
    public static func RACING_CRASH() -> String { return "Crashed during an illegal street race. "; }
    public static func COMBAT_TOURNAMENT() -> String { return "Entered a combat tournament. Lost in the second round. "; }
    public static func RACING_WIN() -> String { return "Won a street race. Still has the car. "; }
    // === DEATH / LOSS ===
    public static func FRIEND_OVERDOSE() -> String { return "Found a friend dead from an overdose. "; }
    public static func NEIGHBOR_KILLED() -> String { return "Neighbor was killed. Nobody investigated. "; }
    public static func SAW_EXECUTION() -> String { return "Witnessed a public execution by a gang. "; }
    public static func BODY_FOUND() -> String { return "Found a body in the alley behind %his% building. "; }
    public static func FUNERAL_DEBT() -> String { return "Went into debt paying for a funeral. "; }
    public static func CHOOM_FLATLINED() -> String { return "Best choom flatlined on a gig. "; }
    // === FOOD / SURVIVAL ===
    public static func FOOD_POISONING() -> String { return "Got food poisoning from a street vendor. Nearly died. "; }
    public static func KIBBLE_DIET() -> String { return "Has been eating nothing but kibble for months. "; }
    public static func REAL_FOOD() -> String { return "Tasted real food for the first time. Cried. "; }
    public static func FOOD_STALL() -> String { return "Runs a food stall on the side. "; }
    // === SCAMS / CON ARTISTRY ===
    public static func FAKE_CHROME() -> String { return "Was sold fake chrome. Paid full price. "; }
    public static func PYRAMID_SCHEME() -> String { return "Got roped into a pyramid scheme. Lost friends and money. "; }
    public static func ROMANCE_SCAM() -> String { return "Was the target of a romance scam. "; }
    public static func FAKE_FIXER() -> String { return "Was conned by someone posing as a fixer. "; }
    public static func SHELL_COMPANY() -> String { return "Unknowingly works for a shell company. "; }
    public static func IDENTITY_SOLD() -> String { return "Someone is using a copy of %his% identity. "; }
    // === CHILDHOOD ECHOES (Adult Consequences) ===
    public static func ORPHANAGE_REUNION() -> String { return "Tracked down others from the same orphanage. "; }
    public static func OLD_BULLY() -> String { return "Ran into a childhood bully. It didn't go well. "; }
    public static func INHERITANCE_SCAM() -> String { return "Received notice of a fake inheritance. Classic scam. "; }
    public static func FAMILY_SECRET() -> String { return "Discovered a dark family secret. "; }
    public static func CHILDHOOD_HOME_DEMOLISHED() -> String { return "Childhood home was demolished for a corp development project. "; }
    // === UNEXPECTED WINDFALLS ===
    public static func FOUND_STASH() -> String { return "Found a hidden stash of eddies in a wall during renovation. "; }
    public static func WRONG_ACCOUNT() -> String { return "A corp accidentally deposited eddies into %his% account. Spent it before they noticed. "; }
    public static func SALVAGE_SCORE() -> String { return "Found valuable salvage in a wreck in the Badlands. "; }
    public static func RARE_SHARD() -> String { return "Found a rare data shard worth a fortune. "; }
    // === BUREAUCRATIC / SYSTEMIC ===
    public static func NC_ID_REVOKED() -> String { return "NC ID was revoked. Essentially a non-person. "; }
    public static func INSURANCE_DENIED() -> String { return "Health insurance claim was denied for the third time. "; }
    public static func PERMIT_REVOKED() -> String { return "Business permit was revoked without explanation. "; }
    public static func TAX_AUDIT() -> String { return "Was audited. Owed more than expected. "; }
    public static func JURY_DUTY() -> String { return "Served on a jury. The defendant disappeared before sentencing. "; }
    public static func WRONG_ADDRESS_RAID() -> String { return "NCPD raided the wrong apartment. %Hers%. "; }
    // === REVENGE / GRUDGES ===
    public static func REVENGE_SERVED() -> String { return "Got revenge on someone who wronged %him% years ago. "; }
    public static func HIT_LIST() -> String { return "Is on someone's hit list. Doesn't know whose. "; }
    public static func VENDETTA() -> String { return "Carrying a vendetta that consumes every waking moment. "; }
    public static func FORGAVE_ENEMY() -> String { return "Forgave an old enemy. Surprised everyone. "; }
    // === CLOSE CALLS / LUCK ===
    public static func WRONG_PLACE() -> String { return "Was at the wrong place at the wrong time. Survived by pure luck. "; }
    public static func ELEVATOR_FALL() -> String { return "Survived an elevator malfunction in a megabuilding. "; }
    public static func MISSED_FLIGHT() -> String { return "Missed a flight that crashed. "; }
    public static func STOOD_UP() -> String { return "Was stood up for a meeting. The location was bombed an hour later. "; }
    public static func LAST_SECOND() -> String { return "Left a building seconds before it collapsed. "; }
    // === CRAFTSMANSHIP / ARTISAN ===
    public static func WEAPON_SMITH() -> String { return "Builds custom weapons in a garage workshop. "; }
    public static func TATTOO_ARTIST() -> String { return "Does tattoo work on the side. "; }
    public static func CAR_MECHANIC() -> String { return "Restores old cars as a hobby. "; }
    public static func SHARD_COLLECTOR() -> String { return "Collects rare data shards. "; }
    public static func BOOTLEG_BD() -> String { return "Produces bootleg braindances. "; }
    // === DEBTS / OBLIGATIONS ===
    public static func OWES_GANG() -> String { return "Owes a dangerous favor to a gang lieutenant. "; }
    public static func OWES_RIPPER() -> String { return "Owes a ripperdoc for emergency surgery. "; }
    public static func BLOOD_OATH() -> String { return "Bound by a blood oath. Won't say to whom. "; }
    public static func COLLATERAL() -> String { return "Was used as collateral for someone else's debt. "; }
    public static func DEBT_COLLECTOR() -> String { return "Works as a debt collector. Nobody's favorite person. "; }
}

