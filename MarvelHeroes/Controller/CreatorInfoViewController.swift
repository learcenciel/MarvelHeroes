//
//  CreatorInfoViewController.swift
//  MarvelHeroes
//
//  Created by Alexander on 01.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class CreatorInfoViewController: UIViewController {

    let marvelAPI = MarvelHeroesAPI.shared
    
    var creator: HeroComicsCreatorResponseResult!
    
    var fetchOffset = 0
    var isDownloading = false
    
    let heroComicsCreatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stan Lee"
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    
    let heroComicsCreatorBackgroundImageView: UIImageView = {
        let image = UIImage(named: "mock_spider_girl")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let comicsInfoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var heroComicsCreatorCreatorsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252)
        tv.showsHorizontalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(HeroSearchInfoComicsCell.self, forCellReuseIdentifier: HeroSearchInfoComicsCell.cellId)
        return tv
    }()
    
    let heroComicsCreatorCollectionViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Creators"
        
        setupViews()
        setupComicsCollectionViewContainer()
    }
    
    private func setupViews() {
        setupHeroComicsCreatorContainerView()
    }
    
    private func setupHeroComicsCreatorContainerView() {
        
        view.addSubview(comicsInfoContainerView)
        comicsInfoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        comicsInfoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comicsInfoContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        comicsInfoContainerView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        comicsInfoContainerView.addSubview(heroComicsCreatorNameLabel)
        heroComicsCreatorNameLabel.leadingAnchor.constraint(equalTo: comicsInfoContainerView.leadingAnchor, constant: 12).isActive = true
        heroComicsCreatorNameLabel.trailingAnchor.constraint(equalTo: comicsInfoContainerView.trailingAnchor, constant: -12).isActive = true
        heroComicsCreatorNameLabel.topAnchor.constraint(equalTo: comicsInfoContainerView.topAnchor, constant: 12).isActive = true
        
        comicsInfoContainerView.addSubview(heroComicsCreatorBackgroundImageView)
        heroComicsCreatorBackgroundImageView.leadingAnchor.constraint(equalTo: comicsInfoContainerView.leadingAnchor).isActive = true
        heroComicsCreatorBackgroundImageView.trailingAnchor.constraint(equalTo: comicsInfoContainerView.trailingAnchor, constant: 14).isActive = true
        heroComicsCreatorBackgroundImageView.topAnchor.constraint(equalTo: comicsInfoContainerView.topAnchor).isActive = true
        heroComicsCreatorBackgroundImageView.bottomAnchor.constraint(equalTo: comicsInfoContainerView.bottomAnchor).isActive = true
    }
    
    private func setupComicsCollectionViewContainer() {
        
        view.addSubview(heroComicsCreatorCollectionViewContainer)
        heroComicsCreatorCollectionViewContainer.topAnchor.constraint(equalTo: comicsInfoContainerView.bottomAnchor).isActive = true
        heroComicsCreatorCollectionViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        heroComicsCreatorCollectionViewContainer.leadingAnchor.constraint(equalTo: comicsInfoContainerView.leadingAnchor).isActive = true
        heroComicsCreatorCollectionViewContainer.trailingAnchor.constraint(equalTo: comicsInfoContainerView.trailingAnchor).isActive = true
        
        heroComicsCreatorCollectionViewContainer.addSubview(heroComicsCreatorCreatorsTableView)
        heroComicsCreatorCreatorsTableView.topAnchor.constraint(equalTo: heroComicsCreatorCollectionViewContainer.topAnchor).isActive = true
        heroComicsCreatorCreatorsTableView.bottomAnchor.constraint(equalTo: heroComicsCreatorCollectionViewContainer.bottomAnchor).isActive = true
        heroComicsCreatorCreatorsTableView.leadingAnchor.constraint(equalTo: heroComicsCreatorCollectionViewContainer.leadingAnchor).isActive = true
        heroComicsCreatorCreatorsTableView.trailingAnchor.constraint(equalTo: heroComicsCreatorCollectionViewContainer.trailingAnchor).isActive = true
    }
    
    func setupViewController(creator: HeroComicsCreatorResponseResult) {

        self.creator = creator
        
        let path = URL(string: self.creator.heroComicsCreatorThumbNail.heroComicsCreatorThumbnailPath + "." + self.creator.heroComicsCreatorThumbNail.heroComicsCreatorThumbnailExtension)
        heroComicsCreatorBackgroundImageView.kf.setImage(with: path)
        heroComicsCreatorNameLabel.text = self.creator.heroComicsCreatorFullName
    }
}

extension CreatorInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.creator.heroComicsCreatorComicsResponse.heroComicsCreatorComicsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let comics = self.creator.heroComicsCreatorComicsResponse.heroComicsCreatorComicsData[indexPath.row]
        
        marvelAPI.getComicsBy(comicsId: comics.heroComicsCreatorComicsPath.getIdFromLastSlash()) { data in
            
            let comicsToPass = data.heroComicsResponseData.results.first { result -> Bool in
                result.comicsTitle == comics.heroComicsCreatorName
            }
            
            let vc = ComicsInfoViewController()
            vc.setupViewController(comics: comicsToPass!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroSearchInfoComicsCell.cellId, for: indexPath) as! HeroSearchInfoComicsCell
        
        let comics = self.creator.heroComicsCreatorComicsResponse.heroComicsCreatorComicsData[indexPath.row]
        
        cell.setup(comics: comics)
        
        return cell
    }
}
