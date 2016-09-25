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
    case Simple
    case SimpleWithSubitems
    case TrueFalse
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
				SettingItem(title: "Change sound", type: .SimpleWithSubitems, action: .ChangeSound),
				SettingItem(title: "Emphasis enabled", type: .TrueFalse, action: .EnableEmphasis)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Play in background", type: .TrueFalse, action: .PlayInBackground)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Rate app", type: .Simple, action: .RateApp),
				SettingItem(title: "Raport bug", type: .Simple, action: .ReportBug)
			]
		)
	]
}