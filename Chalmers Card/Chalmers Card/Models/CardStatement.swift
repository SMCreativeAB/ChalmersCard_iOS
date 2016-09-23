import Foundation

public class CardStatement : NSObject, NSCoding {
    public var balance: Int
    public  var timestamp: Date
    
    public init (balance: Int, timestamp: Date) {
        self.balance = balance
        self.timestamp = timestamp
    }
    
    required convenience public init? (coder decoder: NSCoder) {
        let balance = decoder.decodeInteger(forKey: "balance")
        
        guard let timestamp = decoder.decodeObject(forKey: "timestamp") as? Date else {
            return nil
        }
        
        self.init(balance: balance, timestamp: timestamp)
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(balance, forKey: "balance")
        coder.encode(timestamp, forKey: "timestamp")
    }
}
