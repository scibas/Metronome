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
        mainView.selectMetre(selectedMetre)
	}
	
    func applyButtonDidTap() {
        delegate?.customMetreViewController(self, didSelectAction: .selectMetre(metre: mainView.selectedMetre))
        delegate?.customMetreViewController(self, didSelectAction: .dismiss)
    }
    
    func cancelButtonDidTap() {
        delegate?.customMetreViewController(self, didSelectAction: .dismiss)
    }
    
    @objc private func noteKindSegmentControlDidChange(_ sender: UISegmentedControl) {
        mainView.pickerView.reloadAllComponents()
    }
}

extension CustomMetreViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let beat = row + 1
        let noteKind = mainView.selectedMetre.noteKind
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
