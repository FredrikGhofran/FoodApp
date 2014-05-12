//
//  FoodTableViewController.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-07.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "FoodTableViewController.h"
#import "FoodTableViewCell.h"
@interface FoodTableViewController ()
@property(nonatomic)NSMutableArray *food;
@property(nonatomic)NSMutableArray *energi;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation FoodTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.energi = [@[]mutableCopy];
    self.food = [@[]mutableCopy];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.food.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
        cell.foodNameTextLabel.text = self.food[indexPath.row];
        cell.foodEnergiTextLabel.text =self.energi[indexPath.row];

    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchbar
{
    self.energi = [@[]mutableCopy];
    self.food = [@[]mutableCopy];
    [self.tableView endEditing:YES];
    NSString *urlString = [NSString stringWithFormat:@"http://matapi.se/foodstuff?query=%@",self.searchBar.text];
    
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *parseError;
      //  NSLog(@"Data: %@", data);
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
        //NSLog(@"request is done ! Json: %@",json);
        dispatch_async(dispatch_get_main_queue(),^{
            
            for(int i =0;i<json.count;i++){
            
                [self.food addObject:json[i][@"name"]];
                
               
                NSString *urlString = [NSString stringWithFormat:@"http://matapi.se/foodstuff/%@",json[i][@"number"]];
                 NSURL *URL = [NSURL URLWithString:urlString];
                NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                NSLog(@"11111111111111");
                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    NSLog(@"2222222222222");

                    NSError *parseError;
                   // NSLog(@"Data: %@", data);
                    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                   // NSLog(@"request is done ! Json: %@",json);
                    NSNumber *energi = json[2][@"energyKcal"];
                    NSLog(@"ENERGI: %@ !!!!!!!!!!",energi);
                    [self.energi addObject:[NSString stringWithFormat:@"%@",energi]];
                }];
                 [task resume];
                
            }
            

           [self.tableView reloadData];
         
        });
        
    }];
    
    [task resume];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
