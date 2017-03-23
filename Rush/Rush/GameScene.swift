//
//  GameScene.swift
//  Rush
//
//  Created by JGCM on 17/3/22.
//  Copyright © 2017年 JGCM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var mine = SKSpriteNode()
    var enemy = SKSpriteNode()
    
    var mineL = SKLabelNode()
    var enemyL = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        enemyL = self.childNode(withName: "enemyL") as! SKLabelNode
        mineL = self.childNode(withName: "mineL") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        mine = self.childNode(withName: "mine") as! SKSpriteNode
        mine.position.y = (-self.frame.height / 2) + 50
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        enemyL.text = "\(score[1])"
        mineL.text = "\(score[0])"
        
        ball.physicsBody?.applyImpulse(CGVector(dx: currentGameType.associatedValue.vx, dy: currentGameType.associatedValue.vy))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == mine {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: currentGameType.associatedValue.vx, dy: currentGameType.associatedValue.vy))
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -currentGameType.associatedValue.vx, dy: -currentGameType.associatedValue.vy))
        }
        
        enemyL.text = "\(score[1])"
        mineL.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            switch currentGameType {
            case .player2:
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0))
                }
                if location.y < 0 {
                    mine.run(SKAction.moveTo(x: location.x, duration: 0))
                }
            default:
                mine.run(SKAction.moveTo(x: location.x, duration: 0))
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            switch currentGameType {
            case .player2:
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0))
                }
                if location.y < 0 {
                    mine.run(SKAction.moveTo(x: location.x, duration: 0))
                }
            default:
                mine.run(SKAction.moveTo(x: location.x, duration: 0))
            }
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.15))
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.10))
        case .player2:
            
            break
        }

        if ball.position.y <= mine.position.y - 30{
            addScore(playerWhoWon: enemy)
        } else if ball.position.y >= enemy.position.y + 30{
            addScore(playerWhoWon: mine)
        }
    }
}
