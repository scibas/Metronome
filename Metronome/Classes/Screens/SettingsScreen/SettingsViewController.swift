import UIKit

enum SettingsViewControllerAction {
	case showChangeSound
    case close
}

class SettingsViewController: UITableViewController {
	fileprivate let viewModel: SettingsViewModel

    var flowActionHandler: ((SettingsViewControllerAction) -> Void)?
    
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
		
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonDidTap))
        navigationItem.leftBarButtonItem = closeButton
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: Constants.settingsCellReuseIdentifier)
		
		title = "Settings"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
    
    @objc private func closeButtonDidTap() {
        flowActionHandler?(.close)
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
            flowActionHandler?(.showChangeSound)
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
