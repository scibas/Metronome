import UIKit
import Swinject
import CocoaLumberjack

class FlowController: WithResolver {
	fileprivate let window: UIWindow
	fileprivate let dialogPresenter = DialogPresenter()
	fileprivate var setMetreClosure: SetMetreClosure?
	
	fileprivate weak var navigationController: MetronomeNavigationController?
	
	init(withWindow window: UIWindow) {
		self.window = window
	}
	
	func showMainScren() {
		let mainViewController = resolver().resolve(MainScreenViewController.self)!
		mainViewController.flowDelegate = self
		
		let navigationController = MetronomeNavigationController(rootViewController: mainViewController)
		self.navigationController = navigationController
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}

extension FlowController: MainScreenViewControllerFlowDelegate {
    func showSettingsScreen(_ senderViewController: MainScreenViewController) {
		let settingsViewController = resolver().resolve(SettingsViewController.self)!
		settingsViewController.flowDelegate = self
		navigationController!.pushViewController(settingsViewController, animated: true)
	}
	
    func showCustomMetreScreenForMetre(_ currentMetre: Metre?, senderViewController: MainScreenViewController, setMetreClosure: @escaping (Metre) -> ()) {
		self.setMetreClosure = setMetreClosure
		
		let customMetreViewController = resolver().resolve(CustomMetreViewController.self, argument: currentMetre)!
		customMetreViewController.delegate = self
		dialogPresenter.presentDialogViewController(customMetreViewController, formViewController: senderViewController, animated: true, completion: nil)
	}
}

extension FlowController: CustomMetreViewControllerDelegate {
	func customMetreViewController(_ viewController: CustomMetreViewController, didSelectAction action: CustomMetreViewControllerAction) {
		switch action {
		case .dismiss:
			dialogPresenter.dismissDialogViewControllerFromPresentationViewController(viewController.presentingViewController!, animated: false, completion: nil)
		case .selectMetre(let metre):
			setMetreClosure?(metre)
			break
		}
	}
}

extension FlowController: SettingsViewControllerFlowDelegate {
	func settingsViewController(_ settingsViewController: SettingsViewController, didSelectAction action: SettingsViewControllerAction) {
		switch action {
		case .showChangeSound:
			let selectSoundViewController = resolver().resolve(SelectSoundViewController.self)!
			navigationController!.pushViewController(selectSoundViewController, animated: true)
		case .showRateApp:
			DDLogError("Action not supported yet")
		case .showReportBug:
			DDLogError("Action not supported yet")
		}
	}
}
