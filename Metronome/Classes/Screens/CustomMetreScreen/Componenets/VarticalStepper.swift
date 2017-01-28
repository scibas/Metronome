import UIKit

class VarticalStepper: UIView {
    let increaseButton = UIButton(withTitle: "+")
    let decreaseButton = UIButton(withTitle: "-")
	fileprivate let dividerView = UIView()
	
	init() {
		super.init(frame: .zero)
		
		layer.borderWidth = 1
		layer.cornerRadius = 5
		
		setColorTheme(tintColor)
		
		addSubview(increaseButton)
		addSubview(dividerView)
		addSubview(decreaseButton)
		
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCustomConstraints() {
		
		increaseButton.snp.makeConstraints { (make) in
			make.leading.equalTo(self)
			make.trailing.equalTo(self)
			make.top.equalTo(self)
			make.height.equalTo(self).dividedBy(2)
		}
		
		decreaseButton.snp.makeConstraints { (make) in
			make.leading.equalTo(self)
			make.trailing.equalTo(self)
			make.bottom.equalTo(self)
			make.height.equalTo(self).dividedBy(2)
		}
		
		dividerView.snp.makeConstraints { (make) in
			make.leading.equalTo(self)
			make.trailing.equalTo(self)
			make.height.equalTo(1)
			make.centerY.equalTo(self)
		}
	}
	
	fileprivate func setColorTheme(_ color: UIColor) {
		layer.borderColor = color.cgColor
		dividerView.backgroundColor = color
		increaseButton.tintColor = color
		decreaseButton.tintColor = color
	}
	
	override var intrinsicContentSize : CGSize {
		return CGSize(width: 44.0, height: 88.0)
	}
	
	override func tintColorDidChange() {
		setColorTheme(tintColor)
	}
}

public extension UIButton {
	convenience init(withTitle title: String) {
		self.init(frame: .zero)
		
		setTitle(title, for: .normal)
		titleLabel?.font = UIFont.customMetreIncreaseDecreaseButtonFont()
	}
	
    override open func tintColorDidChange() {
		setTitleColor(self.tintColor, for: .normal)
		setTitleColor(self.tintColor.withAlphaComponent(0.3), for: .disabled)
		setTitleColor(self.tintColor.withAlphaComponent(0.5), for: .highlighted)
	}
}
