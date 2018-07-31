//
// Логика работы представления для формы входа
//

import Bond
import ReactiveKit

/// Модель представления для формы входа в магазин
final class LoginViewModel {
    // MARK: - Properties
    let login = Observable<String?>(nil)
    let password = Observable<String?>(nil)
    
    /// Флаг валидности модели, по описанным в модели правилам
    let isValid = Observable<Bool>(false)
    
    // MARK: - Functions
    func enter(completionHandler completion: @escaping () -> Void) {
        guard let login = login.value,
            let password = password.value else {
                return
        }
        
        service.login(userName: login, password: password) { response in
            if let value = response.value,
                value.result == 1 {
                
                completion()
            }
        }
    }
    
    // Настраивает логику проверки модели на корректность
    fileprivate func setupModelValidationRules() {
        
        // Здесь таки функторы как я понимаю + функция высшего порядка
        let loginIsValid = login.ignoreNil().map { $0 != "" }
        let passwordIsValid = password.ignoreNil().map { $0.count >= 4 }
        
        // Собираем общий флаг
        combineLatest(loginIsValid, passwordIsValid)
            .map { $0 && $1 }
            .bind(to: isValid)
    }
    
    // MARK: - Services
    private var service: AuthRequestFactory
    
    // MARK: - Initializers
    init(service: AuthRequestFactory) {
        self.service = service
        
        setupModelValidationRules()
    }
}
