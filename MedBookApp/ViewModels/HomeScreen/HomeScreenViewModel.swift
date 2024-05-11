//
//  HomeScreenViewModel.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 30/03/24.
//

import UIKit
import RealmSwift

protocol HomeScreenViewModelDelegate: AnyObject {
    func homeCardModelUpdated()
    func loadMoreDataIfNeeded(currentIndex: Int)
    func didTapSignOutButton()
    func didTapHeaderBookmarkButton()
}

protocol HomeScreenViewModelInput {
    func bookmarkBook(with bookmarkedBook: BookmarkedBookModel)
}

protocol HomeScreenViewModelOut {
    var homeCardModel: [HomeScreenCardModel] { get }
    func searchBooks(query: String?)
}

protocol HomeScreenRouting: AnyObject {
    func routingToSignOutScreen()
    func routingToBookmarkScreen()
}

class HomeScreenViewModel: HomeScreenViewModelOut, HomeScreenViewModelInput {
    
    private let apiService: GetBooksService
    private var currentPage = 0
    private var currentOffset = 0
    private let router: HomeScreenRouting
    var searchResults: [Book] = []
    var homeCardModel: [HomeScreenCardModel] = []
    weak var delegate: HomeScreenViewModelDelegate?
    
    init(apiService: GetBooksService = GetBooksService(),
         router: HomeScreenRouting) {
        self.apiService = apiService
        self.router = router
    }
    
    func searchBooks(query: String?) {
        guard let searchText = query?.lowercased(), (query != nil) else {
            // If search text is empty, show all books
            delegate?.homeCardModelUpdated()
            return
        }
        searchBooksDetails(query: searchText)
    }
    
    func searchBooksDetails(query: String) {
        apiService.searchBooks(query: query, limit: 10, offset: currentOffset) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                debugPrint("response: \(response)++")
                self.searchResults = response.docs
                self.currentPage += 1
                self.currentOffset = self.currentPage * 10
                self.getHomeCardDetails()
            case .failure(let error):
                debugPrint("\(error)")
            }
        }
    }
    
    func loadMoreDataIfNeeded(currentIndex: Int) {
        // Load more data when the user scrolls to the end of the table view
        // Check if the current index is close to the end of the data array
        let threshold = 5
        let totalCount = searchResults.count
        if currentIndex >= totalCount - threshold {
            self.delegate?.homeCardModelUpdated()
        }
    }
    
    func getHomeCardDetails() {
        let dispatchGroup = DispatchGroup()
        for book in searchResults {
            if let coverImageURL = URL(string: "https://covers.openlibrary.org/b/id/\(book.cover_i ?? "0")-M.jpg") {
                dispatchGroup.enter()
                fetchCoverImage(for: book, from: coverImageURL) { [weak self] image in
                    guard let self = self else { return }
                    let homeCard = HomeScreenCardModel(title: book.title,
                                                       ratingsAverage: book.ratings_average ?? 0.0,
                                                       ratings_count: book.ratings_count,
                                                       author_name: book.author_name,
                                                       coverImage: image)
                    DispatchQueue.main.async {
                        self.homeCardModel.append(homeCard)
                        dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.delegate?.homeCardModelUpdated() // Notify the view controller that homeCardModel is ready
            }
        }
    }
    
    func fetchCoverImage(for book: Book, from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func didTapSignOutButton() {
        // Reset login status
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        router.routingToSignOutScreen()
    }
    
    func bookmarkBook(with bookmarkedBook: BookmarkedBookModel) {
        // Check if the book is already bookmarked
        if !isBookAlreadyBookmarked(bookmarkedBook: bookmarkedBook) {
            // Save the bookmarked book to the local Realm database
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(bookmarkedBook)
                }
            } catch {
                print("Error saving bookmarked book to Realm: \(error)")
            }
        }
    }
    
    func isBookAlreadyBookmarked(bookmarkedBook: BookmarkedBookModel) -> Bool {
        // Get all bookmarked books from Realm
        do {
            let realm = try Realm()
            let bookmarkedBooks = realm.objects(BookmarkedBookModel.self)
            // Check if the provided book's identifier already exists in the bookmarked books
            return bookmarkedBooks.contains { $0.title == bookmarkedBook.title }
        } catch {
            print("Error fetching bookmarked books from Realm: \(error)")
            return false
        }
    }
    
    func didTapHeaderBookmarkButton() {
        router.routingToBookmarkScreen()
    }
    
}
