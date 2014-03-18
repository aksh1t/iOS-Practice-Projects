#import "HomeViewController.h"

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender{
    
    TGCaptureTextField *tg = [[TGCaptureTextField alloc]initWithTitle:@"My Title" andMessage:@"Enter your name here :"];
    [tg setDelegate:self];
    [tg showInViewController:self];
    
}

- (IBAction)button2Clicked:(id)sender{
    
    TGCaptureTextView *tg = [[TGCaptureTextView alloc]initWithTitle:@"My Title" andMessage:@"Enter your name here :"];
    [tg setDelegate:self];
    [tg showInViewController:self];
    
}

- (IBAction)button3Clicked:(id)sender{
    
    TGCaptureDatePicker *tg = [[TGCaptureDatePicker alloc]initWithTitle:@"My Title" andMessage:@"Enter your date:"];
    [tg setDelegate:self];
    [tg showInViewController:self];
    
}

- (void)tgCaptureTextFieldReturnedData:(NSString *)data{
    NSLog(@"%@",data);
}

-(void)tgCaptureTextViewReturnedData:(NSString *)data{
    NSLog(@"%@",data);
}

-(void)tgCaptureDatePickerReturnedDate:(NSDate *)date{
    NSLog(@"%@",date);
}

@end
