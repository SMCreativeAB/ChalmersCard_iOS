import UIKit
import CWStatusBarNotification

class SettingsController : UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    fileprivate var formController: SettingsTableViewController?
    var isCreate = false
    var shouldHandleError = false
    fileprivate let notification = CWStatusBarNotification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification.notificationStyle = .navigationBarNotification
        notification.notificationAnimationOutStyle = .top
        notification.notificationAnimationInStyle = .top
        notification.notificationLabelBackgroundColor = Config.colorLow
    }
    
    override func viewDidLayoutSubviews() {
        let size = UIScreen.main.bounds.size
        
        if (size.height < 667 && size.width < 375) {
            headerHeight.constant = 63
            header.updateConstraintsIfNeeded()
            view.layoutIfNeeded()
            header.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = Config.tintColor
        self.navigationController?.navigationBar.makeDefault()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldHandleError {
            shouldHandleError = false
            notification.display(withMessage: NSLocalizedString("errorNotice", comment: ""), forDuration: 1.5)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onSave(_ sender: AnyObject) {
        if let form = formController {
            let cardNumber = form.getCardNumber()
            
            if !ProcessInfo.processInfo.arguments.contains("USE_FAKE_DATA") {
                guard String(cardNumber).characters.count == 16 else {
                    return
                }
            }
            
            AppDelegate.getShared().cardRepository!.set(cardNumber)
            
            // Tell balance controller to update
            AppDelegate.getShared().shouldUpdate = true
            
            if isCreate {
                performSegue(withIdentifier: "balanceSegue", sender: self)
                isCreate = false
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "embedForm") {
            self.formController = segue.destination as? SettingsTableViewController
        }
    }
}
