//
//  ViewController.h
//  Calculator
//
//  Created by Vishal on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    double no1;
    double no2;
    BOOL clear;
    NSString * opstr;
    
    UITextField * field;    UILabel * op;
    
    UIButton * b1;  UIButton * b2;  UIButton * b3;  UIButton * b4;  UIButton * b5; 
    UIButton * b6;  UIButton * b7;  UIButton * b8;  UIButton * b9;  UIButton * b0;
  
    UIButton * bclear;  UIButton * bplus;   UIButton * bminus;  UIButton * bmultiply;
    UIButton * bdivide; UIButton * bequal;  UIButton * bdot;
}

@property double no1;
@property double no2;
@property BOOL clear;
@property (nonatomic, retain) NSString * opstr;

@property (nonatomic, retain) IBOutlet UITextField * field;
@property (nonatomic, retain) IBOutlet UILabel * op;
@property (nonatomic, retain) IBOutlet UIButton * b1;
@property (nonatomic, retain) IBOutlet UIButton * b2;
@property (nonatomic, retain) IBOutlet UIButton * b3;
@property (nonatomic, retain) IBOutlet UIButton * b4;
@property (nonatomic, retain) IBOutlet UIButton * b5;
@property (nonatomic, retain) IBOutlet UIButton * b6;
@property (nonatomic, retain) IBOutlet UIButton * b7;
@property (nonatomic, retain) IBOutlet UIButton * b8;
@property (nonatomic, retain) IBOutlet UIButton * b9;
@property (nonatomic, retain) IBOutlet UIButton * b0;
@property (nonatomic, retain) IBOutlet UIButton * bclear;
@property (nonatomic, retain) IBOutlet UIButton * bplus;
@property (nonatomic, retain) IBOutlet UIButton * bminus;
@property (nonatomic, retain) IBOutlet UIButton * bmultiply;
@property (nonatomic, retain) IBOutlet UIButton * bdivide;
@property (nonatomic, retain) IBOutlet UIButton * bequal;
@property (nonatomic, retain) IBOutlet UIButton * bdot;

- (IBAction)buttonpressed:(id)sender;

- (IBAction)bclearpressed:(id)sender;
- (IBAction)bpluspressed:(id)sender;
- (IBAction)bminuspressed:(id)sender;
- (IBAction)bmultiplypressed:(id)sender;
- (IBAction)bdividepressed:(id)sender;
- (IBAction)bequalpressed:(id)sender;

@end
