import UIKit

extension UIColor {
    static func metronomeBackgroundColor() -> UIColor {
        return UIColor(hex: 0x131313)
    }
    
    static func metronomeConsoleColor() -> UIColor {
        return UIColor(hex: 0x272727)
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
