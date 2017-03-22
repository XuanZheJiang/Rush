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
        
        startGame()
        
        enemyL = self.childNode(withName: "enemyL") as! SKLabelNode
        mineL = self.childNode(withName: "mineL") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        mine = self.childNode(withName: "mine") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame() {
        score = [0,0]
        enemyL.text = "\(score[1])"
        mineL.text = "\(score[0])"
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == mine {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
        enemyL.text = "\(score[1])"
        mineL.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            mine.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            mine.run(SKAction.moveTo(x: location.x, duration: 0))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= mine.position.y - 70 {
            addScore(playerWhoWon: enemy)
        } else if ball.position.y >= enemy.position.y + 70{
            addScore(playerWhoWon: mine)
        }
    }
}
