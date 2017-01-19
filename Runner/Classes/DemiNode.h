//
//  DemiNode.h
//  Runner
//
//  Created by Henry Boswell on 2/17/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCNode.h"
#import "GameScene.h"
#import "cocos2d-ui.h"

@interface DemiNode : CCNode
@property CCButton *playButton;
-(id)init:(int)score;

-(void)setAbove:(GameScene*)game;


@end
