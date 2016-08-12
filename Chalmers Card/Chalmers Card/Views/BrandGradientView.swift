import UIKit

class BrandGradientView : UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    private func setupView() {
        autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        guard let gradient = self.layer as? CAGradientLayer else {
            return;
        }
        
        // Set color stops
        gradient.colors = [
            UIColor.colorWithHex(0x57E2CB).CGColor,
            UIColor.colorWithHex(0x4492C6).CGColor
        ]
        
        // Diagonal direction
        gradient.startPoint = CGPointMake(0, 1)
        gradient.endPoint = CGPointMake(1, 0)
        
        gradient.frame = bounds
    }
}