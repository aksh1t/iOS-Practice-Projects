//
//  ViewController1.m
//  StoryboardTutorial
//
//  Created by Akshat on 06/09/13.
//  Copyright (c) 2013 Akshat. All rights reserved.
//

#import "ViewController1.h"
#import "CustomAnimationSegue.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)exitMethod:(UIStoryboardSegue *)myStoryboardSegue{
}

-(IBAction)customExitMethod:(UIStoryboardSegue *)myStoryboardSegue{
    
    UIViewController *src = myStoryboardSegue.sourceViewController;
    
    [UIView animateWithDuration:0.2 animations:^{
        src.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    } completion:^(BOOL finished) {
        [src.navigationController popToRootViewControllerAnimated:NO];
    }];
}

@end
