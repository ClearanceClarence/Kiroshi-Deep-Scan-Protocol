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

    public static func ShouldUseVanillaScanner(target: wref<NPCPuppet>) -> Bool {
        let recordId: String = TDBID.ToStringDEBUG(target.GetRecordID());
        let recordLower: String = StrLower(recordId);

        // ── q112: Automatic Love — Arasaka Industrial Park Guard ──────
        // Guard at the side entrance. Player must scan him to eavesdrop
        // on his conversation for quest progression.
        if StrContains(recordLower, "corpo__arasaka_ma_guard") {
            let appearance: String = NameToString(target.GetCurrentAppearanceName());
            if StrContains(appearance, "guard__lvl2_02") {
                return true;
            };
        };

        return false;
    }
}
