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
        let isCorpo = Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE");
        let isHighStatus = isCorpo || Equals(archetype, "YUPPIE");
        
        if IsDefined(coherence) {
            // High-status archetypes have institutional support - theme penalties are reduced
            if isHighStatus {
                if Equals(coherence.lifeTheme, "FALLING") { score -= RandRange(seed + 5, 20, 60); }
                if Equals(coherence.lifeTheme, "STRUGGLING") { score -= RandRange(seed + 6, 10, 40); }
                if Equals(coherence.lifeTheme, "CLIMBING") { score += RandRange(seed + 7, 20, 60); }
                if Equals(coherence.lifeTheme, "STABLE") { score += RandRange(seed + 8, 30, 80); }
                if coherence.hasSubstanceIssues { score -= RandRange(seed + 10, 15, 40); }
            } else {
                if Equals(coherence.lifeTheme, "FALLING") { score -= RandRange(seed + 5, 50, 150); }
                if Equals(coherence.lifeTheme, "STRUGGLING") { score -= RandRange(seed + 6, 30, 80); }
                if Equals(coherence.lifeTheme, "CLIMBING") { score += RandRange(seed + 7, 20, 60); }
                if Equals(coherence.lifeTheme, "STABLE") { score += RandRange(seed + 8, 30, 80); }
                if coherence.hasSubstanceIssues { score -= RandRange(seed + 10, 30, 80); }
            }
            if coherence.isInDebt { score -= RandRange(seed + 9, 20, 60); }
        }
        
        if score < 100 { score = 100; }
        if score > 850 { score = 850; }
        return score;
    }

    // Wealth influenced by life theme
    private static func GenerateWealthCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let wealth = KdspFinancialProfileManager.GenerateWealth(seed, archetype);
        let isHighStatus = Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") || Equals(archetype, "YUPPIE");
        
        if IsDefined(coherence) {
            if isHighStatus {
                // High-status archetypes - FALLING means losing grip, not poverty
                if Equals(coherence.lifeTheme, "FALLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.75); }
                if Equals(coherence.lifeTheme, "STRUGGLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.85); }
            } else {
                if Equals(coherence.lifeTheme, "FALLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.5); }
                if Equals(coherence.lifeTheme, "STRUGGLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.7); }
            }
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
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S0"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S1"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S2"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S3"));
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
            if Equals(coherence.debtReason, "cyberware loans") {
                let holders: array<String>;
                ArrayPush(holders, "Ripperdoc Financing");
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S4"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S5"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S6"));
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
            if Equals(coherence.debtReason, "gambling") {
                let holders: array<String>;
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S7"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S8"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S9"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S10"));
                return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
            }
            if Equals(coherence.debtReason, "substance habit") {
                let holders: array<String>;
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S11"));
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

        // Corpo archetypes: FALLING means in trouble, not unemployed
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            if IsDefined(coherence) && Equals(coherence.lifeTheme, "FALLING") {
                let statuses: array<String>;
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S12"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S13"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S14"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S15"));
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
            if IsDefined(coherence) && Equals(coherence.jobHistory, "corpo") { return "Corporate employee"; }
            return "Corporate employee";
        }

        // Yuppie archetype: FALLING means struggling professionally, not destitute
        if Equals(archetype, "YUPPIE") {
            if IsDefined(coherence) && Equals(coherence.lifeTheme, "FALLING") {
                let statuses: array<String>;
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S16"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S17"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S18"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S19"));
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
            if IsDefined(coherence) && Equals(coherence.lifeTheme, "STRUGGLING") {
                let statuses: array<String>;
                ArrayPush(statuses, "Self-employed (Overextended)");
                ArrayPush(statuses, "Full-time (Stagnant)");
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S20"));
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
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
    // Corpo archetypes always use their own income tables - coherence themes cannot deflate them to poverty
    private static func GenerateIncomeLevelCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        // Poor archetypes: always use archetype-specific income, never coherence overrides
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") || Equals(archetype, "LOWLIFE") {
            return KdspFinancialProfileManager.GenerateIncomeLevel(seed, archetype);
        }

        // Corpo archetypes: FALLING theme reduces income but keeps it corpo-appropriate
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            if IsDefined(coherence) && Equals(coherence.lifeTheme, "FALLING") {
                if Equals(archetype, "CORPO_MANAGER") {
                    let levels: array<String>;
                    ArrayPush(levels, "€$80,000-120,000/year (Demoted)");
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S21"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S22"));
                    return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
                } else {
                    let levels: array<String>;
                    ArrayPush(levels, "€$25,000-40,000/year (Demoted)");
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S23"));
                    ArrayPush(levels, "€$20,000-35,000/year (Probation)");
                    return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
                }
            }
            return KdspFinancialProfileManager.GenerateIncomeLevel(seed, archetype);
        }

        // Yuppie archetype: FALLING means financial trouble, not poverty
        if Equals(archetype, "YUPPIE") {
            if IsDefined(coherence) {
                if Equals(coherence.lifeTheme, "FALLING") {
                    let levels: array<String>;
                    ArrayPush(levels, "€$50,000-80,000/year (Declining)");
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S24"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S25"));
                    return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
                }
                if Equals(coherence.lifeTheme, "STRUGGLING") {
                    let levels: array<String>;
                    ArrayPush(levels, "€$70,000-100,000/year (Overextended)");
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S26"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S27"));
                    return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
                }
            }
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S28"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S29"); }
            if i == 2 { return "EuroBank"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S30"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S31"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S32"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S33"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S34"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S35"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S36"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S37"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S38"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S39"); }
            if i == 13 { return "SovOil Credit"; }
            if i == 14 { return "IEC Financial"; }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S40"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S41"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S42"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S43"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S44"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S45"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S46"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S47"); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S48"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S49");
        }
        
        // Gang/Criminal debt holders
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S50"); }
            if i == 1 { return "Valentinos (informal)"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S51"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S52"); }
            if i == 4 { return "Animals Collections"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S53"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S54"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S55"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S56"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S57"); }
            if i == 10 { return "Drug Supplier"; }
            if i == 11 { return "Weapons Dealer"; }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S58"); }
            if i == 13 { return "Underground Casino"; }
            return "Territory Boss";
        }
        
        // General population debt holders (40 options)
        let i = RandRange(seed, 0, 39);
        
        // Corporate/Legitimate (0-19)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S28"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S29"); }
        if i == 2 { return "EuroBank"; }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S59"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S30"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S31"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S36"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-Corpo-NC_HOUSING"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S60"); }
        if i == 9 { return "Ripperdoc Financing"; }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S61"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S62"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S63"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S64"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S65"); }
        if i == 15 { return "Westbrook Lending"; }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S66"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S67"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S68"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S69"); }
        
        // Semi-legitimate (20-29)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S70"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S71"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S72"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S73"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S74"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S75"); }
        if i == 26 { return "Rent-to-Own Collections"; }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S76"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S77"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S78"); }
        
        // Shady/Criminal (30-39)
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S79"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S50"); }
        if i == 32 { return "Valentinos (informal)"; }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S51"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S56"); }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S52"); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S57"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S80"); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S81"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S82");
    }

    private static func GenerateDebtStatus(seed: Int32, creditScore: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if creditScore >= 650 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S83"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S84"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S85"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S86"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S87"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S88"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S89"); }
            if i == 7 { return "Under Review"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S90"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S91");
        }
        
        if creditScore >= 450 {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S83"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S86"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S92"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S89"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S93"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S94"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S95"); }
            if i == 7 { return "Hardship Deferment"; }
            if i == 8 { return "In Collections"; }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S96"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S97"); }
            if i == 11 { return "Settlement Offered"; }
            if i == 12 { return "Dispute Filed"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S98"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S99");
        }
        
        // Poor credit - bad status options (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S86"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S100"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S101"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S102"); }
        if i == 4 { return "In Collections"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S103"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S97"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S104"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S105"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S106"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S107"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S108"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S109"); }
        if i == 13 { return "Liens Filed"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S110"); }
        if i == 15 { return "Bankruptcy Recommended"; }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S111"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S112"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S113"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S114");
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
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S115"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S116"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S117"); }
            if i == 5 { return "Skyrise Condo"; }
            if i == 6 { return "Private Villa"; }
            if i == 7 { return "Secured Compound"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S118"); }
            if i == 9 { return "Waterfront Property"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S119"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S120"); }
            if i == 12 { return "Designer Apartment"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S121"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S122");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S123"); }
            if i == 1 { return "Mid-Rise Apartment"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S124"); }
            if i == 3 { return "Company Dormitory"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S125"); }
            if i == 5 { return "Efficiency Apartment"; }
            if i == 6 { return "Corporate Barracks"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S126"); }
            if i == 8 { return "Commuter Pod"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S127");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Mobile Home/Vehicle"; }
            if i == 1 { return "Camp Dwelling"; }
            if i == 2 { return "Nomad Settlement"; }
            if i == 3 { return "Badlands Compound"; }
            if i == 4 { return "Converted RV"; }
            if i == 5 { return "Tent/Temporary Shelter"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S128"); }
            if i == 7 { return "Caravan Trailer"; }
            if i == 8 { return "Desert Shack"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S129");
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
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S130"); }
            if i == 3 { return "Warehouse Conversion"; }
            if i == 4 { return "Clubhouse Quarters"; }
            if i == 5 { return "Fortified Apartment"; }
            if i == 6 { return "Territory Stronghold"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S131"); }
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
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S132"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S133"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S134"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S135"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S136"); }
        if i == 10 { return "Modular Apartment"; }
        if i == 11 { return "Row House"; }
        if i == 12 { return "Tenement Building"; }
        if i == 13 { return "Mixed-Use Building"; }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S137");
    }

    private static func GenerateResidenceDistrict(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S138"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S139"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S140"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S141"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S142"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S143"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S144"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S145"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S146"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S147");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S142"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S148"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S149"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S150"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S151"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S152"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S153"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S154"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S141"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S155");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S156"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S157"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S158"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S159"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S160"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S161"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S162"); }
            if i == 7 { return "Jackson Plains"; }
            if i == 8 { return "Aldecaldo Camp"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S163");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S164"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S165"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S166"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S167"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S154"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S149"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S148"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S168"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S151"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S150"); }
            if i == 10 { return "Dogtown"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S169"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S170"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S171"); }
            return "Valentino Territory";
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S172"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S168"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S151"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S154"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S173"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S174"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S175"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S176"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S177"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S178");
        }
        
        // General population (20 options)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S148"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S164"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S151"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S150"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S149"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S165"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S141"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S154"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S166"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S142"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S179"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S140"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S152"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S180"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S181"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S182"); }
        if i == 16 { return "Dogtown"; }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S168"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S183"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S184");
    }

    private static func GenerateEmploymentStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { 
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S185"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S186"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S187"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S188"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S189");
        }
        if Equals(archetype, "CORPO_DRONE") { 
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S190"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S191"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S192"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S193"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S194");
        }
        if Equals(archetype, "HOMELESS") { 
            let i = RandRange(seed, 0, 4);
            if i == 0 { return "UNEMPLOYED"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S195"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S196"); }
            if i == 3 { return "PANHANDLING"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S197");
        }
        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 6);
            if i == 0 { return "UNEMPLOYED"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S198"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S199"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S200"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S201"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S202"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S203");
        }
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S199"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S204"); }
            if i == 2 { return "GANG OPERATIONS"; }
            if i == 3 { return "CRIMINAL ENTERPRISE"; }
            if i == 4 { return "PROTECTION SERVICES"; }
            if i == 5 { return "DISTRIBUTION NETWORK"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S205"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S206"); }
            if i == 8 { return "TERRITORY MANAGEMENT"; }
            return "COLLECTION SERVICES";
        }
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S207"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S208"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S209"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S210"); }
            if i == 4 { return "CLAN BUSINESS"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S211"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S212"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S213"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S214"); }
            return "CLAN SUPPORT ROLE";
        }
        
        // General population (25 options)
        let i = RandRange(seed, 0, 24);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S215"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S216"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S217"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S218"); }
        if i == 4 { return "SELF-EMPLOYED"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S219"); }
        if i == 6 { return "UNEMPLOYED"; }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S199"); }
        if i == 8 { return "RETIRED"; }
        if i == 9 { return "DISABLED"; }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S220"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S221"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S222"); }
        if i == 13 { return "FREELANCE"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S223"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S224"); }
        if i == 16 { return "FURLOUGHED"; }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S225"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S226"); }
        if i == 19 { return "STUDENT"; }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S227"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S228"); }
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
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-Corpo-TTI"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S229"); }
            if i == 9 { return "NCART"; }
            if i == 10 { return "SovOil"; }
            if i == 11 { return "IEC"; }
            if i == 12 { return "Continental Brands"; }
            if i == 13 { return "All Foods"; }
            if i == 14 { return "Orbital Air"; }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-Corpo-NN54"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-Corpo-WORLD_NEWS"); }
            if i == 17 { return "Dynalar Technologies"; }
            if i == 18 { return "Raven Microcybernetics"; }
            if i == 19 { return "EuroBank"; }
            if i == 20 { return "Kendachi"; }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-Corpo-TDS"); }
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
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S230"); }
            if i == 9 { return "Tech Startup"; }
            if i == 10 { return "Entertainment Industry"; }
            if i == 11 { return "Investment Banking"; }
            if i == 12 { return "Cybersecurity Firm"; }
            if i == 13 { return "Biotech Startup"; }
            return "Venture Capital";
        }
        
        // General population (40 options)
        let i = RandRange(seed, 0, 39);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S231"); }
        if i == 1 { return "Local Business"; }
        if i == 2 { return "Self-Employed"; }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S232"); }
        if i == 4 { return "Food Service"; }
        if i == 5 { return "Retail"; }
        if i == 6 { return "Construction"; }
        if i == 7 { return "Sanitation"; }
        if i == 8 { return "Security (Contract)"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S233"); }
        if i == 10 { return "Delivery Services"; }
        if i == 11 { return "Rideshare Driver"; }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S234"); }
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
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S235"); }
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
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S236"); }
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
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S237"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S238"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S239"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S240"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S241");
        }
        if Equals(archetype, "CORPO_DRONE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$45,000-60,000/year"; }
            if i == 1 { return "€$60,000-80,000/year"; }
            if i == 2 { return "€$80,000-100,000/year"; }
            if i == 3 { return "€$100,000-120,000/year"; }
            if i == 4 { return "€$35,000-50,000/year"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S242"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S243"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S244"); }
            if i == 8 { return "€$90,000/year (Senior)"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S245");
        }
        if Equals(archetype, "YUPPIE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$80,000-120,000/year"; }
            if i == 1 { return "€$120,000-180,000/year"; }
            if i == 2 { return "€$180,000-250,000/year"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S246"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S247"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S248"); }
            if i == 6 { return "€$90,000/year (Associate)"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S249"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S250"); }
            return "€$250,000+/year (Partner)";
        }
        if Equals(archetype, "CIVVIE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$15,000-25,000/year"; }
            if i == 1 { return "€$25,000-35,000/year"; }
            if i == 2 { return "€$35,000-45,000/year"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S251"); }
            if i == 4 { return "€$30,000/year (Hourly)"; }
            if i == 5 { return "€$18,000/year (Part-time)"; }
            if i == 6 { return "€$40,000/year (Skilled)"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S252"); }
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
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S253"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S254"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S255"); }
            if i == 8 { return "€$6,000/year (Unreported)"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S256");
        }
        if Equals(archetype, "GANGER") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$10,000-25,000/year (Est.)"; }
            if i == 1 { return "€$25,000-50,000/year (Est.)"; }
            if i == 2 { return "€$50,000-100,000/year (Est.)"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S257"); }
            if i == 4 { return "€$40,000/year (Enforcer)"; }
            if i == 5 { return "€$75,000/year (Lieutenant)"; }
            if i == 6 { return "€$20,000/year (Soldier)"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S258"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S259"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S260");
        }
        if Equals(archetype, "JUNKIE") { 
            let i = RandRange(seed, 0, 6);
            if i == 0 { return "< €$5,000/year"; }
            if i == 1 { return "€$0-2,000/year"; }
            if i == 2 { return "€$2,000-5,000/year"; }
            if i == 3 { return "NO STABLE INCOME"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S261"); }
            if i == 5 { return "€$1,000/year (Panhandling)"; }
            return "SURVIVAL INCOME ONLY";
        }
        if Equals(archetype, "HOMELESS") { 
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NO INCOME"; }
            if i == 1 { return "€$0-500/year (Panhandling)"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S262"); }
            if i == 3 { return "€$0-1,000/year (Scavenging)"; }
            if i == 4 { return "NO DOCUMENTED INCOME"; }
            return "SUBSISTENCE ONLY";
        }
        if Equals(archetype, "NOMAD") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "€$8,000-15,000/year (Est.)"; }
            if i == 1 { return "€$15,000-25,000/year (Est.)"; }
            if i == 2 { return "€$25,000-40,000/year (Est.)"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S263"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S264"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S265"); }
            if i == 6 { return "€$30,000/year (Smuggling)"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S266"); }
            if i == 8 { return "€$18,000/year (Mechanic)"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S267");
        }
        
        // Default
        let i = RandRange(seed, 0, 9);
        if i == 0 { return "€$20,000-30,000/year"; }
        if i == 1 { return "€$30,000-40,000/year"; }
        if i == 2 { return "€$15,000-25,000/year"; }
        if i == 3 { return "€$25,000/year (Average)"; }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S268"); }
        if i == 5 { return "€$22,000/year (Entry)"; }
        if i == 6 { return "€$28,000/year (Experienced)"; }
        if i == 7 { return "€$18,000/year (Part-time)"; }
        if i == 8 { return "€$32,000/year (Skilled)"; }
        return "€$24,000/year (Median)";
    }

    private static func GeneratePurchase(seed: Int32, archetype: String, wealth: Int32) -> String {
        if wealth >= 100000 {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S269") + IntToString(RandRange(seed, 80000, 250000)); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S270") + IntToString(RandRange(seed, 25000, 100000)); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S271") + IntToString(RandRange(seed, 15000, 75000)); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S272") + IntToString(RandRange(seed, 150000, 750000)); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S273") + IntToString(RandRange(seed, 10000, 100000)); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S274") + IntToString(RandRange(seed, 15000, 50000)); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S275") + IntToString(RandRange(seed, 5000, 25000)); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S276") + IntToString(RandRange(seed, 3000, 15000)); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S277") + IntToString(RandRange(seed, 2000, 8000)); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S278") + IntToString(RandRange(seed, 10000, 50000)); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S279") + IntToString(RandRange(seed, 5000, 25000)); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S280") + IntToString(RandRange(seed, 3000, 20000)); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S281") + IntToString(RandRange(seed, 8000, 40000)); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S282") + IntToString(RandRange(seed, 5000, 30000)); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S283") + IntToString(RandRange(seed, 10000, 75000)); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S284") + IntToString(RandRange(seed, 25000, 150000)); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S285") + IntToString(RandRange(seed, 5000, 50000)); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S286") + IntToString(RandRange(seed, 3000, 15000)); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S287") + IntToString(RandRange(seed, 5000, 20000)); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S288") + IntToString(RandRange(seed, 2000, 25000));
        }
        
        if wealth >= 20000 {
            let i = RandRange(seed, 0, 24);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S289") + IntToString(RandRange(seed, 8000, 30000)); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S290") + IntToString(RandRange(seed, 2000, 20000)); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S291") + IntToString(RandRange(seed, 300, 3000)); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S292") + IntToString(RandRange(seed, 800, 6000)); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S293") + IntToString(RandRange(seed, 1000, 8000)); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S294") + IntToString(RandRange(seed, 2000, 10000)); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S295") + IntToString(RandRange(seed, 1500, 12000)); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S296") + IntToString(RandRange(seed, 500, 3000)); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S297") + IntToString(RandRange(seed, 200, 1500)); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S298") + IntToString(RandRange(seed, 300, 2000)); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S299") + IntToString(RandRange(seed, 500, 3000)); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S300") + IntToString(RandRange(seed, 500, 5000)); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S301") + IntToString(RandRange(seed, 500, 4000)); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S302") + IntToString(RandRange(seed, 300, 2500)); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S303") + IntToString(RandRange(seed, 200, 1500)); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S304") + IntToString(RandRange(seed, 500, 4000)); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S305") + IntToString(RandRange(seed, 400, 2000)); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S306") + IntToString(RandRange(seed, 3000, 15000)); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S307") + IntToString(RandRange(seed, 500, 3000)); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S308") + IntToString(RandRange(seed, 100, 800)); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S309") + IntToString(RandRange(seed, 100, 500)); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S310") + IntToString(RandRange(seed, 100, 1000)); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S311") + IntToString(RandRange(seed, 100, 1000)); }
            if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S312") + IntToString(RandRange(seed, 50, 500)); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S313") + IntToString(RandRange(seed, 50, 300));
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 24);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S314") + IntToString(RandRange(seed, 30, 250)); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S315") + IntToString(RandRange(seed, 20, 150)); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S316") + IntToString(RandRange(seed, 30, 300)); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S317") + IntToString(RandRange(seed, 20, 200)); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S318") + IntToString(RandRange(seed, 30, 300)); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S319") + IntToString(RandRange(seed, 20, 100)); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S320") + IntToString(RandRange(seed, 10, 80)); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S321") + IntToString(RandRange(seed, 5, 50)); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S322") + IntToString(RandRange(seed, 20, 100)); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S323") + IntToString(RandRange(seed, 100, 800)); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S324") + IntToString(RandRange(seed, 200, 800)); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S325") + IntToString(RandRange(seed, 50, 200)); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S326") + IntToString(RandRange(seed, 100, 500)); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S327") + IntToString(RandRange(seed, 10, 50)); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S328") + IntToString(RandRange(seed, 5, 30)); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S329") + IntToString(RandRange(seed, 20, 150)); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S330") + IntToString(RandRange(seed, 20, 200)); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S331") + IntToString(RandRange(seed, 10, 100)); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S332") + IntToString(RandRange(seed, 10, 80)); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S333") + IntToString(RandRange(seed, 20, 150)); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S334") + IntToString(RandRange(seed, 5, 50)); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S335") + IntToString(RandRange(seed, 10, 100)); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S336") + IntToString(RandRange(seed, 5, 40)); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S337") + IntToString(RandRange(seed, 10, 50)); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S338") + IntToString(RandRange(seed, 50, 300));
    }

    private static func GenerateTaxStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "COMPLIANT"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S339"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S340"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S341"); }
            if i == 4 { return "AUDIT PENDING"; }
            if i == 5 { return "UNDER INVESTIGATION"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S342"); }
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
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S343"); }
            if i == 5 { return "FALSE RETURN FILED"; }
            if i == 6 { return "UNDER INVESTIGATION"; }
            return "STATUS UNKNOWN";
        }

        // General population (15 options)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "COMPLIANT"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S344"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S345"); }
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S346"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S347"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S348"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S349"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S350"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S351"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S352"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S353");
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S351"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S354"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S347"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S355"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S356"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S357"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S358"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S359");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S360"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S361"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S349"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S357"); }
            if i == 4 { return "NONE"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S355"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S353"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S362");
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 3);
            if i == 0 { return "NONE"; }
            if i == 1 { return "EXPIRED"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S363"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S364");
        }
        
        if Equals(archetype, "LOWLIFE") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NONE"; }
            if i == 1 { return "EXPIRED"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S363"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S365"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S366"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S367");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NONE"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S357"); }
            if i == 2 { return "EXPIRED"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S365"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S354"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S368");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return "NONE"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S369"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S365"); }
            if i == 3 { return "EXPIRED"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S370"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S357");
        }
        
        // General population - based on wealth
        if wealth >= 100000 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S351"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S354"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S355"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S359"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S356"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S357");
        }
        
        if wealth >= 25000 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S357"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S355"); }
            if i == 2 { return "NONE"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S365"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S354"); }
            return "EXPIRED";
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 7);
        if i == 0 { return "NONE"; }
        if i == 1 { return "EXPIRED"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S363"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S365"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S366"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S367"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S364"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S371");
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
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S372");
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
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S373"); }
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
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S33"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S374"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S375"); }
            if i == 5 { return "Biotechnica Banking"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S376"); }
            if i == 7 { return "EuroBank (Corporate)"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S377"); }
            return "SovOil Financial";
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S378"); }
            if i == 1 { return "UNBANKED"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S379"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S380"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S381");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S378"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S380"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S63"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S382"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S383"); }
            if i == 5 { return "Multiple Aliases"; }
            if i == 6 { return "Offshore Account"; }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S384");
        }
        
        // General population (25 options)
        let i = RandRange(seed, 0, 24);
        if i == 0 { return "EuroBank"; }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S382"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S62"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S63"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S385"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S386"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S387"); }
        if i == 7 { return "Westbrook Financial"; }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S388"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S389"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S390"); }
        if i == 11 { return "Neo-Banking Platform"; }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S391"); }
        if i == 13 { return "Badlands Federal"; }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S392"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S393"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S394"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S378"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S395"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S396"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S397"); }
        if i == 21 { return "Joint Account"; }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S398"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S399"); }
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
