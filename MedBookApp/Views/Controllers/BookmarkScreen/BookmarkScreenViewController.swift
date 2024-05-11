//
//  BookmarkScreenViewController.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 31/03/24.
//

import UIKit

class BookmarkScreenViewController: UIViewController, BookmarkScreenViewModelDelegate {
    
    private let bookmarkScreenView = BookmarkScreenView()
    private let viewModel: BookmarkScreenViewModel
    let gradientLayer = CAGradientLayer()
    
    init(viewModel: BookmarkScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        viewModel.delegate = self
        view.addSubview(bookmarkScreenView)
        bookmarkScreenView.fillSuperview()
        setUpBackground()
        viewModel.fetchBookmarkedBooks()
        // Add tap gesture recognizer to trailingImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(homeButtonTapped))
        bookmarkScreenView.trailingImage.addGestureRecognizer(tapGesture)
    }
    
    func bookmarkedBooksUpdated() {
        bookmarkScreenView.bookmarkedBooks = viewModel.bookmarkedBooks
    }
    
    func setUpBackground() {
        let topColor = UIColor.backgroundColor.cgColor // Color for the top 10%
        let bottomColor = UIColor.white.cgColor // Color for the remaining 90%
        gradientLayer.colors = [topColor, topColor, bottomColor, bottomColor]
        gradientLayer.locations = [0, 0.12, 0.12, 1] // The top 10% will have the top color, the rest will have the bottom color
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func homeButtonTapped() {
        viewModel.homeButtonTapped()
    }
    
}

