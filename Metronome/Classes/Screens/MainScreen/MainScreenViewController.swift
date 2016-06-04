import UIKit

class MainScreenViewController: UIViewController {
	
	override func loadView() {
		let mainView = MainScreenView()
		self.view = mainView
	}
	
	var mainView: MainScreenView { return self.view as! MainScreenView }
}

