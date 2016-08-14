import Foundation
import Alamofire

class APIService {
    func getCardAmount(number: Int, callback: Int? -> Void) {
        Alamofire.request(.GET, Config.apiUrl, parameters: ["card": number]).responseJSON { response in
            if let json = response.result.value {
                let success = json["successful"] as? Int
                let amount = json["balance"] as? String
                
                guard let _ = success where success == 1,
                    var cardAmount = amount else {
                    return callback(nil)
                }
                
                // Clean up integer
                cardAmount = cardAmount.stringByReplacingOccurrencesOfString(" ", withString: "")
                cardAmount = cardAmount.stringByReplacingOccurrencesOfString(",", withString: ".")
                
                guard let cardAmountFloat = Float(cardAmount) else {
                    return callback(nil)
                }
                
                callback(Int(cardAmountFloat))
            }
        }
    }
}