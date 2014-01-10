//
//  MyViewController.m
//  Test
//
//  Created by Akshat on 01/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "MyViewController.h"
#include <AVFoundation/AVFoundation.h>

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    data = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    selecteddata = [[NSMutableArray alloc]init];
    
    self.title = @"TestTable";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
}

- (void)edit{

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
   
    
    NSLog(@"log");
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Selected";
    }else{
        return @"Unselected";
    }
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if(section==0){
            return selecteddata.count;
        }else{
            return data.count;
        }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   //    if([self numberOfSectionsInTableView:myTableView]==1){
//        if(selecteddata.count == 0){
//            cell.textLabel.text = [data objectAtIndex:indexPath.row];
//        }else{
//            cell.textLabel.text = [selecteddata objectAtIndex:indexPath.row];
//        }
//    }else{
        if(indexPath.section == 0){
            cell.textLabel.text = [selecteddata objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.textLabel.text = [data objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
//    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([myTableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){

        [myTableView beginUpdates];
        [myTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        
        NSString *string = [selecteddata objectAtIndex:indexPath.row];
        [selecteddata removeObjectAtIndex:indexPath.row];
        
        NSUInteger newIndex = [data indexOfObject:string
                                            inSortedRange:(NSRange){0, [data count]}
                                                  options:NSBinarySearchingInsertionIndex
                                          usingComparator:^(id obj1, id obj2) {
                                              return [obj1 caseInsensitiveCompare:obj2];
                                          }];
        
        [data insertObject:string atIndex:newIndex];
        NSIndexPath *index = [NSIndexPath indexPathForRow:newIndex inSection:1];
        
        
        
        UITableViewCell *cell = [myTableView cellForRowAtIndexPath:indexPath];
        
        cell.layer.shadowOffset = CGSizeMake(0, 1);
        cell.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.layer.shadowRadius = 7;
        CGRect shadowFrame = cell.layer.bounds;
        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
        cell.layer.shadowPath = shadowPath;
        
        //shadow on
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:0.75];
        anim.duration = 0.75;
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [cell.layer addAnimation:anim forKey:@"shadowOpacity"];
            sleep(0.75);
        });
        cell.layer.shadowOpacity = 0.75;
        
        
        [myTableView moveRowAtIndexPath:indexPath toIndexPath:index];
        
        
        //shadow off
        anim.fromValue = [NSNumber numberWithFloat:0.75];
        anim.toValue = [NSNumber numberWithFloat:0.0];
        anim.duration = 0.75;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [cell.layer addAnimation:anim forKey:@"shadowOpacity"];
        });
        cell.layer.shadowOpacity = 0.0;
        [myTableView endUpdates];
        
    }else{
        
        [myTableView beginUpdates];
        [myTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
        NSString *string = [data objectAtIndex:indexPath.row];
        [data removeObjectAtIndex:indexPath.row];

        NSUInteger newIndex = [selecteddata indexOfObject:string
                                     inSortedRange:(NSRange){0, [selecteddata count]}
                                           options:NSBinarySearchingInsertionIndex
                                          usingComparator:^(id obj1, id obj2) {
                                              return [obj1 caseInsensitiveCompare:obj2];
                                          }];
        
        [selecteddata insertObject:string atIndex:newIndex];
        NSIndexPath *index = [NSIndexPath indexPathForRow:newIndex inSection:0];
        


        UITableViewCell *cell = [myTableView cellForRowAtIndexPath:indexPath];
        
        cell.layer.shadowOffset = CGSizeMake(0, 1);
        cell.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.layer.shadowRadius = 7;
        CGRect shadowFrame = cell.layer.bounds;
        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
        cell.layer.shadowPath = shadowPath;
    
        //shadow on
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        
        //
//        anim.delegate = self;
//        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
//        
        //
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:0.75];
        anim.duration = 0.75;
        
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [cell.layer addAnimation:anim forKey:@"shadowOpacity"];
//            sleep(0.75);
//        });
        cell.layer.shadowOpacity = 0.75;
        
        
        [myTableView moveRowAtIndexPath:indexPath toIndexPath:index];
        
        
        //shadow off
        anim.fromValue = [NSNumber numberWithFloat:0.75];
        anim.toValue = [NSNumber numberWithFloat:0.0];
        anim.duration = 0.75;
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [cell.layer addAnimation:anim forKey:@"shadowOpacity"];
//        });
        cell.layer.shadowOpacity = 0.0;
        [myTableView endUpdates];
    }
}


//- (void)animationDidStop:(CAAnimation *)theAnimation2 finished:(BOOL)flag {
//
//
//}

//Animation{
//    
//    UITableViewCell *cell = [myTableView cellForRowAtIndexPath:finish];
//    
//    cell.layer.shadowOffset = CGSizeMake(0, 1);
//    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
//    cell.layer.shadowRadius = 5;
//    CGRect shadowFrame = cell.layer.bounds;
//    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//    cell.layer.shadowPath = shadowPath;
//    
//    //shadow on
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
//    anim.fromValue = [NSNumber numberWithFloat:0.0];
//    anim.toValue = [NSNumber numberWithFloat:0.5];
//    anim.duration = 0.5;
//    [cell.layer addAnimation:anim forKey:@"shadowOpacity"];
//    cell.layer.shadowOpacity = 0.5;
//    
//    
//    //shadow off
//    anim.fromValue = [NSNumber numberWithFloat:0.5];
//    anim.toValue = [NSNumber numberWithFloat:0.0];
//    anim.duration = 1;
//    [cell.layer addAnimation:anim forKey:@"shadowOpacity"];
//    cell.layer.shadowOpacity = 0.0;
//
//}



@end
