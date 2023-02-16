import CoreKit
import Foundation

public final class Audio {
    public static let shared = Audio()
        
    public func initialize() {}
    private init() {
        log(event: "AudioKit initialized")
        Core.shared.audio = self
    }
}

extension Audio: AudioBridge {
    public func app(state: System.App.State) {}
    public func user(state: System.User.State) {}
}
