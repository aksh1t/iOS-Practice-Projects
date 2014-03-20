#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "TGCapture.h"

@interface TGCaptureVideoPicker : TGCapture <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UIButton       *takePicture;
    IBOutlet UIButton       *selectPicture;
}

- (TGCaptureVideoPicker *)initWithTitle: (NSString *)title andMessage: (NSString *)message;

@end