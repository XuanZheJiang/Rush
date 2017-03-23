//
//  MenuVC.swift
//  Rush
//
//  Created by JGCM on 17/3/22.
//  Copyright © 2017年 JGCM. All rights reserved.
//

import Foundation
import UIKit

struct Speed {
    
    var vx = 10
    var vy = 10
    
    static let easy = Speed(vx: 10, vy: 10)
    static let medium = Speed(vx: 10, vy: 10)
    static let hard = Speed(vx: 10, vy: 10)
}

enum gameType {
    case easy(Speed)
    case medium(Speed)
    case hard(Speed)
    case player2
    
    var associatedValue: Speed {
        switch self {
        case .easy(let speed), .medium(let speed), .hard(let speed):
            return speed
        default:
            return Speed()
        }
    }
}

class MenuVC: UIViewController {
    
    @IBOutlet weak var player2Btn: UIButton!
    
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    @IBAction func Player2(_ sender: Any) {
        moveToGame(game: .player2)
    }
    
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy(.easy))
    }
    
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium(.medium))
    }
    
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard(.hard))
    }
    
    func moveToGame(game: gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
