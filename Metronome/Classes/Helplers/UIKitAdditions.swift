import UIKit

extension UIImageView {
    convenience init(asset: Asset) {
        let image = UIImage(asset: asset)
        self.init(image: image)
    }
}

extension UIButton {
    convenience init(backgroundImageAsset: Asset) {
        self.init(frame: .zero)
        
        let image = UIImage(asset: backgroundImageAsset)
        setBackgroundImage(image, forState: .Normal)
    }
}
