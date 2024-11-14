//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 31.10.2024.
//
import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let genresStackView = UIStackView()
    private let ratingStackView = UIStackView()
    private let ratingLabel = UILabel()
    private let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
    private let overviewTitleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let castTitleLabel = UILabel()
    private let castStackView = UIStackView()
    private let linksStackView = UIStackView()
    private let imdbButton = UIButton()
    private let facebookButton = UIButton()
    private let watchListButton = UIButton()
    
    private let movieID: Int
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovieDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Poster Image
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        contentView.addSubview(posterImageView)
        
        // Title Label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        // Release Date Label
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.textColor = .gray
        contentView.addSubview(releaseDateLabel)
        
        // Genres Stack View
        genresStackView.axis = .horizontal
        genresStackView.spacing = 8
        contentView.addSubview(genresStackView)
        
        // Rating Stack View
        starImageView.tintColor = .systemYellow
        starImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        ratingStackView.addArrangedSubview(starImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        contentView.addSubview(ratingStackView)
        
        // Overview Title Label
        overviewTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        overviewTitleLabel.text = "Overview"
        contentView.addSubview(overviewTitleLabel)
        
        // Overview Label
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0
        contentView.addSubview(overviewLabel)
        
        // Cast Title Label
        castTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        castTitleLabel.text = "Cast"
        contentView.addSubview(castTitleLabel)
        
        // Cast Stack View
        castStackView.axis = .horizontal
        castStackView.spacing = 10
        castStackView.alignment = .center
        contentView.addSubview(castStackView)
        
        // Links Stack View
        imdbButton.setImage(UIImage(named: "imdbIcon"), for: .normal)
        facebookButton.setImage(UIImage(named: "facebookIcon"), for: .normal)
        
        linksStackView.axis = .horizontal
        linksStackView.spacing = 20
        linksStackView.addArrangedSubview(imdbButton)
        linksStackView.addArrangedSubview(facebookButton)
        contentView.addSubview(linksStackView)
        
        // Watch List Button
        watchListButton.setTitle("Add To Watch List", for: .normal)
        watchListButton.backgroundColor = .blue
        watchListButton.layer.cornerRadius = 10
        contentView.addSubview(watchListButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        genresStackView.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(genresStackView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        castTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        castStackView.snp.makeConstraints { make in
            make.top.equalTo(castTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        linksStackView.snp.makeConstraints { make in
            make.top.equalTo(castStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        watchListButton.snp.makeConstraints { make in
            make.top.equalTo(linksStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func fetchMovieDetails() {
        NetworkingManager.shared.getMovieDetails(movieID: movieID) { [weak self] movie in
            DispatchQueue.main.async {
                guard let self = self, let movie = movie else {
                    return
                }
                self.updateUI(with: movie)
            }
        }
        
        NetworkingManager.shared.getMovieCredits(movieID: movieID) { [weak self] cast in
            DispatchQueue.main.async {
                self?.updateCastUI(with: cast)
            }
        }
    }
    
    private func updateCastUI(with cast: [CastMember]) {
        castStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // Clear previous views
        
        // Ensure the cast stack view is set to vertical alignment
        castStackView.axis = .vertical
        castStackView.spacing = 12
        castStackView.alignment = .leading // Align items to the left
        castStackView.distribution = .fillProportionally

        for member in cast.prefix(5) {
            // Create a horizontal stack for each cast member row
            let containerView = UIStackView()
            containerView.axis = .horizontal
            containerView.alignment = .center
            containerView.spacing = 12
            
            // Image View for the actor's photo
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 30
            imageView.clipsToBounds = true
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(60) // Consistent size for all images
            }
            
            // Load the profile image
            if let profilePath = member.profilePath {
                let profileURL = "https://image.tmdb.org/t/p/w500\(profilePath)"
                NetworkingManager.shared.loadImage(posterPath: profileURL) { image in
                    imageView.image = image
                }
            }
            
            // Add tap gesture recognizer to the image view
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actorImageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            
            // Set the actor's ID as the tag to identify which actor was tapped
            imageView.tag = member.id
            
            // Label for the actor's name and character
            let nameLabel = UILabel()
            nameLabel.text = "\(member.name) as \(member.character)"
            nameLabel.font = UIFont.systemFont(ofSize: 16)
            nameLabel.numberOfLines = 0 // Allows text to wrap if needed
            nameLabel.lineBreakMode = .byWordWrapping
            nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
            
            // Add image and label to container view
            containerView.addArrangedSubview(imageView)
            containerView.addArrangedSubview(nameLabel)
            
            // Add the container view to the main vertical stack
            castStackView.addArrangedSubview(containerView)
        }
    }

    // Method to handle the tap on an actor's image
    @objc private func actorImageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        
        let actorID = imageView.tag
        let actorDetailVC = ActorDetailViewController(actorID: actorID)
        navigationController?.pushViewController(actorDetailVC, animated: true)
    }



    private func updateUI(with movie: MovieDetail) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release date: \(movie.releaseDate)"
        
        // Clear previous genres
        genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for genre in movie.genres {
            let genreLabel = UILabel()
            genreLabel.text = genre.name
            genreLabel.font = UIFont.systemFont(ofSize: 14)
            genreLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            genreLabel.layer.cornerRadius = 5
            genreLabel.clipsToBounds = true
            genreLabel.textAlignment = .center
            genresStackView.addArrangedSubview(genreLabel)
        }
        
        overviewLabel.text = movie.overview
        
        // Set up star rating
        updateStarRating(rating: movie.voteAverage)
        
        if let posterPath = movie.posterPath {
            NetworkingManager.shared.loadImage(posterPath: posterPath) { [weak self] image in
                self?.posterImageView.image = image
            }
        }
    }

    private func updateStarRating(rating: Double) {
        // Clear previous stars
        ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let maxStars = 10
        let filledStars = Int(round(rating)) // Round to nearest whole number
        
        for i in 1...maxStars {
            let starImageView = UIImageView()
            if i <= filledStars {
                starImageView.image = UIImage(systemName: "star.fill") // Filled star
                starImageView.tintColor = .systemYellow
            } else {
                starImageView.image = UIImage(systemName: "star") // Empty star
                starImageView.tintColor = .gray
            }
            
            starImageView.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
            
            ratingStackView.addArrangedSubview(starImageView)
        }
    }

}
