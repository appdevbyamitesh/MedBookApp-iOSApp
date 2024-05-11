//
//  BookmarkScreenViewModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 31/03/24.
//

import Foundation
import RealmSwift

protocol BookmarkScreenViewModelDelegate: AnyObject {
    func bookmarkedBooksUpdated()
}

protocol BookmarkScreenViewModelInput {
    func homeButtonTapped()
}

protocol BookmarkScreenViewModelOut {
    var bookmarkedBooks: [BookmarkedBookModel] { get }
}

protocol BookmarkScreenRoutingLogic: AnyObject {
    func routingToHomeScreen()
}

class BookmarkScreenViewModel: BookmarkScreenViewModelOut, BookmarkScreenViewModelInput {
    
    var bookmarkedBooks: [BookmarkedBookModel] = []
    weak var delegate: BookmarkScreenViewModelDelegate?
    private let router: BookmarkScreenRoutingLogic
    
    init(router: BookmarkScreenRoutingLogic) {
        self.router = router
    }
    
    func viewDidLoad() {
        fetchBookmarkedBooks()
    }
    
    func fetchBookmarkedBooks() {
        do {
            let realm = try Realm()
            let bookmarkedBooks = realm.objects(BookmarkedBookModel.self)
            self.bookmarkedBooks = Array(bookmarkedBooks)
            delegate?.bookmarkedBooksUpdated() // Notify the delegate about the update
        } catch {
            print("Error fetching bookmarked books: \(error)")
        }
    }
    
    func homeButtonTapped() {
        router.routingToHomeScreen()
    }
    
}
