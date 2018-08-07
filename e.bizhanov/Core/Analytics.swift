//
//  Аналитика
//

import Crashlytics
import Foundation

/// События сбора аналитики
enum AnalyticsEvent {
    enum SignupMethod: String {
        case password
        case external
    }
    
    enum LoginMethod: String {
        case password
        case external
        case `default`
    }
    
    case signup(method: SignupMethod, success: Bool)
    case login(method: LoginMethod, success: Bool)
    case logout
    case addToCart(
        price: Decimal,
        currency: String,
        name: String,
        type: String,
        id: String
    )
    case purchase(
        price: Decimal,
        currency: String,
        success: Bool,
        name: String,
        type: String,
        id: String
    )
    case custom(name: String, attributes: [String: Any]?)
}

/// Предоставляет возможность трекинга событий приложения
protocol Trackable {
    /// Отследить событие
    ///
    /// - Parameter event: Событие которое необходимо отследить из перечисления `AnalyticsEvent`
    func track(_ event: AnalyticsEvent)
}

extension Trackable {
    func track(_ event: AnalyticsEvent) {
        switch event {
        case let .signup(method, success):
            let success = NSNumber(value: success)
            Answers.logSignUp(withMethod: method.rawValue, success: success, customAttributes: nil)
            
        case let .login(method, success):
            let success = NSNumber(value: success)
            Answers.logLogin(withMethod: method.rawValue, success: success, customAttributes: nil)
            
        case .logout:
            Answers.logCustomEvent(withName: "default", customAttributes: nil)
            
        case let .addToCart(price, currency, name, type, id):
            let price = NSDecimalNumber(decimal: price)
            Answers.logAddToCart(
                withPrice: price,
                currency: currency,
                itemName: name,
                itemType: type,
                itemId: id,
                customAttributes: nil
            )

        case let .purchase(price, currency, success, name, type, id):
            let price = NSDecimalNumber(decimal: price)
            let success = NSNumber(value: success)
            Answers.logPurchase(
                withPrice: price,
                currency: currency,
                success: success,
                itemName: name,
                itemType: type,
                itemId: id,
                customAttributes: nil
            )
            
        case let .custom(name, attributes):
            Answers.logCustomEvent(withName: name, customAttributes: attributes)
        }
        
    }
}

// MARK: - Assertion failure
/**
 Указывает в каком файле и в какой строке произошла ошибка
 
 - Attention: Переопределенный метод.
 
 - Parameters:
   - message: Сообщение об ошибке
   - file: Файл в котором произошла ошибка
   - line: Строка которая вызвала исключение
 */
func assertionFailure(
    _ message: String,
    file: StaticString = #file,
    line: UInt = #line) {
    
    #if DEBUG
        Swift.assertionFailure(message, file: file, line: line)
    #else
        Answers.logCustomEvent(
            withName: "assertionFailure",
            customAttributes: [
                "message": message,
                "file": file,
                "line": line
            ])
    #endif
}
