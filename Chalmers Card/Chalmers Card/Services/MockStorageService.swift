class MockStorageService : StorageProtocol {
    func get(key: String) -> String? {
        return "1234123412341234"
    }
    
    func set(key: String, value: String) {
        
    }
}