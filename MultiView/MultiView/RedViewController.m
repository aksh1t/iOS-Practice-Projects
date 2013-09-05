//
//  RedViewController.m
//  MultiView
//
//  Created by Vishal on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RedViewController.h"

@implementation RedViewController

- (IBAction)redButtonPressed:(id)sender
{
	UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Red View Button Pressed" 
                                                    message:@"You pressed the button on the red view" 
                                                   delegate:self cancelButtonTitle:@"Yep, I did." 
                                          otherButtonTitles:nil];
	[alert1 show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

@end
