//
//  HeroComicsViewController.swift
//  MarvelHeroes
//
//  Created by Alexander on 30.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class SearchComicsViewController: UIViewController {
    
    let marvelAPI = MarvelHeroesAPI.shared
    var comics: HeroComicsResponse?
    
    var fetchOffset: Int = 0
    var isDownloading: Bool = false
    
    let comicsIconSearchImageView: UIImageView = {
        let image = UIImage(named: "Comic_Search")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let comicsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Comics"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()
    
    lazy var comicsSearchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode = .always
        textField.placeholder = "Search for some comics!"
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
        btn.addTarget(self, action: #selector(searchComics), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 243, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.rgb(red: 224, green: 224, blue: 224)
        cv.contentInset = UIEdgeInsets(top: 0,
                                       left: Constants.leftDistanceToView,
                                       bottom: 0,
                                       right: Constants.rightDistanceToView)
        return cv
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
        
        view.backgroundColor = UIColor.rgb(red: 224, green: 224, blue: 224)
        
        setupSearchContainerView()
        setupSearchStubContainer()
        setupCollectionView()
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
        
        searchContainerView.addSubview(comicsSearchTextField)
        comicsSearchTextField.delegate = self
        comicsSearchTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        comicsSearchTextField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -10).isActive = true
        comicsSearchTextField.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 12).isActive = true
        comicsSearchTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3).isActive = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.comicsSearchTextField.frame.height))
        comicsSearchTextField.leftView = paddingView
        
        searchContainerView.addSubview(comicsIconSearchImageView)
        comicsIconSearchImageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        comicsIconSearchImageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        comicsIconSearchImageView.leadingAnchor.constraint(equalTo: comicsSearchTextField.leadingAnchor).isActive = true
        comicsIconSearchImageView.bottomAnchor.constraint(equalTo: comicsSearchTextField.topAnchor, constant: -18).isActive = true
        
        searchContainerView.addSubview(comicsLabel)
        comicsLabel.leadingAnchor.constraint(equalTo: comicsIconSearchImageView.trailingAnchor, constant: 4).isActive = true
        comicsLabel.bottomAnchor.constraint(equalTo: comicsIconSearchImageView.bottomAnchor, constant: 2).isActive = true
        comicsLabel.trailingAnchor.constraint(equalTo: comicsSearchTextField.trailingAnchor).isActive = true
        
        searchContainerView.addSubview(searchButton)
        searchButton.leadingAnchor.constraint(equalTo: comicsSearchTextField.trailingAnchor, constant: 4).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: comicsSearchTextField.bottomAnchor, constant: -2).isActive = true
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
    
    private func setupCollectionView() {
        
        view.addSubview(comicsCollectionView)
        self.comicsCollectionView.register(ComicsSearhCell.self, forCellWithReuseIdentifier: ComicsSearhCell.reuseId)
        
        comicsCollectionView.showsHorizontalScrollIndicator = false
        comicsCollectionView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 14).isActive = true
        comicsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        comicsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comicsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14).isActive = true
    }
    
    @objc private func searchComics() {
        marvelAPI.getComicsBy(comicsTitle: comicsSearchTextField.text!, offset: 0) { comics in
            if comics.heroComicsResponseData.results.isEmpty {
                self.searchStubImageView.isHidden = false
                self.serchStubMessageLabel.isHidden = false
                self.serchStubMessageLabel.text = "Sorry, no results for \"\((self.comicsSearchTextField.text)!)\" querry"
                self.comicsCollectionView.isHidden = true
            } else {
                self.searchStubImageView.isHidden = true
                self.serchStubMessageLabel.isHidden = true
                self.comicsCollectionView.isHidden = false
            }
            
            self.fetchOffset = 0
            self.comics = comics
            self.comicsCollectionView.reloadData()
        }
    }
    
    private func loadMoreComics(by title: String, offset: Int) {
        marvelAPI.getComicsBy(comicsTitle: title, offset: offset) { comics in
            self.comics?.heroComicsResponseData.results += comics.heroComicsResponseData.results
            self.comicsCollectionView.reloadData()
            self.isDownloading = false
        }
    }
}

extension SearchComicsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics?.heroComicsResponseData.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let comics = self.comics else { fatalError() }
        
        let count = comics.heroComicsResponseData.results.count
        
        if count > 1 && indexPath.row == count - 1 && self.isDownloading == false {
            self.fetchOffset += 9
            self.isDownloading = true
            loadMoreComics(by: comicsSearchTextField.text!, offset: self.fetchOffset)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsSearhCell.reuseId, for: indexPath) as! ComicsSearhCell
        
        cell.setup(comics: comics.heroComicsResponseData.results[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth, height: collectionView.frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ComicsInfoViewController()
        guard let comics = comics?.heroComicsResponseData.results[indexPath.row] else { return }
        
        vc.setupViewController(comics: comics)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchComicsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}


