//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit
import WebKit

class ShifumiViewController: UIViewController {


    var playMove : String = ""
    var oppoMove : String = ""
    
    @IBOutlet var background: UIImageView!
    @IBOutlet var oppoImageWaifu: WKWebView!
    @IBOutlet var oppoNameWaifu: UILabel!
    
    @IBOutlet var playImageWaifu: WKWebView!
    @IBOutlet var playNameWaifu: UILabel!
    
    
    @IBOutlet var rockButtonOutlet: UIButton!
    @IBOutlet var paperButtonOutlet: UIButton!
    @IBOutlet var scissorButtonOutlet: UIButton!
    
    @IBOutlet var playSelectMove: UIImageView!
    @IBOutlet var oppoSelectMove: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.image = UIImage(named: "background_shifumi")
        
        let playWaifu = WaifusList.sharedInstance.selectedWaifu
        
        playNameWaifu.text = playWaifu.name
        let playUrl = URL(string: playWaifu.imageUrl)
        if let safeUrl = playUrl {
            playImageWaifu.load(URLRequest(url: safeUrl))
        }
        
        
        let waifus = WaifusList.sharedInstance.waifus
        let rand = Int.random(in: 0...waifus.count-1)
        let randomWaifu = waifus[rand]
        
        oppoNameWaifu.text = randomWaifu.name
        let url = URL(string: randomWaifu.imageUrl)
        if let safeUrl = url {
            oppoImageWaifu.load(URLRequest(url: safeUrl))
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func rockButton(_ sender: Any) {
        playMove = "rock"
        play(playMove: playMove)
    }
    
    @IBAction func paperButton(_ sender: Any) {
        playMove = "paper"
        play(playMove: playMove)
    }
    
    
    @IBAction func scissorsButton(_ sender: Any) {
        playMove = "scissor"
        play(playMove: playMove)
    }
    
    func play(playMove : String) {
        
        playSelectMove.image = UIImage(named: playMove)
        
        rockButtonOutlet.isHidden = true
        paperButtonOutlet.isHidden = true
        scissorButtonOutlet.isHidden = true
        
        let randMove = Int.random(in: 1...3)
        
        switch randMove {
        case 1 :
            oppoMove = "rock"
            oppoSelectMove.image = UIImage(named: "rock")
        case 2:
            oppoMove = "paper"
            oppoSelectMove.image = UIImage(named: "paper")
        case 3:
            oppoMove = "scissor"
            oppoSelectMove.image = UIImage(named: "scissor")
        default:
            break;
        }
        
        
        if(oppoMove == playMove){
            rockButtonOutlet.isHidden = false
            paperButtonOutlet.isHidden = false
            scissorButtonOutlet.isHidden = false
        }
        else{
            
        }
        
        
        
    }
}
