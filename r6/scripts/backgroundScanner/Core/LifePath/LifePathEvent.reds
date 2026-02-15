/* Wrapper object for event text, likelihood of event occurence, and any additional stats conferred by the event */
public class KdspLifePathEvent {

    // Female and Male Strings
    public let femaleVariant: String;
    public let maleVariant: String;

    // Stat modifications that the event confers
    public let wealthMod: Int32;
    public let intMod: Int32;
    public let coolMod: Int32;
    public let bodyMod: Int32;
    public let reflexMod: Int32;
    public let techMod: Int32;

    // Likelihood of the event occuring
    public let weight: Int32;

    // Returns the correct gendered text string
    public func GetText(gender: String) -> String {
        if Equals(gender, "female") {
            return this.femaleVariant;
        } else {
            if Equals(this.maleVariant, "") {
                return this.femaleVariant;
            } else {
                return this.maleVariant;
            }
        }
    }

    /*
    * Setters
    *
    * These methods use an accessor chaining strategy that allows us to chain them together when setting one stat after another. 
    */
    public func SetWealthMod(wealthMod: Int32) -> ref<KdspLifePathEvent> {
        this.wealthMod = wealthMod;
        return this;
    }

    public func SetIntMod(intMod: Int32) -> ref<KdspLifePathEvent> {
        this.intMod = intMod;
        return this;
    }

    public func SetBodyMod(bodyMod: Int32) -> ref<KdspLifePathEvent> {
        this.bodyMod = bodyMod;
        return this;
    }

    public func SetCoolMod(coolMod: Int32) -> ref<KdspLifePathEvent> {
        this.coolMod = coolMod;
        return this;
    }

    public func SetReflexMod(reflexMod: Int32) -> ref<KdspLifePathEvent> {
        this.reflexMod = reflexMod;
        return this;
    }

    public func SetTechMod(techMod: Int32) -> ref<KdspLifePathEvent> {
        this.techMod = techMod;
        return this;
    }
}

// Create a new KdspLifePathEvent with the given female/male strings.
public static func LPE(femaleVariant: String, maleVariant: String) -> ref<KdspLifePathEvent> {
    let event = new KdspLifePathEvent();
    event.femaleVariant = femaleVariant;
    event.maleVariant = maleVariant;
    return event;
}