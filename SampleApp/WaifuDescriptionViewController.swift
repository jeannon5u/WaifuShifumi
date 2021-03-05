//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit
import WebKit

class WaifuDescriptionViewController: UIViewController {

    var waifu: Waifu? = nil
    
    @IBOutlet var imageWaifu: WKWebView!
    @IBOutlet var nameWaifu: UILabel!
    @IBOutlet var originWaifu: UILabel!
    @IBOutlet var descriptionWaifu: UILabel!
    @IBOutlet var rareteWaifu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let safeWaifu = waifu {
            self.title = safeWaifu.name
            self.nameWaifu.text = safeWaifu.name
            self.originWaifu.text = "Origin : \(safeWaifu.origin)"
            self.descriptionWaifu.text = "\(safeWaifu.description)"
            self.rareteWaifu.text = safeWaifu.rarete
            let url = URL(string: safeWaifu.imageUrl)
            
            if let safeUrl = url {
                self.imageWaifu.load(URLRequest(url: safeUrl))
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
