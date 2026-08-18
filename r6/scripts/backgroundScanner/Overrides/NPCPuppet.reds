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

    // Identity strings used across detection, exclusion, and debug paths
    let npcAppearance: String = NameToString(this.GetCurrentAppearanceName());
    let npcRecordId: String = TDBID.ToStringDEBUG(this.GetRecordID());
    let npcRecordLower: String = StrLower(npcRecordId);

    // Quest-critical NPCs that need the vanilla scanner for mission progression.
    // These NPCs have scanner interactions (eavesdrop, quest data) that break
    // if we override their scanner output. Skip them entirely.
    if KdspQuestScannerExclusions.ShouldUseVanillaScannerPrecomputed(npcRecordLower, npcAppearance) {
        return wrappedMethod();
    }

    // Is this a unique/named NPC with a hand-crafted backstory?
    let uniqueBackstory = KdspUniqueNPCManager.TryGetBackstory(this);
    if IsDefined(uniqueBackstory) {
        backstoryChunk = new KdspScannerBackstory();
        let backstoryUI = uniqueBackstory.ToBackstoryUI();

        // Add debug info if enabled
        if KdspSettings.DebugModeEnabled() {
            backstoryUI.debugInfo = "TweakDBID: " + npcRecordId + "\nAppearance: " + npcAppearance;
        }

        backstoryChunk.Set(backstoryUI);
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.KdspScannerBackstory, ToVariant(backstoryChunk));
        return wrappedMethod();
    }

    // Second check: Generate procedural backstories for generic NPCs
    // - Crowd NPCs (random pedestrians)
    // - Generic gang members
    // - Generic police/NCPD
    // - Sex workers / joytoys (special NPC type, not crowd)
    let shouldGenerate = this.IsHuman() && (this.IsCrowd() || this.IsCharacterGanger() || this.IsCharacterPolice() || this.IsPrevention());

    // Also generate for sex workers and service NPCs - they're placed NPCs, not crowd
    if !shouldGenerate && this.IsHuman() {
        if StrContains(npcAppearance, "prostitute") || StrContains(npcAppearance, "sexworker") || StrContains(npcAppearance, "joytoy") {
            shouldGenerate = true;
        }
        // Trauma Team - they have dedicated profiles now
        if StrContains(npcAppearance, "trauma") {
            shouldGenerate = true;
        }
        // Corpo civilians - placed corporate employees, not crowd
        if StrContains(npcAppearance, "corporat") || StrContains(npcRecordLower, "corpoman") || StrContains(npcRecordLower, "corpowoman") {
            shouldGenerate = true;
        }
        // Service NPCs - ripperdocs, vendors, bartenders with unique TweakDB entries
        if StrContains(npcAppearance, "ripperdoc") || StrContains(npcAppearance, "service_") || StrContains(npcAppearance, "barman") || StrContains(npcAppearance, "bartender") {
            shouldGenerate = true;
        }
        // Quest-placed NPCs that use gang/civilian appearances but aren't crowd
        // Covers mq040 (Raymond Chandler Evening), mq013 (A Day In The Life), sts_ep1 (Phantom Liberty), etc.
        if StrContains(npcRecordLower, ".mq0") || StrContains(npcRecordLower, ".sq0") || StrContains(npcRecordLower, ".sts_") || StrContains(npcAppearance, "mq0") || StrContains(npcAppearance, "sq0") || StrContains(npcAppearance, "sts_ep") {
            shouldGenerate = true;
        }
        // Vendor/shopkeeper NPCs
        if StrContains(npcAppearance, "vendor") || StrContains(npcAppearance, "foodshop") || StrContains(npcRecordLower, "foodshop") {
            shouldGenerate = true;
        }
    }

    // Skip corporate/military combat NPCs - only actual soldiers, not employees
    if shouldGenerate {
        // Skip military/tactical units that shouldn't have civilian backstories
        if StrContains(npcAppearance, "militech_soldier") || 
           StrContains(npcAppearance, "militech_mech") ||
           StrContains(npcAppearance, "arasaka_soldier") || 
           StrContains(npcAppearance, "arasaka_ninja") ||
           StrContains(npcAppearance, "arasaka_mech") ||
           StrContains(npcAppearance, "kang_tao_soldier") || 
           StrContains(npcAppearance, "ranger") || 
           StrContains(npcAppearance, "netwatch") || 
           StrContains(npcAppearance, "max_tac") || 
           StrContains(npcAppearance, "maxtac") ||
           StrContains(npcAppearance, "android") ||
           StrContains(npcAppearance, "droid") ||
           StrContains(npcAppearance, "robot") ||
           StrContains(npcAppearance, "mech_") {
            shouldGenerate = false;
        }
    }

    if shouldGenerate {
        let backstoryUI = KdspBackstoryManager.GenerateBackstoryUI(this);
        
        // Add debug info if enabled
        if KdspSettings.DebugModeEnabled() {
            backstoryUI.debugInfo = "TweakDBID: " + npcRecordId + "\nAppearance: " + npcAppearance;
        }
        
        backstoryChunk = new KdspScannerBackstory();
        backstoryChunk.Set(backstoryUI);
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.KdspScannerBackstory, ToVariant(backstoryChunk));
    } else {
        backstoryChunk = new KdspScannerBackstory();
        
        // Still show debug info for skipped NPCs if debug mode enabled
        if KdspSettings.DebugModeEnabled() {
            let backstoryUI: KdspBackstoryUI;
            backstoryUI.debugInfo = "TweakDBID: " + npcRecordId + "\nAppearance: " + npcAppearance + "\n[No backstory generated for this NPC type]";
            backstoryUI.background = " "; // Non-empty to trigger display
            backstoryChunk.Set(backstoryUI);
        } else {
            backstoryChunk.SetEmpty();
        }
        
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.KdspScannerBackstory, ToVariant(backstoryChunk));
    }
    return wrappedMethod();
}
