#import <UIKit/UIKit.h>
#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"

@protocol TGCaptureDelegate <NSObject>
@required
- (void)tgCaptureReturnedData: (id)data;
@end

@interface TGCapture : UIViewController <KBKeyboardHandlerDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UIButton       *doneButton;
    IBOutlet UIView         *overlayView;
}

@property (nonatomic, retain) id<TGCaptureDelegate> delegate;

- (void)removePopupFromViewReturningData:(id)data;
- (void)showInViewController:(UIViewController *)vc;
- (TGCapture *)initWithNibName:(id)nibName andTitle:(NSString *)title andMessage:(NSString *)message;

@end