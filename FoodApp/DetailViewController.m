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
@property (weak, nonatomic) IBOutlet UILabel *savedLabel;
@property(nonatomic)UIDynamicAnimator *animator;
@property(nonatomic)UIGravityBehavior *gravity;
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

    [self labelAmination];
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc]initWithItems:@[self.savedLabel]];
    
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
            NSMutableArray *favorites = [[[Database foodList] objectForKey:@"favorites"] mutableCopy];
            NSArray *food = @[self.foodNameLabel.text,self.proteinValueLabel.text,self.carbsValueLabel.text,self.fatValueLabel.text,self.energiValueLabel.text];
            [favorites addObject:food];
            [[Database foodList] setObject:favorites forKey:@"favorites"];
            [[Database foodList] synchronize];
            [self saveAnimate];
        }
        

    }
}
-(void)labelAmination
{
    self.foodNameLabel.center = CGPointMake(300, 10);
    self.carbsValueLabel.center = CGPointMake(300, 10);
    self.fatValueLabel.center =CGPointMake(300, 10);
    self.proteinValueLabel.center = CGPointMake(300, 10);
    self.energiValueLabel.center = CGPointMake(300, 10);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:1.0];
    self.foodNameLabel.center = CGPointMake(139, 81);
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:1.0];
    self.carbsValueLabel.center = CGPointMake(139, 119);
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:1.0];
    self.proteinValueLabel.center = CGPointMake(140, 158);
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:1.0];
    self.fatValueLabel.center = CGPointMake(140, 196);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:1.0];
    self.energiValueLabel.center = CGPointMake(139, 239);
    [UIView commitAnimations];
    
}
-(void)saveAnimate
{
    [self.animator removeAllBehaviors];
    self.savedLabel.center =CGPointMake(139,0);
    self.savedLabel.text =@"Saved!";
    [UIView animateWithDuration:1.0 animations:^{
        self.savedLabel.center =CGPointMake(139,500);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 animations:^{
            self.savedLabel.center =CGPointMake(139,300);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{                
                
                  [self.animator addBehavior:self.gravity];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
    
    
}

@end
