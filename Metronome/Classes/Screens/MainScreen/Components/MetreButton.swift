import UIKit

class MetreButton: UIButton {
	init(title: String) {
		super.init(frame: CGRect.zero)
		
		titleLabel?.font = UIFont.metreButtonsFont()
		titleLabel?.numberOfLines = 2
		
		setTitle(title, forState: .Normal)
		setTitleColor(UIColor.metreButtonNormalStateColor(), forState: .Normal)
		setTitleColor(UIColor.metreButtonSelectedStateColor(), forState: .Selected)
		setBackgroundImage(UIImage(asset: .Metre_btn), forState: .Normal)
		
		let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MetreButton.didLongPress(_:)))
		longPressGestureRecognizer.allowableMovement = 0
		addGestureRecognizer(longPressGestureRecognizer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func didLongPress(sender: UILongPressGestureRecognizer) {
		if (sender.state == .Began) {
			sendActionsForControlEvents(.LongTouchDown)
		}
	}
}

extension UIControlEvents {
	public static var LongTouchDown = UIControlEvents(rawValue: 1 << 24)
}