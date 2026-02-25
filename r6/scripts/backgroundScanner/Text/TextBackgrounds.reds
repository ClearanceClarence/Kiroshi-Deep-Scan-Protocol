/*
* Background text entries
* Professions, personality traits, and distinguishing characteristics
*/
public abstract class KdspTextBackgrounds {

    // ═══════════════════════════════════════════════════════════
    // PERSONALITY TRAITS
    // ═══════════════════════════════════════════════════════════
    public static func TRAIT_PARANOID() -> String { return "Known for being paranoid. "; }
    public static func TRAIT_AGGRESSIVE() -> String { return "Has an aggressive temperament. "; }
    public static func TRAIT_CALM() -> String { return "Known for staying calm under pressure. "; }
    public static func TRAIT_RECKLESS() -> String { return "Has a reputation for recklessness. "; }
    public static func TRAIT_CALCULATING() -> String { return "Known for being calculating. "; }
    public static func TRAIT_LOYAL() -> String { return "Fiercely loyal to %his% people. "; }
    public static func TRAIT_OPPORTUNIST() -> String { return "Known as an opportunist. "; }
    public static func TRAIT_IDEALIST() -> String { return "Still holds idealistic views. "; }
    public static func TRAIT_CYNICAL() -> String { return "Deeply cynical about the world. "; }
    public static func TRAIT_AMBITIOUS() -> String { return "Driven by ambition. "; }
    public static func TRAIT_VENGEFUL() -> String { return "Known for holding grudges. "; }
    public static func TRAIT_CHARITABLE() -> String { return "Known for charitable acts. "; }
    public static func TRAIT_SECRETIVE() -> String { return "Keeps %his% past secret. "; }
    public static func TRAIT_TRUSTING() -> String { return "Too trusting for Night City. "; }
    public static func TRAIT_SUSPICIOUS() -> String { return "Suspicious of everyone. "; }
    // ═══════════════════════════════════════════════════════════
    // SKILLS / SPECIALIZATIONS
    // ═══════════════════════════════════════════════════════════
    public static func SKILL_DRIVER() -> String { return "Skilled driver. "; }
    public static func SKILL_PILOT() -> String { return "Licensed AV pilot. "; }
    public static func SKILL_HACKER() -> String { return "Competent hacker. "; }
    public static func SKILL_MEDIC() -> String { return "Trained in field medicine. "; }
    public static func SKILL_MARKSMAN() -> String { return "Expert marksman. "; }
    public static func SKILL_BRAWLER() -> String { return "Experienced brawler. "; }
    public static func SKILL_NEGOTIATOR() -> String { return "Skilled negotiator. "; }
    public static func SKILL_STEALTH() -> String { return "Moves unseen when needed. "; }
    public static func SKILL_EXPLOSIVES() -> String { return "Knows %his% way around explosives. "; }
    public static func SKILL_MECHANIC() -> String { return "Can fix almost anything mechanical. "; }
    public static func SKILL_COOK() -> String { return "Known as a decent cook. "; }
    public static func SKILL_LANGUAGE() -> String { return "Speaks multiple languages. "; }
    // ═══════════════════════════════════════════════════════════
    // REPUTATION / STATUS
    // ═══════════════════════════════════════════════════════════
    public static func REP_UNKNOWN() -> String { return "No significant reputation. "; }
    public static func REP_LOCAL() -> String { return "Known in the local area. "; }
    public static func REP_RESPECTED() -> String { return "Respected in certain circles. "; }
    public static func REP_FEARED() -> String { return "Has a reputation that precedes %him%. "; }
    public static func REP_DISGRACED() -> String { return "Carries a disgraced reputation. "; }
    public static func REP_RISING() -> String { return "On the rise in the underworld. "; }
    public static func REP_WASHED_UP() -> String { return "Considered washed up by most. "; }
    public static func REP_LEGEND() -> String { return "Has near-legendary status. "; }
    // ═══════════════════════════════════════════════════════════
    // MOTIVATIONS / GOALS
    // ═══════════════════════════════════════════════════════════
    public static func GOAL_SURVIVE() -> String { return "Just trying to survive. "; }
    public static func GOAL_REVENGE() -> String { return "Seeking revenge for past wrongs. "; }
    public static func GOAL_WEALTH() -> String { return "Driven by the pursuit of eddies. "; }
    public static func GOAL_POWER() -> String { return "Seeks power and influence. "; }
    public static func GOAL_ESCAPE() -> String { return "Dreams of escaping Night City. "; }
    public static func GOAL_FAMILY() -> String { return "Trying to support %his% family. "; }
    public static func GOAL_REDEMPTION() -> String { return "Seeking redemption for past sins. "; }
    public static func GOAL_LEGACY() -> String { return "Wants to leave a legacy. "; }
    public static func GOAL_JUSTICE() -> String { return "Believes in fighting for justice. "; }
    public static func GOAL_FREEDOM() -> String { return "Values freedom above all else. "; }
    // ═══════════════════════════════════════════════════════════
    // PHYSICAL CHARACTERISTICS
    // ═══════════════════════════════════════════════════════════
    public static func PHYS_SCARRED() -> String { return "Bears visible scars from past conflicts. "; }
    public static func PHYS_CHROME_HEAVY() -> String { return "Heavily chromed. "; }
    public static func PHYS_CHROME_LIGHT() -> String { return "Minimal visible chrome. "; }
    public static func PHYS_TATTOOS() -> String { return "Covered in tattoos. "; }
    public static func PHYS_GANG_TATS() -> String { return "Bears gang tattoos. "; }
    public static func PHYS_ATHLETIC() -> String { return "Maintains athletic physique. "; }
    public static func PHYS_WIRY() -> String { return "Lean and wiry build. "; }
    public static func PHYS_IMPOSING() -> String { return "Physically imposing presence. "; }
    public static func PHYS_UNASSUMING() -> String { return "Unassuming appearance. "; }
    // ═══════════════════════════════════════════════════════════
    // CONNECTIONS / RELATIONSHIPS
    // ═══════════════════════════════════════════════════════════
    public static func CONN_FIXER() -> String { return "Has connections to local fixers. "; }
    public static func CONN_GANG() -> String { return "Has gang connections. "; }
    public static func CONN_NCPD() -> String { return "Has contacts in the NCPD. "; }
    public static func CONN_CORPO() -> String { return "Maintains corporate contacts. "; }
    public static func CONN_RIPPER() -> String { return "Knows a good ripperdoc. "; }
    public static func CONN_SMUGGLER() -> String { return "Connected to smuggler networks. "; }
    public static func CONN_MEDIA() -> String { return "Has media contacts. "; }
    public static func CONN_NETRUNNER() -> String { return "Knows netrunners who owe favors. "; }
    public static func CONN_NONE() -> String { return "Keeps to %himself%. "; }
    // ═══════════════════════════════════════════════════════════
    // VICES / WEAKNESSES
    // ═══════════════════════════════════════════════════════════
    public static func VICE_GAMBLING() -> String { return "Has a gambling problem. "; }
    public static func VICE_ALCOHOL() -> String { return "Drinks too much. "; }
    public static func VICE_CHEMS() -> String { return "Uses chems recreationally. "; }
    public static func VICE_BD() -> String { return "Addicted to braindances. "; }
    public static func VICE_SPENDING() -> String { return "Can't hold onto eddies. "; }
    public static func VICE_THRILL() -> String { return "Addicted to thrills and danger. "; }
    public static func VICE_CHROME() -> String { return "Obsessed with getting more chrome. "; }
    public static func VICE_NONE() -> String { return "Keeps %his% vices in check. "; }
    // ═══════════════════════════════════════════════════════════
    // CURRENT STATUS
    // ═══════════════════════════════════════════════════════════
    public static func STATUS_EMPLOYED() -> String { return "Currently employed. "; }
    public static func STATUS_UNEMPLOYED() -> String { return "Currently between jobs. "; }
    public static func STATUS_FREELANCE() -> String { return "Works freelance. "; }
    public static func STATUS_WANTED() -> String { return "Has outstanding warrants. "; }
    public static func STATUS_HIDING() -> String { return "Laying low for now. "; }
    public static func STATUS_RETIRED() -> String { return "Supposedly retired. "; }
    public static func STATUS_DEBT() -> String { return "Deep in debt. "; }
    public static func STATUS_COMFORTABLE() -> String { return "Living comfortably for now. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: MORE PERSONALITY TRAITS
    // ═══════════════════════════════════════════════════════════
    public static func TRAIT_INTROVERTED() -> String { return "Prefers to keep to %himself%. "; }
    public static func TRAIT_EXTROVERTED() -> String { return "Thrives on social interaction. "; }
    public static func TRAIT_IMPULSIVE() -> String { return "Acts on impulse. "; }
    public static func TRAIT_METHODICAL() -> String { return "Approaches everything methodically. "; }
    public static func TRAIT_STUBBORN() -> String { return "Notoriously stubborn. "; }
    public static func TRAIT_ADAPTABLE() -> String { return "Adapts quickly to any situation. "; }
    public static func TRAIT_PESSIMIST() -> String { return "Always expects the worst. "; }
    public static func TRAIT_OPTIMIST() -> String { return "Maintains optimism despite everything. "; }
    public static func TRAIT_PATIENT() -> String { return "Known for %his% patience. "; }
    public static func TRAIT_IMPATIENT() -> String { return "Has no patience for delays. "; }
    public static func TRAIT_GENEROUS() -> String { return "Generous to a fault. "; }
    public static func TRAIT_SELFISH() -> String { return "Looks out for number one. "; }
    public static func TRAIT_HONEST() -> String { return "Brutally honest. "; }
    public static func TRAIT_DECEITFUL() -> String { return "Lies as easily as breathing. "; }
    public static func TRAIT_HUMBLE() -> String { return "Surprisingly humble. "; }
    public static func TRAIT_ARROGANT() -> String { return "Arrogant and knows it. "; }
    public static func TRAIT_PROTECTIVE() -> String { return "Fiercely protective of loved ones. "; }
    public static func TRAIT_DISTANT() -> String { return "Keeps everyone at arm's length. "; }
    public static func TRAIT_CURIOUS() -> String { return "Curiosity often gets %him% into trouble. "; }
    public static func TRAIT_APATHETIC() -> String { return "Doesn't seem to care about anything. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: MORE SKILLS
    // ═══════════════════════════════════════════════════════════
    public static func SKILL_NETRUNNER() -> String { return "Experienced netrunner. "; }
    public static func SKILL_SNIPER() -> String { return "Trained sniper. "; }
    public static func SKILL_KNIFE() -> String { return "Skilled with blades. "; }
    public static func SKILL_MARTIAL_ARTS() -> String { return "Trained in martial arts. "; }
    public static func SKILL_LOCKPICK() -> String { return "Expert lockpick. "; }
    public static func SKILL_SURVEILLANCE() -> String { return "Skilled in surveillance. "; }
    public static func SKILL_FORGERY() -> String { return "Talented forger. "; }
    public static func SKILL_INTERROGATION() -> String { return "Skilled interrogator. "; }
    public static func SKILL_DISGUISE() -> String { return "Master of disguise. "; }
    public static func SKILL_ELECTRONICS() -> String { return "Electronics expert. "; }
    public static func SKILL_CHEMISTRY() -> String { return "Knows chemistry. "; }
    public static func SKILL_FIRST_AID() -> String { return "Basic first aid training. "; }
    public static func SKILL_SURVIVAL() -> String { return "Wilderness survival skills. "; }
    public static func SKILL_STREETWISE() -> String { return "Streetwise and connected. "; }
    public static func SKILL_PERSUASION() -> String { return "Persuasive speaker. "; }
    public static func SKILL_INTIMIDATION() -> String { return "Knows how to intimidate. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: QUIRKS / HABITS
    // ═══════════════════════════════════════════════════════════
    public static func QUIRK_SMOKER() -> String { return "Heavy smoker. "; }
    public static func QUIRK_NIGHT_OWL() -> String { return "Only comes alive at night. "; }
    public static func QUIRK_EARLY_BIRD() -> String { return "Always up before dawn. "; }
    public static func QUIRK_COLLECTOR() -> String { return "Obsessive collector of old tech. "; }
    public static func QUIRK_SUPERSTITIOUS() -> String { return "Highly superstitious. "; }
    public static func QUIRK_GERMAPHOBE() -> String { return "Germaphobe. "; }
    public static func QUIRK_INSOMNIAC() -> String { return "Chronic insomniac. "; }
    public static func QUIRK_WORKAHOLIC() -> String { return "Workaholic tendencies. "; }
    public static func QUIRK_LUCKY() -> String { return "Carries a lucky charm. "; }
    public static func QUIRK_TATTOOS() -> String { return "Gets a new tattoo for every major event. "; }
    public static func QUIRK_MUSIC() -> String { return "Always has music playing. "; }
    public static func QUIRK_READER() -> String { return "Reads actual physical books. "; }
    public static func QUIRK_FITNESS() -> String { return "Obsessed with fitness. "; }
    public static func QUIRK_FOODIE() -> String { return "A foodie who seeks out real food. "; }
    public static func QUIRK_ANIMALS() -> String { return "Has a soft spot for animals. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: FEARS / PHOBIAS
    // ═══════════════════════════════════════════════════════════
    public static func FEAR_HEIGHTS() -> String { return "Afraid of heights. "; }
    public static func FEAR_WATER() -> String { return "Terrified of deep water. "; }
    public static func FEAR_ENCLOSED() -> String { return "Claustrophobic. "; }
    public static func FEAR_CROWDS() -> String { return "Anxious in crowds. "; }
    public static func FEAR_CYBERWARE() -> String { return "Afraid of cyberware. "; }
    public static func FEAR_AI() -> String { return "Distrustful of AI. "; }
    public static func FEAR_SCAVS() -> String { return "Terrified of Scavengers. "; }
    public static func FEAR_MAXTAC() -> String { return "Deeply afraid of MaxTac. "; }
    public static func FEAR_DEATH() -> String { return "Has an intense fear of death. "; }
    public static func FEAR_ABANDONMENT() -> String { return "Fear of abandonment. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: SECRETS
    // ═══════════════════════════════════════════════════════════
    public static func SECRET_PAST() -> String { return "Hiding a dark past. "; }
    public static func SECRET_IDENTITY() -> String { return "Living under a false identity. "; }
    public static func SECRET_INFORMANT() -> String { return "Secret informant for the NCPD. "; }
    public static func SECRET_CORPO_SPY() -> String { return "Actually a corporate spy. "; }
    public static func SECRET_GANG() -> String { return "Has hidden gang affiliations. "; }
    public static func SECRET_WITNESS() -> String { return "Witnessed something %he% wasn't supposed to. "; }
    public static func SECRET_MURDER() -> String { return "Killed someone and covered it up. "; }
    public static func SECRET_FAMILY() -> String { return "Has a secret family. "; }
    public static func SECRET_DEBT() -> String { return "Owes dangerous people money. "; }
    public static func SECRET_SICKNESS() -> String { return "Hiding a terminal illness. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: LIFESTYLE
    // ═══════════════════════════════════════════════════════════
    public static func LIFE_MINIMALIST() -> String { return "Lives a minimalist lifestyle. "; }
    public static func LIFE_FLASHY() -> String { return "Lives flashy, spends big. "; }
    public static func LIFE_FRUGAL() -> String { return "Extremely frugal. "; }
    public static func LIFE_NOMADIC() -> String { return "Never stays in one place long. "; }
    public static func LIFE_HOMEBODY() -> String { return "Rarely leaves home. "; }
    public static func LIFE_PARTY() -> String { return "Lives for the nightlife. "; }
    public static func LIFE_SOLITARY() -> String { return "Prefers solitude. "; }
    public static func LIFE_SOCIAL() -> String { return "Always surrounded by people. "; }
    // ═══════════════════════════════════════════════════════════
    // EXPANDED: BELIEFS
    // ═══════════════════════════════════════════════════════════
    public static func BELIEF_RELIGIOUS() -> String { return "Deeply religious. "; }
    public static func BELIEF_ATHEIST() -> String { return "Staunch atheist. "; }
    public static func BELIEF_SPIRITUAL() -> String { return "Spiritual but not religious. "; }
    public static func BELIEF_TECH() -> String { return "Believes technology will save humanity. "; }
    public static func BELIEF_NATURE() -> String { return "Believes in returning to nature. "; }
    public static func BELIEF_NIHILIST() -> String { return "Nihilistic worldview. "; }
    public static func BELIEF_KARMA() -> String { return "Believes in karma. "; }
    public static func BELIEF_FATE() -> String { return "Believes everything is fated. "; }
    // ═══════════════════════════════════════════════════════════
}
