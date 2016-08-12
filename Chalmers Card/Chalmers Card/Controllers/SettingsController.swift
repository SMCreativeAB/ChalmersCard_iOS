import UIKit

class SettingsController : UIViewController {
    @IBOutlet weak var container: UIView!
    private var formController: SettingsTableViewController?
    
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func onSave(sender: AnyObject) {
        if let form = formController {
            print(form.getCardNumber())
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "embedForm") {
            self.formController = segue.destinationViewController as? SettingsTableViewController
        }
    }
}