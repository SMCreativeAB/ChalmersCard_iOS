import UIKit

class BalanceColorIndicator {
    static func getColor(balance: Int) -> UIColor {
        switch (balance) {
        case 0..<100:
            return Config.colorLow
            
        case 100..<300:
            return Config.colorMedium
            
        default:
            return Config.colorHigh
        }
    }
}