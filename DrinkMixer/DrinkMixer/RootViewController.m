//
//  RootViewController.m
//  DrinkMixer
//
//  Created by Vishal on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "DrinkConstants.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize drinks, addButton;

- (void)addButtonPressed:(id)sender{

    AddViewController *addViewController = [[AddViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    
    addViewController.drinkArray = self.drinks;
    
    UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    
    [self presentModalViewController:addNavController animated:YES];

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkList" ofType:@"plist"];
    
    drinks = [[NSMutableArray alloc]initWithContentsOfFile:path];
    
    self.title = @"Drink Mixer";
    
    self.navigationItem.rightBarButtonItem = self.addButton;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)applicationDidEnterBackground: (NSNotification *)notification{
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"DrinkList" ofType:@"plist"];
    
    [self.drinks writeToFile:path atomically:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.drinks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row]objectForKey:NAME_KEY];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.drinks removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.editing){
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
        detailViewController.drink = [self.drinks objectAtIndex:indexPath.row];

        [self.navigationController pushViewController:detailViewController animated:YES];
    }else{
        
        AddViewController *editingDrink = [[AddViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
        
        editingDrink.drink = [self.drinks objectAtIndex:indexPath.row];
        
        editingDrink.drinkArray = self.drinks;
        
        UINavigationController *editingNavCon = [[UINavigationController alloc]initWithRootViewController:editingDrink];
        
        [self.navigationController presentModalViewController:editingNavCon animated:YES];
    }
}

@end
