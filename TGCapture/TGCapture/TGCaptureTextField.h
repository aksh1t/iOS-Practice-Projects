#import <UIKit/UIKit.h>
#import "TGCapture.h"

@interface TGCaptureTextField : TGCapture  <UITextFieldDelegate>{
    IBOutlet UITextField    *textField;
}

- (TGCaptureTextField *)initWithTitle: (NSString *)title andMessage: (NSString *)message;

@end