#import <UIKit/UIKit.h>
#import "TGCapture.h"

@interface TGCaptureDatePicker : TGCapture{
    IBOutlet UIDatePicker   *datePicker;
}

- (TGCaptureDatePicker *)initWithTitle: (NSString *)title andMessage: (NSString *)message;

@end