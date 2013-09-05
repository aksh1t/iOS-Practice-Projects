//
//  RootViewController.m
//  UITableViewDemo
//
//  Created by Vishal on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController5.h"

#import "DetailViewController1.h"

@implementation RootViewController5

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
    
    self.title = @"Countries";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    listOfItems = [[NSMutableArray alloc] init];
    
    //Add items
    NSArray *countriesToLiveInArray = [NSArray arrayWithObjects:@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Rome", @"Ireland", nil];
    NSDictionary *countriesToLiveInDict = [NSDictionary dictionaryWithObject:countriesToLiveInArray forKey:@"Countries"];
    
    NSArray *countriesLivedInArray = [NSArray arrayWithObjects:@"India", @"U.S.A", nil];
    NSDictionary *countriesLivedInDict = [NSDictionary dictionaryWithObject:countriesLivedInArray forKey:@"Countries"];
    
    NSArray *objectsArray = [NSArray arrayWithObjects:@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Rome", @"Ireland", @"India", @"U.S.A", nil];
    
    NSArray *detailsArray = [NSArray arrayWithObjects:@"Iceland Detail", @"Greenland Detail", @"Switzerland Detail", @"Norway Detail", @"New Zealand Detail", @"Greece Detail", @"Rome Detail", @"Ireland Detail", @"India Detail", @"U.S.A Detail", nil];
    
    detailDictionary = [NSDictionary dictionaryWithObjects:detailsArray forKeys:objectsArray];
    
    [listOfItems addObject:countriesToLiveInDict];
    [listOfItems addObject:countriesLivedInDict];
    
    self.tableView.tableHeaderView = searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    originalListOfItems = [[NSMutableArray alloc]initWithArray:listOfItems];
    
    searching = NO;
    letUserSelectRow = YES;

    UITapGestureRecognizer *singleFingerTap = 
    [[UITapGestureRecognizer alloc] initWithTarget:self 
                                            action:@selector(handleSingleTap:)];
    [overlayView addGestureRecognizer:singleFingerTap];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self doneSearching_Clicked:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(searching)
        return @"";
    
    if(section == 0)
        return @"Countries to visit";
    else
        return @"Countries visited";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) doneSearching_Clicked:(id)sender {
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    
    letUserSelectRow = YES;
    searching = NO;
    
    [listOfItems removeAllObjects];
    [listOfItems addObjectsFromArray:originalListOfItems];
    
    self.navigationItem.rightBarButtonItem = nil;
    self.tableView.scrollEnabled = YES;
    
    [overlayView removeFromSuperview];
    
    [self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked :(UISearchBar *)theSearchBar{
    [self searchTableView];
}

- (void) searchTableView {
    
    NSString *searchText = searchBar.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dictionary in originalListOfItems)
    {
        NSArray *array = [dictionary objectForKey:@"Countries"];
        
        for(NSString *tempObj in array){
            if(tempObj.length >= searchText.length)
            [searchArray addObject:tempObj];
        }
    }
    
    for (NSString *sTemp in searchArray)
    {   NSRange len = {0,searchText.length};
        NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch range:len];
        if (titleResultsRange.length > 0){
            [tempArray addObject:sTemp];
        }
    }
    searchArray = nil;
    NSDictionary *tempDict = [NSDictionary dictionaryWithObject:tempArray forKey:@"Countries"];
    [listOfItems removeAllObjects];
    [listOfItems addObject:tempDict];
    [self.tableView reloadData];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *) theSearchBar{
   [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    CGRect frame = CGRectMake(0, yaxis, width, height);
    overlayView.frame = frame;
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0.6;

    [self.tableView insertSubview:overlayView aboveSubview:self.parentViewController.view];

    searching = YES;
    letUserSelectRow = NO;
    self.tableView.scrollEnabled = NO;
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [self doneSearching_Clicked:nil];
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}

- (void) searchBar:(UISearchBar *) theSearchBar textDidChange:(NSString *)searchText{
    
    if([searchText length] > 0) {
        [overlayView removeFromSuperview];
        searching = YES; 
        letUserSelectRow = YES;
        self.tableView.scrollEnabled = YES;
        [self searchTableView];
    } else {
        [self.tableView insertSubview:overlayView aboveSubview:self.parentViewController.view];
        searching = NO;
        letUserSelectRow = NO;
        self.tableView.scrollEnabled = NO;
        [listOfItems removeAllObjects];
        [listOfItems addObjectsFromArray:originalListOfItems];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(searching)
        return 1;
    else
        return [listOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = [listOfItems objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Countries"];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:     
//        CellIdentifier];
        
        cell = [self getCellContentView:CellIdentifier];
//}
        
        UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
        UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
    
    if(searching) {
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Countries"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
        lblTemp1.text = cellValue;
        lblTemp2.text = [detailDictionary objectForKey:cellValue];
    }else {
        
        //First get the dictionary object
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Countries"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
        
        lblTemp1.text = cellValue;
        lblTemp2.text = [detailDictionary objectForKey:cellValue];
    }
    
    // Set up the cell...
//    
//        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
//        NSArray *array = [dictionary objectForKey:@"Countries"];
//        NSString *cellValue = [array objectAtIndex:indexPath.row];
//        cell.textLabel.text = cellValue;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
    return cell;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
    
    CGRect CellFrame = CGRectMake(0, 0, 300, 60);
    CGRect Label1Frame = CGRectMake(10, 5, 290, 25);
    CGRect Label2Frame = CGRectMake(10, 30, 290, 25); 
    UILabel *lblTemp;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame];                                                               
    //reuseIdentifier:cellIdentifier];
    
    //Initialize Label with tag 1.
    lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
    lblTemp.tag = 1;
    [cell.contentView addSubview:lblTemp];
    
    //Initialize Label with tag 2.
    lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
    lblTemp.tag = 2;
    lblTemp.font = [UIFont boldSystemFontOfSize:12];    
    lblTemp.textColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lblTemp];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedCountry=nil;
    
    NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Countries"];
    selectedCountry = [array objectAtIndex:indexPath.row];
    
    DetailViewController1 *detailViewController= [[DetailViewController1 alloc] initWithNibName:@"DetailViewController1" bundle:nil];
    detailViewController.detail = [detailDictionary objectForKey:selectedCountry];
    detailViewController.selectedCountry = selectedCountry;

    [self.navigationController pushViewController:detailViewController animated:YES];
     
}

@end
