//
// Расширение UIView для IB
//

import UIKit

@IBDesignable
extension UIView {
    /// Радиус скругления
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var topPadding: CGFloat {
        get { return layoutMargins.top }
        set { layoutMargins.top = newValue }
    }
}
