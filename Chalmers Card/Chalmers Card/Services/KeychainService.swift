import Foundation
import KeychainSwift

class KeychainService : StorageProtocol {
    let keychain = KeychainSwift()
    
    init() {
        keychain.synchronizable = true
    }
    
    func get(_ key: String) -> String? {
        return keychain.get(key)
    }
    
    func set(_ key: String, value: String) {
        keychain.set(value, forKey: key)
    }
}
