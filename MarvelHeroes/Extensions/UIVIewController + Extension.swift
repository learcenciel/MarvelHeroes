//
//  UIVIewController + Extension.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

extension SearchHeroesViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
}
}
