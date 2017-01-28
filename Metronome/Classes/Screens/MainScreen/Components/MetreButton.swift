import UIKit

class MetreButton: UIButton {
	init() {
		super.init(frame: CGRect.zero)
		
		titleLabel?.font = UIFont.metreButtonsFont()
		titleLabel?.numberOfLines = 2
		
        setTitleFromMetre(nil)
		setTitleColor(UIColor.metreButtonNormalStateColor(), for: .normal)
		setTitleColor(UIColor.metreButtonSelectedStateColor(), for: .selected)
		setBackgroundImage(UIImage(asset: .Metre_btn), for: .normal)
		
		let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MetreButton.didLongPress(_:)))
		longPressGestureRecognizer.allowableMovement = 0
		addGestureRecognizer(longPressGestureRecognizer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func didLongPress(_ sender: UILongPressGestureRecognizer) {
		if (sender.state == .began) {
			sendActions(for: .LongTouchDown)
		}
	}
    
    func setTitleFromMetre(_ metre: Metre?) {
        if let metre = metre {
            let title = "\(metre.beat)/\(metre.noteKind.rawValue)"
            setTitle(title, for: .normal)
        } else {
            setTitle("Empty", for: .normal)
        }
    }
}

extension UIControlEvents {
	public static var LongTouchDown = UIControlEvents(rawValue: 1 << 24)
}
