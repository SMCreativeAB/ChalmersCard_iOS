protocol StorageProtocol {
    func get(key: String) -> String?
    func set(key: String, value: String)
}