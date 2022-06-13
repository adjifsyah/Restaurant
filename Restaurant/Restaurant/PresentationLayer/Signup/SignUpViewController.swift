//
//  SignUpViewController.swift
//  Instagram Clone
//
//  Created by Adji Firmansyah on 5/13/22.
//

import UIKit
import LocalAuthentication

class SignUpViewController: UIViewController {
    enum PasswordValidate: String, CaseIterable {
        case passwordMustGreaterThan
        case passwordMustBeMatch
    }
    
    // MARK: - LABEL -
    private lazy var emailError: UILabel = {
        var emailError = UILabel()
        emailError.font = .systemFont(ofSize: 12)
        emailError.textColor = .red
        return emailError
    }()
    private lazy var passwordError: UILabel = {
        var emailError = UILabel()
        emailError.font = .systemFont(ofSize: 12)
        emailError.textColor = .red
        return emailError
    }()
    
    private lazy var passwordVerifError: UILabel = {
        var emailError = UILabel()
        emailError.font = .systemFont(ofSize: 12)
        emailError.textColor = .red
        return emailError
    }()
    
    // MARK: - TextField -
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .secondarySystemBackground
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .label
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.addTarget(self, action: #selector(handleEmailChanged), for: .editingChanged)
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = .secondarySystemBackground
        tf.borderStyle = .roundedRect
        tf.textColor = .label
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handlePasswordChanged(textField:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var passwordVerificationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password Verification"
        tf.backgroundColor = .secondarySystemBackground
        tf.borderStyle = .roundedRect
        tf.textColor = .label
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handlePasswordVerification(textField:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - BUTTON -
    lazy var signupButton: UIButton = {
        var login = UIButton()
        login.setTitle("Sign up", for: .normal)
        login.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        login.titleLabel?.textColor = .white
        login.layer.cornerRadius = 4
        login.clipsToBounds = true
        login.backgroundColor = .systemBlue
        login.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        return login
    }()
    
    // MARK: - Stack View -
    lazy var separatorSV: UIStackView = {
        var separator = UIStackView()
        separator.axis = .horizontal
        separator.spacing = 8
        separator.distribution = .fill
        return separator
    }()
    
    lazy var textFieldSV: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var emailStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    private lazy var passwordStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var passwordVerifStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var centerStackView: UIStackView = {
        var center = UIStackView()
        center.translatesAutoresizingMaskIntoConstraints = false
        center.axis = .vertical
        center.spacing = 32
        
        return center
    }()
    
    let userDefault: UserDefaults = .standard
    var context = LAContext()
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        configureView()
        checkForValidForm()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setupConstraint()
    }
    
    private func addView() {
        
        emailStackView.addArrangedSubview(emailTextField)
        emailStackView.addArrangedSubview(emailError)
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordError)
        passwordVerifStackView.addArrangedSubview(passwordVerificationTextField)
        passwordVerifStackView.addArrangedSubview(passwordVerifError)

        centerStackView.addArrangedSubview(emailStackView)
        centerStackView.addArrangedSubview(passwordStackView)
        centerStackView.addArrangedSubview(passwordVerifStackView)
        centerStackView.addArrangedSubview(signupButton)
        
        view.addSubview(centerStackView)
        
    }
    
    private func configureView() {
        title = "Sign up"
    }
    
    @objc private func signupAction() {
        guard let emailTF = emailTextField.text,
              let passwordTF = passwordTextField.text,
              let _ = passwordVerificationTextField.text
        else { return }
        let restaurant = User(email: emailTF, password: passwordTF)
        let encode = try? JSONEncoder().encode(restaurant)
        userDefault.setValue(encode, forKey: "user")
        let isSuccessSave = (userDefault.value(forKey: "user")) != nil
        var authError: NSError?
        let reasonString = "To access the secure data"
        if isSuccessSave {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { (success, error) in
                    guard success else { return }
                    DispatchQueue.main.async {
                        let vc = RSTHomeTableViewController()
                        self.navigationController?.pushViewController(vc, animated: success)
                        vc.navigationItem.hidesBackButton = true
                    }
                }
            } else {
                let alert = UIAlertController(title: "Biometry unavailable",
                                              message: "Your device is not configured for biometric authentication.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
            
        } else {
            print("SAVE ERROR")
        }
    }
    
    @objc func handleEmailChanged(textField: UITextField) {
        guard let emailTF = textField.text else { return }
        
        let isValidEmail = validateEmail(emailStr: emailTF)
        if isValidEmail {
            emailError.isHidden = true
        } else {
            emailError.isHidden = false
            emailError.text = "Invalid email"
        }
        checkForValidForm()
    }
    
    @objc func handlePasswordChanged(textField: UITextField) {
        let isPasswordValid = textField.text?.count ?? 0 > 6
        
        if isPasswordValid {
            passwordError.isHidden = true
        } else {
            passwordError.text = "Password Error"
            passwordError.isHidden = false
        }
        checkForValidForm()
    }
    
    @objc func handlePasswordVerification(textField: UITextField) {
        let isPasswordValid = textField.text?.count ?? 0 > 6
        if isPasswordValid {
            passwordVerifError.isHidden = true
        } else {
            passwordVerifError.text = "Password Error"
            passwordVerifError.isHidden = false
        }
        if textField.text == passwordTextField.text {
            checkForValidForm()
        }
    }

    private func validateEmail(emailStr: String) -> Bool {
        let range = NSRange(location: 0, length: emailTextField.text?.count ?? 0)
        let regularExpress = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try! NSRegularExpression(pattern: regularExpress, options: .caseInsensitive)
        
        return (regex.firstMatch(in: emailStr, options: [], range: range) != nil)
    }
    
    private func checkForValidForm() {
        if emailError.isHidden && passwordError.isHidden && passwordVerifError.isHidden {
            signupButton.isEnabled = true
            signupButton.layer.opacity = 1
        } else {
            signupButton.layer.opacity = 0.5
            signupButton.isEnabled = false
        }
    }
    
    private func setupConstraint() {
        centerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        centerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
}
