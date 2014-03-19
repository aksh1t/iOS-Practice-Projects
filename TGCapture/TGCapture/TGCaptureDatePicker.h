#import <UIKit/UIKit.h>

@protocol TGCaptureDatePickerDelegate;

@interface TGCaptureDatePicker : UIViewController{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UIDatePicker   *datePicker;
    IBOutlet UIButton       *doneButton;
    IBOutlet UIView         *overlayView;
}

@property (nonatomic, retain) id<TGCaptureDatePickerDelegate> delegate;

- (TGCaptureDatePicker *)initWithTitle: (NSString *)title andMessage: (NSString *)message;
- (void)showInViewController: (UIViewController *)vc;

@end

@protocol TGCaptureDatePickerDelegate <NSObject>
@required
- (void)tgCaptureDatePickerReturnedDate: (NSDate *)date;
@end