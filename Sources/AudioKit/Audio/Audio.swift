import CoreKit
import Foundation

internal let queue = DispatchQueue(label: "com.audio.queue", qos: .userInteractive, attributes: .concurrent)

public final class Audio {
    public static let shared = Audio()
    
    private let core = Core()
    private let daemon = Daemon()
    private let initializer = Initializer()
        
    public func initialize() {}
    private init() {
        log(event: "AudioKit initialized")
        CoreKit.Core.shared.audio = self
    }
}
extension Audio: AudioBridge {
    public func app(state: System.App.State) async {
        switch state {
        case .didFinishLaunching:
            do { try await initializer.start() }
            catch { log(event: "Failed to initialize device, error: \(error)", source: .audio) }
            do { try await daemon.start() }
            catch { log(event: "Failed to start daemon, error: \(error)", source: .audio) }
        case .willTerminate:
            do { try await daemon.stop() }
            catch { log(event: "Failed to stop daemon, error: \(error)", source: .audio) }
        default:
            break
        }
    }
    public func user(state: System.User.State) async {}
}
extension Audio {
    public static func set(immutable device: Audio.Device?, for source: Audio.Source, selected: Bool = true) {
        shared.core.set(immutable: device, for: source, selected: selected)
    }
    public var devices: [Audio.Device] { core.devices }
    public var outputs: [Audio.Device] { core.outputs }
    public var inputs: [Audio.Device] { core.inputs }
}
