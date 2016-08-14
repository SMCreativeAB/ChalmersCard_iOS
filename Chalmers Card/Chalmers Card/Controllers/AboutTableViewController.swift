import UIKit

class AboutTableViewController : UITableViewController {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide first section, else return normal height
        return section == 0 ? CGFloat.min : 36
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: true)
        
        var url: NSURL?
        
        if indexPath.section == 0 {
            url = urlForAboutSectionTap(indexPath.row)
        } else {
            url = urlForCreditsSectionTap(indexPath.row)
        }
        
        if let urlToOpen = url {
            UIApplication.sharedApplication().openURL(urlToOpen)
        }
    }
    
    private func urlForAboutSectionTap(row: Int) -> NSURL? {
        if row == 0 { return Config.authorUrl }
        if row == 1 { return Config.authorEmail }
        //if row == 2 { return Config.gitHubUrl }
        
        return nil
    }
    
    private func urlForCreditsSectionTap(row: Int) -> NSURL? {
        if row == 0 { return Config.uiColorHexSwift }
        if row == 1 { return Config.uiCountingLabel }
        if row == 2 { return Config.cwStatusBarNotification }
        if row == 3 { return Config.uiNavigationBarAddition }
        if row == 4 { return Config.eureka }
        if row == 5 { return Config.keychainSwift }
        if row == 6 { return Config.alamofire }
        if row == 7 { return Config.nsDateTimeAgo }
        if row == 8 { return Config.freepik }
        
        return nil
    }
}