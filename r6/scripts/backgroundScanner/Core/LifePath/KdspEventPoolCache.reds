// Kiroshi Deep Scan Protocol - Life Event Pool Cache
// Event pools only vary by archetype, so each pool is built once and reused.
// Pools are read-only after Initialize, which makes caching safe.

public class KdspEventPoolCache extends ScriptableSystem {

    private let m_archetypes: array<String>;
    private let m_pools: array<ref<KdspLifePathPossibilities>>;

    public static func GetInstance(gi: GameInstance) -> ref<KdspEventPoolCache> {
        return GameInstance.GetScriptableSystemsContainer(gi).Get(n"KdspEventPoolCache") as KdspEventPoolCache;
    }

    // Returns the cached pool for an archetype, building it on first request.
    public func GetPool(archetype: String) -> ref<KdspLifePathPossibilities> {
        let i: Int32 = 0;
        while i < ArraySize(this.m_archetypes) {
            if Equals(this.m_archetypes[i], archetype) {
                return this.m_pools[i];
            };
            i += 1;
        };

        // Cache miss — build and store
        let pool: ref<KdspLifePathPossibilities> = new KdspLifePathPossibilities();
        pool.Initialize(archetype);
        ArrayPush(this.m_archetypes, archetype);
        ArrayPush(this.m_pools, pool);
        return pool;
    }
}
