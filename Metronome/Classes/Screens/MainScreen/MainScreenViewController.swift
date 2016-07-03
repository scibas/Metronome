import UIKit

class MainScreenViewController: UIViewController {
    let metronomeEngine: MetronomeEngineProtocol
    let audioEngine: AudioEngine
    
    init(metronomeEngine: MetronomeEngineProtocol, ae: AudioEngine) {
        audioEngine = ae
        self.metronomeEngine = metronomeEngine
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func loadView() {
		let mainView = MainScreenView()
        
		self.view = mainView
	}
    
    var mainView: MainScreenView { return self.view as! MainScreenView }
    
    func btnDidTap() {
        try! metronomeEngine.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidTap(_:)), forControlEvents: .ValueChanged)
        mainView.metreButtonsPanel.addTarget(self, action: #selector(MainScreenViewController.metreButtonDidLongTap(_:)), forControlEvents: .LongTouchDown)
    }
    
    func metreButtonDidTap(sender: MetreButtonsPanel) {
        print("Metre button did tap")
    }
    
    func metreButtonDidLongTap(sender: MetreButtonsPanel) {
        print("Metre button did LONG tap")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

