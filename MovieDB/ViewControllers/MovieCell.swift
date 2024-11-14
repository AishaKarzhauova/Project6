//
//  MovieCell.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 14.11.2024.
//

import Foundation
import UIKit
import SnapKit

class MovieCell: UICollectionViewCell {
    private let posterContainerView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure posterContainerView
        contentView.addSubview(posterContainerView)
        
        // Configure posterImageView
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterContainerView.addSubview(posterImageView)
        
        // Configure titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2 // Allow up to 2 lines for longer titles
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        // Constrain posterContainerView to be centered with increased size
        posterContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(posterContainerView.snp.height).multipliedBy(0.66) // Aspect ratio 2:3 (width:height)
            make.height.equalTo(350) // Increased height for larger poster
        }
        
        // Constrain posterImageView to fill posterContainerView
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Constrain titleLabel below posterContainerView
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterContainerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        NetworkingManager.shared.loadImage(posterPath: movie.posterPath) { [weak self] image in
            self?.posterImageView.image = image
        }
    }
}
