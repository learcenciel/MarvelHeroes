//
//  CreatorSearchCell.swift
//  MarvelHeroes
//
//  Created by Alexander on 01.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class CreatorSearchCell: UITableViewCell {

    static let cellId = "cellId"
    
    let creatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        label.text = "Unknown creator"
        return label
    }()
    
    override func prepareForReuse() {
        self.creatorImageView.image = nil
        self.creatorNameLabel.text = ""
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
        addSubview(creatorImageView)
        creatorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        creatorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        creatorImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        creatorImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        creatorImageView.layer.cornerRadius = 30
        
        addSubview(creatorNameLabel)
        creatorNameLabel.leadingAnchor.constraint(equalTo: creatorImageView.trailingAnchor, constant: 8).isActive = true
        creatorNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        creatorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }
    
    func setup(creator: HeroComicsCreatorResponseResult?) {
        guard let creator = creator else { return }
        
        self.creatorNameLabel.text = creator.heroComicsCreatorFullName.isEmpty ? "Unknown creator" : creator.heroComicsCreatorFullName
        
        guard let url = URL(string: creator.heroComicsCreatorThumbNail.heroComicsCreatorThumbnailPath + "." + creator.heroComicsCreatorThumbNail.heroComicsCreatorThumbnailExtension) else { return }
        
        self.creatorImageView.kf.setImage(with: url)
    }
    
}
