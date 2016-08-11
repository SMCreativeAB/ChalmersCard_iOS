import UIKit
import SafariServices

class BalanceController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func onRefillCardButtonTap(sender: AnyObject) {
        let svc = RefillController(URL: NSURL(string: Config.chargeCardUrl)!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
}

