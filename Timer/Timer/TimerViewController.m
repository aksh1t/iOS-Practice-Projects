#import "TimerViewController.h"

@implementation TimerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Timer";
    
    TimerTableViewController *tableViewController = [TimerTableViewController new];
    [self addChildViewController:tableViewController];
    [self.view addSubview:tableViewController.view];
}

@end