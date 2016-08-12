import UIKit

class AboutTableViewController : UITableViewController {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide first section, else return normal height
        return section == 0 ? CGFloat.min : 36
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: true)
        
        if indexPath.section == 0 {
            return onAboutSectionTap(indexPath.row)
        }
        
        if indexPath.section == 1 {
            return onCreditsSectionTap(indexPath.row)
        }
    }
    
    private func onAboutSectionTap(row: Int) {
        if row == 0 {
            UIApplication.sharedApplication().openURL(Config.authorUrl!)
        } else {
            UIApplication.sharedApplication().openURL(Config.authorEmail!)
        }
    }
    
    private func onCreditsSectionTap(row: Int) {
        print("credits")
        print(row)
    }
}