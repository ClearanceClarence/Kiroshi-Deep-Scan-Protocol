public class KdspCrowdEntity {

    private let m_recordId: TweakDBID;

    private let m_gender: KdspCrowdGender;

    private let m_wealth: KdspCrowdWealth;

    private let m_archetype: KdspCrowdArchetype;

    private let m_association: KdspCrowdAssociation;

    private let m_traits: array<KdspCrowdTrait>;

    public func GetRecordID() -> TweakDBID {
	    return this.m_recordId;
    }

    public func SetRecordID(recordId: TweakDBID) -> Void {
        this.m_recordId = recordId;
    }

    public func GetGender() -> KdspCrowdGender {
	    return this.m_gender;
    }

    public func SetGender(gender: KdspCrowdGender) -> Void {
        this.m_gender = gender;
    }

    public func GetArchetype() -> KdspCrowdArchetype {
	    return this.m_archetype;
    }

    public func SetArchetype(archetype: KdspCrowdArchetype) -> Void {
        this.m_archetype = archetype;
    }

}