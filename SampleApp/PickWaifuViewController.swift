//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit
import WebKit

class PickWaifuViewController: UIViewController {
    
    @IBAction func buttonGoBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet var imageWaifu: WKWebView!
    @IBOutlet var nameWaifu: UILabel!
    @IBOutlet var rareteWaifu: UILabel!
    @IBOutlet var origineWaifu: UILabel!
    @IBOutlet var descriptionWaifu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waifuPull()
        
        imageWaifu.layer.borderWidth = 2
        imageWaifu.layer.borderColor = UIColor.black.cgColor
        
        descriptionWaifu.layer.cornerRadius = 20
        descriptionWaifu.layer.borderWidth = 3
        descriptionWaifu.layer.borderColor = UIColor.black.cgColor
        descriptionWaifu.layer
        
        origineWaifu.layer.cornerRadius = 5
        origineWaifu.layer.borderWidth = 3
        origineWaifu.layer.borderColor = UIColor.black.cgColor
    }
    
    func waifuPull () {
        var rarete: String
        let randRarete = Int.random(in: 1...100)
        
        switch randRarete {
        case 1 :
            rarete = "SS"
        case 2...5 :
            rarete = "S"
        case 6...20 :
            rarete = "A"
        case 21...55 :
            rarete = "B"
        case 56...100 :
            rarete = "C"
        default :
            rarete = "Erreur lol"
        }
        
        debugPrint(randRarete)
        let filterByRarete = WaifusList.sharedInstance.waifus.filter { $0.rarete == rarete }
        debugPrint(filterByRarete)
        let randomWaifu = Int.random(in: 0...filterByRarete.count-1)
        let waifuToAdd = filterByRarete[randomWaifu]
        WaifusList.sharedInstance.addWaifuToCurrent(waifu: waifuToAdd)
        
        nameWaifu.text = waifuToAdd.name
        rareteWaifu.text = waifuToAdd.rarete
        origineWaifu.text = waifuToAdd.origin
        descriptionWaifu.text = waifuToAdd.description
        
        let url = URL(string: waifuToAdd.imageUrl)
        if let safeUrl = url {
            imageWaifu.load(URLRequest(url: safeUrl))
        }
    }
    
    @IBAction func buttonReroll(_ sender: Any) {
        waifuPull()
    }
    
}
