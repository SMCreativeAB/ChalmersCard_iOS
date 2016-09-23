import Foundation
import Alamofire

public class CardAPIService : CardDataProtocol {
    public init() {
        
    }
    
    public func getCardAmount(_ number: String, callback: @escaping (Int?) -> Void) {
        let url = Config.apiUrl + String(number)
        Alamofire.request(url).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value as? [String: Int] {
                if let amount = json["amount"] {
                    return callback(amount)
                } else {
                    callback(nil)
                }
            }
            
            callback(nil)
        }
    }
}
