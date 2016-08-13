import UIKit

class SettingsController : UIViewController {
    @IBOutlet weak var container: UIView!
    private var formController: SettingsTableViewController?
    var isCreate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = Config.tintColor
        self.navigationController?.navigationBar.makeDefault()
        
        print(isCreate)
    }
    
    override func viewWillDisappear(animated: Bool) {
        isCreate = false
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
            
            guard String(cardNumber).characters.count == 16 else {
                return
            }
            
            AppDelegate.getShared().cardRepository.set(cardNumber)
            
            // Tell balance controller to update
            AppDelegate.getShared().didEnterBackground = true
            
            if isCreate {
                performSegueWithIdentifier("balanceSegue", sender: self)
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