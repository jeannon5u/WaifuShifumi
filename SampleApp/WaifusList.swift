//
//  Waifu.swift
//  SampleApp
//
//  Created by Maxime Jeannon on 05/03/2021.
//

public class WaifusList {
    
    public static let sharedInstance = WaifusList()
    
    var waifus: [Waifu] = []
    var currentWaifus: [Waifu] = []
    
    init() {
    }
    
    func addWaifu(waifu: Waifu) {
        self.waifus.append(waifu)
    }
    
    func addWaifuToCurrent(waifu: Waifu) {
        self.currentWaifus.append(waifu)
    }
    
}
