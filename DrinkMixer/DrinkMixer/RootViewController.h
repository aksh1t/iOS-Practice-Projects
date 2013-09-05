//
//  RootViewController.h
//  DrinkMixer
//
//  Created by Vishal on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController{
    
    UIBarButtonItem * addButton;
    NSMutableArray * drinks;
    
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem * addButton;

@property (nonatomic, retain) NSMutableArray * drinks;

- (IBAction)addButtonPressed:(id)sender;

@end
