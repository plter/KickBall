//
//  GameOverScene.cpp
//  KickBallCocos
//
//  Created by plter on 14-6-13.
//
//

#include "GameOverScene.h"
#include "GameScene.h"
#include <time.h>
#include <iostream>


Scene* GameOver::createScene(clock_t time){
    auto s = Scene::create();
    auto l = GameOver::create(time);
    s->addChild(l);
    return s;
}

GameOver * GameOver::create(clock_t time){
    auto go = new GameOver();
    go->init(time);
    go->autorelease();
    return go;
}

bool GameOver::init(clock_t time){
    Layer::init();
    
    
    Size size = Director::getInstance()->getVisibleSize();
    
    //add background
    auto bg = Sprite::create("bg.png");
    addChild(bg);
    bg->cocos2d::Node::setPosition(size.width/2, size.height/2);
    
    restartLabel = Label::create();
    restartLabel->setSystemFontSize(32);
    restartLabel->setPosition(size.width/2, size.height/2+100);
    addChild(restartLabel);
    restartLabel->setString(StringUtils::format("游戏结束，用时%g，点击这里重新开始",((double)time)/CLOCKS_PER_SEC));
    
    //add touch listener
    touchListener = EventListenerTouchOneByOne::create();
    touchListener->onTouchBegan = [this](Touch * t,Event *e){
        if (restartLabel->getBoundingBox().containsPoint(t->getLocation())) {
            Director::getInstance()->getEventDispatcher()->removeEventListener(touchListener);
            
            Director::getInstance()->replaceScene(Game::createScene());
        }
        return false;
    };
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(touchListener,this);
    
    return true;
}