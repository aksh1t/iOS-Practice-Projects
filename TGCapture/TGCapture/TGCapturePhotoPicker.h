#import <UIKit/UIKit.h>

@protocol TGCapturePhotoPickerDelegate;

@interface TGCapturePhotoPicker : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UIButton       *takePicture;
    IBOutlet UIButton       *selectPicture;
    IBOutlet UIView         *overlayView;
}

@property (nonatomic, retain) id<TGCapturePhotoPickerDelegate> delegate;

- (TGCapturePhotoPicker *)initWithTitle: (NSString *)title andMessage: (NSString *)message;
- (void)showInViewController: (UIViewController *)vc;

@end

@protocol TGCapturePhotoPickerDelegate <NSObject>
@required
- (void)tgCapturePhotoPickerReturnedData: (NSDictionary *)info;
@end