//
//  ViewController2.m
//  StoryboardTutorial
//
//  Created by Akshat on 06/09/13.
//  Copyright (c) 2013 Akshat. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

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

- (void)viewDidAppear:(BOOL)animated{
}

-(IBAction)customExitMethod{
    NSLog(@"superview %@",[self.view superview]);
//    [UIView animateWithDuration:0.2 animations:^{
//        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
//    } completion:^(BOOL finished) {
//        [self.navigationController presentViewController:(UINavigationController *)[[self.view superview] superclass] animated:NO completion:^(void){}];
//    }];
}

@end
