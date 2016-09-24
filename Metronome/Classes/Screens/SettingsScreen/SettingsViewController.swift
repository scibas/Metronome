import UIKit

protocol SettingsViewControllerFlowDelegate: class {
    func settingsViewControllerDidSelectChangeSoundAction(settingsViewController: SettingsViewController)
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
        
        if(indexPath.section == 0 && indexPath.row == 0) {  //FixMe: Temporary code, remove
            flowDelegate?.settingsViewControllerDidSelectChangeSoundAction(self)
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
