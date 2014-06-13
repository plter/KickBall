#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"

class Game : public cocos2d::Layer
{
    
private:
    cocos2d::Label * startScreenLabel;
    cocos2d::Sprite * ball;
    bool _gameStarted;
    std::vector<std::string> flags;
    cocos2d::EventListenerPhysicsContact * physicsContactListener;
    cocos2d::EventListenerTouchOneByOne * touchListener;
    clock_t startTime;
    
private:
    static const int MASK_EDGE = 0b1;
    static const int MASK_BALL = 0b10;
    static const int MASK_FLAG = 0B100;
    
private:
    void onTouch(cocos2d::Touch *);
    
public:
    // there's no 'id' in cpp, so we recommend returning the class instance pointer
    static cocos2d::Scene* createScene();

    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
    virtual bool init();  
    
    // a selector callback
    void menuCloseCallback(cocos2d::Ref* pSender);
    
    // implement the "static create()" method manually
    CREATE_FUNC(Game);
};

#endif // __HELLOWORLD_SCENE_H__
