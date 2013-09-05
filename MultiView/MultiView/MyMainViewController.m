//
//  MyMainViewController.m
//  MultiView
//
//  Created by Vishal on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyMainViewController.h"

@interface MyMainViewController ()

@end

@implementation MyMainViewController


@synthesize redViewController, greenViewController;

- (IBAction)switchViews:(id)sender
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
    if (self.greenViewController.view.superview == nil)
    {
        if (self.greenViewController == nil)
        {   
            
            GreenViewController *greenController = 
            [[GreenViewController alloc] initWithNibName:@"GreenView" 
                                                  bundle:nil];
            self.greenViewController = greenController;
            
        }
        [UIView setAnimationTransition:
         UIViewAnimationTransitionCurlUp
                               forView:self.view cache:YES];      
		
        [redViewController viewWillAppear:YES];
        [greenViewController viewWillDisappear:YES];
        [redViewController.view removeFromSuperview];
        [self.view insertSubview:greenViewController.view atIndex:0];
        [greenViewController viewDidDisappear:YES];
        [redViewController viewDidAppear:YES];
        
    }
    else if(self.redViewController.view.superview == nil)
    {
        if (self.redViewController == nil)
        {
            RedViewController *redController = 
            [[RedViewController alloc] initWithNibName:@"RedView" 
                                                bundle:nil];
            self.redViewController = redController;
            
        }
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromLeft
                               forView:self.view cache:YES];
        
        [greenViewController viewWillAppear:YES];
        [redViewController viewWillDisappear:YES];
        [greenViewController.view removeFromSuperview];
        [self.view insertSubview:redViewController.view atIndex:0];
        [redViewController viewDidDisappear:YES];
        [greenViewController viewDidAppear:YES]; 
    }
    [UIView commitAnimations];
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if (self.redViewController.view.superview == nil) 
        self.redViewController = nil;
    else
        self.greenViewController = nil;
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
    RedViewController *redController = [[RedViewController alloc] initWithNibName:@"RedView" bundle:nil];
	self.redViewController = redController;
	[self.view insertSubview:redController.view atIndex:0];
//    [self.view setBackgroundColor:[UIColor yellowColor]];
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

@end
