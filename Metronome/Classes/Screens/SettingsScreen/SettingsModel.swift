import Foundation

struct SettingsGroup {
    let name: String?
    let items: [SettingItem]
}

struct SettingItem {
    let title: String
    let type: SettingItemType
    let itemKind: SettingItemKind
}

enum SettingItemType {
    case simple
    case simpleWithSubitems
    case trueFalse
}

enum SettingItemKind {
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
				SettingItem(title: "Change sound", type: .simpleWithSubitems, itemKind: .changeSound),
				SettingItem(title: "Emphasis enabled", type: .trueFalse, itemKind: .enableEmphasis)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Play in background", type: .trueFalse, itemKind: .playInBackground)
			]
		),
		
		SettingsGroup(
			name: nil,
			items: [
				SettingItem(title: "Rate app", type: .simple, itemKind: .rateApp),
				SettingItem(title: "Raport bug", type: .simple, itemKind: .reportBug)
			]
		)
	]
}
