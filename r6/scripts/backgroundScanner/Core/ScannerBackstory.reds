public class ScannerBackstory extends ScannerChunk {

    private let backstory: BackstoryUI;
    private let isEmpty: Bool;

    public final const func GetBackstory() -> BackstoryUI {
        return this.backstory;
    }

    public final func Set(b: BackstoryUI) -> Void {
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
