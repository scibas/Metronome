import Foundation

protocol DefaultsStorage {
	func storeValue<T>(value: T, forKey key: String)
}
