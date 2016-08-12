import Eureka

class SettingsTableViewController : FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            
        <<< IntRow("CardNumber"){ row in
            row.title = "Kortnumer"
            row.placeholder = "XXXX XXXX XXXX XXXX"
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide first section, else return normal height
        return section == 0 ? CGFloat.min : 36
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let row = form.rowByTag("CardNumber") as! IntRow
        row.cell.textField.becomeFirstResponder()
    }

}
