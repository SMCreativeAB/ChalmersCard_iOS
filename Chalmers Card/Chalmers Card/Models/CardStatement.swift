import Foundation

class CardStatement : NSObject, NSCoding {
    var balance: Int
    var timestamp: NSDate
    
    init (balance: Int, timestamp: NSDate) {
        self.balance = balance
        self.timestamp = timestamp
    }
    
    required convenience init? (coder decoder: NSCoder) {
        let balance = decoder.decodeIntegerForKey("balance")
        
        guard let timestamp = decoder.decodeObjectForKey("timestamp") as? NSDate else {
            return nil
        }
        
        self.init(balance: balance, timestamp: timestamp)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(balance, forKey: "balance")
        coder.encodeObject(timestamp, forKey: "timestamp")
    }
}