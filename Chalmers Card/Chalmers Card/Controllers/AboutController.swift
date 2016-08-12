import UIKit
import UINavigationBar_Addition

class AboutController : UIViewController {
    @IBOutlet weak var headerBackground: UIView!
    private var gradientLayer: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = getBrandGradient(headerBackground.bounds)
        headerBackground.layer.insertSublayer(gradientLayer!, atIndex: 0)
    }
    
    private func getBrandGradient(bounds: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()

        // Set color stops
        gradient.colors = [
            UIColor.colorWithHex(0x57E2CB).CGColor,
            UIColor.colorWithHex(0x4492C6).CGColor
        ]
        
        // Diagonal direction
        gradient.frame = bounds
        gradient.startPoint = CGPointMake(0, 1)
        gradient.endPoint = CGPointMake(1, 0)
        
        return gradient
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.makeTransparent()
    }
    
    override func viewWillLayoutSubviews() {
        gradientLayer?.frame = headerBackground.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

