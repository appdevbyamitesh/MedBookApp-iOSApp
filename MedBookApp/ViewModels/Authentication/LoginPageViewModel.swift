//
//  LoginPageViewModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import Foundation
import RealmSwift

protocol LoginPageViewModelInput {
    func login()
    func handleShowSignUp()
}

protocol LoginPageViewModelOut {
    func isValidUser(email: String, password: String) -> Bool
    func isEmailValid(_ email: String) -> Bool
    func isPasswordValid(_ password: String) -> Bool 
}

protocol LoginPageRoutingLogic: AnyObject {
    func routingToHomeScreen()
    func routingToSignUpScreen()
}

class LoginPageViewModel: LoginPageViewModelInput, LoginPageViewModelOut {
    
    private let router: LoginPageRoutingLogic
    
    init(router: LoginPageRoutingLogic) {
        self.router = router
    }
    
    func login() {
        router.routingToHomeScreen()
    }
    
    func handleShowSignUp() {
        router.routingToSignUpScreen()
    }
    
    func isEmailValid(_ email: String) -> Bool {
        // Regular expression for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        // Regular expression for password validation
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidUser(email: String, password: String) -> Bool {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self).filter("email = %@", email)
            guard let user = users.first else { return false }
            return user.password == password
        } catch {
            print("Error accessing Realm database: \(error)")
            return false
        }
    }
    
}

