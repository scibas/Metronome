import UIKit
import SnapKit

class MainScreenView: UIView {
	
	let consoleView = ConsoleView()
    let displayView = LCDDisplay()
    let metreButtonsPanel = MetreButtonsPanel()
    let settingsButton = UIButton(backgroundImageAsset: .Settings_btn)
    let autoBpmButton = UIButton(backgroundImageAsset: .Autobpm_btn_off)
    let increaseTempoButton = UIButton(backgroundImageAsset: .Tempo_plus_btn)
    let decreaseTempoButton = UIButton(backgroundImageAsset: .Tempo_minus_btn)
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
        
        metreButtonsPanel.addButton(MetreButton(title: "2/4"))
        metreButtonsPanel.addButton(MetreButton(title: "3/4"))
        metreButtonsPanel.addButton(MetreButton(title: "4/4"))
        metreButtonsPanel.addButton(MetreButton(title: "6/8"))
        metreButtonsPanel.addButton(MetreButton(title: "NOT\nSET"))
        
        addSubview(consoleView)
        addSubview(displayView)
        addSubview(metreButtonsPanel)
        addSubview(settingsButton)
        addSubview(autoBpmButton)
        addSubview(jogView)
        addSubview(decreaseTempoButton)
        addSubview(increaseTempoButton)
        
        displayView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Vertical)
        displayView.setContentHuggingPriority(UILayoutPriorityFittingSizeLevel, forAxis: .Vertical)
        
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCustomConstraints() {
        consoleView.snp_makeConstraints { make in
            make.leading.equalTo(jogView).offset(-Constants.consoleMargin)
            make.trailing.equalTo(jogView).offset(Constants.consoleMargin)
            make.top.equalTo(self)
            make.bottom.equalTo(jogView).offset(Constants.consoleMargin)
        }
        
        displayView.snp_makeConstraints { (make) in
            make.leading.equalTo(consoleView)
            make.trailing.equalTo(consoleView)
            make.top.equalTo(self).offset(Constants.statusBarHeight)
        }
        
        metreButtonsPanel.snp_makeConstraints { (make) in
            make.leading.equalTo(self).offset(Constants.defaultSideMargin)
            make.trailing.equalTo(self).offset(-Constants.defaultSideMargin)
            make.top.equalTo(displayView.snp_bottom).offset(Constants.defaultVerticalMargin).priorityMedium()
            make.top.greaterThanOrEqualTo(displayView.snp_bottom).offset(Constants.minimumVerticalMargin)
        }
        
        settingsButton.snp_makeConstraints { (make) in
            make.top.equalTo(jogView)
            make.leading.equalTo(jogView)
        }
        
        autoBpmButton.snp_makeConstraints { (make) in
            make.top.equalTo(jogView)
            make.trailing.equalTo(jogView)
        }
        
        jogView.snp_makeConstraints { make in
            make.top.equalTo(metreButtonsPanel.snp_bottom).offset(Constants.defaultVerticalMargin).priorityMedium()
            make.top.greaterThanOrEqualTo(metreButtonsPanel.snp_bottom).offset(Constants.minimumVerticalMargin)
            make.leading.equalTo(self).offset(Constants.defaultSideMargin)
            make.trailing.equalTo(self).offset(-Constants.defaultSideMargin)
            make.height.equalTo(jogView.snp_width)
        }
        
        decreaseTempoButton.snp_makeConstraints { (make) in
            make.leading.equalTo(consoleView)
            make.trailing.equalTo(self.snp_centerX)
            make.top.equalTo(increaseTempoButton)
            make.bottom.equalTo(increaseTempoButton)
        }
        
        increaseTempoButton.snp_makeConstraints { (make) in
            make.leading.equalTo(self.snp_centerX)
            make.trailing.equalTo(consoleView)
            make.top.equalTo(jogView.snp_bottom)
            make.bottom.equalTo(self).offset(-Constants.defaultSideMargin).priorityMedium()
            make.bottom.lessThanOrEqualTo(self).offset(-Constants.minimumVerticalMargin)
        }
	}
}
