import UIKit.UIGestureRecognizerSubclass

class SingleFingerRotationGestureRecognizer: UIGestureRecognizer {
	fileprivate(set) var rotationAngle = 0.0
	override init(target: Any?, action: Selector?) {
		super.init(target: target, action: action)
	}
	
	override func reset() {
		super.reset()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesBegan(touches, with: event)
		
		guard touches.count <= 1 else {
			state = .failed
			return
		}
		
		guard isPointInsideKnobArea(touches.first!.location(in: view)) else {
			state = .failed
			return
		}
        
        state = .began
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesMoved(touches, with: event)
		
		let oldPoint = touches.first?.previousLocation(in: view)
		let newPoint = touches.first?.location(in: view)
		
		if let oldPoint = oldPoint, let newPoint = newPoint, let middlePoint = viewMiddlePoint() {
			rotationAngle = angleBetweenPoints(oldPoint, point2: newPoint, regardToPoint: middlePoint)
			state = .changed
		}
	}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }
}

private extension SingleFingerRotationGestureRecognizer {
	func distatanceBetweenPoints(_ point1: CGPoint, point2: CGPoint) -> CGFloat {
		let dx = point1.x - point2.x
		let dy = point1.y - point2.y
		
		return sqrt(dx * dx + dy * dy)
	}
	
	func angleBetweenPoints(_ point1: CGPoint, point2: CGPoint, regardToPoint middlePoint: CGPoint) -> Double {
		let a = point1.x - middlePoint.x
		let b = point1.y - middlePoint.y
		let c = point2.x - middlePoint.x
		let d = point2.y - middlePoint.y
		
		return Double(atan2(a, b) - atan2(c, d))
	}
	
	func isPointInsideKnobArea(_ point: CGPoint) -> Bool {
		if let middlePoint = viewMiddlePoint() {
			return distatanceBetweenPoints(point, point2: middlePoint) <= view!.bounds.width / 2.0
		}
		
		return false
	}
	
	func viewMiddlePoint() -> CGPoint? {
		guard (view != nil) else {
			return nil
		}
		
		return CGPoint(x: view!.bounds.midX, y: view!.bounds.midY)
	}
}
