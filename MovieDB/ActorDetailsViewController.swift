//
//  ActorDetailsViewController.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 31.10.2024.
//

import UIKit
import SnapKit

class ActorDetailsViewController: UIViewController {

    private let mainScrollView = UIScrollView()
    private let mainContentView = UIView()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "uma-turman")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let actorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Uma Thurman"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    private let birthDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Born April 29, 1970"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let biographyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Biography"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let biographyTextLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Uma Karuna Thurman (born April 29, 1970) is an American actress. She has performed in a variety of films, from romantic comedies and dramas to science fiction and action films. Following her appearances on the December 1985 and May 1986 covers of British Vogue, Thurman starred in Dangerous Liaisons (1988). She rose to international prominence with her performance as Mia Wallace in Quentin Tarantino's 1994 film Pulp Fiction,[1] for which she was nominated for an Academy Award, a BAFTA Award, a Golden Globe Award, and a Screen Actors Guild Award for Best Supporting Actress. Often hailed as Tarantino's muse,[2] she reunited with the director to play the main role in Kill Bill: Volume 1 and 2 (2003, 2004),[3] which brought her a BAFTA Award nomination and two additional Golden Globe Award nominations.[4][5]

        Established as a Hollywood actress,[6] Thurman's other notable films include Henry & June (1990), The Truth About Cats & Dogs (1996), Batman & Robin (1997), Gattaca (1997), Les Misérables (1998), Paycheck (2003), The Producers (2005), My Super Ex-Girlfriend (2006), Percy Jackson & the Olympians: The Lightning Thief (2010), Lars von Trier's Nymphomaniac (2013),[7] The House That Jack Built (2018), and Hollywood Stargirl (2022).[8] In 2011, she was a member of the jury for the main competition at the 64th Cannes Film Festival,[9] and in 2017, she was named president of the 70th edition's "Un Certain Regard" jury. Thurman made her Broadway debut in The Parisian Woman (2017–2018).
        """
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()

    private let photosHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let moviesHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let photoButton1 = UIButton()
    private let photoButton2 = UIButton()
    private let photoButton3 = UIButton()
    private let photoMoreButton = UIButton()

    private let movieButton1 = UIButton()
    private let movieButton2 = UIButton()
    private let movieButton3 = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setupConstraints()
    }

    private func configureUI() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainContentView)

        mainContentView.addSubview(profileImageView)
        mainContentView.addSubview(actorNameLabel)
        mainContentView.addSubview(birthDetailsLabel)
        mainContentView.addSubview(biographyHeaderLabel)
        mainContentView.addSubview(biographyTextLabel)
        mainContentView.addSubview(photosHeaderLabel)
        mainContentView.addSubview(moviesHeaderLabel)

        setupImageButton(photoButton1, imageName: "uma-turman")
        setupImageButton(photoButton2, imageName: "uma-2")
        setupImageButton(photoButton3, imageName: "uma 3")

        mainContentView.addSubview(photoButton1)
        mainContentView.addSubview(photoButton2)
        mainContentView.addSubview(photoButton3)
        mainContentView.addSubview(photoMoreButton)

        setupImageButton(movieButton1, imageName: "killBillPoster")
        setupImageButton(movieButton2, imageName: "pulp fic")
        setupImageButton(movieButton3, imageName: "Kill-Bill-Volume-2")

        mainContentView.addSubview(movieButton1)
        mainContentView.addSubview(movieButton2)
        mainContentView.addSubview(movieButton3)
    }

    private func setupImageButton(_ button: UIButton, imageName: String) {
        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .normal)
        } else {
            button.backgroundColor = .gray
        }
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
    }

    private func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        mainContentView.snp.makeConstraints { make in
            make.edges.equalTo(mainScrollView)
            make.width.equalTo(mainScrollView)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(mainContentView).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(250)
        }

        actorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        birthDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(actorNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        biographyHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(birthDetailsLabel.snp.bottom).offset(20)
            make.leading.equalTo(mainContentView).offset(16)
        }

        biographyTextLabel.snp.makeConstraints { make in
            make.top.equalTo(biographyHeaderLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(mainContentView).inset(16)
        }

        photosHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(biographyTextLabel.snp.bottom).offset(20)
            make.leading.equalTo(mainContentView).offset(16)
        }

        photoButton1.snp.makeConstraints { make in
            make.top.equalTo(photosHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(mainContentView).offset(16)
            make.width.height.equalTo(80)
        }

        photoButton2.snp.makeConstraints { make in
            make.top.equalTo(photosHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(photoButton1.snp.trailing).offset(16)
            make.width.height.equalTo(80)
        }

        photoButton3.snp.makeConstraints { make in
            make.top.equalTo(photosHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(photoButton2.snp.trailing).offset(16)
            make.width.height.equalTo(80)
        }

        photoMoreButton.snp.makeConstraints { make in
            make.top.equalTo(photosHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(photoButton3.snp.trailing).offset(16)
            make.width.height.equalTo(80)
        }

        moviesHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(photoButton1.snp.bottom).offset(30)
            make.leading.equalTo(mainContentView).offset(16)
        }

        movieButton1.snp.makeConstraints { make in
            make.top.equalTo(moviesHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(mainContentView).offset(16)
            make.width.height.equalTo(80)
        }

        movieButton2.snp.makeConstraints { make in
            make.top.equalTo(moviesHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(movieButton1.snp.trailing).offset(16)
            make.width.height.equalTo(80)
        }

        movieButton3.snp.makeConstraints { make in
            make.top.equalTo(moviesHeaderLabel.snp.bottom).offset(16)
            make.leading.equalTo(movieButton2.snp.trailing).offset(16)
            make.width.height.equalTo(80)
            make.bottom.equalTo(mainContentView).offset(-20)
        }
    }
}
