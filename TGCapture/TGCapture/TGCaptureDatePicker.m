#import "TGCaptureDatePicker.h"

@implementation TGCaptureDatePicker

- (TGCaptureDatePicker *)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    self = [self initWithNibName:@"TGCaptureDatePicker" andTitle:title andMessage:message];
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

- (IBAction)doneButtonClicked:(id)sender{
    [self removePopupFromViewReturningData:[datePicker date]];
}

@end