#import <UIKit/UIKit.h>
#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"

#define popupBackgroundColor        @"popupBackgroundColor"
#define popupCornerRadius           @"popupCornerRadius"
#define separatorColor              @"separatorColor"

@protocol TGCaptureDelegate <NSObject>
@required
- (void)tgCapture:(id)sender returnedData: (id)data;
@end

@interface TGCapture : UIViewController <KBKeyboardHandlerDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UIButton       *doneButton;
    IBOutlet UIView         *overlayView;
    IBOutlet UIView         *separatorView;
}

@property (nonatomic, weak) id<TGCaptureDelegate> delegate;

- (void)setAppearance:(NSDictionary *)appearance;
- (void)removePopupFromViewReturningData:(id)data;
- (void)showInViewController:(UIViewController *)vc;
- (TGCapture *)initWithNibName:(id)nibName andTitle:(NSString *)title andMessage:(NSString *)message;

@end