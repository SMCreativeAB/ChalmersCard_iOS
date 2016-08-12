import UIKit
import UINavigationBar_Addition

class AboutController : UIViewController {    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.makeTransparent()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

