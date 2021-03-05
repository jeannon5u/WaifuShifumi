//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit

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
        
//        AF.request("https://api.punkapi.com/v2/beers").response { response in
//            debugPrint(response)
//
//            let jsonBeers = try! JSON(data: response.data!)
//            let arrayBeer = jsonBeers.arrayValue
//            for beer in arrayBeer {
//                self.beers.append(Beer(name: beer["name"].stringValue,degree: beer["abv"].stringValue,description: beer["description"].stringValue,pictureUrl: beer["image_url"].stringValue))
//            }
//            self.tableView.reloadData()
//        }
    }

    @IBAction func buttonGoBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //Current waifus list
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "WaifuTableViewCell")
        
        let beer = waifus[indexPath.row]
        cell.textLabel?.text = beer.name
    
        return cell
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
