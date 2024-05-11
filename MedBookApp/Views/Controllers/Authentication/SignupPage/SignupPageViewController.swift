//
//  SignupPageViewController.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class SignupPageViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: SignupPageViewModel
    private let signupPageView = SignupPageView()
    
    // MARK: - Initializers
    
    init(viewModel: SignupPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        signupPageView.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        signupPageView.signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        view.addSubview(signupPageView)
        signupPageView.fillSuperview()
        navigationController?.navigationBar.tintColor = .white
        // Set up picker data source and delegate
        signupPageView.countryPicker.dataSource = self
        signupPageView.countryPicker.delegate = self
        // Load default country if exists
        if let defaultCountry = viewModel.loadDefaultCountry() {
            // Select the default country in the picker
            if let defaultCountryIndex = viewModel.countries.firstIndex(of: defaultCountry) {
                signupPageView.countryPicker.selectRow(defaultCountryIndex, inComponent: 0, animated: false)
            }
        }
    }
    
    @objc func signInButtonTapped() {
        viewModel.singnInButtontapped()
    }
    
    @objc func signupButtonTapped() {
        guard let email = signupPageView.emailTextField.text, let password = signupPageView.passwordTextField.text else {
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
        if !viewModel.isValidUser(email: email, password: password) {
            // Handle case where user with the provided email already exists
            showAlert(message: "User with this email already exists")
            return
        }
        viewModel.singnOutButtontapped()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource

extension SignupPageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Only one column for countries
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = viewModel.countries[row]
        viewModel.setDefaultCountry(selectedCountry)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let title = viewModel.countries[row]
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return attributedTitle
    }
    
}
