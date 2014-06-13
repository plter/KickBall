//
//  GameOverScene.swift
//  KickBallMac
//
//  Created by plter on 14-6-13.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

import Foundation
import SpriteKit


class GameOverScene:SKScene{
    
    var label:SKLabelNode!
    
    init(size: CGSize,time:CGFloat) {
        super.init(size:size)
        
        backgroundColor = NSColor.grayColor()
        
        //add background
        var bg = SKSpriteNode(imageNamed: "bg")
        addChild(bg)
        bg.position = CGPoint(x: size.width/2,y: size.height/2)
        
        label = SKLabelNode()
        label.text = "游戏结束，时长\(time)，点击这里继续"
        label.position = CGPoint(x: size.width/2,y: size.height/2+100)
        addChild(label)
    }
    
    
    override func mouseDown(theEvent: NSEvent!) {
        
        if CGRectContainsPoint(label.frame,theEvent.locationInNode(self)){
            self.view.presentScene(GameScene(size: self.view.frame.size))
        }
    }
    
}