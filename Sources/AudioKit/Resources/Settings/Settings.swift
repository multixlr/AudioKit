import CoreKit
import Foundation

extension Settings {
    public struct Audio {}
}
extension Settings.Audio {
    public struct Output {}
}
extension Settings.Audio {
    public struct Input {}
}
extension Settings.Audio.Output {
    public static var immutable: String? {
        get { Settings.get(value: String.self, for: Settings.Keys.Audio.Output.immutable) ?? nil }
        set {
            guard let newValue else {
                Settings.remove(at: Settings.Keys.Audio.Output.immutable)
                return
            }
            Settings.set(value: newValue, for: Settings.Keys.Audio.Output.immutable)
        }
    }
}

extension Settings.Audio.Input {
    public static var immutable: String? {
        get { Settings.get(value: String.self, for: Settings.Keys.Audio.Input.immutable) ?? nil }
        set {
            guard let newValue else {
                Settings.remove(at: Settings.Keys.Audio.Input.immutable)
                return
            }
            Settings.set(value: newValue, for: Settings.Keys.Audio.Input.immutable)
        }
    }
}
