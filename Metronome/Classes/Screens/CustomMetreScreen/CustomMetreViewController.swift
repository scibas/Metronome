import UIKit

enum CustomMetreViewControllerAction {
    case dismiss
    case selectMetre(metre: Metre)
}

protocol CustomMetreViewControllerDelegate: class {
    func customMetreViewController(_ viewController: CustomMetreViewController, didSelectAction action: CustomMetreViewControllerAction)
}

class CustomMetreViewController: UIViewController {
    weak var delegate: CustomMetreViewControllerDelegate?
    private var selectedMetre: Metre
    private let allNotesValues: [NoteKind] = [.halfNote, .quarterNote, .eighthNote, .sixteenthNotes]
    
    struct Constants {
        static let defaultMetre = Metre.fourByFour()
    }
    
    init(with selectedMetre: Metre?) {
        self.selectedMetre = selectedMetre ?? Constants.defaultMetre
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		let mainView = CustomMetreView()
        mainView.segmentedControl.addTarget(self, action: #selector(noteKindSegmentControlDidChange(_:)), for: .valueChanged)
        mainView.applyBarButton.addTapTarget(self, action: #selector(applyButtonDidTap))
        mainView.cancelBarButton.addTapTarget(self, action: #selector(cancelButtonDidTap))
        mainView.pickerView.delegate = self
        mainView.pickerView.dataSource = self
        view = mainView
	}
	
	var mainView: CustomMetreView { return view as! CustomMetreView }
	
	override func viewDidLoad() {
		super.viewDidLoad()
        selectMetre(selectedMetre)
	}
	
    func applyButtonDidTap() {
//        delegate?.customMetreViewController(self, didSelectAction: .selectMetre(metre: viewModel.currentMetre))
        delegate?.customMetreViewController(self, didSelectAction: .dismiss)
    }
    
    func cancelButtonDidTap() {
        delegate?.customMetreViewController(self, didSelectAction: .dismiss)
    }
    
    private func selectMetre(_ metre: Metre) {
        mainView.segmentedControl.selectedSegmentIndex = buttonIndexForNoteKind(metre.noteKind)
        mainView.pickerView.selectRow(metre.beat-1, inComponent: 0, animated: false)
        mainView.pickerView.reloadAllComponents()
    }
    
    @objc private func noteKindSegmentControlDidChange(_ sender: UISegmentedControl) {
        

        mainView.pickerView.reloadAllComponents()
    }
    
    fileprivate func noteKindForButtonIndex(_ butonIndex: Int) -> NoteKind {
        return allNotesValues[butonIndex]
    }
    
    private func buttonIndexForNoteKind(_ noteKind: NoteKind) -> Int {
        return allNotesValues.index(of: noteKind)!
    }
}

extension CustomMetreViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let beat = row + 1
        let noteKind = noteKindForButtonIndex(mainView.segmentedControl.selectedSegmentIndex)
        let metre = Metre(beat: beat, noteKind: noteKind)

        let label: UILabel
        if view == nil {
            label = UILabel()
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica Neue", size: 32)!
            label.textColor = UIColor.metreButtonNormalStateColor()
        } else {
            label = view as! UILabel
        }
        
        label.attributedText = MetreAttributedTextFormater.attributedText(for: metre)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
}
