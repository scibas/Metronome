import Foundation

class TreeStructureNode: NSObject {
    private(set) var children = Set<TreeStructureNode>()
    weak private(set) var parent: TreeStructureNode?
    
    func addChild(_ child: TreeStructureNode) {
        child.parent = self
        children.insert(child)
    }
    
    func removeChild(_ child: TreeStructureNode) {
        child.parent = nil
        children.remove(child)
    }
}
