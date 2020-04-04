//
//  ComicsSearchCreatorsCell.swift
//  MarvelHeroes
//
//  Created by Alexander on 31.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class ComicsSearchCreatorCell: UICollectionViewCell {
    
    static let reuseId = "CreatorCell"
    
    let roleIcon: [String: UIImage] = [
        "writer": UIImage(named: "writer_role")!,
        "inker": UIImage(named: "inker_role")!,
        "editor": UIImage(named: "editor_role")!,
        "colorist": UIImage(named: "colorist_role")!,
        "letterer": UIImage(named: "letterer_role")!,
        "colorist (cover)": UIImage(named: "penciler_role")!,
        "penciller (cover)": UIImage(named: "penciler_role")!,
        "penciler (cover)": UIImage(named: "penciler_role")!,
        "penciller": UIImage(named: "penciler_role")!,
        "penciler": UIImage(named: "penciler_role")!,
        "inker (cover)": UIImage(named: "inker_role")!
    ]
    
    let cellBackgroundColors: [UIColor] = [
        UIColor.rgb(red: 225, green: 74, blue: 151, alpha: 0.8),
        UIColor.rgb(red: 48, green: 103, blue: 211, alpha: 0.8),
        UIColor.rgb(red: 105, green: 66, blue: 214, alpha: 0.8)
    ]
    
    let creatorRoleImageView: UIImageView = {
        let image = UIImage(named: "writer_role")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Stan Lee"
        return label
    }()
    
    override func prepareForReuse() {
        self.creatorNameLabel.text = ""
        self.creatorRoleImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupShadowCell()
        
        let randomColorNumber = Int.random(in: 0...2)
        backgroundColor = cellBackgroundColors[randomColorNumber]
        
        setupViews()
    }
    
    func setupShadowCell() {
        self.layer.cornerRadius = 7
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
    
    func setupViews() {
        
        addSubview(creatorNameLabel)
        addSubview(creatorRoleImageView)
        
        creatorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        creatorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        creatorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        creatorNameLabel.heightAnchor.constraint(equalToConstant: estimatedLabelHeight(text: creatorNameLabel.text!, width: frame.width - 28, font: creatorNameLabel.font)).isActive = true
        
        let width: CGFloat = frame.width / 2.5
        let height: CGFloat = width
        
        let creatorRoleImageViewTopAnchor = creatorRoleImageView.topAnchor.constraint(equalTo: creatorNameLabel.bottomAnchor, constant: frame.height / 8)
        creatorRoleImageViewTopAnchor.priority = UILayoutPriority(rawValue: 1)
        creatorRoleImageViewTopAnchor.isActive = true
        creatorRoleImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        creatorRoleImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        creatorRoleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        creatorRoleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -frame.height / 8).isActive = true
    }
    
    func setup(creator: HeroComicsCreator) {
        creatorNameLabel.text = creator.comicsCreatorName
        creatorRoleImageView.image = roleIcon[creator.comicsCreatorRole]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func estimatedLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {

        let size = CGSize(width: width, height: 1000)

        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        let attributes = [NSAttributedString.Key.font: font]

        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height

        return rectangleHeight
    }
}
