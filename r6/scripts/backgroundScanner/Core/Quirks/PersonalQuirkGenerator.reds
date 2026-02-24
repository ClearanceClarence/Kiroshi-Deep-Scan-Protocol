// Kiroshi Deep Scan - Personal Quirk Generator
// 200 surveillance-state data entries across 7 categories

public abstract class KdspPersonalQuirkGenerator {

    public static func GeneratePersonalQuirk(seed: Int32, archetype: String) -> String {
        // 7 categories, pick one then pick within it
        let cat = RandRange(seed, 0, 6);

        // ── ILLICIT AFFAIRS / RELATIONSHIPS ──
        if cat == 0 {
            let i = RandRange(seed + 10, 0, 34);
            if i == 0 { return "FLAG: Intimate relationship with direct supervisor"; }
            if i == 1 { return "FLAG: Sleeping with ripperdoc (conflict of interest noted)"; }
            if i == 2 { return "FLAG: Affair with neighbor's spouse - ongoing"; }
            if i == 3 { return "FLAG: Romantic involvement with BD dealer"; }
            if i == 4 { return "FLAG: Matched with ex-spouse on dating service (3 times)"; }
            if i == 5 { return "FLAG: Sending anonymous love letters to coworker"; }
            if i == 6 { return "FLAG: Sleeping with landlord - rent suspiciously low"; }
            if i == 7 { return "FLAG: Two active relationships - neither party aware"; }
            if i == 8 { return "FLAG: Affair with fixer - possible intel compromise"; }
            if i == 9 { return "FLAG: Intimate messages to NCPD officer intercepted"; }
            if i == 10 { return "FLAG: Dating ripperdoc's receptionist to get appointment priority"; }
            if i == 11 { return "FLAG: Sleeping with building super - maintenance requests filled instantly"; }
            if i == 12 { return "FLAG: Three simultaneous dating profiles under different names"; }
            if i == 13 { return "FLAG: Affair with best friend's partner - 8 months ongoing"; }
            if i == 14 { return "FLAG: Romantic entanglement with debt collector - debt frozen"; }
            if i == 15 { return "FLAG: Caught in affair via corpo surveillance cam - blackmail risk"; }
            if i == 16 { return "FLAG: Seducing Trauma Team dispatcher for faster response times"; }
            if i == 17 { return "FLAG: Sleeping with food vendor - receives free burritos daily"; }
            if i == 18 { return "FLAG: Ex filed restraining order - now dating ex's sibling"; }
            if i == 19 { return "FLAG: Intimate relationship with therapist (ethics violation)"; }
            if i == 20 { return "FLAG: Sleeping with gym trainer - membership expired 6 months ago"; }
            if i == 21 { return "FLAG: Secret relationship with coworker's ex - office tension noted"; }
            if i == 22 { return "FLAG: Affair exposed when partner found second comm device"; }
            if i == 23 { return "FLAG: Dating two people in same megabuilding - different floors"; }
            if i == 24 { return "FLAG: Romantic messages to AI chatbot flagged as parasocial"; }
            if i == 25 { return "FLAG: Sleeping with corporate auditor - tax irregularities vanished"; }
            if i == 26 { return "FLAG: Three breakups in one month - all via text"; }
            if i == 27 { return "FLAG: Flirting with Delamain cab AI - repeatedly"; }
            if i == 28 { return "FLAG: Affair with rival company employee - industrial espionage risk"; }
            if i == 29 { return "FLAG: Secret relationship with gang member - family unaware"; }
            if i == 30 { return "FLAG: Sleeping with bouncer to skip club queues"; }
            if i == 31 { return "FLAG: Intimate comms intercepted to 4 different recipients same evening"; }
            if i == 32 { return "FLAG: Dating coach hired - fired after coach started dating subject's ex"; }
            if i == 33 { return "FLAG: Spotted leaving ripperdoc clinic with ripperdoc at 3 AM - no procedure scheduled"; }
            return "FLAG: Active on 6 dating platforms simultaneously - different persona on each";
        }

        // ── PHOBIAS / PSYCHOLOGICAL QUIRKS ──
        if cat == 1 {
            let i = RandRange(seed + 10, 0, 29);
            if i == 0 { return "PSYCH NOTE: Documented fear of clowns (incident at carnival, 2074)"; }
            if i == 1 { return "PSYCH NOTE: Fear of fear itself - recursive anxiety loop noted by therapist"; }
            if i == 2 { return "PSYCH NOTE: Pathological fear of elevators - walks 40 floors daily"; }
            if i == 3 { return "PSYCH NOTE: Convinced apartment is haunted - filed 12 NCPD reports"; }
            if i == 4 { return "PSYCH NOTE: Refuses to use fast travel terminals - 'they scramble your atoms'"; }
            if i == 5 { return "PSYCH NOTE: Clinically diagnosed fear of pigeons"; }
            if i == 6 { return "PSYCH NOTE: Believes they were a corpo exec in a past life"; }
            if i == 7 { return "PSYCH NOTE: Sleepwalks - found on rooftop 3 times"; }
            if i == 8 { return "PSYCH NOTE: Cannot sleep without white noise at exactly 72 decibels"; }
            if i == 9 { return "PSYCH NOTE: Panic attacks triggered by vending machine jingles"; }
            if i == 10 { return "PSYCH NOTE: Refuses medical cyberware - 'my body is a temple'"; }
            if i == 11 { return "PSYCH NOTE: Irrational fear of Delamain cabs specifically"; }
            if i == 12 { return "PSYCH NOTE: Compulsive door-checker - tests locks 7 times minimum"; }
            if i == 13 { return "PSYCH NOTE: Terrified of chrome - has panic attacks near heavily augmented people"; }
            if i == 14 { return "PSYCH NOTE: Night terrors - neighbors filed 23 noise complaints"; }
            if i == 15 { return "PSYCH NOTE: Phobia of open sky - only goes outside under covered walkways"; }
            if i == 16 { return "PSYCH NOTE: Believes they can hear their implants 'whispering'"; }
            if i == 17 { return "PSYCH NOTE: Obsessive hand-washer - uses 3x normal water ration"; }
            if i == 18 { return "PSYCH NOTE: Fear of AV's - will not travel above ground level"; }
            if i == 19 { return "PSYCH NOTE: Convinced deceased relative speaks through radio static"; }
            if i == 20 { return "PSYCH NOTE: Cannot enter a room without counting all exits first"; }
            if i == 21 { return "PSYCH NOTE: Therapist notes 'patient argues with own internal monologue'"; }
            if i == 22 { return "PSYCH NOTE: Extreme fear of mannequins - avoids all clothing stores"; }
            if i == 23 { return "PSYCH NOTE: Cries during every braindance - even action ones"; }
            if i == 24 { return "PSYCH NOTE: Pathological need to sit facing the door in every room"; }
            if i == 25 { return "PSYCH NOTE: Believes mirrors show a 2-second delay - checks constantly"; }
            if i == 26 { return "PSYCH NOTE: Fear of being watched through screens - tapes over all cameras"; }
            if i == 27 { return "PSYCH NOTE: Talks to self in three distinct voices - denies doing it"; }
            if i == 28 { return "PSYCH NOTE: Paralyzing fear of the color red - wardrobe entirely blue/grey"; }
            return "PSYCH NOTE: Refuses to walk under bridges - reroutes entire commute daily";
        }

        // ── EMBARRASSING HABITS / PERSONAL SECRETS ──
        if cat == 2 {
            let i = RandRange(seed + 10, 0, 29);
            if i == 0 { return "DATA LEAK: Collects used cyberware from dumpsters"; }
            if i == 1 { return "DATA LEAK: Sings in public restrooms - noise complaints on file"; }
            if i == 2 { return "DATA LEAK: Writes erotic braindance reviews under alias"; }
            if i == 3 { return "DATA LEAK: Competitive eater - banned from 4 noodle shops"; }
            if i == 4 { return "DATA LEAK: Has 200+ unfinished online courses"; }
            if i == 5 { return "DATA LEAK: Hoards vending machine toys - apartment flagged as fire hazard"; }
            if i == 6 { return "DATA LEAK: Still pays subscription for defunct braindance channel"; }
            if i == 7 { return "DATA LEAK: Returns to ripperdoc for 'maintenance' requiring no maintenance"; }
            if i == 8 { return "DATA LEAK: Talks to vending machines - holds full conversations"; }
            if i == 9 { return "DATA LEAK: Sleeps in office - has hidden bedroll under desk"; }
            if i == 10 { return "DATA LEAK: Practices martial arts alone in elevator - caught on camera 47 times"; }
            if i == 11 { return "DATA LEAK: Eats synthetic food with chopsticks regardless of food type"; }
            if i == 12 { return "DATA LEAK: Names every piece of equipment they own"; }
            if i == 13 { return "DATA LEAK: Secret ASMR braindance collection - 4TB and growing"; }
            if i == 14 { return "DATA LEAK: Wears disguise to buy embarrassing groceries"; }
            if i == 15 { return "DATA LEAK: Has memorized every Samurai song - performs in shower nightly"; }
            if i == 16 { return "DATA LEAK: Keeps detailed diary rating every person they've ever met"; }
            if i == 17 { return "DATA LEAK: Pretends to take calls to avoid talking to neighbors"; }
            if i == 18 { return "DATA LEAK: Still uses a paper calendar - coworkers baffled"; }
            if i == 19 { return "DATA LEAK: Takes food from office fridge that isn't theirs - serial offender"; }
            if i == 20 { return "DATA LEAK: Rehearses conversations in mirror before social events"; }
            if i == 21 { return "DATA LEAK: Has a playlist for every mood - 847 playlists and counting"; }
            if i == 22 { return "DATA LEAK: Brings own toilet paper to work - trusts no one"; }
            if i == 23 { return "DATA LEAK: Applauds when AV lands safely - every single time"; }
            if i == 24 { return "DATA LEAK: Smells every piece of food before eating - including drinks"; }
            if i == 25 { return "DATA LEAK: Keeps emergency bag packed at all times - has never left the city"; }
            if i == 26 { return "DATA LEAK: Takes photos of every meal - uploads to nobody"; }
            if i == 27 { return "DATA LEAK: Wears sunglasses indoors - Kiroshi optics have built-in tint"; }
            if i == 28 { return "DATA LEAK: Writes long product reviews for items never purchased"; }
            return "DATA LEAK: Has 14 unread messages from mother - oldest is 3 months";
        }

        // ── CONSPIRACY / DELUSIONAL BELIEFS ──
        if cat == 3 {
            let i = RandRange(seed + 10, 0, 24);
            if i == 0 { return "MONITOR: Believes Arasaka monitors their toaster"; }
            if i == 1 { return "MONITOR: Active poster on 'Night City is a simulation' forums"; }
            if i == 2 { return "MONITOR: Claims to have seen a real animal (unverified)"; }
            if i == 3 { return "MONITOR: Files weekly reports about 'suspicious cloud formations'"; }
            if i == 4 { return "MONITOR: Insists they once met Johnny Silverhand at a food stand"; }
            if i == 5 { return "MONITOR: Believes tap water contains mind-control nanites"; }
            if i == 6 { return "MONITOR: Convinced Biotechnica puts trackers in synthetic food"; }
            if i == 7 { return "MONITOR: Posts daily about 'the real Night City' being underground"; }
            if i == 8 { return "MONITOR: Believes pigeons are Militech surveillance drones"; }
            if i == 9 { return "MONITOR: Claims Delamain cabs record all conversations for NetWatch"; }
            if i == 10 { return "MONITOR: Insists the moon landing was faked - the 2043 one specifically"; }
            if i == 11 { return "MONITOR: Believes braindances can implant false memories - refuses all BD"; }
            if i == 12 { return "MONITOR: Claims to receive coded messages through N54 News broadcasts"; }
            if i == 13 { return "MONITOR: Convinced their ripperdoc installed a tracking chip without consent"; }
            if i == 14 { return "MONITOR: Active member of 'Flat Earth 2.0' - believes Night City is on the edge"; }
            if i == 15 { return "MONITOR: Posts theory that all fixers are the same person in disguise"; }
            if i == 16 { return "MONITOR: Believes MaxTac are actually cyborg clones of one person"; }
            if i == 17 { return "MONITOR: Wears tinfoil under hat - 'blocks Kiroshi satellite pings'"; }
            if i == 18 { return "MONITOR: Claims vending machines change prices based on who's watching"; }
            if i == 19 { return "MONITOR: Insists they've found a 'glitch in reality' near Kabuki market"; }
            if i == 20 { return "MONITOR: Believes Soulkiller is already in the public water supply"; }
            if i == 21 { return "MONITOR: Runs blog claiming all megabuildings are sentient"; }
            if i == 22 { return "MONITOR: Convinced their implants pick up radio frequencies from 2020"; }
            if i == 23 { return "MONITOR: Believes the Afterlife bar is a front for a secret government"; }
            return "MONITOR: Claims to have proof that weather is controlled by Orbital Air";
        }

        // ── WEIRD NCPD / LEGAL FLAGS ──
        if cat == 4 {
            let i = RandRange(seed + 10, 0, 24);
            if i == 0 { return "NCPD NOTE: Restraining order filed by AI vending machine"; }
            if i == 1 { return "NCPD NOTE: Reported missing - was at home the entire time"; }
            if i == 2 { return "NCPD NOTE: Arrested for impersonating Trauma Team member (Halloween)"; }
            if i == 3 { return "NCPD NOTE: 7 noise complaints filed against self"; }
            if i == 4 { return "NCPD NOTE: Reported own vehicle stolen - forgot where parked"; }
            if i == 5 { return "NCPD NOTE: Sued by neighbor over braindance volume levels"; }
            if i == 6 { return "NCPD NOTE: Fined for feeding stray cats in restricted zone"; }
            if i == 7 { return "NCPD NOTE: Called NCPD to report 'suspicious sunset' - twice"; }
            if i == 8 { return "NCPD NOTE: Arrested at protest - was protesting the wrong building"; }
            if i == 9 { return "NCPD NOTE: Filed insurance claim for 'emotional damage from vending machine'"; }
            if i == 10 { return "NCPD NOTE: Reported burglary - missing item found in own pocket"; }
            if i == 11 { return "NCPD NOTE: Fined for public indecency - fell asleep on bench, pants unbuttoned"; }
            if i == 12 { return "NCPD NOTE: Restraining order from former hairdresser"; }
            if i == 13 { return "NCPD NOTE: Reported 'break-in' - was own roommate coming home"; }
            if i == 14 { return "NCPD NOTE: Ticketed for jaywalking 31 times at same intersection"; }
            if i == 15 { return "NCPD NOTE: Called in bomb threat - was own car backfiring"; }
            if i == 16 { return "NCPD NOTE: Accidentally locked self in own apartment - called MaxTac"; }
            if i == 17 { return "NCPD NOTE: Dispute with street vendor over change - 45 minute standoff"; }
            if i == 18 { return "NCPD NOTE: Cited for operating unlicensed lemonade stand (age 34)"; }
            if i == 19 { return "NCPD NOTE: Filed complaint that neighbor's cooking 'smells illegal'"; }
            if i == 20 { return "NCPD NOTE: Attempted to file a missing persons report for themselves"; }
            if i == 21 { return "NCPD NOTE: Trespassing charge - entered wrong apartment, made dinner, left"; }
            if i == 22 { return "NCPD NOTE: Shoplifting charge dismissed - actually forgot item in hand"; }
            if i == 23 { return "NCPD NOTE: Fined for parking violation - vehicle was on fire at the time"; }
            return "NCPD NOTE: 911 call transcript reads 'there's a man outside' - was own reflection in window";
        }

        // ── SECRET DOUBLE LIVES ──
        if cat == 5 {
            let i = RandRange(seed + 10, 0, 24);
            if i == 0 { return "INTEL: Moonlights as underground poetry slam host"; }
            if i == 1 { return "INTEL: Secret braindance addiction - spends 40% of income"; }
            if i == 2 { return "INTEL: Runs anonymous food review blog with 50k followers"; }
            if i == 3 { return "INTEL: Secretly learning guitar - neighbors unaware it's intentional"; }
            if i == 4 { return "INTEL: Maintains second apartment nobody knows about"; }
            if i == 5 { return "INTEL: Volunteers at animal shelter under fake name"; }
            if i == 6 { return "INTEL: Competes in underground dance battles - undefeated"; }
            if i == 7 { return "INTEL: Runs anonymous Net advice column as 'Chrome Mama'"; }
            if i == 8 { return "INTEL: Secret member of a book club that reads pre-war literature"; }
            if i == 9 { return "INTEL: Maintains elaborate garden on rooftop - technically illegal"; }
            if i == 10 { return "INTEL: Underground braindance reviewer - alias 'The Dreamcatcher'"; }
            if i == 11 { return "INTEL: Secretly teaches children to read in abandoned building"; }
            if i == 12 { return "INTEL: Runs pirate radio station from bathroom - 200 listeners"; }
            if i == 13 { return "INTEL: Sells homemade synth-food at black market as 'real cooking'"; }
            if i == 14 { return "INTEL: Performs as street musician on weekends - uses holographic disguise"; }
            if i == 15 { return "INTEL: Secret pen pal with someone in Tokyo - 6 years ongoing"; }
            if i == 16 { return "INTEL: Coaches little league baseball - no league exists, just 4 kids"; }
            if i == 17 { return "INTEL: Writes anonymous confessions on public bathroom walls - tracked by NCPD"; }
            if i == 18 { return "INTEL: Has entire second wardrobe stored at friend's place"; }
            if i == 19 { return "INTEL: Secretly training for marathon - tells everyone they hate running"; }
            if i == 20 { return "INTEL: Runs underground movie screening club in parking garage"; }
            if i == 21 { return "INTEL: Anonymous donor to 12 different charities - lives in studio apartment"; }
            if i == 22 { return "INTEL: Has been writing a novel for 9 years - nobody knows"; }
            if i == 23 { return "INTEL: Maintains aquarium with last known living goldfish - heavily guarded"; }
            return "INTEL: Double life as amateur stand-up comedian - performs under alias at dive bars";
        }

        // ── MUNDANE BUT ABSURD ──
        let i = RandRange(seed + 10, 0, 29);
        if i == 0 { return "NOTE: Has never eaten real food - synthetic only, by choice"; }
        if i == 1 { return "NOTE: Owns 47 identical jackets"; }
        if i == 2 { return "NOTE: Hasn't left Watson in 11 years"; }
        if i == 3 { return "NOTE: Sets 14 alarms every morning - still late daily"; }
        if i == 4 { return "NOTE: Allergic to chrome but has 6 implants"; }
        if i == 5 { return "NOTE: Left-handed but pretends to be right-handed"; }
        if i == 6 { return "NOTE: Keeps detailed spreadsheet rating every food vendor in NC"; }
        if i == 7 { return "NOTE: Has not changed hairstyle since 2058"; }
        if i == 8 { return "NOTE: Refuses to eat any food that isn't the color beige"; }
        if i == 9 { return "NOTE: Walks backwards through doorways - no explanation given"; }
        if i == 10 { return "NOTE: Has memorized every street name in Heywood - cannot name own street"; }
        if i == 11 { return "NOTE: Only communicates via text - even with people in same room"; }
        if i == 12 { return "NOTE: Owns 12 pairs of shoes - wears the same pair daily"; }
        if i == 13 { return "NOTE: Alphabetizes everything in refrigerator"; }
        if i == 14 { return "NOTE: Has called in sick on same date for 6 years running"; }
        if i == 15 { return "NOTE: Refers to self in third person in all written communications"; }
        if i == 16 { return "NOTE: Carries an umbrella every day - Night City hasn't rained in months"; }
        if i == 17 { return "NOTE: Has been 'temporarily' staying at friend's couch for 3 years"; }
        if i == 18 { return "NOTE: Only watches braindances with subtitles on - even when in original language"; }
        if i == 19 { return "NOTE: Takes the stairs everywhere - lives on 47th floor"; }
        if i == 20 { return "NOTE: Has a lucky shirt - wears it to every job interview, never washed"; }
        if i == 21 { return "NOTE: Refuses to make left turns while driving - commute is 3x longer"; }
        if i == 22 { return "NOTE: Celebrates own birthday twice a year - nobody questions it"; }
        if i == 23 { return "NOTE: Orders the same meal at every restaurant - plain rice"; }
        if i == 24 { return "NOTE: Convinced their apartment number is unlucky - has moved 4 times"; }
        if i == 25 { return "NOTE: Keeps fish tank with no fish - 'they know what they did'"; }
        if i == 26 { return "NOTE: Only sleeps in 90-minute intervals - has alarm for each cycle"; }
        if i == 27 { return "NOTE: Waves at security cameras - every single one"; }
        if i == 28 { return "NOTE: Has backup plan for 14 different apocalypse scenarios documented"; }
        return "NOTE: Maintains a revenge list - all entries are minor inconveniences";
    }

    // Extract last name from NPC's display name for family relationship consistency

}
