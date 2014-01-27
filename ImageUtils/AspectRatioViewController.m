//
//  AspectRatioViewController.m
//  ImageUtils
//
//  Created by Akshat on 22/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "AspectRatioViewController.h"

@interface AspectRatioViewController ()

@end

@implementation AspectRatioViewController

@synthesize delegate;

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
    
    ratioArray = [[NSArray alloc]initWithObjects:@"4x5",@"5x7",@"4x6",@"Square", nil];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ratioArray count];
}

-(UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [ratioArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate returnAspectRatio:[ratioArray objectAtIndex:indexPath.row]];
}

@end
