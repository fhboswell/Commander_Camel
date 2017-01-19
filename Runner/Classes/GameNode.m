//
//  GameNode.m
//  Runner
//
//  Created by Henry Boswell on 2/23/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import "GameNode.h"
#import "GameScene.h"
#import "IntroScene.h"
#import "ParallaxBackround.h"
#import "Data.h"
#import "HeartNode.h"
#import "DemiNode.h"
#import "MenueNode.h"
#include "stdlib.h"

@implementation GameNode
{
    CCNodeColor *greenBox;
    CCSprite* enemy;
    HeartNode* liveNode;
    CCSprite* laser;
    CCSprite* fizzle;
    CCNodeColor *flash;
    
    
    int jumpSuccess;
    float speed;
    float counter;
    CCLabelTTF* scoreLabel;
    CCLabelTTF* coinLabel;
    CCLabelTTF* instructionLabel;
    CCLabelTTF* siLabel;
    int bonusThisTime;
    int eType;
    int coinsEarned;
    BOOL tutRan;
    BOOL greenHasMoved;
    CCNodeColor *blackBox;
    CCNodeColor *tutBlackBox;
    CCSprite *coinLabelImage;
    
    
     GameScene *gameOwner;
    
}


- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    [self initGameFactors];
    
    
    //[self runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(0, 0)]rate:1.9f]];
    
    //[self performSelector:@selector(initGameFactors) withObject:nil afterDelay:1.2f];
    
    return self;
    
    
}




-(void) initGameFactors
{
    bonusThisTime = 0;
    eType = 0;
    counter = 0;
    coinsEarned = 0;
    greenHasMoved = false;
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    //-----------
    //***********
    //00000000000
    //-----------
    //tutRan = true;
    
    //start cactus move
    //[self runAgain];
    [self performSelector:@selector(runAgain) withObject:nil afterDelay:4.0f];
    [self performSelector:@selector(tutorialIsland) withObject:nil afterDelay:3.0f];
    if(tutRan == false){
        tutBlackBox = [CCNodeColor nodeWithColor:[CCColor blackColor] width:screenSize.width*3 height:screenSize.height];
        tutBlackBox.position = ccp(-2*screenSize.width,79.0f);
        tutBlackBox.opacity = 0.0f;
        [tutBlackBox runAction:[CCActionFadeTo actionWithDuration:3.0f opacity:.5f]];
    }
    
    
    
    // Create a colored background (sky blue)
    
    //then Parallax backround
    
    
    
    
    //Create yellow and green boxes with red strip under
    //    CCNodeColor *redBox = [CCNodeColor nodeWithColor:[CCColor redColor] width:screenSize.width height:80.0f];
    //    redBox.position = ccp(0,0);
    //    [self addChild:redBox z:-9];
    
    greenBox = [CCNodeColor nodeWithColor:[CCColor yellowColor] width:[Data damage] height:79.0f];
    [self addChild:greenBox z:-8];
    greenBox.position = CGPointMake(180, 0);
    
    greenBox.opacity = .7f;


    
    
    
    
    //blackBox = [CCNodeColor nodeWithColor:[CCColor blackColor] width:screenSize.width height:2.0f];
    //blackBox.position = ccp(0,79);
    //[self addChild:blackBox z:-8];
    
    
    scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%0.f", counter] fontName:@"Marker Felt" fontSize:80];
    //scoreLabel.positionType = CCPositionTypeNormalized;
    //scoreLabel.position = ccp(0.5f, 0.75f); // Top Right of screen
    scoreLabel.position = CGPointMake(screenSize.width/2, screenSize.height -80);
    scoreLabel.outlineColor = [CCColor blackColor];
    scoreLabel.outlineWidth = 3.0f;
    
    [self addChild:scoreLabel z:101];
    
    //[self tutorialIsland];
    
    
    
    
    
    //animated giraffe sprite
        
       
    
    
    laser = [CCSprite spriteWithImageNamed:@"laser.png"];
    laser.position = ccp(180,80);
    laser.visible = NO;
    [self addChild:laser z:15];
    
    fizzle = [CCSprite spriteWithImageNamed:@"fizzle.png"];
    fizzle.position = ccp(110,110);
    fizzle.visible = NO;
    [self addChild:fizzle z:15];
    
    liveNode = [HeartNode new];
    [self addChild:liveNode];
    
    //coin stuff
    coinLabelImage = [CCSprite spriteWithImageNamed:@"coin1.png"];
    coinLabelImage.position = CGPointMake(screenSize.width - 140, screenSize.height -40);
    [self addChild:coinLabelImage z:15];
    coinLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x%-4d", 0] fontName:@"Marker Felt" fontSize:40];
    [coinLabel setHorizontalAlignment:CCTextAlignmentLeft];
    // coinLabel.positionType = CCPositionTypeNormalized;
    coinLabel.position = ccp(screenSize.width - 60, screenSize.height -40); // Top Right of screen
    [self addChild:coinLabel];
    
    coinLabel.outlineColor = [CCColor blackColor];
    coinLabel.outlineWidth = 1.5f;
    
    //[coinLabel setString:@"x1000"];
    flash = [CCNodeColor nodeWithColor:[CCColor redColor]];
    flash.opacity = 0.0f;
    [self addChild:flash z:100];
    
   // [self runAction:[CCActionFadeOut actionWithDuration:1.5f]];
    
    
}


-(void) tutorialIsland
{
    if(tutRan == false){
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        [self addChild:tutBlackBox z:98];
        
        instructionLabel = [CCLabelTTF labelWithString:@"TAP when the obstacle\nis in the ZONE!" fontName:@"Arial Rounded MT Bold" fontSize:40];
        CCActionFiniteTime *fadeBoxIn = [CCActionEaseInOut actionWithAction:[CCActionFadeTo actionWithDuration:.5 opacity:1.0f]rate:1.5f];
        CCActionFiniteTime *fadeBoxOut = [CCActionEaseInOut actionWithAction:[CCActionFadeTo actionWithDuration:.5 opacity:.5f]rate:1.5f];
        [greenBox runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:fadeBoxIn,fadeBoxOut, nil]]];
        instructionLabel.position = CGPointMake(screenSize.width/2, 150);
        [instructionLabel setHorizontalAlignment:CCTextAlignmentCenter];
        instructionLabel.color = [CCColor whiteColor];
        instructionLabel.opacity=0;
        instructionLabel.outlineColor = [CCColor blackColor];
        instructionLabel.outlineWidth = 1.5f;
        [self addChild:instructionLabel z:99];
        //speed = 1.5f*([Data speed]/100);
        
        float s = 1.5f*([Data speed]/100) + .5;
        CCActionFiniteTime* fadein = [CCActionFadeIn actionWithDuration:s];
        
        [instructionLabel runAction:fadein];
        
        
    }
    
}

-(void) die
{
    
    [Data health:2];
    [Data saveData ];
    jumpSuccess = 99;
    [greenBox stopAllActions];
    [coinLabelImage stopAllActions];
    [coinLabel stopAllActions];
    
    [instructionLabel stopAllActions];
    [instructionLabel runAction:[CCActionFadeOut actionWithDuration:0.5f]];
    
    [greenBox runAction:[CCActionFadeOut actionWithDuration:0.5f]];
    [blackBox runAction:[CCActionFadeOut actionWithDuration:0.5f]];
    
    [coinLabelImage runAction:[CCActionFadeOut actionWithDuration:0.5f]];
    [coinLabel runAction:[CCActionFadeOut actionWithDuration:0.5f]];
    
    
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    [enemy stopAllActions];
    
    speed = speed / (screenSize.width -80);
    
    float speed2 = speed*240.0f;
    
    
    CCActionMoveTo* enemyOffScreen = [CCActionMoveTo actionWithDuration:speed2 position:ccp(-80,  20+ enemy.boundingBox.size.height/2)];
    [enemy runAction:enemyOffScreen];
    
    scoreLabel.visible = NO;
    
    [Data coins:[Data coins] + coinsEarned];
    [Data saveData];
    [gameOwner gameOver:counter];
    
    
    
}

-(void)touched
{
    
    if(jumpSuccess<0){
        jumpSuccess=2;
        float x = enemy.position.x - enemy.boundingBox.size.width/2;
        float x2 = enemy.position.x + enemy.boundingBox.size.width/2;
        
        float greenStart = greenBox.position.x;
        if((x>greenStart && x<greenStart+ [Data damage])||(x2>greenStart && x2<greenStart+ [Data damage])||(x<greenStart && x2>greenStart +[Data damage])){
            jumpSuccess=0;
            if(eType == 2){
                
            }
            else if(eType ==1){
                
            }
            else if(eType == 0){
                greenBox.color = [CCColor greenColor];
                [self killEnemy];
                counter = counter+1;
                
                if(counter ==5 && greenHasMoved == false){
                    greenHasMoved=true;
                    [self greenBoxMove];
                }
                
                [scoreLabel setString:[NSString stringWithFormat:@"%0.f", counter]];
                if(counter ==1 && tutRan == false){
                    
                    [greenBox stopAllActions];
                    [greenBox runAction:[CCActionEaseInOut actionWithAction:[CCActionFadeTo actionWithDuration:.3 opacity:0.7f]rate:3.0f]];
                    
                    if([instructionLabel.string isEqualToString:@"DON'T tap to collect\nHEARTS and COINS"] != true){
                        float s = 1.5f*([Data speed]/100) + .5;
                        CCActionFiniteTime* fadeout = [CCActionFadeOut actionWithDuration:(s)/5];
                        CCActionCallBlock* block = [CCActionCallBlock actionWithBlock:^(void){
                            [instructionLabel setString:@"DON'T tap to collect\nHEARTS and COINS"];
                        }];
                        CCActionFiniteTime* fin = [CCActionFadeIn actionWithDuration:s/2];
                        [instructionLabel runAction:[CCActionSequence actions: fadeout, block, fin, nil]];
                    }
                }
            }
            //run this block after a short amount of time
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .2f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [greenBox runAction:[CCActionTintTo actionWithDuration:.2f color:[CCColor yellowColor]]];
            });
        }
        else{
            greenBox.color = [CCColor redColor];
        }
        if(eType !=0){
            greenBox.color = [CCColor redColor];
            
            [enemy stopAllActions];
            [enemy runAction:[CCActionScaleTo actionWithDuration:.7f scale:.0f]];
            [enemy runAction:[CCActionRepeatForever actionWithAction:[CCActionRotateBy actionWithDuration:.5f angle:360]]];
            [enemy runAction:[CCActionTintTo actionWithDuration:.7f color:[CCColor blackColor]]];
            [self performSelector:@selector(runAgain) withObject:nil afterDelay:.9f];
        }
        
        
        
    }

}
-(void)whiteFlash{
    
    CCActionFadeTo *flashOn = [CCActionFadeTo actionWithDuration:.05f opacity:.7f];
    CCActionFadeTo *flashOff = [CCActionFadeTo actionWithDuration:.1f opacity:0.0f];
    
    [flash runAction:[CCActionSequence actions:flashOn, flashOff, nil]];
    
    
    
}

-(void) greenBoxMove
{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    float curr = greenBox.position.x;
    float endX;
    int diff;
    int x = 0;
    do {
        x++;
        int r = arc4random() % ((int)(screenSize.width - (200 + [Data damage])));
        r = abs(r)+140;
        endX = r;
        diff = curr-endX;
    } while (abs(diff)< counter*15 && ( counter*15)<200 && x!=5&& abs(diff)<50);
    float s = 1.5f*([Data luck]/100);
    float c = counter*0.05f;
    s = s - c;
    s = (s>0)?s:0;
    float duration =  ((float)abs(diff)/(100+(arc4random()%300))+s);
    duration = (abs(diff)/duration>500)?((float)abs(diff))/500.f:duration;
    CGPoint end = greenBox.position;
    end.x = endX;
    CCActionMoveTo* greenMove = [CCActionMoveTo actionWithDuration:duration position:end];
    CCActionCallFunc* greenCall = [CCActionCallFunc actionWithTarget:self selector:@selector(greenBoxMove)];
    [greenBox runAction:[CCActionSequence actions:greenMove, greenCall, nil]];
    
}
-(void)chFail{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    jumpSuccess  = 99;
    if(eType == 2){
        [enemy stopAllActions];
        
        ccBezierConfig bezier;
        bezier.controlPoint_1 = ccp(screenSize.width,100);
        bezier.controlPoint_2 =ccp(screenSize.width,screenSize.height);
        bezier.endPosition = ccp(40,screenSize.height-40);
        CCActionMoveTo* enemyMove = [CCActionBezierTo actionWithDuration:1.0f bezier:bezier];
        CCActionCallFunc* lifeAdd = [CCActionCallFunc actionWithTarget:liveNode selector:@selector(addLife:)];
        CCActionCallFunc* afterAdd = [CCActionCallFunc actionWithTarget:self selector:@selector(runAgain)];
        
        [enemy runAction:[CCActionSequence actions:enemyMove, lifeAdd, afterAdd, nil]];
        [enemy runAction:[CCActionScaleTo actionWithDuration:1.0f scale:.25f]];
        
    }
    else if(eType ==1){
        [enemy stopAllActions];
        ccBezierConfig bezier;
        bezier.controlPoint_1 = ccp(0,100);
        bezier.controlPoint_2 =ccp(0,screenSize.height);
        bezier.endPosition = ccp(screenSize.width - 140, screenSize.height -40);
        CCActionMoveTo* enemyMove = [CCActionBezierTo actionWithDuration:1.0f bezier:bezier];
        coinsEarned = coinsEarned+counter;
        CCActionCallBlock* block = [CCActionCallBlock actionWithBlock:^(void){
            [coinLabel setString:[NSString stringWithFormat:@"x%-4d",coinsEarned]];
            [self performSelector:@selector(runAgain) withObject:nil afterDelay:.2f];
        }];
        
        [enemy runAction:[CCActionSequence actions:enemyMove, block, nil]];
        [enemy runAction:[CCActionScaleTo actionWithDuration:1.0f scale:.25f]];
        
    }
    if(tutRan == false){
        CCActionFiniteTime* fout = [CCActionFadeOut actionWithDuration:.7f];
        CCActionCallBlock* cb = [CCActionCallBlock actionWithBlock:^(void){
            [instructionLabel setFontSize:80];
            [instructionLabel setString:@"PLAY"];
            [tutBlackBox runAction:[CCActionFadeTo actionWithDuration:2.5f opacity:.0f]];
        }];
        
        CCActionFiniteTime* fina = [CCActionFadeIn actionWithDuration:1.0f];
        CCActionFiniteTime* fouta = [CCActionFadeOut actionWithDuration:2.0f];
        CCActionCallBlock* cba = [CCActionCallBlock actionWithBlock:^(void){
            [self removeChild:instructionLabel];
        }];
        
        [instructionLabel runAction:[CCActionSequence actions:fout,cb,fina,fouta,cba, nil]];
        
        
    }
    tutRan = true;
    
}
-(void)killEnemy{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    [enemy stopAllActions];
    [enemy runAction:[CCActionEaseOut actionWithAction:[CCActionMoveTo actionWithDuration:1.0f position:ccp(enemy.position.x, screenSize.height+100)]rate:.4f]];
    [enemy runAction:[CCActionScaleTo actionWithDuration:1.0f scale:.0f]];
    [enemy runAction:[CCActionRepeatForever actionWithAction:[CCActionRotateBy actionWithDuration:.3f angle:360]]];
    [enemy runAction:[CCActionTintTo actionWithDuration:1.0f color:[CCColor blackColor]]];
    [self performSelector:@selector(runAgain) withObject:nil afterDelay:1.0f];
    
    
}
- (void) runAgain
{
    [greenBox runAction:[CCActionTintTo actionWithDuration:.2f color:[CCColor yellowColor]]];
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    
    if((int)counter % 7 == 0){
        bonusThisTime = 0;
    }
    laser.visible = NO;
    fizzle.visible = NO;
    
    if(jumpSuccess !=0 && jumpSuccess !=99){
        if( eType == 0){
            [self whiteFlash];
            if(counter>1 || tutRan == true){
                if([liveNode subtractLife]== false){
                    
                    [self die];
                    return;
                }
            }
        }
        
    }
    if(jumpSuccess == -1 && eType !=0){
        [self chFail];
        return;
    }
    //counter = counter + 0.025f;
    speed = 1.5f*([Data speed]/100);
    float c = counter*0.02f;
    speed = speed - c;
    
    //get rid of current enemy
    enemy.visible = NO;
    [enemy stopAllActions];
    [self removeChild:enemy];
    
    int random = 3;
    if(bonusThisTime <2){
        random = arc4random() % 8;
    }
    if(counter<3){
        random = 3;
    }
    if(counter ==1 && tutRan == false){
        random =0;
    }
    
    int z = 100;
    if(random < 2){
        bonusThisTime++;
        int r = arc4random() % 3;
        r = r+1;
        r = (r>2)?1:r;
        enemy = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"coin%i.png",r]];
        eType = r;
        z = 14;
        
    }
    else{
        int r = arc4random() % 2;
        r = r+1;
        enemy = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"enemy%i.png",r]];
        eType = 0;
    }
    
    
    
    
    enemy.position = ccp(screenSize.width + 80, 20+ enemy.boundingBox.size.height/2);
    CCActionMoveTo* enemyMove = [CCActionMoveTo actionWithDuration:speed position:ccp(160, 20+ enemy.boundingBox.size.height/2)];
    CCActionCallFunc* enemyCall = [CCActionCallFunc actionWithTarget:self selector:@selector(runAgain)];
    [enemy runAction:[CCActionSequence actions:enemyMove, enemyCall, nil]];
    [self addChild:enemy z:z];
    
    
    jumpSuccess = -1;

}

-(void)setAbove:(GameScene *)game
{
    gameOwner = game;
}



@end
