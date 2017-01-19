//
//  HeartNode.m
//  Runner
//
//  Created by Aaron Boswell on 2/16/14.
//  Copyright 2014 Aaron Boswell. All rights reserved.
//

#import "HeartNode.h"
#import "Data.h"


@implementation HeartNode{
    int lives;
}
-(id)init{
    self = [super init];
    if (!self) return(nil);

    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    lives = [Data health];
    
    int num = [Data maxHealth];
    hearts = [[NSMutableArray alloc] initWithCapacity:num];
    for(int i = 0; i < num; i++){
        CCSprite* sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"heart.png"]];
        int n = i;
        int yOff = 0;
//        if(n>4){
//            n = i-5;
//            yOff=60;
//        }
        sprite.position = CGPointMake(40+n*40,screenSize.height-40-yOff);
        if(lives<(i+1)){
            sprite.visible = NO;
        }
        [self addChild:sprite];
        [hearts addObject:sprite];
        
    }
    return self;
}
-(BOOL)subtractLife{
    lives = lives - 1;
    [Data health:([Data health]-1)];
    [Data saveData];
    CCSprite* sprite = (CCSprite*)[hearts objectAtIndex:lives];
    sprite.visible = NO;
    if(lives<1){
        return false;
    }
    return true;

}
-(void)addLife:(BOOL)animate{
    if(lives == [Data maxHealth]){
        return;
    }
    lives = lives + 1;
    [Data health:([Data health]+1)];
    [Data saveData];
    CCSprite* sprite = (CCSprite*)[hearts objectAtIndex:lives-1];
    if(animate == true){
        sprite.scale = 0;
        [sprite runAction:[CCActionScaleTo actionWithDuration:.3f scale:1]];
    }
    sprite.visible = YES;
}
-(BOOL)maxLives{
    if(lives ==[Data maxHealth]){
        return true;
    }
    return false;
}
@end
