//
//  ViewController.swift
//  SampleApp
//
//  Created by jficerai on 04/03/2021.
//

import UIKit
import WebKit

class ShifumiViewController: UIViewController {

    var oppoPV : Float = 50
    var playPV : Float = 50
    var initOppoPV : Float = 50
    var initPlayPV : Float = 50
    var playMove : String = ""
    var oppoMove : String = ""
    var oppoWaifu : Waifu = Waifu(id: 0, name: "", origin: "", description: "", imageUrl: "", rarete: "")
    
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
    
    @IBOutlet var textResultat: UILabel!
    
    @IBOutlet var playProgress: UIProgressView!
    @IBOutlet var oppoProgress: UIProgressView!
    
    @IBOutlet var playPVText: UILabel!
    @IBOutlet var oppoPVText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textResultat.text = ""
        playProgress.setProgress(1.0, animated: false)
        oppoProgress.setProgress(1.0, animated: false)
        
        let playWaifu = WaifusList.sharedInstance.selectedWaifu
        
        playNameWaifu.text = playWaifu.name
        let playUrl = URL(string: playWaifu.imageUrl)
        if let safeUrl = playUrl {
            playImageWaifu.load(URLRequest(url: safeUrl))
        }
        
        let waifus = WaifusList.sharedInstance.waifus
        let rand = Int.random(in: 0...waifus.count-1)
        oppoWaifu = waifus[rand]
        
        oppoNameWaifu.text = oppoWaifu.name
        let url = URL(string: oppoWaifu.imageUrl)
        if let safeUrl = url {
            oppoImageWaifu.load(URLRequest(url: safeUrl))
        }
        
        switch WaifusList.sharedInstance.selectedWaifu.rarete {
        case "SS" :
            playPV = 100
        case "S" :
            playPV = 70
        case "A" :
            playPV = 50
        case "B" :
            playPV = 40
        case "C" :
            playPV = 30
        default : break
        }
        
        switch oppoWaifu.rarete {
        case "SS" :
            oppoPV = 100
        case "S" :
            oppoPV = 70
        case "A" :
            oppoPV = 50
        case "B" :
            oppoPV = 40
        case "C" :
            oppoPV = 30
        default : break
        }
        
        initOppoPV = oppoPV
        initPlayPV = playPV
        playPVText.text = "PV : \(playPV)/\(playPV)"
        oppoPVText.text = "PV : \(oppoPV)/\(oppoPV)"
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
        
        if (oppoPV > 0 && playPV > 0) {
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
                textResultat.text = "Draw"
                oppoPV -= 5
                playPV -= 5
            }
            else{
                switch(oppoMove) {
                case "rock" :
                    switch(playMove) {
                    case "paper":
                        textResultat.text = "Victory"
                        oppoPV -= 10
                        
                    case "scissor" :
                        textResultat.text = "Defeat"
                        playPV -= 10
                    default : break
                    }
                case "paper" :
                    switch(playMove) {
                    case "rock":
                        textResultat.text = "Defeat"
                        playPV -= 10
                    case "scissor" :
                        textResultat.text = "Victory"
                        oppoPV -= 10
                    default : break
                    }
                    
                case "scissor" :
                    switch(playMove) {
                    case "rock":
                        textResultat.text = "Victory"
                        oppoPV -= 10
                    case "paper" :
                        textResultat.text = "Defeat"
                        playPV -= 10
                    default : break
                    }
                    
                default : break
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                let displayMoves = self.playPV <= 0 || self.oppoPV <= 0
                self.rockButtonOutlet.isHidden = displayMoves
                self.paperButtonOutlet.isHidden = displayMoves
                self.scissorButtonOutlet.isHidden = displayMoves
                self.oppoSelectMove.image = nil
                self.playSelectMove.image = nil
                self.textResultat.text = ""
                self.playProgress.setProgress(self.playPV/self.initPlayPV, animated: true)
                self.oppoProgress.setProgress(self.oppoPV/self.initOppoPV, animated: true)
                self.playPVText.text = "PV : \(self.playPV)/\(self.initPlayPV)"
                self.oppoPVText.text = "PV : \(self.oppoPV)/\(self.initOppoPV)"
                //égalité
                if (self.playPV <= 0 && self.oppoPV <= 0) {
                    self.textResultat.text = "You both suck asses :)"
                    WaifusList.sharedInstance.removeWaifuFromCurrent(waifu: WaifusList.sharedInstance.selectedWaifu)
                    WaifusList.sharedInstance.addWaifuToCurrent(waifu: self.oppoWaifu)
                    WaifusList.sharedInstance.unselectWaifu()
                }
                //défaite
                else if (self.playPV <= 0) {
                    self.textResultat.text = "Your waifu is gone !"
                    WaifusList.sharedInstance.removeWaifuFromCurrent(waifu: WaifusList.sharedInstance.selectedWaifu)
                    WaifusList.sharedInstance.unselectWaifu()
                }
                //victoire
                else if (self.oppoPV <= 0) {
                    self.textResultat.text = "Your harem grew up !"
                    WaifusList.sharedInstance.addWaifuToCurrent(waifu: self.oppoWaifu)
                }
                
                if (self.oppoPV <= 0 || self.playPV <= 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
