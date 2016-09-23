public class MockStorageService : StorageProtocol {
    public init() {
        
    }
    
    public func get(_ key: String) -> String? {
        return "1234123412341234"
    }
    
    public func set(_ key: String, value: String) {
        
    }
}
