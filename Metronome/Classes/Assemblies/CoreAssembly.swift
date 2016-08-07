import Foundation
import Swinject

class CoreAssembly: AssemblyType {
    
    func assemble(container: Container) {
        registerAudioEngineInConteiner(container)
        registerMetronomeEngineInConteiner(container)
        registerUserSettingsStoregeInConteiner(container)
    }
    
    private func registerAudioEngineInConteiner(container: Container) {
        container.register(AudioEngine.self) { r in
            return AudioEngine()
        }
    }

    private func registerMetronomeEngineInConteiner(container: Container) {
        container.register(MetronomeEngine.self) { r in
            let audioEngine = r.resolve(AudioEngine.self) as! AudioEngineProtocol
            let soundBank = SoundsBank()
            
            return MetronomeEngine(withAudioEngine: audioEngine, andSoundBank: soundBank)
        }
    }
    
    private func registerUserSettingsStoregeInConteiner(container: Container) {
        container.register(UserSettingsStorageClass.self) { r in
            return UserSettingsStorageClass()
        }
    }
}

