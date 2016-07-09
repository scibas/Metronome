import UIKit.UIGestureRecognizerSubclass

class SingleFingerRotationGestureRecognizer: UIGestureRecognizer {
	private(set) var rotationAngle = 0.0
	override init(target: AnyObject?, action: Selector) {
		super.init(target: target, action: action)
	}
	
	override func reset() {
		super.reset()
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
		super.touchesBegan(touches, withEvent: event)
		
		guard touches.count <= 1 else {
			state = .Failed
			return
		}
		
		guard isPointInsideKnobArea(touches.first!.locationInView(view)) else {
			state = .Failed
			return
		}
        
        state = .Began
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
		super.touchesMoved(touches, withEvent: event)
		
		let oldPoint = touches.first?.previousLocationInView(view)
		let newPoint = touches.first?.locationInView(view)
		
		if let oldPoint = oldPoint, newPoint = newPoint, middlePoint = viewMiddlePoint() {
			let angle = angleBetweenPoints(oldPoint, point2: newPoint, regardToPoint: middlePoint)
			
			rotationAngle += angle
			
			state = .Changed
		}
	}
}

private extension SingleFingerRotationGestureRecognizer {
	private func distatanceBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
		let dx = point1.x - point2.x
		let dy = point1.y - point2.y
		
		return sqrt(dx * dx + dy * dy)
	}
	
	private func angleBetweenPoints(point1: CGPoint, point2: CGPoint, regardToPoint middlePoint: CGPoint) -> Double {
		let a = point1.x - middlePoint.x
		let b = point1.y - middlePoint.y
		let c = point2.x - middlePoint.x
		let d = point2.y - middlePoint.y
		
		return Double(atan2(a, b) - atan2(c, d))
	}
	
	private func isPointInsideKnobArea(point: CGPoint) -> Bool {
		if let middlePoint = viewMiddlePoint() {
			return distatanceBetweenPoints(point, point2: middlePoint) <= view!.bounds.width / 2.0
		}
		
		return false
	}
	
	private func viewMiddlePoint() -> CGPoint? {
		guard (view != nil) else {
			return nil
		}
		
		return CGPoint(x: view!.bounds.midX, y: view!.bounds.midY)
	}
}
