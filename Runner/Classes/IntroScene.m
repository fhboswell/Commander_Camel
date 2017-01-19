//
//  IntroScene.m
//  Runner
//
//  Created by Aaron Boswell on 2/11/14.
//  Copyright Aaron Boswell 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "GameScene.h"
#import "Data.h"


// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene
{
    CCSprite *giraffe;
    bool ready;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
   // [Data coins:500];
   // [Data saveData];
    ready = false;
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Giraffe Jaunt" fontName:@"Chalkduster" fontSize:40.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Spinning scene button
    CCButton *spinningButton = [CCButton buttonWithTitle:@"[ Prance! ]" fontName:@"Verdana-Bold" fontSize:12.0f];
    spinningButton.positionType = CCPositionTypeNormalized;
    spinningButton.position = ccp(0.5f, 0.35f);
    [spinningButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:spinningButton];
    
    /*
    CCButton *menuButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:30.0f];
    menuButton.positionType = CCPositionTypeNormalized;
    menuButton.position = ccp(0.85f, 0.95f);
    [menuButton setTarget:self selector:@selector(onMenuClicked:)];
    [self addChild:menuButton];
    */
    
    [self runAgain];
    /*
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Giraffe.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Giraffe.png"];
    [self addChild:spriteSheet];
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=3; i++) {
        [walkAnimFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"%i.png",i]]];
    }
    
    CCSprite *giraffe = [CCSprite spriteWithSpriteFrame:walkAnimFrames.firstObject];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.2];
    [giraffe runAction:[CCActionRepeatForever actionWithAction: [CCActionAnimate actionWithAnimation:animation]]];
    [self addChild:giraffe z:10];
    giraffe.position = ccp(80, 80);
    
    CCSprite *giraffe2 = [CCSprite spriteWithSpriteFrame:walkAnimFrames.firstObject];
    [giraffe2 runAction:[CCActionRepeatForever actionWithAction: [CCActionAnimate actionWithAnimation:animation]]];
    [self addChild:giraffe2 z:10];
    giraffe2.position = ccp(80, 280);
    
    CCSprite *giraffe3 = [CCSprite spriteWithSpriteFrame:walkAnimFrames.firstObject];
    [giraffe3 runAction:[CCActionRepeatForever actionWithAction: [CCActionAnimate actionWithAnimation:animation]]];
    [self addChild:giraffe3 z:10];
    giraffe3.position = ccp(400, 80);
    
    CCSprite *giraffe4 = [CCSprite spriteWithSpriteFrame:walkAnimFrames.firstObject];
    [giraffe4 runAction:[CCActionRepeatForever actionWithAction: [CCActionAnimate actionWithAnimation:animation]]];
    [self addChild:giraffe4 z:10];
    giraffe4.position = ccp(400, 280);
    */
    
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f]];
    [self addChild:background z:1];
    [background runAction:[CCActionFadeTo actionWithDuration:2.0f opacity:1.0f]];
    //[background runAction:[CCActionFadeIn actionWithDuration:.5f]];
    
    [Data speed];
    ready = true;
    // start spinning scene with transition
    
}

/*
- (void)onMenuClicked:(id)sender
{
    // start spinning scene with transition

    [[CCDirector sharedDirector] pushScene:[MenuScene scene]];

}
*/

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
}

// -----------------------------------------------------------------------

#pragma mark - Selectors
- (void) runAgain
{
    if (ready)
    {
        //[[CCDirector sharedDirector] replaceScene:[GameScene scene] withTransition:[CCTransition transitionFadeWithColor:[CCColor whiteColor] duration:.5f]];
        ready = false;
        [self runAgain];
        [[CCDirector sharedDirector] replaceScene:[GameScene scene]withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
    }
    [self unschedule:@selector(runAgain)];
    
    //CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    giraffe.visible = NO;
    [giraffe stopAllActions];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Giraffe.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Giraffe.png"];
    [self addChild:spriteSheet];
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=3; i++) {
        [walkAnimFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"%i.png",i]]];
    }
    
    giraffe = [CCSprite spriteWithSpriteFrame:walkAnimFrames.firstObject];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.2];
    [giraffe runAction:[CCActionRepeatForever actionWithAction: [CCActionAnimate actionWithAnimation:animation]]];
    giraffe.position = ccp(-80, 80);
    
    
    
    
   // [giraffe runAction:[CCActionMoveTo actionWithDuration:3.0f position:ccp(650, 80)]];
    
    CCActionMoveTo* giraffeMove = [CCActionMoveTo actionWithDuration:3.0f position:ccp(650, 80)];
    CCActionCallFunc* giraffeCall = [CCActionCallFunc actionWithTarget:self selector:@selector(runAgain)];
    [giraffe runAction:[CCActionSequence actions:giraffeMove, giraffeCall, nil]];
    [self addChild:giraffe z:2];
    
    
}

@end
