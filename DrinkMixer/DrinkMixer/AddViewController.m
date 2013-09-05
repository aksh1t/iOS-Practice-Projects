//
//  AddViewController.m
//  DrinkMixer
//
//  Created by Vishal on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddViewController.h"
#import "DetailViewController.h"
#import "DrinkConstants.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize drinkArray;

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.nameField setEnabled:YES];
    
    [self.ingredients setEditable:YES];
    
    [self.directions setEditable:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarddidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    keyboardVisible = NO;
}

- (void)viewWillDisappear:(BOOL)animated{

    [self.nameField setEnabled:NO];
    
    [self.ingredients setEditable:NO];
    
    [self.directions setEditable:NO];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

#pragma mark Keyboard handlers

- (void)keyboardDidShow:(NSNotification *)notif{
    
    if(keyboardVisible){
        return;
    }
    
    NSDictionary *info = [notif userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    
    CGRect viewFrame = self.view.bounds;
    
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    self.scrollView.frame = viewFrame;
    
    keyboardVisible = YES;
}

- (void)keyboarddidHide:(NSNotification *)notif{
    
    if(!keyboardVisible){
        return;
    }
    
    self.scrollView.frame = self.view.bounds;

    keyboardVisible = NO;
    
}

- (IBAction)save:(id)sender{
    
    if(self.drink !=nil){
        
        [drinkArray removeObject:self.drink];
        
        self.drink = nil;
    }
    
    NSMutableDictionary * newDrink = [[NSMutableDictionary alloc]init];
    
    [newDrink setValue:self.nameField.text forKey:NAME_KEY];
    
    [newDrink setValue:self.ingredients.text forKey:INGREDIENTS_KEY];
    
    [newDrink setValue:self.directions.text forKey:DIRECTIONS_KEY];
    
    [drinkArray addObject:newDrink];
    
    NSSortDescriptor * sorter = [[NSSortDescriptor alloc]initWithKey:NAME_KEY ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    [drinkArray sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)cancel:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
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
        
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
