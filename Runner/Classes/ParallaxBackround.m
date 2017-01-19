//
//  ParallaxBackround.m
//  Runner
//
//  Created by Aaron Boswell on 2/11/14.
//  Copyright 2014 Aaron Boswell. All rights reserved.
//

#import "ParallaxBackround.h"


@implementation ParallaxBackround
{
    float slow;
}
-(id)init{
    self = [super init];
    if (!self) return(nil);
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    slow = 1;
    int num = 4;
    sprites = [[NSMutableArray alloc] initWithCapacity:num];
    for(int i = 0; i < num; i++){
        
        if(i == 0){
            CCSprite* sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%ibg.png",i+1]];
            sprite.scaleX = (3+screenSize.width) / sprite.boundingBox.size.width;
            sprite.scaleY = (screenSize.height / sprite.boundingBox.size.height)+.05f;
            sprite.position = CGPointMake(screenSize.width/2,(screenSize.height/2)+15);
            [self addChild:sprite z:-i];
            [sprites addObject:sprite];
            
            sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%ibg.png",i+1]];
            sprite.scaleX = (3+screenSize.width) / sprite.boundingBox.size.width;
            sprite.scaleY = (screenSize.height / sprite.boundingBox.size.height)+.05f;
            sprite.position = CGPointMake(3*screenSize.width/2,(screenSize.height/2)+15);
            [self addChild:sprite z:-i];
            [sprites addObject:sprite];
        
        }
        else{
            CCSprite* sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%ibg.png",i+1]];
            sprite.scaleX = (10+screenSize.width) / sprite.boundingBox.size.width;
            sprite.scaleY = screenSize.height / sprite.boundingBox.size.height;
            sprite.position = CGPointMake(screenSize.width/2,(screenSize.height/2)+80);
            [self addChild:sprite z:-i];
            [sprites addObject:sprite];
            
            sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%ibg.png",i+1]];
            sprite.scaleX = (10+screenSize.width) / sprite.boundingBox.size.width;
            sprite.scaleY = screenSize.height / sprite.boundingBox.size.height;
            sprite.position = CGPointMake(3*screenSize.width/2,(screenSize.height/2)+80);
            [self addChild:sprite z:-i];
            [sprites addObject:sprite];
       }
        
    }
    
    
    return self;
}
-(void)stopOverTime:(int)t{
    [self schedule:@selector(slowDown) interval:(t*.2F) repeat:10 delay:0.0f];
}
-(void)setPaused:(BOOL)paused{
    [super setPaused:paused];
    [self unschedule:@selector(slowDown)];
    if(paused == true){
        slow = 1;
    }
}
-(void)slowDown{
    slow = slow*(.6);
    if(slow == .1){
        [self unschedule:@selector(slowDown)];
    }
}
-(void) update:(CCTime)delta
{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    int num = [sprites count];
    for(int i = 0; i < num; i++){
        CCSprite* sprite = [sprites objectAtIndex:i];
        CGPoint pos = sprite.position;

        if(sprite.zOrder == 0){
            pos.x -=(15)*(delta*20*slow);

        }
        else{
            pos.x -=(5 + sprite.zOrder)*(delta*20*slow);

        }
        
        if(pos.x<-screenSize.width/2){
            pos.x = 3*screenSize.width/2;
        }
        sprite.position = pos;

    }

}
@end
