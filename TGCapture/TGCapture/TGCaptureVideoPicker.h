#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

@protocol TGCaptureVideoPickerDelegate;

@interface TGCaptureVideoPicker : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UIButton       *takePicture;
    IBOutlet UIButton       *selectPicture;
    IBOutlet UIView         *overlayView;
}

@property (nonatomic, retain) id<TGCaptureVideoPickerDelegate> delegate;

- (TGCaptureVideoPicker *)initWithTitle: (NSString *)title andMessage: (NSString *)message;
- (void)showInViewController: (UIViewController *)vc;

@end

@protocol TGCaptureVideoPickerDelegate <NSObject>
@required
- (void)tgCaptureVideoPickerReturnedData: (NSDictionary *)info;
@end