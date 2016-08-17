import Eureka

class SettingsTableViewController : FormViewController, UITextFieldDelegate {
    private var cardTextField: UITextField?
    
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
        let text = cardTextField?.text?.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        if let num = text {
            return num
        }
        
        return "0"
    }
    
    private func filterTextFieldInput(textField: UITextField) {
        if var text = textField.text {
            if text.characters.count > 16 {
                let start = text.startIndex.advancedBy(16)
                text.removeRange(start ..< text.endIndex)
                textField.text = text
            }
        }
    }
    
    private func getCardNumberFormatter() -> NSNumberFormatter {
        let formatter = NSNumberFormatter()
        
        formatter.numberStyle = .DecimalStyle
        formatter.groupingSize = 4
        formatter.groupingSeparator = " "
        
        return formatter
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count == 0 {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        return prospectiveText.isNumeric() && prospectiveText.characters.count <= 16
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide first section, else return normal height
        return section == 0 ? CGFloat.min : 36
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        cardTextField?.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let cardNumber = AppDelegate.getShared().cardRepository!.getNumber() {
            form.setValues(["CardNumber": cardNumber])
        }
    }
}
