public class ScannerBackstory extends ScannerChunk {

    private let backstory: BackstoryUI;

    public final const func GetBackstory() -> BackstoryUI {
        return this.backstory;
    }

    public final func Set(b: BackstoryUI) -> Void {
        this.backstory = b;
    }

    public func GetType() -> ScannerDataType {
        // Can't override enums, so just return a name
        return ScannerDataType.Name;
    }
}