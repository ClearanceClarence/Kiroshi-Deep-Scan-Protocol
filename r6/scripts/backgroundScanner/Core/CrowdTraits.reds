public class CrowdTraits {
    protected let m_traits: array<CrowdTrait>;

    public func GetTraits() -> array<CrowdTrait> {
        return this.m_traits;
    }

    public static func Create(traits: array<CrowdTrait>) -> ref<CrowdTraits> {
		let self: ref<CrowdTraits> = new CrowdTraits();
        self.m_traits = traits;
		return self;
	}
}