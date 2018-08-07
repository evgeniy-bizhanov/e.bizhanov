//
//  Описание модели представления для формы регистрации
//

import Bond
import ReactiveKit

enum Gender: String {
    case male = "m"
    case female = "f"
}

/// ViewModel для формы регистрации
final class RegisterViewModel: Trackable {
    
    // MARK: - Properties
    
    /// Логин
    let login = Observable<String?>(nil)
    
    /// Пароль
    let password = Observable<String?>(nil)
    
    /// Подтверждение пароля
    let confirmPassword = Observable<String?>(nil)
    
    /// Эл. почта
    let email = Observable<String?>(nil)
    
    /// Кредитная карта
    let creditCard = Observable<String?>(nil)
    
    /// Пол
    let gender = Observable<Gender?>(nil)
    
    /// Модель валидна и готова к отправке на сервер
    let isValid = Observable<Bool>(false)
    
    
    // MARK: - Functions
    
    /// Регистрирует пользователя с текущими параметрами модели
    func register() {
        
        guard
            let login = login.value,
            let password = password.value,
            let email = email.value else {
                assertionFailure("Поля формы не должны быть пустыми")
                
                // TODO: Вернуть ошибку и показать сообщение пользователю
                
                return
        }
        
        let userData = UserData(
            id: 0,
            username: login,
            password: password,
            email: email,
            gender: "",
            creditCard: "",
            bio: ""
        )
        
        service.register(userData: userData) { [weak self] response in
            guard let `self` = self else {
                return
            }
            
            let success = response.value?.result == 1
            self.track(.signup(method: .password, success: success))
        }
    }
    
    /// Настраивает правила, по которым проверяется модель на корректность
    private func configureValidationRules() {
        
        // логин не пустой
        let loginIsGood = login.ignoreNil().map { $0 != "" }
        
        // Пароль не пустой, больше 4 символов и равен паролю подтверждения
        let passwordIsGood = password.ignoreNil().map { $0.count >= 4 }
        let passwordIsConfirmed = combineLatest(password, confirmPassword).map { $0 == $1 }
        
        combineLatest(
            loginIsGood,
            passwordIsGood,
            passwordIsConfirmed)
        .map { $0 && $1 && $2 }
        .bind(to: isValid)
    }
    
    
    // MARK: - Services
    
    private var service: AuthRequestFactory
    
    
    // MARK: - Initializers
    
    init(service: AuthRequestFactory) {
        self.service = service
        
        configureValidationRules()
    }
}
