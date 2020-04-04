//
//  DummyViewController.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class HeroInfoViewController: UIViewController {
    
    let marvelAPI = MarvelHeroesAPI.shared
    var heroId: Int = 0
    var comics: HeroComicsResponse?
    
    var fetchOffset: Int = 0
    var isDownloading: Bool = false
    
    let heroNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doctor octopus"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()
    
    let heroBackgroundImageView: UIImageView = {
        let image = UIImage(named: "mock_spider_girl")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let heroDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "May \"Mayday\" Parker is the daughter of Spider-Man and Mary Jane Watson-Parker. Born with all her father's powers-and the same silly sense of humor-she's grown up to become one of Earth's most trusted heroes and a fitting tribute to her proud papa."
        textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    let heroInfoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var heroComicsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(HeroSearchInfoComicsCell.self, forCellReuseIdentifier: HeroSearchInfoComicsCell.cellId)
        return tv
    }()
    
    let heroComicsTableViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let comicsStubImageView: UIImageView = {
        let image = UIImage(named: "search_stub")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let comicsStubLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Sorry, no comics found for this character"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Heroes"
        
        setupViews()
        
        fetchComics(by: heroId)
    }
    
    func setupViewController(hero: HeroResponseResult) {
        
        let path = URL(string: hero.heroThumbnail.heroThumbnailPath + "." + hero.heroThumbnail.heroThumbnailFormat)
        heroBackgroundImageView.kf.setImage(with: path)
        heroNameLabel.text = hero.heroName
        heroDescriptionTextView.text = hero.heroDescription
        heroId = hero.heroId
    }
    
    private func setupViews() {
        
        setupHeroContainerView()
        setupHeroComicsTableViewContainer()
        setupComicsStubImageView()
    }
    
    private func setupHeroContainerView() {
        
        view.addSubview(heroInfoContainerView)
        heroInfoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        heroInfoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heroInfoContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        heroInfoContainerView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        heroInfoContainerView.addSubview(heroNameLabel)
        heroNameLabel.leadingAnchor.constraint(equalTo: heroInfoContainerView.leadingAnchor, constant: 12).isActive = true
        heroNameLabel.trailingAnchor.constraint(equalTo: heroInfoContainerView.trailingAnchor, constant: -12).isActive = true
        heroNameLabel.topAnchor.constraint(equalTo: heroInfoContainerView.topAnchor, constant: 12).isActive = true
        
        heroInfoContainerView.addSubview(heroBackgroundImageView)
        heroBackgroundImageView.leadingAnchor.constraint(equalTo: heroInfoContainerView.leadingAnchor).isActive = true
        heroBackgroundImageView.trailingAnchor.constraint(equalTo: heroInfoContainerView.trailingAnchor, constant: 14).isActive = true
        heroBackgroundImageView.topAnchor.constraint(equalTo: heroInfoContainerView.topAnchor).isActive = true
        heroBackgroundImageView.bottomAnchor.constraint(equalTo: heroInfoContainerView.bottomAnchor).isActive = true
        
        heroInfoContainerView.addSubview(heroDescriptionTextView)
        heroDescriptionTextView.leadingAnchor.constraint(equalTo: heroNameLabel.leadingAnchor).isActive = true
        heroDescriptionTextView.trailingAnchor.constraint(equalTo: heroNameLabel.trailingAnchor).isActive = true
        heroDescriptionTextView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor).isActive = true
        heroDescriptionTextView.bottomAnchor.constraint(equalTo: heroInfoContainerView.bottomAnchor, constant: -8).isActive = true
        if heroDescriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            heroDescriptionTextView.text = "No description"
        }
    }
    
    private func setupHeroComicsTableViewContainer() {
        view.addSubview(heroComicsTableViewContainer)
        heroComicsTableViewContainer.topAnchor.constraint(equalTo: heroInfoContainerView.bottomAnchor).isActive = true
        heroComicsTableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        heroComicsTableViewContainer.leadingAnchor.constraint(equalTo: heroInfoContainerView.leadingAnchor).isActive = true
        heroComicsTableViewContainer.trailingAnchor.constraint(equalTo: heroInfoContainerView.trailingAnchor).isActive = true
        
        heroComicsTableViewContainer.addSubview(heroComicsTableView)
        heroComicsTableView.topAnchor.constraint(equalTo: heroComicsTableViewContainer.topAnchor).isActive = true
        heroComicsTableView.bottomAnchor.constraint(equalTo: heroComicsTableViewContainer.bottomAnchor).isActive = true
        heroComicsTableView.leadingAnchor.constraint(equalTo: heroComicsTableViewContainer.leadingAnchor).isActive = true
        heroComicsTableView.trailingAnchor.constraint(equalTo: heroComicsTableViewContainer.trailingAnchor).isActive = true
    }
    
    private func setupComicsStubImageView() {
        heroComicsTableViewContainer.addSubview(comicsStubImageView)
        heroComicsTableViewContainer.addSubview(comicsStubLabel)
        
        comicsStubImageView.topAnchor.constraint(equalTo: heroComicsTableViewContainer.topAnchor, constant: 8).isActive = true
        comicsStubImageView.centerXAnchor.constraint(equalTo: heroComicsTableViewContainer.centerXAnchor).isActive = true
        let hw = view.frame.width - ((view.frame.width / 3) * 2)
        comicsStubImageView.heightAnchor.constraint(equalToConstant: hw).isActive = true
        comicsStubImageView.widthAnchor.constraint(equalToConstant: hw).isActive = true
        
        comicsStubLabel.topAnchor.constraint(equalTo: comicsStubImageView.bottomAnchor, constant: 4).isActive = true
        comicsStubLabel.leadingAnchor.constraint(equalTo: heroComicsTableViewContainer.leadingAnchor, constant: 12).isActive = true
        comicsStubLabel.trailingAnchor.constraint(equalTo: heroComicsTableViewContainer.trailingAnchor, constant: -12).isActive = true
        comicsStubLabel.bottomAnchor.constraint(equalTo: heroComicsTableViewContainer.bottomAnchor, constant: -8).isActive = true
    }
    
    private func fetchComics(by id: Int) {
        marvelAPI.getComicsBy(characterId: heroId, offset: 0) { comics in
            if comics.heroComicsResponseData.results.count == 0 {
                self.comicsStubImageView.isHidden = false
                self.comicsStubLabel.isHidden = false
                self.heroComicsTableView.isHidden = true
            } else {
                self.heroComicsTableView.isHidden = false
                self.comicsStubImageView.isHidden = true
                self.comicsStubLabel.isHidden = true
            }
            
            self.fetchOffset = 0
            self.comics = comics
            self.heroComicsTableView.reloadData()
        }
    }
    
    private func loadMoreComicsBy(characterId: Int, offset: Int) {
        marvelAPI.getComicsBy(characterId: characterId, offset: offset) { comics in
            self.comics?.heroComicsResponseData.results += comics.heroComicsResponseData.results
            self.heroComicsTableView.reloadData()
            self.isDownloading = false
        }
    }
}

extension HeroInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comics?.heroComicsResponseData.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let comics = comics?.heroComicsResponseData.results[indexPath.row] else { return }
        
        let vc = ComicsInfoViewController()
        vc.setupViewController(comics: comics)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let comics = self.comics else { fatalError() }
        
        let count = comics.heroComicsResponseData.results.count
        
        if count > 1 && indexPath.row == count - 1 && self.isDownloading == false {
            self.fetchOffset += 9
            self.isDownloading = true
            loadMoreComicsBy(characterId: heroId, offset: self.fetchOffset)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroSearchInfoComicsCell.cellId, for: indexPath) as! HeroSearchInfoComicsCell
        
        cell.setup(comics: comics.heroComicsResponseData.results[indexPath.row])
        
        return cell
    }
}
