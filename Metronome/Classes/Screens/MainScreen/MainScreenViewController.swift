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
        mainView.button.addTarget(self, action: #selector(MainScreenViewController.btnDidTap), forControlEvents: .TouchUpInside)
		self.view = mainView
	}
	
    
    func btnDidTap() {
        try! metronomeEngine.start()
    }
    
	var mainView: MainScreenView { return self.view as! MainScreenView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

