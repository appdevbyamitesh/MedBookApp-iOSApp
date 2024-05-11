//
//  LoginPageView.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class LoginPageView: UIView {
    
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
        label.text = "Login to continue"
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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .loginPage
        imageView.tintColor = .backgroundColor
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    private lazy var emailAndPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let loginButton: UIButton = {
        return Utilities().attributedButton(withText: "Login",
                                            andImageName: "arrow.right",
                                            backgroundColor: .backgroundColor)
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
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
        addSubview(imageView)
        imageView.anchor(top: emailAndPasswordStackView.bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingTop: 30)
        addSubview(loginButton)
        loginButton.anchor(left: leftAnchor,
                            bottom: safeAreaLayoutGuide.bottomAnchor,
                            right: rightAnchor,
                            paddingLeft: 40,
                            paddingBottom: 40,
                            paddingRight: 40)
        addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: leftAnchor,
                                     bottom: safeAreaLayoutGuide.bottomAnchor,
                                     right: rightAnchor,
                                     paddingLeft: 40,
                                     paddingRight: 40)
    }
    
}
