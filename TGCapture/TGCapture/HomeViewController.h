//
//  HomeViewController.h
//  TGCapture
//
//  Created by Akshat on 18/03/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGCaptureTextField.h"
#import "TGCaptureTextView.h"
#import "TGCaptureDatePicker.h"
#import "TGCaptureTableView.h"
#import "TGCapturePhotoPicker.h"
#import "TGCaptureVideoPicker.h"

@interface HomeViewController : UIViewController <TGCaptureDelegate>

- (IBAction)buttonClicked:(id)sender;
- (IBAction)button2Clicked:(id)sender;
- (IBAction)button3Clicked:(id)sender;
- (IBAction)button4Clicked:(id)sender;
- (IBAction)button5Clicked:(id)sender;
- (IBAction)button6Clicked:(id)sender;

@end