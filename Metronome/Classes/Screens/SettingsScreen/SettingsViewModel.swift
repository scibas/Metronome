import Foundation

class SettingsViewModel {
    private let model: SettingsModel
    
    init(withModel model: SettingsModel) {
        self.model = model
    }
    
    func numberOfSections() -> Int {
        return model.settings.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return model.settings[section].items.count
    }
    
    func settingItemForIndexPath(indexPath: NSIndexPath) -> SettingItem {
        let section = model.settings[indexPath.section]
        return section.items[indexPath.item]
    }
}
