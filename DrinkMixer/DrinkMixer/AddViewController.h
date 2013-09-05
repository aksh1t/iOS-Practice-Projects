//
//  AddViewController.h
//  DrinkMixer
//
//  Created by Vishal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface AddViewController : DetailViewController{
    
    BOOL keyboardVisible;
    
    NSMutableArray * drinkArray;
    
}

@property (nonatomic, retain) NSMutableArray * drinkArray;

- (IBAction)save:(id)sender;

- (IBAction)cancel:(id)sender;

- (void)keyboardDidShow:(NSNotification *)notif;

- (void)keyboarddidHide:(NSNotification *)notif;

@end
