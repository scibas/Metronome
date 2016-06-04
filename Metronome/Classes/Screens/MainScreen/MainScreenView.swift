import UIKit
import SnapKit

class MainScreenView: UIView {
    let button = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        button.setTitle("Button", forState: .Normal)
        self.addSubview(button)
        
        backgroundColor = UIColor.grayColor()
        
        button.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
