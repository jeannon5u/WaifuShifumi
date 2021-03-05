//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

//View
class ListWaifusView: UIViewController {
    
    private let waifu: Waifu
    
    // initialisation d'une vue à la volé
    init(frame: CGRect, waifu: Waifu) {
        self.waifu = waifu
        super.init(nibName: nil, bundle: nil)
        
        self.title = self.waifu.name
        self.view = UIView(frame: frame)
        self.view.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Controller
class ListWaifusViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    @IBAction func buttonGoBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    let waifus = WaifusList.sharedInstance.currentWaifus
    
    @IBOutlet var nameWaifu: UILabel!
    
    @IBAction func actualiser(_ sender: Any) {
        nameWaifu.text = waifus[0].name
    }
    
    // nombre de section dans la tableView (obligatoire)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // nombre de ligne dans la section (obligatoire)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waifus.count
    }
    
    // déclaration de le cellule (obligatoire)
    // ici on utilise le format de cellule par default
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WaifuCell! = tableView.dequeueReusableCell(withIdentifier: "WaifuTableViewCell") as? WaifuCell
        
        let waifu = waifus[indexPath.row]
        cell.nameWaifu.text = waifu.name
        cell.rareteWaifu.text = waifu.rarete
        let url = URL(string: waifu.imageUrl)
        
        if let safeUrl = url {
            cell.imageWaifu.load(URLRequest(url: safeUrl))
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // --- Delegate ---
    
    // cette fonction décrit la logique appliquée une fois qu'on clic sur une cellule
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "segueToWaifuDescription", sender: waifus[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Waifus Listu"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWaifuDescription" {
            
            let waifu = sender as? Waifu
            
            if let viewControllerDestination = segue.destination as?
                WaifuDescriptionViewController {
                viewControllerDestination.waifu = waifu
            }
        }
    }
    
}
