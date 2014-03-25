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
        overlayView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    }
    return self;
}

- (void)tapped{
    canceled = YES;
    [self removePopupFromViewReturningData:nil];
}

- (void)setAppearance:(NSDictionary *)appearance{
    if([appearance valueForKey:popupBackgroundColor]!=nil && [[appearance valueForKey:popupBackgroundColor] isKindOfClass:[UIColor class]]){
        [self.view setBackgroundColor:(UIColor *)[appearance valueForKey:popupBackgroundColor]];
    }
    if([appearance valueForKey:popupCornerRadius]!=nil&&[[appearance valueForKey:popupCornerRadius] isKindOfClass:[NSNumber class]]){
        [self.view.layer setCornerRadius:[[appearance valueForKey:popupCornerRadius] floatValue]];
    }
    if([appearance valueForKey:separatorColor]!=nil&&[[appearance valueForKey:separatorColor] isKindOfClass:[UIColor class]]){
        [separatorView setBackgroundColor:(UIColor *)[appearance valueForKey:separatorColor]];
    }
}

- (void)showInViewController:(UIViewController *)vc{
    UIInterfaceOrientation orientation= [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft){
        [overlayView setFrame:CGRectMake(0, 0, vc.view.frame.size.height, vc.view.frame.size.width)];
        [self.view setCenter:CGPointMake(vc.view.center.y, vc.view.center.x)];
    }else{
        [overlayView setFrame:CGRectMake(0, 0, vc.view.frame.size.width, vc.view.frame.size.height)];
        [self.view setCenter:vc.view.center];
    }
    
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
        [delegate tgCapture:self returnedData:nil];
    }else{
        [delegate tgCapture:self returnedData:data];
    }
}

- (void)keyboardSizeChanged:(CGSize)delta{
    UIInterfaceOrientation orientation= [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft){
        delta.height += (delta.height<0)? 175:-175;
        if(!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            delta.height += (delta.height<0)? 120:-120;
        }
    }else{
        delta.height += (delta.height<0)? 125:-125;
    }
    
    CGRect frame = self.view.frame;
    frame.origin.y -= delta.height;
    self.view.frame = frame;
}

@end