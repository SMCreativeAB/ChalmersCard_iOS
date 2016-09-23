protocol CardDataProtocol {
    func getCardAmount(_ number: String, callback: @escaping (Int?) -> Void)
}
