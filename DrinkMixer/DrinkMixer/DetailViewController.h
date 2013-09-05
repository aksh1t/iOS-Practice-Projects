//
//  DetailViewController.h
//  DrinkMixer
//
//  Created by Vishal on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    
    UITextField * nameField;
    UITextView * ingredients;
    UITextView * directions; 
    UIScrollView * srcollView;
    NSDictionary * drink;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;

@property (nonatomic, retain) IBOutlet UITextField * nameField;

@property (nonatomic, retain) IBOutlet UITextView * ingredients;
 
@property (nonatomic, retain) IBOutlet UITextView * directions;

@property (nonatomic, retain) NSDictionary * drink;

@end
