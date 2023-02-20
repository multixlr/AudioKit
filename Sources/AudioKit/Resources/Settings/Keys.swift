import CoreKit
import Foundation

extension Settings.Keys {
    public struct Audio {}
}
extension Settings.Keys.Audio {
    public struct Output {}
}
extension Settings.Keys.Audio {
    public struct Input {}
}
extension Settings.Keys.Audio.Output {
    public static let immutable = "settings/keys/audio/output/immutable"
}
extension Settings.Keys.Audio.Input {
    public static let immutable = "settings/keys/audio/input/immutable"
}
