//
//  HeartNode.h
//  Runner
//
//  Created by Aaron Boswell on 2/16/14.
//  Copyright 2014 Aaron Boswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HeartNode : CCNode {
    NSMutableArray* hearts;
}
-(BOOL)subtractLife;
-(void)addLife:(BOOL)animate;
-(BOOL)maxLives;


@end
