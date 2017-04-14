import UIKit

protocol FlowController {
    var initialViewController: UIViewController { get }
    
    func addChildFlowController(_ child: TreeStructureNode)
    func removeFromParentFlowController()
}

extension FlowController where Self : TreeStructureNode {
    func addChildFlowController(_ child: TreeStructureNode) {
        self.addChild(child)
    }
    
    func removeFromParentFlowController() {
        parent!.removeChild(self)
    }
}
