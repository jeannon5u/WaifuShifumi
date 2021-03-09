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
    
    @IBOutlet var textResultat: UILabel!
    
    @IBOutlet var playProgress: UIProgressView!
    @IBOutlet var oppoProgress: UIProgressView!
    
    @IBOutlet var playPVText: UILabel!
    @IBOutlet var oppoPVText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textResultat.text = ""
        background.image = UIImage(named: "background_shifumi")
        playProgress.setProgress(1.0, animated: false)
        oppoProgress.setProgress(1.0, animated: false)
        playPVText.text = "PV : 50/50"
        oppoPVText.text = "PV : 50/50"
        
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
            self.rockButtonOutlet.isHidden = false
            self.paperButtonOutlet.isHidden = false
            self.scissorButtonOutlet.isHidden = false
            self.oppoSelectMove.image = nil
            self.playSelectMove.image = nil
            self.textResultat.text = ""
            self.playProgress.setProgress(self.playPV/50, animated: true)
            self.oppoProgress.setProgress(self.oppoPV/50, animated: true)
            self.playPVText.text = "PV : \(self.playPV)/50"
            self.oppoPVText.text = "PV : \(self.oppoPV)/50"
        }
        
        
        
    }
}
