//
//  CountryService.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import Foundation

protocol CountryServiceProtocol {
    func fetchCountries(completion: @escaping (Result<[String], Error>) -> Void)
}

class CountryService: CountryServiceProtocol {
    func fetchCountries(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "https://api.first.org/data/v1/countries") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let countriesResponse = try JSONDecoder().decode(CountriesResponse.self, from: data)
                let countries = countriesResponse.data.values.map { $0.country }
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
