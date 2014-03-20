#import "TGCaptureTextView.h"

@implementation TGCaptureTextView

- (TGCaptureTextView *)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    self = [self initWithNibName:@"TGCaptureTextView" andTitle:title andMessage:message];
    if(self){
        [textView.layer setCornerRadius:5];
        [textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [textView.layer setBorderWidth:0.5];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)tv{
    return YES;
}

- (BOOL)textViewShouldReturn:(UITextView *)tv{
    [tv resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)tv{
    [tv resignFirstResponder];
    return YES;
}

- (IBAction)doneButtonClicked:(id)sender{
    [self removePopupFromViewReturningData:textView.text];
}

@end