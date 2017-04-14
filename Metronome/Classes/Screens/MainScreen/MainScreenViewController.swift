import UIKit

enum MainScreenViewControllerAction {
    case showSettingsScreen
    case showCustomMetreDialog(bankIndex: Int)
}

class MainScreenViewController: UIViewController {
    var flowActionHandler: ((MainScreenViewControllerAction) -> Void)?
	
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
		mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidTap(_:)), for: .valueChanged)
		mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidLongTap(_:)), for: .LongTouchDown)
		mainView.jogView.addTarget(self, action: #selector(MainScreenViewController.jogViewDidTap(_:)), for: .touchUpInside)
		mainView.jogView.addTarget(self, action: #selector(MainScreenViewController.jogViewDidChangeRotateAngle(_:)), for: .valueChanged)
		mainView.increaseTempoButton.addTarget(self, action: #selector(MainScreenViewController.increaseTempoButtonDidTap(_:)), for: .touchUpInside)
		mainView.decreaseTempoButton.addTarget(self, action: #selector(MainScreenViewController.decreaseTempoButtonDidTap(_:)), for: .touchUpInside)
        mainView.settingsButton.addTarget(self, action: #selector(MainScreenViewController.settingsButtonDidTap), for: .touchUpInside)
        
        title = "Metronome"
        
		updateViewState()
	}
    	
	func jogViewDidTap(_ sender: UIView) {
		do {
			try viewModel.toggleStartStop()
		} catch {
			print("Start metronome error: \(error)") // FixMe: handle error
		}
	}
	
	func jogViewDidChangeRotateAngle(_ jogView: JogView) {
		switch jogView.rotationDirection! {
		case .increase:
			viewModel.tempo += 1
		case .decrease:
			viewModel.tempo -= 1
		default:
			break
		}
	}
	
	func metreButtonDidTap(_ sender: MetreButtonsPanel) {
        let bankIndex = sender.selectedButtonIndex!
        
        if viewModel.metreBank.isEmpty(at: bankIndex) {
            flowActionHandler?(.showCustomMetreDialog(bankIndex: bankIndex))
            return
        }
        
        if let selectedMetre = viewModel.metreBank.metre(for: bankIndex) {
            viewModel.metronomeEngine.metre = selectedMetre
        }
	}
	
	func metreButtonDidLongTap(_ sender: MetreButtonsPanel) {
		let bankIndex = sender.selectedButtonIndex!
		flowActionHandler?(.showCustomMetreDialog(bankIndex: bankIndex))
	}
	
	func setMetre(_ metre: Metre, forBankIndex bankIndex: Int) {
		viewModel.storeMetre(metre, forBankIndex: bankIndex)
	}
	
	func increaseTempoButtonDidTap(_ sender: UIButton) {
		viewModel.tempo += 1
		let r = mainView.jogView.sensitivity
		mainView.jogView.rotateJogByAngle(r)
	}
	
	func decreaseTempoButtonDidTap(_ sender: UIButton) {
		viewModel.tempo -= 1
		let r = mainView.jogView.sensitivity
		mainView.jogView.rotateJogByAngle(-r)
	}
    
    func settingsButtonDidTap() {
        flowActionHandler?(.showSettingsScreen)
    }
	
	func updateViewState() {
		for (metreBankButtonIndex, button) in mainView.metreButtonsPanel.buttons.enumerated() {
            let metre = viewModel.metreBank.metre(for: metreBankButtonIndex)
			button.setTitleFromMetre(metre)
		}
	}
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
}

extension MainScreenViewController: MainScreenViewModelDelegate {
	func viewModel(_ viewModel: MainScreenViewModel, didChangeTemp newTempo: BPM) {
		mainView.displayView.bpmValueLabel.text = NSString(format: "%.0f", newTempo) as String
	}
	
	func viewModel(_ viewModel: MainScreenViewModel, didChangeMetre metre: Metre, forBank bankIndex: Int) {
		let metreButton = mainView.metreButtonsPanel.buttons[bankIndex]
		metreButton.setTitleFromMetre(metre)
	}
	
	func viewModel(_ viewModel: MainScreenViewModel, didChangeSelectedBank bankIndex: Int) {
		let metreButton = mainView.metreButtonsPanel.buttons[bankIndex]
		metreButton.isSelected = true
	}
}
