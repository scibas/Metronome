import Foundation
import Swinject

class ScreensAssembly: AssemblyType {
	
	func assemble(container: Container) {
		registerMainScreenInContainter(container)
		registerSettingsScreenInContainter(container)
		registerCustomMetreScreenInContainter(container)
	}
	
	private func registerMainScreenInContainter(container: Container) {
		container.register(MainScreenViewController.self) { r in
			
			let metreonomeEngine = r.resolve(MetronomeEngine.self) as! MetronomeEngineProtocol
			let userSettingsStorage = r.resolve(UserSettingsStorageClass.self) as! UserSettingsStorage
			let viewModel = MainScreenViewModel(metronomeEngine: metreonomeEngine, userSettingsStorage: userSettingsStorage)
			return MainScreenViewController(viewModel: viewModel)
		}
	}
	
	private func registerCustomMetreScreenInContainter(container: Container) {
		container.register(CustomMetreViewController.self) { r in
			let metronomeEngine = r.resolve(MetronomeEngine.self)!
			let model = CustomMetreModel(withMetronomeEngine: metronomeEngine)
			let viewModel = CustomMetreViewModel(withModel: model)
			return CustomMetreViewController(withViewModel: viewModel)
		}
	}
	
	private func registerSettingsScreenInContainter(container: Container) {
	}
}