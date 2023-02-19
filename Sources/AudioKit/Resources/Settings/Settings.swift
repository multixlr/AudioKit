import CoreKit
import Foundation

extension Settings {
    public struct Audio {}
}
extension Settings.Audio {
    public struct Input {}
}
extension Settings.Audio.Input {
    public static var immutable: String? {
        get { Settings.get(value: String.self, for: Settings.Keys.Audio.Input.immutable) ?? nil }
        set { Settings.set(value: newValue, for: Settings.Keys.Audio.Input.immutable) }
    }
}
