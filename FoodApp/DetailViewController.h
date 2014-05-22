//
//  DetailViewController.h
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-07.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//


@interface DetailViewController : UIViewController<UIAlertViewDelegate>
@property(nonatomic)NSString *foodName;
@property(nonatomic)NSNumber *carbsValue;
@property(nonatomic)NSNumber *proteinValue;
@property(nonatomic)NSNumber *fatValue;
@property(nonatomic)NSString *energiValue;
@end
