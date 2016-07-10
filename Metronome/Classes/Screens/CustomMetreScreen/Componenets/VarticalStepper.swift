import UIKit

class VarticalStepper: UIView {
    let increaseButton = UIButton(withTitle: "+")
    let decreaseButton = UIButton(withTitle: "-")
	private let dividerView = UIView()
	
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
		
		increaseButton.snp_makeConstraints { (make) in
			make.leading.equalTo(self)
			make.trailing.equalTo(self)
			make.top.equalTo(self)
			make.height.equalTo(self).dividedBy(2)
		}
		
		decreaseButton.snp_makeConstraints { (make) in
			make.leading.equalTo(self)
			make.trailing.equalTo(self)
			make.bottom.equalTo(self)
			make.height.equalTo(self).dividedBy(2)
		}
		
		dividerView.snp_makeConstraints { (make) in
			make.leading.equalTo(self)
			make.trailing.equalTo(self)
			make.height.equalTo(1)
			make.centerY.equalTo(self)
		}
	}
	
	private func setColorTheme(color: UIColor) {
		layer.borderColor = color.CGColor
		dividerView.backgroundColor = color
		increaseButton.tintColor = color
		decreaseButton.tintColor = color
	}
	
	override func intrinsicContentSize() -> CGSize {
		return CGSize(width: 44.0, height: 88.0)
	}
	
	override func tintColorDidChange() {
		setColorTheme(tintColor)
	}
}

private extension UIButton {
	convenience init(withTitle title: String) {
		self.init(frame: .zero)
		
		setTitle(title, forState: .Normal)
		titleLabel?.font = UIFont.customMetreIncreaseDecreaseButtonFont()
	}
	
    public override func tintColorDidChange() {
		setTitleColor(self.tintColor, forState: .Normal)
		setTitleColor(self.tintColor.colorWithAlphaComponent(0.3), forState: .Disabled)
		setTitleColor(self.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
	}
}
