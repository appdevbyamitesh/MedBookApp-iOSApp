//
//  GetBooksServiceProtocol.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 30/03/24.
//

import UIKit

protocol GetBooksServiceProtocol {
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}
