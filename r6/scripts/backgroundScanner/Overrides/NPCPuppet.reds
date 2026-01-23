@wrapMethod(NPCPuppet)
public const func CompileScannerChunks() -> Bool {
    let scannerBlackboard: wref<IBlackboard>;
    let backstoryChunk: ref<ScannerBackstory>;

    scannerBlackboard = GameInstance.GetBlackboardSystem(this.GetGame()).Get(GetAllBlackboardDefs().UI_ScannerModules);

    // Check if NPC is human - we want backstories for all human NPCs (crowd, gang, combat)
    // Use IsHuman check instead of reaction preset to include all human NPCs
    let isHumanNPC = this.IsHuman();
    
    // Also check if it's not a turret, device, or vehicle
    let isValidTarget = isHumanNPC;

    // Generate backstory for all human NPCs
    if isValidTarget {
        let backstoryUI = BackstoryManager.GenerateBackstoryUI(this);
        backstoryChunk = new ScannerBackstory();
        backstoryChunk.Set(backstoryUI);
        scannerBlackboard.SetVariant(GetAllBlackboardDefs().UI_ScannerModules.ScannerBackstory, ToVariant(backstoryChunk));
    }
    return wrappedMethod();
}
