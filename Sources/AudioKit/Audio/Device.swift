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
