//
//  CountriesResponse.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

struct CountriesResponse: Decodable {
    let data: [String: Country]
}

struct Country: Decodable {
    let country: String
    let region: String
}
