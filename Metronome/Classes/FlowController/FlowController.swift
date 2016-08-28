import UIKit
import Swinject

class FlowController: WithResolver {
	private let window: UIWindow
	private let dialogPresenter = DialogPresenter()
	private var setMetreClosure: SetMetreClosure?
    
	init(withWindow window: UIWindow) {
		self.window = window
	}
	
	func showMainScren() {
		let mainViewController = resolver().resolve(MainScreenViewController.self)!
		mainViewController.flowDelegate = self
		
        self.mainViewController = mainViewController
        
		window.rootViewController = mainViewController
		window.makeKeyAndVisible()
	}
    
    private weak var mainViewController: MainScreenViewController?
    private var bankIndex: Int?
}

extension FlowController: MainScreenViewControllerFlowDelegate {
	func showSettingsScreen(senderViewController: MainScreenViewController) {
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
