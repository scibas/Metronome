import UIKit
import SnapKit

class MainScreenView: UIView {
	
	let consoleView = ConsoleView()
    let displayView = LCDDisplay()
    let metreButtonsPanel = MetreButtonsPanel(numberOfButtons: 5)
    let settingsButton = UIButton(backgroundImageAsset: .settingsBtn)
    let autoBpmButton = UIButton(backgroundImageAsset: .autobpmBtnOff)
    let increaseTempoButton = UIButton(backgroundImageAsset: .tempoPlusBtn)
    let decreaseTempoButton = UIButton(backgroundImageAsset: .tempoMinusBtn)
	let jogView = JogView()
    
    struct Constants {
        static let minimumVerticalMargin = 10.0
        static let defaultVerticalMargin = 20.0
        static let defaultSideMargin = 30.0
        static let consoleMargin = 10.0
        static let statusBarHeight = 20.0
    }
    
	override init(frame: CGRect) {
		super.init(frame: frame)
        backgroundColor = UIColor.metronomeBackgroundColor()
        
        addSubview(consoleView)
        addSubview(displayView)
        addSubview(metreButtonsPanel)
        addSubview(settingsButton)
        addSubview(autoBpmButton)
        addSubview(jogView)
        addSubview(decreaseTempoButton)
        addSubview(increaseTempoButton)
        
        displayView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .vertical)
        displayView.setContentHuggingPriority(UILayoutPriorityFittingSizeLevel, for: .vertical)
        
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupCustomConstraints() {
        consoleView.snp.makeConstraints { make in
            make.leading.equalTo(jogView).offset(-Constants.consoleMargin)
            make.trailing.equalTo(jogView).offset(Constants.consoleMargin)
            make.top.equalTo(self).offset(Constants.statusBarHeight)
            make.bottom.equalTo(jogView).offset(Constants.consoleMargin)
        }
        
        displayView.snp.makeConstraints { (make) in
            make.leading.equalTo(consoleView)
            make.trailing.equalTo(consoleView)
            make.top.equalTo(self).offset(Constants.statusBarHeight + 2)
        }
        
        metreButtonsPanel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(Constants.defaultSideMargin)
            make.trailing.equalTo(self).offset(-Constants.defaultSideMargin)
            make.top.equalTo(displayView.snp.bottom).offset(Constants.defaultVerticalMargin).priority(UILayoutPriorityDefaultLow)
            make.top.greaterThanOrEqualTo(displayView.snp.bottom).offset(Constants.minimumVerticalMargin)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.top.equalTo(jogView)
            make.leading.equalTo(jogView)
        }
        
        autoBpmButton.snp.makeConstraints { (make) in
            make.top.equalTo(jogView)
            make.trailing.equalTo(jogView)
        }
        
        jogView.snp.makeConstraints { make in
            make.top.equalTo(metreButtonsPanel.snp.bottom).offset(Constants.defaultVerticalMargin).priority(UILayoutPriorityDefaultLow)
            make.top.greaterThanOrEqualTo(metreButtonsPanel.snp.bottom).offset(Constants.minimumVerticalMargin)
            make.leading.equalTo(self).offset(Constants.defaultSideMargin)
            make.trailing.equalTo(self).offset(-Constants.defaultSideMargin)
            make.height.equalTo(jogView.snp.width)
        }
        
        decreaseTempoButton.snp.makeConstraints { (make) in
            make.leading.equalTo(consoleView)
            make.trailing.equalTo(self.snp.centerX)
            make.top.equalTo(increaseTempoButton)
            make.bottom.equalTo(increaseTempoButton)
        }
        
        increaseTempoButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.centerX)
            make.trailing.equalTo(consoleView)
            make.top.equalTo(jogView.snp.bottom)
            make.bottom.equalTo(self).offset(-Constants.defaultSideMargin).priority(UILayoutPriorityDefaultLow)
            make.bottom.lessThanOrEqualTo(self).offset(-Constants.minimumVerticalMargin)
        }
	}
}
