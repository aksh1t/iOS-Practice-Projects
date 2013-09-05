//
//  ViewController.h
//  Components
//
//  Created by Vishal on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController{
    
    UILabel *myLabel;
    UILabel *sliderlabel;
    UISlider *slider;
    UISwitch *myswitch;
    UIActivityIndicatorView *ai;
    UIScrollView *scrollView1;
    UIScrollView *scrollView2;
}

@property (nonatomic, retain) UILabel *myLabel;
@property (nonatomic, retain) UILabel *sliderlabel;
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UISwitch *myswitch;
@property (nonatomic, retain) UIActivityIndicatorView *ai;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView1;
@property (nonatomic, retain) UIScrollView *scrollView2;

- (IBAction)doneButtonClicked:(id)sender;

- (void)rainbowButtonClicked;

- (IBAction)segmentclick:(id)sender;

@end
