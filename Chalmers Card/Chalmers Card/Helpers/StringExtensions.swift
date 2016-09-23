import Foundation

extension String {
    func isNumeric() -> Bool {
        let scanner = Scanner(string: self)
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
}
