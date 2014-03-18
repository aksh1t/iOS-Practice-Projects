#import <UIKit/UIKit.h>
#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"

@protocol TGCaptureTextFieldDelegate;

@interface TGCaptureTextField : UIViewController <UITextFieldDelegate, KBKeyboardHandlerDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UITextField    *textField;
    IBOutlet UIButton       *doneButton;
    IBOutlet UIView         *overlayView;
}

@property (nonatomic, retain) id<TGCaptureTextFieldDelegate> delegate;

- (TGCaptureTextField *)initWithTitle: (NSString *)title andMessage: (NSString *)message;
- (void)showInViewController: (UIViewController *)vc;

@end

@protocol TGCaptureTextFieldDelegate <NSObject>
@required
- (void)tgCaptureTextFieldReturnedData: (NSString *)data;
@end