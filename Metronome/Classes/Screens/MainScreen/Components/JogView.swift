import UIKit

enum JogRotationDirection {
	case increase
	case decrease
	case none

	init(delta: Double) {
		if delta > 0 {
			self = .increase
		} else if delta < 0 {
			self = .decrease
		} else {
			self = .none
		}
	}
}

class JogView: UIControl {
	var sensitivity = 0.1 // radians per event

	fileprivate let backgroundImageView = UIImageView(asset: .Jog_bkg)
	fileprivate let knobeImageView = UIImageView(asset: .Jog)
    fileprivate var tampCumulativeAngle = 0.0
    fileprivate weak var tapGestureRecognizer: UIGestureRecognizer?
	fileprivate(set) var rotationDirection: JogRotationDirection?

	var rotGR: SingleFingerRotationGestureRecognizer?

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(backgroundImageView)

		knobeImageView.isUserInteractionEnabled = true
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

	fileprivate func setupCustomConstraints() {
		backgroundImageView.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}

		knobeImageView.snp.makeConstraints { make in
			make.edges.equalTo(backgroundImageView)
		}
	}

	func gestureRecognizerDidDetectRotation(_ senderGestureRecognizer: SingleFingerRotationGestureRecognizer) {
		let rotationAngle = senderGestureRecognizer.rotationAngle

		if senderGestureRecognizer.state == .changed {
            rotateJogByAngle(rotationAngle)
			
			tampCumulativeAngle += rotationAngle
			if abs(tampCumulativeAngle) > sensitivity {
				rotationDirection = JogRotationDirection(delta: tampCumulativeAngle)
				sendActions(for: .valueChanged)
				tampCumulativeAngle = 0.0
			}
		}
	}

	func tapGestureDidDetect(_ sender: UITapGestureRecognizer) {
		sendActions(for: .touchUpInside)
	}

	override func point(inside touchPoint: CGPoint, with event: UIEvent?) -> Bool {
		let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
		let distanceFromCenter = distatanceBetweenPoints(touchPoint, point2: centerPoint)

		let knobeRadius = bounds.size.width / 2.0
		let isInsideKnobe = (distanceFromCenter < knobeRadius)

		return isInsideKnobe
	}

	fileprivate func distatanceBetweenPoints(_ point1: CGPoint, point2: CGPoint) -> CGFloat {
		let dx = point1.x - point2.x
		let dy = point1.y - point2.y

		return sqrt(dx * dx + dy * dy)
	}

	func rotateJogByAngle(_ angle: Double) {
        knobeImageView.transform = knobeImageView.transform.rotated(by: CGFloat(angle))
	}
}

extension JogView: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return otherGestureRecognizer == tapGestureRecognizer
	}
}
