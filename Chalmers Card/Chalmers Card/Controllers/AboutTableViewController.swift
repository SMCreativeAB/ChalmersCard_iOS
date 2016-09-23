import UIKit

class AboutTableViewController : UITableViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide first section, else return normal height
        return section == 0 ? CGFloat.leastNormalMagnitude : 36
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        var url: URL?
        
        if (indexPath as NSIndexPath).section == 0 {
            url = urlForAboutSectionTap((indexPath as NSIndexPath).row)
        } else {
            url = urlForCreditsSectionTap((indexPath as NSIndexPath).row)
        }
        
        if let urlToOpen = url {
            UIApplication.shared.openURL(urlToOpen)
        }
    }
    
    fileprivate func urlForAboutSectionTap(_ row: Int) -> URL? {
        if row == 0 { return Config.authorUrl }
        if row == 1 { return Config.authorEmail }
        if row == 2 { return Config.gitHubUrl }
        
        return nil
    }
    
    fileprivate func urlForCreditsSectionTap(_ row: Int) -> URL? {
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
