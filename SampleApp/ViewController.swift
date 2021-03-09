//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet var buttonShifumi: UIButton!
    
    @IBOutlet var buttonPick: UIButton!
    
    @IBOutlet var buttonList: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AF.request("http://83.194.217.179:3001/waifu").response { response in
        AF.request("https://6041ee3d7f50e000173ab563.mockapi.io/waifu").response { response in
            debugPrint(response)
            
            let jsonWaifus = try! JSON(data: response.data!)
            let arrayWaifus = jsonWaifus.arrayValue
            for waifu in arrayWaifus {
                let waifuToAdd = Waifu(id: waifu["Id"].intValue, name: waifu["Name"].stringValue, origin: waifu["Source"].stringValue, description: waifu["Description"].stringValue, imageUrl: waifu["Image"].stringValue, rarete: waifu["Rarete"].stringValue)
                WaifusList.sharedInstance.addWaifu(waifu: waifuToAdd)
            }
        }
       
        buttonShifumi.layer.cornerRadius = 20
        buttonShifumi.layer.borderWidth = 0
        buttonShifumi.layer.borderColor = UIColor.black.cgColor
        
        buttonPick.layer.cornerRadius = 20
        buttonPick.layer.borderWidth = 0
        buttonPick.layer.borderColor = UIColor.black.cgColor
        
        buttonList.layer.cornerRadius = 20
        buttonList.layer.borderWidth = 0
        buttonList.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func playAction(_ sender: Any) {
        if WaifusList.sharedInstance.isWaifuSelcted() {
            performSegue(withIdentifier: "menuToPlay", sender: nil)
        } else {
            let alert = UIAlertController(title: "No Waifu Selected", message: "Please select a Waifu in your list", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
