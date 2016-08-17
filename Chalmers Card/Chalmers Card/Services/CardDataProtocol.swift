protocol CardDataProtocol {
    func getCardAmount(number: String, callback: Int? -> Void)
}