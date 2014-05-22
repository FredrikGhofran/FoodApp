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

@property (weak, nonatomic) IBOutlet UIImageView *photo;
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
    [self restoreImage];
    self.foodNameLabel.text =self.foodName;
    self.carbsValueLabel.text = [NSString stringWithFormat:@"%@",self.carbsValue];
    self.proteinValueLabel.text = [NSString stringWithFormat:@"%@",self.proteinValue];
    self.fatValueLabel.text = [NSString stringWithFormat:@"%@",self.fatValue];
    self.energiValueLabel.text = self.energiValue;
    
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.photo.image = info[UIImagePickerControllerEditedImage];
    [self save];
    
}
-(NSString *)imagePath:(NSString *)name
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectiory = paths[0];
    NSString *fullImageName = [NSString stringWithFormat:@"%@.png",name];
    NSString *imagePath = [documentsDirectiory stringByAppendingPathComponent:fullImageName];
    
    return imagePath;
    
}
-(void)save
{
    if(self.photo.image){
        
        NSData *imageData = UIImagePNGRepresentation(self.photo.image);
        BOOL success = [imageData writeToFile:[self imagePath:self.foodNameLabel.text] atomically:NO];
        
        
        if(success){
            
            NSLog(@"Saved");
        }else{
            NSLog(@"Failed to save");
        }
    }
    
}
-(void)restoreImage{
    UIImage *image = [UIImage imageWithContentsOfFile:[self imagePath:self.foodNameLabel.text]];
    
    if(image){
        self.photo.image =image;
    }else{
        NSLog(@"Found no image");
    }
    
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
