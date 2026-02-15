public class KdspCrowdTraits {
    protected let m_traits: array<KdspCrowdTrait>;

    public func GetTraits() -> array<KdspCrowdTrait> {
        return this.m_traits;
    }

    public static func Create(traits: array<KdspCrowdTrait>) -> ref<KdspCrowdTraits> {
		let self: ref<KdspCrowdTraits> = new KdspCrowdTraits();
        self.m_traits = traits;
		return self;
	}
}