//
//  MyViewController.h
//  Test
//
//  Created by Akshat on 01/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *data;
    NSMutableArray *selecteddata;

}

@end
