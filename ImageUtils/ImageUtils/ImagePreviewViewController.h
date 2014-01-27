//
//  ImagePreviewViewController.h
//  ImageUtils
//
//  Created by Akshat on 22/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"
#import "AspectRatioViewController.h"

@interface ImagePreviewViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,WYPopoverControllerDelegate,MyProtocolDelegate>{
    BOOL aspctFill;
    int aspectHeight;
    int aspectWidth;
    IBOutlet UITableView *tableView;
    WYPopoverController *popover;
    AspectRatioViewController *avc;
    UIImage *thumbnail;
}

@property (nonatomic, retain) IBOutlet UIImageView *imgView;

@property (nonatomic, retain) IBOutlet UIButton *button;

@property (nonatomic, retain) IBOutlet UISwitch *mySwitch;

-(IBAction)switchValueChanged:(id)sender;

-(IBAction)buttonClicked:(id)sender;

@end
