import UIKit

class JogView: UIControl {
	
	private let backgroundImageView = UIImageView(asset: .Jog_bkg)
	private let knobeImageView = UIImageView(asset: .Jog)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(backgroundImageView)
		
		let rotationGestureRecognizer = SingleFingerRotationGestureRecognizer(target: self, action: #selector(JogView.gestureRecognizerDidDetectRotation(_:)))
		knobeImageView.addGestureRecognizer(rotationGestureRecognizer)
		
		knobeImageView.userInteractionEnabled = true
		addSubview(knobeImageView)
		
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCustomConstraints() {
		backgroundImageView.snp_makeConstraints { make in
			make.edges.equalTo(self)
		}
		
		knobeImageView.snp_makeConstraints { make in
			make.edges.equalTo(self)
		}
	}
	
	func gestureRecognizerDidDetectRotation(sender: SingleFingerRotationGestureRecognizer) {
		knobeImageView.transform = CGAffineTransformMakeRotation(CGFloat(sender.rotationAngle))

        sendActionsForControlEvents(.ValueChanged)
	}
}
