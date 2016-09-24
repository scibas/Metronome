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
		static let cellReuseIdentifier = "CellReuseIdentifier"
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
		tableView.registerClass(MetronomeSettingCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
		
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
		
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellReuseIdentifier, forIndexPath: indexPath) as! MetronomeSettingCell
		cell.bindWithSettingItem(settingsItem)
		return cell
	}
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
        let action = viewModel.settingItemForIndexPath(indexPath).action
        handleAction(action)
    }
    
    private func handleAction(action: SettingItemAction) {
        switch action {
        case .ChangeSound:
            flowDelegate?.settingsViewController(self, didSelectAction: .ShowChangeSound)
        case .EnableEmphasis: break
        case .PlayInBackground: break
        case .RateApp:
            flowDelegate?.settingsViewController(self, didSelectAction: .ShowRateApp)
        case .ReportBug:
            flowDelegate?.settingsViewController(self, didSelectAction: .ShowReportBug)
        }
    }
}

extension MetronomeSettingCell {
	func bindWithSettingItem(settingItem: SettingItem) {
		textLabel?.text = settingItem.title
		
		let showAccesor = (settingItem.type == .Subitems)
		accessoryType = showAccesor ? .DisclosureIndicator : .None
		
		let canSelect = (settingItem.type != .Boolean)
		selectionStyle = canSelect ? .Gray : .None
	}
}
