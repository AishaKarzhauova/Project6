//
//  ActorDetailViewController.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 31.10.2024.
//
import UIKit
import SnapKit

class ActorDetailViewController: UIViewController {
    private let actorID: Int
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let birthDateLabel = UILabel()
    private let placeOfBirthLabel = UILabel()
    private let bioLabel = UILabel()
    
    init(actorID: Int) {
        self.actorID = actorID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchActorDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add Scroll View
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        // Profile Image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 75
        profileImageView.backgroundColor = .lightGray
        contentView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        // Name Label
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // Birth Date Label
        birthDateLabel.font = UIFont.systemFont(ofSize: 16)
        birthDateLabel.textColor = .gray
        birthDateLabel.textAlignment = .center
        contentView.addSubview(birthDateLabel)
        
        birthDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // Place of Birth Label
        placeOfBirthLabel.font = UIFont.systemFont(ofSize: 16)
        placeOfBirthLabel.textColor = .gray
        placeOfBirthLabel.textAlignment = .center
        contentView.addSubview(placeOfBirthLabel)
        
        placeOfBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(birthDateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // Bio Label
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        bioLabel.numberOfLines = 0
        contentView.addSubview(bioLabel)
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(placeOfBirthLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    private func fetchActorDetails() {
        NetworkingManager.shared.getActorDetails(actorID: actorID) { [weak self] actor in
            guard let self = self, let actor = actor else {
                print("Failed to fetch actor details or actor data is nil.")
                return
            }
            DispatchQueue.main.async {
                self.updateUI(with: actor)
            }
        }
    }
    
    private func updateUI(with actor: ActorDetail) {
        nameLabel.text = actor.name
        birthDateLabel.text = "Born: \(actor.birthday ?? "N/A")"
        placeOfBirthLabel.text = "Place of Birth: \(actor.placeOfBirth ?? "N/A")"
        bioLabel.text = actor.biography
        
        if let profilePath = actor.profilePath {
            NetworkingManager.shared.loadImage(posterPath: profilePath) { [weak self] image in
                if let image = image {
                    print("Image loaded successfully")
                    self?.profileImageView.image = image
                } else {
                    print("Failed to load image")
                }
            }
        } else {
            print("No profile path available for actor.")
        }
    }
}
