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
//    NSDictionary *appearenceDict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithFloat:2.3],popupBackgroundColor, nil];
//    [tg setAppearance:appearenceDict];
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

- (IBAction)button4Clicked:(id)sender{
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E", nil];
    
    TGCaptureTableView *tg = [[TGCaptureTableView alloc]initWithTitle:@"My Title" andMessage:@"Select your cells:" andData:arr withMode:tgCaptureTableViewModeSingleSelection];
    [tg setDelegate:self];
    [tg showInViewController:self];
    
}

- (IBAction)button5Clicked:(id)sender{

    TGCapturePhotoPicker *tg = [[TGCapturePhotoPicker alloc]initWithTitle:@"My Title" andMessage:@"Select your photo:"];
    [tg setDelegate:self];
    [tg showInViewController:self];
    
}

- (IBAction)button6Clicked:(id)sender{
    
    TGCaptureVideoPicker *tg = [[TGCaptureVideoPicker alloc]initWithTitle:@"My Title" andMessage:@"Select your photo:"];
    [tg setDelegate:self];
    [tg showInViewController:self];
    
}

-(void)tgCaptureReturnedData:(id)data{
    NSLog(@"%@",data);
}

@end
