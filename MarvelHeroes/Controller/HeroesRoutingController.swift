//
//  HeroesRoutingController.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class HeroesRoutingController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let heroesNavigationController = UINavigationController(rootViewController: SearchHeroesViewController())
        let shieldIcon = UIImage(named: "Shield")?.withRenderingMode(.alwaysOriginal)
        heroesNavigationController.tabBarItem = UITabBarItem(title: "Heroes", image: shieldIcon, tag: 0)
        
        let comicsNavigationController = UINavigationController(rootViewController: SearchComicsViewController())
        let comicsIcon = UIImage(named: "Comics")?.withRenderingMode(.alwaysOriginal)
        comicsNavigationController.tabBarItem = UITabBarItem(title: "Comics", image: comicsIcon, tag: 1)
        
        let creatorsNavigationController = UINavigationController(rootViewController: SearchCreatorViewController())
        let creatorIcon = UIImage(named: "Writer_Search")?.withRenderingMode(.alwaysOriginal)
        creatorsNavigationController.tabBarItem = UITabBarItem(title: "Creators", image: creatorIcon, tag: 2)
        
        let tabBarList = [heroesNavigationController, comicsNavigationController, creatorsNavigationController]
        viewControllers = tabBarList
    }

}
