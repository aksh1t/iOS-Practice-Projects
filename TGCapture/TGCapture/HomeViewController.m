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
    
    TGCaptureTableItem *item1 = [[TGCaptureTableItem alloc]init];
    [item1 setTitle:@"A"];
    [item1 setIsSelected:NO];
    
    TGCaptureTableItem *item2 = [[TGCaptureTableItem alloc]init];
    [item2 setTitle:@"B"];
    [item2 setIsSelected:YES];
    
    TGCaptureTableItem *item3 = [[TGCaptureTableItem alloc]init];
    [item3 setTitle:@"C"];
    [item3 setIsSelected:YES];
    
    NSArray *arr = [NSArray arrayWithObjects:item1, item2, item3, nil];
    
    TGCaptureTableView *tg = [[TGCaptureTableView alloc]initWithTitle:@"My Title" andMessage:@"Select your cells:" andData:arr withMode:tgCaptureTableViewModeMultiSelection];
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

-(void)tgCapture:(id)sender returnedData:(id)data{
    NSLog(@"%@",data);
}

@end
