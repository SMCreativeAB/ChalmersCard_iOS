import UIKit

class NavigationController : UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !AppDelegate.getShared().cardRepository!.exists() && !ProcessInfo.processInfo.arguments.contains("USE_FAKE_DATA") {
            performSegue(withIdentifier: "addCardSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCardSegue" {
            let target = segue.destination as! SettingsController
            target.navigationItem.setHidesBackButton(true, animated: false)
            
            target.isCreate = true
        } else if segue.identifier == "refillSegue" {
            let target = segue.destination as! BalanceController
            target.shouldShowRefill = true
        }
    }
}
