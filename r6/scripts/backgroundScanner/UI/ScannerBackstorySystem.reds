module CrowdScanner.UI

import Codeware.UI.inkCustomController

public class KdspScannerBackstorySystem extends inkCustomController {

    protected let m_root: ref<inkVerticalPanel>;
    protected let m_scanCompleted: Bool;
    protected let m_netWatchDbReport: ref<KdspNetWatchDBReport>;
    protected let m_loadingPanel: wref<inkCompoundWidget>;
    protected let m_fluffFooter: wref<inkCompoundWidget>;
    protected let m_backstory: KdspBackstoryUI;
    protected let m_loadingLineCount: Int32;

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
        root.SetName(n"KdspScannerBackstorySystem");
        root.SetHAlign(inkEHorizontalAlign.Left);
        root.SetVAlign(inkEVerticalAlign.Top);
        root.SetAnchor(inkEAnchor.TopLeft);
        root.SetSizeRule(inkESizeRule.Stretch);
        root.SetFitToContent(true);
        root.SetVisible(false);
        this.m_root = root;
        this.SetRootWidget(root);

        // ═══════════════════════════════════════════════════════════
        // MAIN HEADER - "DEEP SCAN PROTOCOL" (subtle, matches section headers)
        // ═══════════════════════════════════════════════════════════
        let headerContainer: ref<inkVerticalPanel> = new inkVerticalPanel();
        headerContainer.SetName(n"header_container");
        headerContainer.SetFitToContent(true);
        headerContainer.SetMargin(new inkMargin(0.0, 0.0, 0.0, KdspSettings.GetSectionMargin(12.0)));
        headerContainer.Reparent(root);
        
        // Main header text - styled like section headers but slightly larger
        let header: ref<inkText> = new inkText();
        header.SetName(n"main_header");
        header.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        header.SetFontStyle(n"Semi-Bold");
        header.SetFontSize(KdspSettings.GetHeaderFontSize() + 2);
        header.SetLetterCase(textLetterCase.UpperCase);
        header.SetText("Deep Scan Protocol");
        header.SetTintColor(new HDRColor(0.369, 0.965, 0.878, 0.9)); // Cyan, slightly transparent
        header.SetFitToContent(true);
        header.SetHAlign(inkEHorizontalAlign.Left);
        header.Reparent(headerContainer);
        
        // Subtle underline
        let underline: ref<inkRectangle> = new inkRectangle();
        underline.SetName(n"underline");
        underline.SetSize(new Vector2(200.0, 1.0));
        underline.SetTintColor(new HDRColor(0.369, 0.965, 0.878, 0.4));
        underline.SetMargin(new inkMargin(0.0, 4.0, 0.0, 0.0));
        underline.Reparent(headerContainer);

        // ═══════════════════════════════════════════════════════════
        // LOADING PANEL (3-8 randomized lines)
        // ═══════════════════════════════════════════════════════════
        let loadingPanel: ref<inkVerticalPanel> = new inkVerticalPanel();
        loadingPanel.SetName(n"loading_panel");
        loadingPanel.SetFitToContent(true);
        loadingPanel.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
        loadingPanel.Reparent(root);
        this.m_loadingPanel = loadingPanel;

        // Generate randomized loading text using true random seed
        let loadingSeed = Cast<Int32>(RandF() * 999999.0);
        let loadingLines = KdspScannerLoadingText.GenerateLoadingSequence(loadingSeed);
        let lineCount = ArraySize(loadingLines);
        
        // Store line count for animation
        this.m_loadingLineCount = lineCount;

        // Dynamically create loading lines
        let i = 0;
        let loadingFontSize = KdspSettings.GetTextFontSize() - 8; // Slightly smaller than main text
        if loadingFontSize < 14 { loadingFontSize = 14; }
        
        while i < lineCount {
            let loadLine: ref<inkText> = new inkText();
            loadLine.SetName(StringToName("load_" + IntToString(i)));
            loadLine.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
            loadLine.SetFontSize(loadingFontSize);
            loadLine.SetFitToContent(true);
            loadLine.SetOpacity(0.0);
            loadLine.SetText(loadingLines[i]);
            
            // Last line is success - green and bold
            if i == lineCount - 1 {
                loadLine.SetFontStyle(n"Semi-Bold");
                loadLine.SetTintColor(new HDRColor(0.5, 1.0, 0.5, 1.0));
                loadLine.SetMargin(new inkMargin(0.0, KdspSettings.GetHeaderValueGap(6.0), 0.0, 0.0));
            }
            // Error/warning lines - yellow/orange
            else if StrContains(loadingLines[i], "ERROR") || StrContains(loadingLines[i], "WARNING") || StrContains(loadingLines[i], "ALERT") {
                loadLine.SetFontStyle(n"Medium");
                loadLine.SetTintColor(new HDRColor(1.0, 0.7, 0.2, 0.9));
                if i > 0 { loadLine.SetMargin(new inkMargin(0.0, KdspSettings.GetHeaderValueGap(3.0), 0.0, 0.0)); }
            }
            // Normal lines - cyan
            else {
                loadLine.SetFontStyle(n"Medium");
                loadLine.SetTintColor(new HDRColor(0.369, 0.965, 0.878, 0.8));
                if i > 0 { loadLine.SetMargin(new inkMargin(0.0, KdspSettings.GetHeaderValueGap(3.0), 0.0, 0.0)); }
            }
            
            loadLine.Reparent(loadingPanel);
            i += 1;
        }

        // ═══════════════════════════════════════════════════════════
        // MAIN REPORT
        // ═══════════════════════════════════════════════════════════
        this.m_netWatchDbReport = KdspNetWatchDBReport.Create();
        this.m_netWatchDbReport.Reparent(root);

        // ═══════════════════════════════════════════════════════════
        // FOOTER
        // ═══════════════════════════════════════════════════════════
        let footer: ref<inkVerticalPanel> = new inkVerticalPanel();
        footer.SetName(n"footer");
        footer.SetFitToContent(true);
        footer.SetMargin(new inkMargin(0.0, KdspSettings.GetSectionMargin(15.0), 0.0, 0.0));
        footer.SetHAlign(inkEHorizontalAlign.Left);
        footer.SetVisible(false);
        footer.Reparent(root);
        this.m_fluffFooter = footer;

        let footerText: ref<inkText> = new inkText();
        footerText.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        footerText.SetFontStyle(n"Medium");
        footerText.SetFontSize(KdspSettings.GetHeaderFontSize() - 6);
        footerText.SetText("Kiroshi Optics // Deep Scan Protocol v2.0");
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

        // Animate each line with staggered delay
        let i = 0;
        while i < this.m_loadingLineCount {
            let widget = this.m_loadingPanel.GetWidget(StringToName("load_" + IntToString(i)));
            if IsDefined(widget) {
                let opts: inkAnimOptions;
                opts.executionDelay = Cast<Float>(i) * 0.16;
                widget.PlayAnimationWithOptions(fadeIn, opts);
            }
            i += 1;
        }
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

    public func IsBackstoryEmpty(backstoryUI: KdspBackstoryUI) -> Bool {
        if Equals(backstoryUI.background, "") {
            return true;
        } else {
            return false;
        }
    }

    public func ClearBackstory() -> Void {
        // Hide the entire UI for unique NPCs
        this.m_root.SetVisible(false);
        this.m_loadingPanel.SetVisible(false);
        this.m_netWatchDbReport.SetVisible(false);
        this.m_fluffFooter.SetVisible(false);
    }

    public func SetBackstory(backstoryUI: KdspBackstoryUI) {
        this.m_backstory = backstoryUI;
        
        // Update font sizes from settings
        this.UpdateFontSizes();
        
        this.m_netWatchDbReport.SetBackstory(this.m_backstory);
        if !this.IsBackstoryEmpty(backstoryUI) {
            this.m_root.SetVisible(true);
        }
    }

    private func UpdateFontSizes() -> Void {
        let headerSize = KdspSettings.GetHeaderFontSize();
        let textSize = KdspSettings.GetTextFontSize();
        let loadingSize = textSize - 8;
        if loadingSize < 14 { loadingSize = 14; }
        let footerSize = headerSize - 6;
        if footerSize < 10 { footerSize = 10; }
        
        // Update header container margin
        let headerContainer = this.m_root.GetWidget(n"header_container") as inkCompoundWidget;
        if IsDefined(headerContainer) {
            headerContainer.SetMargin(new inkMargin(0.0, 0.0, 0.0, KdspSettings.GetSectionMargin(12.0)));
            let mainHeader = headerContainer.GetWidget(n"main_header") as inkText;
            if IsDefined(mainHeader) {
                // Keep it at 24 or scale with header setting
                let scaledSize = 24 + (headerSize - 20);
                if scaledSize < 16 { scaledSize = 16; }
                mainHeader.SetFontSize(scaledSize);
            }
        }
        
        // Update loading lines
        let i = 0;
        while i < this.m_loadingLineCount {
            let loadLine = this.m_loadingPanel.GetWidget(StringToName("load_" + IntToString(i))) as inkText;
            if IsDefined(loadLine) {
                loadLine.SetFontSize(loadingSize);
            }
            i += 1;
        }
        
        // Update footer
        let footer = this.m_fluffFooter as inkCompoundWidget;
        if IsDefined(footer) {
            footer.SetMargin(new inkMargin(0.0, KdspSettings.GetSectionMargin(15.0), 0.0, 0.0));
            let footerText = footer.GetWidgetByIndex(0) as inkText;
            if IsDefined(footerText) {
                footerText.SetFontSize(footerSize);
            }
        }
    }

    public static func Create() -> ref<KdspScannerBackstorySystem> {
        let self: ref<KdspScannerBackstorySystem> = new KdspScannerBackstorySystem();
        self.CreateInstance();
        return self;
    }
}
