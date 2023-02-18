import CoreKit
import Foundation
import ServiceManagement

fileprivate let full = Bundle.module.url(forResource: "com.multixlr.goxlr", withExtension: "plist")
fileprivate let mini = Bundle.module.url(forResource: "com.multixlr.goxlr.mini", withExtension: "plist")
fileprivate let agents = Bundle.main.bundleURL.appending(path: "Contents/Library/LaunchAgents")
fileprivate let handler = Bundle.module.url(forResource: "goxlr-xpchandler", withExtension: "")
fileprivate let initializer = Bundle.module.url(forResource: "goxlr-initializer", withExtension: "")
fileprivate let directory = try? URL(for: .applicationSupportDirectory, in: .userDomainMask).appending(path: "\(System.App.bundle)")

internal class Initializer {
    public func start() async throws {
        try await install()
        try await initialize(process: .handler)
        try await initialize(process: .initializer)
        try await register()
    }
    
    private func install() async throws {
        guard let directory, let handler, let initializer, let full, let mini else { throw Audio.Error.libraryPath }
        
        let manager = FileManager.default
        let _full = agents.appending(path: "com.multixlr.goxlr.plist")
        let _mini = agents.appending(path: "com.multixlr.goxlr.mini.plist")
        let _handler = directory.appending(path: "goxlr-xpchandler")
        let _initializer = directory.appending(path: "goxlr-initializer")
        
        if !manager.fileExists(atPath: agents.path()) {
            try? manager.createDirectory(at: agents, withIntermediateDirectories: true)
        }
        if !manager.fileExists(atPath: _full.path()) {
            try? manager.copyItem(at: full, to: _full)
        }
        if !manager.fileExists(atPath: _mini.path()) {
            try? manager.copyItem(at: mini, to: _mini)
        }
        if !manager.fileExists(atPath: directory.path()) {
            try? manager.createDirectory(at: directory, withIntermediateDirectories: true)
        }
        if !manager.fileExists(atPath: _handler.path(percentEncoded: false)) {
            try? manager.copyItem(at: handler, to: _handler)
        }
        if !manager.fileExists(atPath: _initializer.path(percentEncoded: false)) {
            try? manager.copyItem(at: initializer, to: _initializer)
        }
        
        log(event: "Installation completed", source: .audio)
    }
    private func initialize(process: Process) async throws {
        guard let executable = process.executable else { return }
        let task = Foundation.Process()
        try task.start(executable)
        log(event: "Initialized \(process.description.lowercased())", source: .audio)
    }
    private func register() async throws {
        try SMAppService.agent(plistName: "com.multixlr.goxlr.plist").register()
        try SMAppService.agent(plistName: "com.multixlr.goxlr.mini.plist").register()
        log(event: "Agents registered", source: .audio)
    }
}
extension Initializer {
    private enum Process {
        case handler
        case initializer
        
        internal var executable: URL? {
            switch self {
            case .handler:
                return AudioKit.handler
            case .initializer:
                return AudioKit.initializer
            }
        }
        internal var description: String {
            switch self {
            case .handler:
                return "Handler"
            case .initializer:
                return "Initializer"
            }
        }
    }
}
