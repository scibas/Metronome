import UIKit
import CocoaLumberjack
import StoreKit

class SettingsFlowController: TreeStructureNode, FlowController, WithResolver {
    fileprivate weak var navigationController: UINavigationController?
    
    lazy private(set) var initialViewController: UIViewController = {
        let settingsViewController = self.resolver().resolve(SettingsViewController.self)!
        settingsViewController.flowActionHandler = { [weak self] selectedAction in
            guard let `self` = self else { return }
            self.handle(action: selectedAction, for: settingsViewController)
        }
        
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        self.navigationController = settingsNavigationController
        
        return settingsNavigationController
    }()
    
    private func handle(action: SettingsViewControllerAction, for settingsViewController: SettingsViewController) {
        switch action {
        case .showChangeSound:
            let selectSoundViewController = self.changeSoundViewController
            navigationController?.pushViewController(selectSoundViewController, animated: true)
        case .close:
            settingsViewController.dismiss(animated: true, completion:{ _ in
                self.removeFromParentFlowController()
            })
        }
    }
    
    private lazy var changeSoundViewController: SelectSoundViewController = {
        let selectSoundViewController = self.resolver().resolve(SelectSoundViewController.self)!
        return selectSoundViewController
    }()
}
