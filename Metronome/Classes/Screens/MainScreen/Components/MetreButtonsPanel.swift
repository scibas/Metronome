import UIKit

class MetreButtonsPanel: UIControl {
	fileprivate let buttonStackView = UIStackView()
	fileprivate(set) var buttons = [MetreButton]()
	fileprivate(set) var selectedButtonIndex: Int?

	init(numberOfButtons: Int) {
		super.init(frame: CGRect.zero)

		buttonStackView.spacing = 5
		buttonStackView.distribution = .fillEqually
		buttonStackView.alignment = .fill
		buttonStackView.axis = .horizontal
		addSubview(buttonStackView)

		for _ in 0 ..< numberOfButtons {
			addButton(MetreButton())
		}

		setupCustomConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setupCustomConstraints() {
		buttonStackView.snp_makeConstraints { (make) in
			make.edges.equalTo(self)
		}
	}

	func addButton(_ button: MetreButton) {
		buttonStackView.addArrangedSubview(button)
		buttons.append(button)
		button.addTarget(self, action: #selector(MetreButtonsPanel.metreButtonDidTap(_:)), for: .touchUpInside)
		button.addTarget(self, action: #selector(MetreButtonsPanel.metreButtonDidLongTap(_:)), for: .LongTouchDown)
	}

	func metreButtonDidTap(_ sender: MetreButton) {
		for button in buttons {
			let isTappedButton = (sender == button)
			button.isSelected = isTappedButton
		}

		selectedButtonIndex = buttons.index(of: sender)
		sendActions(for: .valueChanged)
	}

	func metreButtonDidLongTap(_ sender: MetreButton) {
		selectedButtonIndex = buttons.index(of: sender)
		sendActions(for: .LongTouchDown)
	}
}
