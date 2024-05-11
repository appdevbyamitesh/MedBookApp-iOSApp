//
//  HomeScreenView.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

protocol HomeScreenViewDelegate: AnyObject {
    func didTapSignOutButton()
    func didChangeSearchQuery(_ query: String)
    func didTapHeaderBookmarkButton()
    func loadMoreDataIfNeeded(currentIndex: Int)
    func bookmarkButtonTapped(with bookmarkedBook: BookmarkedBookModel)
}

final class HomeScreenView: UIView {
    
    enum SortingType {
        
        case title
        case average
        case hits
        
    }
    
    // MARK: - Properties
    
    weak var delegate: HomeScreenViewDelegate?
    private var bookDetails: [HomeScreenCardModel] = []
    private var searchQuery: String?
    private var isBookmarked: Bool = false
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leadingStackView, trailingStackView])
        stackView.axis = .horizontal
        stackView.backgroundColor = .backgroundColor
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MedBook"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let leadingImage: UIImageView = {
        let img = UIImageView()
        img.image = .openBook.withTintColor(.white)
        img.setDimensions(width: 24, height: 24)
        return img
    }()
    
    private lazy var leadingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       leadingImage])
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let headerBookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .bookmark).withTintColor(.white), for: .normal)
        button.setDimensions(width: 24, height: 24)
        return button
    }()
    
    private let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = .black // Customize loader color
        loader.hidesWhenStopped = true
        return loader
    }()
    
    func showLoader() {
        loaderView.startAnimating()
    }
    
    func hideLoader() {
        loaderView.stopAnimating()
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Which topic interests you today?"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 2
        label.textColor = .black
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .bookmark).withTintColor(.white), for: .normal)
        button.setDimensions(width: 24, height: 24)
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .exit).withTintColor(.white), for: .normal)
        button.setDimensions(width: 24, height: 24)
        return button
    }()
    
    private lazy var trailingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerBookmarkButton, signOutButton])
        stackView.spacing = 8
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for books"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .customGray
        return searchBar
    }()
    
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tV =  UITableView(frame: .zero, style: .plain)
        tV.separatorStyle = .singleLine
        tV.register(HomeScreenCardView.self, forCellReuseIdentifier: "Cell")
        return tV
    }()
    
    let categories = ["Sort by: ", "Title", "Average", "Hits"]
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        categoryStackView.isHidden = bookDetails.isEmpty
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSwipeGesture()
    }
    
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .left
        addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard gestureRecognizer.direction == .right else { return }
        // Perform animations to reveal the bookmark button
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            addSubview(self.bookmarkButton)
            // Adjust the frame of the bookmark button according to your design
            self.bookmarkButton.frame = CGRect(x: self.frame.width - 60, y: 0,
                                               width: 60, height: self.frame.height)
        }
    }
    
    @objc private func headerBookmarkButtonTapped() {
        delegate?.didTapHeaderBookmarkButton()
    }
    
    func configure(bookDetails: [HomeScreenCardModel]) {
        categoryStackView.isHidden = bookDetails.isEmpty
        self.bookDetails = bookDetails
        tableView.reloadData()
    }
    
    private func setupViews() {
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        headerBookmarkButton.addTarget(self, action: #selector(headerBookmarkButtonTapped), for: .touchUpInside)
        addSubview(mainStackView)
        mainStackView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingRight: 8)
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: mainStackView.topAnchor,
                                left: leftAnchor,
                                right: rightAnchor,
                                paddingTop: 52,
                                paddingLeft: 8,
                                paddingRight: 8)
        addSubview(searchBar)
        searchBar.anchor(top: descriptionLabel.topAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingTop: 80,
                         paddingLeft: 8,
                         paddingRight: 8)
        addSubview(loaderView)
        loaderView.center(inView: self)
        addSubview(categoryStackView)
        setupCategoryStackViewContent()
        categoryStackView.anchor(top: searchBar.topAnchor,
                                 left: leftAnchor,
                                 right: rightAnchor,
                                 paddingTop: 60,
                                 paddingLeft: 8,
                                 paddingRight: 8)
        addSubview(tableView)
        tableView.anchor(top: categoryStackView.bottomAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 20, // Adjust as needed
                         paddingLeft: 8,
                         paddingRight: 8)
    }
    
    private func setupCategoryStackViewContent() {
        let totalSpacing = CGFloat(categories.count - 1) * 20 // 20 is the original spacing
        // Calculate the available width for each label
        let labelWidth = (frame.width - totalSpacing) / CGFloat(categories.count)
        for (index, category) in categories.enumerated() {
            let categoryLabel = UILabel()
            categoryLabel.text = category
            let categoryView = UIView()
            // Add long press gesture recognizer to labels
            categoryLabel.isUserInteractionEnabled = true
            categoryView.addSubview(categoryLabel)
            categoryLabel.anchor(top: categoryView.topAnchor,
                                 left: categoryView.leftAnchor,
                                 bottom: categoryView.bottomAnchor,
                                 right: categoryView.rightAnchor,
                                 paddingTop: 8,
                                 paddingLeft: 8,
                                 paddingBottom: 8,
                                 paddingRight: 8)
            categoryView.tag = index
            // Add tap gesture recognizer to clickable categories
            if index > 0 {
                categoryView.isUserInteractionEnabled = true
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(categoryTapped(_:)))
                categoryView.addGestureRecognizer(tapGestureRecognizer)
            }
            categoryStackView.addArrangedSubview(categoryView)
            // Set width constraint for each category label
            categoryView.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        }
    }
    
    @objc func categoryTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        if index < categories.count {
            // Iterate through all category views and reset their appearance
            for view in categoryStackView.arrangedSubviews {
                if let categoryView = view as? UIView, let categoryLabel = categoryView.subviews.first as? UILabel {
                    categoryView.backgroundColor = .clear
                    categoryLabel.textColor = .black
                    categoryView.layer.cornerRadius = 0
                }
            }
            let selectedCategory = categories[index]
            // Apply Sorting
            switch selectedCategory {
            case "Title":
                sortBooks(by: .title)
            case "Average":
                sortBooks(by: .average)
            case "Hits":
                sortBooks(by: .hits)
            default:
                break
            }
            // Update the appearance of the tapped category label
            if let categoryView = sender.view, let categoryLabel = categoryView.subviews.first as? UILabel {
                categoryView.backgroundColor = .customGray // Change to your desired background color
                categoryLabel.textColor = .black // Change to your desired text color
                categoryView.layer.cornerRadius = categoryLabel.frame.height / 2
            }
        }
    }
    
    private func sortBooks(by sortingType: SortingType) {
        switch sortingType {
        case .title:
            bookDetails.sort { $0.title < $1.title }
        case .average:
            bookDetails.sort { $0.ratingsAverage < $1.ratingsAverage }
        case .hits:
            bookDetails.sort { $0.ratings_count > $1.ratings_count }
        }
        tableView.reloadData()
    }
    
    @objc func signOutButtonTapped() {
        delegate?.didTapSignOutButton()
    }
    
}

// MARK: - UITableViewDataSource

extension HomeScreenView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookDetails.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear // Make footer invisible for spacing
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0 // Desired spacing between cells within a section (adjust as needed)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HomeScreenCardView else { return UITableViewCell() }
        // Check if indexPath.row is within bounds of bookDetails array
        guard indexPath.row < bookDetails.count else {
            return cell // Return empty cell if index is out of bounds
        }
        let bookDetail = bookDetails[indexPath.row]
        cell.configure(bookDetails: bookDetail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookmarkAction = UIContextualAction(style: .normal, title: "Bookmark") { [weak self] (_, _, completionHandler) in
            // Toggle bookmark status or perform any other bookmark action
            self?.toggleBookmarkStatus(forRowAt: indexPath)
            completionHandler(true)
        }
        bookmarkAction.image = UIImage(systemName: "bookmark")?.withTintColor(.white)
        bookmarkAction.backgroundColor = .backgroundColor
        return UISwipeActionsConfiguration(actions: [bookmarkAction])
    }
    
    private func toggleBookmarkStatus(forRowAt indexPath: IndexPath) {
        isBookmarked.toggle()
        if isBookmarked {
            guard indexPath.row < bookDetails.count else {
                // Index out of bounds
                return
            }
            let book = bookDetails[indexPath.row ]
            let bookmarkedBook = BookmarkedBookModel()
            bookmarkedBook.title = book.title
            bookmarkedBook.ratingsAverage = book.ratingsAverage
            bookmarkedBook.ratingsCount = book.ratings_count
            bookmarkedBook.authorNames.append(objectsIn: book.author_name)
            if let imageData = book.coverImage?.jpegData(compressionQuality: 1.0) {
                bookmarkedBook.coverImageData = imageData
            }
            delegate?.bookmarkButtonTapped(with: bookmarkedBook)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

// MARK: - UITableViewDataSource

extension HomeScreenView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            searchQuery = searchText.count >= 3 ? searchText : nil
            delegate?.didChangeSearchQuery(searchText)
        } else {
            // Clear the existing list of books or show a message indicating that the user needs to enter at least 3 characters
            bookDetails.removeAll()
            tableView.reloadData()
            categoryStackView.isHidden = true
        }
    }
    
}

// MARK: - UIScrollViewDelegate

extension HomeScreenView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Detect when the user scrolls to the end of the table view
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        let currentIndex = Int(offsetY + screenHeight)
        if CGFloat(currentIndex) >= contentHeight {
            // User has scrolled to the end, load more data
            delegate?.loadMoreDataIfNeeded(currentIndex: currentIndex)
        }
    }
    
}
