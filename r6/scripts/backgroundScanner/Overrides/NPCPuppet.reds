@wrapMethod(NPCPuppet)
public const func CompileScannerChunks() -> Bool {
    let scannerBlackboard: wref<IBlackboard>;
    let backstoryChunk: ref<ScannerBackstory>;

    scannerBlackboard = GameInstance.GetBlackboardSystem(this.GetGame()).Get(GetAllBlackboardDefs().UI_ScannerModules);

    // First check: Is this a unique/named NPC with a hand-crafted backstory?
    if UniqueNPCManager.IsUniqueNPC(this) {
        let uniqueBackstory = UniqueNPCManager.GetBackstory(this);
        if IsDefined(uniqueBackstory) {
            backstoryChunk = new ScannerBackstory();
            backstoryChunk.Set(uniqueBackstory.ToBackstoryUI());
            scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.ScannerBackstory, ToVariant(backstoryChunk));
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
        let backstoryUI = BackstoryManager.GenerateBackstoryUI(this);
        backstoryChunk = new ScannerBackstory();
        backstoryChunk.Set(backstoryUI);
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.ScannerBackstory, ToVariant(backstoryChunk));
    } else {
        backstoryChunk = new ScannerBackstory();
        backstoryChunk.SetEmpty();
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.ScannerBackstory, ToVariant(backstoryChunk));
    }
    return wrappedMethod();
}
