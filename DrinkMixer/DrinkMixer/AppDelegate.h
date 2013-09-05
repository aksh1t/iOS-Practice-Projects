//
//  AppDelegate.h
//  DrinkMixer
//
//  Created by Vishal on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    UIWindow *window;
    
    UINavigationController *navigationController;
    
    UISplitViewController *splitViewController;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@end
