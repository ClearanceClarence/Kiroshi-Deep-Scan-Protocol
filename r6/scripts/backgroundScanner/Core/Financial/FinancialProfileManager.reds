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
            if Equals(coherence.debtReason, GetLocalizedTextByKey(n"Kdsp-Shared-C15")) { base = RandRange(seed, 5000, 80000); }
            if Equals(coherence.debtReason, "gambling") { base = RandRange(seed, 2000, 100000); }
            if Equals(coherence.debtReason, GetLocalizedTextByKey(n"Kdsp-Shared-C19")) { base = RandRange(seed, 20000, 200000); }
            if Equals(coherence.debtReason, GetLocalizedTextByKey(n"Kdsp-Shared-C18")) { base = RandRange(seed, 3000, 50000); }
            if Equals(coherence.debtReason, GetLocalizedTextByKey(n"Kdsp-Shared-C16")) { base = RandRange(seed, 15000, 100000); }
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
            if Equals(coherence.debtReason, GetLocalizedTextByKey(n"Kdsp-Shared-C15")) {
                let holders: array<String>;
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T0"));
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
            if Equals(coherence.debtReason, GetLocalizedTextByKey(n"Kdsp-Shared-C18")) {
                let holders: array<String>;
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S11"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T1"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T2"));
                ArrayPush(holders, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T3"));
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
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T4");
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
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T5"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T6"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S20"));
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
            return KdspFinancialProfileManager.GenerateEmploymentStatus(seed, archetype);
        }

        if IsDefined(coherence) {
            if Equals(coherence.jobHistory, "none") { return "UNEMPLOYED"; }
            if Equals(coherence.jobHistory, "criminal") {
                let statuses: array<String>;
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T7"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T8"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T9"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T10"));
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
            if Equals(coherence.jobHistory, "unstable") {
                let statuses: array<String>;
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T11"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T12"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T13"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T14"));
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
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T15"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S21"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S22"));
                    return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
                } else {
                    let levels: array<String>;
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T16"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S23"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T17"));
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
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T18"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S24"));
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S25"));
                    return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
                }
                if Equals(coherence.lifeTheme, "STRUGGLING") {
                    let levels: array<String>;
                    ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T19"));
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
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T20"));
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T21"));
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T22"));
                return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
            }
            if Equals(coherence.lifeTheme, "STRUGGLING") {
                let levels: array<String>;
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T23"));
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T24"));
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T21"));
                return levels[RandRange(seed, 0, ArraySize(levels) - 1)];
            }
            if Equals(coherence.lifeTheme, "CORPORATE") {
                let levels: array<String>;
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T25"));
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T26"));
                ArrayPush(levels, GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T27"));
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
        if score >= 800 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T28"); }
        if score >= 750 { return "EXCELLENT"; }
        if score >= 700 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T29"); }
        if score >= 650 { return "GOOD"; }
        if score >= 600 { return "FAIR"; }
        if score >= 550 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T30"); }
        if score >= 500 { return GetLocalizedTextByKey(n"Kdsp-BackstoryManag-T0"); }
        if score >= 400 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T31"); }
        if score >= 300 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T32"); }
        if score >= 250 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T33"); }
        if score >= 150 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T34"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T35");
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
        if wealth >= 5000000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T36"); }
        if wealth >= 1000000 { return "WEALTHY"; }
        if wealth >= 500000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T37"); }
        if wealth >= 250000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T38"); }
        if wealth >= 100000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T39"); }
        if wealth >= 50000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T40"); }
        if wealth >= 25000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T41"); }
        if wealth >= 10000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T42"); }
        if wealth >= 5000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T43"); }
        if wealth >= 1000 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T44"); }
        if wealth >= 100 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T45"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T46");
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
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-Corpo-EUROBANK"); }
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
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T47"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T48"); }
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
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T49"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S51"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S52"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T50"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S53"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S54"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S55"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S56"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S57"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T51"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T52"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S58"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T53"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T54");
        }
        
        // General population debt holders (40 options)
        let i = RandRange(seed, 0, 39);
        
        // Corporate/Legitimate (0-19)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S28"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S29"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-Corpo-EUROBANK"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S59"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S30"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S31"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S36"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-Corpo-NC_HOUSING"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S60"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T0"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S61"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S62"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S63"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S64"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S65"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T55"); }
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
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T56"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S76"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S77"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S78"); }
        
        // Shady/Criminal (30-39)
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S79"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S50"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T49"); }
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
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T57"); }
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
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T58"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T59"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S96"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S97"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T60"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T61"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S98"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S99");
        }
        
        // Poor credit - bad status options (20)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S86"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S100"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S101"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S102"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T59"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S103"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S97"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S104"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S105"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S106"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S107"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S108"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S109"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T62"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S110"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T63"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S111"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S112"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S113"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S114");
    }

    private static func GeneratePropertyStatus(seed: Int32, archetype: String, wealth: Int32) -> String {
        if Equals(archetype, "HOMELESS") { return "NO FIXED ADDRESS"; }
        
        let roll = RandRange(seed, 1, 100);
        
        if wealth >= 500000 {
            if roll <= 70 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T64"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T65");
        }
        if wealth >= 100000 {
            if roll <= 30 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T64"); }
            if roll <= 80 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T66"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T67");
        }
        if wealth >= 20000 {
            if roll <= 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T64"); }
            if roll <= 70 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T66"); }
            if roll <= 85 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T68"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T67");
        }
        
        if roll <= 40 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T66"); }
        if roll <= 60 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T68"); }
        if roll <= 75 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T69"); }
        if roll <= 90 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T70"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T71");
    }

    private static func GenerateResidenceType(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T72"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T73"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S115"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S116"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S117"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T74"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T75"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T76"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S118"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T77"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S119"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S120"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T78"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S121"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S122");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S123"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T79"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S124"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T80"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S125"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T81"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T82"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S126"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T83"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S127");
        }
        
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T84"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T85"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T86"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T87"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T88"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T89"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S128"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T90"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T91"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S129");
        }
        
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T92"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T93"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T94"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T95"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T96"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T97"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T98"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T99"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T100"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T101"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T102"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T103"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T104"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T105"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T106");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T107"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T108"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S130"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T109"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T110"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T111"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T112"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S131"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T113"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T114");
        }
        
        // General population (15 options)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T115"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T116"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T117"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T118"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T119"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S132"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S133"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S134"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S135"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S136"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T120"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T121"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T122"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T123"); }
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
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T124"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T125"); }
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
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T126"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S169"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S170"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S171"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T127");
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
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T126"); }
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T9"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S195"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S196"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T128"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S197");
        }
        if Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 6);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T9"); }
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
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T129"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T130"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T131"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T132"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S205"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S206"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T133"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T134");
        }
        if Equals(archetype, "NOMAD") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S207"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S208"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S209"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S210"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T135"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S211"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S212"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S213"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S214"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T136");
        }
        
        // General population (25 options)
        let i = RandRange(seed, 0, 24);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S215"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S216"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S217"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S218"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T137"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S219"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T9"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S199"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T138"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T139"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S220"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S221"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S222"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T140"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S223"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S224"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T141"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S225"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S226"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T142"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S227"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S228"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T143"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T144"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T145");
    }

    private static func GenerateEmployer(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 29);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-Shared-C6"); }
            if i == 1 { return "Militech"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KANG_TAO"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-Corpo-BIOTECHNICA"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-Corpo-PETROCHEM"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-Corpo-ZETATECH"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KIROSHI"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-Corpo-TTI"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S229"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T146"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-Corpo-SOVOIL"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-Corpo-IEC"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T149"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-Corpo-ALL_FOODS"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-Corpo-ORBITAL_AIR"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-Corpo-NN54"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-Corpo-WORLD_NEWS"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-Corpo-DYNALAR"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-Corpo-RAVEN_MICRO"); }
            if i == 19 { return GetLocalizedTextByKey(n"Kdsp-Corpo-EUROBANK"); }
            if i == 20 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KENDACHI"); }
            if i == 21 { return GetLocalizedTextByKey(n"Kdsp-Corpo-TDS"); }
            if i == 22 { return GetLocalizedTextByKey(n"Kdsp-Corpo-BUDGET_ARMS"); }
            if i == 23 { return "NetWatch"; }
            if i == 24 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T147"); }
            if i == 25 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T148"); }
            if i == 26 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T149"); }
            if i == 27 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T150"); }
            if i == 28 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T151"); }
            return GetLocalizedTextByKey(n"Kdsp-Corpo-FUYUTSUKI");
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T152"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T153"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T154"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T155"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T156"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T157"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T158"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T159"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S230"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T160"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T161"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T162"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T163"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T164"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T165");
        }
        
        // General population (40 options)
        let i = RandRange(seed, 0, 39);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S231"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T166"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T167"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S232"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T168"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T169"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T170"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T171"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T172"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S233"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T173"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T174"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S234"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T175"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T176"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T177"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T178"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T179"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T180"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T181"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T182"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T183"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T184"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S235"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T185"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T186"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T187"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T188"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T189"); }
        if i == 29 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T190"); }
        if i == 30 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T191"); }
        if i == 31 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T192"); }
        if i == 32 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T193"); }
        if i == 33 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T194"); }
        if i == 34 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T195"); }
        if i == 35 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T196"); }
        if i == 36 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S236"); }
        if i == 37 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T197"); }
        if i == 38 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T198"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T199");
    }

    private static func GenerateIncomeLevel(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T200"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T201"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T202"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T203"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T204"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S237"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S238"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S239"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S240"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S241");
        }
        if Equals(archetype, "CORPO_DRONE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T205"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T206"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T207"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T208"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T209"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S242"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S243"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S244"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T210"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S245");
        }
        if Equals(archetype, "YUPPIE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T211"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T212"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T213"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S246"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S247"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S248"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T214"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S249"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S250"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T215");
        }
        if Equals(archetype, "CIVVIE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T216"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T217"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T218"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S251"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T219"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T220"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T221"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S252"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T222"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T223");
        }
        if Equals(archetype, "LOWLIFE") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T224"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T225"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T226"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T227"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T228"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S253"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S254"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S255"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T229"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S256");
        }
        if Equals(archetype, "GANGER") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T230"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T231"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T232"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S257"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T233"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T234"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T235"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S258"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S259"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S260");
        }
        if Equals(archetype, "JUNKIE") { 
            let i = RandRange(seed, 0, 6);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T236"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T237"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T238"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T239"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S261"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T240"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T241");
        }
        if Equals(archetype, "HOMELESS") { 
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T242"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T243"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S262"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T244"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T245"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T246");
        }
        if Equals(archetype, "NOMAD") { 
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T247"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T248"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T249"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S263"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S264"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S265"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T250"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S266"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T251"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S267");
        }
        
        // Default
        let i = RandRange(seed, 0, 9);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T252"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T253"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T216"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T254"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S268"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T255"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T256"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T220"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T257"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T258");
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T259"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S339"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S340"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S341"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T260"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T261"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S342"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T262"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T263"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T264");
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T265"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T266"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T267"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T268"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T269"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T270");
        }
        
        if Equals(archetype, "GANGER") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T259"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T266"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T267"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T271"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S343"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T272"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T261"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T270");
        }

        // General population (15 options)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T259"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S344"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S345"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T273"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T267"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T260"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T274"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T275"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T266"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T262"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T276"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T277"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T278"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T279"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T280");
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T281"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T282"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T283"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T284"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T285"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T286"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T287"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T288");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T289"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T290"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T291"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T292"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T293"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T294"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T295"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T296");
        }
        
        if Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 7);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T297"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T298"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T299"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T300"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T301"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T302"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T303"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T304");
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T305"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T306"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T307"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T308"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S372");
        }
        
        // General population (20 options)
        let i = RandRange(seed, 0, 19);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T309"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T310"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T311"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T305"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T312"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T313"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T314"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T315"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T316"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T317"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T318"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T319"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T320"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T321"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T322"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S373"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T323"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T324"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T325"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T326");
    }

    private static func GenerateBankAffiliation(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T327"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T328"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S33"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S374"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S375"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T329"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S376"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T330"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S377"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T331");
        }
        
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S378"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T332"); }
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
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T333"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T334"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S384");
        }
        
        // General population (25 options)
        let i = RandRange(seed, 0, 24);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-Corpo-EUROBANK"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S382"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S62"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S63"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S385"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S386"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S387"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T335"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S388"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S389"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S390"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T336"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S391"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T337"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S392"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S393"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S394"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S378"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S395"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S396"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S397"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T338"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S398"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-S399"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T339");
    }

    private static func GenerateAccountStatus(seed: Int32, creditScore: Int32) -> String {
        if creditScore >= 750 {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T340"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T341"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T342"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T343"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T344");
        }
        
        if creditScore >= 650 {
            let i = RandRange(seed, 0, 4);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T345"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T346"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T347"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T348"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T349");
        }
        
        if creditScore >= 500 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T350"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T351"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T352"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T353"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T354"); }
            return GetLocalizedTextByKey(n"Kdsp-BarghestProfil-T47");
        }
        
        if creditScore >= 350 {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T355"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T356"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T357"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T358"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T359"); }
            return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T360");
        }
        
        // Very poor credit (10 options)
        let i = RandRange(seed, 0, 9);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T361"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T362"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T363"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T364"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T365"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T366"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T367"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T368"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T369"); }
        return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T370");
    }

    private static func GenerateNCID(seed: Int32, archetype: String) -> String {
        // Homeless / Junkie - often lost, expired, or never had ID
        if Equals(archetype, "HOMELESS") {
            let i = RandRange(seed, 0, 5);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T371"); }
            if i == 1 { return "EXPIRED"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T372"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T373"); }
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
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T374"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T375"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-FinancialProfi-T376"); }
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
