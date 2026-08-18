// Kiroshi Deep Scan Protocol - BOLO / Alert Notice System
// NCPD lookout notices on scanned civilians, independent of warrant status.
// A BOLO doesn't mean charges — it means someone is looking for this person.

public abstract class KdspBoloGenerator {

    public static func Generate(seed: Int32, archetype: String) -> String {
        if !KdspSettings.BoloNoticesEnabled() {
            return "";
        };

        let chance: Int32 = KdspSettings.GetBoloNoticeChance();
        if chance < 1 { chance = 1; };
        if RandRange(seed, 0, chance) != 0 {
            return "";
        };

        let roll = RandRange(seed + 7, 0, 72);

        // ── Person of interest ────────────────────────────────────────
        if roll == 0  { return "BOLO: Person of interest — Watson homicide investigation"; };
        if roll == 1  { return "BOLO: Person of interest — organized retail theft ring"; };
        if roll == 2  { return "BOLO: Person of interest — arson, Northside warehouse fire"; };
        if roll == 3  { return "BOLO: Wanted for questioning — braindance trafficking case"; };
        if roll == 4  { return "BOLO: Wanted for questioning — cyberware chop shop investigation"; };
        if roll == 5  { return "BOLO: Person of interest — smuggling ring, Del Coronado Bay"; };
        if roll == 6  { return "BOLO: Wanted for questioning — counterfeit pharma distribution"; };
        if roll == 7  { return "BOLO: Person of interest — string of megabuilding burglaries"; };

        // ── Witness-related ───────────────────────────────────────────
        if roll == 8  { return "BOLO: Material witness — gang shooting, has not responded to summons"; };
        if roll == 9  { return "BOLO: Witness relocation candidate — contact NCPD before approach"; };
        if roll == 10 { return "BOLO: Subject may have recorded footage of an ongoing case"; };
        if roll == 11 { return "BOLO: Last confirmed sighting of a homicide victim — interview pending"; };
        if roll == 12 { return "BOLO: Named in an affidavit — statement never collected"; };
        if roll == 13 { return "NOTICE: Protected witness [DETAILS SEALED — DO NOT APPROACH]"; };

        // ── Missing persons ───────────────────────────────────────────
        if roll == 14 { return "ALERT: 87% facial match — missing person report #NC-" + IntToString(RandRange(seed + 13, 40000, 99999)); };
        if roll == 15 { return "ALERT: Subject matches description — family-filed missing person case"; };
        if roll == 16 { return "ALERT: Reported missing by employer in " + IntToString(RandRange(seed + 17, 2073, 2077)) + " — case never closed"; };
        if roll == 17 { return "ALERT: Declared legally dead in " + IntToString(RandRange(seed + 19, 2070, 2075)) + " — biometrics say otherwise"; };
        if roll == 18 { return "ALERT: Partial match — John/Jane Doe recovered from Del Coronado Bay [SURVIVOR]"; };
        if roll == 19 { return "ALERT: Subject matches age-progressed image — child missing since " + IntToString(RandRange(seed + 23, 2058, 2066)); };

        // ── Corp-related ──────────────────────────────────────────────
        if roll == 20 { return "NOTICE: Corporate asset recovery flag — unreturned company property"; };
        if roll == 21 { return "NOTICE: Former employer requests location data [CONTRACT DISPUTE]"; };
        if roll == 22 { return "NOTICE: NDA enforcement watch — corp legal monitoring active"; };
        if roll == 23 { return "NOTICE: Debt recovery agency location request on file"; };
        if roll == 24 { return "NOTICE: Non-compete violation claim — corp counsel tracking"; };
        if roll == 25 { return "NOTICE: Severance clawback proceedings — location requested by Arasaka legal"; };
        if roll == 26 { return "NOTICE: Militech exit-interview no-show — clearance revocation incomplete"; };
        if roll == 27 { return "NOTICE: Corporate housing eviction enforcement — unit never vacated"; };
        if roll == 28 { return "ALERT: Subject retains active biometric access to a shuttered facility"; };

        // ── Civil / administrative ────────────────────────────────────
        if roll == 29 { return "BOLO: Welfare check requested by family member — unable to locate"; };
        if roll == 30 { return "NOTICE: Jury summons — three failed delivery attempts"; };
        if roll == 31 { return "NOTICE: Subpoena pending service — civil case"; };
        if roll == 32 { return "NOTICE: Immigration status review flag — hearing date passed"; };
        if roll == 33 { return "NOTICE: Unclaimed inheritance — probate court seeking heir"; };
        if roll == 34 { return "NOTICE: Census non-response flag — enumerator visits refused"; };
        if roll == 35 { return "NOTICE: Child support enforcement locate request"; };
        if roll == 36 { return "NOTICE: Landlord-tenant judgment — payment address unknown"; };
        if roll == 37 { return "NOTICE: Vehicle impound release pending — owner unreachable"; };

        // ── Medical / safety ──────────────────────────────────────────
        if roll == 38 { return "ALERT: Cyberware recall notice — implant batch flagged for defects"; };
        if roll == 39 { return "ALERT: Clinical trial follow-up overdue — Biotechnica monitoring request"; };
        if roll == 40 { return "ALERT: Listed as emergency contact in an open death investigation"; };
        if roll == 41 { return "ALERT: Blood donor recall — rare type needed, contact info stale"; };
        if roll == 42 { return "ALERT: Exposure notification — industrial incident, " + IntToString(RandRange(seed + 29, 2074, 2077)); };
        if roll == 43 { return "ALERT: Organ transplant waitlist match — Trauma Team unable to reach"; };
        if roll == 44 { return "ALERT: Psychiatric hold release follow-up — two missed evaluations"; };
        if roll == 45 { return "NOTICE: Ripperdoc malpractice settlement — claimant location needed"; };

        // ── NetWatch / cyber ──────────────────────────────────────────
        if roll == 46 { return "NOTICE: NetWatch interest flag — subject's alias appears in seized server logs"; };
        if roll == 47 { return "NOTICE: Datastream anomaly traced to subject's registered deck"; };
        if roll == 48 { return "ALERT: Subject's SIN cloned — twelve concurrent users detected"; };
        if roll == 49 { return "NOTICE: Flagged purchaser of restricted ICE-breaking software"; };
        if roll == 50 { return "ALERT: Identity theft victim — case #NC-" + IntToString(RandRange(seed + 31, 10000, 39999)) + " — verification interview pending"; };

        // ── Gang / street ─────────────────────────────────────────────
        if roll == 51 { return "BOLO: Reported target of an active gang retaliation threat"; };
        if roll == 52 { return "NOTICE: Subject on a seized fixer client list — significance unknown"; };
        if roll == 53 { return "NOTICE: Name appears in a scavenger crew's recovered target ledger"; };
        if roll == 54 { return "BOLO: Possible extortion victim — pattern matches protection racket case"; };
        if roll == 55 { return "NOTICE: Frequents an establishment under active NCPD surveillance"; };

        // ── Financial ─────────────────────────────────────────────────
        if roll == 56 { return "NOTICE: Account frozen pending fraud review — holder unreachable"; };
        if roll == 57 { return "NOTICE: Named beneficiary of an unclaimed insurance payout"; };
        if roll == 58 { return "NOTICE: Safety deposit box in arrears — contents scheduled for auction"; };
        if roll == 59 { return "ALERT: Flagged structuring pattern — transactions just under reporting threshold"; };
        if roll == 60 { return "NOTICE: Co-signer default — lender pursuing secondary obligor"; };

        // ── Bounty / private ──────────────────────────────────────────
        if roll == 61 { return "ALERT: Private locate contract on file — client identity shielded"; };
        if roll == 62 { return "NOTICE: Bail bond forfeiture — recovery agent authorized"; };
        if roll == 63 { return "NOTICE: Skip trace active — three agencies holding the same contract"; };
        if roll == 64 { return "ALERT: Subject listed in a leaked mercenary target database [UNVERIFIED]"; };

        // ── Historical / cold case ────────────────────────────────────
        if roll == 65 { return "NOTICE: Cold case DNA review — subject's profile requested for elimination"; };
        if roll == 66 { return "NOTICE: Named in a " + IntToString(RandRange(seed + 37, 2060, 2070)) + " incident report — case reopened"; };
        if roll == 67 { return "NOTICE: Pre-unification records mismatch — identity verification requested"; };

        // ── Odd ones ──────────────────────────────────────────────────
        if roll == 68 { return "NOTICE: Subject of three separate anonymous tips — all unverified"; };
        if roll == 69 { return "BOLO: Vehicle registered to subject seen leaving crime scene [UNCONFIRMED]"; };
        if roll == 70 { return "NOTICE: Repeated appearances in unrelated case files — statistical anomaly flagged"; };
        if roll == 71 { return "ALERT: Duplicate biometric signature registered in another district [IMPOSSIBLE]"; };

        return "";
    }
}
