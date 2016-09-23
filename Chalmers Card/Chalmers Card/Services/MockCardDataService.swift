public class MockCardDataService : CardDataProtocol {
    var calls = 0
    
    public init() {
        
    }
    
    public func getCardAmount(_ number: String, callback: @escaping (Int?) -> Void) {
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
