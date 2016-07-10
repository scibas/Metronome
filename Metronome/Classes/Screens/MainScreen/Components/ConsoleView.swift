import UIKit

class ConsoleView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
        shapeLayer.fillColor = UIColor.metronomeConsoleColor().CGColor
        
        shapeLayer.shadowColor = UIColor.blackColor().CGColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 2)
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.masksToBounds = false
        shapeLayer.shadowRadius = 1.0
	}
	
	override class func layerClass() -> AnyClass {
		return CAShapeLayer.self
	}
	
	var shapeLayer: CAShapeLayer { return self.layer as! CAShapeLayer }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
        let uShapePath = beziePathForUShapeInRect(bounds).CGPath
        shapeLayer.path = uShapePath
		shapeLayer.shadowPath = uShapePath
	}
	
	func beziePathForUShapeInRect(rect: CGRect) -> UIBezierPath {
        let arcRadius = rect.width / 2.0
        
		let path = UIBezierPath()
        path.moveToPoint(CGPoint.zero)
        path.addLineToPoint(CGPoint(x: 0, y: rect.height - arcRadius))
        path.addArcWithCenter(CGPoint(x: arcRadius, y: rect.height - arcRadius), radius: arcRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: false)
        path.addLineToPoint(CGPoint(x: rect.width, y: 0))
        path.closePath()
		
		return path
	}
}
