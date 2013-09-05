//
//  ViewController.m
//  Calculator
//
//  Created by Vishal on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,bdot,bplus,bclear,bequal,bminus,bdivide,bmultiply,op,field;
@synthesize no1,no2,opstr,clear;

- (IBAction)buttonpressed:(id)sender{
    if(sender == bdot){
        if([self.field.text rangeOfString:@"."].location == NSNotFound ){
            self.field.text = [NSString stringWithFormat:@"%@%@",self.field.text,[sender currentTitle]];
        }
    }else{
        if(!clear){
            self.field.text = [NSString stringWithFormat:@"%@%@",self.field.text,[sender currentTitle]];
        }else{
            self.field.text = [NSString stringWithFormat:@"%@",[sender currentTitle]];
            clear = NO;
        }
    }
}
- (IBAction)bclearpressed:(id)sender{
    self.field.text = [NSString stringWithFormat:@""];
    self.op.text = [NSString stringWithFormat:@""];
    clear = NO;
}
- (IBAction)bpluspressed:(id)sender{
    [self setNo1:[self.field.text doubleValue]];
    self.op.text = [NSString stringWithFormat:@"+"];
    clear = YES;
    [self setOpstr:@"plus"];
}
- (IBAction)bminuspressed:(id)sender{
    [self setNo1:[self.field.text doubleValue]];
    self.op.text = [NSString stringWithFormat:@"-"];
    clear = YES;
    [self setOpstr:@"minus"];
}
- (IBAction)bdividepressed:(id)sender{
    [self setNo1:[self.field.text doubleValue]];
    self.op.text = [NSString stringWithFormat:@"÷"];
    clear = YES;
    [self setOpstr:@"divide"];
}
- (IBAction)bmultiplypressed:(id)sender{
    [self setNo1:[self.field.text doubleValue]];
    self.op.text = [NSString stringWithFormat:@"×"];
    clear = YES;
    [self setOpstr:@"multiply"];
}

- (IBAction)bequalpressed:(id)sender{
    if(opstr==nil){}
    else{
        double ans;
        [self setNo2:[self.field.text doubleValue]];
        self.op.text = [NSString stringWithFormat:@"="];
        if(opstr==@"plus"){
            ans = no1 + no2;
            self.field.text = [NSString stringWithFormat:@"%.2f",ans];
            [self setOpstr:nil];
            [self setNo1:0];
            [self setNo2:0];
            clear = YES;
        }else if(opstr==@"minus"){
            ans = no1 - no2;
            self.field.text = [NSString stringWithFormat:@"%.2f",ans];
            [self setOpstr:nil];
            [self setNo1:0];
            [self setNo2:0];
            clear = YES;
        }else if(opstr==@"multiply"){
            ans = no1 * no2;
            self.field.text = [NSString stringWithFormat:@"%.2f",ans];
            [self setOpstr:nil];
            [self setNo1:0];
            [self setNo2:0];
            clear = YES;
        }else if(opstr==@"divide"){
            if(no2==0){ 
                self.field.text = [NSString stringWithFormat:@"Division by 0 error!"];
            }else{
                ans = no1/no2;
                self.field.text = [NSString stringWithFormat:@"%.2f",ans];
            }
            [self setOpstr:nil];
            [self setNo1:0];
            [self setNo2:0];
            clear = YES;
        }else {
            self.field.text = [NSString stringWithFormat:@"Error!"];
            [self setOpstr:nil];
            [self setNo1:0];
            [self setNo2:0];
            clear = YES;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNo1:0];
    [self setNo2:0];
    [self setOpstr:nil];
    clear = NO;
    self.op.text = [NSString stringWithFormat:@""];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
