import UIKit
import SnapKit

class MainScreenView: UIView {
	
	let consoleView = ConsoleView()
    let displayView = LCDDisplay()
	let jogView = JogView()
    
	override init(frame: CGRect) {
		super.init(frame: frame)
        backgroundColor = UIColor.metronomeBackgroundColor()
		
        addSubview(consoleView)
        
        addSubview(displayView)
        
        addSubview(jogView)
        
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCustomConstraints() {
        consoleView.snp_makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-50)
        }
        
        displayView.snp_makeConstraints { (make) in
            make.leading.equalTo(self).offset(22)
            make.trailing.equalTo(self).offset(-22)
            make.top.equalTo(self).offset(20)
        }
        
        jogView.snp_makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-60)
            make.width.equalTo(320)
            make.height.equalTo(jogView.snp_width)
        }
	}
    
    
}
