//
//  UserAuthenticationData.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import RealmSwift

class User: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
