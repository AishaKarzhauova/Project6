//
//  MainViewController.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 31.10.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let containerScrollView = UIScrollView()
    private let containerView = UIView()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "MovieApp"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        return label
    }()
    
    private let themeSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Themes"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var themeCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let genreSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Genres"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var genreCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "killBillPoster")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true // Enable interaction
        return imageView
    }()
    
    private let movieButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kill Bill: vol.1", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let posterImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Kill-Bill-Volume-2")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true // Enable interaction
        return imageView
    }()
    
    private let movieButton2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kill Bill: vol.2", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    private let appTabBar: UITabBar = {
        let tabBar = UITabBar()
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let favoritesTab = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        let watchListTab = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "eye"), tag: 2)
        let searchTab = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 4)
        tabBar.items = [homeTab, favoritesTab, watchListTab, searchTab, profileTab]
        tabBar.selectedItem = homeTab
        return tabBar
    }()
    
    private let themeOptions = ["Popular", "Now Playing", "Upcoming", "Top Rated"]
    private let genreOptions = ["Action", "Adventure", "Comedy", "Drama"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        themeCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "themeCell")
        genreCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "genreCell")
        
        // adding action on tapping the poster
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(posterTapped))
        posterImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(containerView)
        view.addSubview(headerLabel)
        view.addSubview(themeSectionLabel)
        view.addSubview(themeCollection)
        view.addSubview(genreSectionLabel)
        view.addSubview(genreCollection)
        view.addSubview(posterImageView)
        view.addSubview(movieButton)
        view.addSubview(posterImageView2)
        view.addSubview(movieButton2)
        view.addSubview(appTabBar)
    }
    
    private func setupLayout() {
        containerScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(containerScrollView) // Ensures single-column scrolling
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(55)
            make.centerX.equalToSuperview()
        }

        themeSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(18)
            make.leading.equalTo(containerView).offset(16)
        }

        themeCollection.snp.makeConstraints { make in
            make.top.equalTo(themeSectionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(40)
        }

        genreSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(themeCollection.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(16)
        }

        genreCollection.snp.makeConstraints { make in
            make.top.equalTo(genreSectionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(40)
        }

        // First poster and button (vertical stacking)
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(genreCollection.snp.bottom).offset(35)
            make.centerX.equalTo(containerView)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.3)
        }

        movieButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.centerX.equalTo(posterImageView)
        }

        // Second poster and button (below the first one)
        posterImageView2.snp.makeConstraints { make in
            make.top.equalTo(movieButton.snp.bottom).offset(35)
            make.centerX.equalTo(containerView)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            make.height.equalTo(posterImageView2.snp.width).multipliedBy(1.3)
        }

        movieButton2.snp.makeConstraints { make in
            make.top.equalTo(posterImageView2.snp.bottom).offset(10)
            make.centerX.equalTo(posterImageView2)
            make.bottom.equalTo(containerView).offset(-20) // Ensures scrollable content area
        }

        appTabBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == themeCollection ? themeOptions.count : genreOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = collectionView == themeCollection ? "themeCell" : "genreCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        let cellLabel = UILabel()
        cellLabel.textAlignment = .center
        cellLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        cellLabel.textColor = .white
        cellLabel.text = collectionView == themeCollection ? themeOptions[indexPath.item] : genreOptions[indexPath.item]
        
        cell.contentView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = collectionView == themeCollection ? .systemRed : .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }

    @objc private func posterTapped() {
        let detailVC = MovieDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

