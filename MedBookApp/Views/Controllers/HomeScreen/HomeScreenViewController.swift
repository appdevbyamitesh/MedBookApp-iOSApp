//
//  HomeScreenViewController.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

final class HomeScreenViewController: UIViewController, HomeScreenViewModelDelegate {
    
    
    // MARK: - Properties
    
    private let homeScreenView = HomeScreenView()
    private let viewModel: HomeScreenViewModel
    let gradientLayer = CAGradientLayer()
    
    // MARK: - Initializers
    
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupNavigationBar()
        view.addSubview(homeScreenView)
        homeScreenView.fillSuperview()
        setUpBackground()
        homeScreenView.delegate = self
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func homeCardModelUpdated() {
        homeScreenView.hideLoader()
        homeScreenView.configure(bookDetails: viewModel.homeCardModel)
    }
    
    func setUpBackground() {
        let topColor = UIColor.backgroundColor.cgColor // Color for the top 10%
        let bottomColor = UIColor.white.cgColor // Color for the remaining 90%
        gradientLayer.colors = [topColor, topColor, bottomColor, bottomColor]
        gradientLayer.locations = [0, 0.12, 0.12, 1] // The top 10% will have the top color, the rest will have the bottom color
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

// MARK: - HomeScreenViewDelegate

extension HomeScreenViewController: HomeScreenViewDelegate {
    
    func loadMoreDataIfNeeded(currentIndex: Int) {
        viewModel.loadMoreDataIfNeeded(currentIndex: currentIndex)
    }
    
    
    func didChangeSearchQuery(_ query: String) {
        if query.count >= 3 {
            homeScreenView.showLoader()
        }
        viewModel.searchBooks(query: query)
    }
    
    func didTapSignOutButton() {
        viewModel.didTapSignOutButton()
    }
    
    func bookmarkButtonTapped(with bookmarkedBook: BookmarkedBookModel) {
        viewModel.bookmarkBook(with: bookmarkedBook)
    }
    
    func didTapHeaderBookmarkButton() {
        viewModel.didTapHeaderBookmarkButton()
    }
    
}
