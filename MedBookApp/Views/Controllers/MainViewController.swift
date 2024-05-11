//
//  LandingViewController.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 28/03/24.
//

import UIKit

class LandingViewController: UIViewController {
    
    // MARK: - Properties
    
    let gradientLayer = CAGradientLayer()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MedBook"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .manReading
        imageView.tintColor = .backgroundColor
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .backgroundColor
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .backgroundColor
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var signupAndLoginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signupButton, loginButton])
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
        setUpLayout()
        setDescriptionText()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Helpers
    
    func setUpLayout() {
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  paddingTop: 40,
                                  paddingLeft: 20,
                                  paddingRight: 20)
        view.addSubview(imageView)
        imageView.anchor(top: titleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20)
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: imageView.bottomAnchor,
                                left: view.leftAnchor,
                                right: view.rightAnchor,
                                paddingTop: 20,
                                paddingLeft: 20,
                                paddingRight: 20)
        view.addSubview(signupAndLoginStackView)
        signupAndLoginStackView.anchor(left: view.leftAnchor,
                                       bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                       right: view.rightAnchor,
                                       paddingLeft: 40,
                                       paddingBottom: 40,
                                       paddingRight: 40)
    }
    
    func setUpBackground() {
        let backgroundColor = UIColor.backgroundColor.cgColor
        let whiteColor = UIColor.customGray.cgColor
        gradientLayer.colors = [backgroundColor, backgroundColor, whiteColor, whiteColor]
        gradientLayer.locations = [0, 0.8, 0.8, 1]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setDescriptionText() {
        let descriptionText = "Discover, Explore, and Journey into the world of Books!"
        descriptionLabel.text = descriptionText
    }
    
    @objc func signupButtonTapped() {
        
    }
    
    @objc func loginButtonTapped() {
        
    }
    
}
