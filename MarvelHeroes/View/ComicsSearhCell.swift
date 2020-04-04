//
//  ComicsCell.swift
//  MarvelHeroes
//
//  Created by Alexander on 30.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class ComicsSearhCell: UICollectionViewCell {
    
    static let reuseId = "ComicsCell"
    var comics: HeroComicsResponseResult?
    
    let comicsThumbnailImageView: UIImageView = {
        let image = UIImage(named: "mock_comics")
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let comicsNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Doctor Strange - Multiverse of madness #3"
        return label
    }()
    
    override func prepareForReuse() {
        self.comicsNameLabel.text = ""
        self.comicsThumbnailImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupShadowCell()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupShadowCell() {
        self.layer.cornerRadius = 7
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    func setupViews() {
        
        addSubview(comicsThumbnailImageView)
        addSubview(comicsNameLabel)
        
        comicsThumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        comicsThumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        comicsThumbnailImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        comicsThumbnailImageView.heightAnchor.constraint(equalToConstant: frame.width * (5/4)).isActive = true
        
        comicsNameLabel.topAnchor.constraint(equalTo: comicsThumbnailImageView.bottomAnchor, constant: 4).isActive = true
        comicsNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        comicsNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        comicsNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
    }
    
    func setup(comics: HeroComicsResponseResult) {
        
        guard let imagePath = URL(string: comics.comicsThumbNail.comicsThumbnailPath + "." + comics.comicsThumbNail.comicsThumbnailExtension) else { return }
        
        comicsThumbnailImageView.kf.setImage(with: imagePath)
        comicsNameLabel.text = comics.comicsTitle
    }
}

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let minimumLineSpacing: CGFloat = 20
    static let cellWidth: CGFloat = (UIScreen.main.bounds.width / 2)
}
