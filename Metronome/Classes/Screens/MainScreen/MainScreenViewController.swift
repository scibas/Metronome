import UIKit

typealias SetMetreClosure = (_ newMetre: Metre) -> ()

protocol MainScreenViewControllerFlowDelegate: class {
	func showSettingsScreen(_ senderViewController: MainScreenViewController)
	func showCustomMetreScreenForMetre(_ currentMetre: Metre?, senderViewController: MainScreenViewController, setMetreClosure: @escaping SetMetreClosure)
}

class MainScreenViewController: UIViewController {
	weak var flowDelegate: MainScreenViewControllerFlowDelegate?
	
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
		let buttonIndex = sender.selectedButtonIndex!
		viewModel.setMetreFromBankIndex(buttonIndex)
	}
	
	func metreButtonDidLongTap(_ sender: MetreButtonsPanel) {
		let bankIndex = sender.selectedButtonIndex!
		let currentBankMetre = viewModel.metreBank.metreForIndex(bankIndex)
		flowDelegate?.showCustomMetreScreenForMetre(currentBankMetre, senderViewController: self) { [unowned self] newMetre in
			self.viewModel.storeMetre(newMetre, forBankIndex: bankIndex)
		}
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
        flowDelegate?.showSettingsScreen(self)
    }
	
	func updateViewState() {
		for (metreBankButtonIndex, button) in mainView.metreButtonsPanel.buttons.enumerated() {
			let metre = viewModel.metreBank.metreForIndex(metreBankButtonIndex)
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
