import UIKit

class SettingsController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = Config.tintColor
        self.navigationController?.navigationBar.makeDefault()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}