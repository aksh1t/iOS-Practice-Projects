#import "TGCaptureTableView.h"

@implementation TGCaptureTableView

- (TGCaptureTableView *)initWithTitle:(NSString *)title andMessage:(NSString *)message andData:(NSArray *)array withMode:(tgCaptureTableViewMode)mode{
    self = [self initWithNibName:@"TGCaptureTableView" andTitle:title andMessage:message];
    if(self){
        [tableView.layer setCornerRadius:5];
        [tableView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [tableView.layer setBorderWidth:0.5];

        data = array;
        selectedData = [[NSMutableArray alloc]init];
        for(id obj in data) [selectedData addObject:[NSNumber numberWithBool:FALSE]];
        currentMode = mode;
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

- (IBAction)doneButtonClicked:(id)sender{
    [self removePopupFromViewReturningData:selectedData];
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