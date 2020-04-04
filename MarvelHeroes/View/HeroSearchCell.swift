//
//  HeroSearchCell.swift
//  MarvelHeroes
//
//  Created by Alexander on 28.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit
import Kingfisher

class HeroSearchCell: UITableViewCell {
    
    static let cellId = "cellId"
    
    let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    let heroNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        label.text = "Unknown character"
        return label
    }()
    
    let heroSubInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor.rgb(red: 114, green: 117, blue: 117)
        label.numberOfLines = 1
        label.text = "No description"
        return label
    }()
    
    override func prepareForReuse() {
        self.heroImageView.image = nil
        self.heroNameLabel.text = ""
        self.heroSubInfoLabel.text = ""
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
        addSubview(heroImageView)
        heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        heroImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        heroImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        heroImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        heroImageView.layer.cornerRadius = 30
        
        addSubview(heroNameLabel)
        heroNameLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 8).isActive = true
        heroNameLabel.topAnchor.constraint(equalTo: heroImageView.topAnchor).isActive = true
        heroNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        addSubview(heroSubInfoLabel)
        heroSubInfoLabel.leadingAnchor.constraint(equalTo: heroNameLabel.leadingAnchor).isActive = true
        heroSubInfoLabel.trailingAnchor.constraint(equalTo: heroNameLabel.trailingAnchor).isActive = true
        heroSubInfoLabel.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor, constant: 12).isActive = true
    }
    
    func setup(hero: HeroResponseResult?) {
        guard let hero = hero else { return }
        
        self.heroNameLabel.text = hero.heroName.isEmpty ? "Unknown character" : hero.heroName
        
        if hero.heroDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            heroSubInfoLabel.text = "No description"
        } else {
            heroSubInfoLabel.text = hero.heroDescription
        }
        
        guard let url = URL(string: hero.heroThumbnail.heroThumbnailPath + "." + hero.heroThumbnail.heroThumbnailFormat) else { return }
        
        self.heroImageView.kf.setImage(with: url)
    }
}
