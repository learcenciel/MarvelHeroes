//
//  ComicsInfoViewController.swift
//  MarvelHeroes
//
//  Created by Alexander on 31.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class ComicsInfoViewController: UIViewController {
    
    let marvelAPI = MarvelHeroesAPI.shared
    var comics: HeroComicsResponseResult!
    
    let comicsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doctor strange (2018) #20 (Variant)"
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    
    let comicsBackgroundImageView: UIImageView = {
        let image = UIImage(named: "mock_spider_girl")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let comicsDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Henderson Mighty Men Variant"
        textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    let comicsInfoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var comicsCreatorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252)
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(
            top: 0,
            left: Constants.leftDistanceToView,
            bottom: 0,
            right: Constants.rightDistanceToView)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ComicsSearchCreatorCell.self, forCellWithReuseIdentifier: "cellId")
        return cv
    }()
    
    let heroComicsCollectionViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Comics"
        
        setupViews()
        setupComicsCollectionViewContainer()
    }
    
    func setupViewController(comics: HeroComicsResponseResult) {
        
        self.comics = comics
        
        let imagePath = self.comics.comicsThumbNail.comicsThumbnailPath + "." + self.comics.comicsThumbNail.comicsThumbnailExtension
        guard let url = URL(string: imagePath) else { return }
        
        self.comicsBackgroundImageView.kf.setImage(with: url)
        if self.comics.comicsDescriptionResponse.isEmpty {
            self.comicsDescriptionTextView.text = "No description"
        } else {
            self.comicsDescriptionTextView.text = self.comics.comicsDescriptionResponse[0].comicsDescriptionText
        }
        
        self.comicsTitleLabel.text = comics.comicsTitle
    }
    
    private func setupViews() {
        setupComicsContainerView()
    }
    
    private func setupComicsContainerView() {
        
        view.addSubview(comicsInfoContainerView)
        comicsInfoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        comicsInfoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comicsInfoContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        comicsInfoContainerView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        comicsInfoContainerView.addSubview(comicsTitleLabel)
        comicsTitleLabel.leadingAnchor.constraint(equalTo: comicsInfoContainerView.leadingAnchor, constant: 12).isActive = true
        comicsTitleLabel.trailingAnchor.constraint(equalTo: comicsInfoContainerView.trailingAnchor, constant: -12).isActive = true
        comicsTitleLabel.topAnchor.constraint(equalTo: comicsInfoContainerView.topAnchor, constant: 12).isActive = true
        
        comicsInfoContainerView.addSubview(comicsBackgroundImageView)
        comicsBackgroundImageView.leadingAnchor.constraint(equalTo: comicsInfoContainerView.leadingAnchor).isActive = true
        comicsBackgroundImageView.trailingAnchor.constraint(equalTo: comicsInfoContainerView.trailingAnchor, constant: 14).isActive = true
        comicsBackgroundImageView.topAnchor.constraint(equalTo: comicsInfoContainerView.topAnchor).isActive = true
        comicsBackgroundImageView.bottomAnchor.constraint(equalTo: comicsInfoContainerView.bottomAnchor).isActive = true
        
        comicsInfoContainerView.addSubview(comicsDescriptionTextView)
        comicsDescriptionTextView.leadingAnchor.constraint(equalTo: comicsTitleLabel.leadingAnchor).isActive = true
        comicsDescriptionTextView.trailingAnchor.constraint(equalTo: comicsTitleLabel.trailingAnchor).isActive = true
        comicsDescriptionTextView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor).isActive = true
        comicsDescriptionTextView.bottomAnchor.constraint(equalTo: comicsInfoContainerView.bottomAnchor, constant: -8).isActive = true
        if comicsDescriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            comicsDescriptionTextView.text = "No description"
        }
    }
    
    private func setupComicsCollectionViewContainer() {
        view.addSubview(heroComicsCollectionViewContainer)
        heroComicsCollectionViewContainer.topAnchor.constraint(equalTo: comicsInfoContainerView.bottomAnchor).isActive = true
        heroComicsCollectionViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        heroComicsCollectionViewContainer.leadingAnchor.constraint(equalTo: comicsInfoContainerView.leadingAnchor).isActive = true
        heroComicsCollectionViewContainer.trailingAnchor.constraint(equalTo: comicsInfoContainerView.trailingAnchor).isActive = true
        
        heroComicsCollectionViewContainer.addSubview(comicsCreatorsCollectionView)
        comicsCreatorsCollectionView.topAnchor.constraint(equalTo: heroComicsCollectionViewContainer.topAnchor).isActive = true
        comicsCreatorsCollectionView.bottomAnchor.constraint(equalTo: heroComicsCollectionViewContainer.bottomAnchor).isActive = true
        comicsCreatorsCollectionView.leadingAnchor.constraint(equalTo: heroComicsCollectionViewContainer.leadingAnchor).isActive = true
        comicsCreatorsCollectionView.trailingAnchor.constraint(equalTo: heroComicsCollectionViewContainer.trailingAnchor).isActive = true
    }
}

extension ComicsInfoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comics.comicsCreatorsResponse.comicsCreators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ComicsSearchCreatorCell

        cell.setup(creator: comics.comicsCreatorsResponse.comicsCreators[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let creator = self.comics.comicsCreatorsResponse.comicsCreators[indexPath.row]
        
        marvelAPI.getCreatorsBy(name: creator.comicsCreatorName, offset: 0) { data in
            let creatorToPass = data.heroComicsCreatorResponseData.results.first { result -> Bool in
                result.heroComicsCreatorFullName == creator.comicsCreatorName
            }
            
            let vc = CreatorInfoViewController()
            vc.setupViewController(creator: creatorToPass!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth - 20, height: collectionView.frame.height - 60)
    }
}
