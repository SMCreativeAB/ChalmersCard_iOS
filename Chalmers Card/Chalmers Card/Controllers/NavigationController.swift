import UIKit

class NavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !AppDelegate.getShared().cardRepository!.exists() && !NSProcessInfo.processInfo().arguments.contains("USE_FAKE_DATA") {
            performSegueWithIdentifier("addCardSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addCardSegue" {
            let target = segue.destinationViewController as! SettingsController
            target.navigationItem.setHidesBackButton(true, animated: false)
            
            target.isCreate = true
        } else if segue.identifier == "refillSegue" {
            let target = segue.destinationViewController as! BalanceController
            target.shouldShowRefill = true
        }
    }
}