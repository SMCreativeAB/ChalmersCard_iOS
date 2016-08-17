import UIKit
import Foundation
import Eureka

public class CardNumberCell : _FieldCell<String>, CellType {
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public override func setup() {
        super.setup()
        textField.autocorrectionType = .Default
        textField.autocapitalizationType = .None
        textField.keyboardType = .NumberPad
    }
}

public class _CardNumberRow: FieldRow<String, CardNumberCell> {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class CardNumberRow: _CardNumberRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        onCellHighlight { cell, row  in
            let color = cell.textLabel?.textColor
            row.onCellUnHighlight { cell, _ in
                cell.textLabel?.textColor = color
            }
            cell.textLabel?.textColor = cell.tintColor
        }
    }
}