import UIKit

extension UIImageView {
    convenience init(asset: Asset) {
        let image = UIImage(asset: asset)
        self.init(image: image)
    }
    
    
}
