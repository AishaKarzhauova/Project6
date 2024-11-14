//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 31.10.2024.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    
    private let containerScrollView = UIScrollView() // scrollVIew для всей страницы
    private let contentContainerView = UIView() // вью для содержимого скроллВ
    
    private let posterView: UIImageView = { // постер фильма
        let imageView = UIImageView()
        imageView.image = UIImage(named: "killBillPoster")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.text = "Kill Bill: vol.1"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let releaseDateView: UILabel = {
        let label = UILabel()
        label.text = "Release date: 2003"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()
    
    private let ratingView: UILabel = {
        let label = UILabel()
        label.text = "8.2/10 649K"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()
    
    private let genreButtonStack: UIStackView = { // Стек с кнопками жанров
        let actionButton = UIButton(type: .system)
        actionButton.setTitle("Action", for: .normal)
        actionButton.backgroundColor = .systemYellow
        actionButton.tintColor = .black
        actionButton.layer.cornerRadius = 10

        let crimeButton = UIButton(type: .system)
        crimeButton.setTitle("Crime", for: .normal)
        crimeButton.backgroundColor = .systemYellow
        crimeButton.tintColor = .black
        crimeButton.layer.cornerRadius = 10

        actionButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        
        crimeButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(25)
        }

        let stack = UIStackView(arrangedSubviews: [actionButton, crimeButton])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let overviewText: UILabel = {
        let label = UILabel()
        label.text = """
After waking from a four-year coma, a former assassin wreaks vengeance on the team of assassins who betrayed her.
"""
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let castImageStack = UIStackView()

    private let addToWatchlistButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Watch List", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy() // Инициализация и добавление всех элементов интерфейса/
        setupLayoutConstraints() // Настройка констрейнтов
        setupActions() // Настройка действий
    }
    
    private func setupViewHierarchy() { // Добавление всех элементов на экран
        view.backgroundColor = .white
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(contentContainerView)

        let castImage = UIImageView(image: UIImage(named: "umaa"))
        castImage.contentMode = .scaleAspectFill
        castImage.layer.cornerRadius = 10
        castImage.clipsToBounds = true

        castImageStack.axis = .vertical
        castImageStack.alignment = .center
        castImageStack.spacing = 8
        castImageStack.addArrangedSubview(castImage)

        castImage.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(100)
        }

        let views = [posterView, titleView, releaseDateView, ratingView, genreButtonStack, overviewLabel, overviewText, castLabel, castImageStack, addToWatchlistButton]
        views.forEach { contentContainerView.addSubview($0) }
    }
    
    private func setupLayoutConstraints() {
        containerScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentContainerView.snp.makeConstraints { make in
            make.edges.equalTo(containerScrollView)
            make.width.equalTo(containerScrollView)
        }

        posterView.snp.makeConstraints { make in
            make.top.equalTo(contentContainerView).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.height.equalTo(posterView.snp.width).multipliedBy(1.3)
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        releaseDateView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        ratingView.snp.makeConstraints { make in
            make.top.equalTo(releaseDateView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        genreButtonStack.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(genreButtonStack.snp.bottom).offset(16)
            make.leading.equalTo(contentContainerView).offset(16)
        }

        overviewText.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(contentContainerView).inset(16)
        }

        castLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewText.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        castImageStack.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        addToWatchlistButton.snp.makeConstraints { make in
            make.top.equalTo(castImageStack.snp.bottom).offset(30)
            make.leading.trailing.equalTo(contentContainerView).inset(50)
            make.height.equalTo(50)
            make.bottom.equalTo(contentContainerView).offset(-20)
        }
    }

    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCastImageTapped))
        castImageStack.addGestureRecognizer(tapGesture)
    }
    
    @objc private func onCastImageTapped() { // Метод для обработки нажатия на изображение
        let actorDetailsVC = ActorDetailsViewController()
        navigationController?.pushViewController(actorDetailsVC, animated: true)
    }
}
