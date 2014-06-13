//
//  GameOverScene.swift
//  KickBalliOS
//
//  Created by plter on 14-6-13.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene:SKScene{
    init(size: CGSize) {
        super.init(size:size)
        
        var label = SKLabelNode()
        label.text = "游戏结束"
        label.position = CGPoint(x: size.width/2,y: size.height/2)
        addChild(label)
    }
}