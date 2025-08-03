import Foundation

protocol DataStorageProtocol {
    func read<T: Decodable>(forKey key: String) -> T?
    func save<T: Encodable>(structs: T, forKey key: String)
    func delete(forKey key: String)
}

final class UserDefaultsStorage: DataStorageProtocol {
    
    static let shared = UserDefaultsStorage()

    private init() {}

    private let defaults = UserDefaults.standard

    func save<T: Encodable>(structs: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(structs) {
            defaults.set(encoded, forKey: key)
        }
    }

    func read<T: Decodable>(forKey key: String) -> T? {
        if let saveData = defaults.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(T.self, from: saveData) {
                return decoded
            }
        }
        return nil
    }

    func delete(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
