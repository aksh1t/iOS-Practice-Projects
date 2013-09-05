//
//  DetailViewControllerViewController.h
//  UITableViewDemo
//
//  Created by Vishal on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    
    IBOutlet UILabel *lblText;
    
    NSString *selectedCountry;
    
}

@property (retain, nonatomic) NSString *selectedCountry;

@end
