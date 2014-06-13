//
//  GameOverScene.h
//  KickBallCocos
//
//  Created by plter on 14-6-13.
//
//

#include <cocos2d.h>

USING_NS_CC;

class GameOver:Layer {
private:
    Label * restartLabel;
    EventListenerTouchOneByOne * touchListener;
    
public:
    virtual bool init(clock_t time);
    static GameOver * create(clock_t time);
    
    static Scene* createScene(clock_t time);
};
