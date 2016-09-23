import UIKit
import SafariServices
import UICountingLabel
import NSDate_TimeAgo
import CardData

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class BalanceController : UIViewController {
    @IBOutlet weak var balanceLabel: UICountingLabel!
    @IBOutlet weak var timeSinceUpdateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let cardRepository = AppDelegate.getShared().cardRepository
    var shouldShowRefill = false
    var shouldUpdate = true
    var shouldHandleError = false
    var lastBalance = 0
    var lastUpdate: Date?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set label format
        balanceLabel.format = "%d kr"
        balanceLabel.method = .easeOut
        timeSinceUpdateLabel.text = NSLocalizedString("neverUpdated", comment: "")
        
        setupPullToRefresh()
        
        if (!ProcessInfo.processInfo.arguments.contains("USE_FAKE_DATA")) {
            // Will be animated in later
            self.timeSinceUpdateLabel.alpha = 0
            self.balanceLabel.alpha = 0
        }
    
        NotificationCenter.default.addObserver(self, selector:#selector(self.didBecomeActiveAgain), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    func didBecomeActiveAgain() {
        showLastStatement()
        
        // If more than 5min ago, update
        if lastUpdate?.timeIntervalSince(Date()) < -300 {
            self.updateBalance()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showLastStatement() {
        if let lastStatement = cardRepository!.getLastStatement() {
            self.onLastStatement(lastStatement)
        }
    }
    
    public func onLastStatement(_ lastStatement: CardStatement) {
        self.timeSinceUpdateLabel.text = (lastStatement.timestamp as NSDate).timeAgo()
        self.lastBalance = lastStatement.balance
        self.lastUpdate = lastStatement.timestamp as Date
    
        let color = BalanceColorIndicator.getColor(lastStatement.balance)
        setBackgroundColor(color, animated: false)
    }
    
    func setupPullToRefresh() {
        scrollView.alwaysBounceVertical = true
        
        refreshControl.tintColor = UIColor.white
        let whiteColorAttribute = [NSForegroundColorAttributeName: UIColor.white]
        let pullToRefresh = NSLocalizedString("pullToRefresh", comment: "")
        refreshControl.attributedTitle = NSAttributedString(string: pullToRefresh, attributes: whiteColorAttribute)
        
        scrollView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(self.updateBalance), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateBalance() {
        if ProcessInfo.processInfo.arguments.contains("USE_FAKE_DATA") {
            self.cardRepository!.getStatement() { result in
                if let statement = result {
                    self.timeSinceUpdateLabel.text = (statement.timestamp as NSDate).timeAgo()
                    self.balanceLabel.text = String(statement.balance) + " kr"
                    let color = BalanceColorIndicator.getColor(statement.balance)
                    self.setBackgroundColor(color, animated: false)
                    self.timeSinceUpdateLabel.alpha = 1
                    self.balanceLabel.alpha = 1
                }
            }
            
            return
        }
        
        scrollView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
        refreshControl.beginRefreshing()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.timeSinceUpdateLabel.alpha = 0
            self.balanceLabel.alpha = 0
        }) 
        
        DispatchQueue.main.async {
            self.cardRepository!.getStatement() { result in
                if let statement = result {
                    self.timeSinceUpdateLabel.text = (statement.timestamp as NSDate).timeAgo()
                    self.balanceLabel.count(from: CGFloat(self.lastBalance), to: CGFloat(statement.balance))
                    let color = BalanceColorIndicator.getColor(statement.balance)
                    self.setBackgroundColor(color, animated: true)
                } else {
                    // Something went wrong
                    self.shouldHandleError = true
                    self.performSegue(withIdentifier: "settingsSegue", sender: self)
                }
                
                self.refreshControl.endRefreshing()
                self.scrollView.setContentOffset(CGPoint.zero, animated: true)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.timeSinceUpdateLabel.alpha = 1
                    self.balanceLabel.alpha = 1
                }) 
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    @IBAction func onRefillCardButtonTap(_ sender: AnyObject) {
        let safari = RefillController(url: Config.chargeCardUrl!)
        self.present(safari, animated: true, completion: nil)
    }
    
    func setBackgroundColor(_ color: UIColor, animated: Bool) {
        let setTargetColor = {
            self.view.backgroundColor = color
        }
        
        if (animated) {
            UIView.animate(withDuration: 2, animations: setTargetColor)
        } else {
            setTargetColor()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsSegue" && shouldHandleError {
            let destination = segue.destination as! SettingsController
            destination.shouldHandleError = true
            shouldHandleError = false
        }
    }
}

