import UIKit
import SafariServices
import UICountingLabel

class BalanceController : UIViewController {
    @IBOutlet weak var balanceLabel: UICountingLabel!
    @IBOutlet weak var timeSinceUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set label format
        balanceLabel.format = "%d kr"
        balanceLabel.method = .EaseOut
        balanceLabel.text = "0 kr" // todo: use old value

        // Set starting point
        setBackgroundColor(Config.colorDefault, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        // Animate to new balance
        setBackgroundColor(Config.colorHigh, animated: true)
        balanceLabel.countFromCurrentValueTo(500)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func onRefillCardButtonTap(sender: AnyObject) {
        let safari = RefillController(URL: Config.chargeCardUrl!)
        self.presentViewController(safari, animated: true, completion: nil)
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
}

