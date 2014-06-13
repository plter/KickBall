//
//  GameScene.swift
//  KickBallMac
//
//  Created by plter on 14-6-13.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

import SpriteKit

let MASK_EDGE:UInt32 = 0b001
let MASK_BALL:UInt32 = 0b010
let MASK_FLAG:UInt32 = 0b100
let flags = ["flag1","flag2","flag3","flag4","flag5","flag6","flag7","flag8","flag9","flag10","flag11"]

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    
    var gameStarted = false
    var myLabel:SKLabelNode!
    var ball:SKSpriteNode!
    var startTime:NSTimeInterval!
    
    init(size: CGSize) {
        super.init(size:size)
        
        //add background
//        var bg = SKSpriteNode(imageNamed: "bg")
//        addChild(bg)
//        bg.position = CGPoint(x: size.width/2,y: size.height/2)
    }
    
    override func didMoveToView(view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody.contactTestBitMask = MASK_EDGE
        self.physicsWorld.contactDelegate = self
        
        backgroundColor = NSColor.grayColor()
        
        /* Setup your scene here */
        myLabel = SKLabelNode()
        myLabel.color = NSColor.blackColor()
        myLabel.text = "点击屏幕开始游戏";
        myLabel.fontSize = 38;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        ball = SKSpriteNode(imageNamed: "ball")
        ball.position = CGPoint(x:self.frame.size.width/2,y:self.frame.size.height-100);
        addChild(ball)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        if gameStarted{
            let flag = SKSpriteNode(imageNamed: flags[Int(arc4random())%flags.count])
            flag.position = theEvent.locationInNode(self)
            addChild(flag)
            flag.physicsBody = SKPhysicsBody(rectangleOfSize: flag.frame.size)
            flag.physicsBody.contactTestBitMask = MASK_FLAG
            flag.physicsBody.velocity = CGVector(0,500)
        }else{
            gameStarted = true
            myLabel.hidden = true
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody.restitution = 0.7
            ball.physicsBody.contactTestBitMask = MASK_BALL
            
            startTime = NSDate().timeIntervalSince1970
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact!){
        
        var bitCode = contact.bodyA.contactTestBitMask|contact.bodyB.contactTestBitMask
        if bitCode == MASK_FLAG|MASK_EDGE{
            if contact.bodyA.contactTestBitMask == MASK_FLAG {
                contact.bodyA.node.removeFromParent()
            }
            if contact.bodyB.contactTestBitMask == MASK_FLAG {
                contact.bodyB.node.removeFromParent()
            }
        }else if bitCode==MASK_BALL|MASK_EDGE{
            self.view.presentScene(GameOverScene(size: self.view.frame.size,time: NSDate().timeIntervalSince1970-startTime))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
