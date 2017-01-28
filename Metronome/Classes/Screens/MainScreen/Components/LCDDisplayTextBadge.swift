import UIKit

enum BadgeColor {
	case green
	case yellow
	case red
	
	var color: UIColor {
		switch self {
		case .green: return UIColor.displayBadgeGreenColor()
		case .yellow: return UIColor.displayBadgeYellowColor()
		case .red: return UIColor.displayBadgeRedColor()
		}
	}
}

class DisplayTextBadge: UILabel {
	
    struct Constants {
        static let verticalInset: CGFloat = -6.0
        static let horizontalInset: CGFloat = -2.0
    }
    
	init(badgeColor: BadgeColor) {
		super.init(frame: CGRect.zero)
		
		font = UIFont.displayBadgesFont()
		textColor = badgeColor.color
		textAlignment = .center
		
		layer.borderColor = badgeColor.color.cgColor
		layer.borderWidth = 1.0
		layer.cornerRadius = 2.0
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
	override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
		let originalRext = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
		
		return originalRext.insetBy(dx: Constants.verticalInset, dy: Constants.horizontalInset)
	}
}
