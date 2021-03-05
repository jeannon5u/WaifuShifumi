//
//  Waifu.swift
//  SampleApp
//
//  Created by Maxime Jeannon on 05/03/2021.
//

public class WaifusList {
    
    public static let sharedInstance = WaifusList()
    
    var currentWaifus: [Waifu] = []
    var waifus: [Waifu] = []
    
    init() {
        self.waifus.append(Waifu(name: "Mikasa", origin: "SnK", description: "Badass", imageUrl: "https://medias.spotern.com/spots/w640/188/188753-1553277097.jpg"))
        self.waifus.append(Waifu(name: "Armin", origin: "SnK", description: "Cute", imageUrl: ""))
        self.waifus.append(Waifu(name: "Eren", origin: "SnK", description: "Badass since season 4", imageUrl: ""))
        
        self.currentWaifus.append(Waifu(name: "Mikasa", origin: "SnK", description: "Badass", imageUrl: "https://medias.spotern.com/spots/w640/188/188753-1553277097.jpg"))
    }
    
    func addWaifu(waifu: Waifu) {
        self.currentWaifus.append(waifu)
    }
    
}
