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
        let items = ["half", "quater", "eighth", "sixteenth"]
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
        let defaultMargin = 10.0
        
        toolbar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(toolbar.snp.bottom)
            make.leading.equalToSuperview().offset(defaultMargin)
            make.trailing.equalToSuperview().offset(-defaultMargin)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom)
            make.leading.equalToSuperview().offset(defaultMargin)
            make.trailing.equalToSuperview().offset(-defaultMargin)
            make.bottom.equalToSuperview().offset(-defaultMargin)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 300.0)
    }
}
