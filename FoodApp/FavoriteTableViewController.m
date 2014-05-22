//
//  FavoriteTableViewController.m
//  FoodApp
//
//  Created by Fredrik Ghofran on 2014-05-16.
//  Copyright (c) 2014 Fredrik Ghofran. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FoodTableViewCell.h"
#import "Database.h"
#import "DetailViewController.h"
@interface FavoriteTableViewController ()

@end

@implementation FavoriteTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    NSMutableArray *favoriteFoods = [[Database foodList] objectForKey:@"favorites"];
    return favoriteFoods.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.foodNameTextLabel.text = [[Database foodList]  objectForKey:@"favorites"][indexPath.row][0];
    cell.foodEnergiTextLabel.text =[NSString stringWithFormat:@"%@ kcal", [[Database foodList] objectForKey:@"favorites"][indexPath.row][4]];
    return cell;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(FoodTableViewCell*)sender
{
    DetailViewController *detailViewController = [segue destinationViewController];
    NSInteger key = [self.tableView indexPathForCell:sender].row;
    detailViewController.foodName = [[Database foodList] objectForKey:@"favorites"][key][0];
    detailViewController.proteinValue = [[Database foodList] objectForKey:@"favorites"][key][1];
    detailViewController.carbsValue = [[Database foodList] objectForKey:@"favorites"][key][2];
    detailViewController.fatValue = [[Database foodList] objectForKey:@"favorites"][key][3];
    detailViewController.energiValue = [[Database foodList] objectForKey:@"favorites"][key][4];


}


@end
