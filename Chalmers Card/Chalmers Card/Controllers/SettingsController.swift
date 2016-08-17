import UIKit
import CWStatusBarNotification

class SettingsController : UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    private var formController: SettingsTableViewController?
    var isCreate = false
    var shouldHandleError = false
    private let notification = CWStatusBarNotification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification.notificationStyle = .NavigationBarNotification
        notification.notificationAnimationOutStyle = .Top
        notification.notificationAnimationInStyle = .Top
        notification.notificationLabelBackgroundColor = Config.colorLow
    }
    
    override func viewDidLayoutSubviews() {
        let size = UIScreen.mainScreen().bounds.size
        
        if (size.height < 667 && size.width < 375) {
            headerHeight.constant = 63
            header.updateConstraintsIfNeeded()
            view.layoutIfNeeded()
            header.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = Config.tintColor
        self.navigationController?.navigationBar.makeDefault()
    }
    
    override func viewDidAppear(animated: Bool) {
        if shouldHandleError {
            shouldHandleError = false
            notification.displayNotificationWithMessage(NSLocalizedString("errorNotice", comment: ""), forDuration: 1.5)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func onSave(sender: AnyObject) {
        if let form = formController {
            let cardNumber = form.getCardNumber()
            
            if !NSProcessInfo.processInfo().arguments.contains("USE_FAKE_DATA") {
                guard String(cardNumber).characters.count == 16 else {
                    return
                }
            }
            
            AppDelegate.getShared().cardRepository!.set(cardNumber)
            
            // Tell balance controller to update
            AppDelegate.getShared().shouldUpdate = true
            
            if isCreate {
                performSegueWithIdentifier("balanceSegue", sender: self)
                isCreate = false
            } else {
                navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "embedForm") {
            self.formController = segue.destinationViewController as? SettingsTableViewController
        }
    }
}