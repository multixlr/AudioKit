import CoreKit
import Foundation
import SimplyCoreAudio

extension Audio {
    internal class Core {
        private let core = SimplyCoreAudio()
        
        internal func set(immutable device: Audio.Device?, for source: Audio.Source, selected: Bool = true) {
            switch source {
            case .output:
                Settings.Audio.Output.immutable = device?.uid
                if let device, selected {
                    core.allOutputDevices.first(where: {$0.uid == device.uid})?.isDefaultOutputDevice = selected
                }
            case .input:
                Settings.Audio.Input.immutable = device?.uid
                if let device, selected {
                    core.allInputDevices.first(where: {$0.uid == device.uid})?.isDefaultInputDevice = selected
                }
            }
        }
        
        internal init() {
            setup()
        }
        private func setup() {
            setupNotifications()
        }
        private func setupNotifications() {
            NotificationCenter.default.addObserver(forName: .defaultOutputDeviceChanged,
                                                   object: nil,
                                                   queue: .current) { [weak core] (notification) in
                guard let core,
                      let immutable = Settings.Audio.Input.immutable,
                      let device = core.allOutputDevices.first(where: {$0.uid == immutable}),
                      core.defaultInputDevice?.uid != immutable
                else { return }
                device.isDefaultInputDevice = true
            }
            NotificationCenter.default.addObserver(forName: .defaultInputDeviceChanged,
                                                   object: nil,
                                                   queue: .current) { [weak core] (notification) in
                guard let core,
                      let immutable = Settings.Audio.Input.immutable,
                      let device = core.allInputDevices.first(where: {$0.uid == immutable}),
                      core.defaultInputDevice?.uid != immutable
                else { return }
                device.isDefaultInputDevice = true
            }
        }
    }
}
extension Audio.Core {
    internal var devices: [Audio.Device] {
        return core.allDevices.sorted(by: { $0.id < $1.id }).compactMap { Audio.Device(id: Int($0.id), uid: $0.uid, name: $0.name) }
    }
    internal var outputs: [Audio.Device] {
        return core.allOutputDevices.sorted(by: { $0.id < $1.id }).compactMap { Audio.Device(id: Int($0.id), uid: $0.uid, name: $0.name) }
    }
    internal var inputs: [Audio.Device] {
        return core.allInputDevices.sorted(by: { $0.id < $1.id }).compactMap { Audio.Device(id: Int($0.id), uid: $0.uid, name: $0.name) }
    }
}
