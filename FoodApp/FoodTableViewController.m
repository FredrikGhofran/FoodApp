//
//  FoodTableViewController.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-07.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "FoodTableViewController.h"
#import "FoodTableViewCell.h"
#import "DetailViewController.h"
#import "FavoriteDetailViewController.h"
@interface FoodTableViewController ()
@property(nonatomic)NSMutableArray *food;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic)NSMutableDictionary *foodDictionary;
@property(nonatomic)NSMutableDictionary *foodValuesDictionary;
//@property(nonatomic)NSMutableArray *searchResult;
//@property(nonatomic)NSArray *showResult;


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
    
//   // KOD FÖR ATT RENSA DATABASEN
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
  //  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [super viewDidLoad];
    
//    self.showResult = @[];
//    self.searchResult = [@[]mutableCopy];
    self.searchBar.delegate = self;
    self.food = [@[]mutableCopy];
    self.foodDictionary = [[NSMutableDictionary alloc] init];
    self.foodValuesDictionary =[[NSMutableDictionary alloc] init];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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

    if([self.foodDictionary valueForKey:cell.foodNameTextLabel.text]){

        cell.foodEnergiTextLabel.text =[NSString stringWithFormat:@"%@ kcal",[self.foodDictionary valueForKey:cell.foodNameTextLabel.text]];
    }
    else{
        cell.foodEnergiTextLabel.text =@"Loading...";

    }
    
    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchbar
{
    self.foodDictionary = [[NSMutableDictionary alloc] init];
    self.foodValuesDictionary =[[NSMutableDictionary alloc] init];
    self.food = [@[]mutableCopy];
    [self.tableView endEditing:YES];
    NSString *urlString = [NSString stringWithFormat:@"http://matapi.se/foodstuff?query=%@",self.searchBar.text];
    
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *parseError;

        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];

        dispatch_async(dispatch_get_main_queue(),^{
            
            for(int i =0;i<json.count;i++){
                
                [self.food addObject:json[i][@"name"]];

                
                NSString *urlString = [NSString stringWithFormat:@"http://matapi.se/foodstuff/%@",json[i][@"number"]];
                NSURL *URL = [NSURL URLWithString:urlString];
                NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                
                NSURLSession *session = [NSURLSession sharedSession];
                
                NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    NSError *parseError;

                    NSDictionary *foodObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];

                    NSNumber *energi = foodObject[@"nutrientValues"][@"energyKcal"];

                    [self.foodDictionary setValue:[NSString stringWithFormat:@"%@",energi] forKey:self.food[i]];
                    [self.foodValuesDictionary setValue:@[foodObject[@"nutrientValues"][@"protein"],
                                                          foodObject[@"nutrientValues"][@"carbohydrates"],
                                                          foodObject[@"nutrientValues"][@"fat"],
                                                          json[i][@"number"]]
                                                 forKey:json[i][@"name"]];
                    
                    
                    NSLog(@"%@, protein :%@",json[i][@"name"],energi);
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        [self.tableView reloadData];
                    });
                    
                    /*
                    NSLog(@"%@, protein :%@",json[i][@"name"],self.values[json[i][@"name"]][0]);
                    NSLog(@"%@, carbs :%@",json[i][@"name"],self.values[json[i][@"name"]][1]);
                    NSLog(@"%@, fat :%@",json[i][@"name"],self.values[json[i][@"name"]][2]);*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(FoodTableViewCell *)sender
{
    DetailViewController *detailViewController = [segue destinationViewController];
    
    detailViewController.foodName = sender.foodNameTextLabel.text;
   /* NSLog(@"%@ protein: %@",sender.foodNameTextLabel.text,self.values[sender.foodNameTextLabel.text][0]);
    NSLog(@"%@ carbs: %@",sender.foodNameTextLabel.text,self.values[sender.foodNameTextLabel.text][1]);
    NSLog(@"%@ fat: %@",sender.foodNameTextLabel.text,self.values[sender.foodNameTextLabel.text][2]);
    0x8e87040*/

    if([sender.foodEnergiTextLabel.text isEqualToString:@"Loading..."]){
        detailViewController.energiValue = @"Not found";
    }else{
        detailViewController.energiValue = [self.foodDictionary objectForKey:sender.foodNameTextLabel.text];
        

    }
    detailViewController.proteinValue = self.foodValuesDictionary[sender.foodNameTextLabel.text][0];
    detailViewController.carbsValue = self.foodValuesDictionary[sender.foodNameTextLabel.text][1];
    detailViewController.fatValue = self.foodValuesDictionary[sender.foodNameTextLabel.text][2];
    detailViewController.foodNumber = self.foodValuesDictionary[sender.foodNameTextLabel.text][3];
}
//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    NSString *urlString = @"http://matapi.se/foodstuff?query=";
//    
//    
//    NSURL *URL = [NSURL URLWithString:urlString];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSError *parseError;
//        
//        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
//        
//        dispatch_async(dispatch_get_main_queue(),^{
//            for(int i =0;i<json.count;i++){
//                
//                [self.searchResult addObject:json[i][@"name"]];
//           
//            }
//        });
//        
//    }];
//    
//    [task resume];
//    
//    
//    NSPredicate *searchPredicate =[NSPredicate predicateWithFormat:@"description contains[c] %@",searchString];
//    
//    self.showResult = [self.searchResult filteredArrayUsingPredicate:searchPredicate];
//    
//    return YES;
//}


@end
