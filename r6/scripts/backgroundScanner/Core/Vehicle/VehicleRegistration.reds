// Kiroshi Deep Scan - Vehicle Registration Generator
// Procedural vehicle ownership, registration status, and license plates

public abstract class KdspVehicleRegistration {

    public static func GenerateVehicleRegistration(seed: Int32, archetype: String, ncID: String) -> String {
        let result: String = "";

        // Vehicle make/model based on archetype
        let makeRoll = RandRange(seed, 0, 7);
        let isCorpo = Equals(archetype, "CORPO_MANAGER") || Equals(archetype, "CORPO_DRONE");
        let isRich = Equals(archetype, "YUPPIE") || Equals(archetype, "CORPO_MANAGER");
        let isNomad = Equals(archetype, "NOMAD");

        if isRich {
            if makeRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T0"); }
            else if makeRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T1"); }
            else if makeRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S0"); }
            else if makeRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T2"); }
            else if makeRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S1"); }
            else if makeRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S2"); }
            else if makeRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T3"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T4"); }
        } else if isCorpo {
            if makeRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S3"); }
            else if makeRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T5"); }
            else if makeRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S4"); }
            else if makeRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S5"); }
            else if makeRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S6"); }
            else if makeRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T6"); }
            else if makeRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S7"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T7"); }
        } else if isNomad {
            if makeRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S8"); }
            else if makeRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S9"); }
            else if makeRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S10"); }
            else if makeRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S11"); }
            else if makeRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S12"); }
            else if makeRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S13"); }
            else if makeRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S14"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S15"); }
        } else {
            if makeRoll == 0 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S16"); }
            else if makeRoll == 1 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S17"); }
            else if makeRoll == 2 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S18"); }
            else if makeRoll == 3 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S19"); }
            else if makeRoll == 4 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S7"); }
            else if makeRoll == 5 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S5"); }
            else if makeRoll == 6 { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S4"); }
            else { result = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S20"); }
        }

        // License plate
        let plateA = RandRange(seed + 101, 0, 25);
        let plateB = RandRange(seed + 102, 0, 25);
        let plateNum = RandRange(seed + 103, 1000, 9999);
        let letters = GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-T8");
        let plate = StrMid(letters, plateA, 1) + StrMid(letters, plateB, 1) + "-" + IntToString(plateNum);
        result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S21") + plate;

        // Registration status
        let statusRoll = RandRange(seed + 200, 0, 9);
        if statusRoll <= 5 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S22"); }
        else if statusRoll <= 7 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S23"); }
        else if statusRoll == 8 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S24"); }
        else { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S25"); }

        // Violations (30% chance)
        let violationRoll = RandRange(seed + 300, 1, 100);
        if violationRoll <= 30 {
            let vCount = RandRange(seed + 301, 1, 12);
            result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S26") + IntToString(vCount);
            let vTypeRoll = RandRange(seed + 302, 0, 5);
            if vTypeRoll == 0 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S27"); }
            else if vTypeRoll == 1 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S28"); }
            else if vTypeRoll == 2 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S29"); }
            else if vTypeRoll == 3 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S30"); }
            else if vTypeRoll == 4 { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S31"); }
            else { result = result + GetLocalizedTextByKey(n"Kdsp-VehicleRegistr-S32"); }
        }

        return result;
    }

    // ══════════════════════════════════════════════════════════════
    // NET PROFILE
    // Digital footprint, browsing flags, aliases, social presence.

}
