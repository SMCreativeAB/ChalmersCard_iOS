import Foundation
import Alamofire

class CardAPIService :  CardDataProtocol {
    func getCardAmount(number: String, callback: Int? -> Void) {
        print(Config.apiUrl + number)
        Alamofire.request(.GET, Config.apiUrl + String(number)).responseJSON { response in
            if let json = response.result.value, let amount = json["amount"] as? Int {
                return callback(amount)
            }
            
            callback(nil)
        }
    }
}