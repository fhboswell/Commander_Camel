//
//  GameNode.h
//  Runner
//
//  Created by Henry Boswell on 2/23/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import "CCNode.h"
#import "GameScene.h"

@interface GameNode : CCNode

-(id)init;
- (void) runAgain;
-(void) die;
-(void)chFail;
-(void)whiteFlash;
-(void)killEnemy;
-(void)initGameFactors;
-(void)touched;
-(void)setAbove:(GameScene*)game;
-(void)tutorialIsland;

@end
