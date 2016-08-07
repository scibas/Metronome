import UIKit

extension UIFont {
    class func displayBpmFont() -> UIFont {
        return UIFont(name: "New", size: 64)!
    }
    
    class func displayBadgesFont() -> UIFont {
        return UIFont(name: "New", size: 12)!
    }
    
    class func metreButtonsFont() -> UIFont {
        return UIFont(name: "Bebas", size: 15)!
    }
    
    class func customMetreFont() -> UIFont {
        return UIFont.systemFontOfSize(50, weight: UIFontWeightLight)
    }
    
    class func customMetreIncreaseDecreaseButtonFont() -> UIFont {
        return UIFont.systemFontOfSize(30, weight: UIFontWeightThin)
    }
}
