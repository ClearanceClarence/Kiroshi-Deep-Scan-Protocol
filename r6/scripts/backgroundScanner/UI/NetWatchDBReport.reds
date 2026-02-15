module CrowdScanner.UI

import Codeware.UI.inkCustomController

public class KdspNetWatchDBReport extends inkCustomController {

    private let m_backstoryUI: KdspBackstoryUI;
    private let m_root: wref<inkCompoundWidget>;
    
    // Alert sections
    private let m_classificationSection: wref<inkCompoundWidget>;
    private let m_classificationValue: wref<inkText>;
    
    private let m_specialSection: wref<inkCompoundWidget>;
    private let m_specialValue: wref<inkText>;
    
    private let m_ncpdSection: wref<inkCompoundWidget>;
    private let m_ncpdValue: wref<inkText>;
    
    // Profile subsections
    private let m_backgroundSection: wref<inkCompoundWidget>;
    private let m_backgroundValue: wref<inkText>;
    
    private let m_earlyLifeSection: wref<inkCompoundWidget>;
    private let m_earlyLifeValue: wref<inkText>;
    
    private let m_recentSection: wref<inkCompoundWidget>;
    private let m_recentValue: wref<inkText>;
    
    // Data sections
    private let m_threatSection: wref<inkCompoundWidget>;
    private let m_threatValue: wref<inkText>;
    
    private let m_criminalSection: wref<inkCompoundWidget>;
    private let m_criminalValue: wref<inkText>;
    
    private let m_gangSection: wref<inkCompoundWidget>;
    private let m_gangValue: wref<inkText>;
    
    private let m_cyberSection: wref<inkCompoundWidget>;
    private let m_cyberValue: wref<inkText>;
    
    private let m_financeSection: wref<inkCompoundWidget>;
    private let m_financeValue: wref<inkText>;
    
    private let m_medicalSection: wref<inkCompoundWidget>;
    private let m_medicalValue: wref<inkText>;
    
    private let m_relationshipsSection: wref<inkCompoundWidget>;
    private let m_relationshipsValue: wref<inkText>;

    private let m_pronounsSection: wref<inkCompoundWidget>;
    private let m_pronounsValue: wref<inkText>;

    private let m_debugSection: wref<inkCompoundWidget>;
    private let m_debugValue: wref<inkText>;

    protected cb func OnCreate() -> Void {
        this.CreateWidgets();
    }

    protected func CreateWidgets() -> Void {
        let root: ref<inkVerticalPanel> = new inkVerticalPanel();
        root.SetName(n"KdspNetWatchDBReport");
        root.SetHAlign(inkEHorizontalAlign.Left);
        root.SetVAlign(inkEVerticalAlign.Top);
        root.SetMargin(new inkMargin(0.0, 15.0, 0.0, 0.0));
        root.SetFitToContent(true);
        this.SetRootWidget(root);
        this.m_root = root;

        // ═══════════════════════════════════════════════════════════
        // ALERT SECTIONS (Classification, Rare NPC, NCPD)
        // ═══════════════════════════════════════════════════════════
        this.m_classificationSection = this.CreateAlertSection(root, "CLASSIFIED INDIVIDUAL", n"classification", 
            new HDRColor(1.0, 0.35, 0.35, 1.0));
        this.m_classificationValue = this.m_classificationSection.GetWidget(n"classification_value") as inkText;

        this.m_specialSection = this.CreateAlertSection(root, "FLAGGED INDIVIDUAL", n"special", 
            new HDRColor(1.0, 0.85, 0.2, 1.0));
        this.m_specialValue = this.m_specialSection.GetWidget(n"special_value") as inkText;

        this.m_ncpdSection = this.CreateAlertSection(root, "NCPD PERSONNEL FILE", n"ncpd",
            new HDRColor(0.4, 0.75, 1.0, 1.0));
        this.m_ncpdValue = this.m_ncpdSection.GetWidget(n"ncpd_value") as inkText;

        // ═══════════════════════════════════════════════════════════
        // PROFILE - Split into 3 subsections
        // ═══════════════════════════════════════════════════════════
        this.m_backgroundSection = this.CreateDataSection(root, "Background", n"background",
            new HDRColor(0.369, 0.965, 0.878, 1.0));
        this.m_backgroundValue = this.m_backgroundSection.GetWidget(n"background_value") as inkText;

        this.m_earlyLifeSection = this.CreateDataSection(root, "Early Life", n"earlylife",
            new HDRColor(0.369, 0.965, 0.878, 1.0));
        this.m_earlyLifeValue = this.m_earlyLifeSection.GetWidget(n"earlylife_value") as inkText;

        this.m_recentSection = this.CreateDataSection(root, "Recent Activity", n"recent",
            new HDRColor(0.369, 0.965, 0.878, 1.0));
        this.m_recentValue = this.m_recentSection.GetWidget(n"recent_value") as inkText;

        // ═══════════════════════════════════════════════════════════
        // DATA SECTIONS
        // ═══════════════════════════════════════════════════════════
        this.m_threatSection = this.CreateDataSection(root, "Psych Profile", n"threat",
            new HDRColor(0.369, 0.965, 0.878, 1.0));
        this.m_threatValue = this.m_threatSection.GetWidget(n"threat_value") as inkText;

        this.m_criminalSection = this.CreateDataSection(root, "Criminal Record", n"criminal",
            new HDRColor(1.0, 0.4, 0.4, 1.0));
        this.m_criminalValue = this.m_criminalSection.GetWidget(n"criminal_value") as inkText;

        this.m_gangSection = this.CreateDataSection(root, "Gang Affiliation", n"gang",
            new HDRColor(0.85, 0.5, 0.95, 1.0));
        this.m_gangValue = this.m_gangSection.GetWidget(n"gang_value") as inkText;

        this.m_cyberSection = this.CreateDataSection(root, "Cyberware", n"cyber",
            new HDRColor(0.369, 0.965, 0.878, 1.0));
        this.m_cyberValue = this.m_cyberSection.GetWidget(n"cyber_value") as inkText;

        this.m_financeSection = this.CreateDataSection(root, "Financial", n"finance",
            new HDRColor(1.0, 0.9, 0.35, 1.0));
        this.m_financeValue = this.m_financeSection.GetWidget(n"finance_value") as inkText;

        this.m_medicalSection = this.CreateDataSection(root, "Medical", n"medical",
            new HDRColor(0.4, 1.0, 0.55, 1.0));
        this.m_medicalValue = this.m_medicalSection.GetWidget(n"medical_value") as inkText;

        this.m_relationshipsSection = this.CreateDataSection(root, "Relationships", n"relationships",
            new HDRColor(1.0, 0.6, 0.7, 1.0));
        this.m_relationshipsValue = this.m_relationshipsSection.GetWidget(n"relationships_value") as inkText;

        this.m_pronounsSection = this.CreateDataSection(root, "Pronouns", n"pronouns",
            new HDRColor(0.8, 0.6, 1.0, 1.0));
        this.m_pronounsValue = this.m_pronounsSection.GetWidget(n"pronouns_value") as inkText;

        // Debug section - orange/amber color to stand out
        this.m_debugSection = this.CreateDataSection(root, "Debug Info", n"debug",
            new HDRColor(1.0, 0.6, 0.2, 1.0));
        this.m_debugValue = this.m_debugSection.GetWidget(n"debug_value") as inkText;
    }

    // Alert section - bold colored header
    private func CreateAlertSection(parent: ref<inkCompoundWidget>, headerText: String, name: CName, color: HDRColor) -> ref<inkCompoundWidget> {
        let section: ref<inkVerticalPanel> = new inkVerticalPanel();
        section.SetName(name);
        section.SetFitToContent(true);
        section.SetMargin(new inkMargin(0.0, 0.0, 0.0, 14.0));
        section.SetVisible(false);
        section.Reparent(parent);

        let header: ref<inkText> = new inkText();
        header.SetName(StringToName(NameToString(name) + "_header"));
        header.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        header.SetFontStyle(n"Semi-Bold");
        header.SetFontSize(KdspSettings.GetHeaderFontSize());
        header.SetLetterCase(textLetterCase.UpperCase);
        header.SetText(headerText);
        header.SetTintColor(color);
        header.SetMargin(new inkMargin(0.0, 0.0, 0.0, 4.0));
        header.SetFitToContent(true);
        header.Reparent(section);

        let value: ref<inkText> = new inkText();
        value.SetName(StringToName(NameToString(name) + "_value"));
        value.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        value.SetFontStyle(n"Medium");
        value.SetFontSize(KdspSettings.GetTextFontSize());
        value.SetTintColor(color);
        value.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
        value.SetFitToContent(true);
        value.SetWrapping(true, 700.0, textWrappingPolicy.PerCharacter);
        value.Reparent(section);

        return section;
    }

    // Data section - tan/beige header like game's AFFILIATION label
    private func CreateDataSection(parent: ref<inkCompoundWidget>, headerText: String, name: CName, valueColor: HDRColor) -> ref<inkCompoundWidget> {
        let section: ref<inkVerticalPanel> = new inkVerticalPanel();
        section.SetName(name);
        section.SetFitToContent(true);
        section.SetMargin(new inkMargin(0.0, 0.0, 0.0, 12.0));
        section.SetVisible(false);
        section.Reparent(parent);

        // Header - tan/beige color matching game's AFFILIATION label
        let header: ref<inkText> = new inkText();
        header.SetName(StringToName(NameToString(name) + "_header"));
        header.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        header.SetFontStyle(n"Semi-Bold");
        header.SetFontSize(KdspSettings.GetHeaderFontSize());
        header.SetLetterCase(textLetterCase.UpperCase);
        header.SetText(headerText);
        header.SetTintColor(new HDRColor(0.72, 0.65, 0.55, 1.0));
        header.SetMargin(new inkMargin(0.0, 0.0, 0.0, 3.0));
        header.SetFitToContent(true);
        header.Reparent(section);

        // Value - colored text
        let value: ref<inkText> = new inkText();
        value.SetName(StringToName(NameToString(name) + "_value"));
        value.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        value.SetFontStyle(n"Medium");
        value.SetFontSize(KdspSettings.GetTextFontSize());
        value.SetTintColor(valueColor);
        value.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
        value.SetFitToContent(true);
        value.SetWrapping(true, 700.0, textWrappingPolicy.PerCharacter);
        value.Reparent(section);

        return section;
    }

    public func SetBackstory(backstoryUI: KdspBackstoryUI) {
        this.m_backstoryUI = backstoryUI;
        
        // Update font sizes from settings (allows mid-game changes)
        this.UpdateFontSizes();

        // Unique NPC Classification Banner
        if this.m_backstoryUI.isUnique && StrLen(this.m_backstoryUI.uniqueClassification) > 0 {
            this.m_classificationValue.SetText(this.m_backstoryUI.uniqueClassification);
            this.m_classificationSection.SetVisible(true);
            // Update header to show it's a known individual
            let header = this.m_classificationSection.GetWidget(n"classification_header") as inkText;
            if IsDefined(header) {
                header.SetText("KNOWN INDIVIDUAL");
            }
        } else {
            this.m_classificationSection.SetVisible(false);
        };
        
        // Background
        if StrLen(this.m_backstoryUI.background) > 0 {
            this.m_backgroundValue.SetText(this.m_backstoryUI.background);
            this.m_backgroundSection.SetVisible(true);
        } else {
            this.m_backgroundSection.SetVisible(false);
        };
        
        // Early Life
        if StrLen(this.m_backstoryUI.earlyLife) > 0 {
            this.m_earlyLifeValue.SetText(this.m_backstoryUI.earlyLife);
            this.m_earlyLifeSection.SetVisible(true);
        } else {
            this.m_earlyLifeSection.SetVisible(false);
        };
        
        // Recent Activity
        if StrLen(this.m_backstoryUI.significantEvents) > 0 {
            this.m_recentValue.SetText(this.m_backstoryUI.significantEvents);
            this.m_recentSection.SetVisible(true);
        } else {
            this.m_recentSection.SetVisible(false);
        };
        
        // Special Status (Rare)
        if StrLen(this.m_backstoryUI.rareFlag) > 0 {
            this.m_specialValue.SetText(this.m_backstoryUI.rareFlag);
            this.m_specialSection.SetVisible(true);
        } else {
            this.m_specialSection.SetVisible(false);
        };
        
        // NCPD Officer
        if StrLen(this.m_backstoryUI.ncpdOfficer) > 0 {
            this.m_ncpdValue.SetText(this.m_backstoryUI.ncpdOfficer);
            this.m_ncpdSection.SetVisible(true);
        } else {
            this.m_ncpdSection.SetVisible(false);
        };
        
        // Psych Profile
        if StrLen(this.m_backstoryUI.threatAssessment) > 0 {
            this.m_threatValue.SetText(this.m_backstoryUI.threatAssessment);
            this.m_threatSection.SetVisible(true);
        } else {
            this.m_threatSection.SetVisible(false);
        };
        
        // Criminal
        if StrLen(this.m_backstoryUI.criminalRecord) > 0 {
            this.m_criminalValue.SetText(this.m_backstoryUI.criminalRecord);
            this.m_criminalSection.SetVisible(true);
        } else {
            this.m_criminalSection.SetVisible(false);
        };
        
        // Gang
        if StrLen(this.m_backstoryUI.gangAffiliation) > 0 {
            this.m_gangValue.SetText(this.m_backstoryUI.gangAffiliation);
            this.m_gangSection.SetVisible(true);
        } else {
            this.m_gangSection.SetVisible(false);
        };
        
        // Cyberware
        if StrLen(this.m_backstoryUI.cyberwareStatus) > 0 {
            this.m_cyberValue.SetText(this.m_backstoryUI.cyberwareStatus);
            this.m_cyberSection.SetVisible(true);
        } else {
            this.m_cyberSection.SetVisible(false);
        };
        
        // Finance
        if StrLen(this.m_backstoryUI.financialStatus) > 0 {
            this.m_financeValue.SetText(this.m_backstoryUI.financialStatus);
            this.m_financeSection.SetVisible(true);
        } else {
            this.m_financeSection.SetVisible(false);
        };
        
        // Medical
        if StrLen(this.m_backstoryUI.medicalStatus) > 0 {
            this.m_medicalValue.SetText(this.m_backstoryUI.medicalStatus);
            this.m_medicalSection.SetVisible(true);
        } else {
            this.m_medicalSection.SetVisible(false);
        };
        
        // Relationships
        if StrLen(this.m_backstoryUI.relationships) > 0 {
            this.m_relationshipsValue.SetText(this.m_backstoryUI.relationships);
            this.m_relationshipsSection.SetVisible(true);
            
            if StrContains(this.m_backstoryUI.relationships, "ENEMIES:") {
                this.m_relationshipsValue.SetTintColor(new HDRColor(1.0, 0.5, 0.5, 1.0));
            } else {
                this.m_relationshipsValue.SetTintColor(new HDRColor(1.0, 0.6, 0.7, 1.0));
            };
        } else {
            this.m_relationshipsSection.SetVisible(false);
        };

        // Pronouns
        if StrLen(this.m_backstoryUI.pronouns) > 0 {
            this.m_pronounsValue.SetText(this.m_backstoryUI.pronouns);
            this.m_pronounsSection.SetVisible(true);
        } else {
            this.m_pronounsSection.SetVisible(false);
        };

        // Debug Info (only shown when debug mode enabled in settings)
        if StrLen(this.m_backstoryUI.debugInfo) > 0 {
            this.m_debugValue.SetText(this.m_backstoryUI.debugInfo);
            this.m_debugSection.SetVisible(true);
        } else {
            this.m_debugSection.SetVisible(false);
        };
    }

    private func UpdateFontSizes() -> Void {
        let headerSize = KdspSettings.GetHeaderFontSize();
        let textSize = KdspSettings.GetTextFontSize();
        
        // Update all header fonts
        this.UpdateSectionFontSize(this.m_classificationSection, n"classification", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_specialSection, n"special", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_ncpdSection, n"ncpd", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_backgroundSection, n"background", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_earlyLifeSection, n"earlylife", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_recentSection, n"recent", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_threatSection, n"threat", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_criminalSection, n"criminal", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_gangSection, n"gang", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_cyberSection, n"cyber", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_financeSection, n"finance", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_medicalSection, n"medical", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_relationshipsSection, n"relationships", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_pronounsSection, n"pronouns", headerSize, textSize);
        this.UpdateSectionFontSize(this.m_debugSection, n"debug", headerSize, textSize);
    }

    private func UpdateSectionFontSize(section: wref<inkCompoundWidget>, name: CName, headerSize: Int32, textSize: Int32) -> Void {
        if !IsDefined(section) { return; }
        
        let header = section.GetWidget(StringToName(NameToString(name) + "_header")) as inkText;
        let value = section.GetWidget(StringToName(NameToString(name) + "_value")) as inkText;
        
        if IsDefined(header) {
            header.SetFontSize(headerSize);
        }
        if IsDefined(value) {
            value.SetFontSize(textSize);
        }
    }

    public func SetVisible(visible: Bool) {
        this.GetRootWidget().SetVisible(visible);
    }

    public static func Create() -> ref<KdspNetWatchDBReport> {
        let self: ref<KdspNetWatchDBReport> = new KdspNetWatchDBReport();
        self.CreateInstance();
        return self;
    }
}
