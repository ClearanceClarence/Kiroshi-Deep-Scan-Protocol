public class LifePath {
    public let hasParents: Bool;
    public let archetype: String;
    public let career: String;
    public let position: String;
    public let company: String;
    public let gender: String;
    public let background: String;
    public let seed: Int32;
    public let possibleEvents: ref<LifePathPossibilities>;

    public static func Create(target: wref<NPCPuppet>) -> ref<LifePath> {
		let self: ref<LifePath> = new LifePath();
        self.gender = self.GetGender(target);
        self.archetype = self.GetCrowdArchetype(target);
        self.possibleEvents = new LifePathPossibilities();
        self.possibleEvents.Initialize(self.archetype);
		return self;
	}

    private func GetGender(target: wref<NPCPuppet>) -> String {
        let resolvedBodyType = NameToString(target.GetBodyType());
        if Equals(resolvedBodyType, "ManBig") ||  Equals(resolvedBodyType, "ManAverage") ||  Equals(resolvedBodyType, "ManFat") {
            return "male";
        } else {
            return "female";
        }
    }

    private func GetCrowdArchetype(target: wref<NPCPuppet>) -> String {
        let resolvedApperanceName = NameToString(target.GetCurrentAppearanceName());

        if StrContains(resolvedApperanceName, "corporat_ma") || StrContains(resolvedApperanceName, "corpo_ma") {
            return "CORPO_MANAGER";
        }
        if StrContains(resolvedApperanceName, "corporat_wa") || StrContains(resolvedApperanceName, "corpo_wa") || StrContains(resolvedApperanceName, "corpo") {
            return "CORPO_DRONE";
        }
        if StrContains(resolvedApperanceName, "nomad")  {
            return "NOMAD";
        }
        if StrContains(resolvedApperanceName, "homeless")  {
            return "HOMELESS";
        }
        if StrContains(resolvedApperanceName, "junkie")  {
            return "JUNKIE";
        }
        if StrContains(resolvedApperanceName, "lowlife") || StrContains(resolvedApperanceName, "poor")   {
            return "LOWLIFE";
        }
        if StrContains(resolvedApperanceName, "rich")  {
            return "YUPPIE";
        }
        return "CIVVIE";
    }
}