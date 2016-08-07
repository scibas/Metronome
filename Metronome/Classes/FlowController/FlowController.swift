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
		let customMetreViewController = resolver().resolve(CustomMetreViewController.self)!
		dialogPresenter.presentDialogViewController(customMetreViewController, formViewController: senderViewController, animated: true, completion: nil)
	}
}
