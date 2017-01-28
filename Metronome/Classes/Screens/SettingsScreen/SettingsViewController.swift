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
		cell.bindWithSettingItem(settingsItem)
		cell.configureCellForSettingItem(settingsItem)
		cell.switchButtonActionClosure = handleCellSwitchActionClosure
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let action = viewModel.settingItemForIndexPath(indexPath).action
		handleCellAction(action, value: nil)
	}
	
    fileprivate func handleCellAction(_ action: SettingItemAction?, value: Bool?) {
        guard let action = action else { return }
        
		switch action {
		case .changeSound:
			flowDelegate?.settingsViewController(self, didSelectAction: .showChangeSound)
		case .rateApp:
			flowDelegate?.settingsViewController(self, didSelectAction: .showRateApp)
		case .reportBug:
			flowDelegate?.settingsViewController(self, didSelectAction: .showReportBug)
		case .enableEmphasis:
            viewModel.setEmphasisEnabled(value!)
		case .playInBackground:
            viewModel.pauseMetronomeOnEnterBackground(!value!)
		}
	}
	
	fileprivate lazy var handleCellSwitchActionClosure: SwitchActionClosure = {
		return { [weak self] newValue, senderCell in
			let indexPath = self?.tableView.indexPath(for: senderCell)
			
			if let indexPath = indexPath {
				let action = self?.viewModel.settingItemForIndexPath(indexPath).action
                self?.handleCellAction(action, value: newValue)
			}
		}
	}()
}

extension SettingCell {
	func bindWithSettingItem(_ settingItem: SettingItem) {
		titleLabel.text = settingItem.title
	}
	
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
