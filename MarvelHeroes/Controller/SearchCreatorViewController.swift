//
//  CreatorSearchViewController.swift
//  MarvelHeroes
//
//  Created by Alexander on 01.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit
import Alamofire
class SearchCreatorViewController: UIViewController {
    
    var heroCreators: HeroComicsCreatorResponse?
    let marvelAPI = MarvelHeroesAPI.shared
    
    var fetchOffset: Int = 0
    var isDownloading: Bool = false
    
    let heroCreatorIconSearchImageView: UIImageView = {
        let image = UIImage(named: "Creator_Search")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heroCreatorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Creators"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()
    
    lazy var heroCreatorSearchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode = .always
        textField.placeholder = "Search for your favorite!"
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
        btn.addTarget(self, action: #selector(searchForCreators), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 243, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let heroCreatorTableView: UITableView = {
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
        
        searchContainerView.addSubview(heroCreatorSearchTextField)
        heroCreatorSearchTextField.delegate = self
        heroCreatorSearchTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        heroCreatorSearchTextField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -10).isActive = true
        heroCreatorSearchTextField.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 12).isActive = true
        heroCreatorSearchTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3).isActive = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.heroCreatorSearchTextField.frame.height))
        heroCreatorSearchTextField.leftView = paddingView
        
        searchContainerView.addSubview(heroCreatorIconSearchImageView)
        heroCreatorIconSearchImageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        heroCreatorIconSearchImageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        heroCreatorIconSearchImageView.leadingAnchor.constraint(equalTo: heroCreatorSearchTextField.leadingAnchor).isActive = true
        heroCreatorIconSearchImageView.bottomAnchor.constraint(equalTo: heroCreatorSearchTextField.topAnchor, constant: -18).isActive = true
        
        searchContainerView.addSubview(heroCreatorLabel)
        heroCreatorLabel.leadingAnchor.constraint(equalTo: heroCreatorIconSearchImageView.trailingAnchor, constant: 4).isActive = true
        heroCreatorLabel.bottomAnchor.constraint(equalTo: heroCreatorIconSearchImageView.bottomAnchor, constant: 2).isActive = true
        heroCreatorLabel.trailingAnchor.constraint(equalTo: heroCreatorSearchTextField.trailingAnchor).isActive = true
        
        searchContainerView.addSubview(searchButton)
        searchButton.leadingAnchor.constraint(equalTo: heroCreatorSearchTextField.trailingAnchor, constant: 4).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: heroCreatorSearchTextField.bottomAnchor, constant: -2).isActive = true
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
        
        view.addSubview(heroCreatorTableView)
        self.heroCreatorTableView.delegate = self
        self.heroCreatorTableView.dataSource = self
        self.heroCreatorTableView.register(CreatorSearchCell.self, forCellReuseIdentifier: "cellId")
        
        heroCreatorTableView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor).isActive = true
        heroCreatorTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        heroCreatorTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heroCreatorTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func searchForCreators() {
        
        marvelAPI.getCreatorsBy(name: heroCreatorSearchTextField.text!, offset: 0) { creators in
            if creators.heroComicsCreatorResponseData.results.count == 0 {
                self.searchStubImageView.isHidden = false
                self.serchStubMessageLabel.isHidden = false
                self.serchStubMessageLabel.text = "Sorry, no results for \"\((self.heroCreatorSearchTextField.text)!)\" querry"
                self.heroCreatorTableView.isHidden = true
            } else {
                self.searchStubImageView.isHidden = true
                self.serchStubMessageLabel.isHidden = true
                self.heroCreatorTableView.isHidden = false
            }
            
            self.fetchOffset = 0
            self.heroCreators = creators
            self.heroCreatorTableView.reloadData()
        }
    }
    
    private func loadMoreCreators(by name: String, offset: Int) {
        marvelAPI.getCreatorsBy(name: name, offset: offset) { creators in
            
            self.heroCreators?.heroComicsCreatorResponseData.results += creators.heroComicsCreatorResponseData.results

            self.heroCreatorTableView.reloadData()
            self.isDownloading = false
        }
    }
}

extension SearchCreatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroCreators?.heroComicsCreatorResponseData.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreatorInfoViewController()
        
        guard let creator = heroCreators?.heroComicsCreatorResponseData.results[indexPath.row] else { return }
        
        vc.setupViewController(creator: creator)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let creators = self.heroCreators else { fatalError() }
        
        let count = creators.heroComicsCreatorResponseData.results.count
        
        if count > 1 && indexPath.row == count - 1 && self.isDownloading == false {
            self.fetchOffset += 9
            self.isDownloading = true
            loadMoreCreators(by: heroCreatorSearchTextField.text!, offset: self.fetchOffset)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CreatorSearchCell
        
        cell.setup(creator: creators.heroComicsCreatorResponseData.results[indexPath.row])
        
        return cell
    }
}

extension SearchCreatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
