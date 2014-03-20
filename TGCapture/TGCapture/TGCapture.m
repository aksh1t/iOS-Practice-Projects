#import "TGCapture.h"

@implementation TGCapture{
    KBKeyboardHandler *keyboard;
    BOOL canceled;
}

@synthesize delegate;

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (TGCapture *)initWithNibName:(id)nibName andTitle:(NSString *)title andMessage:(NSString *)message{
    self = [self initWithNibName:nibName bundle:nil];
    if(self){
        canceled = NO;
        
        [self.view.layer setCornerRadius:5];
        [self.view.layer setShadowOffset:CGSizeMake(5,5)];
        [self.view.layer setShadowRadius:10];
        [self.view.layer setShadowOpacity:0.3];
        
        [titleLabel setText:title];
        [messageLabel setText:message];
        
        keyboard = [[KBKeyboardHandler alloc] init];
        keyboard.delegate = self;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [singleTap setNumberOfTouchesRequired : 1];
        [overlayView addGestureRecognizer:singleTap];
    }
    
    return self;
}

- (void)tapped{
    canceled = YES;
    [self removePopupFromViewReturningData:nil];
}

- (void)showInViewController:(UIViewController *)vc{
    [overlayView setFrame:vc.view.frame];
    [self.view setCenter:vc.view.center];
    [vc addChildViewController:self];
    [vc.view addSubview:overlayView];
    [vc.view addSubview:self.view];
    
    overlayView.alpha = 0;
    self.view.alpha = 0;
    
    self.view.transform = CGAffineTransformMakeScale(0.01,0.01);
    
    [UIView animateWithDuration:0.3 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.transform = CGAffineTransformMakeScale(1.1,1.1);
                         overlayView.alpha = 0.6;
                         self.view.alpha = 1;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1 animations:^{
                             self.view.transform = CGAffineTransformMakeScale(1,1);
                         }];
                     }];
}

- (void)removePopupFromViewReturningData:(id)data{
    [UIView animateWithDuration:0.1 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.transform = CGAffineTransformMakeScale(1.1,1.1);
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3 animations:^{
                             self.view.transform = CGAffineTransformMakeScale(0.01,0.01);
                             overlayView.alpha = 0;
                             self.view.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self.view removeFromSuperview];
                             [overlayView removeFromSuperview];
                             [self removeFromParentViewController];
                         }];
                     }];
    
    if(canceled){
        [delegate tgCaptureReturnedData:nil];
    }else{
        [delegate tgCaptureReturnedData:data];
    }
}

- (void)keyboardSizeChanged:(CGSize)delta{
    delta.height += (delta.height<0)? 125:-125;
    CGRect frame = self.view.frame;
    frame.origin.y -= delta.height;
    self.view.frame = frame;
}

@end