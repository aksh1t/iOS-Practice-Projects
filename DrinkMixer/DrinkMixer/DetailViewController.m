//
//  DetailViewController.m
//  DrinkMixer
//
//  Created by Vishal on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "DrinkConstants.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameField, ingredients, directions, drink, scrollView;

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.nameField.text = [self.drink objectForKey:NAME_KEY];
    
    self.ingredients.text = [self.drink objectForKey:INGREDIENTS_KEY];
    
    self.directions.text = [self.drink objectForKey:DIRECTIONS_KEY];
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
    
    self.scrollView.contentSize = self.view.frame.size;

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

@end
