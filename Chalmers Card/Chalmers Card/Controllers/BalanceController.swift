import UIKit
import SafariServices

class BalanceController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set starting point
        setBackgroundColor(Config.colorDefault, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        // Animate to new balance
        setBackgroundColor(Config.colorHigh, animated: true)
    }
    
    private func setBackgroundColor(color: UIColor, animated: Bool) {
        let setTargetColor = {
            self.view.backgroundColor = color
        }
        
        if (animated) {
            UIView.animateWithDuration(2, animations: setTargetColor)
        } else {
            setTargetColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func onRefillCardButtonTap(sender: AnyObject) {
        let safari = RefillController(URL: Config.chargeCardUrl!)
        self.presentViewController(safari, animated: true, completion: nil)
    }
}

