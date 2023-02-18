import CoreKit
import Foundation

fileprivate let daemon = Bundle.module.url(forResource: "goxlr-daemon", withExtension: "")

internal class Daemon {
    private var process = Process()
    private var timer = Timer()
    
    internal func start(with arguments: Set<Argument> = [.disableTray]) async throws {
        guard let daemon else { throw Audio.Error.daemonPath }
        process = Process()
        try await process.start(daemon, with: arguments.strings)
        log(event: "Daemon started successfully", source: .audio)
    }
    internal func stop(forced: Bool = false) async throws {
        try await process.stop(forced: forced)
        log(event: "Daemon stopped successfully", source: .audio)
    }
    internal func restart() async throws {
        try await stop(forced: true)
        try await start()
    }
}
