import UIKit

class MetreButtonsPanel: UIControl {
	private let buttonStackView = UIStackView()
	private(set) var buttons = [UIButton]()
    private(set) var selectedButtonIndex: Int?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		buttonStackView.spacing = 5
		buttonStackView.distribution = .FillEqually
		buttonStackView.alignment = .Fill
		buttonStackView.axis = .Horizontal
		addSubview(buttonStackView)
		
		setupCustomConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCustomConstraints() {
		buttonStackView.snp_makeConstraints { (make) in
			make.edges.equalTo(self)
		}
	}
	
	func addButton(button: UIButton) {
		buttonStackView.addArrangedSubview(button)
		buttons.append(button)
		button.addTarget(self, action: #selector(MetreButtonsPanel.metreButtonDidTap(_:)), forControlEvents: .TouchUpInside)
        button.addTarget(self, action: #selector(MetreButtonsPanel.metreButtonDidLongTap(_:)), forControlEvents: .LongTouchDown)
	}
	
	func metreButtonDidTap(sender: UIButton) {
        for button in buttons {
            let isTappedButton = (sender == button)
            button.selected = isTappedButton
        }
        
        selectedButtonIndex = buttons.indexOf(sender)
        sendActionsForControlEvents(.ValueChanged)
	}
    
    func metreButtonDidLongTap(sender: UIButton) {
        selectedButtonIndex = buttons.indexOf(sender)
        sendActionsForControlEvents(.LongTouchDown)
    }
}
