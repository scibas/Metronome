import UIKit

extension UIBarButtonItem {
    func addTapTarget(_ target: AnyObject?, action: Selector) {
        self.target = target
        self.action = action
    }
    
    static func flexibleSpace() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}
