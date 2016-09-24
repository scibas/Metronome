import Foundation

struct SettingsGroup {
    let name: String?
    let items: [SettingItem]
}

struct SettingItem {
    let title: String
    let type: SettingItemType
    let action: SettingItemAction
}

enum SettingItemType {
    case Boolean
    case Select
    case Subitems
}

enum SettingItemAction {
    case ChangeSound
    case EnableEmphasis
    case PlayInBackground
    case RateApp
    case ReportBug
}

struct SettingsModel {
	let settings = [
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Change sound", type: .Subitems, action: .ChangeSound),
				SettingItem(title: "Emphasis enabled", type: .Boolean, action: .EnableEmphasis)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Play in background", type: .Boolean, action: .PlayInBackground)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Rate app", type: .Select, action: .RateApp),
				SettingItem(title: "Raport bug", type: .Select, action: .ReportBug)
			]
		)
	]
}