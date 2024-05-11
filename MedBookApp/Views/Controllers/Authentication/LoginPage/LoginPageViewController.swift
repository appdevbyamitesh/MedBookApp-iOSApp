//
//  LoginPageViewController.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: LoginPageViewModel
    private let loginPageView = LoginPageView()
    
    // MARK: - Initializers
    
    init(viewModel: LoginPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPageView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginPageView.dontHaveAccountButton.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)

        view.addSubview(loginPageView)
        loginPageView.fillSuperview()
        // Set navigation bar back button color to white
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func handleShowSignUp() {
        viewModel.handleShowSignUp()
    }
    
    @objc func loginButtonTapped() {
        guard let email = loginPageView.emailTextField.text, let password = loginPageView.passwordTextField.text else {
            return
        }
        
        if !viewModel.isEmailValid(email) {
            // Handle invalid email format
            showAlert(message: "Invalid email format")
            return
        }
        
        if !viewModel.isPasswordValid(password) {
            // Handle invalid password format
            showAlert(message: "Invalid password format")
            return
        }
        
        debugPrint("\(!viewModel.isValidUser(email: email, password: password))++")
        
        if !viewModel.isValidUser(email: email, password: password) {
            // Handle invalid credentials
            showAlert(message: "Invalid email or password")
            return
        }
        viewModel.login()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


