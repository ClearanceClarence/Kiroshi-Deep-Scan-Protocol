public class CrowdEntity {

    private let m_recordId: TweakDBID;

    private let m_gender: CrowdGender;

    private let m_wealth: CrowdWealth;

    private let m_archetype: CrowdArchetype;

    private let m_association: CrowdAssociation;

    private let m_traits: array<CrowdTrait>;

    public func GetRecordID() -> TweakDBID {
	    return this.m_recordId;
    }

    public func SetRecordID(recordId: TweakDBID) -> Void {
        this.m_recordId = recordId;
    }

    public func GetGender() -> CrowdGender {
	    return this.m_gender;
    }

    public func SetGender(gender: CrowdGender) -> Void {
        this.m_gender = gender;
    }

    public func GetArchetype() -> CrowdArchetype {
	    return this.m_archetype;
    }

    public func SetArchetype(archetype: CrowdArchetype) -> Void {
        this.m_archetype = archetype;
    }

}