//
//  FoodTableViewCell.h
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-07.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foodNameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodEnergiTextLabel;
@end
