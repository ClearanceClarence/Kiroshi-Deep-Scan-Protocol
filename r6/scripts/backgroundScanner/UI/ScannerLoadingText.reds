// Scanner Loading Text Generator
// Generates immersive randomized loading messages

public class KdspScannerLoadingText {

    // Generate a set of loading lines for the scanner
    // Line count adjusted by data density setting
    public static func GenerateLoadingSequence(seed: Int32) -> array<String> {
        let lines: array<String>;
        
        // Determine line count based on density
        // Low: 2-3, Medium: 3-5, High: 3-8
        let density = KdspSettings.GetDataDensity();
        let lineCount: Int32;
        
        if density == 1 {
            lineCount = RandRange(seed, 2, 3);
        } else if density == 2 {
            lineCount = RandRange(seed, 3, 5);
        } else {
            lineCount = RandRange(seed, 3, 8);
        }
        
        // Detect the player's district for location-flavored lines.
        // Scan range is short, so player and target share a district.
        let district: String = "UNKNOWN";
        let player = GetPlayer(GetGameInstance());
        if IsDefined(player) {
            district = KdspCrowdDistrictManager.GetCurrentDistrict(player.GetWorldPosition());
        };

        // Always start with connection
        ArrayPush(lines, KdspTextLoading.GetConnectionLine(seed));

        // When the district is known, the second line routes through
        // local infrastructure before hitting citywide databases
        let usedDistrictLine: Bool = false;
        if lineCount >= 3 && NotEquals(district, "UNKNOWN") {
            ArrayPush(lines, KdspTextLoading.GetDistrictLine(seed + 31, district));
            usedDistrictLine = true;
        };

        // Fill middle lines based on count
        let i = 1;
        if usedDistrictLine { i = 2; };
        while i < lineCount - 1 {
            let lineType = RandRange(seed + (i * 50), 1, 100);
            
            // 15% chance of error/warning line (only on medium/high)
            if density >= 2 && lineType <= 15 {
                ArrayPush(lines, KdspTextLoading.GetErrorLine(seed + (i * 77)));
            }
            // 30% chance of database line
            else if lineType <= 45 {
                ArrayPush(lines, KdspTextLoading.GetDatabaseLine(seed + (i * 100)));
            }
            // 30% chance of processing line
            else if lineType <= 75 {
                ArrayPush(lines, KdspTextLoading.GetProcessingLine(seed + (i * 123)));
            }
            // 25% chance of status line
            else {
                ArrayPush(lines, KdspTextLoading.GetStatusLine(seed + (i * 147)));
            }
            i += 1;
        }
        
        // Always end with success
        ArrayPush(lines, KdspTextLoading.GetSuccessLine(seed + 999));
        
        return lines;
    }

    // ══════════════════════════════════════════════════════════════════════
    // DISTRICT-FLAVORED LINES
    // ══════════════════════════════════════════════════════════════════════

    // ══════════════════════════════════════════════════════════════════════
    // CONNECTION / INITIALIZATION LINES
    // ══════════════════════════════════════════════════════════════════════

    // ══════════════════════════════════════════════════════════════════════
    // DATABASE ACCESS LINES
    // ══════════════════════════════════════════════════════════════════════

    // ══════════════════════════════════════════════════════════════════════
    // PROCESSING / ANALYSIS LINES
    // ══════════════════════════════════════════════════════════════════════

    // ══════════════════════════════════════════════════════════════════════
    // STATUS LINES
    // ══════════════════════════════════════════════════════════════════════

    // ══════════════════════════════════════════════════════════════════════
    // ERROR / WARNING LINES (recovered from)
    // ══════════════════════════════════════════════════════════════════════

    // ══════════════════════════════════════════════════════════════════════
    // SUCCESS / COMPLETION LINES (always last)
    // ══════════════════════════════════════════════════════════════════════
}
