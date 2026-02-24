// Adult life events
public abstract class KdspTextAdulthood {
    // === FINANCIAL ===
    public static func LOST_GAMBLE_F() -> String { return "Lost €$%eddies% Eurodollars gambling. "; }
    public static func LOST_GAMBLE_M() -> String { return ""; }
    public static func WON_LOTTERY_F() -> String { return "Won a scratch-off. "; }
    public static func WON_LOTTERY_M() -> String { return ""; }
    public static func BOUGHT_CAR_F() -> String { return "Bought a car. "; }
    public static func BOUGHT_CAR_M() -> String { return ""; }
    public static func NEW_APT_F() -> String { return "Moved into a new apartment. "; }
    public static func NEW_APT_M() -> String { return ""; }
    public static func ASST_SZD_CRP_F() -> String { return "All assets were seized by the %corp% Corporation. "; }
    public static func ASST_SZD_CRP_M() -> String { return ""; }
    public static func CHRG_BK_DBTR_F() -> String { return "Charged as a bankrupt debtor. "; }
    public static func CHRG_BK_DBTR_M() -> String { return ""; }
    public static func CHRG_MED_DBT_F() -> String { return "Charged as a medical debtor. "; }
    public static func CHRG_MED_DBT_M() -> String { return ""; }
    public static func INDEBT_CRP_INDVL_F() -> String { return "Indebted to the %corp% Corporation. Individual reassigned as a corporate asset. "; }
    public static func INDEBT_CRP_INDVL_M() -> String { return ""; }
    public static func HAB_CRP_DBTR_F() -> String { return "Charged as a habitual corporate debtor. "; }
    public static func HAB_CRP_DBTR_M() -> String { return ""; }
    public static func INHERITANCE_F() -> String { return "Received a small inheritance. "; }
    public static func INHERITANCE_M() -> String { return ""; }
    public static func LOST_SAVINGS_F() -> String { return "Lost all savings in a market crash. "; }
    public static func LOST_SAVINGS_M() -> String { return ""; }
    public static func CRYPTO_F() -> String { return "Got rich on cryptocurrency before losing it all. "; }
    public static func CRYPTO_M() -> String { return ""; }
    public static func EVICTED_F() -> String { return "Was evicted from home. "; }
    public static func EVICTED_M() -> String { return ""; }
    public static func REPO_CAR_F() -> String { return "Had car repossessed. "; }
    public static func REPO_CAR_M() -> String { return ""; }

    // === CAREER ===
    public static func LOST_JOB_F() -> String { return "Lost her job. "; }
    public static func LOST_JOB_M() -> String { return "Lost his job. "; }
    public static func COMPLETED_JOB_F() -> String { return "Completed a job for a fixer and received a €$%eddies% payout. "; }
    public static func COMPLETED_JOB_M() -> String { return ""; }
    public static func RADIO_JOCKEY_F() -> String { return "Moonlighted as a radio jockey. "; }
    public static func RADIO_JOCKEY_M() -> String { return ""; }
    public static func PROMOTION_F() -> String { return "Received a promotion. "; }
    public static func PROMOTION_M() -> String { return ""; }
    public static func FIRED_F() -> String { return "Was fired for misconduct. "; }
    public static func FIRED_M() -> String { return ""; }
    public static func BLACKLISTED_F() -> String { return "Was blacklisted from an industry. "; }
    public static func BLACKLISTED_M() -> String { return ""; }
    public static func WHISTLEBLOWER_F() -> String { return "Became a corporate whistleblower. "; }
    public static func WHISTLEBLOWER_M() -> String { return ""; }
    public static func STARTED_BIZ_F() -> String { return "Started a small business. "; }
    public static func STARTED_BIZ_M() -> String { return ""; }
    public static func BIZ_FAILED_F() -> String { return "Business venture failed catastrophically. "; }
    public static func BIZ_FAILED_M() -> String { return ""; }
    public static func UNION_F() -> String { return "Became a union organizer. "; }
    public static func UNION_M() -> String { return ""; }
    public static func STRIKE_F() -> String { return "Participated in a workers' strike. "; }
    public static func STRIKE_M() -> String { return ""; }

    // === CRIMINAL / LEGAL ===
    public static func IMPRISONED_F() -> String { return "Was imprisoned for %years% years. "; }
    public static func IMPRISONED_M() -> String { return ""; }
    public static func ROB_BODEGA_F() -> String { return "Was involved in a robbery at a bodega. "; }
    public static func ROB_BODEGA_M() -> String { return ""; }
    public static func ROB_VENDOR_F() -> String { return "Was involved in a robbery at a street food vendor. "; }
    public static func ROB_VENDOR_M() -> String { return ""; }
    public static func RUN_CHEMS_F() -> String { return "Began running chems for a local gang. "; }
    public static func RUN_CHEMS_M() -> String { return ""; }
    public static func KILLED_CHOOM_F() -> String { return "Killed an unlucky choom. "; }
    public static func KILLED_CHOOM_M() -> String { return ""; }
    public static func JOINED_RIOT_F() -> String { return "Was involved in a riot. "; }
    public static func JOINED_RIOT_M() -> String { return ""; }
    public static func CODED_BOTNETS_F() -> String { return "Coded synchronized botnets to attack the %corp% Corporation access points, stealing €$%eddies% Eurodollars. "; }
    public static func CODED_BOTNETS_M() -> String { return ""; }
    public static func STOLE_EQP_F() -> String { return "Stole some high-tech equipment from %corp%. "; }
    public static func STOLE_EQP_M() -> String { return ""; }
    public static func FILED_FRD_INS_F() -> String { return "Filed a fraudulent insurance claim. "; }
    public static func FILED_FRD_INS_M() -> String { return ""; }
    public static func CRP_LBLTY_DFDT_F() -> String { return "Charged as a corporate liability defendant. "; }
    public static func CRP_LBLTY_DFDT_M() -> String { return ""; }
    public static func CRP_POL_VIO_F() -> String { return "Charged as a corporate policies violator. "; }
    public static func CRP_POL_VIO_M() -> String { return ""; }
    public static func ARMED_DANGER_F() -> String { return "Notoriously armed and dangerous. "; }
    public static func ARMED_DANGER_M() -> String { return ""; }
    public static func FLSLY_ACC_MRDR_F() -> String { return "Was falsely accused of murder and imprisoned for %years% horrifying years. "; }
    public static func FLSLY_ACC_MRDR_M() -> String { return ""; }
    public static func FREE_CRP_MRDR_F() -> String { return "Was accused of corporate-sanctioned murders with video evidence, but charges were dismissed on technicalities. "; }
    public static func FREE_CRP_MRDR_M() -> String { return ""; }
    public static func ROBOT_DEST_F() -> String { return "Was involved in the destruction of one Arasaka Robot R MK.2. "; }
    public static func ROBOT_DEST_M() -> String { return ""; }
    public static func BUILD_BOMB_F() -> String { return "Meets with known terrorists, while building a dirty bomb with scavenged ordinance and electronics. "; }
    public static func BUILD_BOMB_M() -> String { return ""; }
    public static func ARRESTED_F() -> String { return "Was arrested by NCPD. "; }
    public static func ARRESTED_M() -> String { return ""; }
    public static func PAROLE_F() -> String { return "Currently on parole. "; }
    public static func PAROLE_M() -> String { return ""; }
    public static func BOUNTY_F() -> String { return "Has an active bounty. "; }
    public static func BOUNTY_M() -> String { return ""; }
    public static func WITNESS_PROT_F() -> String { return "Entered witness protection briefly. "; }
    public static func WITNESS_PROT_M() -> String { return ""; }

    // === CYBERWARE / MEDICAL ===
    public static func INST_NEW_AUG_F() -> String { return "Installed a new cybernetic augmentation. "; }
    public static func INST_NEW_AUG_M() -> String { return ""; }
    public static func BOUGHT_CYBER_F() -> String { return "Bought cybernetics. "; }
    public static func BOUGHT_CYBER_M() -> String { return ""; }
    public static func CANCEL_TTI_F() -> String { return "Canceled her Trauma Team Insurance. "; }
    public static func CANCEL_TTI_M() -> String { return "Canceled his Trauma Team Insurance. "; }
    public static func FREE_TTI_F() -> String { return "Signed up as a human guinea pig receiving injections in stem cell chimera trials. Earned a voucher for one free month of Trauma Team Premium. "; }
    public static func FREE_TTI_M() -> String { return ""; }

    // Expanded Adulthood - Career/Work
    public static func FREELANCE_F() -> String { return "Works as a freelancer, taking gigs where she can find them. "; }
    public static func FREELANCE_M() -> String { return "Works as a freelancer, taking gigs where he can find them. "; }
    public static func CORPO_FIRED_F() -> String { return "Was fired from a corpo job under suspicious circumstances. "; }
    public static func CORPO_FIRED_M() -> String { return "Was fired from a corpo job under suspicious circumstances. "; }
    public static func CORPO_BURNOUT_F() -> String { return "Burned out from the corporate grind. "; }
    public static func CORPO_BURNOUT_M() -> String { return "Burned out from the corporate grind. "; }
    public static func SECOND_JOB_F() -> String { return "Works a second job just to make ends meet. "; }
    public static func SECOND_JOB_M() -> String { return "Works a second job just to make ends meet. "; }
    public static func THIRD_SHIFT_F() -> String { return "Works the third shift at a factory. "; }
    public static func THIRD_SHIFT_M() -> String { return "Works the third shift at a factory. "; }
    public static func GIG_ECONOMY_F() -> String { return "Survives on gig economy work. "; }
    public static func GIG_ECONOMY_M() -> String { return "Survives on gig economy work. "; }
    public static func SCAB_WORKER_F() -> String { return "Worked as a scab during a labor strike. "; }
    public static func SCAB_WORKER_M() -> String { return "Worked as a scab during a labor strike. "; }
    public static func CORPO_LADDER_F() -> String { return "Climbed the corporate ladder through ruthless ambition. "; }
    public static func CORPO_LADDER_M() -> String { return "Climbed the corporate ladder through ruthless ambition. "; }
    public static func DEMOTED_F() -> String { return "Was demoted after a corporate restructuring. "; }
    public static func DEMOTED_M() -> String { return "Was demoted after a corporate restructuring. "; }
    public static func FIXER_REP_F() -> String { return "Has built a reputation with local fixers. "; }
    public static func FIXER_REP_M() -> String { return "Has built a reputation with local fixers. "; }
    public static func SOLO_WORK_F() -> String { return "Does solo work for various clients. "; }
    public static func SOLO_WORK_M() -> String { return "Does solo work for various clients. "; }
    public static func NETRUNNER_GIG_F() -> String { return "Takes netrunning gigs on the side. "; }
    public static func NETRUNNER_GIG_M() -> String { return "Takes netrunning gigs on the side. "; }
    public static func TECHIE_REP_F() -> String { return "Known for her technical expertise. "; }
    public static func TECHIE_REP_M() -> String { return "Known for his technical expertise. "; }
    public static func MERC_CONTRACT_F() -> String { return "Completed a lucrative merc contract. "; }
    public static func MERC_CONTRACT_M() -> String { return "Completed a lucrative merc contract. "; }
    public static func BOTCHED_JOB_F() -> String { return "Botched a job and is still paying for it. "; }
    public static func BOTCHED_JOB_M() -> String { return "Botched a job and is still paying for it. "; }

    // Expanded Adulthood - Financial
    public static func LOAN_SHARK_F() -> String { return "Owes money to a dangerous loan shark. "; }
    public static func LOAN_SHARK_M() -> String { return "Owes money to a dangerous loan shark. "; }
    public static func PAID_DEBT_F() -> String { return "Finally paid off a crushing debt. "; }
    public static func PAID_DEBT_M() -> String { return "Finally paid off a crushing debt. "; }
    public static func SCAMMED_F() -> String { return "Was scammed out of her life savings. "; }
    public static func SCAMMED_M() -> String { return "Was scammed out of his life savings. "; }
    public static func SCAMMER_F() -> String { return "Runs scams to make a living. "; }
    public static func SCAMMER_M() -> String { return "Runs scams to make a living. "; }
    public static func UNDERGROUND_CASINO_F() -> String { return "Lost big at an underground casino. "; }
    public static func UNDERGROUND_CASINO_M() -> String { return "Lost big at an underground casino. "; }
    public static func BIG_SCORE_F() -> String { return "Pulled off a big score that set her up for years. "; }
    public static func BIG_SCORE_M() -> String { return "Pulled off a big score that set him up for years. "; }
    public static func LOST_SCORE_F() -> String { return "Lost a big score to betrayal. "; }
    public static func LOST_SCORE_M() -> String { return "Lost a big score to betrayal. "; }
    public static func STOCK_CRASH_F() -> String { return "Lost everything in a stock market crash. "; }
    public static func STOCK_CRASH_M() -> String { return "Lost everything in a stock market crash. "; }
    public static func INSURANCE_FRAUD_F() -> String { return "Committed insurance fraud to survive. "; }
    public static func INSURANCE_FRAUD_M() -> String { return "Committed insurance fraud to survive. "; }
    public static func TAX_EVASION_F() -> String { return "Under investigation for tax evasion. "; }
    public static func TAX_EVASION_M() -> String { return "Under investigation for tax evasion. "; }
    public static func WIRE_TRANSFER_F() -> String { return "Received a mysterious wire transfer. "; }
    public static func WIRE_TRANSFER_M() -> String { return "Received a mysterious wire transfer. "; }
    public static func MONEY_LAUNDERING_F() -> String { return "Involved in a money laundering operation. "; }
    public static func MONEY_LAUNDERING_M() -> String { return "Involved in a money laundering operation. "; }

    // Expanded Adulthood - Criminal
    public static func HEIST_F() -> String { return "Participated in a high-profile heist. "; }
    public static func HEIST_M() -> String { return "Participated in a high-profile heist. "; }
    public static func SMUGGLING_F() -> String { return "Does smuggling runs across borders. "; }
    public static func SMUGGLING_M() -> String { return "Does smuggling runs across borders. "; }
    public static func BLACKMAIL_F() -> String { return "Blackmails people for a living. "; }
    public static func BLACKMAIL_M() -> String { return "Blackmails people for a living. "; }
    public static func BLACKMAILED_F() -> String { return "Is being blackmailed by an unknown party. "; }
    public static func BLACKMAILED_M() -> String { return "Is being blackmailed by an unknown party. "; }
    public static func FENCE_F() -> String { return "Works as a fence for stolen goods. "; }
    public static func FENCE_M() -> String { return "Works as a fence for stolen goods. "; }
    public static func CARJACKING_F() -> String { return "Has a history of carjacking. "; }
    public static func CARJACKING_M() -> String { return "Has a history of carjacking. "; }
    public static func KIDNAPPING_F() -> String { return "Was involved in a kidnapping operation. "; }
    public static func KIDNAPPING_M() -> String { return "Was involved in a kidnapping operation. "; }
    public static func KIDNAPPED_F() -> String { return "Was kidnapped and held for ransom. "; }
    public static func KIDNAPPED_M() -> String { return "Was kidnapped and held for ransom. "; }
    public static func ARSON_F() -> String { return "Committed arson for hire. "; }
    public static func ARSON_M() -> String { return "Committed arson for hire. "; }
    public static func CONTRACT_KILL_F() -> String { return "Carried out a contract killing. "; }
    public static func CONTRACT_KILL_M() -> String { return "Carried out a contract killing. "; }
    public static func WITNESS_KILL_F() -> String { return "Eliminated a witness to a crime. "; }
    public static func WITNESS_KILL_M() -> String { return "Eliminated a witness to a crime. "; }
    public static func EVIDENCE_TAMPER_F() -> String { return "Tampered with evidence in a criminal case. "; }
    public static func EVIDENCE_TAMPER_M() -> String { return "Tampered with evidence in a criminal case. "; }
    public static func BRIBED_NCPD_F() -> String { return "Has NCPD officers on the payroll. "; }
    public static func BRIBED_NCPD_M() -> String { return "Has NCPD officers on the payroll. "; }
    public static func FRAMED_F() -> String { return "Was framed for a crime she didn't commit. "; }
    public static func FRAMED_M() -> String { return "Was framed for a crime he didn't commit. "; }
    public static func PRISON_BREAK_F() -> String { return "Escaped from prison. "; }
    public static func PRISON_BREAK_M() -> String { return "Escaped from prison. "; }
    public static func PAROLE_VIOL_F() -> String { return "Violated parole and is on the run. "; }
    public static func PAROLE_VIOL_M() -> String { return "Violated parole and is on the run. "; }

    // Expanded Adulthood - Relationships
    public static func MARRIED_F() -> String { return "Is married. "; }
    public static func MARRIED_M() -> String { return "Is married. "; }
    public static func DIVORCED_F() -> String { return "Recently divorced. "; }
    public static func DIVORCED_M() -> String { return "Recently divorced. "; }
    public static func AFFAIR_F() -> String { return "Is having an affair. "; }
    public static func AFFAIR_M() -> String { return "Is having an affair. "; }
    public static func AFFAIR_VICTIM_F() -> String { return "Partner had an affair. "; }
    public static func AFFAIR_VICTIM_M() -> String { return "Partner had an affair. "; }
    public static func HAD_CHILD_F() -> String { return "Has a child. "; }
    public static func HAD_CHILD_M() -> String { return "Has a child. "; }
    public static func LOST_CHILD_F() -> String { return "Lost a child to violence. "; }
    public static func LOST_CHILD_M() -> String { return "Lost a child to violence. "; }
    public static func CHILD_TAKEN_F() -> String { return "Child was taken by authorities. "; }
    public static func CHILD_TAKEN_M() -> String { return "Child was taken by authorities. "; }
    public static func ORPHANED_F() -> String { return "Became an orphan as an adult. "; }
    public static func ORPHANED_M() -> String { return "Became an orphan as an adult. "; }
    public static func SIBLING_DEATH_F() -> String { return "Lost a sibling recently. "; }
    public static func SIBLING_DEATH_M() -> String { return "Lost a sibling recently. "; }
    public static func REUNITED_FAM_F() -> String { return "Reunited with long-lost family. "; }
    public static func REUNITED_FAM_M() -> String { return "Reunited with long-lost family. "; }
    public static func DISOWNED_F() -> String { return "Was disowned by her family. "; }
    public static func DISOWNED_M() -> String { return "Was disowned by his family. "; }
    public static func BEST_FRIEND_DEAD_F() -> String { return "Best friend was killed. "; }
    public static func BEST_FRIEND_DEAD_M() -> String { return "Best friend was killed. "; }
    public static func BETRAYED_FRIEND_F() -> String { return "Was betrayed by a close friend. "; }
    public static func BETRAYED_FRIEND_M() -> String { return "Was betrayed by a close friend. "; }
    public static func BETRAYED_SOMEONE_F() -> String { return "Betrayed someone close for personal gain. "; }
    public static func BETRAYED_SOMEONE_M() -> String { return "Betrayed someone close for personal gain. "; }
    public static func ROMANTIC_F() -> String { return "In a romantic relationship. "; }
    public static func ROMANTIC_M() -> String { return "In a romantic relationship. "; }
    public static func HEARTBROKEN_F() -> String { return "Recovering from heartbreak. "; }
    public static func HEARTBROKEN_M() -> String { return "Recovering from heartbreak. "; }

    // Expanded Adulthood - Cyberware/Tech
    public static func CHROME_ADDICTION_F() -> String { return "Addicted to getting new chrome. "; }
    public static func CHROME_ADDICTION_M() -> String { return "Addicted to getting new chrome. "; }
    public static func CYBER_REJECTION_F() -> String { return "Body rejected cyberware implants. "; }
    public static func CYBER_REJECTION_M() -> String { return "Body rejected cyberware implants. "; }
    public static func BLACK_MARKET_CHROME_F() -> String { return "Running black market chrome. "; }
    public static func BLACK_MARKET_CHROME_M() -> String { return "Running black market chrome. "; }
    public static func CYBERWARE_HACK_F() -> String { return "Had cyberware hacked by a netrunner. "; }
    public static func CYBERWARE_HACK_M() -> String { return "Had cyberware hacked by a netrunner. "; }
    public static func MALFUNC_CHROME_F() -> String { return "Suffering from malfunctioning chrome. "; }
    public static func MALFUNC_CHROME_M() -> String { return "Suffering from malfunctioning chrome. "; }
    public static func CHEAP_RIPPER_F() -> String { return "Got bad chrome from a cheap ripper. "; }
    public static func CHEAP_RIPPER_M() -> String { return "Got bad chrome from a cheap ripper. "; }
    public static func PREMIUM_CHROME_F() -> String { return "Has premium military-grade chrome. "; }
    public static func PREMIUM_CHROME_M() -> String { return "Has premium military-grade chrome. "; }
    public static func CYBERPSYCHO_SCARE_F() -> String { return "Had a cyberpsychosis scare. "; }
    public static func CYBERPSYCHO_SCARE_M() -> String { return "Had a cyberpsychosis scare. "; }
    public static func LIMB_REPLACEMENT_F() -> String { return "Has a cybernetic limb replacement. "; }
    public static func LIMB_REPLACEMENT_M() -> String { return "Has a cybernetic limb replacement. "; }
    public static func EYE_REPLACEMENT_F() -> String { return "Has cybernetic eye replacements. "; }
    public static func EYE_REPLACEMENT_M() -> String { return "Has cybernetic eye replacements. "; }
    public static func NEURAL_DAMAGE_F() -> String { return "Suffering from neural interface damage. "; }
    public static func NEURAL_DAMAGE_M() -> String { return "Suffering from neural interface damage. "; }
    public static func BRAINDANCE_DAMAGE_F() -> String { return "Has brain damage from BD addiction. "; }
    public static func BRAINDANCE_DAMAGE_M() -> String { return "Has brain damage from BD addiction. "; }

    // Expanded Adulthood - Gang Related
    public static func JOINED_GANG_F() -> String { return "Joined a gang as an adult. "; }
    public static func JOINED_GANG_M() -> String { return "Joined a gang as an adult. "; }
    public static func LEFT_GANG_F() -> String { return "Left her gang and is marked for death. "; }
    public static func LEFT_GANG_M() -> String { return "Left his gang and is marked for death. "; }
    public static func GANG_INITIATION_F() -> String { return "Passed a brutal gang initiation. "; }
    public static func GANG_INITIATION_M() -> String { return "Passed a brutal gang initiation. "; }
    public static func GANG_PROMOTION_F() -> String { return "Was promoted within the gang hierarchy. "; }
    public static func GANG_PROMOTION_M() -> String { return "Was promoted within the gang hierarchy. "; }
    public static func GANG_EXILE_F() -> String { return "Exiled from her gang. "; }
    public static func GANG_EXILE_M() -> String { return "Exiled from his gang. "; }
    public static func TURF_WAR_F() -> String { return "Veteran of multiple turf wars. "; }
    public static func TURF_WAR_M() -> String { return "Veteran of multiple turf wars. "; }
    public static func GANG_TATTOO_F() -> String { return "Has visible gang tattoos. "; }
    public static func GANG_TATTOO_M() -> String { return "Has visible gang tattoos. "; }
    public static func GANG_DEBT_F() -> String { return "Owes a debt to a gang. "; }
    public static func GANG_DEBT_M() -> String { return "Owes a debt to a gang. "; }
    public static func PROTECTED_F() -> String { return "Under gang protection. "; }
    public static func PROTECTED_M() -> String { return "Under gang protection. "; }
    public static func PROTECTION_RACKET_F() -> String { return "Runs a protection racket. "; }
    public static func PROTECTION_RACKET_M() -> String { return "Runs a protection racket. "; }

    // Expanded Adulthood - Violence/Trauma
    public static func TORTURE_VICTIM_F() -> String { return "Was tortured for information. "; }
    public static func TORTURE_VICTIM_M() -> String { return "Was tortured for information. "; }
    public static func TORTURE_PERPETRATOR_F() -> String { return "Has tortured others for information. "; }
    public static func TORTURE_PERPETRATOR_M() -> String { return "Has tortured others for information. "; }
    public static func AMBUSHED_F() -> String { return "Survived an ambush. "; }
    public static func AMBUSHED_M() -> String { return "Survived an ambush. "; }
    public static func CAR_BOMB_F() -> String { return "Survived a car bomb attack. "; }
    public static func CAR_BOMB_M() -> String { return "Survived a car bomb attack. "; }
    public static func HOSTAGE_F() -> String { return "Was held hostage. "; }
    public static func HOSTAGE_M() -> String { return "Was held hostage. "; }
    public static func HOSTAGE_TAKER_F() -> String { return "Has taken hostages. "; }
    public static func HOSTAGE_TAKER_M() -> String { return "Has taken hostages. "; }
    public static func COMBAT_VET_F() -> String { return "Combat veteran. "; }
    public static func COMBAT_VET_M() -> String { return "Combat veteran. "; }
    public static func PTSD_F() -> String { return "Suffers from PTSD. "; }
    public static func PTSD_M() -> String { return "Suffers from PTSD. "; }
    public static func EXPLOSION_F() -> String { return "Survived an explosion. "; }
    public static func EXPLOSION_M() -> String { return "Survived an explosion. "; }
    public static func CHEMICAL_EXP_F() -> String { return "Was exposed to toxic chemicals. "; }
    public static func CHEMICAL_EXP_M() -> String { return "Was exposed to toxic chemicals. "; }
    public static func RADIATION_EXP_F() -> String { return "Was exposed to radiation. "; }
    public static func RADIATION_EXP_M() -> String { return "Was exposed to radiation. "; }

    // Expanded Adulthood - Misc Life Events
    public static func NEAR_DEATH_F() -> String { return "Had a near-death experience. "; }
    public static func NEAR_DEATH_M() -> String { return "Had a near-death experience. "; }
    public static func FLATLINED_F() -> String { return "Flatlined and was resuscitated. "; }
    public static func FLATLINED_M() -> String { return "Flatlined and was resuscitated. "; }
    public static func COMA_F() -> String { return "Was in a coma for months. "; }
    public static func COMA_M() -> String { return "Was in a coma for months. "; }
    public static func HOMELESS_F() -> String { return "Was homeless for a period. "; }
    public static func HOMELESS_M() -> String { return "Was homeless for a period. "; }
    public static func REFUGEE_F() -> String { return "Was a refugee from another city. "; }
    public static func REFUGEE_M() -> String { return "Was a refugee from another city. "; }
    public static func ILLEGAL_IMMIGRANT_F() -> String { return "Illegal immigrant status. "; }
    public static func ILLEGAL_IMMIGRANT_M() -> String { return "Illegal immigrant status. "; }
    public static func DEPORTATION_F() -> String { return "Facing deportation. "; }
    public static func DEPORTATION_M() -> String { return "Facing deportation. "; }
    public static func CITIZENSHIP_F() -> String { return "Recently gained citizenship. "; }
    public static func CITIZENSHIP_M() -> String { return "Recently gained citizenship. "; }
    public static func FAMOUS_F() -> String { return "Briefly famous in Night City. "; }
    public static func FAMOUS_M() -> String { return "Briefly famous in Night City. "; }
    public static func VIRAL_F() -> String { return "Went viral on the net. "; }
    public static func VIRAL_M() -> String { return "Went viral on the net. "; }
    public static func SCANDAL_F() -> String { return "Involved in a public scandal. "; }
    public static func SCANDAL_M() -> String { return "Involved in a public scandal. "; }
    public static func MEDIA_TARGET_F() -> String { return "Target of a media smear campaign. "; }
    public static func MEDIA_TARGET_M() -> String { return "Target of a media smear campaign. "; }
    public static func EDUCATED_F() -> String { return "Has a college education. "; }
    public static func EDUCATED_M() -> String { return "Has a college education. "; }
    public static func DROPPED_OUT_F() -> String { return "Dropped out of college. "; }
    public static func DROPPED_OUT_M() -> String { return "Dropped out of college. "; }
    public static func MENTOR_F() -> String { return "Mentors younger people. "; }
    public static func MENTOR_M() -> String { return "Mentors younger people. "; }
    public static func MENTORED_F() -> String { return "Was mentored by a professional. "; }
    public static func MENTORED_M() -> String { return "Was mentored by a professional. "; }
    public static func CLUB_REGULAR_F() -> String { return "Regular at Night City clubs. "; }
    public static func CLUB_REGULAR_M() -> String { return "Regular at Night City clubs. "; }
    public static func LIZZIE_REGULAR_F() -> String { return "Regular at Lizzie's Bar. "; }
    public static func LIZZIE_REGULAR_M() -> String { return "Regular at Lizzie's Bar. "; }
    public static func TOTENTANZ_F() -> String { return "Frequents Totentanz. "; }
    public static func TOTENTANZ_M() -> String { return "Frequents Totentanz. "; }
    public static func EMBERS_F() -> String { return "VIP at Embers. "; }
    public static func EMBERS_M() -> String { return "VIP at Embers. "; }
    public static func CYBERPSYCHO_WIT_F() -> String { return "Witnessed a cyberpsycho attack. "; }
    public static func CYBERPSYCHO_WIT_M() -> String { return "Witnessed a cyberpsycho attack. "; }
    public static func SURVIVED_MAXTAC_F() -> String { return "Survived a MaxTac encounter. "; }
    public static func SURVIVED_MAXTAC_M() -> String { return "Survived a MaxTac encounter. "; }
    public static func CAR_ACCIDENT_F() -> String { return "Was in a car accident. "; }
    public static func CAR_ACCIDENT_M() -> String { return ""; }
    public static func INDUSTRIAL_ACC_F() -> String { return "Was in an industrial accident. "; }
    public static func INDUSTRIAL_ACC_M() -> String { return ""; }
    public static func CHROME_REJECT_F() -> String { return "Suffered chrome rejection and had implants removed. "; }
    public static func CHROME_REJECT_M() -> String { return ""; }
    public static func BOOTLEG_CHROME_F() -> String { return "Installed bootleg chrome that caused complications. "; }
    public static func BOOTLEG_CHROME_M() -> String { return ""; }
    public static func SURGERY_F() -> String { return "Underwent major surgery. "; }
    public static func SURGERY_M() -> String { return ""; }
    public static func CHRONIC_F() -> String { return "Developed a chronic illness. "; }
    public static func CHRONIC_M() -> String { return ""; }

    // === SUBSTANCES ===
    public static func BCME_CHEMHEAD_F() -> String { return "Became a chemhead. "; }
    public static func BCME_CHEMHEAD_M() -> String { return ""; }
    public static func TOB_CONSUMER_F() -> String { return "Tobacco consumer. "; }
    public static func TOB_CONSUMER_M() -> String { return ""; }
    public static func AL_BEV_CONSUMER_F() -> String { return "Alcoholic beverage consumer. "; }
    public static func AL_BEV_CONSUMER_M() -> String { return ""; }
    public static func BD_CONSUMER_F() -> String { return "Braindance customer. "; }
    public static func BD_CONSUMER_M() -> String { return ""; }
    public static func BD_ADDICT_F() -> String { return "Braindance addict. "; }
    public static func BD_ADDICT_M() -> String { return ""; }
    public static func CLEAN_F() -> String { return "Got clean and sober. "; }
    public static func CLEAN_M() -> String { return ""; }
    public static func OVERDOSED_F() -> String { return "Overdosed and nearly died. "; }
    public static func OVERDOSED_M() -> String { return ""; }
    public static func REHAB_F() -> String { return "Went through rehabilitation. "; }
    public static func REHAB_M() -> String { return ""; }

    // === CONSUMER / LIFESTYLE ===
    public static func WATER_CONSUMER_F() -> String { return "Real Water subscriber. "; }
    public static func WATER_CONSUMER_M() -> String { return ""; }
    public static func JOYTOY_CONSUMER_F() -> String { return "Joytoy customer. "; }
    public static func JOYTOY_CONSUMER_M() -> String { return ""; }
    public static func RELIC_ASPIRANT_F() -> String { return "Relic aspirant. "; }
    public static func RELIC_ASPIRANT_M() -> String { return ""; }
    public static func BOUGHT_SHARD_F() -> String { return "Bought a shard. "; }
    public static func BOUGHT_SHARD_M() -> String { return ""; }
    public static func BOUGHT_GUN_F() -> String { return "Bought a firearm. "; }
    public static func BOUGHT_GUN_M() -> String { return ""; }
    public static func BOUGHT_SWORD_F() -> String { return "Bought a sword. "; }
    public static func BOUGHT_SWORD_M() -> String { return ""; }
    public static func TWO_AM_CLUB_F() -> String { return "2nd Amendment club member. "; }
    public static func TWO_AM_CLUB_M() -> String { return ""; }
    public static func VAC_AFRICA_F() -> String { return "Vacationed in sunny Africa. "; }
    public static func VAC_AFRICA_M() -> String { return ""; }
    public static func JUMP_TRAFFIC_F() -> String { return "Jumps into traffic daily at heights and crosswalks. "; }
    public static func JUMP_TRAFFIC_M() -> String { return ""; }
    public static func EMAIL_GOV_F() -> String { return "Composes hopeless policy emails to government officials. Deletes her eloquent manifesto in despair without sending. InfoComp retains backup copies."; }
    public static func EMAIL_GOV_M() -> String { return "Composes hopeless policy emails to government officials. Deletes his eloquent manifesto in despair without sending. InfoComp retains backup copies. "; }
    public static func GYM_F() -> String { return "Joined a gym. "; }
    public static func GYM_M() -> String { return ""; }
    public static func PILGRIMAGE_F() -> String { return "Went on a spiritual pilgrimage. "; }
    public static func PILGRIMAGE_M() -> String { return ""; }

    // === RELATIONSHIPS ===
    public static func PARTNER_DIED_F() -> String { return "Partner died tragically. "; }
    public static func PARTNER_DIED_M() -> String { return ""; }
    public static func BETRAYED_F() -> String { return "Was betrayed by a close friend. "; }
    public static func BETRAYED_M() -> String { return ""; }
    public static func RECONNECT_FAM_F() -> String { return "Reconnected with estranged family. "; }
    public static func RECONNECT_FAM_M() -> String { return ""; }
    public static func CUT_FAM_F() -> String { return "Cut off contact with family. "; }
    public static func CUT_FAM_M() -> String { return ""; }

    // === MUSIC / ENTERTAINMENT ===
    public static func JOIN_NEW_BAND_F() -> String { return "Joined a new band. "; }
    public static func JOIN_NEW_BAND_M() -> String { return ""; }
    public static func BAND_BROKE_F() -> String { return "Band broke up. "; }
    public static func BAND_BROKE_M() -> String { return ""; }
    public static func ALBUM_F() -> String { return "Released an album. "; }
    public static func ALBUM_M() -> String { return ""; }

    // === VIOLENCE / COMBAT ===
    public static func SURVIVED_ATK_F() -> String { return "Survived a violent attack. "; }
    public static func SURVIVED_ATK_M() -> String { return ""; }
    public static func KILLED_DEFENSE_F() -> String { return "Killed someone in self-defense. "; }
    public static func KILLED_DEFENSE_M() -> String { return ""; }
    public static func GANG_WAR_F() -> String { return "Survived a gang war. "; }
    public static func GANG_WAR_M() -> String { return ""; }
    public static func SHOT_F() -> String { return "Was shot and survived. "; }
    public static func SHOT_M() -> String { return ""; }
    public static func STABBED_F() -> String { return "Was stabbed and survived. "; }
    public static func STABBED_M() -> String { return ""; }
    public static func LEFT_DEAD_F() -> String { return "Was left for dead but survived. "; }
    public static func LEFT_DEAD_M() -> String { return ""; }

    // === MISC ===
    public static func MOVED_NC_F() -> String { return "Moved to Night City. "; }
    public static func MOVED_NC_M() -> String { return ""; }
    public static func LEFT_NC_F() -> String { return "Left Night City temporarily. "; }
    public static func LEFT_NC_M() -> String { return ""; }
    public static func JOINED_CULT_F() -> String { return "Joined a cult. "; }
    public static func JOINED_CULT_M() -> String { return ""; }
    public static func LEFT_CULT_F() -> String { return "Left a cult. "; }
    public static func LEFT_CULT_M() -> String { return ""; }
    public static func BECAME_NOMAD_F() -> String { return "Left city life to become a nomad. "; }
    public static func BECAME_NOMAD_M() -> String { return ""; }
    public static func LEFT_NOMADS_F() -> String { return "Left nomad life for the city. "; }
    public static func LEFT_NOMADS_M() -> String { return ""; }
    public static func ID_CHANGE_F() -> String { return "Changed identity to escape past. "; }
    public static func ID_CHANGE_M() -> String { return ""; }
    public static func WENT_MISSING_F() -> String { return "Went missing for several months. "; }
    public static func WENT_MISSING_M() -> String { return ""; }
    public static func MEMORY_LOSS_F() -> String { return "Suffered partial memory loss. "; }
    public static func MEMORY_LOSS_M() -> String { return ""; }
    public static func FOUND_FAITH_F() -> String { return "Found faith in a higher power. "; }
    public static func FOUND_FAITH_M() -> String { return ""; }
    public static func LOST_FAITH_F() -> String { return "Lost faith entirely. "; }
    public static func LOST_FAITH_M() -> String { return ""; }
    public static func POLITICAL_F() -> String { return "Had a political awakening. "; }
    public static func POLITICAL_M() -> String { return ""; }
    public static func ACTIVISM_F() -> String { return "Became involved in activism. "; }
    public static func ACTIVISM_M() -> String { return ""; }

    // === EXPANDED: RELATIONSHIPS ===
    public static func HEARTBROKEN_ADULT_F() -> String { return "Had her heart broken in adulthood. "; }
    public static func HEARTBROKEN_ADULT_M() -> String { return "Had his heart broken in adulthood. "; }

    // === EXPANDED: GANG INVOLVEMENT ===
    public static func JOINED_GANG_ADULT_F() -> String { return "Joined a gang later in life. "; }
    public static func JOINED_GANG_ADULT_M() -> String { return ""; }

    // === EXPANDED: MENTORSHIP ===
    public static func MENTORED_ADULT_F() -> String { return "Found a mentor who changed her life. "; }
    public static func MENTORED_ADULT_M() -> String { return "Found a mentor who changed his life. "; }

    // === EXPANDED: NEAR-DEATH ===
    public static func NEAR_DEATH_ADULT_F() -> String { return "Nearly died as an adult. "; }
    public static func NEAR_DEATH_ADULT_M() -> String { return ""; }

    // === EXPANDED: CAREER ===
    public static func PROMOTED_F() -> String { return "Got promoted at work. "; }
    public static func PROMOTED_M() -> String { return ""; }
    public static func FIRED_UNFAIRLY_F() -> String { return "Was fired unfairly. "; }
    public static func FIRED_UNFAIRLY_M() -> String { return ""; }
    public static func STARTED_BUSINESS_F() -> String { return "Started a small business. "; }
    public static func STARTED_BUSINESS_M() -> String { return ""; }
    public static func BUSINESS_FAILED_F() -> String { return "Had a business venture fail. "; }
    public static func BUSINESS_FAILED_M() -> String { return ""; }
    public static func CAREER_CHANGE_F() -> String { return "Made a major career change. "; }
    public static func CAREER_CHANGE_M() -> String { return ""; }

    // === EXPANDED: CRIME ===
    public static func FIRST_KILL_F() -> String { return "Committed her first kill. "; }
    public static func FIRST_KILL_M() -> String { return "Committed his first kill. "; }
    public static func HITMAN_JOB_F() -> String { return "Took a job as a hitman. "; }
    public static func HITMAN_JOB_M() -> String { return ""; }
    public static func HEIST_SUCCESS_F() -> String { return "Pulled off a successful heist. "; }
    public static func HEIST_SUCCESS_M() -> String { return ""; }
    public static func HEIST_FAILED_F() -> String { return "Had a heist go wrong. "; }
    public static func HEIST_FAILED_M() -> String { return ""; }
    public static func INFORMANT_F() -> String { return "Became a police informant. "; }
    public static func INFORMANT_M() -> String { return ""; }
    public static func WITNESS_PROTECTION_F() -> String { return "Entered witness protection. "; }
    public static func WITNESS_PROTECTION_M() -> String { return ""; }

    // === EXPANDED: TRAUMA ===
    public static func MUGGED_F() -> String { return "Was violently mugged. "; }
    public static func MUGGED_M() -> String { return ""; }
    public static func HOME_INVASION_F() -> String { return "Survived a home invasion. "; }
    public static func HOME_INVASION_M() -> String { return ""; }
    public static func TORTURED_F() -> String { return "Was tortured for information. "; }
    public static func TORTURED_M() -> String { return ""; }
    public static func BUILDING_COLLAPSE_F() -> String { return "Survived a building collapse. "; }
    public static func BUILDING_COLLAPSE_M() -> String { return ""; }

    // === EXPANDED: RELATIONSHIPS ===
    public static func GOT_MARRIED_F() -> String { return "Got married. "; }
    public static func GOT_MARRIED_M() -> String { return ""; }
    public static func GOT_DIVORCED_F() -> String { return "Got divorced. "; }
    public static func GOT_DIVORCED_M() -> String { return ""; }
    public static func SPOUSE_DIED_F() -> String { return "Lost a spouse to violence. "; }
    public static func SPOUSE_DIED_M() -> String { return ""; }
    public static func CHILD_DIED_F() -> String { return "Lost a child. "; }
    public static func CHILD_DIED_M() -> String { return ""; }
    public static func CAUGHT_CHEATING_F() -> String { return "Was caught cheating. "; }
    public static func CAUGHT_CHEATING_M() -> String { return ""; }
    public static func RECONCILED_F() -> String { return "Reconciled with estranged family. "; }
    public static func RECONCILED_M() -> String { return ""; }

    // === EXPANDED: HEALTH ===
    public static func DIAGNOSED_ILLNESS_F() -> String { return "Was diagnosed with a serious illness. "; }
    public static func DIAGNOSED_ILLNESS_M() -> String { return ""; }
    public static func BEAT_ILLNESS_F() -> String { return "Beat a serious illness. "; }
    public static func BEAT_ILLNESS_M() -> String { return ""; }
    public static func CYBERWARE_REJECTION_F() -> String { return "Suffered cyberware rejection syndrome. "; }
    public static func CYBERWARE_REJECTION_M() -> String { return ""; }
    public static func ORGAN_REPLACEMENT_F() -> String { return "Had an organ replaced with cyberware. "; }
    public static func ORGAN_REPLACEMENT_M() -> String { return ""; }
    public static func BRAIN_DAMAGE_F() -> String { return "Suffered brain damage from an accident. "; }
    public static func BRAIN_DAMAGE_M() -> String { return ""; }
    public static func LOST_LIMB_F() -> String { return "Lost a limb and got a cybernetic replacement. "; }
    public static func LOST_LIMB_M() -> String { return ""; }

    // === EXPANDED: SUCCESS ===
    public static func LOTTERY_WIN_F() -> String { return "Won a small lottery. "; }
    public static func LOTTERY_WIN_M() -> String { return ""; }
    public static func FAMOUS_BRIEFLY_F() -> String { return "Was briefly famous. "; }
    public static func FAMOUS_BRIEFLY_M() -> String { return ""; }
    public static func VIRAL_MOMENT_F() -> String { return "Had a viral moment on the net. "; }
    public static func VIRAL_MOMENT_M() -> String { return ""; }
    public static func SAVED_SOMEONE_F() -> String { return "Saved someone's life. "; }
    public static func SAVED_SOMEONE_M() -> String { return ""; }
    public static func AWARD_F() -> String { return "Won a professional award. "; }
    public static func AWARD_M() -> String { return ""; }

    // === EXPANDED: MISC ===
    public static func WENT_CORPO_F() -> String { return "Went corporate after years on the street. "; }
    public static func WENT_CORPO_M() -> String { return ""; }
    public static func LEFT_CORPO_F() -> String { return "Left the corporate world behind. "; }
    public static func LEFT_CORPO_M() -> String { return ""; }
    public static func MOVED_DISTRICT_F() -> String { return "Moved to a different district. "; }
    public static func MOVED_DISTRICT_M() -> String { return ""; }
    public static func HOMELESS_PERIOD_F() -> String { return "Spent time homeless. "; }
    public static func HOMELESS_PERIOD_M() -> String { return ""; }
    public static func DEBT_CRISIS_F() -> String { return "Went through a severe debt crisis. "; }
    public static func DEBT_CRISIS_M() -> String { return ""; }
    public static func IDENTITY_STOLEN_F() -> String { return "Had identity stolen. "; }
    public static func IDENTITY_STOLEN_M() -> String { return ""; }

    // === EXPANDED: VIOLENCE ===
    public static func DRIVE_BY_F() -> String { return "Survived a drive-by shooting. "; }
    public static func DRIVE_BY_M() -> String { return ""; }
    public static func GANG_BEATING_F() -> String { return "Received a gang beating. "; }
    public static func GANG_BEATING_M() -> String { return ""; }
    public static func CARJACKED_F() -> String { return "Was carjacked at gunpoint. "; }
    public static func CARJACKED_M() -> String { return ""; }

    // === EXPANDED: WORK DRAMA ===
    public static func WORKPLACE_AFFAIR_F() -> String { return "Had an affair at work. "; }
    public static func WORKPLACE_AFFAIR_M() -> String { return ""; }
    public static func WORKPLACE_ENEMY_F() -> String { return "Made a bitter enemy at work. "; }
    public static func WORKPLACE_ENEMY_M() -> String { return ""; }
    public static func QUIT_DRAMATICALLY_F() -> String { return "Quit a job dramatically. "; }
    public static func QUIT_DRAMATICALLY_M() -> String { return ""; }
    public static func CORPORATE_PURGE_F() -> String { return "Survived a corporate purge. "; }
    public static func CORPORATE_PURGE_M() -> String { return ""; }
    public static func LAYOFF_F() -> String { return "Was laid off unexpectedly. "; }
    public static func LAYOFF_M() -> String { return ""; }
    public static func DEMOTION_F() -> String { return "Was demoted at work. "; }
    public static func DEMOTION_M() -> String { return ""; }
    public static func TRANSFERRED_F() -> String { return "Was transferred against her will. "; }
    public static func TRANSFERRED_M() -> String { return "Was transferred against his will. "; }

    // === EXPANDED: PERSONAL GROWTH ===
    public static func LEARNED_LANGUAGE_F() -> String { return "Learned a new language. "; }
    public static func LEARNED_LANGUAGE_M() -> String { return ""; }
    public static func GOT_DEGREE_F() -> String { return "Earned a degree. "; }
    public static func GOT_DEGREE_M() -> String { return ""; }
    public static func NEW_SKILL_F() -> String { return "Learned a valuable new skill. "; }
    public static func NEW_SKILL_M() -> String { return ""; }
    public static func SOBRIETY_F() -> String { return "Got sober after addiction. "; }
    public static func SOBRIETY_M() -> String { return ""; }
    public static func THERAPY_F() -> String { return "Started therapy. "; }
    public static func THERAPY_M() -> String { return ""; }
    public static func FITNESS_F() -> String { return "Got serious about fitness. "; }
    public static func FITNESS_M() -> String { return ""; }

    // === EXPANDED: FAMILY ===
    public static func LOST_CUSTODY_F() -> String { return "Lost custody of a child. "; }
    public static func LOST_CUSTODY_M() -> String { return ""; }
    public static func MISCARRIAGE_F() -> String { return "Suffered a miscarriage. "; }
    public static func MISCARRIAGE_M() -> String { return ""; }
    public static func ESTRANGED_FAMILY_F() -> String { return "Became estranged from family. "; }
    public static func ESTRANGED_FAMILY_M() -> String { return ""; }
    public static func CARETAKER_F() -> String { return "Became a caretaker for a sick relative. "; }
    public static func CARETAKER_M() -> String { return ""; }
    public static func PARENT_DIED_F() -> String { return "Lost a parent. "; }
    public static func PARENT_DIED_M() -> String { return ""; }

    // === EXPANDED: LEGAL ===
    public static func SUED_F() -> String { return "Was sued in civil court. "; }
    public static func SUED_M() -> String { return ""; }
    public static func WON_LAWSUIT_F() -> String { return "Won a lawsuit. "; }
    public static func WON_LAWSUIT_M() -> String { return ""; }
    public static func LOST_LAWSUIT_F() -> String { return "Lost a lawsuit badly. "; }
    public static func LOST_LAWSUIT_M() -> String { return ""; }
    public static func PROBATION_F() -> String { return "Was put on probation. "; }
    public static func PROBATION_M() -> String { return ""; }
    public static func CHARGES_DROPPED_F() -> String { return "Had charges dropped. "; }
    public static func CHARGES_DROPPED_M() -> String { return ""; }
    public static func WRONGFUL_ARREST_F() -> String { return "Was wrongfully arrested. "; }
    public static func WRONGFUL_ARREST_M() -> String { return ""; }

    // === EXPANDED: UNDERWORLD ===
    public static func FIRST_FIXER_JOB_F() -> String { return "Completed first job for a fixer. "; }
    public static func FIRST_FIXER_JOB_M() -> String { return ""; }
    public static func DOUBLE_CROSSED_F() -> String { return "Was double-crossed on a job. "; }
    public static func DOUBLE_CROSSED_M() -> String { return ""; }
    public static func SCORED_BIG_F() -> String { return "Scored big on a job. "; }
    public static func SCORED_BIG_M() -> String { return ""; }
    public static func BURNED_FIXER_F() -> String { return "Burned a fixer and made enemies. "; }
    public static func BURNED_FIXER_M() -> String { return ""; }
    public static func REP_BOOST_F() -> String { return "Reputation increased significantly. "; }
    public static func REP_BOOST_M() -> String { return ""; }
    public static func REP_TANK_F() -> String { return "Reputation tanked after a failed job. "; }
    public static func REP_TANK_M() -> String { return ""; }

    // === NET / TECH CULTURE ===
    public static func HACKED_BY_VDBS_F() -> String { return "Was hacked by the Voodoo Boys. Lost three days of memory. "; }
    public static func HACKED_BY_VDBS_M() -> String { return ""; }
    public static func ICE_BREACH_F() -> String { return "Personal ICE was breached. Financial data compromised. "; }
    public static func ICE_BREACH_M() -> String { return ""; }
    public static func SOLD_DATA_F() -> String { return "Sold personal data to a corp for quick eddies. "; }
    public static func SOLD_DATA_M() -> String { return ""; }
    public static func DEEP_NET_F() -> String { return "Went deep into the Old Net. Came back different. "; }
    public static func DEEP_NET_M() -> String { return ""; }
    public static func SHARD_MALWARE_F() -> String { return "Slotted a shard loaded with malware. "; }
    public static func SHARD_MALWARE_M() -> String { return ""; }
    public static func DATA_BROKER_F() -> String { return "Works as a data broker on the side. "; }
    public static func DATA_BROKER_M() -> String { return ""; }
    public static func DAEMON_ATTACK_F() -> String { return "Survived a daemon attack through a public terminal. "; }
    public static func DAEMON_ATTACK_M() -> String { return ""; }
    public static func GHOST_PROFILE_F() -> String { return "Maintains a ghost profile — minimal net footprint. "; }
    public static func GHOST_PROFILE_M() -> String { return ""; }

    // === CORPO INTRIGUE ===
    public static func CORPO_SABOTAGE_F() -> String { return "Was the target of corporate sabotage. "; }
    public static func CORPO_SABOTAGE_M() -> String { return ""; }
    public static func CORPO_ESPIONAGE_F() -> String { return "Participated in corporate espionage. "; }
    public static func CORPO_ESPIONAGE_M() -> String { return ""; }
    public static func CORPO_RELOCATION_F() -> String { return "Was forcibly relocated by her employer. "; }
    public static func CORPO_RELOCATION_M() -> String { return "Was forcibly relocated by his employer. "; }
    public static func CORPO_BUYOUT_F() -> String { return "Survived a hostile corporate buyout. "; }
    public static func CORPO_BUYOUT_M() -> String { return ""; }
    public static func NDA_VIOLATION_F() -> String { return "Broke an NDA. Legal consequences pending. "; }
    public static func NDA_VIOLATION_M() -> String { return ""; }
    public static func CORPO_EXPERIMENT_F() -> String { return "Was unknowingly part of a corporate experiment. "; }
    public static func CORPO_EXPERIMENT_M() -> String { return ""; }
    public static func GOLDEN_PARACHUTE_F() -> String { return "Left a corp with a generous severance package. "; }
    public static func GOLDEN_PARACHUTE_M() -> String { return ""; }

    // === NIGHT CITY SURVIVAL ===
    public static func ACID_RAIN_F() -> String { return "Suffered chemical burns from acid rain exposure. "; }
    public static func ACID_RAIN_M() -> String { return ""; }
    public static func BUILDING_FIRE_F() -> String { return "Lost everything in an apartment building fire. "; }
    public static func BUILDING_FIRE_M() -> String { return ""; }
    public static func MEGABUILDING_LOCKDOWN_F() -> String { return "Survived a megabuilding lockdown. "; }
    public static func MEGABUILDING_LOCKDOWN_M() -> String { return ""; }
    public static func POWER_GRID_F() -> String { return "Went two weeks without power during a grid failure. "; }
    public static func POWER_GRID_M() -> String { return ""; }
    public static func CONTAMINATED_WATER_F() -> String { return "Was poisoned by contaminated water supply. "; }
    public static func CONTAMINATED_WATER_M() -> String { return ""; }
    public static func SCAV_TARGET_F() -> String { return "Was targeted by Scavengers for organ harvesting. Escaped. "; }
    public static func SCAV_TARGET_M() -> String { return ""; }
    public static func CYBERPSYCHO_ATTACK_F() -> String { return "Caught in the crossfire of a cyberpsycho rampage. "; }
    public static func CYBERPSYCHO_ATTACK_M() -> String { return ""; }
    public static func DELAMAIN_CRASH_F() -> String { return "Was in a Delamain cab during a system malfunction. "; }
    public static func DELAMAIN_CRASH_M() -> String { return ""; }
    public static func NCART_MUGGED_F() -> String { return "Was mugged on the NCART. "; }
    public static func NCART_MUGGED_M() -> String { return ""; }
    public static func STRAY_BULLET_F() -> String { return "Was hit by a stray bullet during a street shootout. "; }
    public static func STRAY_BULLET_M() -> String { return ""; }

    // === MEDICAL / TRAUMA TEAM ===
    public static func TT_SAVED_F() -> String { return "Was saved by Trauma Team. Still paying the bill. "; }
    public static func TT_SAVED_M() -> String { return ""; }
    public static func TT_DENIED_F() -> String { return "Trauma Team refused service. Coverage had lapsed. "; }
    public static func TT_DENIED_M() -> String { return ""; }
    public static func BAD_RIPPER_F() -> String { return "Went to a back-alley ripperdoc. Got an infection. "; }
    public static func BAD_RIPPER_M() -> String { return ""; }
    public static func ORGAN_SOLD_F() -> String { return "Sold a kidney to pay off debts. "; }
    public static func ORGAN_SOLD_M() -> String { return ""; }
    public static func CLONED_ORGAN_F() -> String { return "Received a cloned organ transplant. "; }
    public static func CLONED_ORGAN_M() -> String { return ""; }
    public static func EXPERIMENTAL_DRUG_F() -> String { return "Volunteered for experimental drug trials. "; }
    public static func EXPERIMENTAL_DRUG_M() -> String { return ""; }
    public static func MISDIAGNOSED_F() -> String { return "Was misdiagnosed and received wrong treatment. "; }
    public static func MISDIAGNOSED_M() -> String { return ""; }

    // === BRAINDANCE / MEDIA ===
    public static func BD_RECORDED_F() -> String { return "Was unknowingly recorded for a braindance. "; }
    public static func BD_RECORDED_M() -> String { return ""; }
    public static func XBD_EXPOSURE_F() -> String { return "Was exposed to illegal XBDs. Still affected. "; }
    public static func XBD_EXPOSURE_M() -> String { return ""; }
    public static func MEDIA_INTERVIEW_F() -> String { return "Was interviewed by a media crew. Story was twisted. "; }
    public static func MEDIA_INTERVIEW_M() -> String { return ""; }
    public static func DEEPFAKE_F() -> String { return "Was the victim of a deepfake scandal. "; }
    public static func DEEPFAKE_M() -> String { return ""; }
    public static func PIRATE_RADIO_F() -> String { return "Ran a pirate radio station. "; }
    public static func PIRATE_RADIO_M() -> String { return ""; }

    // === DISPLACEMENT / MIGRATION ===
    public static func FLED_PACIFICA_F() -> String { return "Fled Pacifica after the collapse. "; }
    public static func FLED_PACIFICA_M() -> String { return ""; }
    public static func CLIMATE_REFUGEE_F() -> String { return "Climate refugee from the Southwest droughts. "; }
    public static func CLIMATE_REFUGEE_M() -> String { return ""; }
    public static func CORPO_WAR_REFUGEE_F() -> String { return "Displaced by the Fourth Corporate War. "; }
    public static func CORPO_WAR_REFUGEE_M() -> String { return ""; }
    public static func SQUATTER_F() -> String { return "Squatting in an abandoned building. "; }
    public static func SQUATTER_M() -> String { return ""; }
    public static func EVICTED_MEGA_F() -> String { return "Was evicted from a megabuilding for unpaid rent. "; }
    public static func EVICTED_MEGA_M() -> String { return ""; }

    // === VIGILANTE / JUSTICE ===
    public static func VIGILANTE_F() -> String { return "Took justice into her own hands once. "; }
    public static func VIGILANTE_M() -> String { return "Took justice into his own hands once. "; }
    public static func WRONGFUL_NCPD_F() -> String { return "Was beaten by NCPD during a false arrest. "; }
    public static func WRONGFUL_NCPD_M() -> String { return ""; }
    public static func BRIBE_NCPD_F() -> String { return "Bribed NCPD to avoid charges. "; }
    public static func BRIBE_NCPD_M() -> String { return ""; }
    public static func TURNED_IN_FRIEND_F() -> String { return "Turned in a friend for the bounty. "; }
    public static func TURNED_IN_FRIEND_M() -> String { return ""; }

    // === RIPPERDOC / CYBERWARE CULTURE ===
    public static func CHROME_JUNKIE_F() -> String { return "Gets new chrome every month. Can't stop upgrading. "; }
    public static func CHROME_JUNKIE_M() -> String { return ""; }
    public static func STRIPPED_CHROME_F() -> String { return "Had chrome forcibly stripped by Scavengers. "; }
    public static func STRIPPED_CHROME_M() -> String { return ""; }
    public static func SECONDHAND_CHROME_F() -> String { return "Running secondhand chrome pulled from a corpse. "; }
    public static func SECONDHAND_CHROME_M() -> String { return ""; }
    public static func SANDEVISTAN_SIDE_F() -> String { return "Suffering side effects from Sandevistan overuse. "; }
    public static func SANDEVISTAN_SIDE_M() -> String { return ""; }
    public static func KIROSHI_GLITCH_F() -> String { return "Kiroshi optics keep glitching. Can't afford a fix. "; }
    public static func KIROSHI_GLITCH_M() -> String { return ""; }

    // === COMMUNITY / SOCIAL ===
    public static func BLOCK_PARTY_F() -> String { return "Organized a block party that turned into a brawl. "; }
    public static func BLOCK_PARTY_M() -> String { return ""; }
    public static func NEIGHBORHOOD_WATCH_F() -> String { return "Started a neighborhood watch. "; }
    public static func NEIGHBORHOOD_WATCH_M() -> String { return ""; }
    public static func FOOD_BANK_F() -> String { return "Volunteers at a food bank. "; }
    public static func FOOD_BANK_M() -> String { return ""; }
    public static func STREET_PREACHER_F() -> String { return "Became a street preacher. "; }
    public static func STREET_PREACHER_M() -> String { return ""; }
    public static func UNDERGROUND_FIGHT_F() -> String { return "Competed in underground fights. "; }
    public static func UNDERGROUND_FIGHT_M() -> String { return ""; }

    // === ROMANTIC / PERSONAL ===
    public static func JOYTOY_RELATIONSHIP_F() -> String { return "Fell in love with a joytoy. "; }
    public static func JOYTOY_RELATIONSHIP_M() -> String { return ""; }
    public static func STALKED_F() -> String { return "Was stalked by an ex. "; }
    public static func STALKED_M() -> String { return ""; }
    public static func CATFISHED_F() -> String { return "Was catfished through a dating service. "; }
    public static func CATFISHED_M() -> String { return ""; }
    public static func PREGNANT_SCARE_F() -> String { return "Had a pregnancy scare that changed everything. "; }
    public static func PREGNANT_SCARE_M() -> String { return "Partner had a pregnancy scare that changed everything. "; }
    public static func ELOPED_F() -> String { return "Eloped. Family doesn't know. "; }
    public static func ELOPED_M() -> String { return ""; }

    // === TRANSPORTATION / VEHICLES ===
    public static func ROAD_RAGE_F() -> String { return "Was involved in a road rage incident on the highway. "; }
    public static func ROAD_RAGE_M() -> String { return ""; }
    public static func STOLEN_CAR_F() -> String { return "Had car stolen. Never recovered. "; }
    public static func STOLEN_CAR_M() -> String { return ""; }
    public static func ILLEGAL_RACING_F() -> String { return "Got into illegal street racing. "; }
    public static func ILLEGAL_RACING_M() -> String { return ""; }
    public static func SMUGGLER_RUN_F() -> String { return "Did a smuggling run through the Badlands. "; }
    public static func SMUGGLER_RUN_M() -> String { return ""; }

    // === ECONOMIC DESPERATION ===
    public static func SOLD_BLOOD_F() -> String { return "Sells blood regularly to make rent. "; }
    public static func SOLD_BLOOD_M() -> String { return ""; }
    public static func DUMPSTER_DIVING_F() -> String { return "Survives partly on dumpster diving. "; }
    public static func DUMPSTER_DIVING_M() -> String { return ""; }
    public static func PAYDAY_LOAN_F() -> String { return "Trapped in a cycle of payday loans. "; }
    public static func PAYDAY_LOAN_M() -> String { return ""; }
    public static func SOLD_POSSESSIONS_F() -> String { return "Sold everything of value to stay afloat. "; }
    public static func SOLD_POSSESSIONS_M() -> String { return ""; }
    public static func CORPO_INDENTURED_F() -> String { return "Signed an indentured labor contract with a corp. "; }
    public static func CORPO_INDENTURED_M() -> String { return ""; }

    // === FIXERS / MERC LIFE ===
    public static func FIXER_BLACKLIST_F() -> String { return "Was blacklisted by every fixer in Watson. "; }
    public static func FIXER_BLACKLIST_M() -> String { return ""; }
    public static func BOTCHED_DELIVERY_F() -> String { return "Botched a delivery run. Package never made it. "; }
    public static func BOTCHED_DELIVERY_M() -> String { return ""; }
    public static func MERC_AMBUSH_F() -> String { return "Was set up on a gig. Barely walked away. "; }
    public static func MERC_AMBUSH_M() -> String { return ""; }
    public static func SOLD_OUT_CLIENT_F() -> String { return "Sold out a client for double the payout. "; }
    public static func SOLD_OUT_CLIENT_M() -> String { return ""; }
    public static func CLEAN_RECORD_F() -> String { return "Has a clean record with fixers. Always delivers. "; }
    public static func CLEAN_RECORD_M() -> String { return ""; }
    public static func FIXER_FAVOR_F() -> String { return "Did a favor for a fixer. Has a marker to call in. "; }
    public static func FIXER_FAVOR_M() -> String { return ""; }
    public static func CREW_WIPED_F() -> String { return "Entire crew was wiped on a job. Only survivor. "; }
    public static func CREW_WIPED_M() -> String { return ""; }
    public static func STOLEN_GOODS_F() -> String { return "Sitting on stolen goods no fence will touch. "; }
    public static func STOLEN_GOODS_M() -> String { return ""; }
    public static func DOUBLE_BOOKED_F() -> String { return "Took two gigs at once. Finished neither. "; }
    public static func DOUBLE_BOOKED_M() -> String { return ""; }
    public static func MERC_RETIREMENT_F() -> String { return "Tried to retire from merc work. Got pulled back in. "; }
    public static func MERC_RETIREMENT_M() -> String { return ""; }

    // === ARASAKA / MILITECH / CORP SPECIFIC ===
    public static func ARASAKA_INTERVIEW_F() -> String { return "Was interviewed by Arasaka counterintelligence. "; }
    public static func ARASAKA_INTERVIEW_M() -> String { return ""; }
    public static func MILITECH_CONTRACT_F() -> String { return "Signed a Militech security contractor agreement. "; }
    public static func MILITECH_CONTRACT_M() -> String { return ""; }
    public static func BIOTECHNICA_TRIAL_F() -> String { return "Was a test subject in a Biotechnica pharmaceutical trial. "; }
    public static func BIOTECHNICA_TRIAL_M() -> String { return ""; }
    public static func KANG_TAO_DEBT_F() -> String { return "Owes a significant debt to Kang Tao. "; }
    public static func KANG_TAO_DEBT_M() -> String { return ""; }
    public static func PETROCHEM_LAYOFF_F() -> String { return "Was laid off during Petrochem downsizing. "; }
    public static func PETROCHEM_LAYOFF_M() -> String { return ""; }
    public static func ZETATECH_RECALL_F() -> String { return "Had Zetatech implants recalled. Still waiting for replacements. "; }
    public static func ZETATECH_RECALL_M() -> String { return ""; }
    public static func ORBITAL_AIR_F() -> String { return "Worked briefly for Orbital Air. Got altitude sickness. "; }
    public static func ORBITAL_AIR_M() -> String { return ""; }
    public static func NIGHT_CORP_DREAM_F() -> String { return "Participated in a Night Corp sleep study. Has strange dreams since. "; }
    public static func NIGHT_CORP_DREAM_M() -> String { return ""; }

    // === DISTRICT-SPECIFIC EVENTS ===
    public static func HEYWOOD_SHOOTOUT_F() -> String { return "Caught in a shootout in Heywood. "; }
    public static func HEYWOOD_SHOOTOUT_M() -> String { return ""; }
    public static func WATSON_LOCKDOWN_F() -> String { return "Was trapped in Watson during a lockdown. "; }
    public static func WATSON_LOCKDOWN_M() -> String { return ""; }
    public static func KABUKI_RIPPER_F() -> String { return "Got discount chrome in Kabuki. Regrets it. "; }
    public static func KABUKI_RIPPER_M() -> String { return ""; }
    public static func JAPANTOWN_DEBT_F() -> String { return "Racked up a debt at a Japantown parlor. "; }
    public static func JAPANTOWN_DEBT_M() -> String { return ""; }
    public static func PACIFICA_SCAV_F() -> String { return "Nearly harvested by Scavs in Pacifica. "; }
    public static func PACIFICA_SCAV_M() -> String { return ""; }
    public static func RANCHO_FLOOD_F() -> String { return "Lost belongings to flooding in Rancho Coronado. "; }
    public static func RANCHO_FLOOD_M() -> String { return ""; }
    public static func DOGTOWN_HUSTLE_F() -> String { return "Ran a hustle out of Dogtown for a few months. "; }
    public static func DOGTOWN_HUSTLE_M() -> String { return ""; }
    public static func CHARTER_HILL_MUGGED_F() -> String { return "Was mugged walking through Charter Hill at night. "; }
    public static func CHARTER_HILL_MUGGED_M() -> String { return ""; }
    public static func BADLANDS_BREAKDOWN_F() -> String { return "Car broke down in the Badlands. Walked for hours. "; }
    public static func BADLANDS_BREAKDOWN_M() -> String { return ""; }
    public static func CITY_CENTER_BOMBING_F() -> String { return "Was near a bombing in City Center. Still flinches at loud sounds. "; }
    public static func CITY_CENTER_BOMBING_M() -> String { return ""; }

    // === SUBSTANCE ABUSE / ADDICTION ===
    public static func GLITTER_ADDICTION_F() -> String { return "Hooked on Glitter. Can't afford to quit. "; }
    public static func GLITTER_ADDICTION_M() -> String { return ""; }
    public static func SYNTHCOKE_F() -> String { return "Has a synthcoke habit. "; }
    public static func SYNTHCOKE_M() -> String { return ""; }
    public static func BLACK_LACE_F() -> String { return "Tried Black Lace. Blacked out for three days. "; }
    public static func BLACK_LACE_M() -> String { return ""; }
    public static func DEALER_F() -> String { return "Deals chems on the corner. "; }
    public static func DEALER_M() -> String { return ""; }
    public static func SOBER_SPONSOR_F() -> String { return "Acts as a sobriety sponsor for others. "; }
    public static func SOBER_SPONSOR_M() -> String { return ""; }
    public static func RELAPSED_F() -> String { return "Relapsed after two years clean. "; }
    public static func RELAPSED_M() -> String { return ""; }
    public static func BOOZE_DEPENDENCE_F() -> String { return "Functional alcoholic. Drinks to cope. "; }
    public static func BOOZE_DEPENDENCE_M() -> String { return ""; }

    // === MILITARIZED / SECURITY ===
    public static func NCPD_BRUTALITY_F() -> String { return "Was brutalized during an NCPD sweep. "; }
    public static func NCPD_BRUTALITY_M() -> String { return ""; }
    public static func MAXTAC_WITNESS_F() -> String { return "Witnessed MaxTac neutralize a cyberpsycho on her block. "; }
    public static func MAXTAC_WITNESS_M() -> String { return "Witnessed MaxTac neutralize a cyberpsycho on his block. "; }
    public static func MILITECH_DRONE_F() -> String { return "Was nearly killed by an errant Militech security drone. "; }
    public static func MILITECH_DRONE_M() -> String { return ""; }
    public static func PRIVATE_SECURITY_F() -> String { return "Worked private security for a corpo exec. "; }
    public static func PRIVATE_SECURITY_M() -> String { return ""; }
    public static func ARASAKA_DETAINED_F() -> String { return "Was detained by Arasaka security for 72 hours without charges. "; }
    public static func ARASAKA_DETAINED_M() -> String { return ""; }
    public static func EVENT_SECURITY_F() -> String { return "Worked event security at Afterlife. "; }
    public static func EVENT_SECURITY_M() -> String { return ""; }

    // === AFTERLIFE / BARS / NIGHTLIFE ===
    public static func AFTERLIFE_REGULAR_F() -> String { return "Is a regular at the Afterlife. "; }
    public static func AFTERLIFE_REGULAR_M() -> String { return ""; }
    public static func BARFIGHT_F() -> String { return "Broke a jaw in a bar fight. "; }
    public static func BARFIGHT_M() -> String { return ""; }
    public static func DRINK_NAMED_F() -> String { return "Had a drink named after her at a dive bar. "; }
    public static func DRINK_NAMED_M() -> String { return "Had a drink named after him at a dive bar. "; }
    public static func BANNED_BAR_F() -> String { return "Banned from three different bars. "; }
    public static func BANNED_BAR_M() -> String { return ""; }
    public static func UNDERGROUND_PARTY_F() -> String { return "Went to an underground party in an abandoned factory. Never talks about what happened. "; }
    public static func UNDERGROUND_PARTY_M() -> String { return ""; }
    public static func NIGHTCLUB_OD_F() -> String { return "Overdosed at a nightclub. Was revived on site. "; }
    public static func NIGHTCLUB_OD_M() -> String { return ""; }

    // === PETS / ANIMALS ===
    public static func PET_CAT_F() -> String { return "Keeps a stray cat in her apartment. "; }
    public static func PET_CAT_M() -> String { return "Keeps a stray cat in his apartment. "; }
    public static func PET_DOG_F() -> String { return "Owns a dog. Only living thing that trusts her. "; }
    public static func PET_DOG_M() -> String { return "Owns a dog. Only living thing that trusts him. "; }
    public static func PET_DIED_F() -> String { return "Lost a pet to a stray bullet. "; }
    public static func PET_DIED_M() -> String { return ""; }
    public static func FEEDS_STRAYS_F() -> String { return "Feeds stray animals in the neighborhood. "; }
    public static func FEEDS_STRAYS_M() -> String { return ""; }

    // === GAMBLING / VICE ===
    public static func PACHINKO_DEBT_F() -> String { return "Has a crippling pachinko addiction. "; }
    public static func PACHINKO_DEBT_M() -> String { return ""; }
    public static func RIGGED_FIGHT_F() -> String { return "Bet on a rigged fight. Lost everything. "; }
    public static func RIGGED_FIGHT_M() -> String { return ""; }
    public static func CASINO_BANNED_F() -> String { return "Banned from multiple casinos for cheating. "; }
    public static func CASINO_BANNED_M() -> String { return ""; }
    public static func BOOKIE_F() -> String { return "Works as a bookie on the side. "; }
    public static func BOOKIE_M() -> String { return ""; }
    public static func POKER_SHARK_F() -> String { return "Cleans out poker games regularly. "; }
    public static func POKER_SHARK_M() -> String { return ""; }

    // === HOUSING / LIVING CONDITIONS ===
    public static func COFFIN_MOTEL_F() -> String { return "Lives in a coffin motel. "; }
    public static func COFFIN_MOTEL_M() -> String { return ""; }
    public static func ROOFTOP_SQUAT_F() -> String { return "Squats on a rooftop. "; }
    public static func ROOFTOP_SQUAT_M() -> String { return ""; }
    public static func ROOMMATE_HELL_F() -> String { return "Has a roommate from hell. "; }
    public static func ROOMMATE_HELL_M() -> String { return ""; }
    public static func UPGRADED_APT_F() -> String { return "Moved up to a nicer apartment. "; }
    public static func UPGRADED_APT_M() -> String { return ""; }
    public static func LIVES_IN_CAR_F() -> String { return "Lives out of a car. "; }
    public static func LIVES_IN_CAR_M() -> String { return ""; }
    public static func NOISE_COMPLAINT_F() -> String { return "Filed 47 noise complaints. None were addressed. "; }
    public static func NOISE_COMPLAINT_M() -> String { return ""; }
    public static func APARTMENT_ROBBERY_F() -> String { return "Apartment was cleaned out while at work. "; }
    public static func APARTMENT_ROBBERY_M() -> String { return ""; }

    // === COMBAT ARENA / SPORTS ===
    public static func BOXING_AMATEUR_F() -> String { return "Fought amateur boxing matches for cash. "; }
    public static func BOXING_AMATEUR_M() -> String { return ""; }
    public static func FIGHT_CLUB_F() -> String { return "Member of an underground fight club. "; }
    public static func FIGHT_CLUB_M() -> String { return ""; }
    public static func RACING_CRASH_F() -> String { return "Crashed during an illegal street race. "; }
    public static func RACING_CRASH_M() -> String { return ""; }
    public static func COMBAT_TOURNAMENT_F() -> String { return "Entered a combat tournament. Lost in the second round. "; }
    public static func COMBAT_TOURNAMENT_M() -> String { return ""; }
    public static func RACING_WIN_F() -> String { return "Won a street race. Still has the car. "; }
    public static func RACING_WIN_M() -> String { return ""; }

    // === DEATH / LOSS ===
    public static func FRIEND_OVERDOSE_F() -> String { return "Found a friend dead from an overdose. "; }
    public static func FRIEND_OVERDOSE_M() -> String { return ""; }
    public static func NEIGHBOR_KILLED_F() -> String { return "Neighbor was killed. Nobody investigated. "; }
    public static func NEIGHBOR_KILLED_M() -> String { return ""; }
    public static func SAW_EXECUTION_F() -> String { return "Witnessed a public execution by a gang. "; }
    public static func SAW_EXECUTION_M() -> String { return ""; }
    public static func BODY_FOUND_F() -> String { return "Found a body in the alley behind her building. "; }
    public static func BODY_FOUND_M() -> String { return "Found a body in the alley behind his building. "; }
    public static func FUNERAL_DEBT_F() -> String { return "Went into debt paying for a funeral. "; }
    public static func FUNERAL_DEBT_M() -> String { return ""; }
    public static func CHOOM_FLATLINED_F() -> String { return "Best choom flatlined on a gig. "; }
    public static func CHOOM_FLATLINED_M() -> String { return ""; }

    // === FOOD / SURVIVAL ===
    public static func FOOD_POISONING_F() -> String { return "Got food poisoning from a street vendor. Nearly died. "; }
    public static func FOOD_POISONING_M() -> String { return ""; }
    public static func KIBBLE_DIET_F() -> String { return "Has been eating nothing but kibble for months. "; }
    public static func KIBBLE_DIET_M() -> String { return ""; }
    public static func REAL_FOOD_F() -> String { return "Tasted real food for the first time. Cried. "; }
    public static func REAL_FOOD_M() -> String { return ""; }
    public static func FOOD_STALL_F() -> String { return "Runs a food stall on the side. "; }
    public static func FOOD_STALL_M() -> String { return ""; }

    // === SCAMS / CON ARTISTRY ===
    public static func FAKE_CHROME_F() -> String { return "Was sold fake chrome. Paid full price. "; }
    public static func FAKE_CHROME_M() -> String { return ""; }
    public static func PYRAMID_SCHEME_F() -> String { return "Got roped into a pyramid scheme. Lost friends and money. "; }
    public static func PYRAMID_SCHEME_M() -> String { return ""; }
    public static func ROMANCE_SCAM_F() -> String { return "Was the target of a romance scam. "; }
    public static func ROMANCE_SCAM_M() -> String { return ""; }
    public static func FAKE_FIXER_F() -> String { return "Was conned by someone posing as a fixer. "; }
    public static func FAKE_FIXER_M() -> String { return ""; }
    public static func SHELL_COMPANY_F() -> String { return "Unknowingly works for a shell company. "; }
    public static func SHELL_COMPANY_M() -> String { return ""; }
    public static func IDENTITY_SOLD_F() -> String { return "Someone is using a copy of her identity. "; }
    public static func IDENTITY_SOLD_M() -> String { return "Someone is using a copy of his identity. "; }

    // === CHILDHOOD ECHOES (Adult Consequences) ===
    public static func ORPHANAGE_REUNION_F() -> String { return "Tracked down others from the same orphanage. "; }
    public static func ORPHANAGE_REUNION_M() -> String { return ""; }
    public static func OLD_BULLY_F() -> String { return "Ran into a childhood bully. It didn't go well. "; }
    public static func OLD_BULLY_M() -> String { return ""; }
    public static func INHERITANCE_SCAM_F() -> String { return "Received notice of a fake inheritance. Classic scam. "; }
    public static func INHERITANCE_SCAM_M() -> String { return ""; }
    public static func FAMILY_SECRET_F() -> String { return "Discovered a dark family secret. "; }
    public static func FAMILY_SECRET_M() -> String { return ""; }
    public static func CHILDHOOD_HOME_DEMOLISHED_F() -> String { return "Childhood home was demolished for a corp development project. "; }
    public static func CHILDHOOD_HOME_DEMOLISHED_M() -> String { return ""; }

    // === UNEXPECTED WINDFALLS ===
    public static func FOUND_STASH_F() -> String { return "Found a hidden stash of eddies in a wall during renovation. "; }
    public static func FOUND_STASH_M() -> String { return ""; }
    public static func WRONG_ACCOUNT_F() -> String { return "A corp accidentally deposited eddies into her account. Spent it before they noticed. "; }
    public static func WRONG_ACCOUNT_M() -> String { return "A corp accidentally deposited eddies into his account. Spent it before they noticed. "; }
    public static func SALVAGE_SCORE_F() -> String { return "Found valuable salvage in a wreck in the Badlands. "; }
    public static func SALVAGE_SCORE_M() -> String { return ""; }
    public static func RARE_SHARD_F() -> String { return "Found a rare data shard worth a fortune. "; }
    public static func RARE_SHARD_M() -> String { return ""; }

    // === BUREAUCRATIC / SYSTEMIC ===
    public static func NC_ID_REVOKED_F() -> String { return "NC ID was revoked. Essentially a non-person. "; }
    public static func NC_ID_REVOKED_M() -> String { return ""; }
    public static func INSURANCE_DENIED_F() -> String { return "Health insurance claim was denied for the third time. "; }
    public static func INSURANCE_DENIED_M() -> String { return ""; }
    public static func PERMIT_REVOKED_F() -> String { return "Business permit was revoked without explanation. "; }
    public static func PERMIT_REVOKED_M() -> String { return ""; }
    public static func TAX_AUDIT_F() -> String { return "Was audited. Owed more than expected. "; }
    public static func TAX_AUDIT_M() -> String { return ""; }
    public static func JURY_DUTY_F() -> String { return "Served on a jury. The defendant disappeared before sentencing. "; }
    public static func JURY_DUTY_M() -> String { return ""; }
    public static func WRONG_ADDRESS_RAID_F() -> String { return "NCPD raided the wrong apartment. Hers. "; }
    public static func WRONG_ADDRESS_RAID_M() -> String { return "NCPD raided the wrong apartment. His. "; }

    // === REVENGE / GRUDGES ===
    public static func REVENGE_SERVED_F() -> String { return "Got revenge on someone who wronged her years ago. "; }
    public static func REVENGE_SERVED_M() -> String { return "Got revenge on someone who wronged him years ago. "; }
    public static func HIT_LIST_F() -> String { return "Is on someone's hit list. Doesn't know whose. "; }
    public static func HIT_LIST_M() -> String { return ""; }
    public static func VENDETTA_F() -> String { return "Carrying a vendetta that consumes every waking moment. "; }
    public static func VENDETTA_M() -> String { return ""; }
    public static func FORGAVE_ENEMY_F() -> String { return "Forgave an old enemy. Surprised everyone. "; }
    public static func FORGAVE_ENEMY_M() -> String { return ""; }

    // === CLOSE CALLS / LUCK ===
    public static func WRONG_PLACE_F() -> String { return "Was at the wrong place at the wrong time. Survived by pure luck. "; }
    public static func WRONG_PLACE_M() -> String { return ""; }
    public static func ELEVATOR_FALL_F() -> String { return "Survived an elevator malfunction in a megabuilding. "; }
    public static func ELEVATOR_FALL_M() -> String { return ""; }
    public static func MISSED_FLIGHT_F() -> String { return "Missed a flight that crashed. "; }
    public static func MISSED_FLIGHT_M() -> String { return ""; }
    public static func STOOD_UP_F() -> String { return "Was stood up for a meeting. The location was bombed an hour later. "; }
    public static func STOOD_UP_M() -> String { return ""; }
    public static func LAST_SECOND_F() -> String { return "Left a building seconds before it collapsed. "; }
    public static func LAST_SECOND_M() -> String { return ""; }

    // === CRAFTSMANSHIP / ARTISAN ===
    public static func WEAPON_SMITH_F() -> String { return "Builds custom weapons in a garage workshop. "; }
    public static func WEAPON_SMITH_M() -> String { return ""; }
    public static func TATTOO_ARTIST_F() -> String { return "Does tattoo work on the side. "; }
    public static func TATTOO_ARTIST_M() -> String { return ""; }
    public static func CAR_MECHANIC_F() -> String { return "Restores old cars as a hobby. "; }
    public static func CAR_MECHANIC_M() -> String { return ""; }
    public static func SHARD_COLLECTOR_F() -> String { return "Collects rare data shards. "; }
    public static func SHARD_COLLECTOR_M() -> String { return ""; }
    public static func BOOTLEG_BD_F() -> String { return "Produces bootleg braindances. "; }
    public static func BOOTLEG_BD_M() -> String { return ""; }

    // === DEBTS / OBLIGATIONS ===
    public static func OWES_GANG_F() -> String { return "Owes a dangerous favor to a gang lieutenant. "; }
    public static func OWES_GANG_M() -> String { return ""; }
    public static func OWES_RIPPER_F() -> String { return "Owes a ripperdoc for emergency surgery. "; }
    public static func OWES_RIPPER_M() -> String { return ""; }
    public static func BLOOD_OATH_F() -> String { return "Bound by a blood oath. Won't say to whom. "; }
    public static func BLOOD_OATH_M() -> String { return ""; }
    public static func COLLATERAL_F() -> String { return "Was used as collateral for someone else's debt. "; }
    public static func COLLATERAL_M() -> String { return ""; }
    public static func DEBT_COLLECTOR_F() -> String { return "Works as a debt collector. Nobody's favorite person. "; }
    public static func DEBT_COLLECTOR_M() -> String { return ""; }

}

