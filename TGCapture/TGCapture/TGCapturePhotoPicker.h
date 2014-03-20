#import <UIKit/UIKit.h>
#import "TGCapture.h"

@interface TGCapturePhotoPicker : TGCapture <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UIButton       *takePicture;
    IBOutlet UIButton       *selectPicture;
}

- (TGCapturePhotoPicker *)initWithTitle: (NSString *)title andMessage: (NSString *)message;

@end