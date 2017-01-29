import UIKit

enum SettingsViewControllerAction {
	case showChangeSound
	case showRateApp
	case showReportBug
}

protocol SettingsViewControllerFlowDelegate: class {
	func settingsViewController(_ settingsViewController: SettingsViewController, didSelectAction action: SettingsViewControllerAction)
}

class SettingsViewController: UITableViewController {
	weak var flowDelegate: SettingsViewControllerFlowDelegate?
	fileprivate let viewModel: SettingsViewModel
	
	struct Constants {
		static let settingsCellReuseIdentifier = "SettingsCellReuseIdentifier"
	}
	
	init(withViewModel viewModel: SettingsViewModel) {
		self.viewModel = viewModel
		super.init(style: .grouped)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(SettingCell.self, forCellReuseIdentifier: Constants.settingsCellReuseIdentifier)
		
		title = "Settings"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.numberOfSections()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfItemsInSection(section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let settingsItem = viewModel.settingItemForIndexPath(indexPath)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.settingsCellReuseIdentifier, for: indexPath) as! SettingCell
        cell.titleLabel.text = settingsItem.title
        cell.settingItemKind = settingsItem.itemKind

        cell.configureCellForSettingItem(settingsItem)
        cell.delegate = self
		return cell
	}
}

extension SettingsViewController: SettingCellActionDelegate {
    func settingCell(cell: SettingCell, didPerform action: SettingsCellAction) {
        let settingItemKind = cell.settingItemKind!
        
        switch (settingItemKind, action) {
        case (.changeSound, .didTap):
            flowDelegate?.settingsViewController(self, didSelectAction: .showChangeSound)
        case (.rateApp, .didTap):
            flowDelegate?.settingsViewController(self, didSelectAction: .showRateApp)
        case (.reportBug, .didTap):
            flowDelegate?.settingsViewController(self, didSelectAction: .showReportBug)
        case (.enableEmphasis, .switchStateDidChange(let switchValue)):
            viewModel.setEmphasisEnabled(switchValue)
        case (.playInBackground, .switchStateDidChange(let switchValue)):
            viewModel.pauseMetronomeOnEnterBackground(!switchValue)
        default:
            print("Action \(action) not handled for item kind \(settingItemKind)")
        }
    }
}


extension SettingCell {
	func configureCellForSettingItem(_ settingItem: SettingItem) {
		switch settingItem.type {
		case .simple:
			accessoryType = .none
			selectionStyle = .gray
			showSwitchButton = false
		case .simpleWithSubitems:
			accessoryType = .disclosureIndicator
			selectionStyle = .gray
			showSwitchButton = false
		case .trueFalse:
			accessoryType = .none
			selectionStyle = .none
			showSwitchButton = true
		}
	}
}
