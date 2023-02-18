import Foundation

extension Audio {
    internal enum Error: Swift.Error, CustomStringConvertible {
        case daemonPath
        case libraryPath
        
        internal var description: String {
            switch self {
            case .daemonPath:
                return "Invalid path for daemon provided."
            case .libraryPath:
                return "Invalid path for library."
            }
        }
    }
}
