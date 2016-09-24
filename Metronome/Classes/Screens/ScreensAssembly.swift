import Foundation
import Swinject

final class ScreensAssembly: AssemblyType {
	func assemble(container: Container) {
		registerMainScreenInContainter(container)
		registerCustomMetreScreenInContainter(container)
		registerSettingsScreenInContainter(container)
		registerSelectSoundScreenInContainer(container)
	}
}

private extension ScreensAssembly {
	private func registerMainScreenInContainter(container: Container) {
		container.register(MainScreenViewController.self) { r in
			
			let metreonomeEngine = r.resolve(MetronomeEngine.self) as! MetronomeEngineProtocol
			let userSettingsStorage = r.resolve(UserSettingsStorageClass.self) as! UserSettingsStorage
			let viewModel = MainScreenViewModel(metronomeEngine: metreonomeEngine, userSettingsStorage: userSettingsStorage)
			return MainScreenViewController(viewModel: viewModel)
		}
	}
	
	private func registerCustomMetreScreenInContainter(container: Container) {
		container.register(CustomMetreViewController.self) { (r, currentMetre: Metre?) in
			let metronomeEngine = r.resolve(MetronomeEngine.self)!
			let model = CustomMetreModel(withMetronomeEngine: metronomeEngine)
			let viewModel = CustomMetreViewModel(withModel: model, currentMetre: currentMetre)
			return CustomMetreViewController(withViewModel: viewModel)
		}
	}
	
	private func registerSettingsScreenInContainter(container: Container) {
		container.register(SettingsViewController.self) { resolver in
			let model = SettingsModel()
			let viewModel = SettingsViewModel(withModel: model)
			return SettingsViewController(withViewModel: viewModel)
		}
	}
	
	private func registerSelectSoundScreenInContainer(container: Container) {
		container.register(SelectSoundViewController.self) { r in
			let soundBank = r.resolve(SoundsBank.self)!
			let metronomeEngine = r.resolve(MetronomeEngine.self)!
			let model = SelectSoundModel(withSoundBank: soundBank, andMetronomeEngine: metronomeEngine)
			let viewModel = SelectSoundViewModel(withModel: model)
			return SelectSoundViewController(withViewModel: viewModel)
		}
	}
}