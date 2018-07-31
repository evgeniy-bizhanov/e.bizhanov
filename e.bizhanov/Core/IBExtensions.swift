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
}
