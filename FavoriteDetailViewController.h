//
//  FavoriteDetailViewController.h
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-17.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

@interface FavoriteDetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic)NSString *foodName;
@property(nonatomic)NSNumber *carbsValue;
@property(nonatomic)NSNumber *proteinValue;
@property(nonatomic)NSNumber *fatValue;
@property(nonatomic)NSString *energiValue;
@end
