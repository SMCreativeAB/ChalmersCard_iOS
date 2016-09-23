import Foundation
import KeychainSwift

public class KeychainService : StorageProtocol {
    let keychain = KeychainSwift()
    
    public init() {
        keychain.accessGroup = "group.chalmersCard"
        keychain.synchronizable = true
    }
    
    public func get(_ key: String) -> String? {
        return keychain.get(key)
    }
    
    public func set(_ key: String, value: String) {
        keychain.set(value, forKey: key)
    }
}
