//
//  ViewController.h
//  InstaEmail
//
//  Created by Vishal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController

<UIPickerViewDataSource,UIPickerViewDelegate,MFMailComposeViewControllerDelegate>{
    
    UIPickerView *emailPicker;
    UITextField *notesField;
    NSArray *activities;
    NSArray *feelings;
    
}

@property(nonatomic,retain) IBOutlet UIPickerView *emailPickerOutlet;
@property(nonatomic,retain) IBOutlet UITextField *notesFieldOutlet;

- (IBAction)sendButtonTapped:(id)sender;
- (IBAction)notesFieldDone:(id)sender;

@end
