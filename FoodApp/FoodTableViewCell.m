//
//  FoodTableViewCell.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-07.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "FoodTableViewCell.h"
@interface FoodTableViewCell ()

@end

@implementation FoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
