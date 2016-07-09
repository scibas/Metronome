import UIKit

class MetreButton: UIButton {
	init() {
		super.init(frame: CGRect.zero)
		
		titleLabel?.font = UIFont.metreButtonsFont()
		titleLabel?.numberOfLines = 2
		
        setTitleFromMetre(nil)
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
    
    func setTitleFromMetre(metre: Metre?) {
        if let metre = metre {
            let title = "\(metre.beat)/\(metre.noteKindOf.rawValue)"
            setTitle(title, forState: .Normal)
        } else {
            setTitle("Empty", forState: .Normal)
        }
    }
}

extension UIControlEvents {
	public static var LongTouchDown = UIControlEvents(rawValue: 1 << 24)
}