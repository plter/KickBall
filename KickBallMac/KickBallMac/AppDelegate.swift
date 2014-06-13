//
//  AppDelegate.swift
//  KickBallMac
//
//  Created by plter on 14-6-13.
//  Copyright (c) 2014年 eoe. All rights reserved.
//


import Cocoa
import SpriteKit

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow
    @IBOutlet var skView: SKView
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        let scene = GameScene(size: self.skView.frame.size)
        
        scene.scaleMode = .AspectFill
        
        self.skView.presentScene(scene)
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.skView.ignoresSiblingOrder = true
        
        self.skView.showsFPS = true
        self.skView.showsNodeCount = true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true;
    }
}
