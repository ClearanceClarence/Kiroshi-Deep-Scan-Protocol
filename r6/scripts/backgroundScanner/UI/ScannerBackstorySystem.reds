module CrowdScanner.UI

import Codeware.UI.inkCustomController

public class ScannerBackstorySystem extends inkCustomController {

    protected let m_root: ref<inkVerticalPanel>;
    protected let m_scanCompleted: Bool;
    protected let m_netWatchDbReport: ref<NetWatchDBReport>;
    protected let m_loadingPanel: wref<inkCompoundWidget>;
    protected let m_fluffFooter: wref<inkCompoundWidget>;
    protected let m_backstory: BackstoryUI;

    protected cb func OnInitialize() -> Bool {
        this.m_loadingPanel.SetVisible(true);
        this.m_netWatchDbReport.SetVisible(false);
        this.m_fluffFooter.SetVisible(false);
        
        // Animate loading text
        this.AnimateLoading();
    }

    protected cb func OnCreate() -> Void {
        this.CreateWidgets();
    }

    protected func CreateWidgets() -> Void {
        let root: ref<inkVerticalPanel> = new inkVerticalPanel();
        root.SetName(n"ScannerBackstorySystem");
        root.SetHAlign(inkEHorizontalAlign.Left);
        root.SetVAlign(inkEVerticalAlign.Top);
        root.SetAnchor(inkEAnchor.TopLeft);
        root.SetSizeRule(inkESizeRule.Stretch);
        root.SetFitToContent(true);
        root.SetVisible(false);
        this.m_root = root;
        this.SetRootWidget(root);

        // ═══════════════════════════════════════════════════════════
        // MAIN HEADER
        // ═══════════════════════════════════════════════════════════
        let header: ref<inkText> = new inkText();
        header.SetName(n"main_header");
        header.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        header.SetFontStyle(n"Semi-Bold");
        header.SetFontSize(20);
        header.SetLetterCase(textLetterCase.UpperCase);
        header.SetText("Deep Scan Protocol");
        header.SetTintColor(new HDRColor(0.62, 0.60, 0.58, 1.0));
        header.SetMargin(new inkMargin(0.0, 5.0, 0.0, 10.0));
        header.SetFitToContent(true);
        header.Reparent(root);

        // ═══════════════════════════════════════════════════════════
        // LOADING PANEL
        // ═══════════════════════════════════════════════════════════
        let loadingPanel: ref<inkVerticalPanel> = new inkVerticalPanel();
        loadingPanel.SetName(n"loading_panel");
        loadingPanel.SetFitToContent(true);
        loadingPanel.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
        loadingPanel.Reparent(root);
        this.m_loadingPanel = loadingPanel;

        let loadLine1: ref<inkText> = new inkText();
        loadLine1.SetName(n"load_1");
        loadLine1.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        loadLine1.SetFontStyle(n"Medium");
        loadLine1.SetFontSize(18);
        loadLine1.SetText("Connecting to NCPD database...");
        loadLine1.SetTintColor(new HDRColor(0.369, 0.965, 0.878, 0.8));
        loadLine1.SetFitToContent(true);
        loadLine1.SetOpacity(0.0);
        loadLine1.Reparent(loadingPanel);

        let loadLine2: ref<inkText> = new inkText();
        loadLine2.SetName(n"load_2");
        loadLine2.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        loadLine2.SetFontStyle(n"Medium");
        loadLine2.SetFontSize(18);
        loadLine2.SetText("Fetching citizen records...");
        loadLine2.SetTintColor(new HDRColor(0.369, 0.965, 0.878, 0.8));
        loadLine2.SetMargin(new inkMargin(0.0, 3.0, 0.0, 0.0));
        loadLine2.SetFitToContent(true);
        loadLine2.SetOpacity(0.0);
        loadLine2.Reparent(loadingPanel);

        let loadLine3: ref<inkText> = new inkText();
        loadLine3.SetName(n"load_3");
        loadLine3.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        loadLine3.SetFontStyle(n"Medium");
        loadLine3.SetFontSize(18);
        loadLine3.SetText("Processing...");
        loadLine3.SetTintColor(new HDRColor(0.369, 0.965, 0.878, 0.8));
        loadLine3.SetMargin(new inkMargin(0.0, 3.0, 0.0, 0.0));
        loadLine3.SetFitToContent(true);
        loadLine3.SetOpacity(0.0);
        loadLine3.Reparent(loadingPanel);

        // ═══════════════════════════════════════════════════════════
        // MAIN REPORT
        // ═══════════════════════════════════════════════════════════
        this.m_netWatchDbReport = NetWatchDBReport.Create();
        this.m_netWatchDbReport.Reparent(root);

        // ═══════════════════════════════════════════════════════════
        // FOOTER
        // ═══════════════════════════════════════════════════════════
        let footer: ref<inkVerticalPanel> = new inkVerticalPanel();
        footer.SetName(n"footer");
        footer.SetFitToContent(true);
        footer.SetMargin(new inkMargin(0.0, 15.0, 0.0, 0.0));
        footer.SetHAlign(inkEHorizontalAlign.Left);
        footer.SetVisible(false);
        footer.Reparent(root);
        this.m_fluffFooter = footer;

        let footerText: ref<inkText> = new inkText();
        footerText.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        footerText.SetFontStyle(n"Medium");
        footerText.SetFontSize(14);
        footerText.SetText("Kiroshi Optics // Deep Scan Protocol v1.1");
        footerText.SetTintColor(new HDRColor(0.4, 0.4, 0.38, 1.0));
        footerText.SetFitToContent(true);
        footerText.Reparent(footer);
    }

    private func AnimateLoading() -> Void {
        let fadeIn = new inkAnimDef();
        let alphaInterp = new inkAnimTransparency();
        alphaInterp.SetDuration(0.15);
        alphaInterp.SetStartTransparency(0.0);
        alphaInterp.SetEndTransparency(1.0);
        alphaInterp.SetType(inkanimInterpolationType.Linear);
        alphaInterp.SetMode(inkanimInterpolationMode.EasyIn);
        fadeIn.AddInterpolator(alphaInterp);

        let load1 = this.m_loadingPanel.GetWidget(n"load_1");
        let load2 = this.m_loadingPanel.GetWidget(n"load_2");
        let load3 = this.m_loadingPanel.GetWidget(n"load_3");

        let opts1: inkAnimOptions;
        opts1.executionDelay = 0.0;
        
        let opts2: inkAnimOptions;
        opts2.executionDelay = 0.2;
        
        let opts3: inkAnimOptions;
        opts3.executionDelay = 0.4;

        load1.PlayAnimationWithOptions(fadeIn, opts1);
        load2.PlayAnimationWithOptions(fadeIn, opts2);
        load3.PlayAnimationWithOptions(fadeIn, opts3);
    }

    public func isScanCompleted() -> Bool {
        return this.m_scanCompleted;
    }

    public func SetScanCompleted(completed: Bool) {
        this.m_scanCompleted = completed;
        if this.m_scanCompleted {
            this.m_loadingPanel.SetVisible(false);
            this.m_netWatchDbReport.SetVisible(true);
            this.m_fluffFooter.SetVisible(true);
        }
    }

    public func IsBackstoryEmpty(backstoryUI: BackstoryUI) -> Bool {
        if Equals(backstoryUI.background, "") {
            return true;
        } else {
            return false;
        }
    }

    public func SetBackstory(backstoryUI: BackstoryUI) {
        this.m_backstory = backstoryUI;
        this.m_netWatchDbReport.SetBackstory(this.m_backstory);
        if !this.IsBackstoryEmpty(backstoryUI) {
            this.m_root.SetVisible(true);
        }
    }

    public static func Create() -> ref<ScannerBackstorySystem> {
        let self: ref<ScannerBackstorySystem> = new ScannerBackstorySystem();
        self.CreateInstance();
        return self;
    }
}
