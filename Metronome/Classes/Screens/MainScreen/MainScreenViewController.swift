import UIKit

typealias SetMetreClosure = (newMetre: Metre) -> ()

protocol MainScreenViewControllerFlowDelegate: class {
	func showSettingsScreen(senderViewController: MainScreenViewController)
	func showCustomMetreScreenForMetre(currentMetre: Metre?, senderViewController: MainScreenViewController, setMetreClosure: SetMetreClosure)
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
		mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidTap(_:)), forControlEvents: .ValueChanged)
		mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidLongTap(_:)), forControlEvents: .LongTouchDown)
		mainView.jogView.addTarget(self, action: #selector(MainScreenViewController.jogViewDidTap(_:)), forControlEvents: .TouchUpInside)
		mainView.jogView.addTarget(self, action: #selector(MainScreenViewController.jogViewDidChangeRotateAngle(_:)), forControlEvents: .ValueChanged)
		mainView.increaseTempoButton.addTarget(self, action: #selector(MainScreenViewController.increaseTempoButtonDidTap(_:)), forControlEvents: .TouchUpInside)
		mainView.decreaseTempoButton.addTarget(self, action: #selector(MainScreenViewController.decreaseTempoButtonDidTap(_:)), forControlEvents: .TouchUpInside)
        mainView.settingsButton.addTarget(self, action: #selector(MainScreenViewController.settingsButtonDidTap), forControlEvents: .TouchUpInside)
        
        title = "Metronome"
        
		updateViewState()
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
		let currentBankMetre = viewModel.metreBank.metreForIndex(bankIndex)
		flowDelegate?.showCustomMetreScreenForMetre(currentBankMetre, senderViewController: self) { [unowned self] newMetre in
			self.viewModel.storeMetre(newMetre, forBankIndex: bankIndex)
		}
	}
	
	func setMetre(metre: Metre, forBankIndex bankIndex: Int) {
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
    
    func settingsButtonDidTap() {
        flowDelegate?.showSettingsScreen(self)
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
