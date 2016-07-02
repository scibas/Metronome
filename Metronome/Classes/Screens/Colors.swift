import UIKit

extension UIColor {
    class func metronomeBackgroundColor() -> UIColor {
        return UIColor(hex: 0x131313)
    }
    
    class func metronomeConsoleColor() -> UIColor {
        return UIColor(hex: 0x272727)
    }
    
    class func displayTextColor() -> UIColor {
        return UIColor(hex:0xc7c8c1)
    }
    
    class func displayBadgeGreenColor() -> UIColor {
        return UIColor(hex:0x008000)
    }
    
    class func displayBadgeRedColor() -> UIColor {
        return UIColor(hex:0xB75152)
    }
    
    class func displayBadgeYellowColor() -> UIColor {
        return UIColor(hex:0xC28F3B)
    }
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        let redComponent = CGFloat((hex >> 16) & 0xFF)
        let greenComponent = CGFloat((hex >> 8) & 0xFF)
        let blueComponent = CGFloat(hex & 0xFF)
        
        self.init(red: redComponent / 255.0, green: greenComponent / 255.0, blue: blueComponent / 255.0, alpha: alpha)
    }
}
