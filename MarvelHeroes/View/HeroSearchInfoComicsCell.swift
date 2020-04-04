//
//  HeroComicsCell.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Kingfisher
import UIKit

class HeroSearchInfoComicsCell: UITableViewCell {
    
    static let cellId = "cellId"
    
    let comicsThumbnailImageView: UIImageView = {
        let image = UIImage(named: "mock_comics")
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let comicsNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override func prepareForReuse() {
        self.comicsThumbnailImageView.image = nil
        self.comicsNameLabel.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(comicsThumbnailImageView)
        comicsThumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        comicsThumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let height: CGFloat = 70
        let width: CGFloat = height * (2.0 / 3.0)
        comicsThumbnailImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        comicsThumbnailImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        addSubview(comicsNameLabel)
        comicsNameLabel.leadingAnchor.constraint(equalTo: comicsThumbnailImageView.trailingAnchor, constant: 12).isActive = true
        comicsNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        comicsNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34).isActive = true
        comicsNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
    
    func setup(comics: HeroComicsResponseResult) {
        
        guard let imagePath = URL(string: comics.comicsThumbNail.comicsThumbnailPath + "." + comics.comicsThumbNail.comicsThumbnailExtension) else { return }
        
        comicsThumbnailImageView.kf.setImage(with: imagePath)
        comicsNameLabel.text = comics.comicsTitle
    }
    
    func setup(comics: HeroComicsCreatorData) {
        
        comicsNameLabel.text = comics.heroComicsCreatorName
    }
}
