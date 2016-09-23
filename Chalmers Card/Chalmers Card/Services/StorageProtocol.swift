public protocol StorageProtocol {
    func get(_ key: String) -> String?
    func set(_ key: String, value: String)
}
