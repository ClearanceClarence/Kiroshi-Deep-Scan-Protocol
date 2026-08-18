// ============================================================================
//  KdspQuestScannerExclusions.reds
//  Kiroshi Deep Scan Protocol — Quest-Critical Scanner Exclusions
//
//  Some quest NPCs use the vanilla scanner for mission progression —
//  eavesdropping, quest data overlays, or scan-triggered objectives.
//  If we override their scanner output, the quest breaks.
//
//  This file is a simple exclusion list. Any NPC matched here gets
//  vanilla scanner behavior with zero mod interference.
//
//  To add new exclusions: add a check in ShouldUseVanillaScanner().
//  Use the record ID (TweakDBID) for precision, appearance name for
//  broader patterns.
// ============================================================================

public abstract class KdspQuestScannerExclusions {

    // Takes precomputed identity strings from CompileScannerChunks
    public static func ShouldUseVanillaScannerPrecomputed(recordLower: String, appearance: String) -> Bool {
        // ── q112: Automatic Love — Arasaka Industrial Park Guard ──────
        // Guard at the side entrance. Player must scan him to eavesdrop
        // on his conversation for quest progression.
        if StrContains(recordLower, "corpo__arasaka_ma_guard") && StrContains(appearance, "guard__lvl2_02") {
            return true;
        };

        return false;
    }

    public static func ShouldUseVanillaScanner(target: wref<NPCPuppet>) -> Bool {
        let recordLower: String = StrLower(TDBID.ToStringDEBUG(target.GetRecordID()));
        let appearance: String = NameToString(target.GetCurrentAppearanceName());
        return KdspQuestScannerExclusions.ShouldUseVanillaScannerPrecomputed(recordLower, appearance);
    }
}
