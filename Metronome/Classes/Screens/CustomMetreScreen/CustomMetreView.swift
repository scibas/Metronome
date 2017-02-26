import UIKit

class CustomMetreView: UIView {
    private let allNotesValues: [NoteKind] = [.halfNote, .quarterNote, .eighthNote, .sixteenthNotes]
    
    lazy var applyBarButton = UIBarButtonItem(title: "Apply", style: .plain, target: nil, action: nil)
    lazy var cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    
    lazy var toolbar: UIToolbar = {
        var barButtonsItems = [self.cancelBarButton, UIBarButtonItem.flexibleSpace(), self.applyBarButton]
        let toolbar = UIToolbar()
        toolbar.setItems(barButtonsItems, animated: false)
        toolbar.barStyle = .blackOpaque
        return toolbar
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = [
            UIImage(asset: Asset.halfNote),
            UIImage(asset: Asset.quaterNote),
            UIImage(asset: Asset.eightNote),
            UIImage(asset: Asset.sixteenthNote)
        ]
        let segmentedControl = UISegmentedControl(items: items)
        return segmentedControl
    }()
    
    lazy var pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.metronomeBackgroundColor()
        
        addSubview(toolbar)
        addSubview(segmentedControl)
        addSubview(pickerView)
        
        setupCustomConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCustomConstraints() {
        let defaultSideMargin = 10.0
        
        toolbar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.leading.equalToSuperview().offset(defaultSideMargin)
            make.trailing.equalToSuperview().offset(-defaultSideMargin)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-defaultSideMargin)
            make.height.equalTo(40)
        }
    }
    
    func selectMetre(_ metre: Metre) {
        segmentedControl.selectedSegmentIndex = buttonIndexForNoteKind(metre.noteKind)
        pickerView.selectRow(metre.beat-1, inComponent: 0, animated: false)
        pickerView.reloadAllComponents()
    }
    
    var selectedMetre: Metre {
        let selectedBeat = pickerView.selectedRow(inComponent: 0) + 1
        let selectedNoteKind = noteKindForButtonIndex(segmentedControl.selectedSegmentIndex)
        
        return Metre(beat: selectedBeat, noteKind: selectedNoteKind)
    }
    
    fileprivate func noteKindForButtonIndex(_ butonIndex: Int) -> NoteKind {
        return allNotesValues[butonIndex]
    }
    
    private func buttonIndexForNoteKind(_ noteKind: NoteKind) -> Int {
        return allNotesValues.index(of: noteKind)!
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 300.0)
    }
}
