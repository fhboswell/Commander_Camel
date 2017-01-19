//
//  DemiNode.m
//  Runner
//
//  Created by Henry Boswell on 2/17/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import "DemiNode.h"
#import "GameScene.h"
#import "Data.h"

@implementation DemiNode
{
    CCLabelTTF *hsLabel;
    CCLabelTTF *demiScoreLabel;
    CCLabelTTF *coinsLabel;
    
    GameScene *gameOwner;
    
    
}
@synthesize playButton;

-(id)init:(int)score
{
    self = [super init];
    if (!self) return(nil);
    
   // [Data coins:(score+[Data coins])];
   // [Data saveData];
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    //CCNodeColor *blackBox = [CCNodeColor nodeWithColor:[CCColor blackCol]];
    
    
    NSString *playButtonString = (score == -1)?@"[ Play ]":@"[ Play ]";
    playButton = [CCButton buttonWithTitle:playButtonString fontName:@"Verdana-Bold" fontSize:50.0f];
   // playButton.positionType = CCPositionTypeNormalized;
   // playButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    
    playButton.position = ccp(screenSize.width*(0.7f),70);
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    
    [self addChild:playButton z:2];
    
    coinsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Coins: %0.f", [Data coins]] fontName:@"Marker Felt" fontSize:30];
    coinsLabel.outlineColor = [CCColor blackColor];
    coinsLabel.outlineWidth = 1.0f;
    coinsLabel.position = ccp(screenSize.width*(0.7), 125); // Top Right of screen
    [self addChild:coinsLabel];
    
    CCButton *menuButton = [CCButton buttonWithTitle:@"\n [ Spend Coins ] \n" fontName:@"Marker Felt" fontSize:35];
    menuButton.position = ccp(screenSize.width*(0.25), 170);
    [menuButton setTarget:self selector:@selector(onMenuClicked:)];
    [self addChild:menuButton];
    

    
    
    
    CCLabelTTF *hslabel = [CCLabelTTF labelWithString:@"NEW HIGH SCORE" fontName:@"Arial Rounded MT Bold" fontSize:40.0f];
    hslabel.outlineColor = [CCColor blackColor];
    hslabel.outlineWidth = 2.0f;
    hslabel.color = [CCColor cyanColor];
    hslabel.position = ccp(screenSize.width/2,screenSize.height - 40); // Middle of screen
    [self addChild:hslabel];
    

    if (score > [Data HS])
    {
        
        [Data HS:score];
        [Data saveData];
        
    }else if (score > ([Data HS]*0.75f))
    {
        [hslabel setString:@"SO CLOSE TRY AGAIN"];
        
    }else if (score > ([Data HS]*0.50f))
    {
        [hslabel setString:@"Better luck next time"];
    }
    else if (score > ([Data HS]*0.20f))
    {
        [hslabel setString:@"I've Seen better"];
    }
    else if (score < ([Data HS]/0.20f))
    {
        [hslabel setString:@"GO HOME!!!!"];
    }
    
    hsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"High Score: %0.f", [Data HS]] fontName:@"Marker Felt" fontSize:30];
    hsLabel.outlineWidth = 1.0f;
    hsLabel.outlineColor = [CCColor blackColor];
    
    hsLabel.position = ccp(screenSize.width*(0.70), 175); // Top Right of screen
    [self addChild:hsLabel];
    
    demiScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"This Round: %d", score] fontName:@"Marker Felt" fontSize:30];
    demiScoreLabel.outlineWidth = 1.0f;
    demiScoreLabel.outlineColor = [CCColor blackColor];
    demiScoreLabel.position = ccp(screenSize.width*(0.70), 225); // Top Right of screen
    [self addChild:demiScoreLabel];
    
    
    
    if(score == -1){
        [hslabel setString:@"Commander\nCamel!"];
        hslabel.fontSize = 80;
        hslabel.horizontalAlignment = CCTextAlignmentCenter;
        hslabel.position = ccp(hslabel.position.x,hslabel.position.y-40);
        demiScoreLabel.visible = false;
        hsLabel.visible = false;
        coinsLabel.visible = false;
        menuButton.visible = false;
    }
    
    return self;
    }


     //coinsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Coins: %0.f", [Data coins]] fontName:@"Marker Felt" fontSize:30];
    

-(void)setAbove:(GameScene *)game
{
    gameOwner = game;
}

- (void)onMenuClicked:(id)sender
{
    // start spinning scene with transition
 //   [[CCDirector sharedDirector] pushScene:[MenuScene scene]];
    
    [gameOwner showMenu];
    [self performSelector:@selector(showPlay) withObject:nil afterDelay:2.0f];
    
    
}
-(void)showPlay
{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    [playButton runAction:[CCActionEaseIn actionWithAction:[CCActionMoveTo actionWithDuration:1.5f position:ccp(screenSize.width*(0.75f), -125)]rate:.4f]];
}


- (void)onPlayClicked:(id)sender
{
    // back to intro scene with transition
    //[[CCDirector sharedDirector] replaceScene:[GameScene scene]withTransition:[CCTransition transitionCrossFadeWithDuration:0.7f]];
    playButton.enabled = false;
    [gameOwner play];
    
}

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    //coinsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Coins: %0.f", [Data coins]] fontName:@"Marker Felt" fontSize:30];
    [coinsLabel setString:[NSString stringWithFormat:@"Coins: %0.f", [Data coins]]];
    
}

@end
