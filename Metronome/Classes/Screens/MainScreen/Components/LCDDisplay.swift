import UIKit

class LCDDisplay: UIView {
	fileprivate let backgroundImageView = UIImageView(asset: .displayBkg)
    let bpmValueLabel = UILabel()
	fileprivate let metreBadge = DisplayTextBadge(badgeColor: .yellow)
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(backgroundImageView)
		
		bpmValueLabel.text = "120"
		bpmValueLabel.textColor = UIColor.displayTextColor()
		bpmValueLabel.font = UIFont.displayBpmFont()
		addSubview(bpmValueLabel)
        
        metreBadge.text = "4/4"
        addSubview(metreBadge)
		
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupCustomConstraints() {
		backgroundImageView.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
		
        metreBadge.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
        }
        
		bpmValueLabel.snp.makeConstraints { make in
			make.center.equalTo(self)
            make.top.greaterThanOrEqualTo(self).offset(5)
            make.bottom.lessThanOrEqualTo(self).offset(-5)
		}
	}
	
	override var intrinsicContentSize : CGSize {
		return CGSize(width: UIViewNoIntrinsicMetric, height: 90.0)
	}
}
