import UIKit

enum SettingsViewControllerAction {
	case ShowChangeSound
	case ShowRateApp
	case ShowReportBug
}

protocol SettingsViewControllerFlowDelegate: class {
	func settingsViewController(settingsViewController: SettingsViewController, didSelectAction action: SettingsViewControllerAction)
}

class SettingsViewController: UITableViewController {
	weak var flowDelegate: SettingsViewControllerFlowDelegate?
	private let viewModel: SettingsViewModel
	
	struct Constants {
		static let settingsCellReuseIdentifier = "SettingsCellReuseIdentifier"
	}
	
	init(withViewModel viewModel: SettingsViewModel) {
		self.viewModel = viewModel
		super.init(style: .Grouped)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.registerClass(SettingCell.self, forCellReuseIdentifier: Constants.settingsCellReuseIdentifier)
		
		title = "Settings"
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return viewModel.numberOfSections()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfItemsInSection(section)
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let settingsItem = viewModel.settingItemForIndexPath(indexPath)
		
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.settingsCellReuseIdentifier, forIndexPath: indexPath) as! SettingCell
		cell.bindWithSettingItem(settingsItem)
		cell.configureCellForSettingItem(settingsItem)
		cell.switchButtonActionClosure = handleCellSwitchActionClosure
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		let action = viewModel.settingItemForIndexPath(indexPath).action
		handleCellAction(action, value: nil)
	}
	
    private func handleCellAction(action: SettingItemAction?, value: Bool?) {
        guard let action = action else { return }
        
		switch action {
		case .ChangeSound:
			flowDelegate?.settingsViewController(self, didSelectAction: .ShowChangeSound)
		case .RateApp:
			flowDelegate?.settingsViewController(self, didSelectAction: .ShowRateApp)
		case .ReportBug:
			flowDelegate?.settingsViewController(self, didSelectAction: .ShowReportBug)
		case .EnableEmphasis:
            viewModel.setEmphasisEnabled(value!)
		case .PlayInBackground:
            viewModel.pauseMetronomeOnEnterBackground(value!)
		}
	}
	
	private lazy var handleCellSwitchActionClosure: SwitchActionClosure = {
		return { [weak self] newValue, senderCell in
			let indexPath = self?.tableView.indexPathForCell(senderCell)
			
			if let indexPath = indexPath {
				let action = self?.viewModel.settingItemForIndexPath(indexPath).action
                self?.handleCellAction(action, value: newValue)
			}
		}
	}()
}

extension SettingCell {
	func bindWithSettingItem(settingItem: SettingItem) {
		titleLabel.text = settingItem.title
	}
	
	func configureCellForSettingItem(settingItem: SettingItem) {
		switch settingItem.type {
		case .Simple:
			accessoryType = .None
			selectionStyle = .Gray
			showSwitchButton = false
		case .SimpleWithSubitems:
			accessoryType = .DisclosureIndicator
			selectionStyle = .Gray
			showSwitchButton = false
		case .TrueFalse:
			accessoryType = .None
			selectionStyle = .None
			showSwitchButton = true
		}
	}
}
