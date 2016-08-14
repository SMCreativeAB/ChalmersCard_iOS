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
    var shouldHandleError = false
    var lastBalance = 0
    var lastUpdate: NSDate?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set label format
        balanceLabel.format = "%d kr"
        balanceLabel.method = .EaseOut
        timeSinceUpdateLabel.text = NSLocalizedString("neverUpdated", comment: "")
        
        setupPullToRefresh()
        
        // Will be animated in later
        timeSinceUpdateLabel.alpha = 0
        balanceLabel.alpha = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(self.didBecomeActiveAgain), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func didBecomeActiveAgain() {
        showLastStatement()
        
        // If more than 5min ago, update
        if lastUpdate?.timeIntervalSinceDate(NSDate()) < -300 {
            self.updateBalance()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func showLastStatement() {
        if let lastStatement = cardRepository.getLastStatement() {
            timeSinceUpdateLabel.text = lastStatement.timestamp.timeAgo()
            lastBalance = lastStatement.balance
            lastUpdate = lastStatement.timestamp
            
            let color = BalanceColorIndicator.getColor(lastStatement.balance)
            setBackgroundColor(color, animated: false)
        }
    }
    
    private func setupPullToRefresh() {
        scrollView.alwaysBounceVertical = true
        
        refreshControl.tintColor = UIColor.whiteColor()
        let whiteColorAttribute = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let pullToRefresh = NSLocalizedString("pullToRefresh", comment: "")
        refreshControl.attributedTitle = NSAttributedString(string: pullToRefresh, attributes: whiteColorAttribute)
        
        scrollView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(self.updateBalance), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateBalance() {
        scrollView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
        refreshControl.beginRefreshing()
        
        UIView.animateWithDuration(0.3) {
            self.timeSinceUpdateLabel.alpha = 0
            self.balanceLabel.alpha = 0
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.cardRepository.getStatement() { result in
                if let statement = result {
                    self.timeSinceUpdateLabel.text = statement.timestamp.timeAgo()
                    self.balanceLabel.countFrom(CGFloat(self.lastBalance), to: CGFloat(statement.balance))
                    let color = BalanceColorIndicator.getColor(statement.balance)
                    self.setBackgroundColor(color, animated: true)
                } else {
                    // Something went wrong
                    self.shouldHandleError = true
                    self.performSegueWithIdentifier("settingsSegue", sender: self)
                }
                
                self.refreshControl.endRefreshing()
                self.scrollView.setContentOffset(CGPoint.zero, animated: true)
                
                UIView.animateWithDuration(0.3) {
                    self.timeSinceUpdateLabel.alpha = 1
                    self.balanceLabel.alpha = 1
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        showLastStatement()
        
        // If the app has been inactive, we should update
        if AppDelegate.getShared().shouldUpdate {
            shouldUpdate = true
            AppDelegate.getShared().shouldUpdate = false
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settingsSegue" && shouldHandleError {
            let destination = segue.destinationViewController as! SettingsController
            destination.shouldHandleError = true
            shouldHandleError = false
        }
    }
}

