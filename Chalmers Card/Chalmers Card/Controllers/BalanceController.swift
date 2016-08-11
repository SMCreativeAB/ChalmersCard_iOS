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
    
    @IBAction func onChargeCardButtonTap(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: Config.chargeCardUrl)!, entersReaderIfAvailable: true)
        self.presentViewController(svc, animated: true, completion: nil)
    }
}

