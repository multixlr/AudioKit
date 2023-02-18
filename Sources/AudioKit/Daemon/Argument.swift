import Foundation

extension Daemon {
    internal enum Argument: String {
        case disableTray = "--disable-tray"
    }
}
extension Collection where Element == Daemon.Argument {
    internal var strings: [String] {
        return compactMap { $0.rawValue }
    }
}
