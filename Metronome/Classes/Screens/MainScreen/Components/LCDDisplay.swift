import UIKit

class LCDDisplay: UIView {
	private let backgroundImageView = UIImageView(asset: .Display_bkg)
	private let bpmValueLabel = UILabel()
	private let metreBadge = DisplayTextBadge(badgeColor: .Yellow)
    
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(backgroundImageView)
		
		layer.shadowOffset = CGSize(width: 1, height: 1)
		layer.shadowOpacity = 1
		layer.shadowColor = UIColor.blackColor().CGColor
		
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
	
	private func setupCustomConstraints() {
		backgroundImageView.snp_makeConstraints { make in
			make.edges.equalTo(self)
		}
		
        metreBadge.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
        }
        
		bpmValueLabel.snp_makeConstraints { make in
			make.center.equalTo(self)
            make.top.greaterThanOrEqualTo(self).offset(5)
            make.bottom.lessThanOrEqualTo(self).offset(-5)
		}
	}
	
	override func intrinsicContentSize() -> CGSize {
		return CGSize(width: UIViewNoIntrinsicMetric, height: 90.0)
	}
}
