import Foundation
import Alamofire

class APIService {
    func getCardAmount(number: Int, callback: Int? -> Void) {
        print(Config.apiUrl + String(number))
        Alamofire.request(.GET, Config.apiUrl + String(number)).responseJSON { response in
            if let json = response.result.value, let amount = json["amount"] as? Int {
                return callback(amount)
            }
            
            callback(nil)
        }
    }
}