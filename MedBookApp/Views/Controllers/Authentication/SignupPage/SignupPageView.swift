//
//  SignupPageView.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class SignupPageView: UIView {
    
    // MARK: - Properties
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to MedBook 📖"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Signup to continue"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Email")
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var emailAndPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let signupButton: UIButton = {
        return Utilities().attributedButton(withText: "Let's go",
                                            andImageName: "arrow.right",
                                            backgroundColor: .backgroundColor)
    }()
    
    let tickBoxStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    let countryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tintColor = .white
        return picker
    }()
    
    let signInButton: UIButton = {
        let button = Utilities().attributedButton("Have an account? ", "Sign In")
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    
    private func setUpLayout() {
        addSubview(welcomeLabel)
        welcomeLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 32,
                            paddingLeft: 32,
                            paddingRight: 32)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: welcomeLabel.bottomAnchor,
                                left: leftAnchor,
                                right: rightAnchor,
                                paddingTop: 8,
                                paddingLeft: 32,
                                paddingRight: 32)
        
        addSubview(emailAndPasswordStackView)
        emailAndPasswordStackView.anchor(top: descriptionLabel.bottomAnchor,
                                         left: leftAnchor,
                                         right: rightAnchor,
                                         paddingTop: 32,
                                         paddingLeft: 32,
                                         paddingRight: 32)
        
        addSubview(tickBoxStackView)
        tickBoxStackView.anchor(top: emailAndPasswordStackView.bottomAnchor,
                                left: leftAnchor,
                                right: rightAnchor,
                                paddingTop: 24,
                                paddingLeft: 32,
                                paddingRight: 32)
        addTickBox(withText: "At least 8 Characters")
        addTickBox(withText: "Must Conatain an uppercase letetr")
        addTickBox(withText: "Conatins a special character")
        addTickBox(withText: "Contains at least 1 digit")
        addSubview(countryPicker)
        countryPicker.anchor(top: tickBoxStackView.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: 40,
                             paddingLeft: 32,
                             paddingBottom: 32,
                             paddingRight: 32)
        
        addSubview(signupButton)
        signupButton.anchor(left: leftAnchor,
                            bottom: safeAreaLayoutGuide.bottomAnchor,
                            right: rightAnchor,
                            paddingLeft: 40,
                            paddingBottom: 40,
                            paddingRight: 40)
        addSubview(signInButton)
        signInButton.anchor(left: leftAnchor,
                          bottom: safeAreaLayoutGuide.bottomAnchor,
                          right: rightAnchor,
                          paddingLeft: 40,
                          paddingRight: 40)
    }
    
    // MARK: - Helper Methods
    
    func addTickBox(withText text: String) {
        let tickBox = UIButton(type: .system)
        tickBox.setImage(UIImage(named: "icons8-unchecked-checkbox-50"), for: .normal)
        tickBox.tintColor = .white
        tickBox.setDimensions(width: 24, height: 24)
        
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        
        let hStack = UIStackView(arrangedSubviews: [tickBox, label])
        hStack.spacing = 8
        hStack.alignment = .center
        tickBoxStackView.addArrangedSubview(hStack)
    }
    
}
