import UIKit
import Swinject

class FlowController: WithResolver {
	
	private let window: UIWindow
	private let dialogPresenter = DialogPresenter()
	
	init(withWindow window: UIWindow) {
		self.window = window
	}
	
	func showMainScren() {
		let mainViewController = resolver().resolve(MainScreenViewController.self)!
		mainViewController.flowDelegate = self
		
		window.rootViewController = mainViewController
		window.makeKeyAndVisible()
	}
}

extension FlowController: MainScreenViewControllerFlowDelegate {
	func showSettingsScreen(senderViewController: MainScreenViewController) {
	}
	
	func showCustomMetreScreenForMetreBank(metreBankIndex: Int, senderViewController: MainScreenViewController) {
		let metre: Metre? = nil
		let customMetreViewController = resolver().resolve(CustomMetreViewController.self, argument: metre)!
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
            print("New metre: \(metre)")
			break
		}
	}
}
