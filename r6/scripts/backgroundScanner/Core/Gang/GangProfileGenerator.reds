// Gang Profile Generator - Main Entry Point
// Delegates to individual gang profile classes for generation

public class KdspGangProfileGenerator {

    public static func Generate(seed: Int32, gangAffiliation: String, appearanceName: String, gender: String) -> ref<KdspDetailedGangProfile> {
        
        // Delegate to gang-specific generators
        if Equals(gangAffiliation, "TYGER_CLAWS") {
            return KdspTygerClawsProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "MAELSTROM") {
            return KdspMaelstromProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "VALENTINOS") {
            return KdspValentinosProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "6TH_STREET") {
            return KdspSixthStreetProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "ANIMALS") {
            return KdspAnimalsProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "VOODOO_BOYS") {
            return KdspVoodooBoysProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "MOXES") {
            return KdspMoxesProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "SCAVENGERS") {
            return KdspScavengersProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "WRAITHS") {
            return KdspWraithsProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "ALDECALDOS") {
            return KdspAldecaldosProfile.Generate(seed, appearanceName, gender);
        }
        
        // Fallback for unknown gangs
        return KdspGangProfileGenerator.GenerateGeneric(seed, gangAffiliation, gender);
    }

    private static func GenerateGeneric(seed: Int32, gangAffiliation: String, gender: String) -> ref<KdspDetailedGangProfile> {
        let profile: ref<KdspDetailedGangProfile> = new KdspDetailedGangProfile();
        profile.gangAffiliation = gangAffiliation;
        profile.gangName = gangAffiliation;
        profile.headerLabel = "GANG MEMBER FILE";
        
        let roll = RandRange(seed, 1, 100);
        if roll <= 50 { profile.rank = "Member"; }
        else if roll <= 80 { profile.rank = "Veteran"; }
        else { profile.rank = "Senior"; }
        profile.rankMeaning = "";
        
        profile.role = "Street Operations";
        profile.territory = "Unknown";
        profile.yearsActive = RandRange(seed + 300, 1, 10);
        profile.bodyCount = RandRange(seed + 400, 0, 20);
        profile.arrestCount = RandRange(seed + 500, 0, 5);
        profile.loyaltyRating = "UNKNOWN";
        profile.background = "Gang member with standard criminal background.";
        profile.recentActivity = "Active in local operations.";
        profile.status = "ACTIVE";
        
        return profile;
    }
}
