@wrapMethod(NPCPuppet)
public const func CompileScannerChunks() -> Bool {
    let scannerBlackboard: wref<IBlackboard>;
    let backstoryChunk: ref<ScannerBackstory>;

    scannerBlackboard = GameInstance.GetBlackboardSystem(this.GetGame()).Get(GetAllBlackboardDefs().UI_ScannerModules);

    // Generate backstories for generic NPCs only:
    // - Crowd NPCs (random pedestrians)
    // - Generic gang members
    // - Generic police/NCPD
    // Named story characters (Johnny, Panam, Takemura, etc.) are none of these
    let shouldGenerate = this.IsHuman() && (this.IsCrowd() || this.IsCharacterGanger() || this.IsCharacterPolice() || this.IsPrevention());

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
