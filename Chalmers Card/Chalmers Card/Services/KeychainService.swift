import Foundation
import KeychainSwift

class KeychainService {
    let keychain = KeychainSwift()
    
    init() {
        keychain.synchronizable = true
    }
    
    func get(key: String) -> String? {
        return keychain.get(key)
    }
    
    func set(key: String, value: String) {
        keychain.set(value, forKey: key)
    }
}
