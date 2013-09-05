//
//  DVController.h
//  CustomTableApp
//
//  Created by Vishal on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVControllerDelegate.h"
#import "MyData.h"

@interface DVController : UITableViewController <UIActionSheetDelegate>{
    
    NSArray *cellDataArray;
    
    UIDatePicker *picker;
    
    NSMutableDictionary *tempDict;
    
    NSString *titleString,*dateString;
    
    UIBarButtonItem *trashButton;
    
    UIButton *confirmButton;
    
    UIView *confirmView;
    
    UITextField *cellTextField,*pickerTextField;
    
    UILabel *cellLabel;
    
    NSInteger currentRow;
    
    MyData *dataObject;
    
    id <RVControllerDelegate> delegate;
    
}

- (IBAction)saveButtonClicked:(id)sender;

- (IBAction)trashButtonClicked:(id)sender;

- (IBAction)textFieldEditing:(UITextField *)textField;

- (IBAction)pickerValueChanged:(UIDatePicker *)picker;

@property (readwrite) NSInteger currentRow;

@property (nonatomic, retain) NSString *titleString;

@property (nonatomic, retain) IBOutlet UIButton *confirmButton;

@property (nonatomic, retain) IBOutlet UIView *confirmView;

@property (nonatomic, retain) IBOutlet UITextField *cellTextField;

@property (nonatomic, retain) IBOutlet UILabel *cellLabel;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *trashButton;

@property (nonatomic, retain) IBOutlet UIDatePicker *picker;

@property (nonatomic, retain) MyData *dataObject;

@property (retain, nonatomic) id <RVControllerDelegate> delegate;

@end

