import UIKit

class MainScreenViewController: UIViewController {
	let viewModel: MainScreenViewModel

	init(viewModel: MainScreenViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)

		viewModel.delegate = self
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		let mainView = MainScreenView()

		self.view = mainView
	}

	var mainView: MainScreenView { return self.view as! MainScreenView }

	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidTap(_:)), forControlEvents: .ValueChanged)
		mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidLongTap(_:)), forControlEvents: .LongTouchDown)
		mainView.jogView.addTarget(self, action: #selector(MainScreenViewController.jogViewDidTap(_:)), forControlEvents: .TouchUpInside)
		mainView.jogView.addTarget(self, action: #selector(MainScreenViewController.jogViewDidChangeRotateAngle(_:)), forControlEvents: .ValueChanged)
		mainView.increaseTempoButton.addTarget(self, action: #selector(MainScreenViewController.increaseTempoButtonDidTap(_:)), forControlEvents: .TouchUpInside)
		mainView.decreaseTempoButton.addTarget(self, action: #selector(MainScreenViewController.decreaseTempoButtonDidTap(_:)), forControlEvents: .TouchUpInside)

		updateViewState()
	}

	func jogViewDidTap(sender: UIView) {
		do {
			try viewModel.toggleStartStop()
		} catch {
			print("Start metronome error: \(error)") // FixMe: handle error
		}
	}

	func jogViewDidChangeRotateAngle(jogView: JogView) {
		switch jogView.rotationDirection! {
		case .Increase:
			viewModel.tempo += 1
		case .Decrease:
			viewModel.tempo -= 1
		default:
			break
		}
	}

	func metreButtonDidTap(sender: MetreButtonsPanel) {
		let buttonIndex = sender.selectedButtonIndex!
		viewModel.setMetreFromBankIndex(buttonIndex)
	}

	func metreButtonDidLongTap(sender: MetreButtonsPanel) {
		let bankIndex = sender.selectedButtonIndex!

		let beat = Int(arc4random_uniform(12))
		let exp = pow(2.0, Double(arc4random_uniform(4)))
		let noteKindOf = NoteKindOf(rawValue: Int(exp))!
		let metre = Metre(beat: beat, noteKindOf: noteKindOf)

		viewModel.storeMetre(metre, forBankIndex: bankIndex)
	}

	func increaseTempoButtonDidTap(sender: UIButton) {
        viewModel.tempo += 1
        let r = mainView.jogView.sensitivity
        mainView.jogView.rotateJogByAngle(r)
	}

	func decreaseTempoButtonDidTap(sender: UIButton) {
        viewModel.tempo -= 1
        let r = mainView.jogView.sensitivity
        mainView.jogView.rotateJogByAngle(-r)
	}

	func updateViewState() {
		for (metreBankButtonIndex, button) in mainView.metreButtonsPanel.buttons.enumerate() {
			let metre = viewModel.metreBank.metreForIndex(metreBankButtonIndex)
			button.setTitleFromMetre(metre)
		}
	}

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
}

extension MainScreenViewController: MainScreenViewModelDelegate {
	func viewModel(viewModel: MainScreenViewModel, didChangeTemp newTempo: BPM) {
		mainView.displayView.bpmValueLabel.text = NSString(format: "%.0f", newTempo) as String
	}

	func viewModel(viewModel: MainScreenViewModel, didChangeMetre metre: Metre, forBank bankIndex: Int) {
		let metreButton = mainView.metreButtonsPanel.buttons[bankIndex]
		metreButton.setTitleFromMetre(metre)
	}

	func viewModel(viewModel: MainScreenViewModel, didChangeSelectedBank bankIndex: Int) {
		let metreButton = mainView.metreButtonsPanel.buttons[bankIndex]
		metreButton.selected = true
	}
}
