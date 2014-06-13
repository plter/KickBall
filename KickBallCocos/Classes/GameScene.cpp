#include "GameScene.h"
#include "GameOverScene.h"

USING_NS_CC;

Scene* Game::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::createWithPhysics();
    scene->getPhysicsWorld()->setGravity(Vec2(0, -2000));
    //pause physics world
    scene->unscheduleUpdate();
    
    // 'layer' is an autorelease object
    auto layer = Game::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool Game::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !Layer::init() )
    {
        return false;
    }
    
    _gameStarted = false;
    
    Size size = Director::getInstance()->getVisibleSize();
    //init flags array
    for (int i=1; i<=11; i++) {
        flags.push_back(StringUtils::format("flag%d.png",i));
    }
    
    //add bg or edge
    auto background = Sprite::create("bg.png");
    background->setPosition(size.width/2, size.height/2);
    addChild(background);
    background->setPhysicsBody(PhysicsBody::createEdgeBox(background->getContentSize()));
    background->getPhysicsBody()->setContactTestBitmask(MASK_EDGE);
    
    //add start screen label
    startScreenLabel = Label::create();
    addChild(startScreenLabel);
    startScreenLabel->setSystemFontSize(40);
    startScreenLabel->setString("Press screen to start game");
    startScreenLabel->setPosition(size.width/2, size.height/2);
    
    //add ball
    ball = Sprite::create("ball.png");
    addChild(ball);
    ball->setPhysicsBody(PhysicsBody::createCircle(ball->getContentSize().width/2));
    ball->getPhysicsBody()->setContactTestBitmask(MASK_BALL);
    ball->setPosition(size.width/2, size.height/2+200);
    
    //add touch listener
    touchListener = EventListenerTouchOneByOne::create();
    touchListener->onTouchBegan = [this](Touch* t,Event * e){
        this->onTouch(t);
        return false;
    };
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(touchListener, this);
    
    //add physics contact listener
    physicsContactListener = EventListenerPhysicsContact::create();
    physicsContactListener->onContactBegin = [this](PhysicsContact & contact){
        switch (contact.getShapeA()->getBody()->getContactTestBitmask()|contact.getShapeB()->getBody()->getContactTestBitmask()) {
            case MASK_EDGE|MASK_FLAG:
                if (contact.getShapeA()->getBody()->getContactTestBitmask()==MASK_FLAG) {
                    contact.getShapeA()->getBody()->getNode()->removeFromParent();
                }
                if (contact.getShapeB()->getBody()->getContactTestBitmask()==MASK_FLAG) {
                    contact.getShapeB()->getBody()->getNode()->removeFromParent();
                }
                break;
            case MASK_EDGE|MASK_BALL:
                //remove listeners
                Director::getInstance()->getEventDispatcher()->removeEventListener(touchListener);
                Director::getInstance()->getEventDispatcher()->removeEventListener(physicsContactListener);
                
                Director::getInstance()->replaceScene(GameOver::createScene(clock()-startTime));
                break;
            default:
                break;
        }
        
        return true;
    };
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(physicsContactListener, this);
    
    return true;
}


void Game::onTouch(Touch * t){
    if (_gameStarted) {
        //add flag
        auto flag = Sprite::create(flags[rand()%flags.size()]);
        flag->setPhysicsBody(PhysicsBody::createBox(flag->getContentSize()));
        flag->getPhysicsBody()->setContactTestBitmask(MASK_FLAG);
        addChild(flag);
        flag->setPosition(t->getLocation());
        flag->getPhysicsBody()->setVelocity(Vec2(0, 1000));
    }else{
        //start game
        _gameStarted = true;
        getScene()->scheduleUpdate();
        startScreenLabel->setVisible(false);
        startTime = clock();
    }
}

void Game::menuCloseCallback(Ref* pSender)
{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WP8) || (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT)
	MessageBox("You pressed the close button. Windows Store Apps do not implement a close button.","Alert");
    return;
#endif

    Director::getInstance()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
