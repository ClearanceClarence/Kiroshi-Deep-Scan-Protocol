public func RandRange(seed: Int32, min: Int32, max: Int32) -> Int32 {
  // Add (max + 1) to account for truncation of floats.
  let val: Int32 = Cast(RandNoiseF(seed, Cast(min), Cast(max + 1)));
  return val;
}

public func RandTrueFalseWeighted(seed: Int32, opt weight: Int32) -> Bool {
  let val: Int32 = Cast(RandNoiseF(seed, 0.0, 100.0)) + weight;

  if val > 50 {
    return true;
  } else {
    return false;
  }
}

public func RandTrueFalse(seed: Int32) -> Bool {
  return RandTrueFalseWeighted(seed, 0);
}

// Calculates the cumulative density of a weighted set of events.
public static func CDF(weightedEvents: array<ref<LifePathEvent>>) -> array<Int32> {
    let i = 0;
    let cumulativeWeights: array<Int32>;
    let prev = 0;
    while i < ArraySize(weightedEvents) - 1 {
        ArrayPush(cumulativeWeights, prev + weightedEvents[i].weight);
        prev = prev + weightedEvents[i].weight;
        i += 1;
    }
    return cumulativeWeights;
}

public func RandChance(seed: Int32, probability: Float) -> Bool {
  let target: Int32 = Cast(100.0 * probability);
  let ret = RandRange(seed, 1, 100);
  if ret <= target {
    return true;
  } else {
    return false;
  }
}


public func shouldPrintDebugLog() -> Bool {
  return false;
}