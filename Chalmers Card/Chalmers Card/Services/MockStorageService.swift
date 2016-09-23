class MockStorageService : StorageProtocol {
    func get(_ key: String) -> String? {
        return "1234123412341234"
    }
    
    func set(_ key: String, value: String) {
        
    }
}
