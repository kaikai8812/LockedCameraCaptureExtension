import LockedCameraCapture
import AppIntents

struct CaptureIntent: CameraCaptureIntent {
    static var title: LocalizedStringResource = "CaptureIntent"
    
    @MainActor
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
