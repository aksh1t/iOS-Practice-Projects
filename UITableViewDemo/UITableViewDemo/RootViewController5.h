//
//  RootViewController.h
//  UITableViewDemo
//
//  Created by Vishal on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OverlayViewController1.h"

@interface RootViewController5 : UITableViewController{
    
    NSMutableArray *listOfItems;
    
    NSMutableArray *copyListOfItems;
    
    NSMutableArray *originalListOfItems;
    
    NSDictionary *detailDictionary;
    
    IBOutlet UISearchBar *searchBar;
    
    IBOutlet UIView *overlayView;
    
    BOOL searching;
    
    BOOL letUserSelectRow;
}

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

@end
