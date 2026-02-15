@wrapMethod(NPCPuppet)
public const func CompileScannerChunks() -> Bool {
    let scannerBlackboard: wref<IBlackboard>;
    let backstoryChunk: ref<KdspScannerBackstory>;

    // Safety check - ensure we have a valid game instance
    let game = this.GetGame();
    if !GameInstance.IsValid(game) {
        return wrappedMethod();
    }

    scannerBlackboard = GameInstance.GetBlackboardSystem(game).Get(GetAllBlackboardDefs().UI_ScannerModules);
    if !IsDefined(scannerBlackboard) {
        return wrappedMethod();
    }

    // First check: Is this a unique/named NPC with a hand-crafted backstory?
    if KdspUniqueNPCManager.IsUniqueNPC(this) {
        let uniqueBackstory = KdspUniqueNPCManager.GetBackstory(this);
        if IsDefined(uniqueBackstory) {
            backstoryChunk = new KdspScannerBackstory();
            let backstoryUI = uniqueBackstory.ToBackstoryUI();
            
            // Add debug info if enabled
            if KdspSettings.DebugModeEnabled() {
                let recordID = this.GetRecordID();
                let appearanceName = NameToString(this.GetCurrentAppearanceName());
                backstoryUI.debugInfo = "TweakDBID: " + TDBID.ToStringDEBUG(recordID) + "\nAppearance: " + appearanceName;
            }
            
            backstoryChunk.Set(backstoryUI);
            scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.KdspScannerBackstory, ToVariant(backstoryChunk));
            return wrappedMethod();
        }
    }

    // Second check: Generate procedural backstories for generic NPCs
    // - Crowd NPCs (random pedestrians)
    // - Generic gang members
    // - Generic police/NCPD
    let shouldGenerate = this.IsHuman() && (this.IsCrowd() || this.IsCharacterGanger() || this.IsCharacterPolice() || this.IsPrevention());

    // Skip corporate/military combat NPCs - only actual soldiers, not employees
    if shouldGenerate {
        let appearanceName = NameToString(this.GetCurrentAppearanceName());
        // Skip military/tactical units that shouldn't have civilian backstories
        if StrContains(appearanceName, "militech_soldier") || 
           StrContains(appearanceName, "militech_mech") ||
           StrContains(appearanceName, "arasaka_soldier") || 
           StrContains(appearanceName, "arasaka_ninja") ||
           StrContains(appearanceName, "arasaka_mech") ||
           StrContains(appearanceName, "kang_tao_soldier") || 
           StrContains(appearanceName, "trauma_team") || 
           StrContains(appearanceName, "ranger") || 
           StrContains(appearanceName, "netwatch") || 
           StrContains(appearanceName, "max_tac") || 
           StrContains(appearanceName, "maxtac") {
            shouldGenerate = false;
        }
    }

    if shouldGenerate {
        let backstoryUI = KdspBackstoryManager.GenerateBackstoryUI(this);
        
        // Add debug info if enabled
        if KdspSettings.DebugModeEnabled() {
            let recordID = this.GetRecordID();
            let appearanceName = NameToString(this.GetCurrentAppearanceName());
            backstoryUI.debugInfo = "TweakDBID: " + TDBID.ToStringDEBUG(recordID) + "\nAppearance: " + appearanceName;
        }
        
        backstoryChunk = new KdspScannerBackstory();
        backstoryChunk.Set(backstoryUI);
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.KdspScannerBackstory, ToVariant(backstoryChunk));
    } else {
        backstoryChunk = new KdspScannerBackstory();
        
        // Still show debug info for skipped NPCs if debug mode enabled
        if KdspSettings.DebugModeEnabled() {
            let backstoryUI: KdspBackstoryUI;
            let recordID = this.GetRecordID();
            let appearanceName = NameToString(this.GetCurrentAppearanceName());
            backstoryUI.debugInfo = "TweakDBID: " + TDBID.ToStringDEBUG(recordID) + "\nAppearance: " + appearanceName + "\n[No backstory generated for this NPC type]";
            backstoryUI.background = " "; // Non-empty to trigger display
            backstoryChunk.Set(backstoryUI);
        } else {
            backstoryChunk.SetEmpty();
        }
        
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.KdspScannerBackstory, ToVariant(backstoryChunk));
    }
    return wrappedMethod();
}
