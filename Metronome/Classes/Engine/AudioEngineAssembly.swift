import Foundation
import Swinject

class AudioEngineAssembly: Assembly {
	func assemble(container: Container) {
		registerAudioEngine(in: container)
		registerMetronomeEngine(in: container)
		registerSoundBank(in: container)
        registerUserSettingsStorege(in: container) // RefactorMe: Take me out of here! I don't belong here.
        registerMetreBank(in: container)
	}
}

private extension AudioEngineAssembly {
	func registerAudioEngine(in container: Container) {
		container.register(AudioEngine.self) { r in
			return AudioEngine()
		}.inObjectScope(.container)
	}
	
	func registerMetronomeEngine(in container: Container) {
		container.register(MetronomeEngine.self) { r in
			let audioEngine = r.resolve(AudioEngine.self) as! AudioEngineProtocol
			let soundBank = r.resolve(SoundsBank.self)!
			let appLifeCycleEvantBroadcaster = r.resolve(AppLifeCycleEventBroadcaster.self)!
            
			return MetronomeEngine(withAudioEngine: audioEngine, andSoundBank: soundBank, appLifeCycleEventBroadcaster: appLifeCycleEvantBroadcaster)
		}.inObjectScope(.container)
	}
	
    func registerSoundBank(in container: Container) {
		container.register(SoundsBank.self) { r in
			return SoundsBank()
		}.inObjectScope(.container)
	}
	
	func registerUserSettingsStorege(in container: Container) {
		container.register(UserSettingsStorageClass.self) { r in
			return UserSettingsStorageClass()
		}.inObjectScope(.container)
	}
    
    func registerMetreBank(in container: Container) {
        container.register(MetreBank.self) { _ in
            return MetreBank()
        }.inObjectScope(.container)
    }
}
