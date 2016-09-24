import Foundation
import Swinject

class AudioEngineAssembly: AssemblyType {
	func assemble(container: Container) {
		registerAudioEngineInConteiner(container)
		registerMetronomeEngineInConteiner(container)
		registerSoundBankInConteiner(container)
		registerUserSettingsStoregeInConteiner(container) // RefactorMe: Take me out of here! I don't belong here.
	}
}

private extension AudioEngineAssembly {
	private func registerAudioEngineInConteiner(container: Container) {
		container.register(AudioEngine.self) { r in
			return AudioEngine()
		}.inObjectScope(.Container)
	}
	
	private func registerMetronomeEngineInConteiner(container: Container) {
		container.register(MetronomeEngine.self) { r in
			let audioEngine = r.resolve(AudioEngine.self) as! AudioEngineProtocol
			let soundBank = r.resolve(SoundsBank.self)!
			
			return MetronomeEngine(withAudioEngine: audioEngine, andSoundBank: soundBank)
		}.inObjectScope(.Container)
	}
	
    private func registerSoundBankInConteiner(container: Container) {
		container.register(SoundsBank.self) { r in
			return SoundsBank()
		}.inObjectScope(.Container)
	}
	
	private func registerUserSettingsStoregeInConteiner(container: Container) {
		container.register(UserSettingsStorageClass.self) { r in
			return UserSettingsStorageClass()
		}.inObjectScope(.Container)
	}
}

