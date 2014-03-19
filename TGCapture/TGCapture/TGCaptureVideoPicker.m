#import "TGCaptureVideoPicker.h"

@implementation TGCaptureVideoPicker{
    BOOL canceled;
}

@synthesize delegate;

- (TGCaptureVideoPicker *)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    self = [self initWithNibName:@"TGCaptureVideoPicker" bundle:nil];
    if(self){
        canceled = NO;
        
        [self.view.layer setCornerRadius:5];
        [self.view.layer setShadowOffset:CGSizeMake(5,5)];
        [self.view.layer setShadowRadius:10];
        [self.view.layer setShadowOpacity:0.3];
        
        [takePicture.layer setCornerRadius:5];
        [selectPicture.layer setCornerRadius:5];
        
        [titleLabel setText:title];
        [messageLabel setText:message];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [singleTap setNumberOfTouchesRequired : 1];
        [overlayView addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)tapped{
    canceled = YES;
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
                             [delegate tgCaptureVideoPickerReturnedData:nil];
                         }];
                     }];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)takePicture:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
        
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerCameraCaptureModeVideo;
        picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (IBAction)selectPicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,nil];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.view removeFromSuperview];
    [overlayView removeFromSuperview];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self removeFromParentViewController];
    
    if(canceled) [delegate tgCaptureVideoPickerReturnedData:nil];
    else [delegate tgCaptureVideoPickerReturnedData:info];
}

@end