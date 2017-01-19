//
//  Data.h
//  Runner
//
//  Created by Aaron Boswell on 2/15/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Data : NSObject

+(float)speed;
+(float)coins;
+(float)health;
+(float)damage;
+(float)luck;
+(float)HS;

+(float)defaultSpeed;
+(float)defaultHealth;
+(float)defaultDamage;
+(float)defaultLuck;

+(float)maxSpeed;
+(float)maxHealth;
+(float)maxDamage;
+(float)maxLuck;



+(void)speed:(float)s;
+(void)coins:(float)c;
+(void)health:(float)h;
+(void)damage:(float)d;
+(void)luck:(float)l;
+(void)HS:(float)hs;

+(void)saveData;

@end
