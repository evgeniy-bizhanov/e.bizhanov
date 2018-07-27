//
// Базовый контроллер
//

import UIKit

class UIBaseViewController: UIViewController {
    
    var isCanBecomeFirstResponder: (UIView) -> Bool = { $0.canBecomeFirstResponder }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFirstResponders()
    }
}

// MARK: - Служебные методы
extension UIBaseViewController {
    fileprivate func assignResponderDelegate(_ responder: UIView) {
        if let textField = responder as? UITextField {
            textField.delegate = self as? UITextFieldDelegate
        }
    }
    
    // Нумерация объектов, которые могут становиться firstResponder
    // Пронумеровав объекты, можно перемещаться между ними, с помощью кнопки Next
    fileprivate func numberFirstResponders() {
        var index = 0
        
        // Ищем все элементы, которые могут быть firstResponder
        let responders = views(in: view, withFilter: isCanBecomeFirstResponder)
        for responder in responders {
            assignResponderDelegate(responder)
            responder.tag = index
            index += 1
        }
    }
}
