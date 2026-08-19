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
            ArrayPush(docs, "Gang-affiliated ripperdoc");
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

        implant.slot = "Body Modification";
        
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
        if m == 0 { implant.manufacturer = "Biosyn Medical"; }
        else if m == 1 { implant.manufacturer = "Raven Microcyber"; }
        else if m == 2 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S26"); }
        else if m == 3 { implant.manufacturer = GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S27"); }
        else if m == 4 { implant.manufacturer = "BodyWorks Ltd."; }
        else if m == 5 { implant.manufacturer = "Arasaka Biotech"; }
        else if m == 6 { implant.manufacturer = "Zetatech Medical"; }
        else if m == 7 { implant.manufacturer = "TransForm Cybernetics"; }
        else if m == 8 { implant.manufacturer = "NewYou Industries"; }
        else { implant.manufacturer = "Biotechnica Wellness"; }
        
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
        if i == 5 { return "Operating System"; }
        if i == 6 { return "Arms"; }
        if i == 7 { return "Legs"; }
        if i == 8 { return "Hands"; }
        if i == 9 { return "Frontal Cortex"; }
        if i == 10 { return "Nervous System"; }
        if i == 11 { return "Immune System"; }
        if i == 12 { return "Cardiovascular"; }
        if i == 13 { return "Musculature"; }
        return "Internal Organs";
    }

    private static func GetImplantForSlot(seed: Int32, slot: String, archetype: String) -> String {
        if Equals(slot, "Optics") {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S28"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S29"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S30"); }
            if i == 3 { return "Kiroshi Cockatrice"; }
            if i == 4 { return "Kiroshi Doomsayer"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S31"); }
            if i == 6 { return "Threat Detector"; }
            if i == 7 { return "Trajectory Analysis"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S32"); }
            if i == 9 { return "Infrared Scanner"; }
            if i == 10 { return "Zoom Enhancement"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S33"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S34"); }
            if i == 13 { return "Reticle Overlay"; }
            if i == 14 { return "Weakspot Detection"; }
            if i == 15 { return "Thermographic Scanner"; }
            if i == 16 { return "Combat HUD"; }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S35"); }
            if i == 18 { return "Cyberoptic Scanner"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S36");
        }
        
        if Equals(slot, "Neural") {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Neural Link"; }
            if i == 1 { return "Kerenzikov"; }
            if i == 2 { return "Sandevistan Mk.1"; }
            if i == 3 { return "Sandevistan Mk.2"; }
            if i == 4 { return "Sandevistan Mk.3"; }
            if i == 5 { return "Synaptic Accelerator"; }
            if i == 6 { return "Memory Boost"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S37"); }
            if i == 8 { return "Pain Editor"; }
            if i == 9 { return "Reflex Tuner"; }
            if i == 10 { return "Neural Processor"; }
            if i == 11 { return "Cognitive Controller"; }
            if i == 12 { return "Sensory Amplifier"; }
            if i == 13 { return "Reaction Enhancer"; }
            if i == 14 { return "Adrenaline Converter"; }
            if i == 15 { return "Neofiber"; }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S38"); }
            if i == 17 { return "Maneuvering System"; }
            if i == 18 { return "Reflex Booster"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S39");
        }
        
        if Equals(slot, "Circulatory") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Biomonitor"; }
            if i == 1 { return "Blood Pump"; }
            if i == 2 { return "Syn-Lungs"; }
            if i == 3 { return "Second Heart"; }
            if i == 4 { return "Adrenaline Booster"; }
            if i == 5 { return "Toxin Binder"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S40"); }
            if i == 7 { return "Microgenerator"; }
            if i == 8 { return "Metabolic Editor"; }
            if i == 9 { return "Blood Oxygenator"; }
            if i == 10 { return "Detoxifier"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S41"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S42"); }
            if i == 13 { return "Heal-on-Kill"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S43");
        }
        
        if Equals(slot, "Skeletal") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Titanium Bones"; }
            if i == 1 { return "Dense Marrow"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S44"); }
            if i == 3 { return "Microrotors"; }
            if i == 4 { return "Para Bellum"; }
            if i == 5 { return "Kinetic Frame"; }
            if i == 6 { return "Bionic Joints"; }
            if i == 7 { return "Shock Absorbers"; }
            if i == 8 { return "Spring Joints"; }
            if i == 9 { return "Epimorphic Skeleton"; }
            if i == 10 { return "Micro-Vibration Motor"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S45"); }
            if i == 12 { return "Hardened Skeleton"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S46"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S47");
        }
        
        if Equals(slot, "Integumentary") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Subdermal Armor"; }
            if i == 1 { return "Fireproof Coating"; }
            if i == 2 { return "Grounding Plating"; }
            if i == 3 { return "Heat Converter"; }
            if i == 4 { return "Optical Camo"; }
            if i == 5 { return "Subdermal Weave"; }
            if i == 6 { return "Nano-Plating"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S48"); }
            if i == 8 { return "Chitin Shell"; }
            if i == 9 { return "Shock-n-Awe"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S49"); }
            if i == 11 { return "Thermal Regulator"; }
            if i == 12 { return "EMP Shielding"; }
            if i == 13 { return "Self-Healing Dermis"; }
            return "Skinweave";
        }
        
        if Equals(slot, "Operating System") {
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Militech Paraline"; }
            if i == 1 { return "Arasaka MKV"; }
            if i == 2 { return "NetWatch Netdriver"; }
            if i == 3 { return "Raven Microcyber"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S50"); }
            if i == 5 { return "Tetratronic Rippler"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S51"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S52"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S53"); }
            if i == 9 { return "Zetatech Sandevistan"; }
            if i == 10 { return "Dynalar Sandevistan"; }
            if i == 11 { return "QianT Sandevistan"; }
            if i == 12 { return "Militech Falcon"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S54"); }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S55"); }
            if i == 15 { return "Netdriver Mk.5"; }
            if i == 16 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S56"); }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S57"); }
            if i == 18 { return "Standard Cyberdeck"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S58");
        }
        
        if Equals(slot, "Arms") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Gorilla Arms"; }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S59"); }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S60"); }
            if i == 3 { return "Mantis Blades"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S61"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S62"); }
            if i == 6 { return "Monowire"; }
            if i == 7 { return "Monowire (Electrical)"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S63"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S64"); }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S65"); }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S66"); }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S67"); }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S68"); }
            return "Partial Cyberarm";
        }
        
        if Equals(slot, "Legs") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Reinforced Tendons"; }
            if i == 1 { return "Fortified Ankles"; }
            if i == 2 { return "Lynx Paws"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S69"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S70"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S71"); }
            if i == 6 { return "Jenkins Tendons"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S72"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S73"); }
            if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S74"); }
            if i == 10 { return "Hover System"; }
            return "Partial Cyberleg";
        }
        
        if Equals(slot, "Hands") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Ballistic Coprocessor"; }
            if i == 1 { return "Smart Link"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S75"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S76"); }
            if i == 4 { return "Power Grip"; }
            if i == 5 { return "Precision Targeting"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S77"); }
            if i == 7 { return "Recoil Dampener"; }
            if i == 8 { return "Grip Enhancement"; }
            if i == 9 { return "Feedback Circuit"; }
            if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S78"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S79");
        }
        
        if Equals(slot, "Frontal Cortex") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Mechatronic Core"; }
            if i == 1 { return "Ex-Disk"; }
            if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S80"); }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S81"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S82"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S37"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S83"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S84"); }
            if i == 8 { return "Memory Bank"; }
            if i == 9 { return "Self-ICE"; }
            if i == 10 { return "Bioconductor"; }
            if i == 11 { return "Heal-on-Kill Processor"; }
            if i == 12 { return "Behavioral Coprocessor"; }
            if i == 13 { return "Attention Coprocessor"; }
            return "Logic Coprocessor";
        }
        
        if Equals(slot, "Nervous System") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Synaptic Accelerator"; }
            if i == 1 { return "Kerenzikov"; }
            if i == 2 { return "Reflex Tuner"; }
            if i == 3 { return "Neofiber"; }
            if i == 4 { return "Tyrosine Injector"; }
            if i == 5 { return "Adrenaline Surge"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S85"); }
            if i == 7 { return "Pain Inhibitor"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S86"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S87");
        }
        
        if Equals(slot, "Immune System") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Cataresist"; }
            if i == 1 { return "Inductor"; }
            if i == 2 { return "Toxin Binder"; }
            if i == 3 { return "Detoxifier"; }
            if i == 4 { return "Nano-Antibodies"; }
            if i == 5 { return "Pathogen Filter"; }
            if i == 6 { return "Rad Shield"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S88"); }
            if i == 8 { return "Auto-Immune Booster"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S89");
        }
        
        if Equals(slot, "Cardiovascular") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Second Heart"; }
            if i == 1 { return "Blood Pump"; }
            if i == 2 { return "Bioconductor"; }
            if i == 3 { return "Syn-Heart"; }
            if i == 4 { return "Cardiac Regulator"; }
            if i == 5 { return "Oxygen Boost"; }
            if i == 6 { return "Stamina Enhancer"; }
            if i == 7 { return "Emergency Bypass"; }
            if i == 8 { return "Clotting System"; }
            return "Vascular Implant";
        }
        
        if Equals(slot, "Musculature") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S90"); }
            if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S91"); }
            if i == 2 { return "Power Amplifier"; }
            if i == 3 { return "Reflex Muscle"; }
            if i == 4 { return "Micro-Generator Muscles"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S92"); }
            if i == 6 { return "Slow-Twitch Enhancer"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S93"); }
            if i == 8 { return "Core Stabilizer"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S94");
        }
        
        if Equals(slot, "Internal Organs") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Synthetic Liver"; }
            if i == 1 { return "Synthetic Kidney"; }
            if i == 2 { return "Synthetic Stomach"; }
            if i == 3 { return "Metabolic Optimizer"; }
            if i == 4 { return "Digestive Enhancement"; }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S95"); }
            if i == 6 { return "Nutrient Extractor"; }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S96"); }
            if i == 8 { return "Waste Recycler"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S97");
        }
        
        return "Generic Implant";
    }

    private static func GetManufacturer(seed: Int32, wealth: Int32, archetype: String) -> String {
        // Weight selection based on wealth
        if wealth >= 70 || Equals(archetype, "CORPO_MANAGER") {
            // Premium manufacturers (20)
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Arasaka"; }
            if i == 1 { return "Arasaka Biotech"; }
            if i == 2 { return "Militech"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S98"); }
            if i == 4 { return "Kiroshi"; }
            if i == 5 { return "Kiroshi Group"; }
            if i == 6 { return "Zetatech"; }
            if i == 7 { return "Zetatech Medical"; }
            if i == 8 { return "Dynalar"; }
            if i == 9 { return "Raven Microcybernetics"; }
            if i == 10 { return "Kang Tao"; }
            if i == 11 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S99"); }
            if i == 12 { return "Biotechnica"; }
            if i == 13 { return "Biotechnica Premium"; }
            if i == 14 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S100"); }
            if i == 15 { return "Petrochem Biotech"; }
            if i == 16 { return "QianT"; }
            if i == 17 { return "Fuyutsuki Electronics"; }
            if i == 18 { return "Stephenson Technologies"; }
            return "NetWatch Certified";
        }
        
        if wealth >= 40 {
            // Mid-range manufacturers (20)
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Arasaka"; }
            if i == 1 { return "Militech"; }
            if i == 2 { return "Kiroshi"; }
            if i == 3 { return "Zetatech"; }
            if i == 4 { return "Raven Microcybernetics"; }
            if i == 5 { return "Kendachi"; }
            if i == 6 { return "Tsunami Defense"; }
            if i == 7 { return "Biotechnica"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S101"); }
            if i == 9 { return "BudgetArms Cyber"; }
            if i == 10 { return "SovOil Cybertech"; }
            if i == 11 { return "EuroCorps Medical"; }
            if i == 12 { return "IEC Implants"; }
            if i == 13 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S102"); }
            if i == 14 { return "Continental Brands"; }
            if i == 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S103"); }
            if i == 16 { return "Standard Cybernetics"; }
            if i == 17 { return "MediCorp"; }
            if i == 18 { return "CyberMed Inc."; }
            return "GenCyber";
        }
        
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            // Black market / Budget (20)
            let i = RandRange(seed, 0, 19);
            if i == 0 { return "Unknown Manufacturer"; }
            if i == 1 { return "Scav-Sourced"; }
            if i == 2 { return "Homemade"; }
            if i == 3 { return "Bootleg"; }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S104"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S105"); }
            if i == 6 { return "Salvaged"; }
            if i == 7 { return "Gang Workshop"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S106"); }
            if i == 9 { return "Pirated Firmware"; }
            if i == 10 { return "BudgetArms Cyber"; }
            if i == 11 { return "Kendachi"; }
            if i == 12 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S101"); }
            if i == 13 { return "Second-Hand"; }
            if i == 14 { return "Refurbished"; }
            if i == 15 { return "Gray Market"; }
            if i == 16 { return "Maelstrom Modified"; }
            if i == 17 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S107"); }
            if i == 18 { return "Animals Sourced"; }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S108");
        }
        
        // Budget default (15)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "BudgetArms Cyber"; }
        if i == 1 { return "Kendachi"; }
        if i == 2 { return "Tsunami Defense"; }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S101"); }
        if i == 4 { return "Standard Cybernetics"; }
        if i == 5 { return "MediCorp"; }
        if i == 6 { return "GenCyber"; }
        if i == 7 { return "CheapWare"; }
        if i == 8 { return "ValueCyber"; }
        if i == 9 { return "Economy Implants"; }
        if i == 10 { return "BasicCyber Corp"; }
        if i == 11 { return "City Medical"; }
        if i == 12 { return "Community Clinic"; }
        if i == 13 { return "Refurbished"; }
        return "Unknown Brand";
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
        if roll >= 90 { return "Factory New"; }
        if roll >= 85 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S110"); }
        if roll >= 80 { return "Excellent"; }
        if roll >= 75 { return "Very Good"; }
        if roll >= 70 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S111"); }
        if roll >= 60 { return "Good"; }
        if roll >= 50 { return "Satisfactory"; }
        if roll >= 40 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S112"); }
        if roll >= 35 { return "Fair"; }
        if roll >= 30 { return "Worn"; }
        if roll >= 25 { return "Degraded"; }
        if roll >= 20 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S113"); }
        if roll >= 15 { return "Poor"; }
        if roll >= 10 { return "Failing"; }
        if roll >= 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S114"); }
        return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S115");
    }

    private static func GetGrade(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100) + (wealth / 3);
        
        if roll >= 98 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S116"); }
        if roll >= 95 { return "Legendary"; }
        if roll >= 90 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S117"); }
        if roll >= 85 { return "Epic"; }
        if roll >= 80 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S118"); }
        if roll >= 75 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S119"); }
        if roll >= 70 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S120"); }
        if roll >= 65 { return "Rare"; }
        if roll >= 55 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S121"); }
        if roll >= 45 { return "Uncommon"; }
        if roll >= 35 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S122"); }
        if roll >= 25 { return "Common"; }
        if roll >= 15 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S123"); }
        if roll >= 10 { return "Junk Grade"; }
        return "Salvage Grade";
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
        if risk >= 95 { return "CRITICAL - MAXTAC FLAGGED"; }
        if risk >= 90 { return "CRITICAL - CYBERPSYCHO SYMPTOMS PRESENT"; }
        if risk >= 85 { return "CRITICAL - IMMEDIATE INTERVENTION REQUIRED"; }
        if risk >= 80 { return "CRITICAL - IMMINENT BREAKDOWN"; }
        if risk >= 75 { return "SEVERE - MANDATORY TREATMENT"; }
        if risk >= 70 { return "SEVERE - FREQUENT EPISODES"; }
        if risk >= 65 { return "HIGH - THERAPY REQUIRED"; }
        if risk >= 60 { return "HIGH - MONITORING REQUIRED"; }
        if risk >= 55 { return "HIGH - REGULAR ASSESSMENT NEEDED"; }
        if risk >= 50 { return "ELEVATED - WARNING SIGNS PRESENT"; }
        if risk >= 45 { return "ELEVATED - BORDERLINE"; }
        if risk >= 40 { return "ELEVATED - REGULAR CHECKUPS ADVISED"; }
        if risk >= 35 { return "MODERATE-HIGH - MONITOR CLOSELY"; }
        if risk >= 30 { return "MODERATE - OCCASIONAL SYMPTOMS"; }
        if risk >= 25 { return "MODERATE - WITHIN ACCEPTABLE RANGE"; }
        if risk >= 20 { return "MODERATE - WITHIN NORMAL PARAMETERS"; }
        if risk >= 15 { return "LOW-MODERATE - STABLE"; }
        if risk >= 10 { return "LOW - MINIMAL RISK"; }
        if risk >= 5 { return "LOW - STABLE"; }
        return "MINIMAL - EXCELLENT STABILITY";
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
                if i == 0 { return "Unknown (unlicensed)"; }
                if i == 1 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S172"); }
                if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S173"); }
                if i == 3 { return "Self-installed"; }
                if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S1"); }
                if i == 5 { return "Gang-affiliated ripperdoc"; }
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
        if i == 7 { return "Octavio, Arroyo"; }
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
        if i == 26 { return "Dogtown Clinic"; }
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
            if i == 5 { return "Comprehensive Coverage"; }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S214"); }
            if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S215"); }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S216"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S217");
        }
        
        if wealth >= 40 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Standard Coverage"; }
            if i == 1 { return "Basic Coverage"; }
            if i == 2 { return "Limited Warranty"; }
            if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S218"); }
            if i == 4 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S219"); }
            if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S220"); }
            if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S221"); }
            if i == 7 { return "Partial Coverage"; }
            if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S222"); }
            return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S223");
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "Basic Coverage"; }
        if i == 1 { return "Warranty Expired"; }
        if i == 2 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S224"); }
        if i == 3 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S225"); }
        if i == 4 { return "No Warranty"; }
        if i == 5 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S226"); }
        if i == 6 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S227"); }
        if i == 7 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S228"); }
        if i == 8 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S229"); }
        if i == 9 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S230"); }
        if i == 10 { return GetLocalizedTextByKey(n"Kdsp-CyberwareRegis-S231"); }
        if i == 11 { return "Never Registered"; }
        if i == 12 { return "Registration Pending"; }
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
