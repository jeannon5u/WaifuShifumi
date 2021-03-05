//
//  Waifu.swift
//  SampleApp
//
//  Created by Maxime Jeannon on 05/03/2021.
//

class Waifu {
    var id: Int
    var name: String
    var origin: String
    var description: String
    var imageUrl: String
    var rarete: String
    
    init(id: Int, name:String, origin: String, description: String, imageUrl: String, rarete: String) {
        self.id = id
        self.name = name
        self.origin = origin
        self.description = description
        self.imageUrl = imageUrl
        self.rarete = rarete
    }
    
}
