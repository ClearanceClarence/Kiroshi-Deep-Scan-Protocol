public class KdspScannerBackstory extends ScannerChunk {

    private let backstory: KdspBackstoryUI;
    private let isEmpty: Bool;

    public final const func GetBackstory() -> KdspBackstoryUI {
        return this.backstory;
    }

    public final func Set(b: KdspBackstoryUI) -> Void {
        this.backstory = b;
        this.isEmpty = false;
    }

    public final func SetEmpty() -> Void {
        this.isEmpty = true;
    }

    public final const func IsEmpty() -> Bool {
        return this.isEmpty;
    }

    public func GetType() -> ScannerDataType {
        // Can't override enums, so just return a name
        return ScannerDataType.Name;
    }
}
