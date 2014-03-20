#import "TGCaptureTextField.h"

@implementation TGCaptureTextField

- (TGCaptureTextField *)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    self = [self initWithNibName:@"TGCaptureTextField" andTitle:title andMessage:message];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf{
    [tf resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)tf{
    [tf resignFirstResponder];
    return YES;
}

- (IBAction)doneButtonClicked:(id)sender{
    [self removePopupFromViewReturningData:textField.text];
}

@end