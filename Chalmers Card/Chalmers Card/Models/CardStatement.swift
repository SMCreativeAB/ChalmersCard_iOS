import Foundation

class CardStatement : NSObject, NSCoding {
    var balance: Int
    var timestamp: Date
    
    init (balance: Int, timestamp: Date) {
        self.balance = balance
        self.timestamp = timestamp
    }
    
    required convenience init? (coder decoder: NSCoder) {
        let balance = decoder.decodeInteger(forKey: "balance")
        
        guard let timestamp = decoder.decodeObject(forKey: "timestamp") as? Date else {
            return nil
        }
        
        self.init(balance: balance, timestamp: timestamp)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(balance, forKey: "balance")
        coder.encode(timestamp, forKey: "timestamp")
    }
}
