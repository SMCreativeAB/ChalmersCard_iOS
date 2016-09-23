import UIKit
import Foundation
import Eureka

open class CardNumberCell : _FieldCell<String>, CellType {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .default
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
    }
}

open class _CardNumberRow: FieldRow<CardNumberCell> {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class CardNumberRow: _CardNumberRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}
