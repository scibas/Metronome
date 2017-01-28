import Foundation

final class SettingsViewModel {
    private let model: SettingsModel
    private let metronomeEngine: MetronomeEngineProtocol
    
    init(withModel model: SettingsModel, metronomeEngine: MetronomeEngineProtocol) {
        self.model = model
        self.metronomeEngine = metronomeEngine
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
    
    func setEmphasisEnabled(emphasisEnabled: Bool) {
        metronomeEngine.emphasisEnabled = emphasisEnabled
    }
    
    func pauseMetronomeOnEnterBackground(pause: Bool) {
        metronomeEngine.pauseOnAppExit = pause
    }
}
