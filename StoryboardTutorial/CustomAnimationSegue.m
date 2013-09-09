#import "CustomAnimationSegue.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomAnimationSegue

-(void)perform{
    UIViewController *dst = [self destinationViewController];
    UIViewController *src = [self sourceViewController];
    
    [src.view addSubview:dst.view];
    
    dst.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [UIView animateWithDuration:0.2f animations:^{
        dst.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    } completion:^(BOOL finished) {
    
//Uncomment below stuff for rubberband zoom
        
//        [UIView animateWithDuration:0.3f animations:^{
//            dst.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
//                    NSLog(@"2");
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2f animations:^{
//                dst.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
//                        NSLog(@"3");
//            }];
//        }];
    }];
    
    [self performSelector:@selector(animationDone:) withObject:dst afterDelay:0.01f];
}

- (void)animationDone:(id)vc{
    UIViewController *dst = (UIViewController*)vc;
    UINavigationController *nav = [[self sourceViewController] navigationController];
    [nav popViewControllerAnimated:NO];
    [nav pushViewController:dst animated:NO];
}

@end