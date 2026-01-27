// Adult life events
public abstract class TextAdulthood {
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
    public static func PAROLE_F() -> String { return "Currently on parole. "; }
    public static func PAROLE_M() -> String { return "Currently on parole. "; }
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
    public static func CYBERPSYCHO_SCARE_F() -> String { return "Had a cyberpsychosis scare and scaled back on chrome. "; }
    public static func CYBERPSYCHO_SCARE_M() -> String { return ""; }
    public static func BOOTLEG_CHROME_F() -> String { return "Installed bootleg chrome that caused complications. "; }
    public static func BOOTLEG_CHROME_M() -> String { return ""; }
    public static func SURGERY_F() -> String { return "Underwent major surgery. "; }
    public static func SURGERY_M() -> String { return ""; }
    public static func CHRONIC_F() -> String { return "Developed a chronic illness. "; }
    public static func CHRONIC_M() -> String { return ""; }
    public static func FLATLINED_F() -> String { return "Flatlined and was revived by ripperdoc. "; }
    public static func FLATLINED_M() -> String { return ""; }

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
    public static func MARRIED_F() -> String { return "Got married. "; }
    public static func MARRIED_M() -> String { return ""; }
    public static func DIVORCED_F() -> String { return "Got divorced. "; }
    public static func DIVORCED_M() -> String { return ""; }
    public static func HAD_CHILD_F() -> String { return "Had a child. "; }
    public static func HAD_CHILD_M() -> String { return ""; }
    public static func LOST_CHILD_F() -> String { return "Lost a child. "; }
    public static func LOST_CHILD_M() -> String { return ""; }
    public static func PARTNER_DIED_F() -> String { return "Partner died tragically. "; }
    public static func PARTNER_DIED_M() -> String { return ""; }
    public static func AFFAIR_F() -> String { return "Had an affair. "; }
    public static func AFFAIR_M() -> String { return ""; }
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
    public static func VIRAL_F() -> String { return "Went viral on the net briefly. "; }
    public static func VIRAL_M() -> String { return ""; }

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
    public static func SURVIVED_MAXTAC_F() -> String { return "Survived a Max-Tac operation. "; }
    public static func SURVIVED_MAXTAC_M() -> String { return ""; }
    public static func CYBERPSYCHO_WIT_F() -> String { return "Witnessed a cyberpsycho attack. "; }
    public static func CYBERPSYCHO_WIT_M() -> String { return ""; }

    // === EXPANDED: RELATIONSHIPS ===
    public static func HEARTBROKEN_F() -> String { return "Had her heart broken. "; }
    public static func HEARTBROKEN_M() -> String { return "Had his heart broken. "; }
    public static func HEARTBROKEN_ADULT_F() -> String { return "Had her heart broken in adulthood. "; }
    public static func HEARTBROKEN_ADULT_M() -> String { return "Had his heart broken in adulthood. "; }
    public static func ROMANTIC_F() -> String { return "Found a romantic partner. "; }
    public static func ROMANTIC_M() -> String { return ""; }

    // === EXPANDED: GANG INVOLVEMENT ===
    public static func JOINED_GANG_F() -> String { return "Joined a gang as an adult. "; }
    public static func JOINED_GANG_M() -> String { return ""; }
    public static func JOINED_GANG_ADULT_F() -> String { return "Joined a gang later in life. "; }
    public static func JOINED_GANG_ADULT_M() -> String { return ""; }
    public static func LEFT_GANG_F() -> String { return "Left the gang life behind. "; }
    public static func LEFT_GANG_M() -> String { return ""; }

    // === EXPANDED: MENTORSHIP ===
    public static func MENTORED_F() -> String { return "Was mentored by an experienced professional. "; }
    public static func MENTORED_M() -> String { return ""; }
    public static func MENTORED_ADULT_F() -> String { return "Found a mentor who changed her life. "; }
    public static func MENTORED_ADULT_M() -> String { return "Found a mentor who changed his life. "; }
    public static func MENTOR_F() -> String { return "Became a mentor to younger people. "; }
    public static func MENTOR_M() -> String { return ""; }

    // === EXPANDED: NEAR-DEATH ===
    public static func NEAR_DEATH_F() -> String { return "Had a near-death experience. "; }
    public static func NEAR_DEATH_M() -> String { return ""; }
    public static func NEAR_DEATH_ADULT_F() -> String { return "Nearly died as an adult. "; }
    public static func NEAR_DEATH_ADULT_M() -> String { return ""; }
    public static func FLATLINED_F() -> String { return "Flatlined and was resuscitated. "; }
    public static func FLATLINED_M() -> String { return ""; }
    public static func COMA_F() -> String { return "Spent time in a coma. "; }
    public static func COMA_M() -> String { return ""; }

}
