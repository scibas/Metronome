import Foundation

class SettingsModel {
	let settings = [
		SettingsSection(
			title: nil,
			items: [
				SettingItem(title: "Change sound", type: .Subitems, subItems: nil),
				SettingItem(title: "Emphasis enabled", type: .Boolean, subItems: nil)
			]
		),
		
		SettingsSection(
			title: nil,
			items: [
				SettingItem(title: "Play in background", type: .Boolean, subItems: nil)
			]
		),
		
		SettingsSection(
			title: nil,
			items: [
				SettingItem(title: "Rate app", type: .Select, subItems: nil),
				SettingItem(title: "Raport bug", type: .Select, subItems: nil)
			]
		)
	]
}

struct SettingsSection {
	let title: String?
	let items: [SettingItem]
}

struct SettingItem {
	let title: String
	let type: SettingItemType
	let subItems: [SettingItem]?
}

enum SettingItemType {
	case Boolean
	case Select
	case Subitems
}