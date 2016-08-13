import UIKit
import SafariServices
import UICountingLabel
import NSDate_TimeAgo

class BalanceController : UIViewController {
    @IBOutlet weak var balanceLabel: UICountingLabel!
    @IBOutlet weak var timeSinceUpdateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let cardRepository = AppDelegate.getShared().cardRepository
    var shouldShowRefill = false
    var shouldUpdate = true
    let refreshControl = UIRefreshControl()
    
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

        setupPullToRefresh()
    }
    
    private func setupPullToRefresh() {
        scrollView.alwaysBounceVertical = true
        
        refreshControl.tintColor = UIColor.whiteColor()
        //let whiteColorAttribute = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: whiteColorAttribute)
        scrollView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(self.updateBalance), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateBalance() {
        refreshControl.beginRefreshing()
        
        UIView.animateWithDuration(0.3) {
            self.timeSinceUpdateLabel.alpha = 0
            self.balanceLabel.alpha = 0
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            if let statement = self.cardRepository.getStatement() {
                self.timeSinceUpdateLabel.text = statement.timestamp.timeAgo()
                self.balanceLabel.countFromCurrentValueTo(CGFloat(statement.balance))
                let color = BalanceColorIndicator.getColor(statement.balance)
                self.setBackgroundColor(color, animated: true)
                
                UIView.animateWithDuration(0.3) {
                    self.timeSinceUpdateLabel.alpha = 1
                    self.balanceLabel.alpha = 1
                }
            }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        // If the app has been inactive, we should update
        if AppDelegate.getShared().didEnterBackground {
            shouldUpdate = true
            AppDelegate.getShared().didEnterBackground = false
        }
        
        if shouldUpdate {
            self.updateBalance()
            shouldUpdate = false
        }
        
        if shouldShowRefill {
            onRefillCardButtonTap(self)
            shouldShowRefill = false
        }
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

