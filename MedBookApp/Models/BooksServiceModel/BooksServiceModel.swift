//
//  BooksServiceModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 30/03/24.
//

import Foundation

struct BooksServiceModel: Decodable {
    
    let docs: [Book]
    
}

struct Book: Decodable {
    
    let title: String
    let ratings_average: Double?
    let ratings_count: Int
    let author_name: [String]
    let cover_i: String? // Make cover_i optional
    
    private enum CodingKeys: String, CodingKey {
        case title
        case ratings_average
        case ratings_count
        case author_name
        case cover_i
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        ratings_average = try container.decodeIfPresent(Double.self, forKey: .ratings_average)
        ratings_count = try container.decode(Int.self, forKey: .ratings_count)
        author_name = try container.decode([String].self, forKey: .author_name)
        
        // Decode cover_i as a String if available, otherwise decode as Int and convert to String
        if let cover_iString = try? container.decode(String.self, forKey: .cover_i) {
            cover_i = cover_iString
        } else if let cover_iInt = try? container.decode(Int.self, forKey: .cover_i) {
            cover_i = String(cover_iInt)
        } else {
            cover_i = nil
        }
    }
    
}

