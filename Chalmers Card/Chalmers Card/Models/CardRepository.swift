import Foundation

class CardRepository {
    static let keychainKey = "CHALMERS_CARD"
    static let lastStatementKey = "CHALMERS_CARD_STATEMENT"
    let defaults = NSUserDefaults.standardUserDefaults()
    let keychain = KeychainService()
    let api = APIService()
    
    func getStatement(callback: CardStatement? -> Void) {
        var cardStatement: CardStatement?
        
        if let number = getNumber() {
            let balance = api.getCardAmount(number)
            cardStatement = CardStatement(balance: balance, timestamp: NSDate())
            
            let statementData = NSKeyedArchiver.archivedDataWithRootObject(cardStatement!)
            defaults.setObject(statementData, forKey: CardRepository.lastStatementKey)
        }
        
        delay(1) {
            callback(cardStatement)
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