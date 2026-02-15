/* 
* A weighted collection of lifepath events of various criterias. Initialized based on character's archetype.
*
* Events are categorized into positive, neutral, and negative. NPC archetypes that are more successful in nature lean towards generating backgrounds
* that are associated with more positive events (rich citizens, corpos, etc...). NPCs from less desirable archetypes are lean towards generating more negative/neutral
* events.
*
* There are several additional modifiers that can make certain events more likely. For instance, CORPO type citizens are more likely to get events that involve working
* with corporations, NOMAD citizens are more likely to get Nomad events, etc...
*
* Events are weighted within an array using a cumlative density function that maps back to the array's index, allow us to make certain outcomes more/or less likely for certain
* types for characters. More on that here: https://stackoverflow.com/questions/4463561/weighted-random-selection-from-array
*
*/
public class KdspLifePathPossibilities {

    // Upbringing
    public final let m_weightedUpbringingEvents: array<ref<KdspLifePathEvent>>;
    public final let m_cdfWeightedUpbringingEvents: array<Int32>;

    // Home
    public final let m_weightedHomeEvents: array<ref<KdspLifePathEvent>>;
    public final let m_cdfWeightedHomeEvents: array<Int32>;

    // Childhood 
    public final let m_weightedChildhoodEvents: array<ref<KdspLifePathEvent>>;
    public final let m_cdfWeightedChildhoodEvents: array<Int32>;

    // Job 
    public final let m_weightedJobEvents: array<ref<KdspLifePathEvent>>;
    public final let m_cdfWeightedJobEvents: array<Int32>;

    // Adulthood 
    public final let m_weightedAdultEvents: array<ref<KdspLifePathEvent>>;
    public final let m_cdfWeightedAdultEvents: array<Int32>;

    public func Initialize(archetype: String) -> Void {
        let positiveOutcomeWeight: Int32;
        let neutralOutcomeWeight: Int32;
        let negativeOutcomeWeight: Int32;

        let corpoMod: Int32;
        let nomadMod: Int32;
        let junkieMod: Int32;
        let gangerMod: Int32;
        let homelessMod: Int32;

        if Equals(archetype, "CORPO_MANAGER") {
            positiveOutcomeWeight = 100;
            neutralOutcomeWeight = 5;
            negativeOutcomeWeight = 0;
            corpoMod = 75;
        };
        if Equals(archetype, "CORPO_DRONE") {
            positiveOutcomeWeight = 85;
            neutralOutcomeWeight = 10;
            negativeOutcomeWeight = 5;
            corpoMod = 30;
        };
        if Equals(archetype, "NOMAD") {
            positiveOutcomeWeight = 10;
            neutralOutcomeWeight = 60;
            negativeOutcomeWeight = 30;
            nomadMod = 100;
        };
        if Equals(archetype, "HOMELESS") {
            positiveOutcomeWeight = 1;
            neutralOutcomeWeight = 20;
            negativeOutcomeWeight = 79;
        };
        if Equals(archetype, "JUNKIE") {
            positiveOutcomeWeight = 3;
            neutralOutcomeWeight = 15;
            negativeOutcomeWeight = 82;
            junkieMod = 30;
        };
        if Equals(archetype, "LOWLIFE") {
            positiveOutcomeWeight = 15;
            neutralOutcomeWeight = 35;
            negativeOutcomeWeight = 50;
        };
        if Equals(archetype, "GANGER") {
            positiveOutcomeWeight = 10;
            neutralOutcomeWeight = 50;
            negativeOutcomeWeight = 40;
            gangerMod = 50;
        };
        if Equals(archetype, "CIVVIE") {
            positiveOutcomeWeight = 30;
            neutralOutcomeWeight = 50;
            negativeOutcomeWeight = 20;
        };
        if Equals(archetype, "YUPPIE") {
            positiveOutcomeWeight = 85;
            neutralOutcomeWeight = 14;
            negativeOutcomeWeight = 1;
        };
        this.m_weightedUpbringingEvents = UpbringingEvents(positiveOutcomeWeight, neutralOutcomeWeight, negativeOutcomeWeight, corpoMod, nomadMod, junkieMod, gangerMod);
        this.m_cdfWeightedUpbringingEvents = CDF(this.m_weightedUpbringingEvents);

        this.m_weightedHomeEvents = HomeEvents(positiveOutcomeWeight, neutralOutcomeWeight, negativeOutcomeWeight, corpoMod, nomadMod, junkieMod, gangerMod, homelessMod);
        this.m_cdfWeightedHomeEvents= CDF(this.m_weightedHomeEvents);

        this.m_weightedChildhoodEvents = ChildhoodEvents(positiveOutcomeWeight, neutralOutcomeWeight, negativeOutcomeWeight, corpoMod, nomadMod, junkieMod, gangerMod, homelessMod);
        this.m_cdfWeightedChildhoodEvents= CDF(this.m_weightedChildhoodEvents);

        this.m_weightedJobEvents = JobEvents(positiveOutcomeWeight, neutralOutcomeWeight, negativeOutcomeWeight, corpoMod, nomadMod, junkieMod, gangerMod, homelessMod);
        this.m_cdfWeightedJobEvents= CDF(this.m_weightedJobEvents);

        this.m_weightedAdultEvents = AdultEvents(positiveOutcomeWeight, neutralOutcomeWeight, negativeOutcomeWeight, corpoMod, nomadMod, junkieMod, gangerMod, homelessMod);
        this.m_cdfWeightedAdultEvents = CDF(this.m_weightedAdultEvents);
    }
}