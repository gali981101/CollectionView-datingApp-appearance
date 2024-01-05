//
//  Girl.swift
//  CollectionViewDemo
//
//  Created by Terry Jason on 2024/1/5.
//

import Foundation

struct Girl: Hashable {
    var name: String = ""
    var imageName: String = ""
    var description: String = ""
    var likes: Int = 0
    var isFavorite: Bool = false
    
    init(name: String, imageName: String, description: String, likes: Int, isFavorite: Bool) {
        self.name = name
        self.imageName = imageName
        self.description = description
        self.likes = likes
        self.isFavorite = isFavorite
    }
}
