import UIKit

class CustomMetreView: UIView {
    let metreLabel = UILabel()
    let noteKindLabel = UILabel()
    let byLabel = UILabel()
    
    let metreStepperButton = VarticalStepper()
    let noteKingOfStepperButton = VarticalStepper()
    
    let cancelButton = UIButton()
    let applyButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.metronomeBackgroundColor()
        
        byLabel.text = "/"
        byLabel.textColor = UIColor.metreButtonSelectedStateColor()
        byLabel.font = UIFont.customMetreFont()
        
        metreLabel.textColor = UIColor.metreButtonSelectedStateColor()
        metreLabel.font = UIFont.customMetreFont()
        
        noteKindLabel.textColor = UIColor.metreButtonSelectedStateColor()
        noteKindLabel.font = UIFont.customMetreFont()
        
        applyButton.setTitle("APPLY", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        
        addSubview(metreLabel)
        addSubview(noteKindLabel)
        addSubview(byLabel)
        addSubview(applyButton)
        addSubview(cancelButton)
        
        metreStepperButton.tintColor = UIColor.metreButtonSelectedStateColor()
        noteKingOfStepperButton.tintColor = UIColor.metreButtonSelectedStateColor()
        
        addSubview(noteKingOfStepperButton)
        addSubview(metreStepperButton)
        
        setupCustomConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCustomConstraints() {
        byLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self).offset(-80)
        }
        
        metreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(byLabel)
            make.trailing.equalTo(byLabel.snp.leading)
        }
        
        noteKindLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(byLabel)
            make.leading.equalTo(self.byLabel.snp.trailing)
        }
        
        metreStepperButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(metreLabel)
            make.leading.equalTo(self).offset(15)
        }
        
        noteKingOfStepperButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(noteKindLabel)
            make.trailing.equalTo(self).offset(-15)
        }

        cancelButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(44)
            make.bottom.equalTo(self).offset(-10)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(44)
            make.bottom.equalTo(cancelButton.snp.top)

        }
        
    }
}
