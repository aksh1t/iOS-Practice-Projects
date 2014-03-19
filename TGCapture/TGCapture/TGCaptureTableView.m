#import "TGCaptureTableView.h"

@implementation TGCaptureTableView{
    BOOL canceled;
}

@synthesize delegate;

- (TGCaptureTableView *)initWithTitle:(NSString *)title andMessage:(NSString *)message andData:(NSArray *)array withMode:(tgCaptureTableViewMode)mode{
    self = [self initWithNibName:@"TGCaptureTableView" bundle:nil];
    if(self){
        canceled = NO;
        
        [self.view.layer setCornerRadius:5];
        [self.view.layer setShadowOffset:CGSizeMake(5,5)];
        [self.view.layer setShadowRadius:10];
        [self.view.layer setShadowOpacity:0.3];
        
        [titleLabel setText:title];
        [messageLabel setText:message];
        [tableView.layer setCornerRadius:5];
        [tableView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [tableView.layer setBorderWidth:0.5];

        data = array;
        selectedData = [[NSMutableArray alloc]init];
        for(id obj in data) [selectedData addObject:[NSNumber numberWithBool:FALSE]];
        currentMode = mode;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [singleTap setNumberOfTouchesRequired : 1];
        [overlayView addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)tapped{
    canceled = YES;
    [self doneButtonClicked:self];
}

- (void)showInViewController:(UIViewController *)vc{
    [overlayView setFrame:vc.view.frame];
    [self.view setCenter:vc.view.center];
    [vc addChildViewController:self];
    [vc.view addSubview:overlayView];
    [vc.view addSubview:self.view];
    
    overlayView.alpha = 0;
    self.view.alpha = 0;
    
    self.view.transform = CGAffineTransformMakeScale(0.01,0.01);
    
    [UIView animateWithDuration:0.3 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.transform = CGAffineTransformMakeScale(1.1,1.1);
                         overlayView.alpha = 0.6;
                         self.view.alpha = 1;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1 animations:^{
                             self.view.transform = CGAffineTransformMakeScale(1,1);
                         }];
                     }];
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
    [UIView animateWithDuration:0.1 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.transform = CGAffineTransformMakeScale(1.1,1.1);
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3 animations:^{
                             self.view.transform = CGAffineTransformMakeScale(0.01,0.01);
                             overlayView.alpha = 0;
                             self.view.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self.view removeFromSuperview];
                             [overlayView removeFromSuperview];
                             [self removeFromParentViewController];
                             if(canceled){
                                 [delegate tgCaptureTableViewReturnedData:nil];
                             }else{
                                 [delegate tgCaptureTableViewReturnedData:selectedData];
                             }
                         }];
                     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (currentMode) {
        case tgCaptureTableViewModeSingleSelection:
            [selectedData removeAllObjects];
            for(id obj in data) [selectedData addObject:[NSNumber numberWithBool:FALSE]];
            [selectedData replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:TRUE]];
            break;
        case tgCaptureTableViewModeMultiSelection:
            if([[selectedData objectAtIndex:indexPath.row]boolValue])
                [selectedData replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:FALSE]];
            else
                [selectedData replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:TRUE]];
            break;
        default:
            break;
    }
    [tv reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    [cellLabel setText:[data objectAtIndex:indexPath.row]];
    
    UIImageView *checkmark = (UIImageView *)[cell viewWithTag:2];
    [checkmark setHidden:![[selectedData objectAtIndex:indexPath.row]boolValue]];
    
    return cell;
}

@end