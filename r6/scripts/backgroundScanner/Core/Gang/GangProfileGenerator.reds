// Gang Profile Generator - Main Entry Point
// Delegates to individual gang profile classes for generation

public class GangProfileGenerator {

    public static func Generate(seed: Int32, gangAffiliation: String, appearanceName: String, gender: String) -> ref<DetailedGangProfile> {
        
        // Delegate to gang-specific generators
        if Equals(gangAffiliation, "TYGER_CLAWS") {
            return TygerClawsProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "MAELSTROM") {
            return MaelstromProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "VALENTINOS") {
            return ValentinosProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "6TH_STREET") {
            return SixthStreetProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "ANIMALS") {
            return AnimalsProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "VOODOO_BOYS") {
            return VoodooBoysProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "MOXES") {
            return MoxesProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "SCAVENGERS") {
            return ScavengersProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "WRAITHS") {
            return WraithsProfile.Generate(seed, appearanceName, gender);
        }
        if Equals(gangAffiliation, "ALDECALDOS") {
            return AldecaldosProfile.Generate(seed, appearanceName, gender);
        }
        
        // Fallback for unknown gangs
        return GangProfileGenerator.GenerateGeneric(seed, gangAffiliation, gender);
    }

    private static func GenerateGeneric(seed: Int32, gangAffiliation: String, gender: String) -> ref<DetailedGangProfile> {
        let profile: ref<DetailedGangProfile> = new DetailedGangProfile();
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
