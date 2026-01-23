public func ReplaceFirst(src: String, target: String, replacement: String) -> String {
    let left: String;
    let right: String;
    let strLen = StrLen(src);
    let targetLen = StrLen(target);

    let targetIndex = StrFindFirst(src, target);
    left = StrLeft(src, targetIndex);
    right = StrRight(src, strLen - targetIndex - targetLen);

    return left + replacement + right;
} 

public static func isLocKey(locKey: String) -> Bool {
    return Equals(GetLocalizedText(locKey), null);
}