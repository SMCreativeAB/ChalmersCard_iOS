import UIKit
import SafariServices
import CWStatusBarNotification

class RefillController : SFSafariViewController {
    private let notification = CWStatusBarNotification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification.notificationStyle = .NavigationBarNotification
        notification.notificationAnimationOutStyle = .Top
        notification.notificationAnimationInStyle = .Top
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.persistent = true
        pasteboard.string = "hej"
        
        delay(0.7) {
            self.notification.displayNotificationWithMessage("Ditt kortnummer har kopierats och kan klistras in nedan", forDuration: 1.5)
        }
    }
}