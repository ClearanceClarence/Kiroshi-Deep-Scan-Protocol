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
    // - Sex workers / joytoys (special NPC type, not crowd)
    let shouldGenerate = this.IsHuman() && (this.IsCrowd() || this.IsCharacterGanger() || this.IsCharacterPolice() || this.IsPrevention());

    // Also generate for sex workers and service NPCs - they're placed NPCs, not crowd
    if !shouldGenerate && this.IsHuman() {
        let checkAppearance = NameToString(this.GetCurrentAppearanceName());
        let checkRecord = TDBID.ToStringDEBUG(this.GetRecordID());
        let checkRecordLower = StrLower(checkRecord);
        if StrContains(checkAppearance, "prostitute") || StrContains(checkAppearance, "sexworker") || StrContains(checkAppearance, "joytoy") {
            shouldGenerate = true;
        }
        // Trauma Team - they have dedicated profiles now
        if StrContains(checkAppearance, "trauma") {
            shouldGenerate = true;
        }
        // Corpo civilians - placed corporate employees, not crowd
        if StrContains(checkAppearance, "corporat") || StrContains(checkRecordLower, "corpoman") || StrContains(checkRecordLower, "corpowoman") {
            shouldGenerate = true;
        }
        // Service NPCs - ripperdocs, vendors, bartenders with unique TweakDB entries
        if StrContains(checkAppearance, "ripperdoc") || StrContains(checkAppearance, "service_") || StrContains(checkAppearance, "barman") || StrContains(checkAppearance, "bartender") {
            shouldGenerate = true;
        }
        // Quest-placed NPCs that use gang/civilian appearances but aren't crowd
        // Covers mq040 (Raymond Chandler Evening), mq013 (A Day In The Life), sts_ep1 (Phantom Liberty), etc.
        if StrContains(checkRecordLower, ".mq0") || StrContains(checkRecordLower, ".sq0") || StrContains(checkRecordLower, ".sts_") || StrContains(checkAppearance, "mq0") || StrContains(checkAppearance, "sq0") || StrContains(checkAppearance, "sts_ep") {
            shouldGenerate = true;
        }
        // Vendor/shopkeeper NPCs
        if StrContains(checkAppearance, "vendor") || StrContains(checkAppearance, "foodshop") || StrContains(checkRecordLower, "foodshop") {
            shouldGenerate = true;
        }
    }

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
           StrContains(appearanceName, "ranger") || 
           StrContains(appearanceName, "netwatch") || 
           StrContains(appearanceName, "max_tac") || 
           StrContains(appearanceName, "maxtac") ||
           StrContains(appearanceName, "android") ||
           StrContains(appearanceName, "droid") ||
           StrContains(appearanceName, "robot") ||
           StrContains(appearanceName, "mech_") {
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
