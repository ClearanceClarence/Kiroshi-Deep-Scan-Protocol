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
            ArrayPush(docs, "Unlicensed clinic (Kabuki)");
            ArrayPush(docs, "Back-alley doc (Watson)");
            ArrayPush(docs, "Black market surgeon");
            ArrayPush(docs, "Gang-affiliated ripperdoc");
            ArrayPush(docs, "Scav chop shop survivor");
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
                ArrayPush(statuses, "VOID - Non-payment");
                ArrayPush(statuses, "VOID - Unauthorized mods");
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
        if i == 0 { implant.name = "Hormonal Regulation Implant"; }
        else if i == 1 { implant.name = "Voice Modulator (Feminine)"; }
        else if i == 2 { implant.name = "Voice Modulator (Masculine)"; }
        else if i == 3 { implant.name = "Voice Modulator (Androgynous)"; }
        else if i == 4 { implant.name = "Biosculpt Integration Suite"; }
        else if i == 5 { implant.name = "Dermal Contouring System"; }
        else if i == 6 { implant.name = "Full Body Biosculpt Package"; }
        else if i == 7 { implant.name = "Skeletal Feminization Frame"; }
        else if i == 8 { implant.name = "Skeletal Masculinization Frame"; }
        else if i == 9 { implant.name = "Gender Confirmation Suite"; }
        else if i == 10 { implant.name = "Hormone Synthesis Module"; }
        else if i == 11 { implant.name = "Facial Reconstruction Suite"; }
        else if i == 12 { implant.name = "Body Proportion Adjuster"; }
        else if i == 13 { implant.name = "Height Modification System"; }
        else if i == 14 { implant.name = "Vocal Cord Replacement"; }
        else if i == 15 { implant.name = "Cosmetic Dermal Implants"; }
        else if i == 16 { implant.name = "Appearance Alteration Suite"; }
        else if i == 17 { implant.name = "Biosculpted Features Package"; }
        else if i == 18 { implant.name = "Identity Reassignment Implants"; }
        else { implant.name = "Comprehensive Body Modification"; }
        
        // Body mod manufacturers (10 options)
        let m = RandRange(seed + 10, 0, 9);
        if m == 0 { implant.manufacturer = "Biosyn Medical"; }
        else if m == 1 { implant.manufacturer = "Raven Microcyber"; }
        else if m == 2 { implant.manufacturer = "Night City Medical"; }
        else if m == 3 { implant.manufacturer = "Chrome & Flesh Inc."; }
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
            if i == 0 { return "Kiroshi Optics Mk.1"; }
            if i == 1 { return "Kiroshi Optics Mk.2"; }
            if i == 2 { return "Kiroshi Optics Mk.3"; }
            if i == 3 { return "Kiroshi Cockatrice"; }
            if i == 4 { return "Kiroshi Doomsayer"; }
            if i == 5 { return "Basic Optic Enhancer"; }
            if i == 6 { return "Threat Detector"; }
            if i == 7 { return "Trajectory Analysis"; }
            if i == 8 { return "Low-Light Vision Mod"; }
            if i == 9 { return "Infrared Scanner"; }
            if i == 10 { return "Zoom Enhancement"; }
            if i == 11 { return "Target Analysis System"; }
            if i == 12 { return "Facial Recognition Suite"; }
            if i == 13 { return "Reticle Overlay"; }
            if i == 14 { return "Weakspot Detection"; }
            if i == 15 { return "Thermographic Scanner"; }
            if i == 16 { return "Combat HUD"; }
            if i == 17 { return "Targeting Reticle Mk.1"; }
            if i == 18 { return "Cyberoptic Scanner"; }
            return "Budget Ocular Implant";
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
            if i == 7 { return "Limbic System Enhancement"; }
            if i == 8 { return "Pain Editor"; }
            if i == 9 { return "Reflex Tuner"; }
            if i == 10 { return "Neural Processor"; }
            if i == 11 { return "Cognitive Controller"; }
            if i == 12 { return "Sensory Amplifier"; }
            if i == 13 { return "Reaction Enhancer"; }
            if i == 14 { return "Adrenaline Converter"; }
            if i == 15 { return "Neofiber"; }
            if i == 16 { return "Kerenzikov Boost System"; }
            if i == 17 { return "Maneuvering System"; }
            if i == 18 { return "Reflex Booster"; }
            return "Basic Neural Interface";
        }
        
        if Equals(slot, "Circulatory") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Biomonitor"; }
            if i == 1 { return "Blood Pump"; }
            if i == 2 { return "Syn-Lungs"; }
            if i == 3 { return "Second Heart"; }
            if i == 4 { return "Adrenaline Booster"; }
            if i == 5 { return "Toxin Binder"; }
            if i == 6 { return "Bioplastic Blood Vessels"; }
            if i == 7 { return "Microgenerator"; }
            if i == 8 { return "Metabolic Editor"; }
            if i == 9 { return "Blood Oxygenator"; }
            if i == 10 { return "Detoxifier"; }
            if i == 11 { return "Emergency Clotting System"; }
            if i == 12 { return "Adrenal Surge Regulator"; }
            if i == 13 { return "Heal-on-Kill"; }
            return "Blood Flow Optimizer";
        }
        
        if Equals(slot, "Skeletal") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Titanium Bones"; }
            if i == 1 { return "Dense Marrow"; }
            if i == 2 { return "Synaptic Signal Optimizer"; }
            if i == 3 { return "Microrotors"; }
            if i == 4 { return "Para Bellum"; }
            if i == 5 { return "Kinetic Frame"; }
            if i == 6 { return "Bionic Joints"; }
            if i == 7 { return "Shock Absorbers"; }
            if i == 8 { return "Spring Joints"; }
            if i == 9 { return "Epimorphic Skeleton"; }
            if i == 10 { return "Micro-Vibration Motor"; }
            if i == 11 { return "Sway Reduction System"; }
            if i == 12 { return "Hardened Skeleton"; }
            if i == 13 { return "Carry Capacity Boost"; }
            return "Reinforced Bone Lacing";
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
            if i == 7 { return "Ballistic Dermal Plating"; }
            if i == 8 { return "Chitin Shell"; }
            if i == 9 { return "Shock-n-Awe"; }
            if i == 10 { return "Pain Suppressor Skin"; }
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
            if i == 4 { return "Stephenson Tech Mk.4"; }
            if i == 5 { return "Tetratronic Rippler"; }
            if i == 6 { return "Biodyne Berserk Mk.1"; }
            if i == 7 { return "Biodyne Berserk Mk.2"; }
            if i == 8 { return "Biodyne Berserk Mk.3"; }
            if i == 9 { return "Zetatech Sandevistan"; }
            if i == 10 { return "Dynalar Sandevistan"; }
            if i == 11 { return "QianT Sandevistan"; }
            if i == 12 { return "Militech Falcon"; }
            if i == 13 { return "Fuyutsuki Electronics Mk.1"; }
            if i == 14 { return "Fuyutsuki Electronics Mk.2"; }
            if i == 15 { return "Netdriver Mk.5"; }
            if i == 16 { return "Arasaka Quickhack Array"; }
            if i == 17 { return "Militech Combat OS"; }
            if i == 18 { return "Standard Cyberdeck"; }
            return "Budget Operating System";
        }
        
        if Equals(slot, "Arms") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Gorilla Arms"; }
            if i == 1 { return "Gorilla Arms (Thermal)"; }
            if i == 2 { return "Gorilla Arms (Electric)"; }
            if i == 3 { return "Mantis Blades"; }
            if i == 4 { return "Mantis Blades (Thermal)"; }
            if i == 5 { return "Mantis Blades (Chemical)"; }
            if i == 6 { return "Monowire"; }
            if i == 7 { return "Monowire (Electrical)"; }
            if i == 8 { return "Projectile Launch System"; }
            if i == 9 { return "Launcher - Explosive"; }
            if i == 10 { return "Launcher - Tranquilizer"; }
            if i == 11 { return "Standard Cyberlimb (Left)"; }
            if i == 12 { return "Standard Cyberlimb (Right)"; }
            if i == 13 { return "Full Cyberarm Replacement"; }
            return "Partial Cyberarm";
        }
        
        if Equals(slot, "Legs") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Reinforced Tendons"; }
            if i == 1 { return "Fortified Ankles"; }
            if i == 2 { return "Lynx Paws"; }
            if i == 3 { return "Standard Cyberleg (Left)"; }
            if i == 4 { return "Standard Cyberleg (Right)"; }
            if i == 5 { return "Full Cyberleg Replacement"; }
            if i == 6 { return "Jenkins Tendons"; }
            if i == 7 { return "Leeroy Ligament System"; }
            if i == 8 { return "Speed Boosting Legs"; }
            if i == 9 { return "Jump Enhancement System"; }
            if i == 10 { return "Hover System"; }
            return "Partial Cyberleg";
        }
        
        if Equals(slot, "Hands") {
            let i = RandRange(seed, 0, 11);
            if i == 0 { return "Ballistic Coprocessor"; }
            if i == 1 { return "Smart Link"; }
            if i == 2 { return "Tattoo: Tyger Claws Dermal Imprint"; }
            if i == 3 { return "Tattoo: Security Decryption Coprocessor"; }
            if i == 4 { return "Power Grip"; }
            if i == 5 { return "Precision Targeting"; }
            if i == 6 { return "Steadying Hand Mod"; }
            if i == 7 { return "Recoil Dampener"; }
            if i == 8 { return "Grip Enhancement"; }
            if i == 9 { return "Feedback Circuit"; }
            if i == 10 { return "Technical Aptitude Coprocessor"; }
            return "Standard Hand Cyberware";
        }
        
        if Equals(slot, "Frontal Cortex") {
            let i = RandRange(seed, 0, 14);
            if i == 0 { return "Mechatronic Core"; }
            if i == 1 { return "Ex-Disk"; }
            if i == 2 { return "RAM Upgrade Mk.1"; }
            if i == 3 { return "RAM Upgrade Mk.2"; }
            if i == 4 { return "RAM Upgrade Mk.3"; }
            if i == 5 { return "Limbic System Enhancement"; }
            if i == 6 { return "Visual Cortex Support"; }
            if i == 7 { return "Camillo RAM Manager"; }
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
            if i == 6 { return "Nerve Speed Enhancer"; }
            if i == 7 { return "Pain Inhibitor"; }
            if i == 8 { return "Sensory Overload Protector"; }
            return "Basic Nerve Boost";
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
            if i == 7 { return "Viral Resistance Module"; }
            if i == 8 { return "Auto-Immune Booster"; }
            return "Basic Immune Enhancer";
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
            if i == 0 { return "Bionic Muscle Fiber"; }
            if i == 1 { return "Synthetic Muscle Enhancement"; }
            if i == 2 { return "Power Amplifier"; }
            if i == 3 { return "Reflex Muscle"; }
            if i == 4 { return "Micro-Generator Muscles"; }
            if i == 5 { return "Fast-Twitch Fiber Mod"; }
            if i == 6 { return "Slow-Twitch Enhancer"; }
            if i == 7 { return "Grip Strength Boost"; }
            if i == 8 { return "Core Stabilizer"; }
            return "Standard Muscle Boost";
        }
        
        if Equals(slot, "Internal Organs") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Synthetic Liver"; }
            if i == 1 { return "Synthetic Kidney"; }
            if i == 2 { return "Synthetic Stomach"; }
            if i == 3 { return "Metabolic Optimizer"; }
            if i == 4 { return "Digestive Enhancement"; }
            if i == 5 { return "Toxin Processing Unit"; }
            if i == 6 { return "Nutrient Extractor"; }
            if i == 7 { return "Internal Air Filter"; }
            if i == 8 { return "Waste Recycler"; }
            return "Organ Support System";
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
            if i == 3 { return "Militech Advanced Systems"; }
            if i == 4 { return "Kiroshi"; }
            if i == 5 { return "Kiroshi Group"; }
            if i == 6 { return "Zetatech"; }
            if i == 7 { return "Zetatech Medical"; }
            if i == 8 { return "Dynalar"; }
            if i == 9 { return "Raven Microcybernetics"; }
            if i == 10 { return "Kang Tao"; }
            if i == 11 { return "Kang Tao Medical"; }
            if i == 12 { return "Biotechnica"; }
            if i == 13 { return "Biotechnica Premium"; }
            if i == 14 { return "Trauma Team Medical"; }
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
            if i == 8 { return "Night City Cybernetics"; }
            if i == 9 { return "BudgetArms Cyber"; }
            if i == 10 { return "SovOil Cybertech"; }
            if i == 11 { return "EuroCorps Medical"; }
            if i == 12 { return "IEC Implants"; }
            if i == 13 { return "Orbital Air Medical"; }
            if i == 14 { return "Continental Brands"; }
            if i == 15 { return "All Foods Medical"; }
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
            if i == 4 { return "Street Doc Special"; }
            if i == 5 { return "Black Market Import"; }
            if i == 6 { return "Salvaged"; }
            if i == 7 { return "Gang Workshop"; }
            if i == 8 { return "Chop Shop Reclaimed"; }
            if i == 9 { return "Pirated Firmware"; }
            if i == 10 { return "BudgetArms Cyber"; }
            if i == 11 { return "Kendachi"; }
            if i == 12 { return "Night City Cybernetics"; }
            if i == 13 { return "Second-Hand"; }
            if i == 14 { return "Refurbished"; }
            if i == 15 { return "Gray Market"; }
            if i == 16 { return "Maelstrom Modified"; }
            if i == 17 { return "Voodoo Boys Tech"; }
            if i == 18 { return "Animals Sourced"; }
            return "6th Street Supply";
        }
        
        // Budget default (15)
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "BudgetArms Cyber"; }
        if i == 1 { return "Kendachi"; }
        if i == 2 { return "Tsunami Defense"; }
        if i == 3 { return "Night City Cybernetics"; }
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
        
        if roll >= 95 { return "Factory New - Pristine"; }
        if roll >= 90 { return "Factory New"; }
        if roll >= 85 { return "Excellent - Like New"; }
        if roll >= 80 { return "Excellent"; }
        if roll >= 75 { return "Very Good"; }
        if roll >= 70 { return "Good - Minor Wear"; }
        if roll >= 60 { return "Good"; }
        if roll >= 50 { return "Satisfactory"; }
        if roll >= 40 { return "Fair - Signs of Use"; }
        if roll >= 35 { return "Fair"; }
        if roll >= 30 { return "Worn"; }
        if roll >= 25 { return "Degraded"; }
        if roll >= 20 { return "Poor - Maintenance Required"; }
        if roll >= 15 { return "Poor"; }
        if roll >= 10 { return "Failing"; }
        if roll >= 5 { return "Critical - Needs Replacement"; }
        return "Dangerous - Immediate Attention";
    }

    private static func GetGrade(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100) + (wealth / 3);
        
        if roll >= 98 { return "Legendary - Iconic"; }
        if roll >= 95 { return "Legendary"; }
        if roll >= 90 { return "Epic - Modified"; }
        if roll >= 85 { return "Epic"; }
        if roll >= 80 { return "Epic - Standard"; }
        if roll >= 75 { return "Rare - Enhanced"; }
        if roll >= 70 { return "Rare - Modified"; }
        if roll >= 65 { return "Rare"; }
        if roll >= 55 { return "Uncommon - Quality"; }
        if roll >= 45 { return "Uncommon"; }
        if roll >= 35 { return "Common - Good"; }
        if roll >= 25 { return "Common"; }
        if roll >= 15 { return "Common - Budget"; }
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
        if i == 0 { return "Subdermal Armor (immune rejection)"; }
        if i == 1 { return "Neural Link v1 (incompatible genetics)"; }
        if i == 2 { return "Syn-Lungs (allergic reaction)"; }
        if i == 3 { return "Kiroshi Optics Mk.1 (nerve damage)"; }
        if i == 4 { return "Gorilla Arms (skeletal incompatibility)"; }
        if i == 5 { return "Sandevistan (cardiac complications)"; }
        if i == 6 { return "Memory Boost (seizure inducing)"; }
        if i == 7 { return "Second Heart (clotting disorder)"; }
        if i == 8 { return "Mantis Blades (tissue rejection)"; }
        if i == 9 { return "Monowire (neural pathway damage)"; }
        
        // Technical failure (10-19)
        if i == 10 { return "Cyberdeck v1 (firmware incompatible)"; }
        if i == 11 { return "Reflex Tuner (signal interference)"; }
        if i == 12 { return "Kerenzikov (heart arrhythmia)"; }
        if i == 13 { return "Titanium Bones (bone density mismatch)"; }
        if i == 14 { return "Blood Pump (valve failure)"; }
        if i == 15 { return "Adrenaline Booster (overproduction crisis)"; }
        if i == 16 { return "Pain Editor (sensory loss)"; }
        if i == 17 { return "Optical Camo (skin necrosis)"; }
        if i == 18 { return "Reinforced Tendons (mobility loss)"; }
        if i == 19 { return "Biomonitor (false readings)"; }
        
        // Psychological rejection (20-29)
        if i == 20 { return "Limbic Enhancement (personality changes)"; }
        if i == 21 { return "Synaptic Accelerator (anxiety inducing)"; }
        if i == 22 { return "RAM Upgrade (memory fragmentation)"; }
        if i == 23 { return "Berserk OS (uncontrollable rage)"; }
        if i == 24 { return "Cyberlimb (phantom pain syndrome)"; }
        if i == 25 { return "Facial Reconstruction (identity dissociation)"; }
        if i == 26 { return "Voice Modulator (speech dysphoria)"; }
        if i == 27 { return "Sensory Amp (sensory overload)"; }
        if i == 28 { return "Cognitive Processor (decision paralysis)"; }
        return "Full Cyberarm (body dysmorphia)";
    }

    private static func GenerateLastVisit(seed: Int32) -> String {
        let months = RandRange(seed, 1, 24);
        if months == 1 { return "1 month ago"; }
        if months <= 12 { return IntToString(months) + " months ago"; }
        return IntToString(months / 12) + " year(s) ago";
    }

    private static func GenerateRipperdoc(seed: Int32, archetype: String) -> String {
        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Arasaka Medical Division (Corporate Plan)"; }
            if i == 1 { return "Militech Health Services (Executive)"; }
            if i == 2 { return "Trauma Team Platinum Care"; }
            if i == 3 { return "Biotechnica Premium Wellness"; }
            if i == 4 { return "Kang Tao Executive Medical"; }
            if i == 5 { return "Night City Medical Center (VIP)"; }
            if i == 6 { return "Charter Hill Private Clinic"; }
            if i == 7 { return "Westbrook Wellness Center"; }
            if i == 8 { return "Corporate Concierge Medical"; }
            return "Private Practice (Retained)";
        }
        
        if Equals(archetype, "CORPO_DRONE") {
            if RandRange(seed + 5, 1, 100) <= 70 {
                let i = RandRange(seed, 0, 4);
                if i == 0 { return "Corporate Health Services"; }
                if i == 1 { return "Arasaka Employee Medical"; }
                if i == 2 { return "Militech Staff Clinic"; }
                if i == 3 { return "Company Insurance Network"; }
                return "Corporate HMO Provider";
            }
        }
        
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            if RandRange(seed + 5, 1, 100) <= 50 {
                let i = RandRange(seed, 0, 14);
                if i == 0 { return "Unknown (unlicensed)"; }
                if i == 1 { return "Street Clinic (Pacifica)"; }
                if i == 2 { return "Scav Operation (records unclear)"; }
                if i == 3 { return "Self-installed"; }
                if i == 4 { return "Back-alley doc (Watson)"; }
                if i == 5 { return "Gang-affiliated ripperdoc"; }
                if i == 6 { return "Maelstrom Chop Shop"; }
                if i == 7 { return "Unlicensed clinic (Kabuki)"; }
                if i == 8 { return "Black market surgeon"; }
                if i == 9 { return "Cargo container clinic"; }
                if i == 10 { return "Basement operation (Northside)"; }
                if i == 11 { return "Mobile clinic (untraceable)"; }
                if i == 12 { return "Combat medic (former)"; }
                if i == 13 { return "Veterinary clinic (after hours)"; }
                return "Friend of a friend";
            }
        }

        // Standard ripperdocs (30 options)
        let i = RandRange(seed, 0, 29);
        if i == 0 { return "Viktor Vektor, Watson"; }
        if i == 1 { return "Dr. Chrome, Westbrook"; }
        if i == 2 { return "Cassius Ryder, Wellsprings"; }
        if i == 3 { return "Charles Bucks, Kabuki"; }
        if i == 4 { return "Instant Implants, City Center"; }
        if i == 5 { return "Doc Ryder, Northside"; }
        if i == 6 { return "Fingers M.D., Jig-Jig Street"; }
        if i == 7 { return "Octavio, Arroyo"; }
        if i == 8 { return "Nina Kraviz, Pacifica"; }
        if i == 9 { return "Robert, Rancho Coronado"; }
        if i == 10 { return "Buck, Santo Domingo"; }
        if i == 11 { return "Kraviz Clinic, Coastview"; }
        if i == 12 { return "Japantown Cyberware Clinic"; }
        if i == 13 { return "Little China Implant Center"; }
        if i == 14 { return "Heywood Medical Plaza"; }
        if i == 15 { return "Wellsprings Health Center"; }
        if i == 16 { return "Northside Industrial Med"; }
        if i == 17 { return "Kabuki Market Clinic"; }
        if i == 18 { return "Glen Ripperdoc Services"; }
        if i == 19 { return "Vista del Rey Medical"; }
        if i == 20 { return "Rancho Coronado Clinic"; }
        if i == 21 { return "Arroyo Community Health"; }
        if i == 22 { return "Downtown Implant Center"; }
        if i == 23 { return "Watson Cyberware Clinic"; }
        if i == 24 { return "Corpo Plaza Medical (basic)"; }
        if i == 25 { return "Charter Hill Ripperdoc"; }
        if i == 26 { return "Dogtown Clinic"; }
        if i == 27 { return "Pacifica Free Clinic"; }
        if i == 28 { return "Stadium City Medical"; }
        return "Local Neighborhood Ripperdoc";
    }

    private static func GenerateWarrantyStatus(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if wealth >= 70 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Full Coverage (Platinum Plan)"; }
            if i == 1 { return "Full Coverage (Corporate Executive)"; }
            if i == 2 { return "Premium Protection Plus"; }
            if i == 3 { return "Lifetime Warranty (Transferable)"; }
            if i == 4 { return "Extended Warranty Active"; }
            if i == 5 { return "Comprehensive Coverage"; }
            if i == 6 { return "Standard Coverage + Upgrades"; }
            if i == 7 { return "Trauma Team Cyber Package"; }
            if i == 8 { return "Arasaka Elite Protection"; }
            return "Militech Security Warranty";
        }
        
        if wealth >= 40 {
            let i = RandRange(seed, 0, 9);
            if i == 0 { return "Standard Coverage"; }
            if i == 1 { return "Basic Coverage"; }
            if i == 2 { return "Limited Warranty"; }
            if i == 3 { return "Extended Warranty (3 years)"; }
            if i == 4 { return "Parts Only Coverage"; }
            if i == 5 { return "Labor Only Coverage"; }
            if i == 6 { return "Warranty Expired (Renewable)"; }
            if i == 7 { return "Partial Coverage"; }
            if i == 8 { return "Emergency Repairs Only"; }
            return "Standard Plan - Current";
        }
        
        // Low wealth
        let i = RandRange(seed, 0, 14);
        if i == 0 { return "Basic Coverage"; }
        if i == 1 { return "Warranty Expired"; }
        if i == 2 { return "Warranty Expired (2074)"; }
        if i == 3 { return "Warranty Expired (2075)"; }
        if i == 4 { return "No Warranty"; }
        if i == 5 { return "No Warranty - Used Parts"; }
        if i == 6 { return "No Warranty - Black Market"; }
        if i == 7 { return "VOID - Unauthorized Mods"; }
        if i == 8 { return "VOID - Non-Payment"; }
        if i == 9 { return "VOID - Illegal Modifications"; }
        if i == 10 { return "VOID - Self-Installation"; }
        if i == 11 { return "Never Registered"; }
        if i == 12 { return "Registration Pending"; }
        if i == 13 { return "Unknown - No Records"; }
        return "Salvage - No Warranty";
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
