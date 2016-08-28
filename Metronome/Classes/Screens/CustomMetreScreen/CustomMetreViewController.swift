import UIKit

enum CustomMetreViewControllerAction {
    case Dismiss
    case SelectMetre(metre: Metre)
}

protocol CustomMetreViewControllerDelegate: class {
    func customMetreViewController(viewController: CustomMetreViewController, didSelectAction action: CustomMetreViewControllerAction)
}

class CustomMetreViewController: UIViewController, CustomMetreViewModelDelegateProtocol {
    weak var delegate: CustomMetreViewControllerDelegate?
    
	private let viewModel: CustomMetreViewModel
	
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
		mainView.metreStepperButton.increaseButton.addTarget(self, action: #selector(CustomMetreViewController.increaseMetreButtonDidTap), forControlEvents: .TouchUpInside)
		mainView.metreStepperButton.decreaseButton.addTarget(self, action: #selector(CustomMetreViewController.decreaseMetreButtonDidTap), forControlEvents: .TouchUpInside)
		mainView.noteKingOfStepperButton.increaseButton.addTarget(self, action: #selector(CustomMetreViewController.increaseNoteKindButtonDidTap), forControlEvents: .TouchUpInside)
		mainView.noteKingOfStepperButton.decreaseButton.addTarget(self, action: #selector(CustomMetreViewController.decreaseNoteKindButtonDidTap), forControlEvents: .TouchUpInside)
        mainView.applyButton.addTarget(self, action: #selector(CustomMetreViewController.applyButtonDidTap), forControlEvents: .TouchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(CustomMetreViewController.cancelButtonDidTap), forControlEvents: .TouchUpInside)
		
		view = mainView
	}
	
	var mainView: CustomMetreView { return view as! CustomMetreView }
	
	override func viewDidLoad() {
		displayMetre(viewModel.currentMetre)
        
        updateMetreStepperButtonState()
        updateNoteKindStepperButtonState()
	}
	
	func customMetreViewModel(viewModel: CustomMetreViewModel, didChangeMetre newMetre: Metre) {
		displayMetre(newMetre)
	}
	
	func displayMetre(metre: Metre) {
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
	
	private func updateMetreStepperButtonState() {
		mainView.metreStepperButton.increaseButton.enabled = viewModel.canIncreaseMetre()
        mainView.metreStepperButton.decreaseButton.enabled = viewModel.canDecreaseMetre()
	}
	
	private func updateNoteKindStepperButtonState() {
        mainView.noteKingOfStepperButton.increaseButton.enabled = viewModel.canIncreaseNoteKind()
        mainView.noteKingOfStepperButton.decreaseButton.enabled = viewModel.canDecreaseNoteKind()
	}
    
    func applyButtonDidTap() {
        viewModel.applyNewMetrum()
        delegate?.customMetreViewController(self, didSelectAction: .SelectMetre(metre: viewModel.currentMetre))
        delegate?.customMetreViewController(self, didSelectAction: .Dismiss)
    }
    
    func cancelButtonDidTap() {
        delegate?.customMetreViewController(self, didSelectAction: .Dismiss)
    }
}