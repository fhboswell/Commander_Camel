//
//  MenueNode.h
//  Runner
//
//  Created by Henry Boswell on 2/23/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCNode.h"

#import "cocos2d-ui.h"
#import "GameScene.h"
#import "DemiNode.h"

@interface MenueNode : CCNode

-(void)setAbove:(GameScene*)game;
-(void)setLateral:(DemiNode*)demi;

@end
