/*
* Background text entries
* Professions, personality traits, and distinguishing characteristics
*/
public abstract class TextBackgrounds {

    // ═══════════════════════════════════════════════════════════
    // PERSONALITY TRAITS
    // ═══════════════════════════════════════════════════════════
    public static func TRAIT_PARANOID_F() -> String { return "Known for being paranoid. "; }
    public static func TRAIT_PARANOID_M() -> String { return ""; }

    public static func TRAIT_AGGRESSIVE_F() -> String { return "Has an aggressive temperament. "; }
    public static func TRAIT_AGGRESSIVE_M() -> String { return ""; }

    public static func TRAIT_CALM_F() -> String { return "Known for staying calm under pressure. "; }
    public static func TRAIT_CALM_M() -> String { return ""; }

    public static func TRAIT_RECKLESS_F() -> String { return "Has a reputation for recklessness. "; }
    public static func TRAIT_RECKLESS_M() -> String { return ""; }

    public static func TRAIT_CALCULATING_F() -> String { return "Known for being calculating. "; }
    public static func TRAIT_CALCULATING_M() -> String { return ""; }

    public static func TRAIT_LOYAL_F() -> String { return "Fiercely loyal to her people. "; }
    public static func TRAIT_LOYAL_M() -> String { return "Fiercely loyal to his people. "; }

    public static func TRAIT_OPPORTUNIST_F() -> String { return "Known as an opportunist. "; }
    public static func TRAIT_OPPORTUNIST_M() -> String { return ""; }

    public static func TRAIT_IDEALIST_F() -> String { return "Still holds idealistic views. "; }
    public static func TRAIT_IDEALIST_M() -> String { return ""; }

    public static func TRAIT_CYNICAL_F() -> String { return "Deeply cynical about the world. "; }
    public static func TRAIT_CYNICAL_M() -> String { return ""; }

    public static func TRAIT_AMBITIOUS_F() -> String { return "Driven by ambition. "; }
    public static func TRAIT_AMBITIOUS_M() -> String { return ""; }

    public static func TRAIT_VENGEFUL_F() -> String { return "Known for holding grudges. "; }
    public static func TRAIT_VENGEFUL_M() -> String { return ""; }

    public static func TRAIT_CHARITABLE_F() -> String { return "Known for charitable acts. "; }
    public static func TRAIT_CHARITABLE_M() -> String { return ""; }

    public static func TRAIT_SECRETIVE_F() -> String { return "Keeps her past secret. "; }
    public static func TRAIT_SECRETIVE_M() -> String { return "Keeps his past secret. "; }

    public static func TRAIT_TRUSTING_F() -> String { return "Too trusting for Night City. "; }
    public static func TRAIT_TRUSTING_M() -> String { return ""; }

    public static func TRAIT_SUSPICIOUS_F() -> String { return "Suspicious of everyone. "; }
    public static func TRAIT_SUSPICIOUS_M() -> String { return ""; }

    // ═══════════════════════════════════════════════════════════
    // SKILLS / SPECIALIZATIONS
    // ═══════════════════════════════════════════════════════════
    public static func SKILL_DRIVER_F() -> String { return "Skilled driver. "; }
    public static func SKILL_DRIVER_M() -> String { return ""; }

    public static func SKILL_PILOT_F() -> String { return "Licensed AV pilot. "; }
    public static func SKILL_PILOT_M() -> String { return ""; }

    public static func SKILL_HACKER_F() -> String { return "Competent hacker. "; }
    public static func SKILL_HACKER_M() -> String { return ""; }

    public static func SKILL_MEDIC_F() -> String { return "Trained in field medicine. "; }
    public static func SKILL_MEDIC_M() -> String { return ""; }

    public static func SKILL_MARKSMAN_F() -> String { return "Expert marksman. "; }
    public static func SKILL_MARKSMAN_M() -> String { return ""; }

    public static func SKILL_BRAWLER_F() -> String { return "Experienced brawler. "; }
    public static func SKILL_BRAWLER_M() -> String { return ""; }

    public static func SKILL_NEGOTIATOR_F() -> String { return "Skilled negotiator. "; }
    public static func SKILL_NEGOTIATOR_M() -> String { return ""; }

    public static func SKILL_STEALTH_F() -> String { return "Moves unseen when needed. "; }
    public static func SKILL_STEALTH_M() -> String { return ""; }

    public static func SKILL_EXPLOSIVES_F() -> String { return "Knows her way around explosives. "; }
    public static func SKILL_EXPLOSIVES_M() -> String { return "Knows his way around explosives. "; }

    public static func SKILL_MECHANIC_F() -> String { return "Can fix almost anything mechanical. "; }
    public static func SKILL_MECHANIC_M() -> String { return ""; }

    public static func SKILL_COOK_F() -> String { return "Known as a decent cook. "; }
    public static func SKILL_COOK_M() -> String { return ""; }

    public static func SKILL_LANGUAGE_F() -> String { return "Speaks multiple languages. "; }
    public static func SKILL_LANGUAGE_M() -> String { return ""; }

    // ═══════════════════════════════════════════════════════════
    // REPUTATION / STATUS
    // ═══════════════════════════════════════════════════════════
    public static func REP_UNKNOWN_F() -> String { return "No significant reputation. "; }
    public static func REP_UNKNOWN_M() -> String { return ""; }

    public static func REP_LOCAL_F() -> String { return "Known in the local area. "; }
    public static func REP_LOCAL_M() -> String { return ""; }

    public static func REP_RESPECTED_F() -> String { return "Respected in certain circles. "; }
    public static func REP_RESPECTED_M() -> String { return ""; }

    public static func REP_FEARED_F() -> String { return "Has a reputation that precedes her. "; }
    public static func REP_FEARED_M() -> String { return "Has a reputation that precedes him. "; }

    public static func REP_DISGRACED_F() -> String { return "Carries a disgraced reputation. "; }
    public static func REP_DISGRACED_M() -> String { return ""; }

    public static func REP_RISING_F() -> String { return "On the rise in the underworld. "; }
    public static func REP_RISING_M() -> String { return ""; }

    public static func REP_WASHED_UP_F() -> String { return "Considered washed up by most. "; }
    public static func REP_WASHED_UP_M() -> String { return ""; }

    public static func REP_LEGEND_F() -> String { return "Has near-legendary status. "; }
    public static func REP_LEGEND_M() -> String { return ""; }

    // ═══════════════════════════════════════════════════════════
    // MOTIVATIONS / GOALS
    // ═══════════════════════════════════════════════════════════
    public static func GOAL_SURVIVE_F() -> String { return "Just trying to survive. "; }
    public static func GOAL_SURVIVE_M() -> String { return ""; }

    public static func GOAL_REVENGE_F() -> String { return "Seeking revenge for past wrongs. "; }
    public static func GOAL_REVENGE_M() -> String { return ""; }

    public static func GOAL_WEALTH_F() -> String { return "Driven by the pursuit of eddies. "; }
    public static func GOAL_WEALTH_M() -> String { return ""; }

    public static func GOAL_POWER_F() -> String { return "Seeks power and influence. "; }
    public static func GOAL_POWER_M() -> String { return ""; }

    public static func GOAL_ESCAPE_F() -> String { return "Dreams of escaping Night City. "; }
    public static func GOAL_ESCAPE_M() -> String { return ""; }

    public static func GOAL_FAMILY_F() -> String { return "Trying to support her family. "; }
    public static func GOAL_FAMILY_M() -> String { return "Trying to support his family. "; }

    public static func GOAL_REDEMPTION_F() -> String { return "Seeking redemption for past sins. "; }
    public static func GOAL_REDEMPTION_M() -> String { return ""; }

    public static func GOAL_LEGACY_F() -> String { return "Wants to leave a legacy. "; }
    public static func GOAL_LEGACY_M() -> String { return ""; }

    public static func GOAL_JUSTICE_F() -> String { return "Believes in fighting for justice. "; }
    public static func GOAL_JUSTICE_M() -> String { return ""; }

    public static func GOAL_FREEDOM_F() -> String { return "Values freedom above all else. "; }
    public static func GOAL_FREEDOM_M() -> String { return ""; }

    // ═══════════════════════════════════════════════════════════
    // PHYSICAL CHARACTERISTICS
    // ═══════════════════════════════════════════════════════════
    public static func PHYS_SCARRED_F() -> String { return "Bears visible scars from past conflicts. "; }
    public static func PHYS_SCARRED_M() -> String { return ""; }

    public static func PHYS_CHROME_HEAVY_F() -> String { return "Heavily chromed. "; }
    public static func PHYS_CHROME_HEAVY_M() -> String { return ""; }

    public static func PHYS_CHROME_LIGHT_F() -> String { return "Minimal visible chrome. "; }
    public static func PHYS_CHROME_LIGHT_M() -> String { return ""; }

    public static func PHYS_TATTOOS_F() -> String { return "Covered in tattoos. "; }
    public static func PHYS_TATTOOS_M() -> String { return ""; }

    public static func PHYS_GANG_TATS_F() -> String { return "Bears gang tattoos. "; }
    public static func PHYS_GANG_TATS_M() -> String { return ""; }

    public static func PHYS_ATHLETIC_F() -> String { return "Maintains athletic physique. "; }
    public static func PHYS_ATHLETIC_M() -> String { return ""; }

    public static func PHYS_WIRY_F() -> String { return "Lean and wiry build. "; }
    public static func PHYS_WIRY_M() -> String { return ""; }

    public static func PHYS_IMPOSING_F() -> String { return "Physically imposing presence. "; }
    public static func PHYS_IMPOSING_M() -> String { return ""; }

    public static func PHYS_UNASSUMING_F() -> String { return "Unassuming appearance. "; }
    public static func PHYS_UNASSUMING_M() -> String { return ""; }

    // ═══════════════════════════════════════════════════════════
    // CONNECTIONS / RELATIONSHIPS
    // ═══════════════════════════════════════════════════════════
    public static func CONN_FIXER_F() -> String { return "Has connections to local fixers. "; }
    public static func CONN_FIXER_M() -> String { return ""; }

    public static func CONN_GANG_F() -> String { return "Has gang connections. "; }
    public static func CONN_GANG_M() -> String { return ""; }

    public static func CONN_NCPD_F() -> String { return "Has contacts in the NCPD. "; }
    public static func CONN_NCPD_M() -> String { return ""; }

    public static func CONN_CORPO_F() -> String { return "Maintains corporate contacts. "; }
    public static func CONN_CORPO_M() -> String { return ""; }

    public static func CONN_RIPPER_F() -> String { return "Knows a good ripperdoc. "; }
    public static func CONN_RIPPER_M() -> String { return ""; }

    public static func CONN_SMUGGLER_F() -> String { return "Connected to smuggler networks. "; }
    public static func CONN_SMUGGLER_M() -> String { return ""; }

    public static func CONN_MEDIA_F() -> String { return "Has media contacts. "; }
    public static func CONN_MEDIA_M() -> String { return ""; }

    public static func CONN_NETRUNNER_F() -> String { return "Knows netrunners who owe favors. "; }
    public static func CONN_NETRUNNER_M() -> String { return ""; }

    public static func CONN_NONE_F() -> String { return "Keeps to herself. "; }
    public static func CONN_NONE_M() -> String { return "Keeps to himself. "; }

    // ═══════════════════════════════════════════════════════════
    // VICES / WEAKNESSES
    // ═══════════════════════════════════════════════════════════
    public static func VICE_GAMBLING_F() -> String { return "Has a gambling problem. "; }
    public static func VICE_GAMBLING_M() -> String { return ""; }

    public static func VICE_ALCOHOL_F() -> String { return "Drinks too much. "; }
    public static func VICE_ALCOHOL_M() -> String { return ""; }

    public static func VICE_CHEMS_F() -> String { return "Uses chems recreationally. "; }
    public static func VICE_CHEMS_M() -> String { return ""; }

    public static func VICE_BD_F() -> String { return "Addicted to braindances. "; }
    public static func VICE_BD_M() -> String { return ""; }

    public static func VICE_SPENDING_F() -> String { return "Can't hold onto eddies. "; }
    public static func VICE_SPENDING_M() -> String { return ""; }

    public static func VICE_THRILL_F() -> String { return "Addicted to thrills and danger. "; }
    public static func VICE_THRILL_M() -> String { return ""; }

    public static func VICE_CHROME_F() -> String { return "Obsessed with getting more chrome. "; }
    public static func VICE_CHROME_M() -> String { return ""; }

    public static func VICE_NONE_F() -> String { return "Keeps her vices in check. "; }
    public static func VICE_NONE_M() -> String { return "Keeps his vices in check. "; }

    // ═══════════════════════════════════════════════════════════
    // CURRENT STATUS
    // ═══════════════════════════════════════════════════════════
    public static func STATUS_EMPLOYED_F() -> String { return "Currently employed. "; }
    public static func STATUS_EMPLOYED_M() -> String { return ""; }

    public static func STATUS_UNEMPLOYED_F() -> String { return "Currently between jobs. "; }
    public static func STATUS_UNEMPLOYED_M() -> String { return ""; }

    public static func STATUS_FREELANCE_F() -> String { return "Works freelance. "; }
    public static func STATUS_FREELANCE_M() -> String { return ""; }

    public static func STATUS_WANTED_F() -> String { return "Has outstanding warrants. "; }
    public static func STATUS_WANTED_M() -> String { return ""; }

    public static func STATUS_HIDING_F() -> String { return "Laying low for now. "; }
    public static func STATUS_HIDING_M() -> String { return ""; }

    public static func STATUS_RETIRED_F() -> String { return "Supposedly retired. "; }
    public static func STATUS_RETIRED_M() -> String { return ""; }

    public static func STATUS_DEBT_F() -> String { return "Deep in debt. "; }
    public static func STATUS_DEBT_M() -> String { return ""; }

    public static func STATUS_COMFORTABLE_F() -> String { return "Living comfortably for now. "; }
    public static func STATUS_COMFORTABLE_M() -> String { return ""; }

    // ═══════════════════════════════════════════════════════════
}
