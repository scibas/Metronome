import UIKit

enum BadgeColor {
	case Green
	case Yellow
	case Red
	
	var color: UIColor {
		switch self {
		case .Green: return UIColor.displayBadgeGreenColor()
		case .Yellow: return UIColor.displayBadgeYellowColor()
		case .Red: return UIColor.displayBadgeRedColor()
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
		textAlignment = .Center
		
		layer.borderColor = badgeColor.color.CGColor
		layer.borderWidth = 1.0
		layer.cornerRadius = 2.0
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
	override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
		let originalRext = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
		
		return CGRectInset(originalRext, Constants.verticalInset, Constants.horizontalInset)
	}
}
