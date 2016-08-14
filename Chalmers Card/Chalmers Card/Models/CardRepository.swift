import Foundation

class CardRepository {
    static let keychainKey = "CHALMERS_CARD"
    static let lastStatementKey = "CHALMERS_CARD_STATEMENT"
    let defaults = NSUserDefaults.standardUserDefaults()
    let keychain = KeychainService()
    let api = APIService()
    
    func getStatement(callback: CardStatement? -> Void) {
        if let number = getNumber() {
            api.getCardAmount(number) { amount in
                self.onCardAmount(amount, callback: callback)
            }
        } else {
            callback(nil)
        }
    }
    
    private func onCardAmount(amount: Int?, callback: CardStatement? -> Void) {
        if let amountValue = amount {
            let cardStatement = CardStatement(balance: amountValue, timestamp: NSDate())
            let statementData = NSKeyedArchiver.archivedDataWithRootObject(cardStatement)
            self.defaults.setObject(statementData, forKey: CardRepository.lastStatementKey)
            callback(cardStatement)
        } else {
            callback(nil)
        }
    }
    
    func getNumber() -> Int? {
        if let str = keychain.get(CardRepository.keychainKey) {
            return Int(str)
        }
        
        return nil
    }
    
    func getLastStatement() -> CardStatement? {
        if let data = defaults.objectForKey(CardRepository.lastStatementKey) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? CardStatement
        }
        
        return nil
    }
    
    func exists() -> Bool {
        return getNumber() != nil
    }
    
    func set(number: Int) {
        keychain.set(CardRepository.keychainKey, value: String(number))
    }
}