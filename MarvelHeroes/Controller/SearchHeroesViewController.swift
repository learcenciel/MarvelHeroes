//
//  ViewController.swift
//  MarvelHeroes
//
//  Created by Alexander on 28.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SearchHeroesViewController: UIViewController {
    
    var heroes: HeroResponse?
    let marvelAPI = MarvelHeroesAPI.shared
    
    var fetchOffset: Int = 0
    var isDownloading: Bool = false
    
    let heroIconSearchImageView: UIImageView = {
        let image = UIImage(named: "Hero_Search")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heroesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Heroes"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()
    
    lazy var heroSearchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode = .always
        textField.placeholder = "Search for some hero!"
        textField.backgroundColor = UIColor.rgb(red: 208, green: 210, blue: 214)
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel!.text = "search!"
        btn.layer.cornerRadius = 4
        let btnImage = UIImage(named: "Search_Hero_Button")
        btn.setImage(btnImage , for: .normal)
        btn.addTarget(self, action: #selector(searchForHeroes), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 243, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let heroesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchStubImageView: UIImageView = {
        let image = UIImage(named: "search_stub")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let serchStubMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.rgb(red: 155, green: 155, blue: 155)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchContainerView()
        setupSearchStubContainer()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    private func setupSearchContainerView() {
        
        view.addSubview(searchContainerView)
        searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchContainerView.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        
        searchContainerView.addSubview(heroSearchTextField)
        heroSearchTextField.delegate = self
        heroSearchTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        heroSearchTextField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -10).isActive = true
        heroSearchTextField.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 12).isActive = true
        heroSearchTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3).isActive = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.heroSearchTextField.frame.height))
        heroSearchTextField.leftView = paddingView
        
        searchContainerView.addSubview(heroIconSearchImageView)
        heroIconSearchImageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        heroIconSearchImageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        heroIconSearchImageView.leadingAnchor.constraint(equalTo: heroSearchTextField.leadingAnchor).isActive = true
        heroIconSearchImageView.bottomAnchor.constraint(equalTo: heroSearchTextField.topAnchor, constant: -18).isActive = true
        
        searchContainerView.addSubview(heroesLabel)
        heroesLabel.leadingAnchor.constraint(equalTo: heroIconSearchImageView.trailingAnchor, constant: 4).isActive = true
        heroesLabel.bottomAnchor.constraint(equalTo: heroIconSearchImageView.bottomAnchor, constant: 2).isActive = true
        heroesLabel.trailingAnchor.constraint(equalTo: heroSearchTextField.trailingAnchor).isActive = true
        
        searchContainerView.addSubview(searchButton)
        searchButton.leadingAnchor.constraint(equalTo: heroSearchTextField.trailingAnchor, constant: 4).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: heroSearchTextField.bottomAnchor, constant: -2).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -4).isActive = true
    }
    
    private func setupSearchStubContainer() {
        
        view.addSubview(searchStubImageView)
        searchStubImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        searchStubImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchStubImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        searchStubImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        view.addSubview(serchStubMessageLabel)
        serchStubMessageLabel.topAnchor.constraint(equalTo: searchStubImageView.bottomAnchor, constant: 12).isActive = true
        serchStubMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        serchStubMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    private func setupTableView() {
        
        view.addSubview(heroesTableView)
        self.heroesTableView.delegate = self
        self.heroesTableView.dataSource = self
        self.heroesTableView.register(HeroSearchCell.self, forCellReuseIdentifier: HeroSearchCell.cellId)
        
        heroesTableView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor).isActive = true
        heroesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        heroesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heroesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func searchForHeroes() {
        marvelAPI.getHeroesBy(nameStartsWith: heroSearchTextField.text!, offset: 0) { heroes in
            if heroes.heroResponseData.responseResults.count == 0 {
                self.searchStubImageView.isHidden = false
                self.serchStubMessageLabel.isHidden = false
                self.serchStubMessageLabel.text = "Sorry, no results for \"\((self.heroSearchTextField.text)!)\" querry"
                self.heroesTableView.isHidden = true
            } else {
                self.searchStubImageView.isHidden = true
                self.serchStubMessageLabel.isHidden = true
                self.heroesTableView.isHidden = false
            }
            
            self.heroes = heroes
            self.fetchOffset = 0
            self.heroesTableView.reloadData()
        }
    }
    
    private func loadMoreHeroes(by name: String, offset: Int) {
        marvelAPI.getHeroesBy(nameStartsWith: name, offset: offset) { heroes in
            self.heroes?.heroResponseData.responseResults += heroes.heroResponseData.responseResults
            self.heroesTableView.reloadData()
            self.isDownloading = false
        }
    }
}

extension SearchHeroesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes?.heroResponseData.responseResults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = HeroInfoViewController()
        
        guard let hero = heroes?.heroResponseData.responseResults[indexPath.row] else { return }
        
        vc.setupViewController(hero: hero)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let hero = self.heroes else { return UITableViewCell() }
        
        let count = hero.heroResponseData.responseResults.count
        
        if count > 1 && indexPath.row == count - 1 && self.isDownloading == false {
            self.fetchOffset += 9
            self.isDownloading = true
            loadMoreHeroes(by: heroSearchTextField.text!, offset: self.fetchOffset)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroSearchCell.cellId, for: indexPath) as! HeroSearchCell
        
        cell.setup(hero: heroes?.heroResponseData.responseResults[indexPath.row])
        
        return cell
    }
}

extension SearchHeroesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
