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
    case simple
    case simpleWithSubitems
    case trueFalse
}

enum SettingItemAction {
    case changeSound
    case enableEmphasis
    case playInBackground
    case rateApp
    case reportBug
}

struct SettingsModel {
	let settings = [
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Change sound", type: .simpleWithSubitems, action: .changeSound),
				SettingItem(title: "Emphasis enabled", type: .trueFalse, action: .enableEmphasis)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Play in background", type: .trueFalse, action: .playInBackground)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Rate app", type: .simple, action: .rateApp),
				SettingItem(title: "Raport bug", type: .simple, action: .reportBug)
			]
		)
	]
}
