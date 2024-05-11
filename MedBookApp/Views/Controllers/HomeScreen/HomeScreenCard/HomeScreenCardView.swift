//
//  HomeScreenCardView.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 30/03/24.
//

import UIKit

final class HomeScreenCardView: UITableViewCell {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coverImageView, trailingStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .customGray
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var trailingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bottomStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel, averageRatingLabel, ratingsCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isBaselineRelativeArrangement = true // Align baselines
        return stackView
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 48, height: 48)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let averageRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private let ratingsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(bookDetails: HomeScreenCardModel) {
        titleLabel.text = bookDetails.title
        authorLabel.text = bookDetails.author_name.first ?? ""
        coverImageView.image = bookDetails.coverImage
        configureRatingCounts(counts: bookDetails.ratings_count, averageRating: bookDetails.ratingsAverage)
    }
    
    func configureRatingCounts(counts: Int, averageRating: Double) {
        let formattedAverageRating = String(format: "%.1f", averageRating)
        let averageRatingString = NSMutableAttributedString(string: "⭐️ \(formattedAverageRating)")
        averageRatingString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: 2))
        averageRatingLabel.attributedText = averageRatingString
        
        // Set attributed string for ratings count with emoji
        let ratingsCountString = NSMutableAttributedString(string: "📚 \(counts)")
        ratingsCountString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: 2))
        ratingsCountLabel.attributedText = ratingsCountString
    }
    
    private func setupViews() {
        backgroundColor = .customGray
        contentView.addSubview(mainStackView)
        // Set attributed string for average rating with emoji
        mainStackView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                             left: leftAnchor,
                             bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 8)
    }
    
}
