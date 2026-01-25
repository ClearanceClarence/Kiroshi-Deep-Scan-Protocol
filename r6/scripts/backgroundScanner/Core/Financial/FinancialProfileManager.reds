// Financial Profile Generation System
public class FinancialProfileManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String) -> ref<FinancialProfileData> {
        return FinancialProfileManager.GenerateCoherent(seed, archetype, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> ref<FinancialProfileData> {
        let profile: ref<FinancialProfileData> = new FinancialProfileData();
        let density = KiroshiSettings.GetDataDensity();

        // Generate credit score - always shown
        profile.creditScore = FinancialProfileManager.GenerateCreditScoreCoherent(seed, archetype, coherence);
        profile.creditTier = FinancialProfileManager.GetCreditTier(profile.creditScore);

        // Generate wealth indicator - always shown
        profile.estimatedWealth = FinancialProfileManager.GenerateWealthCoherent(seed + 100, archetype, coherence);
        profile.wealthTier = FinancialProfileManager.GetWealthTier(profile.estimatedWealth);

        // Debt information - always shown
        if IsDefined(coherence) {
            profile.hasDebt = coherence.isInDebt;
        } else {
            profile.hasDebt = FinancialProfileManager.HasDebt(seed + 200, archetype, profile.creditScore);
        }
        
        if profile.hasDebt {
            profile.debtAmount = FinancialProfileManager.GenerateDebtAmountCoherent(seed + 210, archetype, coherence);
            profile.debtHolder = FinancialProfileManager.GenerateDebtHolderCoherent(seed + 220, archetype, coherence);
            profile.debtStatus = FinancialProfileManager.GenerateDebtStatus(seed + 230, profile.creditScore);
        }

        // Property status - only on medium/high
        if density >= 2 {
            profile.propertyStatus = FinancialProfileManager.GeneratePropertyStatus(seed + 300, archetype, profile.estimatedWealth);
            profile.residenceType = FinancialProfileManager.GenerateResidenceType(seed + 310, archetype);
            profile.residenceDistrict = FinancialProfileManager.GenerateResidenceDistrict(seed + 320, archetype);
        }

        // Employment status - always shown
        profile.employmentStatus = FinancialProfileManager.GenerateEmploymentStatusCoherent(seed + 400, archetype, coherence);
        profile.employer = FinancialProfileManager.GenerateEmployer(seed + 410, archetype);
        profile.incomeLevel = FinancialProfileManager.GenerateIncomeLevelCoherent(seed + 420, archetype, coherence);

        // Recent purchases - only on high density
        if density >= 3 {
            let purchaseCount = RandRange(seed + 500, 0, 4);
            purchaseCount = KiroshiSettings.GetMaxListItems(purchaseCount);
            let i = 0;
            while i < purchaseCount {
                ArrayPush(profile.recentPurchases, FinancialProfileManager.GeneratePurchase(seed + 510 + (i * 33), archetype, profile.estimatedWealth));
                i += 1;
            }
        }

        // Financial flags - only on medium/high
        if density >= 2 {
            profile.taxStatus = FinancialProfileManager.GenerateTaxStatus(seed + 600, archetype);
            profile.bankruptcyHistory = FinancialProfileManager.HasBankruptcyCoherent(seed + 610, archetype, coherence);
            profile.corporateAsset = FinancialProfileManager.IsCorporateAsset(seed + 620, archetype, profile.debtStatus);
        }

        // Insurance - only on medium/high
        if density >= 2 {
            profile.traumaTeamCoverage = FinancialProfileManager.GenerateTraumaTeamCoverage(seed + 700, archetype, profile.estimatedWealth);
            profile.healthInsurance = FinancialProfileManager.GenerateHealthInsurance(seed + 710, archetype);
        }

        // Bank accounts - only on high density
        if density >= 3 {
            profile.bankAffiliation = FinancialProfileManager.GenerateBankAffiliation(seed + 800, archetype);
            profile.accountStatus = FinancialProfileManager.GenerateAccountStatus(seed + 810, profile.creditScore);
        }

        return profile;
    }

    // Credit score influenced by life theme
    private static func GenerateCreditScoreCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let score = FinancialProfileManager.GenerateCreditScore(seed, archetype);
        
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
    private static func GenerateWealthCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let wealth = FinancialProfileManager.GenerateWealth(seed, archetype);
        
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.5); }
            if Equals(coherence.lifeTheme, "STRUGGLING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 0.7); }
            if Equals(coherence.lifeTheme, "CLIMBING") { wealth = Cast<Int32>(Cast<Float>(wealth) * 1.2); }
            if Equals(coherence.lifeTheme, "CORPORATE") { wealth = Cast<Int32>(Cast<Float>(wealth) * 1.4); }
        }
        
        return wealth;
    }

    // Debt amount coherent with reason
    private static func GenerateDebtAmountCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Int32 {
        let base = FinancialProfileManager.GenerateDebtAmount(seed, archetype);
        
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
    private static func GenerateDebtHolderCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
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
        
        return FinancialProfileManager.GenerateDebtHolder(seed, archetype);
    }

    // Employment status influenced by job history
    private static func GenerateEmploymentStatusCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
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
        
        return FinancialProfileManager.GenerateEmploymentStatus(seed, archetype);
    }

    // Income level coherent with life theme
    private static func GenerateIncomeLevelCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> String {
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
        
        return FinancialProfileManager.GenerateIncomeLevel(seed, archetype);
    }

    // Bankruptcy more likely with falling life theme
    private static func HasBankruptcyCoherent(seed: Int32, archetype: String, coherence: ref<CoherenceProfile>) -> Bool {
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
        if score >= 750 { return "EXCELLENT"; }
        if score >= 650 { return "GOOD"; }
        if score >= 550 { return "FAIR"; }
        if score >= 400 { return "POOR"; }
        if score >= 250 { return "VERY POOR"; }
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
        if wealth >= 1000000 { return "WEALTHY"; }
        if wealth >= 250000 { return "UPPER MIDDLE CLASS"; }
        if wealth >= 50000 { return "MIDDLE CLASS"; }
        if wealth >= 10000 { return "WORKING CLASS"; }
        if wealth >= 1000 { return "LOW INCOME"; }
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
        let holders: array<String>;

        // Corporations
        ArrayPush(holders, "Arasaka Financial Services");
        ArrayPush(holders, "Militech Credit Division");
        ArrayPush(holders, "Night City Municipal Debt Collection");
        ArrayPush(holders, "EuroBank");
        ArrayPush(holders, "Orbital Lending Corp");
        ArrayPush(holders, "Zetatech Consumer Finance");
        ArrayPush(holders, "NCMH (Medical Debt)");
        ArrayPush(holders, "Night City Housing Authority");
        
        // Shadier options
        ArrayPush(holders, "Unknown Private Lender");
        ArrayPush(holders, "Tyger Claws (informal)");
        ArrayPush(holders, "Valentinos (informal)");
        ArrayPush(holders, "6th Street Collections");
        ArrayPush(holders, "Street Fixer (unnamed)");
        ArrayPush(holders, "Maelstrom Debt Enforcement");

        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") || Equals(archetype, "YUPPIE") {
            return holders[RandRange(seed, 0, 7)];
        }
        if Equals(archetype, "GANGER") {
            return holders[RandRange(seed, 8, ArraySize(holders) - 1)];
        }
        
        return holders[RandRange(seed, 0, ArraySize(holders) - 1)];
    }

    private static func GenerateDebtStatus(seed: Int32, creditScore: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if creditScore >= 650 {
            if roll <= 60 { return "Current - Good Standing"; }
            if roll <= 85 { return "Current - Minimum Payments"; }
            if roll <= 95 { return "30 Days Past Due"; }
            return "Under Review";
        }
        if creditScore >= 450 {
            if roll <= 20 { return "Current - Good Standing"; }
            if roll <= 50 { return "Current - Minimum Payments"; }
            if roll <= 70 { return "30-60 Days Past Due"; }
            if roll <= 85 { return "In Collections"; }
            return "Wage Garnishment Active";
        }
        
        if roll <= 10 { return "Current - Minimum Payments"; }
        if roll <= 30 { return "60-90 Days Past Due"; }
        if roll <= 55 { return "In Collections"; }
        if roll <= 75 { return "Wage Garnishment Active"; }
        if roll <= 90 { return "Asset Seizure Pending"; }
        return "Debt Sold to Enforcement Agency";
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
        let types: array<String>;

        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            ArrayPush(types, "Penthouse Suite");
            ArrayPush(types, "Luxury Apartment");
            ArrayPush(types, "Executive Housing Complex");
            ArrayPush(types, "Gated Community Residence");
            ArrayPush(types, "High-Rise Apartment (Premium)");
        } else if Equals(archetype, "CORPO_DRONE") {
            ArrayPush(types, "Corporate Housing Unit");
            ArrayPush(types, "Mid-Rise Apartment");
            ArrayPush(types, "Megabuilding Unit (Standard)");
            ArrayPush(types, "Company Dormitory");
        } else if Equals(archetype, "NOMAD") {
            ArrayPush(types, "Mobile Home/Vehicle");
            ArrayPush(types, "Camp Dwelling");
            ArrayPush(types, "Nomad Settlement");
            ArrayPush(types, "Badlands Compound");
        } else if Equals(archetype, "HOMELESS") {
            ArrayPush(types, "Street/Alley");
            ArrayPush(types, "Abandoned Building");
            ArrayPush(types, "Underpass/Bridge");
            ArrayPush(types, "Shelter (Temporary)");
            ArrayPush(types, "Tent City");
        } else if Equals(archetype, "GANGER") {
            ArrayPush(types, "Gang Safehouse");
            ArrayPush(types, "Shared Apartment");
            ArrayPush(types, "Megabuilding Unit (Low)");
            ArrayPush(types, "Warehouse Conversion");
        } else {
            ArrayPush(types, "Megabuilding Unit");
            ArrayPush(types, "Low-Rise Apartment");
            ArrayPush(types, "Shared Housing");
            ArrayPush(types, "Studio Apartment");
            ArrayPush(types, "Basement Unit");
        }

        return types[RandRange(seed, 0, ArraySize(types) - 1)];
    }

    private static func GenerateResidenceDistrict(seed: Int32, archetype: String) -> String {
        let districts: array<String>;

        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            ArrayPush(districts, "City Center - Corporate Plaza");
            ArrayPush(districts, "Westbrook - North Oak");
            ArrayPush(districts, "Westbrook - Charter Hill");
            ArrayPush(districts, "Heywood - The Glen");
        } else if Equals(archetype, "CORPO_DRONE") {
            ArrayPush(districts, "City Center - Downtown");
            ArrayPush(districts, "Watson - Little China");
            ArrayPush(districts, "Westbrook - Japantown");
            ArrayPush(districts, "Santo Domingo - Rancho Coronado");
        } else if Equals(archetype, "NOMAD") {
            ArrayPush(districts, "Badlands - Rocky Ridge");
            ArrayPush(districts, "Badlands - Biotechnica Flats");
            ArrayPush(districts, "Badlands - Sierra Sonora");
            ArrayPush(districts, "Santo Domingo - Arroyo (Edge)");
        } else if Equals(archetype, "GANGER") {
            ArrayPush(districts, "Watson - Kabuki");
            ArrayPush(districts, "Watson - Northside");
            ArrayPush(districts, "Heywood - Vista del Rey");
            ArrayPush(districts, "Pacifica - West Wind Estate");
            ArrayPush(districts, "Santo Domingo - Arroyo");
        } else if Equals(archetype, "HOMELESS") {
            ArrayPush(districts, "Watson - Kabuki (Streets)");
            ArrayPush(districts, "Pacifica - Coastview");
            ArrayPush(districts, "Heywood - Wellsprings");
            ArrayPush(districts, "Santo Domingo - Arroyo");
        } else {
            ArrayPush(districts, "Watson - Little China");
            ArrayPush(districts, "Watson - Kabuki");
            ArrayPush(districts, "Heywood - Wellsprings");
            ArrayPush(districts, "Santo Domingo - Rancho Coronado");
            ArrayPush(districts, "Westbrook - Japantown");
        }

        return districts[RandRange(seed, 0, ArraySize(districts) - 1)];
    }

    private static func GenerateEmploymentStatus(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "EMPLOYED - Executive Level"; }
        if Equals(archetype, "CORPO_DRONE") { return "EMPLOYED - Corporate"; }
        if Equals(archetype, "HOMELESS") { return "UNEMPLOYED"; }
        if Equals(archetype, "JUNKIE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 80 { return "UNEMPLOYED"; }
            return "EMPLOYED - Informal";
        }

        let statuses: array<String>;
        ArrayPush(statuses, "EMPLOYED - Full Time");
        ArrayPush(statuses, "EMPLOYED - Part Time");
        ArrayPush(statuses, "EMPLOYED - Contract");
        ArrayPush(statuses, "EMPLOYED - Gig Economy");
        ArrayPush(statuses, "SELF-EMPLOYED");
        ArrayPush(statuses, "UNEMPLOYED - Seeking");
        ArrayPush(statuses, "UNEMPLOYED");
        ArrayPush(statuses, "EMPLOYED - Informal");
        ArrayPush(statuses, "RETIRED");
        ArrayPush(statuses, "DISABLED");

        if Equals(archetype, "GANGER") {
            if RandRange(seed, 1, 100) <= 70 { return "EMPLOYED - Informal"; }
        }

        return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
    }

    private static func GenerateEmployer(seed: Int32, archetype: String) -> String {
        let employers: array<String>;

        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            ArrayPush(employers, "Arasaka Corporation");
            ArrayPush(employers, "Militech");
            ArrayPush(employers, "Kang Tao");
            ArrayPush(employers, "Biotechnica");
            ArrayPush(employers, "Petrochem");
            ArrayPush(employers, "Zetatech");
            ArrayPush(employers, "Kiroshi Opticals");
            ArrayPush(employers, "Trauma Team International");
            ArrayPush(employers, "Night City Municipal");
            ArrayPush(employers, "NCART");
        } else if Equals(archetype, "YUPPIE") {
            ArrayPush(employers, "Private Practice");
            ArrayPush(employers, "Consulting Firm");
            ArrayPush(employers, "Media Corporation");
            ArrayPush(employers, "Law Firm");
            ArrayPush(employers, "Financial Services");
        } else {
            ArrayPush(employers, "Various (Gig Work)");
            ArrayPush(employers, "Local Business");
            ArrayPush(employers, "Self-Employed");
            ArrayPush(employers, "Factory (Santo Domingo)");
            ArrayPush(employers, "Food Service");
            ArrayPush(employers, "Retail");
            ArrayPush(employers, "Construction");
            ArrayPush(employers, "Sanitation");
            ArrayPush(employers, "Security (Contract)");
            ArrayPush(employers, "N/A - Unemployed");
        }

        return employers[RandRange(seed, 0, ArraySize(employers) - 1)];
    }

    private static func GenerateIncomeLevel(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "€$250,000+ /year"; }
        if Equals(archetype, "CORPO_DRONE") { return "€$45,000 - €$120,000 /year"; }
        if Equals(archetype, "YUPPIE") { return "€$80,000 - €$200,000 /year"; }
        if Equals(archetype, "CIVVIE") { return "€$15,000 - €$45,000 /year"; }
        if Equals(archetype, "LOWLIFE") { return "€$5,000 - €$15,000 /year"; }
        if Equals(archetype, "GANGER") { return "€$10,000 - €$50,000 /year (Est.)"; }
        if Equals(archetype, "JUNKIE") { return "< €$5,000 /year"; }
        if Equals(archetype, "HOMELESS") { return "NO INCOME"; }
        if Equals(archetype, "NOMAD") { return "€$8,000 - €$30,000 /year (Est.)"; }
        return "€$20,000 - €$40,000 /year";
    }

    private static func GeneratePurchase(seed: Int32, archetype: String, wealth: Int32) -> String {
        let purchases: array<String>;

        if wealth >= 100000 {
            ArrayPush(purchases, "Luxury vehicle - €$" + IntToString(RandRange(seed, 50000, 200000)));
            ArrayPush(purchases, "Premium cyberware - €$" + IntToString(RandRange(seed, 10000, 75000)));
            ArrayPush(purchases, "Vacation package - €$" + IntToString(RandRange(seed, 5000, 30000)));
            ArrayPush(purchases, "Real estate investment - €$" + IntToString(RandRange(seed, 100000, 500000)));
            ArrayPush(purchases, "Art purchase - €$" + IntToString(RandRange(seed, 2000, 50000)));
        } else if wealth >= 20000 {
            ArrayPush(purchases, "Used vehicle - €$" + IntToString(RandRange(seed, 5000, 25000)));
            ArrayPush(purchases, "Cyberware upgrade - €$" + IntToString(RandRange(seed, 1000, 15000)));
            ArrayPush(purchases, "Electronics - €$" + IntToString(RandRange(seed, 200, 2000)));
            ArrayPush(purchases, "Furniture - €$" + IntToString(RandRange(seed, 500, 5000)));
            ArrayPush(purchases, "Weapon - €$" + IntToString(RandRange(seed, 500, 5000)));
        } else {
            ArrayPush(purchases, "Food supplies - €$" + IntToString(RandRange(seed, 20, 200)));
            ArrayPush(purchases, "Clothing - €$" + IntToString(RandRange(seed, 30, 300)));
            ArrayPush(purchases, "Basic electronics - €$" + IntToString(RandRange(seed, 50, 500)));
            ArrayPush(purchases, "Medication - €$" + IntToString(RandRange(seed, 20, 300)));
            ArrayPush(purchases, "Ammunition - €$" + IntToString(RandRange(seed, 50, 500)));
        }

        return purchases[RandRange(seed, 0, ArraySize(purchases) - 1)];
    }

    private static func GenerateTaxStatus(seed: Int32, archetype: String) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            if roll <= 85 { return "COMPLIANT"; }
            if roll <= 95 { return "AUDIT PENDING"; }
            return "UNDER INVESTIGATION";
        }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            if roll <= 30 { return "NO TAX OBLIGATION"; }
            if roll <= 60 { return "NON-FILER"; }
            return "DELINQUENT";
        }
        if Equals(archetype, "GANGER") {
            if roll <= 20 { return "COMPLIANT"; }
            if roll <= 50 { return "NON-FILER"; }
            return "DELINQUENT";
        }

        if roll <= 60 { return "COMPLIANT"; }
        if roll <= 75 { return "MINOR DISCREPANCY"; }
        if roll <= 90 { return "DELINQUENT"; }
        return "AUDIT PENDING";
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

    private static func GenerateTraumaTeamCoverage(seed: Int32, archetype: String, wealth: Int32) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "PLATINUM (Full Coverage)"; }
        if Equals(archetype, "YUPPIE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 50 { return "GOLD"; }
            if roll <= 80 { return "SILVER"; }
            return "PLATINUM (Full Coverage)";
        }
        if Equals(archetype, "CORPO_DRONE") {
            let roll = RandRange(seed, 1, 100);
            if roll <= 30 { return "SILVER (Corporate Plan)"; }
            if roll <= 60 { return "BRONZE (Corporate Plan)"; }
            return "NONE (Opt-Out)";
        }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            return "NONE";
        }
        
        if wealth >= 50000 {
            let roll = RandRange(seed, 1, 100);
            if roll <= 30 { return "SILVER"; }
            if roll <= 60 { return "BRONZE"; }
            return "NONE";
        }
        
        if RandRange(seed, 1, 100) <= 15 { return "BRONZE"; }
        return "NONE";
    }

    private static func GenerateHealthInsurance(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") { return "ARASAKA PREMIUM HEALTH"; }
        if Equals(archetype, "CORPO_DRONE") { return "CORPORATE BASIC PLAN"; }
        if Equals(archetype, "YUPPIE") { return "PRIVATE HEALTH PLAN"; }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") { return "UNINSURED"; }
        
        let roll = RandRange(seed, 1, 100);
        if roll <= 20 { return "NC PUBLIC HEALTH"; }
        if roll <= 40 { return "BASIC COVERAGE"; }
        if roll <= 60 { return "MINIMAL COVERAGE"; }
        return "UNINSURED";
    }

    private static func GenerateBankAffiliation(seed: Int32, archetype: String) -> String {
        let banks: array<String>;
        
        ArrayPush(banks, "EuroBank");
        ArrayPush(banks, "Night City Savings");
        ArrayPush(banks, "Arasaka Financial");
        ArrayPush(banks, "Militech Banking");
        ArrayPush(banks, "Pacific Credit Union");
        ArrayPush(banks, "Watson Community Bank");
        ArrayPush(banks, "Digital First Bank");
        ArrayPush(banks, "No Bank Account (Cash Only)");

        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
            return banks[RandRange(seed, 2, 3)]; // Corporate banks
        }
        if Equals(archetype, "HOMELESS") || Equals(archetype, "JUNKIE") {
            return banks[7]; // No account
        }
        if RandRange(seed + 5, 1, 100) <= 20 {
            return banks[7]; // Some unbanked
        }
        
        return banks[RandRange(seed, 0, 6)];
    }

    private static func GenerateAccountStatus(seed: Int32, creditScore: Int32) -> String {
        if creditScore >= 650 { return "ACTIVE - GOOD STANDING"; }
        if creditScore >= 500 { return "ACTIVE - FAIR STANDING"; }
        if creditScore >= 350 { return "RESTRICTED"; }
        return "FROZEN / CLOSED";
    }
}

public class FinancialProfileData {
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
}
