import Foundation

class CardRepository {
    static let keychainKey = "CHALMERS_CARD"
    static let lastStatementKey = "CHALMERS_CARD_STATEMENT"
    let defaults = NSUserDefaults.standardUserDefaults()
    let keychain = KeychainService()
    let api = APIService()
    var statement: CardStatement?
    
    func getStatement() -> CardStatement? {
        if let number = getNumber() where statement == nil {
            statement = loadStatement(number)
        }
        
        return statement
    }
    
    func getNumber() -> Int? {
        if let str = keychain.get(CardRepository.keychainKey) {
            return Int(str)
        }
        
        return nil
    }
    
    func getLastStatement() -> CardStatement? {
        if statement == nil, let data = defaults.objectForKey(CardRepository.lastStatementKey) as? NSData {
            statement = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? CardStatement
        }
        
        return statement
    }
    
    func exists() -> Bool {
        return getNumber() != nil
    }
    
    func set(number: Int) {
        keychain.set(CardRepository.keychainKey, value: String(number))
    }
    
    private func loadStatement(number: Int) -> CardStatement {
        let balance = api.getCardAmount(number)
        let cardStatement = CardStatement(balance: balance, timestamp: NSDate())
        
        let statementData = NSKeyedArchiver.archivedDataWithRootObject(cardStatement)
        defaults.setObject(statementData, forKey: CardRepository.lastStatementKey)
        
        return cardStatement
    }
}