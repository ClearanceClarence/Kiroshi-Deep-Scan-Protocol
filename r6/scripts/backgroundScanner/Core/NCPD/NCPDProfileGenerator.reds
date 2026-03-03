// Kiroshi Deep Scan - NCPD Officer Profile Generator
// Procedural background, early life, and recent activity for NCPD officers

public abstract class KdspNCPDProfileGenerator {

    public static func GenerateNCPDBackground(seed: Int32, lifePath: ref<KdspLifePath>) -> String {
        let origin = KdspNCPDProfileGenerator.GetOrigin(seed + 100);
        let path = KdspNCPDProfileGenerator.GetPathToNCPD(seed + 150);
        return origin + " " + path;
    }

    private static func GetOrigin(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 39);
        if roll == 0 { return "Grew up in Heywood. Lost two siblings to gang violence before age 15."; }
        if roll == 1 { return "Watson native. Father was NCPD — killed during a routine traffic stop in Kabuki."; }
        if roll == 2 { return "Corporate brat. Family lost everything when Biotechnica restructured."; }
        if roll == 3 { return "Raised in a Megabuilding in Santo Domingo. Shared a 20-square-meter unit with six people."; }
        if roll == 4 { return "Military family. Three generations of service before Night City swallowed them."; }
        if roll == 5 { return "Orphaned young. Grew up in a Night City group home in Northside."; }
        if roll == 6 { return "Mother was Trauma Team. Father was a drunk. Standard Night City upbringing."; }
        if roll == 7 { return "Ex-Militech contractor. Saw things in the Corporate War that won't leave."; }
        if roll == 8 { return "Former gang associate. Valentinos-adjacent but never made — got out before initiation."; }
        if roll == 9 { return "Street kid from Arroyo. Watched friends get chewed up by the system one by one."; }
        if roll == 10 { return "Nomad background. Family clan dissolved when they hit Night City. Everyone scattered."; }
        if roll == 11 { return "Pacifica native. One of the few who made it out legally."; }
        if roll == 12 { return "Born in the Combat Zone. Doesn't talk about it."; }
        if roll == 13 { return "Third-generation NCPD. Grandfather walked a beat in Little China when it was still safe."; }
        if roll == 14 { return "Transferred from out of state. Previous department dissolved due to corruption charges."; }
        if roll == 15 { return "Former bouncer at Afterlife. Saw enough corpses to want a badge instead."; }
        if roll == 16 { return "Grew up in Westbrook. Watched the neighborhood gentrify while the crime went underground."; }
        if roll == 17 { return "Academy scholarship kid. First in the family to finish any kind of schooling."; }
        if roll == 18 { return "Came up through the NCPD cadet program. Been on the force since age 19."; }
        if roll == 19 { return "Former Arasaka security. Left after the Tower bombing. Wanted something that felt real."; }
        if roll == 20 { return "Japantown native. Speaks fluent Japanese. Recruited specifically for Tyger Claws intelligence."; }
        if roll == 21 { return "Single mother. Two kids. Took the badge because it was the only job with insurance."; }
        if roll == 22 { return "Ex-Trauma Team medic. Couldn't handle watching patients die because their coverage lapsed."; }
        if roll == 23 { return "Heywood born and raised. Uncle was Valentinos. Holidays are complicated."; }
        if roll == 24 { return "Former corporate accountant. Found irregularities. Reported them. Lost the job. Found a new one."; }
        if roll == 25 { return "Badlands kid. Walked into Night City at 17 with nothing. Badge gave structure."; }
        if roll == 26 { return "Rancho Coronado. Father was a factory foreman until automation took the plant."; }
        if roll == 27 { return "Night City born. Never left city limits. Doesn't know anything else."; }
        if roll == 28 { return "Former private investigator. Solo work paid worse and the hours were the same."; }
        if roll == 29 { return "The Glen native. Grew up hearing gunfire so often it stopped waking the family."; }
        if roll == 30 { return "Immigrant family. Parents worked three jobs each. Badge was the path to stability."; }
        if roll == 31 { return "Charter Hill upbringing. Comfortable, not wealthy. Wanted to do something that mattered."; }
        if roll == 32 { return "Kabuki market kid. Used to run messages for the Tyger Claws before a mentor pulled them out."; }
        if roll == 33 { return "Vista del Rey. Quiet neighborhood. Quiet childhood. Then the neighbor turned out to be a Scav."; }
        if roll == 34 { return "Former paramedic. Burned out after a mass-casualty Cyberpsycho incident in Watson."; }
        if roll == 35 { return "Coastal town, south of Night City. Moved in for a relationship. Relationship didn't last. Job did."; }
        if roll == 36 { return "Corpo kid turned street kid turned cop. The full Night City progression."; }
        if roll == 37 { return "Mother was NCPD dispatch. Grew up listening to calls on a scanner. Knew every code by age 12."; }
        if roll == 38 { return "Grew up near Reconciliation Park. Remembers when they built the memorial. Took the oath that year."; }
        return "Night City native. Details of early life not on file.";
    }

    private static func GetPathToNCPD(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 24);
        if roll == 0 { return "Academy graduate. Middling scores. Assigned to patrol."; }
        if roll == 1 { return "Top of the academy class. Had options. Chose patrol anyway."; }
        if roll == 2 { return "Academy washout first try. Reapplied. Made it the second time."; }
        if roll == 3 { return "Fast-tracked through academy after Militech recommendation."; }
        if roll == 4 { return "Hired directly from private security. Skipped half the academy."; }
        if roll == 5 { return "Completed academy during a recruitment surge. Standards were lower that year."; }
        if roll == 6 { return "Military-to-NCPD pipeline. Combat experience counted for academy credits."; }
        if roll == 7 { return "Academy graduate. Wanted detective. Got patrol. Hasn't let go of that."; }
        if roll == 8 { return "Recruited after civilian involvement in stopping a robbery. NCPD saw potential."; }
        if roll == 9 { return "Family connections got them into the academy. Performance since has been their own."; }
        if roll == 10 { return "Academy graduate. Only person in the class who actually wanted to be a cop."; }
        if roll == 11 { return "Former NCPD civilian employee. Decided to go active after seeing what dispatch deals with."; }
        if roll == 12 { return "Lateral transfer from another city's department. Night City was supposed to be temporary."; }
        if roll == 13 { return "Academy dropout originally. Came back after the DataKrash when they needed everyone."; }
        if roll == 14 { return "Completed academy with a broken wrist. Refused to delay graduation."; }
        if roll == 15 { return "Joined during the recruitment crisis. They were taking anyone with a pulse and a clean record."; }
        if roll == 16 { return "Academy honors. Top marksman. Bottom interpersonal skills."; }
        if roll == 17 { return "Got in on a diversity initiative. Has spent every day since proving it wasn't a handout."; }
        if roll == 18 { return "Former CI. Became an informant, then decided the other side of the badge paid better."; }
        if roll == 19 { return "Academy graduate. Nothing special. Nothing terrible. Just a cop."; }
        if roll == 20 { return "Recruited by an NCPD officer who saw them break up a fight bare-handed in Kabuki."; }
        if roll == 21 { return "Completed a compressed 12-week wartime academy program. Knows the gaps in the training."; }
        if roll == 22 { return "Transferred from corporate judicial enforcement. Prefers street work."; }
        if roll == 23 { return "Academy class had a 40% attrition rate. This one stuck."; }
        return "Standard academy pipeline. Unremarkable entry.";
    }

    public static func GenerateNCPDEarlyLife(seed: Int32, lifePath: ref<KdspLifePath>) -> String {
        let event = KdspNCPDProfileGenerator.GetEarlyCareerEvent(seed + 200);
        let detail = KdspNCPDProfileGenerator.GetCareerDetail(seed + 250);
        return event + " " + detail;
    }

    private static func GetEarlyCareerEvent(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 39);
        if roll == 0 { return "First partner was killed during a Maelstrom raid in Northside. Still carries the badge."; }
        if roll == 1 { return "Involved in a high-profile shootout in Watson during first year. Three suspects dead. Internal review cleared."; }
        if roll == 2 { return "Discovered a corruption ring in own precinct. Reported it. Got transferred to Pacifica as thanks."; }
        if roll == 3 { return "First month on patrol: responded to a Cyberpsycho incident alone. Survived. Earned a commendation and a prescription for sleep aids."; }
        if roll == 4 { return "Shot during a routine domestic call in Heywood. Vest caught it. Off the street for three months."; }
        if roll == 5 { return "Found a Scavenger den in a basement during a noise complaint. 14 victims recovered, 3 alive."; }
        if roll == 6 { return "Former partner went dirty — took bribes from Tyger Claws. Internal Affairs pulled them both in. Cleared after 6 months."; }
        if roll == 7 { return "First arrest was a corpo executive for vehicular manslaughter. Case got buried. Learned how Night City works."; }
        if roll == 8 { return "Witnessed a MaxTac takedown firsthand during a Cyberpsycho call in Japantown. Nightmares for months."; }
        if roll == 9 { return "Saved a child during a gang crossfire in The Glen. Only good thing that happened that year."; }
        if roll == 10 { return "Walked in on a braindance snuff operation in Kabuki. Can't watch BDs anymore."; }
        if roll == 11 { return "Early career marked by excessive force complaints. Three investigations. All inconclusive."; }
        if roll == 12 { return "Responded to a bombing at a food processing plant. First mass casualty scene. Still smells the smoke sometimes."; }
        if roll == 13 { return "Partner retired early due to PTSD after a hostage situation went wrong in Santo Domingo."; }
        if roll == 14 { return "Worked undercover in the Valentinos for 8 months. Cover wasn't blown. But some loyalties got complicated."; }
        if roll == 15 { return "Caught falsifying a report to protect a CI. Disciplinary action. Career nearly ended. Didn't."; }
        if roll == 16 { return "Refused to take a bribe from 6th Street during a traffic stop. Got a brick through the apartment window that night."; }
        if roll == 17 { return "First-year ride-along went sideways when the patrol car was ambushed by Scavengers near the dam."; }
        if roll == 18 { return "Broke up an illegal implant surgery in progress. Patient died on the table. Surgeon escaped."; }
        if roll == 19 { return "Transferred precincts three times in two years. Not by choice."; }
        if roll == 20 { return "Early commendation for talking down a suicidal jumper on the Corpo Plaza overpass."; }
        if roll == 21 { return "Arrested a city councilman's son for assault. Charges dropped within hours. Learned the lesson."; }
        if roll == 22 { return "Chased a Wraith convoy into Badlands jurisdiction. Got reprimanded. Caught the driver anyway."; }
        if roll == 23 { return "Worked the Jig-Jig Street beat for 14 months. Requested transfer. Denied. Requested again. Granted."; }
        if roll == 24 { return "Partnered with a 20-year veteran who taught everything the academy didn't. Retired last year."; }
        if roll == 25 { return "Accidentally discharged weapon in a parking garage. No injuries. The paperwork lasted longer than the investigation."; }
        if roll == 26 { return "Pulled over an unmarked Arasaka vehicle. Got a phone call from the precinct captain within 4 minutes."; }
        if roll == 27 { return "Investigated a series of missing persons in Wellsprings. Trail went cold. Cases still open."; }
        if roll == 28 { return "Was first on scene to a Cyberpsycho attack at a ramen shop in Little China. Civilians dead before backup arrived."; }
        if roll == 29 { return "Rotated through the evidence locker for 6 months after a knee injury. Noticed items going missing. Didn't report it."; }
        if roll == 30 { return "Worked crowd control during the anti-corpo riots. Got hit with a bottle. Still has the scar."; }
        if roll == 31 { return "Investigated own neighbor for domestic abuse. Case went to trial. Moved apartments the same week."; }
        if roll == 32 { return "Spent two years in the cybercrimes unit. The braindance cases are the ones that stick."; }
        if roll == 33 { return "Pulled a driver from a burning car after a chase. Received a commendation. Never mentioned it."; }
        if roll == 34 { return "Early career was clean. Too clean. Colleagues suspected a plant. IA confirmed they weren't. Trust was never fully rebuilt."; }
        if roll == 35 { return "Took a bullet in a Scavenger warehouse raid. Spent 8 weeks recovering. Came back harder."; }
        if roll == 36 { return "Was assigned to escort a corpo witness. Witness was killed in transit. Investigation found no fault. Doesn't help."; }
        if roll == 37 { return "First year ended with a formal complaint from a Militech attorney. File sealed."; }
        if roll == 38 { return "Found a dead officer in a patrol car during a night shift. Carbon monoxide. The department called it an accident."; }
        return "Early career was unremarkable. Which in Night City counts as lucky.";
    }

    private static func GetCareerDetail(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 24);
        if roll == 0 { return "Marksmanship scores consistently above average."; }
        if roll == 1 { return "Has requested transfer to Homicide four times. Denied each time."; }
        if roll == 2 { return "Known to work doubles without logging overtime."; }
        if roll == 3 { return "Psych evaluation flagged elevated stress markers. Cleared for duty anyway."; }
        if roll == 4 { return "Maintains a personal case file at home. Against regulation."; }
        if roll == 5 { return "Popular with patrol. Unpopular with administration."; }
        if roll == 6 { return "Three IA investigations. Zero findings. Either clean or careful."; }
        if roll == 7 { return "Known to look the other way on minor drug offenses. Prioritizes violent crime."; }
        if roll == 8 { return "Volunteers for Pacifica shifts that nobody else wants."; }
        if roll == 9 { return "Carries a backup piece. Department doesn't know about it."; }
        if roll == 10 { return "Quietly pays a CI out of pocket when the department budget runs dry."; }
        if roll == 11 { return "Has turned down promotions twice. Prefers the street."; }
        if roll == 12 { return "Drinks after shift. Every shift. Functional."; }
        if roll == 13 { return "Keeps a flask in the patrol car. Everyone knows. Nobody says anything."; }
        if roll == 14 { return "Mentors new academy graduates. Doesn't sugarcoat what they're walking into."; }
        if roll == 15 { return "Badge number has been flagged by the Valentinos. Drives a different route home every night."; }
        if roll == 16 { return "Sleeps in the precinct locker room more often than at home."; }
        if roll == 17 { return "Reputation for paperwork accuracy. Files every report on time. Colleagues find it suspicious."; }
        if roll == 18 { return "Maintains contacts in three gangs. NCPD Intelligence knows about two of them."; }
        if roll == 19 { return "Weapon has been discharged in the line of duty 4 times. Each one documented and justified."; }
        if roll == 20 { return "Avoids corpo-adjacent cases. Doesn't say why."; }
        if roll == 21 { return "Known for being the last one to leave the precinct. First one in."; }
        if roll == 22 { return "Carries a photo of someone in the vest pocket. Never talks about it."; }
        if roll == 23 { return "Fluent in street slang for three gang territories. Useful during interrogations."; }
        return "Standard performance metrics. No red flags. No commendations.";
    }

    public static func GenerateNCPDRecentActivity(seed: Int32, lifePath: ref<KdspLifePath>) -> String {
        let current = KdspNCPDProfileGenerator.GetCurrentSituation(seed + 300);
        let developing = KdspNCPDProfileGenerator.GetDevelopingElement(seed + 350);
        return current + " " + developing;
    }

    private static func GetCurrentSituation(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 39);
        if roll == 0 { return "Currently assigned to gang task force operations in Watson."; }
        if roll == 1 { return "On standard patrol rotation. Third consecutive month without incident."; }
        if roll == 2 { return "Recently returned from administrative leave following an officer-involved shooting."; }
        if roll == 3 { return "Under Internal Affairs review. Allegations of excessive force during an arrest in Kabuki."; }
        if roll == 4 { return "Currently working overtime due to staffing shortages in the precinct."; }
        if roll == 5 { return "Assigned to a joint NCPD-Militech operation. Details classified."; }
        if roll == 6 { return "On light duty following a knee injury sustained during a foot chase."; }
        if roll == 7 { return "Recently completed mandatory anger management counseling. Back on full duty."; }
        if roll == 8 { return "Temporarily assigned to evidence processing after a complaint from a local politician."; }
        if roll == 9 { return "Working a cold case on personal time. Homicide won't reopen it officially."; }
        if roll == 10 { return "Just returned from two weeks compassionate leave. Partner was killed in the line of duty."; }
        if roll == 11 { return "Assigned to community liaison in Heywood. Considered a demotion by everyone including the officer."; }
        if roll == 12 { return "Recently passed the detective examination. Waiting list is 18 months."; }
        if roll == 13 { return "Pulled from undercover assignment after cover was compromised. Currently on desk duty."; }
        if roll == 14 { return "On rotation in the Badlands checkpoint. Two more weeks until city reassignment."; }
        if roll == 15 { return "Currently mentoring a rookie. Third one this year. The other two quit."; }
        if roll == 16 { return "Operating in Pacifica with reduced backup. Standard for the district."; }
        if roll == 17 { return "Involved in a vehicle pursuit last week that ended in a civilian injury. Review pending."; }
        if roll == 18 { return "Recently transferred from Japantown precinct after receiving threats from Tyger Claws."; }
        if roll == 19 { return "Assigned to the Cyberpsycho response hotline. Mostly coordinates with MaxTac."; }
        if roll == 20 { return "Working double shifts to cover for a colleague on medical leave."; }
        if roll == 21 { return "On traffic duty following a suspension. Three more weeks."; }
        if roll == 22 { return "Just completed a raid on a Scavenger operation. Sixteen arrests. Paperwork ongoing."; }
        if roll == 23 { return "Suspended with pay pending investigation into missing evidence from a drug bust."; }
        if roll == 24 { return "Currently operating a DUI checkpoint in City Center. Low-risk assignment."; }
        if roll == 25 { return "Reassigned from Gang Intelligence to Patrol after budget cuts eliminated the unit."; }
        if roll == 26 { return "On the Maelstrom watch list after a raid in the All Foods plant area."; }
        if roll == 27 { return "Working plainclothes in Jig-Jig Street. Vice operation targeting illegal braindance vendors."; }
        if roll == 28 { return "Spent last month providing security for a city council hearing. Uneventful."; }
        if roll == 29 { return "Currently part of the precinct's crisis negotiation team. Two callouts this month."; }
        if roll == 30 { return "Back on patrol after six months desk duty due to a back injury from a car accident."; }
        if roll == 31 { return "Assigned to a stakeout in Santo Domingo. Target hasn't shown in three weeks."; }
        if roll == 32 { return "Volunteered for the Night City Marathon security detail. Straightforward assignment."; }
        if roll == 33 { return "Currently assigned to courthouse security. Temporary. Boring. Preferred."; }
        if roll == 34 { return "Working the night shift in Northside. Nobody volunteers for the night shift in Northside."; }
        if roll == 35 { return "Conducting welfare checks in a Megabuilding after three overdose deaths in one week."; }
        if roll == 36 { return "Investigating a string of car thefts near Corpo Plaza. Low priority but steady work."; }
        if roll == 37 { return "Recently attended a fellow officer's funeral. Third one this year."; }
        if roll == 38 { return "Temporarily embedded with a Trauma Team unit for a cross-training program."; }
        return "Standard patrol duties. No notable assignments.";
    }

    private static func GetDevelopingElement(seed: Int32) -> String {
        let roll = RandRange(seed, 0, 29);
        if roll == 0 { return "Promotion board next quarter. Chances are decent."; }
        if roll == 1 { return "Has been asking about early retirement options."; }
        if roll == 2 { return "Considering a transfer to a quieter district. If one exists."; }
        if roll == 3 { return "Marriage is falling apart. Comes to work to avoid going home."; }
        if roll == 4 { return "Recently started seeing a department therapist. Off the record."; }
        if roll == 5 { return "An old informant resurfaced with intel on a major case. Deciding whether to pursue it."; }
        if roll == 6 { return "Received a threat at home address. Source unknown. Request for protection detail denied."; }
        if roll == 7 { return "Studying for the sergeant exam. Third attempt."; }
        if roll == 8 { return "Being recruited by corporate security. The pay is triple. Hasn't decided yet."; }
        if roll == 9 { return "A fixer has been making offers. No response yet. The department doesn't know."; }
        if roll == 10 { return "Morale is low. Colleagues are leaving for private sector. The ones left are stretched thin."; }
        if roll == 11 { return "Has a disciplinary hearing next month over a use-of-force report."; }
        if roll == 12 { return "Recently broke off a relationship. Throwing more hours into the job."; }
        if roll == 13 { return "Saving money for a transfer to a different city. If any are hiring."; }
        if roll == 14 { return "Union rep approached about filing a grievance against the precinct commander."; }
        if roll == 15 { return "Quietly documenting irregularities in the evidence chain. Not sure what to do with it."; }
        if roll == 16 { return "A journalist has been asking questions about an old case. Avoiding the calls."; }
        if roll == 17 { return "Looking into private investigation licensing. Just in case."; }
        if roll == 18 { return "New partner is untested. Trust hasn't been established yet."; }
        if roll == 19 { return "Department-mandated fitness test next week. Not worried. Should be."; }
        if roll == 20 { return "A cold case match came back from the lab. Might change everything. Might be nothing."; }
        if roll == 21 { return "Has been volunteering at a youth center in Heywood on days off. Doesn't put it on the resume."; }
        if roll == 22 { return "Internal Affairs called. Wouldn't say what about. That was three days ago."; }
        if roll == 23 { return "Considering applying for MaxTac. The psychological screening is the obstacle."; }
        if roll == 24 { return "Something happened on a recent call. Won't talk about it. Colleagues have noticed the change."; }
        if roll == 25 { return "The precinct is being restructured. Everyone's position is under review."; }
        if roll == 26 { return "Recently recognized by a gang member in a grocery store. Changed routines immediately."; }
        if roll == 27 { return "Pension vests in 18 months. Counting the days."; }
        if roll == 28 { return "Just found out the department is cutting the mental health benefit. Planning to speak up at the union meeting."; }
        return "No pending developments.";
    }

    // ══════════════════════════════════════════════════════════════
    // TRAUMA TEAM GENERATORS
    // Professional military-medical operatives. Corporate soldiers.

}
