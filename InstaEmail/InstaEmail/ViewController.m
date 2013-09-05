//
//  ViewController.m
//  InstaEmail
//
//  Created by Vishal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize emailPickerOutlet = emailPicker;
@synthesize notesFieldOutlet = notesField;

#pragma mark -

#pragma mark Mail composer delegate method

-(void) mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -

#pragma mark Picker Delegate Protocol

- (NSString *)pickerView:(UIPickerView *) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0){
        return [activities objectAtIndex:row];
    }else{
        return [feelings objectAtIndex:row];
    }
    return nil;
}

#pragma mark -

#pragma mark Picker Datasource Protocol

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component == 0){
        return [activities count];
    } else {
        return [feelings count];
    }
}

- (IBAction)notesFieldDone:(id)sender{
    
    [sender resignFirstResponder];
}

- (IBAction)sendButtonTapped:(id)sender{
    
    NSString *message = [NSString stringWithFormat:@"%@ I'm %@ and feeling %@ about it.",notesField.text?notesField.text:@"",[activities objectAtIndex:[emailPicker selectedRowInComponent:0]],[feelings objectAtIndex:[emailPicker selectedRowInComponent:1]]];
    
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc]init];
        mailController.mailComposeDelegate = self;
        [mailController setSubject:@"InstaEmail Testing"];
        [mailController setMessageBody:message isHTML:NO];
        [self presentModalViewController:mailController animated:YES];
    }else{
        NSLog(@"Sorry, you need to setup your mail first.");
    }
    
    NSLog(@"%@",message);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activities = [[NSArray alloc]initWithObjects:@"eating",@"thinking",@"sleeping",@"working",@"shopping",@"coding",@"reading",@"laughing",@"crying", nil];
    
    feelings = [[NSArray alloc]initWithObjects:@"happy",@"sad",@"awesome",@"ill",@"confused",@"hopeful",@"anxious",@"psyched", nil];
    
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
