import UIKit

class MetreButton: UIButton {
	init() {
		super.init(frame: CGRect.zero)
		
		titleLabel?.font = UIFont.metreButtonsFont()
		
		setTitleColor(UIColor.metreButtonNormalStateColor(), for: .normal)
		setTitleColor(UIColor.metreButtonSelectedStateColor(), for: .selected)
        setTitleFromMetre(nil)
        
		setBackgroundImage(UIImage(asset: .metreBtn), for: .normal)
		
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
            let normalStateAttributedString = MetreAttributedTextFormater.attributedText(for: metre, with: titleLabel?.font, and: titleColor(for: .normal))
            let selectedStateAttributedString = MetreAttributedTextFormater.attributedText(for: metre, with: titleLabel?.font, and: titleColor(for: .selected))
            setAttributedTitle(normalStateAttributedString, for: .normal)
            setAttributedTitle(selectedStateAttributedString, for: .selected)
        } else {
            setTitle("Empty", for: .normal)
        }
    }
}

extension UIControlEvents {
	public static var LongTouchDown = UIControlEvents(rawValue: 1 << 24)
}
