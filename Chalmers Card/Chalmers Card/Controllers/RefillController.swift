import UIKit
import SafariServices
import CWStatusBarNotification

class RefillController : SFSafariViewController {
    private let notification = CWStatusBarNotification()
    private var isVisible = false
    
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
        
        isVisible = true
        
        delay(0.7) {
            if self.isVisible {
                self.notification.displayNotificationWithMessage("Ditt kortnummer har kopierats och kan klistras in nedan", forDuration: 1.5)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        isVisible = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}