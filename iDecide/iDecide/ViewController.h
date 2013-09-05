//
//  ViewController.h
//  iDecide
//
//  Created by Vishal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    UILabel *answer;
    
}

@property(nonatomic,retain) IBOutlet UILabel *answeroutlet;

-(IBAction)buttonPressed:(id)sender;

@end
