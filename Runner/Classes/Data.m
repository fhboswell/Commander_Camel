//
//  Data.m
//  Runner
//
//  Created by Aaron Boswell on 2/15/14.
//  Copyright (c) 2014 Aaron Boswell. All rights reserved.
//

#import "Data.h"


static float speed = 0;
static float defaultSpeed = 100.0f;
static float maxSpeed = 150.0f;
static float coins = 0;

static float health = 0;
static float defaultHealth = 2.0f;
static float maxHealth = 5.0f;

static float damage = 0;
static float defaultDamage = 25.0f;
static float maxDamage = 75.0f;

static float luck = 0;
static float defaultLuck = 50.0f;
static float maxLuck = 150.0f;

static float HS = 0;

@implementation Data
+(void)initialize{
    
        //Only Use Following Code for Reseting instance


    [[NSUserDefaults standardUserDefaults] setFloat: defaultSpeed forKey:@"speed"];
    [[NSUserDefaults standardUserDefaults] setFloat: 0.0f forKey:@"coins"];
    [[NSUserDefaults standardUserDefaults] setFloat: defaultHealth forKey:@"health"];
    [[NSUserDefaults standardUserDefaults] setFloat: defaultDamage forKey:@"damage"];
    [[NSUserDefaults standardUserDefaults] setFloat: defaultLuck forKey:@"luck"];
    [[NSUserDefaults standardUserDefaults] setFloat: 0.0f forKey:@"HS"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
    speed = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"speed"];
    coins = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"coins"];
    health = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"health"];
    damage = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"damage"];
    luck = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"luck"];
    HS = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"HS"];
    if(speed == 0){
        [[NSUserDefaults standardUserDefaults] setFloat: defaultSpeed forKey:@"speed"];
        [[NSUserDefaults standardUserDefaults] setFloat: 0.0f forKey:@"coins"];
        [[NSUserDefaults standardUserDefaults] setFloat: defaultHealth forKey:@"health"];
        [[NSUserDefaults standardUserDefaults] setFloat: defaultDamage forKey:@"damage"];
        [[NSUserDefaults standardUserDefaults] setFloat: defaultLuck forKey:@"luck"];
        [[NSUserDefaults standardUserDefaults] setFloat: 0.0f forKey:@"HS"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [Data initialize];
    }


}
//Getters
+(float)speed{return speed;}
+(float)coins{return coins;}
+(float)health{return health;}
+(float)damage{return damage;}
+(float)luck{return luck;}
+(float)HS{return HS;}

+(float)defaultSpeed{return defaultSpeed;}
+(float)defaultHealth{return defaultHealth;}
+(float)defaultDamage{return defaultDamage;}
+(float)defaultLuck{return defaultLuck;}

+(float)maxSpeed{return maxSpeed;}
+(float)maxHealth{return maxHealth;}
+(float)maxDamage{return maxDamage;}
+(float)maxLuck{return maxLuck;}

//Setters
+(void)speed:(float)s{speed = s;}
+(void)coins:(float)c{coins = c;}
+(void)health:(float)h{health = h;}
+(void)damage:(float)d{damage = d;}
+(void)luck:(float)l{luck = l;}
+(void)HS:(float)hs{HS = hs;}




+(void)saveData{
    [[NSUserDefaults standardUserDefaults] setFloat: speed forKey:@"speed"];
    [[NSUserDefaults standardUserDefaults] setFloat: coins forKey:@"coins"];
    [[NSUserDefaults standardUserDefaults] setFloat: health forKey:@"health"];
    [[NSUserDefaults standardUserDefaults] setFloat: damage forKey:@"damage"];
    [[NSUserDefaults standardUserDefaults] setFloat: luck forKey:@"luck"];
    [[NSUserDefaults standardUserDefaults] setFloat: HS forKey:@"HS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
