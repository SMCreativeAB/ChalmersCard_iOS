import UIKit
import SafariServices
import UICountingLabel
import NSDate_TimeAgo

class BalanceController : UIViewController {
    @IBOutlet weak var balanceLabel: UICountingLabel!
    @IBOutlet weak var timeSinceUpdateLabel: UILabel!
    
    let cardRepository = AppDelegate.getShared().cardRepository
    var shouldShowRefill = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set label format
        balanceLabel.format = "%d kr"
        balanceLabel.method = .EaseOut
        timeSinceUpdateLabel.text = "Never updated"
        
        if let lastStatement = cardRepository.getLastStatement() {
            timeSinceUpdateLabel.text = lastStatement.timestamp.timeAgo()
            balanceLabel.text = String(lastStatement.balance)
            
            let color = BalanceColorIndicator.getColor(lastStatement.balance)
            setBackgroundColor(color, animated: false)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func updateBalance() {
        if let statement = cardRepository.getStatement() {
            timeSinceUpdateLabel.text = statement.timestamp.timeAgo()
            balanceLabel.countFromCurrentValueTo(CGFloat(statement.balance))
            
            let color = BalanceColorIndicator.getColor(statement.balance)
            setBackgroundColor(color, animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.updateBalance()
        }
        
        if shouldShowRefill {
            onRefillCardButtonTap(self)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        shouldShowRefill = false
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

