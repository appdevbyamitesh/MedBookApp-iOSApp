//
//  MainCoordinator.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class MainCoordinator: LandingRouting, LoginPageRoutingLogic, HomeScreenRouting, SignupPageRoutingLogic, BookmarkScreenRoutingLogic {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let landingViewController = ViewControllerAssembly.makeLandingViewController(coordinator: self, router: self)
        navigationController.pushViewController(landingViewController, animated: false)
    }
    
    func routingToSignup() {
        let signupViewController = ViewControllerAssembly.makeSignupViewController(router: self)
        navigationController.pushViewController(signupViewController, animated: true)
    }
    
    func routingToLogin() {
        let loginViewController = ViewControllerAssembly.makeLoginViewController(router: self)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func routingToHomeScreen() {
        let loginViewController = ViewControllerAssembly.makeHomeViewController(router: self)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func routingToSignOutScreen() {
        let landingViewController = ViewControllerAssembly.makeLandingViewController(coordinator: self, router: self)
        navigationController.pushViewController(landingViewController, animated: false)
    }
    
    func routingToSignUpScreen() {
        let signupViewController = ViewControllerAssembly.makeSignupViewController(router: self)
        navigationController.pushViewController(signupViewController, animated: true)
    }
    
    func routingToBookmarkScreen() {
        let bookmarkScreenController = ViewControllerAssembly.makeBookmarkScreenController(router: self)
        navigationController.pushViewController(bookmarkScreenController, animated: true)
    }
    
}
