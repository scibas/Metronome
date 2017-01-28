import Foundation
import Swinject

class AudioEngineAssembly: Assembly {
	func assemble(container: Container) {
		registerAudioEngineInConteiner(container)
		registerMetronomeEngineInConteiner(container)
		registerSoundBankInConteiner(container)
		registerUserSettingsStoregeInConteiner(container) // RefactorMe: Take me out of here! I don't belong here.
	}
}

private extension AudioEngineAssembly {
	func registerAudioEngineInConteiner(_ container: Container) {
		container.register(AudioEngine.self) { r in
			return AudioEngine()
		}.inObjectScope(.container)
	}
	
	func registerMetronomeEngineInConteiner(_ container: Container) {
		container.register(MetronomeEngine.self) { r in
			let audioEngine = r.resolve(AudioEngine.self) as! AudioEngineProtocol
			let soundBank = r.resolve(SoundsBank.self)!
			let appLifeCycleEvantBroadcaster = r.resolve(AppLifeCycleEventBroadcaster.self)!
            
			return MetronomeEngine(withAudioEngine: audioEngine, andSoundBank: soundBank, appLifeCycleEventBroadcaster: appLifeCycleEvantBroadcaster)
		}.inObjectScope(.container)
	}
	
    func registerSoundBankInConteiner(_ container: Container) {
		container.register(SoundsBank.self) { r in
			return SoundsBank()
		}.inObjectScope(.container)
	}
	
	func registerUserSettingsStoregeInConteiner(_ container: Container) {
		container.register(UserSettingsStorageClass.self) { r in
			return UserSettingsStorageClass()
		}.inObjectScope(.container)
	}
}

