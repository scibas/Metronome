import Foundation
import Swinject

class FlowControllersAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(MainFlowController.self) {_ in
            return MainFlowController()
        }
        
        container.register(SettingsFlowController.self) { _ in
            return SettingsFlowController()
            
        }
    }
}

