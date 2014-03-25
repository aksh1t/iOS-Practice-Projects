#import "TGCaptureTableView.h"

@implementation TGCaptureTableView

- (TGCaptureTableView *)initWithTitle:(NSString *)title andMessage:(NSString *)message andData:(NSArray *)array withMode:(tgCaptureTableViewMode)mode{
    self = [self initWithNibName:@"TGCaptureTableView" andTitle:title andMessage:message];
    if(self){
        [tableView.layer setCornerRadius:5];
        [tableView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [tableView.layer setBorderWidth:0.5];

        data = array;
        
        int lastindex = 0;
        BOOL noselected = TRUE;
        if(mode == tgCaptureTableViewModeSingleSelection){
            for(int i=0;i<[data count];i++) {
                if([(TGCaptureTableItem *)[data objectAtIndex:i] isSelected]){
                    lastindex = i;
                    noselected = FALSE;
                    [(TGCaptureTableItem *)[data objectAtIndex:i] setIsSelected:FALSE];
                }
            }
            if(!noselected)
                [(TGCaptureTableItem *)[data objectAtIndex:lastindex] setIsSelected:TRUE];
        }
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
    
    NSMutableArray *returnData = [[NSMutableArray alloc]init];
    for(id item in data){
        if([(TGCaptureTableItem *)item isSelected]){
            [returnData addObject:item];
        }
    }

    [self removePopupFromViewReturningData:returnData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (currentMode) {
        case tgCaptureTableViewModeSingleSelection:
            for(id item in data) [(TGCaptureTableItem *)item setIsSelected:FALSE];
            [(TGCaptureTableItem *)[data objectAtIndex:indexPath.row]setIsSelected:TRUE];
            break;
        case tgCaptureTableViewModeMultiSelection:
            if([(TGCaptureTableItem *)[data objectAtIndex:indexPath.row] isSelected])
                [(TGCaptureTableItem *)[data objectAtIndex:indexPath.row] setIsSelected:FALSE];
            else
                [(TGCaptureTableItem *)[data objectAtIndex:indexPath.row] setIsSelected:TRUE];
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
    [cellLabel setText:[(TGCaptureTableItem *)[data objectAtIndex:indexPath.row] title]];
    
    UIImageView *checkmark = (UIImageView *)[cell viewWithTag:2];
    [checkmark setHidden:![(TGCaptureTableItem *)[data objectAtIndex:indexPath.row] isSelected]];
    
    return cell;
}

@end