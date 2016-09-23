import UIKit
import NotificationCenter
import CardData
import NSDate_TimeAgo

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
        showLastStatement()
    
    }
    
    func showLastStatement() {
        if let lastStatement = cardRepository!.getLastStatement() {
            self.timeAgoLabel.text = (lastStatement.timestamp as NSDate).timeAgo()
            self.amountLabel.text = String(lastStatement.balance) + " kr"
        } else {
            amountLabel.text = "-"
            timeAgoLabel.text =  NSLocalizedString("noCard", comment: "")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func widgetPerformUpdate(_ completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        showLastStatement()
        completionHandler(NCUpdateResult.newData)
    }
    
}
