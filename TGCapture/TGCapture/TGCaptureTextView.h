#import <UIKit/UIKit.h>
#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"

@protocol TGCaptureTextViewDelegate;

@interface TGCaptureTextView : UIViewController <UITextViewDelegate, KBKeyboardHandlerDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UITextView     *textView;
    IBOutlet UIButton       *doneButton;
    IBOutlet UIView         *overlayView;
}

@property (nonatomic, retain) id<TGCaptureTextViewDelegate> delegate;

- (TGCaptureTextView *)initWithTitle: (NSString *)title andMessage: (NSString *)message;
- (void)showInViewController: (UIViewController *)vc;

@end

@protocol TGCaptureTextViewDelegate <NSObject>
@required
- (void)tgCaptureTextViewReturnedData: (NSString *)data;
@end