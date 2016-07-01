import UIKit

class JogView: UIView {
    
    private let knobView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5)

        let rotationGestureRecognizer = SingleFingerRotationGestureRecognizer(target: self, action: #selector(JogView.gestureRecognizerDidDetectRotation(_:)))
        knobView.addGestureRecognizer(rotationGestureRecognizer)
        
        knobView.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
        addSubview(knobView)
        
        setupCustomConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = min(bounds.width, bounds.height) / 2.0
        knobView.layer.cornerRadius = radius
    }
    
    func setupCustomConstraints() {
        knobView.snp_makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func gestureRecognizerDidDetectRotation(sender: SingleFingerRotationGestureRecognizer) {
            print("Did detect rotation: \(sender.rotationAngle)")
    }
}
