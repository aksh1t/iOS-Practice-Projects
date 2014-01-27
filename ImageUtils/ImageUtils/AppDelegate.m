//
//  AppDelegate.m
//  ImageUtils
//
//  Created by Akshat on 16/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MultipleImageTestViewController.h"
#import "ImagePreviewViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    hvc = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    mvc = [[MultipleImageTestViewController alloc]initWithNibName:@"MultipleImageTestViewController" bundle:nil];
    ivc = [[ImagePreviewViewController alloc]initWithNibName:@"ImagePreviewViewController" bundle:nil];
    
    UIViewController *navigationViewController = [[UIViewController alloc]init];
    navigationViewController.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 addTarget:self
                action:@selector(button1:)
      forControlEvents:UIControlEventTouchDown];
    [button1 setTitle:@"Image Preview" forState:UIControlStateNormal];
    button1.frame = CGRectMake(80.0, 100.0, 160.0, 40.0);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 addTarget:self
                action:@selector(button2:)
      forControlEvents:UIControlEventTouchDown];
    [button2 setTitle:@"Efficiency Testing" forState:UIControlStateNormal];
    button2.frame = CGRectMake(80.0, 160.0, 160.0, 40.0);
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 addTarget:self
                action:@selector(button3:)
      forControlEvents:UIControlEventTouchDown];
    [button3 setTitle:@"Cropping Test" forState:UIControlStateNormal];
    button3.frame = CGRectMake(80.0, 220.0, 160.0, 40.0);
    
    [navigationViewController.view addSubview:button1];
    [navigationViewController.view addSubview:button2];
    [navigationViewController.view addSubview:button3];
    
    navCon = [[UINavigationController alloc] initWithRootViewController:navigationViewController];
    self.window.rootViewController = navCon;
    [self.window makeKeyAndVisible];
    return YES;
}

- (IBAction)button1:(id)sender{
    [navCon pushViewController:ivc animated:YES];
}

- (IBAction)button2:(id)sender{
    [navCon pushViewController:mvc animated:YES];
}

- (IBAction)button3:(id)sender{
    [navCon pushViewController:hvc animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
