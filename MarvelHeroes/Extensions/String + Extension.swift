//
//  String + Extension.swift
//  MarvelHeroes
//
//  Created by Alexander on 01.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension String {
    func getIdFromLastSlash() -> Int {
        guard let id = self.components(separatedBy: "/").last else { return 0 }
        return Int(id)!
    }
}
