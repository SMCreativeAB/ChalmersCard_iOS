import Foundation

extension String {
    func isNumeric() -> Bool {
        let scanner = NSScanner(string: self)
        return scanner.scanDecimal(nil) && scanner.atEnd
    }
}