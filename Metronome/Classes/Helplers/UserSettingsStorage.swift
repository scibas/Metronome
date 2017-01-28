import Foundation

protocol UserSettingsStorage: KeyValueStorage {
	var tempo: BPM? { get set }
	var metre: Metre? { get set }
    var emphasisEnabled: Bool? { set get }
}

protocol KeyValueStorage {
	func storeValue<T>(_ value: T, forKey key: String)
}


//temporary code below
class UserSettingsStorageClass: UserSettingsStorage {
    var tempo: BPM?
    var metre: Metre?
    var emphasisEnabled: Bool?
    
    func storeValue<T>(_ value: T, forKey key: String) {
    }
}
