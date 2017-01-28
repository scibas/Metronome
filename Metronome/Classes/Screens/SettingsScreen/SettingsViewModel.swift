import Foundation

final class SettingsViewModel {
    fileprivate let model: SettingsModel
    fileprivate let metronomeEngine: MetronomeEngineProtocol
    
    init(withModel model: SettingsModel, metronomeEngine: MetronomeEngineProtocol) {
        self.model = model
        self.metronomeEngine = metronomeEngine
    }
    
    func numberOfSections() -> Int {
        return model.settings.count
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return model.settings[section].items.count
    }
    
    func settingItemForIndexPath(_ indexPath: IndexPath) -> SettingItem {
        let section = model.settings[indexPath.section]
        return section.items[indexPath.item]
    }
    
    func setEmphasisEnabled(_ emphasisEnabled: Bool) {
        metronomeEngine.emphasisEnabled = emphasisEnabled
    }
    
    func pauseMetronomeOnEnterBackground(_ pause: Bool) {
        metronomeEngine.pauseOnAppExit = pause
    }
}
