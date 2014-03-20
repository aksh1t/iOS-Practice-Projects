#import "TGCapturePhotoPicker.h"

@implementation TGCapturePhotoPicker

- (TGCapturePhotoPicker *)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    self = [self initWithNibName:@"TGCapturePhotoPicker" andTitle:title andMessage:message];
    if(self){
        [takePicture.layer setCornerRadius:5];
        [selectPicture.layer setCornerRadius:5];
    }
    return self;
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
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [myAlertView show];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (IBAction)selectPicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self removePopupFromViewReturningData:info];
}

@end