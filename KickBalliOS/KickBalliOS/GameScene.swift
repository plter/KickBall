//
//  GameScene.swift
//  KickBalliOS
//
//  Created by plter on 14-6-13.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

import SpriteKit

let MASK_EDGE:UInt32=0b1
let MASK_BALL:UInt32=0b10
let MASK_FLAG:UInt32 = 0b100

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    var gameStarted:Bool!
    var ball:SKSpriteNode!
    var startGameLabel:SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        physicsBody.contactTestBitMask = MASK_EDGE
        
        physicsWorld.contactDelegate = self
        
        ball = childNodeWithName("ball") as SKSpriteNode
        startGameLabel = childNodeWithName("startGameLabel") as SKLabelNode
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if gameStarted {
            //add flag
            var flag = SKSpriteNode(imageNamed: "flag1")
            addChild(flag)
            flag.physicsBody = SKPhysicsBody(rectangleOfSize: flag.frame.size)
            flag.position = touches.anyObject().locationInNode(self)
            flag.physicsBody.contactTestBitMask = MASK_FLAG
            flag.physicsBody.velocity = CGVector(0,500)
        }else{
            gameStarted = true
            
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody.contactTestBitMask = MASK_BALL
            startGameLabel.hidden = true
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact!){
        let maskCode = contact.bodyA.contactTestBitMask|contact.bodyB.contactTestBitMask
        
        if maskCode == MASK_EDGE|MASK_FLAG {
            
            if contact.bodyA.contactTestBitMask==MASK_FLAG{
                contact.bodyA.node.removeFromParent()
            }
            if contact.bodyB.contactTestBitMask==MASK_FLAG{
                contact.bodyB.node.removeFromParent()
            }
        }else if maskCode == MASK_EDGE|MASK_BALL{
//            print("GameOver")
            self.view.presentScene(GameOverScene(size: self.frame.size))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
