import UIKit
import SnapKit

class MainScreenView: UIView {
	
	let consoleView = ConsoleView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
        backgroundColor = UIColor.metronomeBackgroundColor()
		
        addSubview(consoleView)
        
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCustomConstraints() {
        consoleView.snp_makeConstraints { (make) in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-100)
        }
	}
    
    
}
