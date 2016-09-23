import UIKit

class BrandGradientView : UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    
    fileprivate func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let gradient = self.layer as? CAGradientLayer else {
            return;
        }
        
        // Set color stops
        gradient.colors = [
            UIColor.colorWithHex(0x57E2CB).cgColor,
            UIColor.colorWithHex(0x4492C6).cgColor
        ]
        
        // Diagonal direction
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        gradient.frame = bounds
    }
}
