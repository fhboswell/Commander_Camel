//
//  StoreNode.m
//  Runner
//
//  Created by Henry Boswell on 3/4/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import "CCNode.h"
#import "StoreNode.h"

@implementation StoreNode
{
    GameScene* gameOwner;
    CCButton* backButton;
    
}


- (id)init
{
    // Apple recommend assigning self with supers return value
    
    self = [super init];
    if (!self) return(nil);
    
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    
    
    
    NSString *buttonString = @"[ Back ]";
    backButton = [CCButton buttonWithTitle:buttonString fontName:@"Verdana-Bold" fontSize:50.0f];
    backButton.position = ccp(screenSize.width*(0.7f),70);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton z:2];
    
    
    
    
    return self;
    
}



-(void)setAbove:(GameScene *)game
{
    gameOwner = game;
}

-(void)onBackClicked
{
    [gameOwner backToMenu];
}





@end
