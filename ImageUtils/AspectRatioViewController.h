//
//  AspectRatioViewController.h
//  ImageUtils
//
//  Created by Akshat on 22/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol MyProtocolDelegate
-(void)returnAspectRatio:(NSString *)myString;
@end

@interface AspectRatioViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableView;
    NSArray *ratioArray;
}
@property (nonatomic, weak) id<MyProtocolDelegate> delegate;
@end