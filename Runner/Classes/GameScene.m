  //
//  GameScene.m
//  Runner
//
//  Created by Aaron Boswell on 2/11/14.
//  Copyright 2014 Aaron Boswell. All rights reserved.
//

#import "GameScene.h"
#import "IntroScene.h"
#import "ParallaxBackround.h"
#import "Data.h"
#import "HeartNode.h"
#import "DemiNode.h"
#import "MenueNode.h"
#include "stdlib.h"
#import "GameNode.h"
#import "StoreNode.h"

//#import "CCActionCallFunc.h"



@implementation GameScene
{
  
    CCNodeColor *blackBox;
    DemiNode *demiScreen;
    MenueNode *menuScreen;
    GameNode *gameScreen;
    StoreNode *storeScreen;
    CCNodeColor *smallBlackBox;
    bool demi;
    CCSprite *giraffe;
    CCActionRepeatForever* giraffeAnimate;
    ParallaxBackround* pb;
    BOOL play;


}

+ (GameScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Enable touch handling on scene nodexx
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.1f green:.7f blue:2.0f alpha:1.0f]];
    [self addChild:background z:-10];
    pb = [ParallaxBackround new];
    [self addChild:pb z:-9];
    
    smallBlackBox = [CCNodeColor nodeWithColor:[CCColor blackColor] width:screenSize.width height:2.0f];
    smallBlackBox.position = ccp(0,79);
    [self addChild:smallBlackBox z:-8];

   // gameScreen = [[GameNode alloc]init];
   // [gameScreen setAbove:self];
    
    //gameScreen.opacity = 0.0f;
    
   // gameScreen.position = CGPointMake(screenSize.width, 0);
    //[gameScreen setOpacity:0.0f];
    
    //[self addChild:gameScreen z:102];
    //[gameScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:3.0f position:ccp(0, 0)]rate:1.9f]];
    //[gameScreen runAction:[CCActionFadeIn actionWithDuration:3.0f]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Giraffe.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Giraffe.png"];
    [self addChild:spriteSheet];
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=3; i++) {
        [walkAnimFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"%i.png",i]]];
    }

    giraffe = [CCSprite spriteWithSpriteFrame:walkAnimFrames.firstObject];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.2];
    giraffeAnimate =[CCActionRepeatForever actionWithAction: [CCActionAnimate actionWithAnimation:animation]];
    giraffe.position = ccp(-80, 80);
    [self addChild:giraffe z:300];

    
    
    blackBox = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
    
    blackBox.position = ccp(0,0);
    [self addChild:blackBox z:100];
    
    [self firstRun];
    //[self initGameFactors];

    // done
	return self;
}
- (void)dealloc
{
    // clean up code goes here
}



// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if(gameScreen !=nil){
        [gameScreen touched];
    }

}

#pragma mark - Enter & Exit
// -----------------------------------------------------------------------


- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
}
- (void)onExit
{
    // always call super onExit last
    [super onExit];
}
-(void)firstRun{
    play = false;
    demi = true;
    blackBox.opacity = .4f;
    
    demiScreen = [[DemiNode alloc] init:-1];
    [demiScreen setAbove:self];
    demiScreen.position = CGPointMake(0, 0);
    
    
    menuScreen = [[MenueNode alloc]init];
    [menuScreen setAbove:self];
    [menuScreen setLateral:demiScreen];
    menuScreen.position = CGPointMake(0, -400);
    
    [self addChild:menuScreen z:101];
    [self addChild:demiScreen z:100];
    [self bringGiraffeIn];
    //CCActionDelay *delayDemi = [CCActionDelay actionWithDuration:2.0f];
    //CCActionEaseIn *easeDemi = [CCActionEaseIn actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:.4f];
    [demiScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:2.0f position:ccp(0, 0)]rate:4.0f]];
    //[self performSelector:@selector(deconstructGame) withObject:nil afterDelay:3.0f];
    
    

    
}
-(void)bringGiraffeIn{
    //demiScreen.playButton.state = CCControlStateDisabled;
    

    CCActionCallBlock* call = [CCActionCallBlock actionWithBlock:^(void){
        if(pb.paused ==false){
            pb.paused = true;
        }
        [giraffe runAction:giraffeAnimate];
        
    }];
    
    
    CCActionFiniteTime* moveIn = [CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:3.2f position:ccp(80, 80)] rate:2.7f];
    
    CCActionCallBlock* call2 = [CCActionCallBlock actionWithBlock:^(void){
        if(play !=true){
            [giraffe stopAllActions];
        }
    }];
    [giraffe runAction:[CCActionSequence actions:call,moveIn,call2, nil]];
    
}
-(void)gameOver:(float)counter
{
    play = false;
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    float speed = 1.5f*([Data speed]/100);
    float c = counter*0.02f;
    speed = speed - c;
    speed = speed / (screenSize.width -80);
    float speed1 = speed*160.0f;
    [giraffe stopAllActions];
    CCActionMoveTo* giraffeOffScreen = [CCActionMoveTo actionWithDuration:speed1 position:ccp(-80, 80)];
    
    CCActionCallBlock* stop = [CCActionCallBlock actionWithBlock:^(void){
        //[pb stopOverTime:1.0f];
    }];
    CCActionFiniteTime* delay = [CCActionDelay actionWithDuration:1.0f];
    
    CCActionCallFunc* backIn = [CCActionCallFunc actionWithTarget:self selector:@selector(bringGiraffeIn)];

    [giraffe runAction:[CCActionSequence actions:giraffeOffScreen,stop,delay,backIn, nil]];

    
    
    [blackBox runAction:[CCActionFadeTo actionWithDuration:0.8f opacity:0.4f]];
    
    demiScreen = [[DemiNode alloc] init:counter];
    [demiScreen setAbove:self];
    demiScreen.position = CGPointMake(0, -400);
    
    storeScreen = [[StoreNode alloc]init];
    [storeScreen setAbove:self];
    storeScreen.position = CGPointMake(0, -400);
    
    
    menuScreen = [[MenueNode alloc]init];
    [menuScreen setAbove:self];
    [menuScreen setLateral:demiScreen];
    menuScreen.position = CGPointMake(0, -400);
    
    [self addChild:menuScreen z:101];
    [self addChild:demiScreen z:100];
    [self addChild:storeScreen z:102];
    CCActionDelay *delayDemi = [CCActionDelay actionWithDuration:0.7f];
    CCActionEaseIn *easeDemi = [CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.5f position:ccp(0, 0)]rate:3.f];
    //[demiScreen runAction:[CCActionEaseIn actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:.4f]];
    //[self performSelector:@selector(deconstructGame) withObject:nil afterDelay:3.0f];
    [demiScreen runAction:[CCActionSequence actions:delayDemi,easeDemi, nil]];
    
    
}

-(void) play
{
    play = true;
    if(pb.paused ==true){
        pb.paused = false;
    }
    if([giraffe numberOfRunningActions] ==0){
        [giraffe runAction:giraffeAnimate];
    }
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    if(gameScreen != nil){
        [self deconstructGame];
    }
    if(demi)
    {
    [demiScreen runAction:[CCActionEaseBackInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, -400)]]];
    }else
    {
       [demiScreen runAction:[CCActionEaseBackInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 800)]]];
        [menuScreen runAction:[CCActionEaseBackInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, -400)]]];
        
    }
    [blackBox runAction:[CCActionFadeTo actionWithDuration:1.0f opacity:0.0f]];
    [self performSelector:@selector(deconstructScreens) withObject:nil afterDelay:1.9f];
    gameScreen = [[GameNode alloc]init];
    [gameScreen setAbove:self];
    
    //gameScreen.opacity = 0.0f;
    
    gameScreen.position = CGPointMake(screenSize.width, 0);
    //[gameScreen setOpacity:0.0f];
    [self addChild:gameScreen z:102];
    [gameScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:2.7f position:ccp(0, 0)]rate:1.9f]];
    
    //[gameScreen runAction:[CCActionFadeIn actionWithDuration:3.0f]];
    demi = true;
    
}
-(void) deconstructScreens
{
    [self removeChild:demiScreen];
    demiScreen = nil;
    [self removeChild:menuScreen];
    menuScreen = nil;
    [self removeChild:storeScreen];
    storeScreen = nil;
    
}
-(void) deconstructGame
{
    [self removeChild:gameScreen];
    gameScreen = nil;
    
}


-(void) showMenu
{
    demi = false;
    [demiScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 400)]rate:1.9f]];
    [menuScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:1.9f]];
}
-(void) hideMenu
{
    [demiScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:1.9f]];
    [menuScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, -400)]rate:1.9f]];
    
}
-(void) backToMenu
{
    [demiScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 400)]rate:1.9f]];
    [menuScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:1.9f]];
    [storeScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, -400)]rate:1.9f]];
}
-(void) showStore
{
    [demiScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 800)]rate:1.9f]];
    [menuScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 400)]rate:1.9f]];
    [storeScreen runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:1.9f]];
}

@end
