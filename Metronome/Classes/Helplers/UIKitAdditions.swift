import UIKit

extension UIImageView {
    convenience init(withImageNamed imageName: String) {
        let image = UIImage(named: imageName)
        self.init(image: image)
    }
}
