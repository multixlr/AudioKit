import CoreKit
import AppKit
import Foundation

extension Process {
    internal func start(_ executable: URL, with arguments: [String] = []) throws {
        try? stop(forced: true)
        let pipe = Pipe()
        self.executableURL = executable
        self.arguments = arguments
        self.standardError = pipe
        self.standardOutput = pipe
        self.terminationHandler = { process in
            let output = String(decoding: pipe.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self)
            log(event: "Process '\(executable.lastPathComponent)' terminated with reason: '\(process.terminationReason.description)'\n\(output)")
        }
        try run()
    }
    internal func stop(forced: Bool = false) throws {
        guard !forced else { kill(); return }
        guard isRunning else {
            throw Process.Error.stopped
        }
        interrupt()
    }
    private func kill() {
        let pipe = Pipe()
        let process = Process()
        process.executableURL = URL(string: "file:///usr/bin/killall")
        process.arguments = ["goxlr-daemon"]
        process.standardOutput = pipe
        process.standardError = pipe
        try? process.run()
        process.waitUntilExit()
    }
}
extension Process.TerminationReason {
    internal var description: String {
        switch self {
        case .exit:
            return "Exit"
        case .uncaughtSignal:
            return "Uncaught Signal"
        @unknown default:
            return "Unknown reason"
        }
    }
}
extension Process {
    internal enum Error: Swift.Error, CustomStringConvertible {
        case stopped
        
        internal var description: String {
            switch self {
            case .stopped:
                return "Process is not running."
            }
        }
    }
}
