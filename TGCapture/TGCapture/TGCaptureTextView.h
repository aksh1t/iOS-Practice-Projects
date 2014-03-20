#import <UIKit/UIKit.h>
#import "TGCapture.h"

@interface TGCaptureTextView : TGCapture <UITextViewDelegate>{
    IBOutlet UITextView     *textView;
}

- (TGCaptureTextView *)initWithTitle: (NSString *)title andMessage: (NSString *)message;

@end