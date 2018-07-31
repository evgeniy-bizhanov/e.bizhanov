//
//  Представление формы регистрации RegisterView.swift
//

import UIKit

final class RegisterView: UINibView {
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var creditCard: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
}
