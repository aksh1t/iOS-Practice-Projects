//
//  AppDelegate.h
//  ImageUtils
//
//  Created by Akshat on 16/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipleImageTestViewController.h"
#import "ImagePreviewViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navCon;
    MultipleImageTestViewController *mvc;
    ImagePreviewViewController *ivc;
    HomeViewController *hvc;
}

@property (strong, nonatomic) UIWindow *window;

@end
