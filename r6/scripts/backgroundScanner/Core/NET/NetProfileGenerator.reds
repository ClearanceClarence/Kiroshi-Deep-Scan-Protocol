// Kiroshi Deep Scan - NET Profile Generator
// Network activity, darknet presence, and browsing habits

public abstract class KdspNetProfileGenerator {

    public static func GenerateNetProfile(seed: Int32, archetype: String, gangAffiliation: String) -> String {
        let result: String = "";

        let isCorpo = Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE");
        let isGanger = !Equals(gangAffiliation, "NONE");

        // Social media presence
        let socialRoll = RandRange(seed, 0, 7);
        if isCorpo {
            if socialRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S0"); }
            else if socialRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S1"); }
            else if socialRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S2"); }
            else if socialRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S3"); }
            else if socialRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S4"); }
            else if socialRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S5"); }
            else if socialRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S6"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S7"); }
        } else if isGanger {
            if socialRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S8"); }
            else if socialRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S9"); }
            else if socialRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S10"); }
            else if socialRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S11"); }
            else if socialRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S12"); }
            else if socialRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S13"); }
            else if socialRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S14"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S15"); }
        } else {
            if socialRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S16"); }
            else if socialRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S17"); }
            else if socialRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S18"); }
            else if socialRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S19"); }
            else if socialRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S20"); }
            else if socialRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S21"); }
            else if socialRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S22"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S23"); }
        }

        // Known aliases (40% chance)
        let aliasRoll = RandRange(seed + 100, 1, 100);
        if aliasRoll <= 40 {
            result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S24") + KdspNetAliases.GenerateAlias(seed + 101) + "\"";
        }

        // Browsing flags / activity (50% chance)
        let browseRoll = RandRange(seed + 200, 1, 100);
        if browseRoll <= 50 {
            let browseType = RandRange(seed + 201, 0, 9);
            if browseType == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S25"); }
            else if browseType == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S26"); }
            else if browseType == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S27"); }
            else if browseType == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S28"); }
            else if browseType == 4 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S29"); }
            else if browseType == 5 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S30"); }
            else if browseType == 6 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S31"); }
            else if browseType == 7 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S32"); }
            else if browseType == 8 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S33"); }
            else { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S34"); }
        }

        // Darknet activity level
        let darkRoll = RandRange(seed + 300, 0, 9);
        if isGanger || darkRoll <= 1 {
            let darkLevel = RandRange(seed + 301, 0, 4);
            if darkLevel == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S35"); }
            else if darkLevel == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S36"); }
            else if darkLevel == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S37"); }
            else if darkLevel == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S38"); }
            else { result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S39"); }
        } else if darkRoll <= 4 {
            result = result + GetLocalizedTextByKey(n"Kdsp-NetProfileGene-S40");
        }

        return result;
    }
}
