import Eureka

class SettingsTableViewController : FormViewController, UITextFieldDelegate {
    fileprivate var cardTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section(footer: NSLocalizedString("cardSafelyStoredNotice", comment: ""))
            
        <<< CardNumberRow("CardNumber"){ row in
            row.title = NSLocalizedString("cardNumber", comment: "")
            row.placeholder = "XXXXXXXXXXXXXXXX"
            //row.formatter = self.getCardNumberFormatter()
            self.cardTextField = row.cell.textField
        }.onChange() { row in
            self.filterTextFieldInput(row.cell.textField)
        }
    }
    
    func getCardNumber() -> String {
        let text = cardTextField?.text?.replacingOccurrences(of: " ", with: "")
        
        if let num = text {
            return num
        }
        
        return "0"
    }
    
    fileprivate func filterTextFieldInput(_ textField: UITextField) {
        if var text = textField.text {
            if text.characters.count > 16 {
                let start = text.characters.index(text.startIndex, offsetBy: 16)
                text.removeSubrange(start ..< text.endIndex)
                textField.text = text
            }
        }
    }
    
    fileprivate func getCardNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.groupingSize = 4
        formatter.groupingSeparator = " "
        
        return formatter
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count == 0 {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return prospectiveText.isNumeric() && prospectiveText.characters.count <= 16
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide first section, else return normal height
        return section == 0 ? CGFloat.leastNormalMagnitude : 36
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cardTextField?.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let cardNumber = AppDelegate.getShared().cardRepository!.getNumber() {
            form.setValues(["CardNumber": cardNumber])
        }
    }
}
