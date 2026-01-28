import CrowdScanner.UI.ScannerBackstorySystem
import Codeware.UI.inkCustomController

@addField(ScannerNPCBodyGameController)
private let m_scannedObjectCallbackID: ref<CallbackHandle>;

@addField(ScannerNPCBodyGameController)
private let m_BBID_ScanState: ref<CallbackHandle>;

@addField(ScannerNPCBodyGameController)
private let m_isFullyScanned: Bool;

@addField(ScannerNPCBodyGameController)
private let m_scanBlackboard: wref<IBlackboard>;

@addField(ScannerNPCBodyGameController)
private let m_scannerBackstorySystem: ref<ScannerBackstorySystem>;

@addField(ScannerNPCBodyGameController)
private let m_nameCallbackID: ref<CallbackHandle>;

@addField(ScannerNPCBodyGameController)
private let m_backstoryCallbackID: ref<CallbackHandle>;

@addField(ScannerNPCBodyGameController)
private let m_currentTarget: EntityID;

@addField(ScannerNPCBodyGameController)
private let m_currentTargetBuffered: EntityID;

@addField(ScannerNPCBodyGameController)
private let m_attachedRenderer: Bool;


@replaceMethod(ScannerNPCBodyGameController)
protected cb func OnInitialize() -> Bool {
  super.OnInitialize();
  this.m_scanBlackboard = this.GetBlackboardSystem().Get(GetAllBlackboardDefs().UI_Scanner);
  this.m_scannedObjectCallbackID = this.m_scanBlackboard.RegisterDelayedListenerEntityID(GetAllBlackboardDefs().UI_Scanner.ScannedObject, this, n"OnScannedObject", true);
  this.m_factionCallbackID = this.m_chunkBlackboard.RegisterDelayedListenerVariant(this.m_chunkBlackboardDef.ScannerFaction, this, n"OnFactionChanged");
  this.m_rarityCallbackID = this.m_chunkBlackboard.RegisterDelayedListenerVariant(this.m_chunkBlackboardDef.ScannerRarity, this, n"OnRarityChanged");
  this.OnFactionChanged(this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerFaction));
  this.OnRarityChanged(this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerRarity));

  
  this.m_nameCallbackID = this.m_chunkBlackboard.RegisterDelayedListenerVariant(this.m_chunkBlackboardDef.ScannerName, this, n"OnNameChanged");
  this.m_scanBlackboard = this.GetBlackboardSystem().Get(GetAllBlackboardDefs().UI_Scanner);
  this.m_BBID_ScanState = this.m_scanBlackboard.RegisterDelayedListenerVariant(GetAllBlackboardDefs().UI_Scanner.CurrentState, this, n"OnStateChanged", true);

  this.OnNameChanged(this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerName));

  this.m_backstoryCallbackID = this.m_chunkBlackboard.RegisterDelayedListenerVariant(this.m_chunkBlackboardDef.ScannerBackstory, this, n"OnBackstoryChanged");

  this.OnBackstoryChanged(this.m_chunkBlackboard.GetVariant(this.m_chunkBlackboardDef.ScannerBackstory));
}

@addMethod(ScannerNPCBodyGameController)
protected cb func OnStateChanged(val: Variant) -> Bool {
  let state: gameScanningState = FromVariant<gameScanningState>(val);
  
  if(!this.m_attachedRenderer) {
    this.RenderNPCBackstory();
  }
  
  if (Equals(state, gameScanningState.Complete)) {
    this.m_scannerBackstorySystem.SetScanCompleted(true);
  }
}

@addMethod(ScannerNPCBodyGameController)
protected cb func OnBackstoryChanged(val: Variant) -> Bool {
  let backstoryChunk: ref<ScannerBackstory> = FromVariant<ref<ScannerBackstory>>(val);
  
  // Skip if backstory is marked as empty (unique NPCs)
  if IsDefined(backstoryChunk) && backstoryChunk.IsEmpty() {
    this.m_scannerBackstorySystem.ClearBackstory();
    return true;
  }
  
  if IsDefined(backstoryChunk) {
    let backstoryUI = backstoryChunk.GetBackstory();
    this.m_scannerBackstorySystem.SetBackstory(backstoryUI);
  }
}

@addMethod(ScannerNPCBodyGameController)
protected cb func OnScannedObject(val: EntityID) -> Bool {
  this.m_currentTargetBuffered = this.m_currentTarget;
  this.m_currentTarget = val;
  this.ComputeVisibility();
}

@addMethod(ScannerNPCBodyGameController)
private final func ComputeVisibility() -> Void {
  let currentTargetObject: wref<GameObject>;
  let owner: ref<GameObject>;

  if !EntityID.IsDefined(this.m_currentTarget) {
    return;
  };

  owner = this.GetOwnerEntity() as GameObject;
  currentTargetObject = GameInstance.FindEntityByID(owner.GetGame(), this.m_currentTarget) as GameObject;
  if this.ShouldShowScanner(currentTargetObject) {
    // Scanner visible
  } else {
    // Scanner not visible
  };
}

@addMethod(ScannerNPCBodyGameController)
private final func ShouldShowScanner(currentTargetObject: wref<GameObject>) -> Bool {
  if EntityID.IsDefined(this.m_currentTarget) {
    return currentTargetObject.ShouldShowScanner();
  };
  return false;
}

@addMethod(ScannerNPCBodyGameController)
protected cb func OnNameChanged(val: Variant) -> Bool {
  // Generate Backstory From Name
  // Create Backstory Object
  // Assign To Variable
}

@addMethod(ScannerNPCBodyGameController)
private func RenderNPCBackstory() -> Void {
  
  // Configuration to ensure child widgets can expand the root widget.
  let root = this.GetRootWidget();
  root.SetSizeRule(inkESizeRule.Stretch);
  root.SetFitToContent(true);
  root.SetHAlign(inkEHorizontalAlign.Left);
  root.SetVAlign(inkEVerticalAlign.Top);
  root.SetAnchor(inkEAnchor.TopLeft);

  // Configuration to ensure child wdiget can expand the left panel.
  let leftPanel = this.GetWidget(n"LeftPanel") as inkCompoundWidget;
  leftPanel.SetHAlign(inkEHorizontalAlign.Left);
  leftPanel.SetVAlign(inkEVerticalAlign.Top);
  leftPanel.SetAnchor(inkEAnchor.TopLeft);
  leftPanel.SetSizeRule(inkESizeRule.Stretch);

  // Add backstory to left panel
  let scannerBackstorySystem = ScannerBackstorySystem.Create();
  this.m_scannerBackstorySystem = scannerBackstorySystem;
  this.m_scannerBackstorySystem.Reparent(leftPanel);

  this.m_attachedRenderer = true;
}
