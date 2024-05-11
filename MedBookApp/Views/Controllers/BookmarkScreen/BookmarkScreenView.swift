//
//  BookmarkScreenView.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 31/03/24.
//

import UIKit

class BookmarkScreenView: UIView {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       UIView(),
                                                       trailingImage])
        stackView.axis = .horizontal
        stackView.backgroundColor = .backgroundColor
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let trailingImage: UIImageView = {
        let img = UIImageView()
        img.image = .homeUnselected.withTintColor(.white)
        img.isUserInteractionEnabled = true
        img.setDimensions(width: 24, height: 24)
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bookmarked"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let tableView: UITableView = {
        let tV =  UITableView(frame: .zero, style: .plain)
        tV.separatorStyle = .singleLine
        tV.register(HomeScreenCardView.self, forCellReuseIdentifier: "BookMarkedCell")
        return tV
    }()
    
    var bookmarkedBooks: [BookmarkedBookModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(mainStackView)
        mainStackView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             left: leftAnchor,
                             right:rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 20,
                             paddingRight: 20)
        addSubview(tableView)
        tableView.anchor(top: titleLabel.bottomAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 20, // Adjust as needed
                         paddingLeft: 8,
                         paddingRight: 8)
    }
    
}

extension BookmarkScreenView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear // Make footer invisible for spacing
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkedCell", for: indexPath) as? HomeScreenCardView else {
            return UITableViewCell()
        }
        let bookmarkedBook = bookmarkedBooks[indexPath.row]
        if let imageData = bookmarkedBook.coverImageData, let coverImage = UIImage(data: imageData) {
            cell.configure(bookDetails: HomeScreenCardModel(title: bookmarkedBook.title,
                                                            ratingsAverage: bookmarkedBook.ratingsAverage,
                                                            ratings_count: bookmarkedBook.ratingsCount,
                                                            author_name: Array(bookmarkedBook.authorNames),
                                                            coverImage: coverImage))
        }
        return cell
    }
    
}
