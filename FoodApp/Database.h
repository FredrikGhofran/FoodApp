//
//  Database.h
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-17.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Database : NSObject
+ (NSUserDefaults *) foodList;
+ (void) setfoodList:(NSUserDefaults *)foodList;
@end
