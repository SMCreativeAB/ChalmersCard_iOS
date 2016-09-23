import UIKit
import NotificationCenter
import CardData

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!

    let api = CardAPIService()
    let storage = KeychainService()
    var cardRepository: CardRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardRepository = CardRepository(keychain: storage, api: api)

        // Do any additional setup after loading the view from its nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func widgetPerformUpdate(_ completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
