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
    
	override init(frame: CGRect) {
		super.init(frame: frame)
        backgroundColor = UIColor.metronomeBackgroundColor()
		
        addSubview(consoleView)
        
        addSubview(displayView)
        
        metreButtonsPanel.addButton(MetreButton(title: "2/4"))
        metreButtonsPanel.addButton(MetreButton(title: "3/4"))
        metreButtonsPanel.addButton(MetreButton(title: "4/4"))
        metreButtonsPanel.addButton(MetreButton(title: "6/8"))
        metreButtonsPanel.addButton(MetreButton(title: "CUSTOM"))
        addSubview(metreButtonsPanel)
        
        addSubview(settingsButton)
        
        addSubview(autoBpmButton)
        
        addSubview(jogView)
        
        addSubview(decreaseTempoButton)
        
        addSubview(increaseTempoButton)
        
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCustomConstraints() {
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
            make.height.equalTo(150)
        }
        
        metreButtonsPanel.snp_makeConstraints { (make) in
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.top.equalTo(displayView.snp_bottom).offset(30)
            make.height.equalTo(54)
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
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-60)
            make.width.equalTo(320)
            make.height.equalTo(jogView.snp_width)
        }
        
        decreaseTempoButton.snp_makeConstraints { (make) in
            make.leading.equalTo(consoleView)
            make.trailing.equalTo(self.snp_centerX).offset(-5)
            make.top.equalTo(jogView.snp_bottom)
        }
        
        increaseTempoButton.snp_makeConstraints { (make) in
            make.leading.equalTo(self.snp_centerX).offset(5)
            make.trailing.equalTo(consoleView)
            make.top.equalTo(jogView.snp_bottom)
        }
	}
}
