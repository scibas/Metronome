import UIKit
import Swinject
import CocoaLumberjack

class MainFlowController: TreeStructureNode, FlowController, WithResolver {
	fileprivate let dialogPresenter = DialogPresenter()
	
    lazy var initialViewController: UIViewController = {
		let mainViewController = self.resolver().resolve(MainScreenViewController.self)!
        mainViewController.flowActionHandler = { [weak self] selectedAction in
            guard let `self` = self else { return }
            self.handle(selectedAction, for: mainViewController)
        }
		
		return mainViewController
    }()
    
    private func handle(_ action: MainScreenViewControllerAction, for mainScreenViewController: MainScreenViewController) {
        switch action {
        case .showSettingsScreen:
            let settingsFlowController = resolver().resolve(SettingsFlowController.self)!
    
            addChildFlowController(settingsFlowController)
    
            let settingsViewController = settingsFlowController.initialViewController
            mainScreenViewController.present(settingsViewController, animated: true)
            
        case .showCustomMetreDialog(let selectedBankIndex):
            let currentMetre: Metre? = Metre.fourByFour()
            let customMetreViewController = resolver().resolve(CustomMetreViewController.self, argument: selectedBankIndex)!
            customMetreViewController.delegate = self
            dialogPresenter.presentDialogViewController(customMetreViewController, formViewController: mainScreenViewController, animated: true, completion: nil)
        }
    }
}

extension MainFlowController: CustomMetreViewControllerDelegate {
	func customMetreViewController(_ viewController: CustomMetreViewController, didSelectAction action: CustomMetreViewControllerAction) {
		switch action {
		case .dismiss:
			dialogPresenter.dismissDialogViewControllerFromPresentationViewController(viewController.presentingViewController!, animated: true, completion: nil)
		case .selectMetre(let metre):
//			setMetreClosure?(metre)
			break
		}
	}
}
