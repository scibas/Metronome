import UIKit
import Swinject

class FlowController: WithResolver {
	private let window: UIWindow
	private let dialogPresenter = DialogPresenter()
	private var setMetreClosure: SetMetreClosure?
	
	private weak var navigationController: MetronomeNavigationController?
	
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
	func showSettingsScreen(senderViewController: MainScreenViewController) {
		let settingsViewController = resolver().resolve(SettingsViewController.self)!
		settingsViewController.flowDelegate = self
		navigationController!.pushViewController(settingsViewController, animated: true)
	}
	
	func showCustomMetreScreenForMetre(currentMetre: Metre?, senderViewController: MainScreenViewController, setMetreClosure: SetMetreClosure) {
		self.setMetreClosure = setMetreClosure
		
		let customMetreViewController = resolver().resolve(CustomMetreViewController.self, argument: currentMetre)!
		customMetreViewController.delegate = self
		dialogPresenter.presentDialogViewController(customMetreViewController, formViewController: senderViewController, animated: true, completion: nil)
	}
}

extension FlowController: CustomMetreViewControllerDelegate {
	func customMetreViewController(viewController: CustomMetreViewController, didSelectAction action: CustomMetreViewControllerAction) {
		switch action {
		case .Dismiss:
			dialogPresenter.dismissDialogViewControllerFromPresentationViewController(viewController.presentingViewController!, animated: false, completion: nil)
		case .SelectMetre(let metre):
			setMetreClosure?(newMetre: metre)
			break
		}
	}
}

extension FlowController: SettingsViewControllerFlowDelegate {
	func settingsViewControllerDidSelectChangeSoundAction(settingsViewController: SettingsViewController) {
		let selectSoundViewController = resolver().resolve(SelectSoundViewController.self)!
		navigationController!.pushViewController(selectSoundViewController, animated: true)
	}
}
