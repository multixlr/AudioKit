import CoreKit
import Foundation
import SimplyCoreAudio

extension Audio {
    public struct Device: Hashable, Identifiable {
        public let id: Int
        public let uid: String?
        public let name: String
    }
}

extension Audio.Device {
    public func immutable(source: Audio.Source) -> Bool {
        switch source {
        case .output:
            return Settings.Audio.Output.immutable == uid
        case .input:
            return Settings.Audio.Input.immutable == uid
        }
    }
}
