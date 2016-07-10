import UIKit

class CustomMetreViewController: UIViewController, CustomMetreViewModelDelegateProtocol {
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
        updateNoteKindOfStepperButtonState()
	}
	
	func customMetreViewModel(viewModel: CustomMetreViewModel, didChangeMetre newMetre: Metre) {
		displayMetre(newMetre)
	}
	
	func displayMetre(metre: Metre) {
		mainView.metreLabel.text = "\(metre.beat)"
		mainView.noteKindOfLabel.text = "\(metre.noteKindOf.rawValue)"
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
        updateNoteKindOfStepperButtonState()
	}
	
	func decreaseNoteKindButtonDidTap() {
		viewModel.decreaseNoteKind()
        updateNoteKindOfStepperButtonState()
	}
	
	func updateMetreStepperButtonState() {
		mainView.metreStepperButton.increaseButton.enabled = viewModel.canIncreaseMetre()
        mainView.metreStepperButton.decreaseButton.enabled = viewModel.canDecreaseMetre()
	}
	
	func updateNoteKindOfStepperButtonState() {
        mainView.noteKingOfStepperButton.increaseButton.enabled = viewModel.canIncreaseNoteKing()
        mainView.noteKingOfStepperButton.decreaseButton.enabled = viewModel.canDecreaseNoteKing()
	}
    
    func applyButtonDidTap() {
        viewModel.applyNewMetrum()
    }
    
    func cancelButtonDidTap() {
        
    }
}