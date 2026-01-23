// Cyberware Registry Generation System
public class CyberwareRegistryManager {

    public static func Generate(seed: Int32, archetype: String, wealth: Int32) -> ref<CyberwareRegistryData> {
        let registry: ref<CyberwareRegistryData> = new CyberwareRegistryData();

        // Determine cyberware count based on archetype and wealth
        let cyberwareCount = CyberwareRegistryManager.GetCyberwareCount(seed, archetype, wealth);
        registry.totalImplants = cyberwareCount;

        // Generate individual cyberware entries
        let i = 0;
        while i < cyberwareCount {
            let cyberware = CyberwareRegistryManager.GenerateCyberware(seed + (i * 123), archetype, wealth);
            ArrayPush(registry.implants, cyberware);
            
            if !cyberware.isLegal {
                registry.hasIllegalCyberware = true;
                registry.illegalCount += 1;
            }
            i += 1;
        }

        // Body Modification cyberware - 20% chance when enabled (lore-friendly for Night City)
        if KiroshiSettings.BodyModRecordsEnabled() && RandRange(seed + 450, 1, 100) <= 20 {
            let bodyMod = CyberwareRegistryManager.GenerateBodyModCyberware(seed + 460, wealth);
            ArrayPush(registry.implants, bodyMod);
            registry.totalImplants += 1;
        }

        // Calculate cyberpsychosis risk
        registry.cyberpsychosisRisk = CyberwareRegistryManager.CalculateCyberpsychosisRisk(seed + 500, registry.implants, archetype);
        registry.cyberpsychosisStatus = CyberwareRegistryManager.GetCyberpsychosisStatus(registry.cyberpsychosisRisk);

        // Generate rejected/failed implants
        if RandRange(seed + 600, 1, 100) <= 20 {
            registry.hasRejectedImplants = true;
            let rejectCount = RandRange(seed + 610, 1, 3);
            i = 0;
            while i < rejectCount {
                ArrayPush(registry.rejectedImplants, CyberwareRegistryManager.GenerateRejectedImplant(seed + 700 + (i * 50)));
                i += 1;
            }
        }

        // Last ripperdoc visit
        registry.lastRipperdocVisit = CyberwareRegistryManager.GenerateLastVisit(seed + 800);
        registry.preferredRipperdoc = CyberwareRegistryManager.GenerateRipperdoc(seed + 900, archetype);

        // Warranty status
        registry.warrantyStatus = CyberwareRegistryManager.GenerateWarrantyStatus(seed + 1000, wealth);

        return registry;
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

    private static func GenerateCyberware(seed: Int32, archetype: String, wealth: Int32) -> ref<CyberwareImplant> {
        let implant: ref<CyberwareImplant> = new CyberwareImplant();

        // Select slot
        implant.slot = CyberwareRegistryManager.GetRandomSlot(seed);
        
        // Select implant based on slot
        implant.name = CyberwareRegistryManager.GetImplantForSlot(seed + 10, implant.slot, archetype);
        
        // Select manufacturer
        implant.manufacturer = CyberwareRegistryManager.GetManufacturer(seed + 20, wealth, archetype);
        
        // Determine legality
        implant.isLegal = CyberwareRegistryManager.DetermineIfLegal(seed + 30, archetype, implant.name);
        
        // Condition
        implant.condition = CyberwareRegistryManager.GetCondition(seed + 40, wealth);
        
        // Installation year
        implant.installYear = RandRange(seed + 50, 2065, 2077);

        // Grade
        implant.grade = CyberwareRegistryManager.GetGrade(seed + 60, wealth);

        return implant;
    }

    private static func GenerateBodyModCyberware(seed: Int32, wealth: Int32) -> ref<CyberwareImplant> {
        let implant: ref<CyberwareImplant> = new CyberwareImplant();

        implant.slot = "Body Modification";
        
        // Select body mod implant type
        let implants: array<String>;
        ArrayPush(implants, "Hormonal Regulation Implant");
        ArrayPush(implants, "Voice Modulator (Feminine)");
        ArrayPush(implants, "Voice Modulator (Masculine)");
        ArrayPush(implants, "Voice Modulator (Androgynous)");
        ArrayPush(implants, "Biosculpt Integration Suite");
        ArrayPush(implants, "Dermal Contouring System");
        ArrayPush(implants, "Full Body Biosculpt Package");
        ArrayPush(implants, "Skeletal Feminization Frame");
        ArrayPush(implants, "Skeletal Masculinization Frame");
        ArrayPush(implants, "Gender Confirmation Suite");
        ArrayPush(implants, "Hormone Synthesis Module");
        
        implant.name = implants[RandRange(seed, 0, ArraySize(implants) - 1)];
        
        // Body mod manufacturers
        let manufacturers: array<String>;
        ArrayPush(manufacturers, "Biosyn Medical");
        ArrayPush(manufacturers, "Raven Microcyber");
        ArrayPush(manufacturers, "Night City Medical");
        ArrayPush(manufacturers, "Chrome & Flesh Inc.");
        ArrayPush(manufacturers, "BodyWorks Ltd.");
        ArrayPush(manufacturers, "Arasaka Biotech");
        ArrayPush(manufacturers, "Zetatech Medical");
        
        implant.manufacturer = manufacturers[RandRange(seed + 10, 0, ArraySize(manufacturers) - 1)];
        
        // Body mods are always legal (medical cyberware)
        implant.isLegal = true;
        
        // Condition based on wealth
        implant.condition = CyberwareRegistryManager.GetCondition(seed + 20, wealth);
        
        // Installation year
        implant.installYear = RandRange(seed + 30, 2068, 2077);

        // Grade based on wealth
        implant.grade = CyberwareRegistryManager.GetGrade(seed + 40, wealth);

        return implant;
    }

    private static func GetRandomSlot(seed: Int32) -> String {
        let slots: array<String>;
        ArrayPush(slots, "Optics");
        ArrayPush(slots, "Neural");
        ArrayPush(slots, "Circulatory");
        ArrayPush(slots, "Skeletal");
        ArrayPush(slots, "Integumentary");
        ArrayPush(slots, "Operating System");
        ArrayPush(slots, "Arms");
        ArrayPush(slots, "Legs");
        ArrayPush(slots, "Hands");
        ArrayPush(slots, "Frontal Cortex");
        
        return slots[RandRange(seed, 0, ArraySize(slots) - 1)];
    }

    private static func GetImplantForSlot(seed: Int32, slot: String, archetype: String) -> String {
        let implants: array<String>;

        if Equals(slot, "Optics") {
            ArrayPush(implants, "Kiroshi Optics Mk.1");
            ArrayPush(implants, "Kiroshi Optics Mk.2");
            ArrayPush(implants, "Kiroshi Optics Mk.3");
            ArrayPush(implants, "Basic Optic Enhancer");
            ArrayPush(implants, "Threat Detector");
            ArrayPush(implants, "Trajectory Analysis");
            ArrayPush(implants, "Low-Light Vision Mod");
        }
        else if Equals(slot, "Neural") {
            ArrayPush(implants, "Neural Link");
            ArrayPush(implants, "Kerenzikov");
            ArrayPush(implants, "Sandevistan");
            ArrayPush(implants, "Synaptic Accelerator");
            ArrayPush(implants, "Memory Boost");
            ArrayPush(implants, "Limbic System Enhancement");
            ArrayPush(implants, "Pain Editor");
        }
        else if Equals(slot, "Circulatory") {
            ArrayPush(implants, "Biomonitor");
            ArrayPush(implants, "Blood Pump");
            ArrayPush(implants, "Syn-Lungs");
            ArrayPush(implants, "Second Heart");
            ArrayPush(implants, "Adrenaline Booster");
            ArrayPush(implants, "Toxin Binder");
            ArrayPush(implants, "Bioplastic Blood Vessels");
        }
        else if Equals(slot, "Skeletal") {
            ArrayPush(implants, "Titanium Bones");
            ArrayPush(implants, "Dense Marrow");
            ArrayPush(implants, "Synaptic Signal Optimizer");
            ArrayPush(implants, "Microrotors");
            ArrayPush(implants, "Para Bellum");
            ArrayPush(implants, "Kinetic Frame");
        }
        else if Equals(slot, "Integumentary") {
            ArrayPush(implants, "Subdermal Armor");
            ArrayPush(implants, "Fireproof Coating");
            ArrayPush(implants, "Grounding Plating");
            ArrayPush(implants, "Heat Converter");
            ArrayPush(implants, "Optical Camo");
        }
        else if Equals(slot, "Operating System") {
            ArrayPush(implants, "Militech Paraline");
            ArrayPush(implants, "Arasaka MKV");
            ArrayPush(implants, "NetWatch Netdriver");
            ArrayPush(implants, "Raven Microcyber");
            ArrayPush(implants, "Stephenson Tech Mk.4");
            ArrayPush(implants, "Tetratronic Rippler");
            ArrayPush(implants, "Biodyne Berserk");
        }
        else if Equals(slot, "Arms") {
            ArrayPush(implants, "Gorilla Arms");
            ArrayPush(implants, "Mantis Blades");
            ArrayPush(implants, "Monowire");
            ArrayPush(implants, "Projectile Launch System");
            ArrayPush(implants, "Standard Cyberlimb");
        }
        else if Equals(slot, "Legs") {
            ArrayPush(implants, "Reinforced Tendons");
            ArrayPush(implants, "Fortified Ankles");
            ArrayPush(implants, "Lynx Paws");
            ArrayPush(implants, "Standard Cyberlimb");
        }
        else if Equals(slot, "Hands") {
            ArrayPush(implants, "Ballistic Coprocessor");
            ArrayPush(implants, "Smart Link");
            ArrayPush(implants, "Tattoo: Tyger Claws Dermal Imprint");
            ArrayPush(implants, "Tattoo: Security Decryption Coprocessor");
        }
        else if Equals(slot, "Frontal Cortex") {
            ArrayPush(implants, "Mechatronic Core");
            ArrayPush(implants, "Ex-Disk");
            ArrayPush(implants, "RAM Upgrade");
            ArrayPush(implants, "Limbic System Enhancement");
            ArrayPush(implants, "Visual Cortex Support");
        }
        else if Equals(slot, "Body Modification") {
            // Gender-affirming and body modification cyberware (lore-friendly for Night City)
            ArrayPush(implants, "Hormonal Regulation Implant");
            ArrayPush(implants, "Voice Modulator (Feminine)");
            ArrayPush(implants, "Voice Modulator (Masculine)");
            ArrayPush(implants, "Voice Modulator (Androgynous)");
            ArrayPush(implants, "Biosculpt Integration Suite");
            ArrayPush(implants, "Dermal Contouring System");
            ArrayPush(implants, "Full Body Biosculpt Package");
            ArrayPush(implants, "Skeletal Feminization/Masculinization Frame");
            ArrayPush(implants, "Gender Confirmation Suite");
            ArrayPush(implants, "Hormone Synthesis Module");
        }
        else {
            ArrayPush(implants, "Generic Implant");
        }

        return implants[RandRange(seed, 0, ArraySize(implants) - 1)];
    }

    private static func GetManufacturer(seed: Int32, wealth: Int32, archetype: String) -> String {
        let manufacturers: array<String>;
        
        // Premium manufacturers
        ArrayPush(manufacturers, "Arasaka");
        ArrayPush(manufacturers, "Militech");
        ArrayPush(manufacturers, "Kiroshi");
        ArrayPush(manufacturers, "Zetatech");
        ArrayPush(manufacturers, "Dynalar");
        ArrayPush(manufacturers, "Raven Microcybernetics");
        ArrayPush(manufacturers, "Kang Tao");
        
        // Budget manufacturers
        ArrayPush(manufacturers, "BudgetArms Cyber");
        ArrayPush(manufacturers, "Kendachi");
        ArrayPush(manufacturers, "Tsunami Defense");
        ArrayPush(manufacturers, "Biotechnica");
        ArrayPush(manufacturers, "Night City Cybernetics");
        
        // Black market / Unknown
        ArrayPush(manufacturers, "Unknown Manufacturer");
        ArrayPush(manufacturers, "Scav-Sourced");
        ArrayPush(manufacturers, "Homemade");
        ArrayPush(manufacturers, "Bootleg");

        // Weight selection based on wealth
        let roll = RandRange(seed, 1, 100);
        if wealth >= 70 || Equals(archetype, "CORPO_MANAGER") {
            return manufacturers[RandRange(seed + 5, 0, 6)]; // Premium
        } else if wealth >= 40 {
            return manufacturers[RandRange(seed + 5, 0, 11)]; // Mix
        } else if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            if roll <= 40 {
                return manufacturers[RandRange(seed + 5, 12, ArraySize(manufacturers) - 1)]; // Black market
            }
            return manufacturers[RandRange(seed + 5, 7, 11)]; // Budget
        }
        return manufacturers[RandRange(seed + 5, 7, 11)]; // Budget default
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
        
        if roll >= 90 { return "Factory New"; }
        if roll >= 75 { return "Excellent"; }
        if roll >= 55 { return "Good"; }
        if roll >= 35 { return "Fair"; }
        if roll >= 20 { return "Poor"; }
        return "Critical - Needs Replacement";
    }

    private static func GetGrade(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100) + (wealth / 3);
        
        if roll >= 95 { return "Legendary"; }
        if roll >= 80 { return "Epic"; }
        if roll >= 60 { return "Rare"; }
        if roll >= 35 { return "Uncommon"; }
        return "Common";
    }

    private static func CalculateCyberpsychosisRisk(seed: Int32, implants: array<ref<CyberwareImplant>>, archetype: String) -> Int32 {
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
        if risk >= 80 { return "CRITICAL - IMMEDIATE INTERVENTION RECOMMENDED"; }
        if risk >= 60 { return "HIGH - MONITORING REQUIRED"; }
        if risk >= 40 { return "ELEVATED - REGULAR CHECKUPS ADVISED"; }
        if risk >= 20 { return "MODERATE - WITHIN NORMAL PARAMETERS"; }
        return "LOW - STABLE";
    }

    private static func GenerateRejectedImplant(seed: Int32) -> String {
        let rejections: array<String>;
        ArrayPush(rejections, "Subdermal Armor (immune rejection)");
        ArrayPush(rejections, "Neural Link v1 (incompatible genetics)");
        ArrayPush(rejections, "Syn-Lungs (allergic reaction)");
        ArrayPush(rejections, "Kiroshi Optics Mk.1 (nerve damage)");
        ArrayPush(rejections, "Gorilla Arms (skeletal incompatibility)");
        ArrayPush(rejections, "Sandevistan (cardiac complications)");
        ArrayPush(rejections, "Memory Boost (seizure inducing)");
        ArrayPush(rejections, "Second Heart (clotting disorder)");
        
        return rejections[RandRange(seed, 0, ArraySize(rejections) - 1)];
    }

    private static func GenerateLastVisit(seed: Int32) -> String {
        let months = RandRange(seed, 1, 24);
        if months == 1 { return "1 month ago"; }
        if months <= 12 { return IntToString(months) + " months ago"; }
        return IntToString(months / 12) + " year(s) ago";
    }

    private static func GenerateRipperdoc(seed: Int32, archetype: String) -> String {
        let docs: array<String>;
        
        // Legitimate ripperdocs
        ArrayPush(docs, "Viktor Vektor, Watson");
        ArrayPush(docs, "Dr. Chrome, Westbrook");
        ArrayPush(docs, "Cassius Ryder, Wellsprings");
        ArrayPush(docs, "Charles Bucks, Kabuki");
        ArrayPush(docs, "Instant Implants, City Center");
        ArrayPush(docs, "Doc Ryder, Northside");
        ArrayPush(docs, "Fingers M.D., Jig-Jig Street");
        ArrayPush(docs, "Octavio, Arroyo");
        ArrayPush(docs, "Nina Kraviz, Pacifica");
        
        // Black market
        ArrayPush(docs, "Unknown (unlicensed)");
        ArrayPush(docs, "Street Clinic, Pacifica");
        ArrayPush(docs, "Scav Operation (records unclear)");
        ArrayPush(docs, "Self-installed");

        if Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "YUPPIE") {
            return "Arasaka Medical Division (Corporate Plan)";
        }
        if Equals(archetype, "CORPO_DRONE") {
            if RandRange(seed + 5, 1, 100) <= 70 {
                return "Corporate Health Services";
            }
        }
        if Equals(archetype, "GANGER") || Equals(archetype, "LOWLIFE") {
            if RandRange(seed + 5, 1, 100) <= 40 {
                return docs[RandRange(seed + 10, 9, ArraySize(docs) - 1)];
            }
        }

        return docs[RandRange(seed, 0, 8)];
    }

    private static func GenerateWarrantyStatus(seed: Int32, wealth: Int32) -> String {
        let roll = RandRange(seed, 1, 100);
        
        if wealth >= 70 {
            if roll <= 60 { return "Full Coverage (Platinum Plan)"; }
            if roll <= 90 { return "Standard Coverage"; }
            return "Extended Warranty Active";
        }
        if wealth >= 40 {
            if roll <= 30 { return "Standard Coverage"; }
            if roll <= 60 { return "Basic Coverage"; }
            if roll <= 80 { return "Warranty Expired"; }
            return "No Warranty";
        }
        
        if roll <= 20 { return "Basic Coverage"; }
        if roll <= 50 { return "Warranty Expired"; }
        return "No Warranty";
    }
}

public class CyberwareRegistryData {
    public let totalImplants: Int32;
    public let implants: array<ref<CyberwareImplant>>;
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

public class CyberwareImplant {
    public let name: String;
    public let slot: String;
    public let manufacturer: String;
    public let isLegal: Bool;
    public let condition: String;
    public let installYear: Int32;
    public let grade: String;
}
