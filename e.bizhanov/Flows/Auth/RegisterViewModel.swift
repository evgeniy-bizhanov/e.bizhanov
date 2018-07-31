//
//  Описание модели представления для формы регистрации
//

import Bond
import ReactiveKit

enum Gender: String {
    case male = "m"
    case female = "f"
}

class RegisterViewModel {
    
    // MARK: - Properties
    
    let login = Observable<String?>(nil)
    let password = Observable<String?>(nil)
    let confirmPassword = Observable<String?>(nil)
    let email = Observable<String?>(nil)
    let creditCard = Observable<String?>(nil)
    let gender = Observable<Gender?>(nil)
    let isValid = Observable<Bool>(false)
    
    
    // MARK: - Functions
    
    func configure() {
        
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
    
    var model: AuthRequestFactory
    
    
    // MARK: - Initializers
    
    init(model: AuthRequestFactory) {
        self.model = model
        
        configure()
    }
}
