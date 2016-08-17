class MockCardDataService : CardDataProtocol {
    var calls = 0
    
    func getCardAmount(number: String, callback: Int? -> Void) {
        if calls == 0 {
            callback(543)
        } else if calls == 1 {
            callback(149)
        } else {
            callback(0);
        }
        
        calls += 1
    }
}