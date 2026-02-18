// Financial Profile Generation System
public class KdspFinancialProfileManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String) -> ref<KdspFinancialProfileData> {
        return KdspFinancialProfileManager.GenerateCoherent(seed, archetype, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> ref<KdspFinancialProfileData> {
        let profile: ref<KdspFinancialProfileData> = new KdspFinancialProfileData();
        let density = KdspSettings.GetDataDensity();

        // Generate credit score - always shown
        profile.creditScore = KdspFinancialProfileManager.GenerateCreditScoreCoherent(seed, archetype, coherence);
        profile.creditTier = KdspFinancialProfileManager.GetCreditTier(profile.creditScore);

        // Generate wealth indicator - always shown
        profile.estimatedWealth = KdspFinancialProfileManager.GenerateWealthCoherent(seed + 100, archetype, coherence);
        profile.wealthTier = KdspFinancialProfileManager.GetWealthTier(profile.estimatedWealth);

        // Debt information - always shown
        if IsDefined(coherence) {
            profile.hasDebt = coherence.isInDebt;
        } else {
            profile.hasDebt = KdspFinancialProfileManager.HasDebt(seed + 200, archetype, profile.creditScore);
        }
        
        if profile.hasDebt {
            profile.debtAmount = KdspFinancialProfileManager.GenerateDebtAmountCoherent(seed + 210, archetype, coherence);
            profile.debtHolder = KdspFinancialProfileManager.GenerateDebtHolderCoherent(seed + 220, archetype, coherence);
            profile.debtStatus = KdspFinancialProfileManager.GenerateDebtStatus(seed + 230, profile.creditScore);
        }

        // Property status - only on medium/high
        if density >= 2 {
            profile.propertyStatus = KdspFinancialProfileManager.GeneratePropertyStatus(seed + 300, archetype, profile.estimatedWealth);
            profile.residenceType = KdspFinancialProfileManager.GenerateResidenceType(seed + 310, archetype);
            profile.residenceDistrict = KdspFinancialProfileManager.GenerateResidenceDistrict(seed + 320, archetype);
        }

        // Employment status - always shown
        profile.employmentStatus = KdspFinancialProfileManager.GenerateEmploymentStatusCoherent(seed + 400, archetype, coherence);
        profile.employer = KdspFinancialProfileManager.GenerateEmployer(seed + 410, archetype);
        profile.incomeLevel = KdspFinancialProfileManager.GenerateIncomeLevelCoherent(seed + 420, archetype, coherence);

        // Recent purchases - only on high density
        if density >= 3 {
            let purchaseCount = RandRange(seed + 500, 0, 4);
            purchaseCount = KdspSettings.GetMaxListItems(purchaseCount);
            let i = 0;
            while i < purchaseCount {
                ArrayPush(profile.recentPurchases, KdspFinancialProfileManager.GeneratePurchase(seed + 510 + (i * 33), archetype, profile.estimatedWealth));
                i += 1;
            }
        }

        // Financial flags - only on medium/high
        if density >= 2 {
            profile.taxStatus = KdspFinancialProfileManager.GenerateTaxStatus(seed + 600, archetype);
            profile.bankruptcyHistory = KdspFinancialProfileManager.HasBankruptcyCoherent(seed + 610, archetype, coherence);
            profile.corporateAsset = KdspFinancialProfileManager.IsCorporateAsset(seed + 620, archetype, profile.debtStatus);
        }

        // Insurance - only on medium/high
        if density >= 2 {
            profile.traumaTeamCoverage = KdspFinancialProfileManager.GenerateTraumaTeamCoverage(seed + 700, archetype, profile.estimatedWealth);
            profile.healthInsurance = KdspFinancialProfileManager.GenerateHealthInsurance(seed + 710, archetype);
        }

        // Bank accounts - only on high density
        if density >= 3 {
            profile.bankAffiliation = KdspFinancialProfileManager.GenerateBankAffiliation(seed + 800, archetype);
            profile.accountStatus = KdspFinancialProfileManager.GenerateAccountStatus(seed + 810, profile.creditScore);
        }

        // Night City ID - always generated
        profile.ncID = KdspFinancialProfileManager.GenerateNCID(seed + 900, archetype);

        return profile;
    }

    // Credit score influenced by life theme
    private static func GenerateCreditScoreCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let score = KdspFinancialProfileManager.GenerateCreditScore(seed, archetype);
        
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") { score -= RandRange(seed + 5, 50, 150); }
            if Equals(coherence.lifeTheme, "STRUGGLING") { score -= RandRange(seed + 6, 30, 80); }
            if Equals(coherence.lifeTheme, "CLIMBING") { score += RandRange(seed + 7, 20, 60); }
            if Equals(coherence.lifeTheme, "STABLE") { score += RandRange(seed + 8, 30, 80); }
            if coherence.isInDebt { score -= RandRange(seed + 9, 20, 60); }
            if coherence.hasSubstanceIssues { score -= RandRange(seed + 10, 30, 80); }
        }
        
        if score < 100 { score = 100; }
        if score > 850 { score = 850; }
        return score;
    }

    // Wealth influenced by life theme
    private static func GenerateWealthCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let wealth = KdspFinancialProfileManager.GenerateWealth(seed, archetype);
        
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.5); }
            if Equals(coherence.lifeTheme, "STRUGGLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.7); }
            if Equals(coherence.lifeTheme, "CLIMBING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 1.2); }
            if Equals(coherence.lifeTheme, "CORPORATE") { wealth = Cast<Int32>(Cast<Float>(wealth) * 1.4); }
        }
        
        return wealth;
    }

    // Debt amount coherent with reason
    private static func GenerateDebtAmountCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let base = KdspFinancialProfileManager.GenerateDebtAmount(seed, archetype);
        
        if IsDefined(coherence) && NotEquals(coherence.debtReason, "") {
            if Equals(coherence.debtReason, "medical bills") { base = RandRange(seed, 10000, 150000); }
            if Equals(coherence.debtReason, "cyberware loans") { base = RandRange(seed, 5000, 80000); }
            if Equals(coherence.debtReason, "gambling") { base = RandRange(seed, 2000, 100000); }
            if Equals(coherence.debtReason, "failed business") { base = RandRange(seed, 20000, 200000); }
            if Equals(coherence.debtReason, "substance habit") { base = RandRange(seed, 3000, 50000); }
            if Equals(coherence.debtReason, "education loans") { base = RandRange(seed, 15000, 100000); }
        }
        
        return base;
    }

    // Debt holder coherent with reason
    private static func GenerateDebtHolderCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && NotEquals(coherence.debtReason, "") {
            if Equals(coherence.debtReason, "medical bills") {
                let holders: array<String>;
                ArrayPush(holders, "Trauma Team Collections");
                ArrayPush(holders, "Night City Medical Center");
                ArrayPush(holders, "Biotechnica Medical Services");
                ArrayPush(holders, "Private Healthcare Debt");
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
            if Equals(coherence.debtReason, "cyberware loans") {
                let holders: array<String>;
                ArrayPush(holders, "Ripperdoc Financing");
                ArrayPush(holders, "Zetatech Consumer Credit");
                ArrayPush(holders, "Kang Tao Finance");
                ArrayPush(holders, "Midnight Black Clinic");
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
            if Equals(coherence.debtReason, "gambling") {
                let holders: array<String>;
                ArrayPush(holders, "Pacifica Casino Group");
                ArrayPush(holders, "Private Loan Shark");
                ArrayPush(holders, "Underground Betting Ring");
                ArrayPush(holders, "Tyger Claws Collections");
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
            if Equals(coherence.debtReason, "substance habit") {
                let holders: array<String>;
                ArrayPush(holders, "Private Debt (Street)");
                ArrayPush(holders, "Gang Collections");
                ArrayPush(holders, "Rehabilitation Center");
                ArrayPush(holders, "Unnamed Creditor");
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
        }
        
        return KdspFinancialProfileManager.GenerateDebtHolder(seed, archetype);
    }

    // Employment status influenced by job history
    // Poor archetypes always use their own employment tables - coherence cannot override
    private static func GenerateEmploymentStatusCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") || Equals(archetype, "LOWLIFE") {
            return KdspFinancialProfileManager.GenerateEmploymentStatus(seed, archetype);
        }

        if IsDefined(coherence) {
            if Equals(coherence.jobHistory, "none") { return "UNEMPLOYED"; }
            if Equals(coherence.jobHistory, "criminal") {
                let statuses: array<String>;
                ArrayPush(statuses, "Self-employed");
                ArrayPush(statuses, "Freelance");
                ArrayPush(statuses, "UNEMPLOYED");
                ArrayPush(statuses, "Informal employment");
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
            if Equals(coherence.jobHistory, "unstable") {
                let statuses: array<String>;
                ArrayPush(statuses, "Part-time");
                ArrayPush(statuses, "Contract worker");
                ArrayPush(statuses, "Gig economy");
                ArrayPush(statuses, "Recently terminated");
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
            if Equals(coherence.jobHistory, "corpo") { return "Corporate employee"; }
            if Equals(coherence.jobHistory, "steady") { return "Full-time employed"; }
        }
        
        return KdspFinancialProfileManager.GenerateEmploymentStatus(seed, archetype);
    }

    // Income level coherent with life theme
    // Poor archetypes always use their own income tables - coherence themes cannot inflate them
    private static func GenerateIncomeLevelCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        // Poor archetypes: always use archetype-specific income, never coherence overrides
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") || Equals(archetype, "LOWLIFE") {
            return KdspFinancialProfileManager.GenerateIncomeLevel(seed, archetype);
        }

        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") {
                let levels: array<String>;
                ArrayPush(levels, "€$0-500/month");
                ArrayPush(levels, "€$500-1,500/month");
                ArrayPush(levels, "€$1,500-3,000/month");
                return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
            }
            if Equals(coherence.lifeTheme, "STRUGGLING") {
                let levels: array<String>;
                ArrayPush(levels, "€$1,000-2,000/month");
                ArrayPush(levels, "€$2,000-4,000/month");
                ArrayPush(levels, "€$500-1,500/month");
                return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
            }
            if Equals(coherence.lifeTheme, "CORPORATE") {
                let levels: array<String>;
                ArrayPush(levels, "€$8,000-15,000/month");
                ArrayPush(levels, "€$15,000-30,000/month");
                ArrayPush(levels, "€$5,000-10,000/month");
                return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
            }
        }
        
        return KdspFinancialProfileManager.GenerateIncomeLevel(seed, archetype);
    }

    // Bankruptcy more likely with falling life theme
    private static func HasBankruptcyCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Bool {
        let chance = 10;
        
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") { chance += 30; }
            if Equals(coherence.lifeTheme, "STRUGGLING") { chance += 15; }
            if coherence.isInDebt { chance += 10; }
            if coherence.hasSubstanceIssues { chance += 10; }
        }
        
        if Equals(archetype, "HOMELESS") { chance += 25; }
        if Equals(archetype, "JUNKIE") { chance += 20; }
        
        return RandRange(seed, 1, 100) <= chance;
    }

    private static func GenerateCreditScore(seed: Int32, archetype: String) -> Int32 {
        let base: Int32;
        let variance: Int32;

        if Equals(archetype, "CORPO_MANAGER") { base = 780; variance = 70; }
        else if Equals(archetype, "CORPO_DRONE") { base = 700; variance = 100; }
        else if Equals(archetype, "YUPPIE") { base = 720; variance = 80; }
        else if Equals(archetype, "CIVVIE") { base = 620; variance = 150; }
        else if Equals(archetype, "NOMAD") { base = 500; variance = 200; }
        else if Equals(archetype, "LOWLIFE") { base = 400; variance = 150; }
        else if Equals(archetype, "GANGER") { base = 350; variance = 150; }
        else if Equals(archetype, "JUNKIE") { base = 300; variance = 150; }
        else if Equals(archetype, "HOMELESS") { base = 200; variance = 150; }
        else { base = 550; variance = 200; }

        let score = base + RandRange(seed, -variance, variance);
        if score < 100 { score = 100; }
        if score > 850 { score = 850; }
        
        return score;
    }

    private static func GetCreditTier(score: Int32) -> String {
        if score >= 800 { return "EXCEPTIONAL"; }
        if score >= 750 { return "EXCELLENT"; }
        if score >= 700 { return "VERY GOOD"; }
        if score >= 650 { return "GOOD"; }
        if score >= 600 { return "FAIR"; }
        if score >= 550 { return "BELOW AVERAGE"; }
        if score >= 500 { return "POOR"; }
        if score >= 400 { return "VERY POOR"; }
        if score >= 300 { return "BAD"; }
        if score >= 250 { return "SEVERELY DAMAGED"; }
        if score >= 150 { return "CRITICAL"; }
        return "NO CREDIT HISTORY";
    }

    private static func GenerateWealth(seed: Int32, archetype: String) -> Int32 {
        // Returns estimated net worth in eddies
        let base: Int32;

        if Equals(archetype, "CORPO_MANAGER") { base = RandRange(seed, 500000, 5000000); }
        else if Equals(archetype, "CORPO_DRONE") { base = RandRange(seed, 50000, 500000); }
        else if Equals(archetype, "YUPPIE") { base = RandRange(seed, 100000, 1000000); }
        else if Equals(archetype, "CIVVIE") { base = RandRange(seed, 5000, 100000); }
        else if Equals(archetype, "NOMAD") { base = RandRange(seed, 2000, 50000); }
        else if Equals(archetype, "LOWLIFE") { base = RandRange(seed, 100, 10000); }
        else if Equals(archetype, "GANGER") { base = RandRange(seed, 500, 75000); }
        else if Equals(archetype, "JUNKIE") { base = RandRange(seed, 0, 2000); }
        else if Equals(archetype, "HOMELESS") { base = RandRange(seed, 0, 500); }
        else { base = RandRange(seed, 1000, 50000); }

        return base;
    }

    private static func GetWealthTier(wealth: Int32) -> String {
        if wealth >= 5000000 { return "ULTRA WEALTHY"; }
        if wealth >= 1000000 { return "WEALTHY"; }
        if wealth >= 500000 { return "AFFLUENT"; }
        if wealth >= 250000 { return "UPPER MIDDLE CLASS"; }
        if wealth >= 100000 { return "COMFORTABLE"; }
        if wealth >= 50000 { return "MIDDLE CLASS"; }
        if wealth >= 25000 { return "LOWER MIDDLE CLASS"; }
        if wealth >= 10000 { return "WORKING CLASS"; }
        if wealth >= 5000 { return "LOW INCOME"; }
        if wealth >= 1000 { return "NEAR POVERTY"; }
        if wealth >= 100 { return "POVERTY"; }
        return "DESTITUTE";
    }

    private static func HasDebt(seed: Int32, archetype: String, creditScore: Int32) -> Bool {
        let debtChance: Int32;

        if Equals(archetype, "CORPO_MANAGER") { debtChance = 20; }
        else if Equals(archetype, "CORPO_DRONE") { debtChance = 60; }
        else if Equals(archetype, "YUPPIE") { debtChance = 40; }
        else if Equals(archetype, "CIVVIE") { debtChance = 70; }
        else if Equals(archetype, "LOWLIFE") { debtChance = 85; }
        else if Equals(archetype, "GANGER") { debtChance = 50; }
        else if Equals(archetype, "JUNKIE") { debtChance = 90; }
        else if Equals(archetype, "HOMELESS") { debtChance = 95; }
        else { debtChance = 60; }

        return RandRange(seed, 1, 100) <= debtChance;
    }

    private static func GenerateDebtAmount(seed: Int32, archetype: String) -> Int32 {
        if Equals(archetype, "CORPO_MANAGER") { return RandRange(seed, 50000, 500000); }
        if Equals(archetype, "CORPO_DRONE") { return RandRange(seed, 10000, 200000); }
        if Equals(archetype, "YUPPIE") { return RandRange(seed, 20000, 300000); }
        if Equals(archetype, "CIVVIE") { return RandRange(seed, 5000, 100000); }
        if Equals(archetype, "LOWLIFE") { return RandRange(seed, 1000, 50000); }
        if Equals(archetype, "GANGER") { return RandRange(seed, 2000, 75000); }
        if Equals(archetype, "JUNKIE") { return RandRange(seed, 500, 30000); }
        if Equals(archetype, "HOMELESS") { return RandRange(seed, 100, 20000); }
        return RandRange(seed, 1000, 50000);
    }

    private static func GenerateDebtHolder(seed: Int32, archetype: String) -> String {
        // Corporate/Legitimate debt holders for higher archetypes
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 24);
            if i == 0 { return "Arasaka Financial Services"; }
            if i == 1 { return "Militech Credit Division"; }
            if i == 2 { return "EuroBank"; }
            if i == 3 { return "Orbital Lending Corp"; }
            if i == 4 { return "Zetatech Consumer Finance"; }
            if i == 5 { return "Night City Municipal Debt"; }
            if i == 6 { return "Kang Tao Financial"; }
            if i == 7 { return "Biotechnica Credit Services"; }
            if i == 8 { return "Petrochem Finance Division"; }
            if i == 9 { return "NCMH (Medical Debt)"; }
            if i == 10 { return "NC Housing Authority"; }
            if i == 11 { return "Corporate Credit Union"; }
            if i == 12 { return "Trauma Team Billing"; }
            if i == 13 { return "SovOil Credit"; }
            if i == 14 { return "IEC Financial"; }
            if i == 15 { return "Continental Brands Credit"; }
            if i == 16 { return "Federal Student Loans"; }
            if i == 17 { return "NC Auto Finance"; }
            if i == 18 { return "Premium Healthcare Collections"; }
            if i == 19 { return "Luxury Credit Partners"; }
            if i == 20 { return "Executive Lending Group"; }
            if i == 21 { return "Corporate Tax Authority"; }
            if i == 22 { return "Property Management Corp"; }
            if i == 23 { return "Cyberware Financing LLC"; }
            return "Investment Recovery Services";
        }
        
        // Gang/Criminal debt holders
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Tyger Claws (informal)"; }
            if i == 1 { return "Valentinos (informal)"; }
            if i == 2 { return "6th Street Collections"; }
            if i == 3 { return "Maelstrom Debt Enforcement"; }
            if i == 4 { return "Animals Collections"; }
            if i == 5 { return "Voodoo Boys (spiritual debt)"; }
            if i == 6 { return "Mox Protection Fund"; }
            if i == 7 { return "Gang Elder Council"; }
            if i == 8 { return "Street Fixer (unnamed)"; }
            if i == 9 { return "Local Loan Shark"; }
            if i == 10 { return "Drug Supplier"; }
            if i == 11 { return "Weapons Dealer"; }
            if i == 12 { return "Chop Shop Owner"; }
            if i == 13 { return "Underground Casino"; }
            return "Territory Boss";
        }
        
        // General population debt holders (40 options)
        let i = RandRange(seed, 0, 39);
        
        // Corporate/Legitimate (0-19)
        if i == 0 { return "Arasaka Financial Services"; }
        if i == 1 { return "Militech Credit Division"; }
        if i == 2 { return "EuroBank"; }
        if i == 3 { return "Night City Municipal Debt Collection"; }
        if i == 4 { return "Orbital Lending Corp"; }
        if i == 5 { return "Zetatech Consumer Finance"; }
        if i == 6 { return "NCMH (Medical Debt)"; }
        if i == 7 { return "Night City Housing Authority"; }
        if i == 8 { return "NC Auto Loans"; }
        if i == 9 { return "Ripperdoc Financing"; }
        if i == 10 { return "Night City Savings & Loan"; }
        if i == 11 { return "Pacific Credit Union"; }
        if i == 12 { return "Watson Community Bank"; }
        if i == 13 { return "Heywood Finance Corp"; }
        if i == 14 { return "Santo Domingo Credit"; }
        if i == 15 { return "Westbrook Lending"; }
        if i == 16 { return "All Foods Payroll Advance"; }
        if i == 17 { return "NC Transit Authority"; }
        if i == 18 { return "Utility Collections (NCCE)"; }
        if i == 19 { return "Education Loan Services"; }
        
        // Semi-legitimate (20-29)
        if i == 20 { return "Payday Lending Network"; }
        if i == 21 { return "Quick Cash NC"; }
        if i == 22 { return "Emergency Loans Inc."; }
        if i == 23 { return "Title Loan Services"; }
        if i == 24 { return "Pawn Shop Debt"; }
        if i == 25 { return "Buy Now Pay Later Corp"; }
        if i == 26 { return "Rent-to-Own Collections"; }
        if i == 27 { return "Subprime Auto Lending"; }
        if i == 28 { return "Third Party Collector"; }
        if i == 29 { return "Debt Consolidation Services"; }
        
        // Shady/Criminal (30-39)
        if i == 30 { return "Unknown Private Lender"; }
        if i == 31 { return "Tyger Claws (informal)"; }
        if i == 32 { return "Valentinos (informal)"; }
        if i == 33 { return "6th Street Collections"; }
        if i == 34 { return "Street Fixer (unnamed)"; }
        if i == 35 { return "Maelstrom Debt Enforcement"; }
        if i == 36 { return "Local Loan Shark"; }
        if i == 37 { return "Underground Gambling Debt"; }
        if i == 38 { return "Drug Debt (Unspecified)"; }
        return "Private Individual (Enforced)";
    }

    private static func GenerateDebtStatus(seed: Int32, creditScore: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if creditScore >= 650 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Current - Good Standing"; }
            if i == 1 { return "Current - Excellent Payment History"; }
            if i == 2 { return "Current - Auto-Pay Active"; }
            if i == 3 { return "Current - Minimum Payments"; }
            if i == 4 { return "Current - Ahead of Schedule"; }
            if i == 5 { return "Current - Recently Paid Down"; }
            if i == 6 { return "30 Days Past Due"; }
            if i == 7 { return "Under Review"; }
            if i == 8 { return "Payment Plan Active"; }
            return "Refinancing in Progress";
        }
        
        if creditScore >= 450 {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Current - Good Standing"; }
            if i == 1 { return "Current - Minimum Payments"; }
            if i == 2 { return "Current - Struggling"; }
            if i == 3 { return "30 Days Past Due"; }
            if i == 4 { return "30-60 Days Past Due"; }
            if i == 5 { return "60 Days Past Due"; }
            if i == 6 { return "Payment Plan Negotiated"; }
            if i == 7 { return "Hardship Deferment"; }
            if i == 8 { return "In Collections"; }
            if i == 9 { return "Collection Calls Active"; }
            if i == 10 { return "Wage Garnishment Active"; }
            if i == 11 { return "Settlement Offered"; }
            if i == 12 { return "Dispute Filed"; }
            if i == 13 { return "Legal Action Pending"; }
            return "Credit Counseling Required";
        }
        
        // Poor credit - bad status options (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Current - Minimum Payments"; }
        if i == 1 { return "60-90 Days Past Due"; }
        if i == 2 { return "90+ Days Past Due"; }
        if i == 3 { return "120+ Days Delinquent"; }
        if i == 4 { return "In Collections"; }
        if i == 5 { return "Multiple Collection Agencies"; }
        if i == 6 { return "Wage Garnishment Active"; }
        if i == 7 { return "Bank Account Levied"; }
        if i == 8 { return "Asset Seizure Pending"; }
        if i == 9 { return "Asset Seizure Complete"; }
        if i == 10 { return "Debt Sold to Enforcement Agency"; }
        if i == 11 { return "Legal Judgment Against"; }
        if i == 12 { return "Court Order for Payment"; }
        if i == 13 { return "Liens Filed"; }
        if i == 14 { return "Default - Charged Off"; }
        if i == 15 { return "Bankruptcy Recommended"; }
        if i == 16 { return "Skip Trace Active"; }
        if i == 17 { return "Enforcement Officers Notified"; }
        if i == 18 { return "Corporate Indentured Status Risk"; }
        return "Serious Delinquency - Final Notice";
    }

    private static func GeneratePropertyStatus(seed: Int32, archetype: String, wealth: Int32) -> String {
        if Equals(archetype, "HOMELESS") { return "NO FIXED ADDRESS"; }
        
        let roll = RandRange(seed, 1, 100);
        
        if wealth >= 500000 {
            if roll <= 70 { return "PROPERTY OWNER"; }
            return "RENTER (Luxury)";
        }
        if wealth >= 100000 {
            if roll <= 30 { return "PROPERTY OWNER"; }
            if roll <= 80 { return "RENTER"; }
            return "CORPORATE HOUSING";
        }
        if wealth >= 20000 {
            if roll <= 10 { return "PROPERTY OWNER"; }
            if roll <= 70 { return "RENTER"; }
            if roll <= 85 { return "SUBLETTING"; }
            return "CORPORATE HOUSING";
        }
        
        if roll <= 40 { return "RENTER"; }
        if roll <= 60 { return "SUBLETTING"; }
        if roll <= 75 { return "COHABITING"; }
        if roll <= 90 { return "SQUATTING"; }
        return "TRANSIENT";
    }

    private static func GenerateResidenceType(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Penthouse Suite"; }
            if i == 1 { return "Luxury Apartment"; }
            if i == 2 { return "Executive Housing Complex"; }
            if i == 3 { return "Gated Community Residence"; }
            if i == 4 { return "High-Rise Apartment (Premium)"; }
            if i == 5 { return "Skyrise Condo"; }
            if i == 6 { return "Private Villa"; }
            if i == 7 { return "Secured Compound"; }
            if i == 8 { return "Corporate Tower Residence"; }
            if i == 9 { return "Waterfront Property"; }
            if i == 10 { return "Historic Renovated Loft"; }
            if i == 11 { return "Smart Home Estate"; }
            if i == 12 { return "Designer Apartment"; }
            if i == 13 { return "Executive Suite Hotel"; }
            return "Private Floor Residence";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Corporate Housing Unit"; }
            if i == 1 { return "Mid-Rise Apartment"; }
            if i == 2 { return "Megabuilding Unit (Standard)"; }
            if i == 3 { return "Company Dormitory"; }
            if i == 4 { return "Subsidized Corporate Housing"; }
            if i == 5 { return "Efficiency Apartment"; }
            if i == 6 { return "Corporate Barracks"; }
            if i == 7 { return "Employee Housing Block"; }
            if i == 8 { return "Commuter Pod"; }
            return "Shared Corporate Suite";
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Mobile Home/Vehicle"; }
            if i == 1 { return "Camp Dwelling"; }
            if i == 2 { return "Nomad Settlement"; }
            if i == 3 { return "Badlands Compound"; }
            if i == 4 { return "Converted RV"; }
            if i == 5 { return "Tent/Temporary Shelter"; }
            if i == 6 { return "Clan Communal Housing"; }
            if i == 7 { return "Caravan Trailer"; }
            if i == 8 { return "Desert Shack"; }
            return "Salvaged Vehicle Home";
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Street/Alley"; }
            if i == 1 { return "Abandoned Building"; }
            if i == 2 { return "Underpass/Bridge"; }
            if i == 3 { return "Shelter (Temporary)"; }
            if i == 4 { return "Tent City"; }
            if i == 5 { return "Cardboard Dwelling"; }
            if i == 6 { return "Storm Drain"; }
            if i == 7 { return "Rooftop Encampment"; }
            if i == 8 { return "Abandoned Vehicle"; }
            if i == 9 { return "Construction Site"; }
            if i == 10 { return "Dumpster Area"; }
            if i == 11 { return "Subway Station"; }
            if i == 12 { return "Park Bench"; }
            if i == 13 { return "Loading Dock"; }
            return "Wherever Available";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Gang Safehouse"; }
            if i == 1 { return "Shared Apartment"; }
            if i == 2 { return "Megabuilding Unit (Low)"; }
            if i == 3 { return "Warehouse Conversion"; }
            if i == 4 { return "Clubhouse Quarters"; }
            if i == 5 { return "Fortified Apartment"; }
            if i == 6 { return "Territory Stronghold"; }
            if i == 7 { return "Above Business (Gang-owned)"; }
            if i == 8 { return "Shipping Container"; }
            return "Underground Bunker";
        }
        
        // General population (15 options)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "Megabuilding Unit"; }
        if i == 1 { return "Low-Rise Apartment"; }
        if i == 2 { return "Shared Housing"; }
        if i == 3 { return "Studio Apartment"; }
        if i == 4 { return "Basement Unit"; }
        if i == 5 { return "Coffin Hotel (Long-term)"; }
        if i == 6 { return "SRO (Single Room Occupancy)"; }
        if i == 7 { return "Converted Storage Unit"; }
        if i == 8 { return "Above Shop Apartment"; }
        if i == 9 { return "Prefab Housing Unit"; }
        if i == 10 { return "Modular Apartment"; }
        if i == 11 { return "Row House"; }
        if i == 12 { return "Tenement Building"; }
        if i == 13 { return "Mixed-Use Building"; }
        return "Public Housing Project";
    }

    private static func GenerateResidenceDistrict(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "City Center - Corporate Plaza"; }
            if i == 1 { return "Westbrook - North Oak"; }
            if i == 2 { return "Westbrook - Charter Hill"; }
            if i == 3 { return "Heywood - The Glen"; }
            if i == 4 { return "City Center - Downtown"; }
            if i == 5 { return "Westbrook - Japantown (Premium)"; }
            if i == 6 { return "Heywood - Vista del Rey (Gated)"; }
            if i == 7 { return "City Center - Corpo Plaza"; }
            if i == 8 { return "North Oak Estates"; }
            return "Charter Hill Heights";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "City Center - Downtown"; }
            if i == 1 { return "Watson - Little China"; }
            if i == 2 { return "Westbrook - Japantown"; }
            if i == 3 { return "Santo Domingo - Rancho Coronado"; }
            if i == 4 { return "Heywood - Wellsprings"; }
            if i == 5 { return "Watson - Arasaka Waterfront"; }
            if i == 6 { return "City Center - Corporation St."; }
            if i == 7 { return "Santo Domingo - Arroyo"; }
            if i == 8 { return "Heywood - The Glen"; }
            return "Westbrook - Charter Hill (Budget)";
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Badlands - Rocky Ridge"; }
            if i == 1 { return "Badlands - Biotechnica Flats"; }
            if i == 2 { return "Badlands - Sierra Sonora"; }
            if i == 3 { return "Santo Domingo - Arroyo (Edge)"; }
            if i == 4 { return "Badlands - Red Peaks"; }
            if i == 5 { return "Badlands - Oil Fields"; }
            if i == 6 { return "Badlands - Solar Farm"; }
            if i == 7 { return "Jackson Plains"; }
            if i == 8 { return "Aldecaldo Camp"; }
            return "Badlands - Highway 99";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Watson - Kabuki"; }
            if i == 1 { return "Watson - Northside"; }
            if i == 2 { return "Heywood - Vista del Rey"; }
            if i == 3 { return "Pacifica - West Wind Estate"; }
            if i == 4 { return "Santo Domingo - Arroyo"; }
            if i == 5 { return "Westbrook - Japantown"; }
            if i == 6 { return "Watson - Little China"; }
            if i == 7 { return "Pacifica - Coastview"; }
            if i == 8 { return "Heywood - Wellsprings"; }
            if i == 9 { return "Santo Domingo - Rancho Coronado"; }
            if i == 10 { return "Dogtown"; }
            if i == 11 { return "Pacifica - Stadium"; }
            if i == 12 { return "Watson - Northside Industrial"; }
            if i == 13 { return "Heywood - Glen North"; }
            return "Valentino Territory";
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Watson - Kabuki (Streets)"; }
            if i == 1 { return "Pacifica - Coastview"; }
            if i == 2 { return "Heywood - Wellsprings"; }
            if i == 3 { return "Santo Domingo - Arroyo"; }
            if i == 4 { return "Watson - Northside (Industrial)"; }
            if i == 5 { return "City Center - Underpasses"; }
            if i == 6 { return "Pacifica - Abandoned Mall"; }
            if i == 7 { return "Santo Domingo - Factory District"; }
            if i == 8 { return "Various - Migrant"; }
            return "Badlands - Outskirts";
        }
        
        // General population (20 options)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "Watson - Little China"; }
        if i == 1 { return "Watson - Kabuki"; }
        if i == 2 { return "Heywood - Wellsprings"; }
        if i == 3 { return "Santo Domingo - Rancho Coronado"; }
        if i == 4 { return "Westbrook - Japantown"; }
        if i == 5 { return "Watson - Northside"; }
        if i == 6 { return "Heywood - The Glen"; }
        if i == 7 { return "Santo Domingo - Arroyo"; }
        if i == 8 { return "Heywood - Vista del Rey"; }
        if i == 9 { return "City Center - Downtown"; }
        if i == 10 { return "Pacifica - West Wind"; }
        if i == 11 { return "Westbrook - Charter Hill"; }
        if i == 12 { return "Watson - Arasaka Waterfront"; }
        if i == 13 { return "Megabuilding H10 - Watson"; }
        if i == 14 { return "Megabuilding H8 - Japantown"; }
        if i == 15 { return "Megabuilding H4 - Arroyo"; }
        if i == 16 { return "Dogtown"; }
        if i == 17 { return "Pacifica - Coastview"; }
        if i == 18 { return "Santo Domingo - Industrial"; }
        return "Heywood - Glen South";
    }

    private static func GenerateEmploymentStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { 
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "EMPLOYED - Executive Level"; }
            if i == 1 { return "EMPLOYED - Senior Management"; }
            if i == 2 { return "EMPLOYED - Director Level"; }
            if i == 3 { return "EMPLOYED - VP Level"; }
            return "EMPLOYED - C-Suite Adjacent";
        }
        if Equals(archetype, "CORPO_DRONE") { 
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "EMPLOYED - Corporate"; }
            if i == 1 { return "EMPLOYED - Corporate (Probation)"; }
            if i == 2 { return "EMPLOYED - Corporate (Contract)"; }
            if i == 3 { return "EMPLOYED - Corporate (Temp)"; }
            return "EMPLOYED - Corporate (Intern)";
        }
        if Equals(archetype, "HOMELESS") { 
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "UNEMPLOYED"; }
            if i == 1 { return "UNEMPLOYED - Long-term"; }
            if i == 2 { return "UNEMPLOYED - Disabled"; }
            if i == 3 { return "PANHANDLING"; }
            return "INFORMAL - Scavenging";
        }
        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 6);
            if i == 0 { return "UNEMPLOYED"; }
            if i == 1 { return "UNEMPLOYED - Unable to work"; }
            if i == 2 { return "EMPLOYED - Informal"; }
            if i == 3 { return "UNEMPLOYED - Recently fired"; }
            if i == 4 { return "GIG ECONOMY - Sporadic"; }
            if i == 5 { return "SELF-EMPLOYED - Dealer"; }
            return "DAY LABOR - When sober";
        }
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "EMPLOYED - Informal"; }
            if i == 1 { return "SELF-EMPLOYED - Street business"; }
            if i == 2 { return "GANG OPERATIONS"; }
            if i == 3 { return "CRIMINAL ENTERPRISE"; }
            if i == 4 { return "PROTECTION SERVICES"; }
            if i == 5 { return "DISTRIBUTION NETWORK"; }
            if i == 6 { return "EMPLOYED - Front business"; }
            if i == 7 { return "FREELANCE - Muscle for hire"; }
            if i == 8 { return "TERRITORY MANAGEMENT"; }
            return "COLLECTION SERVICES";
        }
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "EMPLOYED - Clan duties"; }
            if i == 1 { return "SELF-EMPLOYED - Mechanic"; }
            if i == 2 { return "EMPLOYED - Smuggling runs"; }
            if i == 3 { return "FREELANCE - Transport"; }
            if i == 4 { return "CLAN BUSINESS"; }
            if i == 5 { return "EMPLOYED - Scavenging operations"; }
            if i == 6 { return "CONTRACT - Convoy security"; }
            if i == 7 { return "SELF-EMPLOYED - Trading"; }
            if i == 8 { return "FREELANCE - Guide services"; }
            return "CLAN SUPPORT ROLE";
        }
        
        // General population (25 options)
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "EMPLOYED - Full Time"; }
        if i == 1 { return "EMPLOYED - Part Time"; }
        if i == 2 { return "EMPLOYED - Contract"; }
        if i == 3 { return "EMPLOYED - Gig Economy"; }
        if i == 4 { return "SELF-EMPLOYED"; }
        if i == 5 { return "UNEMPLOYED - Seeking"; }
        if i == 6 { return "UNEMPLOYED"; }
        if i == 7 { return "EMPLOYED - Informal"; }
        if i == 8 { return "RETIRED"; }
        if i == 9 { return "DISABLED"; }
        if i == 10 { return "EMPLOYED - Seasonal"; }
        if i == 11 { return "EMPLOYED - Night shift"; }
        if i == 12 { return "EMPLOYED - Multiple jobs"; }
        if i == 13 { return "FREELANCE"; }
        if i == 14 { return "ON LEAVE - Medical"; }
        if i == 15 { return "ON LEAVE - Maternity/Paternity"; }
        if i == 16 { return "FURLOUGHED"; }
        if i == 17 { return "EMPLOYED - Probationary"; }
        if i == 18 { return "EMPLOYED - Apprentice"; }
        if i == 19 { return "STUDENT"; }
        if i == 20 { return "EMPLOYED - Remote"; }
        if i == 21 { return "LAID OFF - Recent"; }
        if i == 22 { return "UNDEREMPLOYED"; }
        if i == 23 { return "ZERO HOURS CONTRACT"; }
        return "TEMP AGENCY";
    }

    private static func GenerateEmployer(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 29);
            if i == 0 { return "Arasaka Corporation"; }
            if i == 1 { return "Militech"; }
            if i == 2 { return "Kang Tao"; }
            if i == 3 { return "Biotechnica"; }
            if i == 4 { return "Petrochem"; }
            if i == 5 { return "Zetatech"; }
            if i == 6 { return "Kiroshi Opticals"; }
            if i == 7 { return "Trauma Team International"; }
            if i == 8 { return "Night City Municipal"; }
            if i == 9 { return "NCART"; }
            if i == 10 { return "SovOil"; }
            if i == 11 { return "IEC"; }
            if i == 12 { return "Continental Brands"; }
            if i == 13 { return "All Foods"; }
            if i == 14 { return "Orbital Air"; }
            if i == 15 { return "Network News 54"; }
            if i == 16 { return "World News Service"; }
            if i == 17 { return "Dynalar Technologies"; }
            if i == 18 { return "Raven Microcybernetics"; }
            if i == 19 { return "EuroBank"; }
            if i == 20 { return "Kendachi"; }
            if i == 21 { return "Tsunami Defense Systems"; }
            if i == 22 { return "Budget Arms"; }
            if i == 23 { return "NetWatch"; }
            if i == 24 { return "MaxTac Division"; }
            if i == 25 { return "NCPD Administration"; }
            if i == 26 { return "Ziggurat"; }
            if i == 27 { return "Segotari"; }
            if i == 28 { return "Rocklin Augmentics"; }
            return "Fuyutsuki Electronics";
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Private Practice"; }
            if i == 1 { return "Consulting Firm"; }
            if i == 2 { return "Media Corporation"; }
            if i == 3 { return "Law Firm"; }
            if i == 4 { return "Financial Services"; }
            if i == 5 { return "Medical Practice"; }
            if i == 6 { return "Architecture Firm"; }
            if i == 7 { return "Marketing Agency"; }
            if i == 8 { return "Real Estate Development"; }
            if i == 9 { return "Tech Startup"; }
            if i == 10 { return "Entertainment Industry"; }
            if i == 11 { return "Investment Banking"; }
            if i == 12 { return "Cybersecurity Firm"; }
            if i == 13 { return "Biotech Startup"; }
            return "Venture Capital";
        }
        
        // General population (40 options)
        let i = RandRange(seed, 0, 39);
        if i == 0 { return "Various (Gig Work)"; }
        if i == 1 { return "Local Business"; }
        if i == 2 { return "Self-Employed"; }
        if i == 3 { return "Factory (Santo Domingo)"; }
        if i == 4 { return "Food Service"; }
        if i == 5 { return "Retail"; }
        if i == 6 { return "Construction"; }
        if i == 7 { return "Sanitation"; }
        if i == 8 { return "Security (Contract)"; }
        if i == 9 { return "N/A - Unemployed"; }
        if i == 10 { return "Delivery Services"; }
        if i == 11 { return "Rideshare Driver"; }
        if i == 12 { return "Warehouse (All Foods)"; }
        if i == 13 { return "Manufacturing Plant"; }
        if i == 14 { return "Bar/Club Staff"; }
        if i == 15 { return "Street Vendor"; }
        if i == 16 { return "Mechanic Shop"; }
        if i == 17 { return "Cleaning Services"; }
        if i == 18 { return "Healthcare Aide"; }
        if i == 19 { return "Childcare"; }
        if i == 20 { return "Taxi/Transport"; }
        if i == 21 { return "Hospitality"; }
        if i == 22 { return "Bouncer/Doorman"; }
        if i == 23 { return "Small Business Owner"; }
        if i == 24 { return "Repair Technician"; }
        if i == 25 { return "Dock Worker"; }
        if i == 26 { return "Market Stall"; }
        if i == 27 { return "Hair Salon"; }
        if i == 28 { return "Laundromat"; }
        if i == 29 { return "Pawn Shop"; }
        if i == 30 { return "Gun Store"; }
        if i == 31 { return "Pharmacy Assistant"; }
        if i == 32 { return "Grocery Store"; }
        if i == 33 { return "Electronics Repair"; }
        if i == 34 { return "Tattoo Parlor"; }
        if i == 35 { return "Clothing Store"; }
        if i == 36 { return "Night Market Vendor"; }
        if i == 37 { return "Recycling Plant"; }
        if i == 38 { return "Seasonal Work"; }
        return "Day Labor";
    }

    private static func GenerateIncomeLevel(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$250,000-500,000/year"; }
            if i == 1 { return "€$500,000-1,000,000/year"; }
            if i == 2 { return "€$1,000,000+/year"; }
            if i == 3 { return "€$200,000-350,000/year"; }
            if i == 4 { return "€$350,000-500,000/year"; }
            if i == 5 { return "€$150,000-250,000/year + Bonuses"; }
            if i == 6 { return "€$300,000/year + Stock Options"; }
            if i == 7 { return "€$400,000/year + Benefits Package"; }
            if i == 8 { return "€$250,000/year + Performance Bonus"; }
            return "€$500,000/year + Executive Package";
        }
        if Equals(archetype, "CORPO_DRONE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$45,000-60,000/year"; }
            if i == 1 { return "€$60,000-80,000/year"; }
            if i == 2 { return "€$80,000-100,000/year"; }
            if i == 3 { return "€$100,000-120,000/year"; }
            if i == 4 { return "€$35,000-50,000/year"; }
            if i == 5 { return "€$50,000/year + Overtime"; }
            if i == 6 { return "€$70,000/year + Benefits"; }
            if i == 7 { return "€$55,000/year (Entry Level)"; }
            if i == 8 { return "€$90,000/year (Senior)"; }
            return "€$65,000/year + Corporate Housing";
        }
        if Equals(archetype, "YUPPIE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$80,000-120,000/year"; }
            if i == 1 { return "€$120,000-180,000/year"; }
            if i == 2 { return "€$180,000-250,000/year"; }
            if i == 3 { return "€$100,000/year + Commission"; }
            if i == 4 { return "€$150,000/year (Partner Track)"; }
            if i == 5 { return "€$200,000/year + Profit Share"; }
            if i == 6 { return "€$90,000/year (Associate)"; }
            if i == 7 { return "€$130,000/year + Bonuses"; }
            if i == 8 { return "€$175,000/year (Senior Associate)"; }
            return "€$250,000+/year (Partner)";
        }
        if Equals(archetype, "CIVVIE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$15,000-25,000/year"; }
            if i == 1 { return "€$25,000-35,000/year"; }
            if i == 2 { return "€$35,000-45,000/year"; }
            if i == 3 { return "€$20,000/year + Tips"; }
            if i == 4 { return "€$30,000/year (Hourly)"; }
            if i == 5 { return "€$18,000/year (Part-time)"; }
            if i == 6 { return "€$40,000/year (Skilled)"; }
            if i == 7 { return "€$22,000/year + Benefits"; }
            if i == 8 { return "€$28,000/year (Union)"; }
            return "€$32,000/year (Full-time)";
        }
        if Equals(archetype, "LOWLIFE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$5,000-8,000/year"; }
            if i == 1 { return "€$8,000-12,000/year"; }
            if i == 2 { return "€$12,000-15,000/year"; }
            if i == 3 { return "€$3,000-6,000/year (Sporadic)"; }
            if i == 4 { return "€$10,000/year (Cash)"; }
            if i == 5 { return "€$7,000/year (Gig Work)"; }
            if i == 6 { return "€$4,000/year + Scavenging"; }
            if i == 7 { return "€$9,000/year (Day Labor)"; }
            if i == 8 { return "€$6,000/year (Unreported)"; }
            return "VARIABLE - Under €$15,000/year";
        }
        if Equals(archetype, "GANGER") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$10,000-25,000/year (Est.)"; }
            if i == 1 { return "€$25,000-50,000/year (Est.)"; }
            if i == 2 { return "€$50,000-100,000/year (Est.)"; }
            if i == 3 { return "€$15,000/year + Street Income"; }
            if i == 4 { return "€$40,000/year (Enforcer)"; }
            if i == 5 { return "€$75,000/year (Lieutenant)"; }
            if i == 6 { return "€$20,000/year (Soldier)"; }
            if i == 7 { return "VARIABLE - Criminal Enterprise"; }
            if i == 8 { return "€$30,000/year + Territory Cut"; }
            return "UNREPORTED - Estimated €$35,000+";
        }
        if Equals(archetype, "JUNKIE") { 
            let i = RandRange(seed, 0, 6);
            if i == 0 { return "< €$5,000/year"; }
            if i == 1 { return "€$0-2,000/year"; }
            if i == 2 { return "€$2,000-5,000/year"; }
            if i == 3 { return "NO STABLE INCOME"; }
            if i == 4 { return "IRREGULAR - Under €$3,000/year"; }
            if i == 5 { return "€$1,000/year (Panhandling)"; }
            return "SURVIVAL INCOME ONLY";
        }
        if Equals(archetype, "HOMELESS") { 
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NO INCOME"; }
            if i == 1 { return "€$0-500/year (Panhandling)"; }
            if i == 2 { return "NONE - Relies on shelters"; }
            if i == 3 { return "€$0-1,000/year (Scavenging)"; }
            if i == 4 { return "NO DOCUMENTED INCOME"; }
            return "SUBSISTENCE ONLY";
        }
        if Equals(archetype, "NOMAD") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$8,000-15,000/year (Est.)"; }
            if i == 1 { return "€$15,000-25,000/year (Est.)"; }
            if i == 2 { return "€$25,000-40,000/year (Est.)"; }
            if i == 3 { return "CLAN-BASED - Shared resources"; }
            if i == 4 { return "€$20,000/year (Transport runs)"; }
            if i == 5 { return "€$12,000/year + Trade goods"; }
            if i == 6 { return "€$30,000/year (Smuggling)"; }
            if i == 7 { return "VARIABLE - Contract work"; }
            if i == 8 { return "€$18,000/year (Mechanic)"; }
            return "NON-MONETARY - Barter economy";
        }
        
        // Default
        let i = RandRange(seed, 0, 9);
        if i == 0 { return "€$20,000-30,000/year"; }
        if i == 1 { return "€$30,000-40,000/year"; }
        if i == 2 { return "€$15,000-25,000/year"; }
        if i == 3 { return "€$25,000/year (Average)"; }
        if i == 4 { return "€$35,000/year + Overtime"; }
        if i == 5 { return "€$22,000/year (Entry)"; }
        if i == 6 { return "€$28,000/year (Experienced)"; }
        if i == 7 { return "€$18,000/year (Part-time)"; }
        if i == 8 { return "€$32,000/year (Skilled)"; }
        return "€$24,000/year (Median)";
    }

    private static func GeneratePurchase(seed: Int32, archetype: String, wealth: Int32) -> String {
        if wealth >= 100000 {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Luxury vehicle - €$" + IntToString(RandRange(seed, 80000, 250000)); }
            if i == 1 { return "Premium cyberware suite - €$" + IntToString(RandRange(seed, 25000, 100000)); }
            if i == 2 { return "Vacation package (orbital) - €$" + IntToString(RandRange(seed, 15000, 75000)); }
            if i == 3 { return "Real estate investment - €$" + IntToString(RandRange(seed, 150000, 750000)); }
            if i == 4 { return "Art collection piece - €$" + IntToString(RandRange(seed, 10000, 100000)); }
            if i == 5 { return "Custom weapon (legendary) - €$" + IntToString(RandRange(seed, 15000, 50000)); }
            if i == 6 { return "Personal AV rental - €$" + IntToString(RandRange(seed, 5000, 25000)); }
            if i == 7 { return "Designer clothing - €$" + IntToString(RandRange(seed, 3000, 15000)); }
            if i == 8 { return "Fine dining (monthly) - €$" + IntToString(RandRange(seed, 2000, 8000)); }
            if i == 9 { return "Private security contract - €$" + IntToString(RandRange(seed, 10000, 50000)); }
            if i == 10 { return "Exclusive club membership - €$" + IntToString(RandRange(seed, 5000, 25000)); }
            if i == 11 { return "Wine collection - €$" + IntToString(RandRange(seed, 3000, 20000)); }
            if i == 12 { return "Smart home upgrade - €$" + IntToString(RandRange(seed, 8000, 40000)); }
            if i == 13 { return "Luxury watch - €$" + IntToString(RandRange(seed, 5000, 30000)); }
            if i == 14 { return "Private medical procedure - €$" + IntToString(RandRange(seed, 10000, 75000)); }
            if i == 15 { return "Investment portfolio addition - €$" + IntToString(RandRange(seed, 25000, 150000)); }
            if i == 16 { return "Rare collectible - €$" + IntToString(RandRange(seed, 5000, 50000)); }
            if i == 17 { return "High-end electronics - €$" + IntToString(RandRange(seed, 3000, 15000)); }
            if i == 18 { return "Personal trainer (annual) - €$" + IntToString(RandRange(seed, 5000, 20000)); }
            return "Charity donation - €$" + IntToString(RandRange(seed, 2000, 25000));
        }
        
        if wealth >= 20000 {
            let i = RandRange(seed, 0, 24);
            if i == 0 { return "Used vehicle - €$" + IntToString(RandRange(seed, 8000, 30000)); }
            if i == 1 { return "Cyberware upgrade - €$" + IntToString(RandRange(seed, 2000, 20000)); }
            if i == 2 { return "Electronics - €$" + IntToString(RandRange(seed, 300, 3000)); }
            if i == 3 { return "Furniture set - €$" + IntToString(RandRange(seed, 800, 6000)); }
            if i == 4 { return "Quality weapon - €$" + IntToString(RandRange(seed, 1000, 8000)); }
            if i == 5 { return "Apartment deposit - €$" + IntToString(RandRange(seed, 2000, 10000)); }
            if i == 6 { return "Medical procedure - €$" + IntToString(RandRange(seed, 1500, 12000)); }
            if i == 7 { return "Vacation (domestic) - €$" + IntToString(RandRange(seed, 500, 3000)); }
            if i == 8 { return "New clothes - €$" + IntToString(RandRange(seed, 200, 1500)); }
            if i == 9 { return "Gym equipment - €$" + IntToString(RandRange(seed, 300, 2000)); }
            if i == 10 { return "Tools/Equipment - €$" + IntToString(RandRange(seed, 500, 3000)); }
            if i == 11 { return "Education course - €$" + IntToString(RandRange(seed, 500, 5000)); }
            if i == 12 { return "Vehicle repair - €$" + IntToString(RandRange(seed, 500, 4000)); }
            if i == 13 { return "Home appliance - €$" + IntToString(RandRange(seed, 300, 2500)); }
            if i == 14 { return "Weapon accessories - €$" + IntToString(RandRange(seed, 200, 1500)); }
            if i == 15 { return "Entertainment system - €$" + IntToString(RandRange(seed, 500, 4000)); }
            if i == 16 { return "Personal device - €$" + IntToString(RandRange(seed, 400, 2000)); }
            if i == 17 { return "Motorcycle - €$" + IntToString(RandRange(seed, 3000, 15000)); }
            if i == 18 { return "Insurance payment - €$" + IntToString(RandRange(seed, 500, 3000)); }
            if i == 19 { return "Restaurant meals - €$" + IntToString(RandRange(seed, 100, 800)); }
            if i == 20 { return "Pet expenses - €$" + IntToString(RandRange(seed, 100, 500)); }
            if i == 21 { return "Hobby supplies - €$" + IntToString(RandRange(seed, 100, 1000)); }
            if i == 22 { return "Gift purchase - €$" + IntToString(RandRange(seed, 100, 1000)); }
            if i == 23 { return "Bar tab - €$" + IntToString(RandRange(seed, 50, 500)); }
            return "Subscription services - €$" + IntToString(RandRange(seed, 50, 300));
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "Food supplies - €$" + IntToString(RandRange(seed, 30, 250)); }
        if i == 1 { return "Basic clothing - €$" + IntToString(RandRange(seed, 20, 150)); }
        if i == 2 { return "Used electronics - €$" + IntToString(RandRange(seed, 30, 300)); }
        if i == 3 { return "Medication - €$" + IntToString(RandRange(seed, 20, 200)); }
        if i == 4 { return "Ammunition - €$" + IntToString(RandRange(seed, 30, 300)); }
        if i == 5 { return "Bus pass - €$" + IntToString(RandRange(seed, 20, 100)); }
        if i == 6 { return "Cheap booze - €$" + IntToString(RandRange(seed, 10, 80)); }
        if i == 7 { return "Street food - €$" + IntToString(RandRange(seed, 5, 50)); }
        if i == 8 { return "Prepaid phone - €$" + IntToString(RandRange(seed, 20, 100)); }
        if i == 9 { return "Used weapon - €$" + IntToString(RandRange(seed, 100, 800)); }
        if i == 10 { return "Rent payment - €$" + IntToString(RandRange(seed, 200, 800)); }
        if i == 11 { return "Utility bill - €$" + IntToString(RandRange(seed, 50, 200)); }
        if i == 12 { return "Cheap cyberware mod - €$" + IntToString(RandRange(seed, 100, 500)); }
        if i == 13 { return "Cigarettes - €$" + IntToString(RandRange(seed, 10, 50)); }
        if i == 14 { return "Energy drinks - €$" + IntToString(RandRange(seed, 5, 30)); }
        if i == 15 { return "Basic tools - €$" + IntToString(RandRange(seed, 20, 150)); }
        if i == 16 { return "Street drugs - €$" + IntToString(RandRange(seed, 20, 200)); }
        if i == 17 { return "Braindance chips - €$" + IntToString(RandRange(seed, 10, 100)); }
        if i == 18 { return "Second-hand clothes - €$" + IntToString(RandRange(seed, 10, 80)); }
        if i == 19 { return "Pawn shop item - €$" + IntToString(RandRange(seed, 20, 150)); }
        if i == 20 { return "Lottery tickets - €$" + IntToString(RandRange(seed, 5, 50)); }
        if i == 21 { return "Alcohol - €$" + IntToString(RandRange(seed, 10, 100)); }
        if i == 22 { return "Vending machine meals - €$" + IntToString(RandRange(seed, 5, 40)); }
        if i == 23 { return "Basic hygiene supplies - €$" + IntToString(RandRange(seed, 10, 50)); }
        return "Debt payment - €$" + IntToString(RandRange(seed, 50, 300));
    }

    private static func GenerateTaxStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "COMPLIANT"; }
            if i == 1 { return "COMPLIANT - Auto-Withheld"; }
            if i == 2 { return "COMPLIANT - Corporate Filing"; }
            if i == 3 { return "COMPLIANT - Itemized"; }
            if i == 4 { return "AUDIT PENDING"; }
            if i == 5 { return "UNDER INVESTIGATION"; }
            if i == 6 { return "OVERPAID - Refund Due"; }
            if i == 7 { return "EXTENSION FILED"; }
            if i == 8 { return "AMENDED RETURN"; }
            return "CORPORATE HANDLING";
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NO TAX OBLIGATION"; }
            if i == 1 { return "NON-FILER"; }
            if i == 2 { return "DELINQUENT"; }
            if i == 3 { return "BELOW THRESHOLD"; }
            if i == 4 { return "NO INCOME TO REPORT"; }
            return "STATUS UNKNOWN";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "COMPLIANT"; }
            if i == 1 { return "NON-FILER"; }
            if i == 2 { return "DELINQUENT"; }
            if i == 3 { return "UNREPORTED INCOME"; }
            if i == 4 { return "CASH ONLY - No Records"; }
            if i == 5 { return "FALSE RETURN FILED"; }
            if i == 6 { return "UNDER INVESTIGATION"; }
            return "STATUS UNKNOWN";
        }

        // General population (15 options)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "COMPLIANT"; }
        if i == 1 { return "COMPLIANT - Standard"; }
        if i == 2 { return "COMPLIANT - Auto-File"; }
        if i == 3 { return "MINOR DISCREPANCY"; }
        if i == 4 { return "DELINQUENT"; }
        if i == 5 { return "AUDIT PENDING"; }
        if i == 6 { return "PAYMENT PLAN ACTIVE"; }
        if i == 7 { return "LATE FILING PENALTY"; }
        if i == 8 { return "NON-FILER"; }
        if i == 9 { return "EXTENSION FILED"; }
        if i == 10 { return "REFUND PENDING"; }
        if i == 11 { return "AMENDED RETURN FILED"; }
        if i == 12 { return "DISPUTE IN PROGRESS"; }
        if i == 13 { return "COLLECTIONS ACTIVE"; }
        return "WAGE LEVY ACTIVE";
    }

    private static func HasBankruptcy(seed: Int32, archetype: String) -> Bool {
        let chance: Int32;
        
        if Equals(archetype, "CORPO_MANAGER") { chance = 5; }
        else if Equals(archetype, "YUPPIE") { chance = 10; }
        else if Equals(archetype, "CORPO_DRONE") { chance = 15; }
        else if Equals(archetype, "CIVVIE") { chance = 20; }
        else if Equals(archetype, "LOWLIFE") { chance = 40; }
        else if Equals(archetype, "JUNKIE") { chance = 50; }
        else if Equals(archetype, "HOMELESS") { chance = 60; }
        else { chance = 25; }

        return RandRange(seed, 1, 100) <= chance;
    }

    private static func IsCorporateAsset(seed: Int32, archetype: String, debtStatus: String) -> Bool {
        if StrContains(debtStatus, "Asset Seizure") || StrContains(debtStatus, "Enforcement") {
            return RandRange(seed, 1, 100) <= 50;
        }
        if Equals(archetype, "CORPO_DRONE") {
            return RandRange(seed, 1, 100) <= 15;
        }
        return false;
    }

    // Trauma Team coverage uses canonical 2077 tiers: Silver, Gold, Platinum
    // Clients can subscribe for as little as 24 hours
    private static func GenerateTraumaTeamCoverage(seed: Int32, archetype: String, wealth: Int32) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "PLATINUM - Corporate Plan"; }
            if i == 1 { return "PLATINUM - Annual"; }
            if i == 2 { return "PLATINUM - Family Plan"; }
            if i == 3 { return "GOLD - Corporate Plan"; }
            if i == 4 { return "PLATINUM - Executive Benefit"; }
            if i == 5 { return "GOLD - Annual"; }
            if i == 6 { return "PLATINUM - Employer Provided"; }
            return "GOLD - Employer Provided";
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "GOLD - Annual"; }
            if i == 1 { return "GOLD - Monthly"; }
            if i == 2 { return "PLATINUM - Annual"; }
            if i == 3 { return "SILVER - Annual"; }
            if i == 4 { return "GOLD - Family Plan"; }
            if i == 5 { return "SILVER - Monthly"; }
            if i == 6 { return "GOLD - Self-Employed"; }
            return "PLATINUM - Monthly";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "SILVER - Corporate Plan"; }
            if i == 1 { return "SILVER - Employer Provided"; }
            if i == 2 { return "GOLD - Corporate Plan"; }
            if i == 3 { return "SILVER - Monthly"; }
            if i == 4 { return "NONE"; }
            if i == 5 { return "SILVER - Annual"; }
            if i == 6 { return "GOLD - Employer Provided"; }
            return "SILVER - Subsidized";
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 3);
            if i == 0 { return "NONE"; }
            if i == 1 { return "EXPIRED"; }
            if i == 2 { return "LAPSED - Non-Payment"; }
            return "NONE - Never Subscribed";
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NONE"; }
            if i == 1 { return "EXPIRED"; }
            if i == 2 { return "LAPSED - Non-Payment"; }
            if i == 3 { return "SILVER - 24-Hour Plan (Occasional)"; }
            if i == 4 { return "NONE - Cannot Afford"; }
            return "SILVER - Lapsed";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NONE"; }
            if i == 1 { return "SILVER - Monthly"; }
            if i == 2 { return "EXPIRED"; }
            if i == 3 { return "SILVER - 24-Hour Plan (Occasional)"; }
            if i == 4 { return "GOLD - Monthly"; }
            return "NONE - Blacklisted";
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NONE"; }
            if i == 1 { return "NONE - Outside Service Area"; }
            if i == 2 { return "SILVER - 24-Hour Plan (Occasional)"; }
            if i == 3 { return "EXPIRED"; }
            if i == 4 { return "NONE - Clan Medics Only"; }
            return "SILVER - Monthly";
        }
        
        // General population - based on wealth
        if wealth >= 100000 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "GOLD - Annual"; }
            if i == 1 { return "GOLD - Monthly"; }
            if i == 2 { return "SILVER - Annual"; }
            if i == 3 { return "PLATINUM - Monthly"; }
            if i == 4 { return "GOLD - Family Plan"; }
            return "SILVER - Monthly";
        }
        
        if wealth >= 25000 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "SILVER - Monthly"; }
            if i == 1 { return "SILVER - Annual"; }
            if i == 2 { return "NONE"; }
            if i == 3 { return "SILVER - 24-Hour Plan (Occasional)"; }
            if i == 4 { return "GOLD - Monthly"; }
            return "EXPIRED";
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "NONE"; }
        if i == 1 { return "EXPIRED"; }
        if i == 2 { return "LAPSED - Non-Payment"; }
        if i == 3 { return "SILVER - 24-Hour Plan (Occasional)"; }
        if i == 4 { return "NONE - Cannot Afford"; }
        if i == 5 { return "SILVER - Lapsed"; }
        if i == 6 { return "NONE - Never Subscribed"; }
        return "EXPIRED - Seeking Renewal";
    }

    private static func GenerateHealthInsurance(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "ARASAKA PREMIUM HEALTH"; }
            if i == 1 { return "MILITECH EXECUTIVE CARE"; }
            if i == 2 { return "CORPORATE PLATINUM PLAN"; }
            if i == 3 { return "ZETATECH COMPREHENSIVE"; }
            if i == 4 { return "KANG TAO ELITE CARE"; }
            if i == 5 { return "BIOTECHNICA WELLNESS PLUS"; }
            if i == 6 { return "EXECUTIVE CONCIERGE MEDICAL"; }
            return "UNLIMITED CORPORATE CARE";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "CORPORATE BASIC PLAN"; }
            if i == 1 { return "EMPLOYEE STANDARD CARE"; }
            if i == 2 { return "CORPORATE GROUP HEALTH"; }
            if i == 3 { return "COMPANY HMO"; }
            if i == 4 { return "CORPORATE PPO"; }
            if i == 5 { return "EMPLOYEE BRONZE TIER"; }
            if i == 6 { return "SUBSIDIZED EMPLOYER PLAN"; }
            return "BASIC CORPORATE COVERAGE";
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "PRIVATE HEALTH PLAN"; }
            if i == 1 { return "PREMIUM INDIVIDUAL"; }
            if i == 2 { return "COMPREHENSIVE PRIVATE"; }
            if i == 3 { return "HIGH-END PPO"; }
            if i == 4 { return "BOUTIQUE MEDICAL"; }
            if i == 5 { return "EXECUTIVE HEALTH PLAN"; }
            if i == 6 { return "PRIVATE PRACTICE NETWORK"; }
            return "PREMIUM FAMILY CARE";
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "UNINSURED"; }
            if i == 1 { return "EMERGENCY ROOM ONLY"; }
            if i == 2 { return "CHARITY CARE"; }
            if i == 3 { return "FREE CLINIC ONLY"; }
            return "LAPSED - Uninsured";
        }
        
        // General population (20 options)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return "NC PUBLIC HEALTH"; }
        if i == 1 { return "BASIC COVERAGE"; }
        if i == 2 { return "MINIMAL COVERAGE"; }
        if i == 3 { return "UNINSURED"; }
        if i == 4 { return "NC MEDICAID"; }
        if i == 5 { return "LOW-COST COMMUNITY PLAN"; }
        if i == 6 { return "CATASTROPHIC ONLY"; }
        if i == 7 { return "HIGH-DEDUCTIBLE PLAN"; }
        if i == 8 { return "MARKETPLACE BRONZE"; }
        if i == 9 { return "MARKETPLACE SILVER"; }
        if i == 10 { return "EMPLOYER BASIC"; }
        if i == 11 { return "UNION HEALTH PLAN"; }
        if i == 12 { return "GIG WORKER COLLECTIVE"; }
        if i == 13 { return "RIPPERDOC MEMBERSHIP"; }
        if i == 14 { return "CLINIC SUBSCRIPTION"; }
        if i == 15 { return "EXPIRED - Seeking Coverage"; }
        if i == 16 { return "COBRA CONTINUATION"; }
        if i == 17 { return "SPOUSE'S PLAN"; }
        if i == 18 { return "PARENT'S PLAN"; }
        return "PENDING ENROLLMENT";
    }

    private static func GenerateBankAffiliation(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Arasaka Financial"; }
            if i == 1 { return "Militech Banking"; }
            if i == 2 { return "Kang Tao Financial"; }
            if i == 3 { return "Zetatech Credit Union"; }
            if i == 4 { return "Corporate Employee Bank"; }
            if i == 5 { return "Biotechnica Banking"; }
            if i == 6 { return "Petrochem Financial Services"; }
            if i == 7 { return "EuroBank (Corporate)"; }
            if i == 8 { return "Executive Banking Services"; }
            return "SovOil Financial";
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "No Bank Account (Cash Only)"; }
            if i == 1 { return "UNBANKED"; }
            if i == 2 { return "Account Closed - Collections"; }
            if i == 3 { return "Prepaid Card Only"; }
            return "Check Cashing Services Only";
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return "No Bank Account (Cash Only)"; }
            if i == 1 { return "Prepaid Card Only"; }
            if i == 2 { return "Watson Community Bank"; }
            if i == 3 { return "Night City Savings"; }
            if i == 4 { return "Crypto Wallet Only"; }
            if i == 5 { return "Multiple Aliases"; }
            if i == 6 { return "Offshore Account"; }
            return "Cash Only - No Records";
        }
        
        // General population (25 options)
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "EuroBank"; }
        if i == 1 { return "Night City Savings"; }
        if i == 2 { return "Pacific Credit Union"; }
        if i == 3 { return "Watson Community Bank"; }
        if i == 4 { return "Digital First Bank"; }
        if i == 5 { return "Heywood Savings & Loan"; }
        if i == 6 { return "Santo Domingo Credit Union"; }
        if i == 7 { return "Westbrook Financial"; }
        if i == 8 { return "NC Municipal Bank"; }
        if i == 9 { return "People's Bank of NC"; }
        if i == 10 { return "Online Bank (App Only)"; }
        if i == 11 { return "Neo-Banking Platform"; }
        if i == 12 { return "Crypto Exchange Account"; }
        if i == 13 { return "Badlands Federal"; }
        if i == 14 { return "Immigrant Services Bank"; }
        if i == 15 { return "Veterans Credit Union"; }
        if i == 16 { return "Workers Solidarity Bank"; }
        if i == 17 { return "No Bank Account (Cash Only)"; }
        if i == 18 { return "Prepaid Card Account"; }
        if i == 19 { return "Check Cashing Services"; }
        if i == 20 { return "Family Member's Account"; }
        if i == 21 { return "Joint Account"; }
        if i == 22 { return "Basic Checking Only"; }
        if i == 23 { return "Savings Account Only"; }
        return "Multiple Accounts";
    }

    private static func GenerateAccountStatus(seed: Int32, creditScore: Int32) -> String {
        if creditScore >= 750 {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "ACTIVE - EXCELLENT STANDING"; }
            if i == 1 { return "ACTIVE - PREMIUM MEMBER"; }
            if i == 2 { return "ACTIVE - PREFERRED CLIENT"; }
            if i == 3 { return "ACTIVE - VIP STATUS"; }
            return "ACTIVE - LONG-STANDING MEMBER";
        }
        
        if creditScore >= 650 {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "ACTIVE - GOOD STANDING"; }
            if i == 1 { return "ACTIVE - STANDARD MEMBER"; }
            if i == 2 { return "ACTIVE - REGULAR STATUS"; }
            if i == 3 { return "ACTIVE - SATISFACTORY"; }
            return "ACTIVE - NORMAL";
        }
        
        if creditScore >= 500 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "ACTIVE - FAIR STANDING"; }
            if i == 1 { return "ACTIVE - UNDER REVIEW"; }
            if i == 2 { return "ACTIVE - LIMITED SERVICES"; }
            if i == 3 { return "ACTIVE - OVERDRAFT WARNING"; }
            if i == 4 { return "ACTIVE - MONITORING"; }
            return "PROBATIONARY";
        }
        
        if creditScore >= 350 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "RESTRICTED"; }
            if i == 1 { return "RESTRICTED - DEPOSITS ONLY"; }
            if i == 2 { return "RESTRICTED - NO OVERDRAFT"; }
            if i == 3 { return "SUSPENDED - PENDING REVIEW"; }
            if i == 4 { return "LIMITED ACCESS"; }
            return "PROBATION - FINAL WARNING";
        }
        
        // Very poor credit (10 options)
        let i = RandRange(seed, 0, 9);
        if i == 0 { return "FROZEN"; }
        if i == 1 { return "CLOSED - COLLECTIONS"; }
        if i == 2 { return "CLOSED - NEGATIVE BALANCE"; }
        if i == 3 { return "CLOSED - FRAUD SUSPECTED"; }
        if i == 4 { return "ACCOUNT SEIZED"; }
        if i == 5 { return "LEVIED BY CREDITOR"; }
        if i == 6 { return "BLACKLISTED"; }
        if i == 7 { return "NO ACCOUNT"; }
        if i == 8 { return "PENDING CLOSURE"; }
        return "TERMINATED";
    }

    private static func GenerateNCID(seed: Int32, archetype: String) -> String {
        // Homeless / Junkie - often lost, expired, or never had ID
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "UNREGISTERED"; }
            if i == 1 { return "EXPIRED"; }
            if i == 2 { return "REVOKED"; }
            if i == 3 { return "LOST/MISSING"; }
            // Some still have one
            return "NC" + IntToString(RandRange(seed + 1, 100000, 999999));
        }

        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 6);
            if i == 0 { return "SUSPENDED"; }
            if i == 1 { return "EXPIRED"; }
            // Most still have one
            return "NC" + IntToString(RandRange(seed + 1, 100000, 999999));
        }

        // Nomads - different system or no NC registration
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NO NC REGISTRATION"; }
            if i == 1 { return "CLAN ID ONLY"; }
            if i == 2 { return "TEMPORARY PASS"; }
            // Some registered in the city
            return "NC" + IntToString(RandRange(seed + 1, 100000, 999999));
        }

        // Everyone else gets a standard NC ID
        return "NC" + IntToString(RandRange(seed + 1, 100000, 999999));
    }
}

public class KdspFinancialProfileData {
    public let creditScore: Int32;
    public let creditTier: String;
    public let estimatedWealth: Int32;
    public let wealthTier: String;
    public let hasDebt: Bool;
    public let debtAmount: Int32;
    public let debtHolder: String;
    public let debtStatus: String;
    public let propertyStatus: String;
    public let residenceType: String;
    public let residenceDistrict: String;
    public let employmentStatus: String;
    public let employer: String;
    public let incomeLevel: String;
    public let recentPurchases: array<String>;
    public let taxStatus: String;
    public let bankruptcyHistory: Bool;
    public let corporateAsset: Bool;
    public let traumaTeamCoverage: String;
    public let healthInsurance: String;
    public let bankAffiliation: String;
    public let accountStatus: String;
    public let ncID: String;
}
