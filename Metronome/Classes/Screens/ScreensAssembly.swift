import Foundation
import Swinject

final class ScreensAssembly: Assembly {
	func assemble(container: Container) {
		registerMainScreenInContainter(container)
		registerCustomMetreScreenInContainter(container)
		registerSettingsScreenInContainter(container)
		registerSelectSoundScreenInContainer(container)
	}
}

private extension ScreensAssembly {
	func registerMainScreenInContainter(_ container: Container) {
		container.register(MainScreenViewController.self) { r in
			
			let metreonomeEngine = r.resolve(MetronomeEngine.self) as! MetronomeEngineProtocol
			let userSettingsStorage = r.resolve(UserSettingsStorageClass.self) as! UserSettingsStorage
			let viewModel = MainScreenViewModel(metronomeEngine: metreonomeEngine, userSettingsStorage: userSettingsStorage)
			return MainScreenViewController(viewModel: viewModel)
		}
	}
	
	func registerCustomMetreScreenInContainter(_ container: Container) {
		container.register(CustomMetreViewController.self) { (r, currentMetre: Metre?) in
			let metronomeEngine = r.resolve(MetronomeEngine.self)!
			let model = CustomMetreModel(withMetronomeEngine: metronomeEngine)
			let viewModel = CustomMetreViewModel(withModel: model, currentMetre: currentMetre)
			return CustomMetreViewController(withViewModel: viewModel)
		}
	}
	
	func registerSettingsScreenInContainter(_ container: Container) {
		container.register(SettingsViewController.self) { r in
			let model = SettingsModel()
            let metronomeEngine = r.resolve(MetronomeEngine.self)!
			let viewModel = SettingsViewModel(withModel: model, metronomeEngine: metronomeEngine)
			return SettingsViewController(withViewModel: viewModel)
		}
	}
	
	func registerSelectSoundScreenInContainer(_ container: Container) {
		container.register(SelectSoundViewController.self) { r in
			let soundBank = r.resolve(SoundsBank.self)!
			let metronomeEngine = r.resolve(MetronomeEngine.self)!
			let model = SelectSoundModel(withSoundBank: soundBank, andMetronomeEngine: metronomeEngine)
			let viewModel = SelectSoundViewModel(withModel: model)
			return SelectSoundViewController(withViewModel: viewModel)
		}
	}
}
