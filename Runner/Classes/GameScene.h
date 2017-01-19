//
//  GameScene.h
//  Runner
//
//  Created by Aaron Boswell on 2/11/14.
//  Copyright 2014 Aaron Boswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCAnimation.h"


@interface GameScene : CCScene {
    
}
+ (GameScene *)scene;
- (id)init;
//- (void) runAgain;
//-(void) die;
//-(void)chFail;
//-(void)whiteFlash;
//-(void)killEnemy;
-(void)showMenu;
-(void)hideMenu;
//-(void)play;
//-(void)initGameFactors;
-(void)gameOver:(float)score;
-(void)play;
-(void) deconstructGame;
-(void) deconstructScreens;
-(void)firstRun;
-(void)backToMenu;
-(void)showStore;

@end
