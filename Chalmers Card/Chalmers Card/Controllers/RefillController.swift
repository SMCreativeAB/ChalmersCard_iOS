import UIKit
import SafariServices
import CWStatusBarNotification

class RefillController : SFSafariViewController {
    fileprivate let notification = CWStatusBarNotification()
    fileprivate var isVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification.notificationStyle = .navigationBarNotification
        notification.notificationAnimationOutStyle = .top
        notification.notificationAnimationInStyle = .top
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pasteboard = UIPasteboard.general
        pasteboard.setPersistent(true)
        pasteboard.string = String(AppDelegate.getShared().cardRepository!.getNumber()!)
        
        isVisible = true
        
        delay(0.7) {
            if self.isVisible {
                self.notification.display(withMessage: NSLocalizedString("cardCopied", comment: ""), forDuration: 1.5)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isVisible = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
}
