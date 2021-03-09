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
    var selectedWaifu: Waifu = Waifu(id: 0, name: "", origin: "", description: "", imageUrl: "", rarete: "")
    
    init() {
    }
    
    func addWaifu(waifu: Waifu) {
        self.waifus.append(waifu)
    }
    
    func addWaifuToCurrent(waifu: Waifu) {
        self.currentWaifus.append(waifu)
    }
 
    func removeWaifuFromCurrent(waifu: Waifu) {
        self.currentWaifus = self.currentWaifus.filter { $0.id != waifu.id }
    }
    
    func changeSelectedWaifu(waifu: Waifu) {
        self.selectedWaifu = waifu
    }
    
    func unselectWaifu() {
        self.selectedWaifu = Waifu(id: 0, name: "", origin: "", description: "", imageUrl: "", rarete: "")
    }
    
    func isWaifuSelcted() -> Bool {
        return self.selectedWaifu.id != 0
    }
    
}
