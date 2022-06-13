//
//  LoginViewController.swift
//  Instagram Clone
//
//  Created by Adji Firmansyah on 5/20/22.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    private lazy var signupLabel: UILabel = {
        var signup = UILabel()
        signup.text = "Don't have an account?"
        signup.font = .systemFont(ofSize: 12)
        signup.textColor = .systemGray2
        return signup
    }()
    
    private lazy var signupButton: UIButton = {
        var signup = UIButton()
        signup.setTitle("SignUp", for: .normal)
        signup.setTitleColor(.systemBlue, for: .normal)
        signup.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        signup.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        return signup
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var separator: UIView = {
        var separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }()
    // MARK: - StackView
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
    
    // MARK: - Stack View -
    
    private lazy var stackViewTextField: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var signupStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    private lazy var bottomStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
        checkForValidForm()

        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        AddSubView()
        setupConstraint()
    }
    
    private func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func AddSubView() {
        view.addSubview(stackViewTextField)
        view.addSubview(loginButton)
        view.addSubview(bottomStackView)
        
        emailStackView.addArrangedSubview(emailTextField)
        emailStackView.addArrangedSubview(emailError)
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordError)
        
        stackViewTextField.addArrangedSubview(emailStackView)
        stackViewTextField.addArrangedSubview(passwordStackView)
        
        signupStackView.addArrangedSubview(signupLabel)
        signupStackView.addArrangedSubview(signupButton)
        
        bottomStackView.addArrangedSubview(separator)
        bottomStackView.addArrangedSubview(signupStackView)
    }
    
    private func configureView() {
        title = "Sign In"
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
        let tapColor: UIColor = .systemBlue
        let clear: UIColor = .clear
        if passwordTextField.isEditing {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = tapColor.cgColor
        } else {
            passwordTextField.layer.borderWidth = 0
            passwordTextField.layer.borderColor = clear.cgColor
        }
        let isPasswordValid = passwordTextField.text?.count ?? 0 > 6
        
        if isPasswordValid {
            
            passwordError.isHidden = true
        } else {
            passwordError.text = "Password Error"
            passwordError.isHidden = false
        }
        checkForValidForm()
    }
    
    @objc func handleLogin() {
//        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
    }
    
    private func validateEmail(emailStr: String) -> Bool {
        let range = NSRange(location: 0, length: emailTextField.text?.count ?? 0)
        let regularExpress = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try! NSRegularExpression(pattern: regularExpress, options: .caseInsensitive)
        
        return (regex.firstMatch(in: emailStr, options: [], range: range) != nil)
    }
    
    private func checkForValidForm() {
        if emailError.isHidden && passwordError.isHidden {
            
            loginButton.isEnabled = true
            loginButton.layer.opacity = 1
        } else {
            loginButton.layer.opacity = 0.5
            loginButton.isEnabled = false
        }
    }
    
    @objc private func signupAction() {
        let vc = SignUpViewController()
        let _ = UINavigationController(rootViewController: vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupConstraint() {
        stackViewTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackViewTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        stackViewTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: stackViewTextField.bottomAnchor, constant: 32).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        separator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleLogin()
        return true
    }
}
