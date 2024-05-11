//
//  GetBooksService.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 30/03/24.
//

import UIKit

struct GetBooksService {
    
    private let networkService: GetBooksServiceProtocol
    
    init(networkService: GetBooksServiceProtocol = URLSession.shared) {
        self.networkService = networkService
    }
    
    func searchBooks(query: String, limit: Int, offset: Int, completion: @escaping (Result<BooksServiceModel, Error>) -> Void) {
        let urlString = "https://openlibrary.org/search.json?title=\(query)&limit=\(limit)&offset=\(offset)"
        debugPrint("urlString: \(urlString)++")
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        networkService.fetchData(url: url, completion: completion)
    }
    
}

extension URLSession: GetBooksServiceProtocol {
    
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        dataTask(with: url) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                debugPrint("Error: Invalid response or network error")
                if let error = error {
                    debugPrint("Network error: \(error)")
                }
                completion(.failure(error ?? NetworkError.invalidResponse))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                debugPrint("Error decoding data: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
}
