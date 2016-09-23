import Foundation
import Alamofire

class CardAPIService : CardDataProtocol {
    func getCardAmount(_ number: String, callback: @escaping (Int?) -> Void) {
        print(Config.apiUrl + number)
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
