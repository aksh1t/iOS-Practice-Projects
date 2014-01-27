//
//  ImagePreviewViewController.m
//  ImageUtils
//
//  Created by Akshat on 22/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "ImagePreviewViewController.h"
#import "WYPopoverController.h"
#import "AspectRatioViewController.h"
#import "ImageUtils.h"

@interface ImagePreviewViewController ()

@end

@implementation ImagePreviewViewController

@synthesize imgView,button,mySwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        imgView = [[UIImageView alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    avc = [[AspectRatioViewController alloc]initWithNibName:@"AspectRatioViewController" bundle:nil];
    avc.delegate = self;
    
    ImageUtils *util = [[ImageUtils alloc]init];
    thumbnail = [util imageWithImage:[UIImage imageNamed:@"twomb.jpg"] scaledToWidth:160];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)myTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MyCell";
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = (UITableViewCell *)[nib objectAtIndex:0];
    }
    
    imgView.image = thumbnail;
    
    button.tag = 1;
    imgView.tag = 2;
    mySwitch.tag = 3;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(IBAction)buttonClicked:(id)sender{
    
    CGPoint touchPoint = [[(UIButton *)sender superview] convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:touchPoint];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIButton *thisButton = (UIButton *)[cell viewWithTag:1];
    button = thisButton;
    
    UIImageView *thisImgView = (UIImageView *)[cell viewWithTag:2];
    imgView = thisImgView;
    
    popover = [[WYPopoverController alloc] initWithContentViewController:avc];
    
    WYPopoverBackgroundView *popoverAppearance = [WYPopoverBackgroundView appearance];
    
    [popoverAppearance setOuterCornerRadius:4];
    [popoverAppearance setOuterShadowBlurRadius:0];
    [popoverAppearance setOuterShadowColor:[UIColor clearColor]];
    [popoverAppearance setOuterShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setGlossShadowColor:[UIColor clearColor]];
    [popoverAppearance setGlossShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setBorderWidth:8];
    [popoverAppearance setArrowHeight:10];
    [popoverAppearance setArrowBase:20];
    
    [popoverAppearance setInnerCornerRadius:4];
    [popoverAppearance setInnerShadowBlurRadius:0];
    [popoverAppearance setInnerShadowColor:[UIColor clearColor]];
    [popoverAppearance setInnerShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setFillTopColor:[UIColor darkGrayColor]];
    [popoverAppearance setFillBottomColor:[UIColor darkGrayColor]];
    [popoverAppearance setOuterStrokeColor:[UIColor darkGrayColor]];
    [popoverAppearance setInnerStrokeColor:[UIColor darkGrayColor]];
    
    popover.popoverContentSize = avc.view.frame.size;
    [popover presentPopoverFromRect:thisButton.bounds
                             inView:thisButton
           permittedArrowDirections:WYPopoverArrowDirectionAny
                           animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller{
    popover.delegate = nil;
    popover = nil;
}

-(IBAction)switchValueChanged:(id)sender{
    
    CGPoint touchPoint = [[(UIButton *)sender superview] convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:touchPoint];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    mySwitch = (UISwitch *)[cell viewWithTag:3];
    ImageUtils *util = [[ImageUtils alloc]init];
    imgView.image = [util resizeImage:thumbnail toAspectWidth:imgView.image.size.width andAspectHeight:imgView.image.size.height isAspectFill:mySwitch.isOn];
    
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
}

-(void)returnAspectRatio:(NSString *)myString{
    [button setTitle:myString forState:UIControlStateNormal];
    
    ImageUtils *util = [[ImageUtils alloc]init];
    
    int w,h;
    
    if([myString isEqualToString:@"Square"]){
        w=1;h=1;
    }else{
        NSArray *arr = [myString componentsSeparatedByString:@"x"];
        w = (int)[(NSString *)[arr objectAtIndex:0]integerValue];
        h = (int)[(NSString *)[arr objectAtIndex:1]integerValue];
    }
    
    imgView.image = [util resizeImage:thumbnail toAspectWidth:w andAspectHeight:h isAspectFill:mySwitch.isOn];
    
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    [popover dismissPopoverAnimated:YES];
}

@end
