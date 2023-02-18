import CoreKit
import Foundation

public final class Audio {
    public static let shared = Audio()
    
    private let daemon = Daemon()
    private let initializer = Initializer()
        
    public func initialize() {}
    private init() {
        log(event: "AudioKit initialized")
        Core.shared.audio = self
    }
}

extension Audio: AudioBridge {
    public func app(state: System.App.State) async {
        switch state {
        case .willFinishLaunching:
            break
//            do { try await daemon.start() }
//            catch { log(event: "Failed to start daemon, error: \(error)", source: .audio) }
        case .didFinishLaunching:
            do { try await initializer.start() }
            catch { log(event: "Failed to initialize device, error: \(error)", source: .audio) }
        case .willTerminate:
            do { try await daemon.stop() }
            catch { log(event: "Failed to stop daemon, error: \(error)", source: .audio) }
        default:
            break
        }
    }
    public func user(state: System.User.State) async {}
}
