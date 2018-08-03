//
//  Тестирует UI регистрации и авторизации пользователей
//

import XCTest

class AuthUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Тестирует результат успешной авторизации
    func testEnterSuccess() {
        enterAuthData(login: "username", password: "password")
        
        app.buttons["enter"].tap()
        
        let controller = app.navigationBars["Каталог"]
        XCTAssertNotNil(controller)
    }
    
    // Тестирует поведение кнопки при положительной валидации модели
    func testModelValidationSuccess() {
        enterAuthData(login: "username", password: "password")
        
        let enter = app.buttons["enter"]
        XCTAssertTrue(enter.isEnabled)
    }
    
    // Тестирует поведение кнопки при отрицательной валидации модели
    func testModelValidationFails() {
        enterAuthData(login: "username", password: "pas")
        
        let enter = app.buttons["enter"]
        XCTAssertFalse(enter.isEnabled)
    }
    
    // Тестирует корректность навигации между экранами авторизации и регистрации
    func testAuthNavigationSuccess() {
        
        app.buttons["register"].tap()
        
        let register = app.staticTexts["header"]
        XCTAssertNotNil(register)
        XCTAssertEqual(register.label, "Зарегистрируйтесь")
        
        app.buttons["login"].tap()
        
        let login = app.staticTexts["header"]
        XCTAssertNotNil(login)
        XCTAssertEqual(login.label, "Добро пожаловать")
    }
    
    // Вводит данные в поля авторизации
    fileprivate func enterAuthData(login: String, password: String) {
        let loginField = app.textFields["login"]
        let passwordField = app.secureTextFields["password"]
        
        loginField.tap()
        loginField.typeText(login)
        
        passwordField.tap()
        passwordField.typeText(password)
        
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
