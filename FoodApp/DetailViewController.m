//
//  DetailViewController.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-07.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "DetailViewController.h"
#import "FavoriteTableViewController.h"
#import "Database.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carbsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *proteinValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *fatValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *energiValueLabel;
@end

@implementation DetailViewController

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
    NSLog(@"Detail View protein :%@",self.proteinValue);
    NSLog(@"Detail View fat :%@",self.fatValue);

    NSLog(@"Detail View carbsValue :%@",self.carbsValue);

    self.foodNameLabel.text =self.foodName;
    self.carbsValueLabel.text = [NSString stringWithFormat:@"%@",self.carbsValue];
    self.proteinValueLabel.text = [NSString stringWithFormat:@"%@",self.proteinValue];
    self.fatValueLabel.text = [NSString stringWithFormat:@"%@",self.fatValue];
    self.energiValueLabel.text = self.energiValue;
}
- (IBAction)saveButtonClick:(id)sender {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Save food" message:@"Do you wont to save your food to favorites?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView show];
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0){
        NSLog(@"no");
    }else if(buttonIndex == 1){
        if([self.energiValueLabel.text isEqualToString:@"Not found"]){
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Try again" message:@"Your energi value was not found,please try to go back to the search view an reaload!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
        }else{
            NSLog(@"yes");
            NSInteger number =[[Database foodList] integerForKey:@"countNr"];
            NSArray *food = @[self.foodNameLabel.text,self.proteinValueLabel.text,self.carbsValueLabel.text,self.fatValueLabel.text,self.energiValueLabel.text];
            number++;
            [[Database foodList]  setObject:food forKey:[NSString stringWithFormat:@"%d",number]];
            [[Database foodList]  setInteger:number forKey:@"countNr"];
            [[Database foodList] synchronize];
            NSLog(@"%d",[[Database foodList]  integerForKey:@"countNr"]);
        
        }
  

    }
}


@end
