//
//  Database.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-17.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "Database.h"

@implementation Database
static NSUserDefaults * _foodList;

+ (NSUserDefaults *)foodList
{
    if(!_foodList){
        _foodList = [NSUserDefaults standardUserDefaults];
        if(![_foodList objectForKey:@"favorites"]){
            [_foodList setObject:@[] forKey:@"favorites"];

        }
    }
    return _foodList;
}

+ (void) setfoodList:(NSUserDefaults *)foodList{
    _foodList = foodList;
}
@end
