//
//  FavoriteDetailViewController.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-17.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "FavoriteDetailViewController.h"

@interface FavoriteDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carbsValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *proteinValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *fatValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *energiValueLabel;
@end

@implementation FavoriteDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foodNameLabel.text =self.foodName;
    self.carbsValueLabel.text = [NSString stringWithFormat:@"%@",self.carbsValue];
    self.proteinValueLabel.text = [NSString stringWithFormat:@"%@",self.proteinValue];
    self.fatValueLabel.text = [NSString stringWithFormat:@"%@",self.fatValue];
    self.energiValueLabel.text = self.energiValue;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
