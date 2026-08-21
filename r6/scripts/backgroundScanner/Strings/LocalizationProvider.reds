// Kiroshi Deep Scan Protocol - Localization Provider
// Resolves the player's game language to a language package.
// Every game language maps to a package file in Strings/ - community
// translations are installed by replacing the matching stub file.

module KiroshiDeepScan.Localization
import Codeware.Localization.*

public class LocalizationProvider extends ModLocalizationProvider {
    public func GetPackage(language: CName) -> ref<ModLocalizationPackage> {
        switch language {
            case n"en-us": return new English();
            case n"fr-fr": return new French();
            case n"pl-pl": return new Polish();
            case n"de-de": return new German();
            case n"es-es": return new Spanish();
            case n"es-mx": return new SpanishLatAm();
            case n"it-it": return new Italian();
            case n"pt-br": return new Portuguese();
            case n"ru-ru": return new Russian();
            case n"zh-cn": return new ChineseSimplified();
            case n"zh-tw": return new ChineseTraditional();
            case n"jp-jp": return new Japanese();
            case n"kr-kr": return new Korean();
            case n"ar-ar": return new Arabic();
            case n"cz-cz": return new Czech();
            case n"hu-hu": return new Hungarian();
            case n"tr-tr": return new Turkish();
            case n"th-th": return new Thai();
            default: return null;
        }
    }

    public func GetFallback() -> CName {
        return n"en-us";
    }
}
