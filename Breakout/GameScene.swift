//
//  GameScene.swift
//  Breakout
//
//  Created by daniell Escareno on 3/30/26.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball = SKShapeNode()
    
    override func didMove(to view: SKView) {
        // this stuff happens once (when the app opens)
        createBackground()
        resetGame()
    }
    
    func resetGame() {
        // this stuff happens before each game starts 
        makeBall()
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "Stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy(x:0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let repeatForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(repeatForever)
        }
    }
    
    func makeBall() {
        ball.removeFromParent() // remove the ball (if it exist)
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .yellow
        ball.name = "ball"
        
        // physics shape matches ball images
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // ignores all forces that are impulses
        ball.physicsBody?.isDynamic = false
        // use percise collision dedection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        //  no loss of energy from collison
        ball.physicsBody?.friction = 0
        // gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        // bounces fully off of objects
        ball.physicsBody?.restitution = 1
        // does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball) // add ball object to the view
        
    }
}
