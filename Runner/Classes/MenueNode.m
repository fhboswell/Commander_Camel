//
//  MenuScene.m
//  Runner
//
//  Created by Henry Boswell on 2/15/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import "MenueNode.h"
#import "IntroScene.h"
#import "Data.h"
#import "ParallaxBackround.h"
#include "stdlib.h"
#import "GameScene.h"
#import "HeartNode.h"


@implementation MenueNode{
    CCLabelTTF *scoreLabel;
    CCLabelTTF *speedLabel;
    CCLabelTTF *healthLabel;
    CCLabelTTF *damLabel;
    CCLabelTTF *luckLabel;
    CCLabelTTF *ncLabel;
    
    CCButton *backButton;
    CCButton *speedButton;
    CCButton *healthButton;
    CCButton *damButton;
    CCButton *luckButton;
    
    GameScene* gameOwner;
    DemiNode* demiBro;
    
    CCNodeColor *gbSpeed;
    CCNodeColor *rbSpeed;
    
    CCNodeColor *gbDam;
    CCNodeColor *rbDam;
    
    CCNodeColor *gbLuck;
    CCNodeColor *rbLuck;
    
    CCLabelTTF* coinLabel;
    CCSprite *coinLabelImage;
    
    HeartNode* heartNode;
    
    float luckBought;
    float damBought;
    float speedBought;
    
    
    
}



// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    
    self = [super init];
    if (!self) return(nil);

    
    CGSize screen = [[CCDirector sharedDirector] viewSize];

    //coin stuff
    coinLabelImage = [CCSprite spriteWithImageNamed:@"coin1.png"];
    coinLabelImage.position = CGPointMake(screen.width - 180, screen.height -100);
    coinLabelImage.scale = 40/coinLabelImage.boundingBox.size.width;
    
    [self addChild:coinLabelImage z:15];
    coinLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x%-5.0f", [Data coins]] fontName:@"Marker Felt" fontSize:40];
    [coinLabel setHorizontalAlignment:CCTextAlignmentLeft];
    // coinLabel.positionType = CCPositionTypeNormalized;
    coinLabel.position = ccp(screen.width - 100, screen.height -100); // Top Right of screen
    [self addChild:coinLabel];
    
    coinLabel.outlineColor = [CCColor blackColor];
    coinLabel.outlineWidth = 1.5f;
    
    
    
    /*
    backButton = [CCButton buttonWithTitle:@"[ back ]" fontName:@"Verdana-Bold" fontSize:30.0f];
    backButton.position = ccp(screen.width*0.85f, screen.height*0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
     */
    
    
    speedBought = ([Data speed] - [Data defaultSpeed])/(([Data maxSpeed]-[Data defaultSpeed])/15);
    luckBought = ([Data luck] - [Data defaultLuck])/(([Data maxLuck]-[Data defaultLuck])/15);
    damBought = ([Data damage] - [Data defaultDamage])/(([Data maxDamage]-[Data defaultDamage])/15);
    
    CCLabelTTF *healthCost = [CCLabelTTF labelWithString:@"1 Heart for 50 coins" fontName:@"Verdana-Bold" fontSize:20.0f];
    healthCost.position = ccp(screen.width*0.20f+10, screen.height*0.60f+55);
    [self addChild:healthCost];

    healthButton = [CCButton buttonWithTitle:@"[BUY]" fontName:@"Verdana-Bold" fontSize:30.0f];
    healthButton.position = ccp(screen.width*0.20f+10, screen.height*0.60f+20);
    [healthButton setLabelColor:[CCColor greenColor] forState:CCControlStateDisabled];
    [healthButton setTarget:self selector:@selector(onHealthClicked:)];
    [self addChild:healthButton];
    
    heartNode = [HeartNode new];
    [self addChild:heartNode];
    heartNode.scale = 1.0f/1.25f;
    heartNode.position = CGPointMake(heartNode.position.x,screen.height/3.0f - 50);
    
    
    speedButton = [CCButton buttonWithTitle:[NSString stringWithFormat:@"[Slow:%4.0f coins]",((2.0f*(powf(speedBought, 2.0f)))+10.0f)] fontName:@"Verdana-Bold" fontSize:20.0f];
    
    speedButton.position = ccp(screen.width*0.6f-80, screen.height*0.50f +11);
    [speedButton setTarget:self selector:@selector(onSpeedClicked:)];
    [self addChild:speedButton];
    

        
    gbSpeed = [CCNodeColor nodeWithColor:[CCColor greenColor] width:150 height:20.0f];
    gbSpeed.position = CGPointMake(screen.width*0.65f, screen.height*0.50f);
    [self addChild:gbSpeed z:3];
    gbSpeed.scaleX = ([Data speed]-[Data defaultSpeed])/([Data maxSpeed]-[Data defaultSpeed]);
    
    rbSpeed = [CCNodeColor nodeWithColor:[CCColor redColor] width:150 height:20.0f];
    rbSpeed.position = CGPointMake(screen.width*0.65f, screen.height*0.50f);
    [self addChild:rbSpeed z:2];
        
  
    
    
    damButton = [CCButton buttonWithTitle:[NSString stringWithFormat:@"[Focus:%4.0f coins]",((2.0f*(powf(damBought, 2.0f)))+10.0f)] fontName:@"Verdana-Bold" fontSize:20.0f];
    damButton.position = ccp(screen.width*0.60f-80, screen.height*0.30f+11);
    [damButton setTarget:self selector:@selector(onDamClicked:)];
    [self addChild:damButton];
    
    
    gbDam = [CCNodeColor nodeWithColor:[CCColor greenColor] width:150 height:20.0f];
    gbDam.position = CGPointMake(screen.width*0.65f, screen.height*0.30f);
    [self addChild:gbDam z:5];
    gbDam.scaleX = ([Data damage]-[Data defaultDamage])/([Data maxDamage]-[Data defaultDamage]);
    
    rbDam = [CCNodeColor nodeWithColor:[CCColor redColor] width:150 height:20.0f];
    rbDam.position = CGPointMake(screen.width*0.65f, screen.height*0.30f);
    [self addChild:rbDam z:4];
        
    
 
    
    
    luckButton = [CCButton buttonWithTitle:[NSString stringWithFormat:@"[Relax:%4.0f coins]",((2.0f*(powf(luckBought, 2.0f)))+10.0f)] fontName:@"Verdana-Bold" fontSize:20.0f];
    luckButton.position = ccp(screen.width*0.60f-80, screen.height*0.10f+11);
    [luckButton setTarget:self selector:@selector(onLuckClicked:)];
    [self addChild:luckButton];
    
    
    gbLuck = [CCNodeColor nodeWithColor:[CCColor greenColor] width:150 height:20.0f];
    gbLuck.position = CGPointMake(screen.width*0.65f, screen.height*0.10f);
    [self addChild:gbLuck z:7];
    gbLuck.scaleX = ([Data luck]-[Data defaultLuck])/([Data maxLuck]-[Data defaultLuck]);
    
    rbLuck = [CCNodeColor nodeWithColor:[CCColor redColor] width:150 height:20.0f];
    rbLuck.position = CGPointMake(screen.width*0.65f, screen.height*0.10f);
    [self addChild:rbLuck z:6];
    
    [self checkMax];

    
    return self;
}

-(void)checkMax
{
    if([Data speed] >= [Data maxSpeed]) {
        [Data speed:[Data maxSpeed]];
        speedButton.title = @"Max Slow";
        speedButton.enabled = false;
    }
    if([Data health] == [Data maxHealth]){
        [healthButton setTitle:@"Max Health"];
        healthButton.enabled = false;
        healthButton.scale = .6f;
    }
    if([Data damage] == [Data maxDamage]) {
        damButton.title = @"Max Focus";
        [Data damage:[Data maxDamage]];
        damButton.enabled = false;
    }
    if([Data luck] == [Data maxLuck]) {
        luckButton.title = @"Max Relax";
        [Data luck:[Data luck]];
        luckButton.enabled = false;
        
    }
}


- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [demiBro onEnter];
    [gameOwner hideMenu];
    //[[CCDirector sharedDirector] resume];
    
}

- (void)onSpeedClicked:(id)sender
{
    // back to intro scene with transition
    if([Data speed] < [Data maxSpeed] && [Data coins] > ((2.0f*(powf(speedBought, 2.0f)))+10.0f))
    {
        [Data speed:[Data speed]+([Data maxSpeed]-[Data defaultSpeed])/15];
        [Data coins:[Data coins]-((2.0f*(powf(speedBought, 2.0f)))+10.0f)];
        [coinLabel setString:[NSString stringWithFormat:@"x%-5.0f", [Data coins]]];
        [Data saveData];
        [gbSpeed stopAllActions];
        [gbSpeed runAction:[CCActionScaleTo actionWithDuration:.5f scaleX:([Data speed]-[Data defaultSpeed])/([Data maxSpeed]-[Data defaultSpeed]) scaleY:1]];
        speedBought = ([Data speed] - [Data defaultSpeed])/(([Data maxSpeed]-[Data defaultSpeed])/15);
        [speedButton setTitle:[NSString stringWithFormat:@"[Slow:%4.0f coins]",((2.0f*(powf(speedBought, 2.0f)))+10.0f)]];


    }
    else if([Data speed] >= [Data maxSpeed]) {

    }
    else{
        CCActionFiniteTime* tint = [CCActionTintTo actionWithDuration:.2f color:[CCColor redColor]];
        CCActionFiniteTime* tintOff = [CCActionTintTo actionWithDuration:1.0f color:[CCColor whiteColor]];
        [coinLabel runAction:[CCActionSequence actions:tint,tintOff, nil]];
    }
    [self checkMax];

}

- (void)onHealthClicked:(id)sender
{
    // back to intro scene with transition
    if([Data health]<[Data maxHealth] && [Data coins] > 50){
        [heartNode addLife:true];
        [Data coins:[Data coins]-50];
        [scoreLabel setString:[NSString stringWithFormat:@"%0.f", [Data coins]]];
        [Data saveData];
    }
    [self checkMax];

    
    
    
}

- (void)onDamClicked:(id)sender
{
    if([Data damage] < [Data maxDamage] && [Data coins] > ((2.0f*(powf(damBought, 2.0f)))+10.0f))
    {
        [Data damage:[Data damage]+([Data maxDamage]-[Data defaultDamage])/15];
        [Data coins:[Data coins]-((2.0f*(powf(damBought, 2.0f)))+10.0f)];
        [coinLabel setString:[NSString stringWithFormat:@"x%-5.0f", [Data coins]]];
        [Data saveData];
        [gbDam stopAllActions];
        [gbDam runAction:[CCActionScaleTo actionWithDuration:.5f scaleX:([Data damage]-[Data defaultDamage])/([Data maxDamage]-[Data defaultDamage]) scaleY:1]];
        damBought = ([Data damage] - [Data defaultDamage])/(([Data maxDamage]-[Data defaultDamage])/15);
        [damButton setTitle:[NSString stringWithFormat:@"[Focus:%4.0f coins]",((2.0f*(powf(damBought, 2.0f)))+10.0f)]];

    }
    else if([Data damage] == [Data maxDamage]) {

    }
    else{
        CCActionFiniteTime* tint = [CCActionTintTo actionWithDuration:.2f color:[CCColor redColor]];
        CCActionFiniteTime* tintOff = [CCActionTintTo actionWithDuration:1.0f color:[CCColor whiteColor]];
        [coinLabel runAction:[CCActionSequence actions:tint,tintOff, nil]];
    }
    [self checkMax];


    
    
}

- (void)onLuckClicked:(id)sender
{
    if([Data luck] < [Data maxLuck] && [Data coins] > ((2.0f*(powf(luckBought, 2.0f)))+10.0f))
    {
        [Data luck:[Data luck]+([Data maxLuck]-[Data defaultLuck])/15];
        [Data coins:[Data coins]-((2.0f*(powf(luckBought, 2.0f)))+10.0f)];
        [coinLabel setString:[NSString stringWithFormat:@"x%-5.0f", [Data coins]]];
        [Data saveData];
        [gbLuck stopAllActions];
        [gbLuck runAction:[CCActionScaleTo actionWithDuration:.5f scaleX:([Data luck]-[Data defaultLuck])/([Data maxLuck]-[Data defaultLuck]) scaleY:1]];
        luckBought = ([Data luck] - [Data defaultLuck])/(([Data maxLuck]-[Data defaultLuck])/15);
        [luckButton setTitle:[NSString stringWithFormat:@"[Relax:%4.0f coins]",((2.0f*(powf(luckBought, 2.0f)))+10.0f)]];
        

    }
    else if([Data luck] == [Data maxLuck]) {


    }
    else{
        CCActionFiniteTime* tint = [CCActionTintTo actionWithDuration:.2f color:[CCColor redColor]];
        CCActionFiniteTime* tintOff = [CCActionTintTo actionWithDuration:1.0f color:[CCColor whiteColor]];
        [coinLabel runAction:[CCActionSequence actions:tint,tintOff, nil]];
    }
    [self checkMax];
    
    
    
}

-(void)setAbove:(GameScene *)game
{
    gameOwner = game;
}
-(void)setLateral:(DemiNode *)demi;
{
    demiBro = demi;
}


@end
