//
//  ParallaxBackround.h
//  Runner
//
//  Created by Aaron Boswell on 2/11/14.
//  Copyright 2014 Aaron Boswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackround : CCNode {
    NSMutableArray* sprites;
}
-(void)stopOverTime:(int)t;

@end
