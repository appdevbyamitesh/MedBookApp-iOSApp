//
//  BookmarkedBookModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 31/03/24.
//

import UIKit
import RealmSwift

class BookmarkedBookModel: Object {
    
    @Persisted var title: String
    @Persisted var ratingsAverage: Double
    @Persisted var ratingsCount: Int
    @Persisted var authorNames: List<String>
    @Persisted var coverImageData: Data?
    
}
