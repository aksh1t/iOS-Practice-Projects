//
//  HomeViewController.h
//  CocoaPodsExample
//
//  Created by Akshat on 07/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"

@interface HomeViewController : UIViewController <UIScrollViewDelegate,NIAttributedLabelDelegate>{
    
    IBOutlet UIScrollView* scrollView;
    IBOutlet UIPageControl *showPageControl;
    
}

-(IBAction)pageChanged:(id)sender;

@end
