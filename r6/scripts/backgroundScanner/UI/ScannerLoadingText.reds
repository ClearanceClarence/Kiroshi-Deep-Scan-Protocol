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
        
        // Always start with connection
        ArrayPush(lines, KdspScannerLoadingText.GetConnectionLine(seed));
        
        // Fill middle lines based on count
        let i = 1;
        while i < lineCount - 1 {
            let lineType = RandRange(seed + (i * 50), 1, 100);
            
            // 15% chance of error/warning line (only on medium/high)
            if density >= 2 && lineType <= 15 {
                ArrayPush(lines, KdspScannerLoadingText.GetErrorLine(seed + (i * 77)));
            }
            // 30% chance of database line
            else if lineType <= 45 {
                ArrayPush(lines, KdspScannerLoadingText.GetDatabaseLine(seed + (i * 100)));
            }
            // 30% chance of processing line
            else if lineType <= 75 {
                ArrayPush(lines, KdspScannerLoadingText.GetProcessingLine(seed + (i * 123)));
            }
            // 25% chance of status line
            else {
                ArrayPush(lines, KdspScannerLoadingText.GetStatusLine(seed + (i * 147)));
            }
            i += 1;
        }
        
        // Always end with success
        ArrayPush(lines, KdspScannerLoadingText.GetSuccessLine(seed + 999));
        
        return lines;
    }

    // ══════════════════════════════════════════════════════════════════════
    // CONNECTION / INITIALIZATION LINES
    // ══════════════════════════════════════════════════════════════════════
    private static func GetConnectionLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, "Initializing Kiroshi Deep Scan Protocol...");
        ArrayPush(lines, "Establishing secure NetWatch bypass...");
        ArrayPush(lines, "Spoofing authentication credentials...");
        ArrayPush(lines, "Kiroshi Mk.IV neural link established...");
        ArrayPush(lines, "Routing connection through proxy node...");
        ArrayPush(lines, "Handshaking with NCPD central server...");
        ArrayPush(lines, "Initiating multi-spectrum biometric scan...");
        ArrayPush(lines, "Deep Scan subroutine loaded...");
        ArrayPush(lines, "Engaging passive reconnaissance mode...");
        ArrayPush(lines, "Calibrating optical recognition matrix...");
        ArrayPush(lines, "Neural pattern lock acquired...");
        ArrayPush(lines, "Pinging Night City datafortress nodes...");
        ArrayPush(lines, "Quantum encryption handshake initiated...");
        ArrayPush(lines, "Optical implant sync complete...");
        ArrayPush(lines, "Kiroshi subsystems online...");
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // DATABASE ACCESS LINES
    // ══════════════════════════════════════════════════════════════════════
    private static func GetDatabaseLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, "Accessing NCPD criminal database...");
        ArrayPush(lines, "Querying Night City Medical Registry...");
        ArrayPush(lines, "Pulling cyberware registration records...");
        ArrayPush(lines, "Scanning Trauma Team coverage database...");
        ArrayPush(lines, "Accessing Arasaka Banking Node [ENCRYPTED]...");
        ArrayPush(lines, "Fetching immigration services records...");
        ArrayPush(lines, "Decrypting Militech personnel files...");
        ArrayPush(lines, "Connecting to Ripperdoc Network...");
        ArrayPush(lines, "Accessing social credit score database...");
        ArrayPush(lines, "Querying gang affiliation registry...");
        ArrayPush(lines, "Pulling employment verification records...");
        ArrayPush(lines, "Accessing sealed court records...");
        ArrayPush(lines, "Fetching NCPD facial recognition data...");
        ArrayPush(lines, "Querying Zetatech employee database...");
        ArrayPush(lines, "Scanning Biotechnica medical trials registry...");
        ArrayPush(lines, "Accessing Kang Tao import/export manifests...");
        ArrayPush(lines, "Pulling NetWatch flagged communications...");
        ArrayPush(lines, "Querying Petrochem contractor database...");
        ArrayPush(lines, "Accessing Night City tax records...");
        ArrayPush(lines, "Pulling Trauma Team incident reports...");
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // PROCESSING / ANALYSIS LINES
    // ══════════════════════════════════════════════════════════════════════
    private static func GetProcessingLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, "Compiling threat assessment matrix...");
        ArrayPush(lines, "Analyzing neural signature patterns...");
        ArrayPush(lines, "Processing criminal record fragments...");
        ArrayPush(lines, "Running background check algorithm...");
        ArrayPush(lines, "Correlating known associates...");
        ArrayPush(lines, "Mapping financial transaction history...");
        ArrayPush(lines, "Reconstructing employment timeline...");
        ArrayPush(lines, "Verifying cyberware serial numbers...");
        ArrayPush(lines, "Calculating cyberpsychosis risk index...");
        ArrayPush(lines, "Cross-matching gang tattoo database...");
        ArrayPush(lines, "Analyzing behavioral prediction model...");
        ArrayPush(lines, "Processing biometric data clusters...");
        ArrayPush(lines, "Running facial recognition subroutine...");
        ArrayPush(lines, "Decoding encrypted medical records...");
        ArrayPush(lines, "Triangulating last known locations...");
        ArrayPush(lines, "Parsing social network connections...");
        ArrayPush(lines, "Evaluating psychological profile markers...");
        ArrayPush(lines, "Cross-referencing witness statements...");
        ArrayPush(lines, "Analyzing spending patterns...");
        ArrayPush(lines, "Reconstructing travel history...");
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // STATUS LINES
    // ══════════════════════════════════════════════════════════════════════
    private static func GetStatusLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, "Bypassing Militech firewall... SUCCESS");
        ArrayPush(lines, "Evading Arasaka countermeasures...");
        ArrayPush(lines, "Data broker fee: 0.02 eddies [AUTO-PAID]");
        ArrayPush(lines, "Connection stable. No trace detected.");
        ArrayPush(lines, "Scrubbing proxy logs...");
        ArrayPush(lines, "NetWatch alert level: GREEN");
        ArrayPush(lines, "Masking origin point... DONE");
        ArrayPush(lines, "Verifying data integrity...");
        ArrayPush(lines, "Secondary sources: 3 matches found");
        ArrayPush(lines, "Archive search: 847 records scanned");
        ArrayPush(lines, "Real-time threat assessment: MINIMAL");
        ArrayPush(lines, "Firewall penetration: 100%");
        ArrayPush(lines, "ICE countermeasures: NEUTRALIZED");
        ArrayPush(lines, "Black ICE detection: NEGATIVE");
        ArrayPush(lines, "Daemon injection: NOT REQUIRED");
        ArrayPush(lines, "Trace route: OBSCURED");
        ArrayPush(lines, "NCPD monitoring: EVADED");
        ArrayPush(lines, "Corporate oversight: NONE DETECTED");
        ArrayPush(lines, "Proxy chain: 7 nodes active");
        ArrayPush(lines, "Signal strength: OPTIMAL");
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // ERROR / WARNING LINES (recovered from)
    // ══════════════════════════════════════════════════════════════════════
    private static func GetErrorLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, "WARNING: Partial records detected");
        ArrayPush(lines, "ERROR: Arasaka node timeout... retrying...");
        ArrayPush(lines, "ALERT: NetWatch probe detected... evading...");
        ArrayPush(lines, "Connection interrupted... reconnecting...");
        ArrayPush(lines, "ERROR: Database query failed... rerouting...");
        ArrayPush(lines, "WARNING: Incomplete financial data");
        ArrayPush(lines, "ALERT: Corporate ICE detected... bypassing...");
        ArrayPush(lines, "ERROR: Authentication rejected... spoofing...");
        ArrayPush(lines, "WARNING: Medical records [PARTIALLY SEALED]");
        ArrayPush(lines, "NOTICE: Subject flagged in 2 databases");
        ArrayPush(lines, "ERROR: Militech firewall... breach in progress...");
        ArrayPush(lines, "WARNING: Corrupted data block... reconstructing...");
        ArrayPush(lines, "ALERT: Trace attempt detected... masking...");
        ArrayPush(lines, "ERROR: Timeout on NCPD node... switching...");
        ArrayPush(lines, "WARNING: Criminal records [EXPUNGED - RECOVERING]");
        ArrayPush(lines, "NOTICE: Some records may be outdated");
        ArrayPush(lines, "ERROR: Kang Tao server unreachable... skipping...");
        ArrayPush(lines, "WARNING: Immigration data incomplete");
        ArrayPush(lines, "ALERT: Black ICE signature... neutralizing...");
        ArrayPush(lines, "ERROR: Zetatech connection lost... retrying...");
        ArrayPush(lines, "WARNING: Subject has counter-surveillance implant");
        ArrayPush(lines, "NOTICE: Archived records only - no live data");
        ArrayPush(lines, "ERROR: Decryption failed... using backup key...");
        ArrayPush(lines, "WARNING: Data integrity check failed... verifying...");
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }

    // ══════════════════════════════════════════════════════════════════════
    // SUCCESS / COMPLETION LINES (always last)
    // ══════════════════════════════════════════════════════════════════════
    private static func GetSuccessLine(seed: Int32) -> String {
        let lines: array<String>;
        ArrayPush(lines, "Scan complete. Displaying results.");
        ArrayPush(lines, "Data compilation complete. Confidence: 94.7%");
        ArrayPush(lines, "Profile assembled from 7 data sources.");
        ArrayPush(lines, "All systems nominal. Rendering output.");
        ArrayPush(lines, "Analysis complete. No anomalies detected.");
        ArrayPush(lines, "Subject profile compiled successfully.");
        ArrayPush(lines, "Database query complete. Rendering...");
        ArrayPush(lines, "Records retrieved. Processing complete.");
        ArrayPush(lines, "Deep scan finished. Confidence: HIGH");
        ArrayPush(lines, "Intel package ready. Displaying profile.");
        ArrayPush(lines, "Compilation successful. 12 records merged.");
        ArrayPush(lines, "Query complete. Threat assessment ready.");
        ArrayPush(lines, "Profile locked. Displaying subject data.");
        ArrayPush(lines, "Scan finalized. Accuracy: 97.2%");
        ArrayPush(lines, "All databases queried. Results compiled.");
        ArrayPush(lines, "Data aggregation complete. Rendering...");
        ArrayPush(lines, "Subject analysis complete. Displaying...");
        ArrayPush(lines, "Profile generation successful.");
        return lines[RandRange(seed, 0, ArraySize(lines) - 1)];
    }
}
