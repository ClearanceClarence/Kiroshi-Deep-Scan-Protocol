// Cyberware Registry Generation System
public class KdspCyberwareRegistryManager {

    // Legacy function for backward compatibility
    public static func Generate(seed: Int32, archetype: String, wealth: Int32) -> ref<KdspCyberwareRegistryData> {
        return KdspCyberwareRegistryManager.GenerateCoherent(seed, archetype, wealth, null);
    }

    // Coherent generation using life profile
    public static func GenerateCoherent(seed: Int32, archetype: String, wealth: Int32, coherence: ref<KdspCoherenceProfile>) -> ref<KdspCyberwareRegistryData> {
        let registry: ref<KdspCyberwareRegistryData> = new KdspCyberwareRegistryData();
        let density = KdspSettings.GetDataDensity();

        // Adjust wealth based on coherence
        let effectiveWealth = wealth;
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") { effectiveWealth = effectiveWealth - 20; }
            if Equals(coherence.lifeTheme, "STRUGGLING") { effectiveWealth = effectiveWealth - 10; }
            if Equals(coherence.lifeTheme, "CLIMBING") { effectiveWealth = effectiveWealth + 10; }
            if effectiveWealth < 0 { effectiveWealth = 0; }
        }

        // Determine cyberware count based on archetype and wealth - limited by density
        let cyberwareCount = KdspCyberwareRegistryManager.GetCyberwareCount(seed, archetype, effectiveWealth);
        cyberwareCount = KdspSettings.GetMaxListItems(cyberwareCount);
        registry.totalImplants = cyberwareCount;

        // Generate individual cyberware entries
        let i = 0;
        while i < cyberwareCount {
            let cyberware = KdspCyberwareRegistryManager.GenerateCyberwareCoherent(seed + (i * 123), archetype, effectiveWealth, coherence);
            ArrayPush(registry.implants, cyberware);
            
            if !cyberware.isLegal {
                registry.hasIllegalCyberware = true;
                registry.illegalCount += 1;
            }
            i += 1;
        }

        // Body Modification cyberware - only on high density
        if density >= 3 && KdspSettings.BodyModRecordsEnabled() && RandRange(seed + 450, 1, 100) <= 20 {
            let bodyMod = KdspCyberwareRegistryManager.GenerateBodyModCyberware(seed + 460, effectiveWealth);
            ArrayPush(registry.implants, bodyMod);
            registry.totalImplants += 1;
        }

        // Calculate cyberpsychosis risk - always shown
        registry.cyberpsychosisRisk = KdspCyberwareRegistryManager.CalculateCyberpsychosisRiskCoherent(seed + 500, registry.implants, archetype, coherence);
        registry.cyberpsychosisStatus = KdspCyberwareRegistryManager.GetCyberpsychosisStatus(registry.cyberpsychosisRisk);

        // Generate rejected/failed implants - only on medium/high
        if density >= 2 {
            let rejectChance = 20;
            if IsDefined(coherence) {
                if Equals(coherence.lifeTheme, "FALLING") { rejectChance += 25; }
                if Equals(coherence.lifeTheme, "STRUGGLING") { rejectChance += 10; }
                if coherence.hasSubstanceIssues { rejectChance += 15; }
            }
            
            if RandRange(seed + 600, 1, 100) <= rejectChance {
                registry.hasRejectedImplants = true;
                let rejectCount = RandRange(seed + 610, 1, 3);
                rejectCount = KdspSettings.GetMaxListItems(rejectCount);
                i = 0;
                while i < rejectCount {
                    ArrayPush(registry.rejectedImplants, KdspCyberwareRegistryManager.GenerateRejectedImplant(seed + 700 + (i * 50)));
                    i += 1;
                }
            }
        }

        // Last ripperdoc visit - only on high density
        if density >= 3 {
            registry.lastRipperdocVisit = KdspCyberwareRegistryManager.GenerateLastVisit(seed + 800);
            registry.preferredRipperdoc = KdspCyberwareRegistryManager.GenerateRipperdocCoherent(seed + 900, archetype, coherence);
        }

        // Warranty status - only on high density
        if density >= 3 {
            registry.warrantyStatus = KdspCyberwareRegistryManager.GenerateWarrantyStatusCoherent(seed + 1000, effectiveWealth, coherence);
        }

        return registry;
    }

    // Cyberware quality and legality affected by life theme
    private static func GenerateCyberwareCoherent(seed: Int32, archetype: String, wealth: Int32, coherence: ref<KdspCoherenceProfile>) -> ref<KdspCyberwareImplant> {
        let cyberware = KdspCyberwareRegistryManager.GenerateCyberware(seed, archetype, wealth);
        
        // Criminal theme = more likely illegal
        if IsDefined(coherence) && Equals(coherence.lifeTheme, "CRIMINAL") {
            if RandRange(seed + 50, 1, 100) <= 50 {
                cyberware.isLegal = false;
            }
        }
        
        return cyberware;
    }

    // Cyberpsychosis risk influenced by substance abuse
    private static func CalculateCyberpsychosisRiskCoherent(seed: Int32, implants: array<ref<KdspCyberwareImplant>>, archetype: String, coherence: ref<KdspCoherenceProfile>) -> Int32 {
        let risk = KdspCyberwareRegistryManager.CalculateCyberpsychosisRisk(seed, implants, archetype);
        
        if IsDefined(coherence) {
            // Substance abuse increases cyberpsychosis risk (neurotransmitter imbalance)
            if coherence.hasSubstanceIssues { risk += RandRange(seed + 5, 10, 25); }
            // Trauma and instability increase risk
            if coherence.hasTrauma { risk += RandRange(seed + 6, 5, 15); }
            if Equals(coherence.lifeTheme, "FALLING") { risk += RandRange(seed + 7, 5, 10); }
        }
        
        if risk > 100 { risk = 100; }
        return risk;
    }

    // Ripperdoc choice influenced by criminal lifestyle
    private static func GenerateRipperdocCoherent(seed: Int32, archetype: String, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) && Equals(coherence.lifeTheme, "CRIMINAL") {
            let docs: array<String>;
            ArrayPush(docs, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S0"));
            ArrayPush(docs, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S1"));
            ArrayPush(docs, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S2"));
            ArrayPush(docs, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T0"));
            ArrayPush(docs, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S3"));
            return docs[RandRange(seed, 0, ArraySize(docs) - 1)];
        }
        return KdspCyberwareRegistryManager.GenerateRipperdoc(seed, archetype);
    }

    // Warranty affected by life circumstances
    private static func GenerateWarrantyStatusCoherent(seed: Int32, wealth: Int32, coherence: ref<KdspCoherenceProfile>) -> String {
        if IsDefined(coherence) {
            if Equals(coherence.lifeTheme, "FALLING") || Equals(coherence.lifeTheme, "STRUGGLING") {
                let statuses: array<String>;
                ArrayPush(statuses, "EXPIRED");
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S4"));
                ArrayPush(statuses, GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S5"));
                ArrayPush(statuses, "NONE");
                return statuses[RandRange(seed, 0, ArraySize(statuses) - 1)];
            }
        }
        return KdspCyberwareRegistryManager.GenerateWarrantyStatus(seed, wealth);
    }

    private static func GetCyberwareCount(seed: Int32, archetype: String, wealth: Int32) -> Int32 {
        let base: Int32;
        
        if Equals(archetype, "CORPO_MANAGER") { base = RandRange(seed, 4, 8); }
        else if Equals(archetype, "CORPO_DRONE") { base = RandRange(seed, 3, 6); }
        else if Equals(archetype, "YUPPIE") { base = RandRange(seed, 3, 7); }
        else if Equals(archetype, "GANGER") { base = RandRange(seed, 2, 6); }
        else if Equals(archetype, "NOMAD") { base = RandRange(seed, 1, 4); }
        else if Equals(archetype, "LOWLIFE") { base = RandRange(seed, 1, 4); }
        else if Equals(archetype, "JUNKIE") { base = RandRange(seed, 0, 3); }
        else if Equals(archetype, "HOMELESS") { base = RandRange(seed, 0, 2); }
        else { base = RandRange(seed, 1, 4); }

        // Wealth modifier
        base += wealth / 30;
        
        if base < 0 { base = 0; }
        if base > 12 { base = 12; }
        
        return base;
    }

    private static func GenerateCyberware(seed: Int32, archetype: String, wealth: Int32) -> ref<KdspCyberwareImplant> {
        let implant: ref<KdspCyberwareImplant> = new KdspCyberwareImplant();

        // Select slot
        implant.slot = KdspCyberwareRegistryManager.GetRandomSlot(seed);
        
        // Select implant based on slot
        implant.name = KdspCyberwareRegistryManager.GetImplantForSlot(seed + 10, implant.slot, archetype);
        
        // Select manufacturer
        implant.manufacturer = KdspCyberwareRegistryManager.GetManufacturer(seed + 20, wealth, archetype);
        
        // Determine legality
        implant.isLegal = KdspCyberwareRegistryManager.DetermineIfLegal(seed + 30, archetype, implant.name);
        
        // Condition
        implant.condition = KdspCyberwareRegistryManager.GetCondition(seed + 40, wealth);
        
        // Installation year
        implant.installYear = RandRange(seed + 50, 2065, 2077);

        // Grade
        implant.grade = KdspCyberwareRegistryManager.GetGrade(seed + 60, wealth);

        return implant;
    }

    private static func GenerateBodyModCyberware(seed: Int32, wealth: Int32) -> ref<KdspCyberwareImplant> {
        let implant: ref<KdspCyberwareImplant> = new KdspCyberwareImplant();

        implant.slot = GetLocalizedTextByKey(n"Kdsp-Shared-C5");
        
        // Select body mod implant type (20 options)
        let i = RandRange(seed, 0, 19);
        if i == 0 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S6"); }
        else if i == 1 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S7"); }
        else if i == 2 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S8"); }
        else if i == 3 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S9"); }
        else if i == 4 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S10"); }
        else if i == 5 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S11"); }
        else if i == 6 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S12"); }
        else if i == 7 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S13"); }
        else if i == 8 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S14"); }
        else if i == 9 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S15"); }
        else if i == 10 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S16"); }
        else if i == 11 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S17"); }
        else if i == 12 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S18"); }
        else if i == 13 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S19"); }
        else if i == 14 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S20"); }
        else if i == 15 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S21"); }
        else if i == 16 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S22"); }
        else if i == 17 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S23"); }
        else if i == 18 { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S24"); }
        else { implant.name = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S25"); }
        
        // Body mod manufacturers (10 options)
        let m = RandRange(seed + 10, 0, 9);
        if m == 0 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T1"); }
        else if m == 1 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T2"); }
        else if m == 2 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S26"); }
        else if m == 3 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S27"); }
        else if m == 4 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T3"); }
        else if m == 5 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T4"); }
        else if m == 6 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T5"); }
        else if m == 7 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T6"); }
        else if m == 8 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T7"); }
        else { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T8"); }
        
        // Body mods are always legal (medical cyberware)
        implant.isLegal = true;
        
        // Condition based on wealth
        implant.condition = KdspCyberwareRegistryManager.GetCondition(seed + 20, wealth);
        
        // Installation year
        implant.installYear = RandRange(seed + 30, 2068, 2077);

        // Grade based on wealth
        implant.grade = KdspCyberwareRegistryManager.GetGrade(seed + 40, wealth);

        return implant;
    }

    private static func GetRandomSlot(seed: Int32) -> String {
        let i = RandRange(seed, 0, 14);
        
        if i == 0 { return "Optics"; }
        if i == 1 { return "Neural"; }
        if i == 2 { return "Circulatory"; }
        if i == 3 { return "Skeletal"; }
        if i == 4 { return "Integumentary"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-Shared-C25"); }
        if i == 6 { return "Arms"; }
        if i == 7 { return "Legs"; }
        if i == 8 { return "Hands"; }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-Shared-C24"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-Shared-C26"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-Shared-C23"); }
        if i == 12 { return "Cardiovascular"; }
        if i == 13 { return "Musculature"; }
        return GetLocalizedTextByKey(n"Kdsp-Shared-C22");
    }

    private static func GetImplantForSlot(seed: Int32, slot: String, archetype: String) -> String {
        if Equals(slot, "Optics") {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S28"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S29"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S30"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T9"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T10"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S31"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T11"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T12"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S32"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T13"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T14"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S33"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S34"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T15"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T16"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T17"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T18"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S35"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T19"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S36");
        }
        
        if Equals(slot, "Neural") {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T20"); }
            if i == 1 { return "Kerenzikov"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T21"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T22"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T23"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T24"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T25"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S37"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T26"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T27"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T28"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T29"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T30"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T31"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T32"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T33"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S38"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T34"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T35"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S39");
        }
        
        if Equals(slot, "Circulatory") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T36"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T37"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T38"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T39"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T40"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T41"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S40"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T42"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T43"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T44"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T45"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S41"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S42"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T46"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S43");
        }
        
        if Equals(slot, "Skeletal") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T47"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T48"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S44"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T49"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T50"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T51"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T52"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T53"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T54"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T55"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T56"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S45"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T57"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S46"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S47");
        }
        
        if Equals(slot, "Integumentary") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T58"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T59"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T60"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T61"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T62"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T63"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T64"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S48"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T65"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T66"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S49"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T67"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T68"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T69"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T70");
        }
        
        if Equals(slot, GetLocalizedTextByKey(n"Kdsp-Shared-C25")) {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T71"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T72"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T73"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T2"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S50"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T74"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S51"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S52"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S53"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T75"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T76"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T77"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T78"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S54"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S55"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T79"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S56"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S57"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T80"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S58");
        }
        
        if Equals(slot, "Arms") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T81"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S59"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S60"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T82"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S61"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S62"); }
            if i == 6 { return "Monowire"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T83"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S63"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S64"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S65"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S66"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S67"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S68"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T84");
        }
        
        if Equals(slot, "Legs") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T85"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T86"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T87"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S69"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S70"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S71"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T88"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S72"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S73"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S74"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T89"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T90");
        }
        
        if Equals(slot, "Hands") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T91"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T92"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S75"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S76"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T93"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T94"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S77"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T95"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T96"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T97"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S78"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S79");
        }
        
        if Equals(slot, GetLocalizedTextByKey(n"Kdsp-Shared-C24")) {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T98"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T99"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S80"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S81"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S82"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S37"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S83"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S84"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T100"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T101"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T102"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T103"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T104"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T105"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T106");
        }
        
        if Equals(slot, GetLocalizedTextByKey(n"Kdsp-Shared-C26")) {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T24"); }
            if i == 1 { return "Kerenzikov"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T27"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T33"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T107"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T108"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S85"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T109"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S86"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S87");
        }
        
        if Equals(slot, GetLocalizedTextByKey(n"Kdsp-Shared-C23")) {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T110"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T111"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T41"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T45"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T112"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T113"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T114"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S88"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T115"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S89");
        }
        
        if Equals(slot, "Cardiovascular") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T39"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T37"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T102"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T116"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T117"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T118"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T119"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T120"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T121"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T122");
        }
        
        if Equals(slot, "Musculature") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S90"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S91"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T123"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T124"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T125"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S92"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T126"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S93"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T127"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S94");
        }
        
        if Equals(slot, GetLocalizedTextByKey(n"Kdsp-Shared-C22")) {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T128"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T129"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T130"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T131"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T132"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S95"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T133"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S96"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T134"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S97");
        }
        
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T135");
    }

    private static func GetManufacturer(seed: Int32, wealth: Int32, archetype: String) -> String {
        // Weight selection based on wealth
        if wealth >= 70 || Equals(archetype, "CORPO_MANAGER") {
            // Premium manufacturers (20)
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Arasaka"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T4"); }
            if i == 2 { return "Militech"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S98"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T136"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T137"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-Corpo-ZETATECH"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T5"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T138"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-Corpo-RAVEN_MICRO"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KANG_TAO"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S99"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-Corpo-BIOTECHNICA"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T139"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S100"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T140"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T141"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-Corpo-FUYUTSUKI"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T142"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T143");
        }
        
        if wealth >= 40 {
            // Mid-range manufacturers (20)
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Arasaka"; }
            if i == 1 { return "Militech"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T136"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-Corpo-ZETATECH"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-Corpo-RAVEN_MICRO"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KENDACHI"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T144"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-Corpo-BIOTECHNICA"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S101"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T145"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T146"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T147"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T148"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S102"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T149"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S103"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T150"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T151"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T152"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T153");
        }
        
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            // Black market / Budget (20)
            let i = RandRange(seed, 0, 19);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T154"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T155"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T156"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T157"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S104"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S105"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T158"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T159"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S106"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T160"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T145"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KENDACHI"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S101"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T161"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T162"); }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T163"); }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T164"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S107"); }
            if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T165"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S108");
        }
        
        // Budget default (15)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T145"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-Corpo-KENDACHI"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T144"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S101"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T150"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T151"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T153"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T166"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T167"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T168"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T169"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T170"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T171"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T162"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T172");
    }

    private static func DetermineIfLegal(seed: Int32, archetype: String, implantName: String) -> Bool {
        // Some implants are always questionable
        if StrContains(implantName, "Mantis") || StrContains(implantName, "Gorilla") || 
           StrContains(implantName, "Projectile") || StrContains(implantName, "Monowire") {
            if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") {
                return RandRange(seed, 1, 100) <= 90; // Usually licensed
            }
            return RandRange(seed, 1, 100) <= 50; // 50/50 for others
        }

        // Archetype affects legality
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE") || Equals(archetype, "YUPPIE") {
            return RandRange(seed, 1, 100) <= 95;
        }
        if Equals(archetype, "GANGER") {
            return RandRange(seed, 1, 100) <= 30;
        }
        if Equals(archetype, "LOWLIFE") || Equals(archetype, "JUNKIE") {
            return RandRange(seed, 1, 100) <= 50;
        }
        
        return RandRange(seed, 1, 100) <= 75;
    }

    private static func GetCondition(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100) + (wealth / 2);
        
        if roll >= 95 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S109"); }
        if roll >= 90 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T173"); }
        if roll >= 85 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S110"); }
        if roll >= 80 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T174"); }
        if roll >= 75 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T175"); }
        if roll >= 70 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S111"); }
        if roll >= 60 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T176"); }
        if roll >= 50 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T177"); }
        if roll >= 40 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S112"); }
        if roll >= 35 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T178"); }
        if roll >= 30 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T179"); }
        if roll >= 25 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T180"); }
        if roll >= 20 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S113"); }
        if roll >= 15 { return "Poor"; }
        if roll >= 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T181"); }
        if roll >= 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S114"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S115");
    }

    private static func GetGrade(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100) + (wealth / 3);
        
        if roll >= 98 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S116"); }
        if roll >= 95 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T182"); }
        if roll >= 90 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S117"); }
        if roll >= 85 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T183"); }
        if roll >= 80 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S118"); }
        if roll >= 75 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S119"); }
        if roll >= 70 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S120"); }
        if roll >= 65 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T184"); }
        if roll >= 55 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S121"); }
        if roll >= 45 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T185"); }
        if roll >= 35 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S122"); }
        if roll >= 25 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T186"); }
        if roll >= 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S123"); }
        if roll >= 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T187"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T188");
    }

    private static func CalculateCyberpsychosisRisk(seed: Int32, implants: array<ref<KdspCyberwareImplant>>, archetype: String) -> Int32 {
        let baseRisk = ArraySize(implants) * 5;
        
        // Illegal implants increase risk
        let i = 0;
        while i < ArraySize(implants) {
            if !implants[i].isLegal { baseRisk += 8; }
            if Equals(implants[i].condition, "Critical - Needs Replacement") { baseRisk += 10; }
            if Equals(implants[i].condition, "Poor") { baseRisk += 5; }
            
            // Weapon implants increase risk more
            if StrContains(implants[i].name, "Mantis") || StrContains(implants[i].name, "Gorilla") ||
               StrContains(implants[i].name, "Berserk") || StrContains(implants[i].name, "Sandevistan") {
                baseRisk += 7;
            }
            i += 1;
        }

        // Archetype modifier
        if Equals(archetype, "GANGER") { baseRisk += 15; }
        else if Equals(archetype, "JUNKIE") { baseRisk += 20; }
        else if Equals(archetype, "CORPO_MANAGER") { baseRisk -= 10; } // Better healthcare

        // Add some randomness
        baseRisk += RandRange(seed, -10, 15);

        if baseRisk < 0 { baseRisk = 0; }
        if baseRisk > 100 { baseRisk = 100; }

        return baseRisk;
    }

    private static func GetCyberpsychosisStatus(risk: Int32) -> String {
        if risk >= 95 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T189"); }
        if risk >= 90 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T190"); }
        if risk >= 85 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T191"); }
        if risk >= 80 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T192"); }
        if risk >= 75 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T193"); }
        if risk >= 70 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T194"); }
        if risk >= 65 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T195"); }
        if risk >= 60 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T196"); }
        if risk >= 55 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T197"); }
        if risk >= 50 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T198"); }
        if risk >= 45 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T199"); }
        if risk >= 40 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T200"); }
        if risk >= 35 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T201"); }
        if risk >= 30 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T202"); }
        if risk >= 25 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T203"); }
        if risk >= 20 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T204"); }
        if risk >= 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T205"); }
        if risk >= 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T206"); }
        if risk >= 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T207"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T208");
    }

    private static func GenerateRejectedImplant(seed: Int32) -> String {
        let i = RandRange(seed, 0, 29);
        
        // Immune rejection (0-9)
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S124"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S125"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S126"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S127"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S128"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S129"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S130"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S131"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S132"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S133"); }
        
        // Technical failure (10-19)
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S134"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S135"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S136"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S137"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S138"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S139"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S140"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S141"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S142"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S143"); }
        
        // Psychological rejection (20-29)
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S144"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S145"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S146"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S147"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S148"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S149"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S150"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S151"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S152"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S153");
    }

    private static func GenerateLastVisit(seed: Int32) -> String {
        let months = RandRange(seed, 1, 24);
        if months == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S154"); }
        if months <= 12 { return IntToString(months) + GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S155"); }
        return IntToString(months / 12) + GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S156");
    }

    private static func GenerateRipperdoc(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S157"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S158"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S159"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S160"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S161"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S162"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S163"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S164"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S165"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S166");
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            if RandRange(seed + 5, 1, 100) <= 70 {
                let i = RandRange(seed, 0, 4);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S167"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S168"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S169"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S170"); }
                return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S171");
            }
        }
        
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                let i = RandRange(seed, 0, 14);
                if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T209"); }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S172"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S173"); }
                if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T210"); }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S1"); }
                if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T0"); }
                if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S174"); }
                if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S0"); }
                if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S2"); }
                if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S175"); }
                if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S176"); }
                if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S177"); }
                if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S178"); }
                if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S179"); }
                return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S180");
            }
        }

        // Standard ripperdocs (30 options)
        let i = RandRange(seed, 0, 29);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S181"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S182"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S183"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S184"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S185"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S186"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S187"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T211"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S188"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S189"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S190"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S191"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S192"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S193"); }
        if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S194"); }
        if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S195"); }
        if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S196"); }
        if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S197"); }
        if i == 18 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S198"); }
        if i == 19 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S199"); }
        if i == 20 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S200"); }
        if i == 21 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S201"); }
        if i == 22 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S202"); }
        if i == 23 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S203"); }
        if i == 24 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S204"); }
        if i == 25 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S205"); }
        if i == 26 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T212"); }
        if i == 27 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S206"); }
        if i == 28 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S207"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S208");
    }

    private static func GenerateWarrantyStatus(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if wealth >= 70 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S209"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S210"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S211"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S212"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S213"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T213"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S214"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S215"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S216"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S217");
        }
        
        if wealth >= 40 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T214"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T215"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T216"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S218"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S219"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S220"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S221"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T217"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S222"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S223");
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 14);
        if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T215"); }
        if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T218"); }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S224"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S225"); }
        if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T219"); }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S226"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S227"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S228"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S229"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S230"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S231"); }
        if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T220"); }
        if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-T221"); }
        if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S232"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S233");
    }
}

public class KdspCyberwareRegistryData {
    public let totalImplants: Int32;
    public let implants: array<ref<KdspCyberwareImplant>>;
    public let hasIllegalCyberware: Bool;
    public let illegalCount: Int32;
    public let cyberpsychosisRisk: Int32;
    public let cyberpsychosisStatus: String;
    public let hasRejectedImplants: Bool;
    public let rejectedImplants: array<String>;
    public let lastRipperdocVisit: String;
    public let preferredRipperdoc: String;
    public let warrantyStatus: String;
}

public class KdspCyberwareImplant {
    public let name: String;
    public let slot: String;
    public let manufacturer: String;
    public let isLegal: Bool;
    public let condition: String;
    public let installYear: Int32;
    public let grade: String;
}
