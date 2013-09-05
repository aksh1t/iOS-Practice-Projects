//
//  DetailViewController.h
//  UITableViewDemo
//
//  Created by Vishal on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController1 : UIViewController{
    
    IBOutlet UILabel * lbl;
    
    IBOutlet UITextView * detailText;
    
    NSString * detail;
    
    NSString * selectedCountry;
}
 
@property (nonatomic, retain) NSString * detail;

@property (nonatomic, retain) NSString * selectedCountry;

@end
