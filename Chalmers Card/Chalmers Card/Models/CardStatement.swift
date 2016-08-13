import Foundation

class CardStatement : NSObject, NSCoding {
    var balance: Int
    var timestamp: NSDate
    
    init (balance: Int, timestamp: NSDate) {
        self.balance = balance
        self.timestamp = timestamp
    }
    
    required convenience init? (coder decoder: NSCoder) {
        print("balance")
        print(decoder.decodeObjectForKey("balance") as? Int)
        print("timestamp")
        print(decoder.decodeObjectForKey("timestamp") as? NSDate)
        guard let balance = decoder.decodeObjectForKey("balance") as? Int,
            let timestamp = decoder.decodeObjectForKey("timestamp") as? NSDate else {
                print("return nil")
                return nil
        }
        
        print("decoding")
        
        self.init(balance: balance, timestamp: timestamp)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(balance), forKey: "balance")
        coder.encodeObject(timestamp, forKey: "timestamp")
    }
}