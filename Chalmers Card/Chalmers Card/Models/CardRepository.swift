import Foundation

class CardRepository {
    static let keychainKey = "CHALMERS_CARD"
    let keychain = KeychainService()
    let api = APIService()
    var card: Card?
    
    func get() -> Card? {
        if let number = keychain.get(CardRepository.keychainKey) where card == nil {
            loadCard(Int(number)!)
        }
        
        return card
    }
    
    func exists() -> Bool {
        return keychain.get(CardRepository.keychainKey) != nil
    }
    
    func set(number: Int) {
        card = nil
        keychain.set(CardRepository.keychainKey, value: String(number))
    }
    
    private func loadCard(number: Int) {
        let cardNumber = Int(number)
        let newCard = Card(number: cardNumber)
        newCard.balance = api.getCardAmount(cardNumber)
        
        card = newCard
    }
}