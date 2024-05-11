//
//  SignupPageViewModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import Foundation
import RealmSwift

protocol SignupPageViewModelInput {
    func viewDidLoad()
    func setDefaultCountry(_ country: String)
    func saveUser(email: String, password: String)
    func singnOutButtontapped()
    func singnInButtontapped()
    func loadDefaultCountry() -> String?
}

protocol SignupPageViewModelOut {
    var countries: [String] { get }
    func isEmailValid(_ email: String) -> Bool
    func isPasswordValid(_ password: String) -> Bool
    func isValidUser(email: String, password: String) -> Bool
}

protocol SignupPageRoutingLogic: AnyObject {
    func routingToHomeScreen()
    func routingToLogin()
}

class SignupPageViewModel: SignupPageViewModelInput, SignupPageViewModelOut {
    
    private let countryService: CountryServiceProtocol
    var countries: [String] = []
    private let defaults = UserDefaults.standard
    private let defaultCountryKey = "DefaultCountry"
    private let router: SignupPageRoutingLogic
    
    init(countryService: CountryServiceProtocol,
         router: SignupPageRoutingLogic) {
        self.countryService = countryService
        self.router = router
    }
    
    func viewDidLoad() {
        fetchCountries()
        loadDefaultCountry()
    }
    
    func fetchCountries() {
        countryService.fetchCountries { result in
            switch result {
            case .success(let countries):
                self.countries = countries
            case .failure(let error):
                debugPrint("\(error)")
            }
        }
    }
    
    func setDefaultCountry(_ country: String) {
        defaults.set(country, forKey: defaultCountryKey)
    }
    
    func singnOutButtontapped() {
        router.routingToHomeScreen()
    }
    
    func singnInButtontapped() {
        router.routingToLogin()
    }
    
    func loadDefaultCountry() -> String? {
        if let defaultCountry = defaults.string(forKey: defaultCountryKey) {
            // Set the default country in the view or do any other required action
            print("Default Country Loaded: \(defaultCountry)")
            return defaultCountry
        } else {
            print("No default country found")
            return nil
        }
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
        let realm = try! Realm()
        // Check if a user with the given email already exists
        if let existingUser = realm.objects(User.self).filter("email == %@", email).first {
            // User with the same email already exists
            return false
        } else {
            // No user with the given email exists, proceed with saving the user
            saveUser(email: email, password: password)
            return true
        }
    }
    
    func saveUser(email: String, password: String) {
        let realm = try! Realm()
        // Check if a user with the given email already exists
        if realm.objects(User.self).filter("email == %@", email).isEmpty {
            // No user with the given email exists, proceed with saving the user
            do {
                try realm.write {
                    let user = User(email: email, password: password)
                    realm.add(user)
                }
            } catch {
                print("Error saving user: \(error)")
            }
        } else {
            print("User with email '\(email)' already exists")
        }
    }
        
}
