import UIKit

enum JogRotationDirection {
	case Increase
	case Decrease
	case None

	init(delta: Double) {
		if delta > 0 {
			self = .Increase
		} else if delta < 0 {
			self = .Decrease
		} else {
			self = None
		}
	}
}

class JogView: UIControl {
	var sensitivity = 0.1 // radians per event

	private let backgroundImageView = UIImageView(asset: .Jog_bkg)
	private let knobeImageView = UIImageView(asset: .Jog)
    private var tampCumulativeAngle = 0.0
    private weak var tapGestureRecognizer: UIGestureRecognizer?
	private(set) var rotationDirection: JogRotationDirection?

	var rotGR: SingleFingerRotationGestureRecognizer?

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
		self.rotGR = rotationGestureRecognizer

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

	func gestureRecognizerDidDetectRotation(senderGestureRecognizer: SingleFingerRotationGestureRecognizer) {
		let rotationAngle = senderGestureRecognizer.rotationAngle

		if senderGestureRecognizer.state == .Changed {
            rotateJogByAngle(rotationAngle)
			
			tampCumulativeAngle += rotationAngle
			if abs(tampCumulativeAngle) > sensitivity {
				rotationDirection = JogRotationDirection(delta: tampCumulativeAngle)
				sendActionsForControlEvents(.ValueChanged)
				tampCumulativeAngle = 0.0
			}
		}
	}

	func tapGestureDidDetect(sender: UITapGestureRecognizer) {
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

	func rotateJogByAngle(angle: Double) {
        knobeImageView.transform = CGAffineTransformRotate(knobeImageView.transform, CGFloat(angle))
	}
}

extension JogView: UIGestureRecognizerDelegate {
	func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return otherGestureRecognizer == tapGestureRecognizer
	}
}
