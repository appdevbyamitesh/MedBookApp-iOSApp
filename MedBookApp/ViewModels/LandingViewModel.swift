//
//  LandingViewModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

protocol LandingViewModelInput {
    func signupButtonTapped()
    func loginButtonTapped()
}

protocol LandingRouting: AnyObject {
    func routingToSignup()
    func routingToLogin()
}

class LandingViewModel: LandingViewModelInput {
    
    private var routing: LandingRouting
    
    init(routing: LandingRouting) {
        self.routing = routing
    }
    
    func signupButtonTapped() {
        routing.routingToSignup()
    }
    
    func loginButtonTapped() {
        routing.routingToLogin()
    }
    
}
