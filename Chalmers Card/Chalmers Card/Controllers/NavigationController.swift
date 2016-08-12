import UIKit

class NavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !AppDelegate.getShared().cardRepository.exists() {
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