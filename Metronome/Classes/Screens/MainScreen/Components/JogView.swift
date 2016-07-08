import UIKit

class JogView: UIControl {
	
	private let backgroundImageView = UIImageView(asset: .Jog_bkg)
	private let knobeImageView = UIImageView(asset: .Jog)
    private weak var tapGestureRecognizer: UIGestureRecognizer?
    private(set) var initialAngle = 0.0
    private(set) var rotationAngle = 0.0
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(backgroundImageView)
		
		knobeImageView.userInteractionEnabled = true
		addSubview(knobeImageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JogView.tapGestureDidDetect(_:)))
        knobeImageView.addGestureRecognizer(tapGestureRecognizer)
        self.tapGestureRecognizer = tapGestureRecognizer
        
        let rotationGestureRecognizer = SingleFingerRotationGestureRecognizer(target: self, action: #selector(JogView.gestureRecognizerDidDetectRotation(_:)))
        rotationGestureRecognizer.delegate = self
        knobeImageView.addGestureRecognizer(rotationGestureRecognizer)
        
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCustomConstraints() {
		backgroundImageView.snp_makeConstraints { make in
			make.edges.equalTo(self)
		}
		
		knobeImageView.snp_makeConstraints { make in
			make.edges.equalTo(backgroundImageView)
		}
	}
	
	func gestureRecognizerDidDetectRotation(sender: SingleFingerRotationGestureRecognizer) {
		knobeImageView.transform = CGAffineTransformMakeRotation(CGFloat(sender.rotationAngle))
        initialAngle = sender.initialAngle
        rotationAngle = sender.rotationAngle
        sendActionsForControlEvents(.ValueChanged)
	}
    
    func tapGestureDidDetect(sender: UITapGestureRecognizer){
        sendActionsForControlEvents(.TouchUpInside)
    }
    
    override func pointInside(touchPoint: CGPoint, withEvent event: UIEvent?) -> Bool {
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let distanceFromCenter = distatanceBetweenPoints(touchPoint, point2: centerPoint)
        
        let knobeRadius = bounds.size.width / 2.0
        let isInsideKnobe = (distanceFromCenter < knobeRadius)
        
        return isInsideKnobe
    }
    
    private func distatanceBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        
        return sqrt(dx * dx + dy * dy)
    }
}

extension JogView: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer == tapGestureRecognizer
    }
}
