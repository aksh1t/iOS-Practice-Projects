//
//  MyMainViewController.h
//  MultiView
//
//  Created by Vishal on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedViewController.h"
#import "GreenViewController.h"

@interface MyMainViewController : UIViewController{
    
    RedViewController *redViewController;
    GreenViewController *greenViewController;
    
}

@property (nonatomic) RedViewController *redViewController;

@property (nonatomic) GreenViewController *greenViewController;

- (IBAction)switchViews:(id)sender;


@end
