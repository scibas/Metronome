import UIKit

enum CustomMetreViewControllerAction {
    case dismiss
    case selectMetre(metre: Metre)
}

protocol CustomMetreViewControllerDelegate: class {
    func customMetreViewController(_ viewController: CustomMetreViewController, didSelectAction action: CustomMetreViewControllerAction)
}

class CustomMetreViewController: UIViewController, CustomMetreViewModelDelegateProtocol {
    weak var delegate: CustomMetreViewControllerDelegate?
    
	fileprivate let viewModel: CustomMetreViewModel
	
	init(withViewModel viewModel: CustomMetreViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		self.viewModel.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		let mainView = CustomMetreView()
		mainView.metreStepperButton.increaseButton.addTarget(self, action: #selector(CustomMetreViewController.increaseMetreButtonDidTap), for: .touchUpInside)
		mainView.metreStepperButton.decreaseButton.addTarget(self, action: #selector(CustomMetreViewController.decreaseMetreButtonDidTap), for: .touchUpInside)
		mainView.noteKingOfStepperButton.increaseButton.addTarget(self, action: #selector(CustomMetreViewController.increaseNoteKindButtonDidTap), for: .touchUpInside)
		mainView.noteKingOfStepperButton.decreaseButton.addTarget(self, action: #selector(CustomMetreViewController.decreaseNoteKindButtonDidTap), for: .touchUpInside)
        mainView.applyButton.addTarget(self, action: #selector(CustomMetreViewController.applyButtonDidTap), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(CustomMetreViewController.cancelButtonDidTap), for: .touchUpInside)
		
		view = mainView
	}
	
	var mainView: CustomMetreView { return view as! CustomMetreView }
	
	override func viewDidLoad() {
		displayMetre(viewModel.currentMetre)
        
        updateMetreStepperButtonState()
        updateNoteKindStepperButtonState()
	}
	
	func customMetreViewModel(_ viewModel: CustomMetreViewModel, didChangeMetre newMetre: Metre) {
		displayMetre(newMetre)
	}
	
	func displayMetre(_ metre: Metre) {
		mainView.metreLabel.text = "\(metre.beat)"
		mainView.noteKindLabel.text = "\(metre.noteKind.rawValue)"
	}
	
	func increaseMetreButtonDidTap() {
		viewModel.increaseMetre()
        updateMetreStepperButtonState()
	}
	
	func decreaseMetreButtonDidTap() {
		viewModel.decreaseMetre()
        updateMetreStepperButtonState()
	}
	
	func increaseNoteKindButtonDidTap() {
		viewModel.increaseNoteKind()
        updateNoteKindStepperButtonState()
	}
	
	func decreaseNoteKindButtonDidTap() {
		viewModel.decreaseNoteKind()
        updateNoteKindStepperButtonState()
	}
	
	fileprivate func updateMetreStepperButtonState() {
		mainView.metreStepperButton.increaseButton.isEnabled = viewModel.canIncreaseMetre()
        mainView.metreStepperButton.decreaseButton.isEnabled = viewModel.canDecreaseMetre()
	}
	
	fileprivate func updateNoteKindStepperButtonState() {
        mainView.noteKingOfStepperButton.increaseButton.isEnabled = viewModel.canIncreaseNoteKind()
        mainView.noteKingOfStepperButton.decreaseButton.isEnabled = viewModel.canDecreaseNoteKind()
	}
    
    func applyButtonDidTap() {
        viewModel.applyNewMetrum()
        delegate?.customMetreViewController(self, didSelectAction: .selectMetre(metre: viewModel.currentMetre))
        delegate?.customMetreViewController(self, didSelectAction: .dismiss)
    }
    
    func cancelButtonDidTap() {
        delegate?.customMetreViewController(self, didSelectAction: .dismiss)
    }
}
