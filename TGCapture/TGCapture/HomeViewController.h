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

@interface HomeViewController : UIViewController <TGCaptureTextFieldDelegate,TGCaptureTextViewDelegate,TGCaptureDatePickerDelegate>

- (IBAction)buttonClicked:(id)sender;
- (IBAction)button2Clicked:(id)sender;
- (IBAction)button3Clicked:(id)sender;

@end