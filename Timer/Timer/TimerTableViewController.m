#import "TimerTableViewController.h"

#define NO_OF_CELLS 20

@implementation TimerTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray new];
    
    for(int i=0;i<NO_OF_CELLS;i++){
        TimerData *data = [[TimerData alloc]initWithTime:6000 andIndex:i];
        data.delegate = self;
        [dataArray addObject:data];
    }
}

-(void)remainingTimeForIndex:(int)index is:(long)num{
    TimerTableViewCell *cell = (TimerTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell.countDownLabel setText:[NSString stringWithFormat:@"%02ld:%02ld:%02ld",num/6000,(num/100)%60,num%100]];
    if(num == 0){
        [cell.toggleButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return NO_OF_CELLS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimerTableViewCell"];
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"TimerTableViewCell" bundle:nil] forCellReuseIdentifier:@"TimerTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TimerTableViewCell"];
    }
    
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    TimerTableViewCell *myCell = (TimerTableViewCell *)cell;
    TimerData *data = [dataArray objectAtIndex:indexPath.row];
    myCell.timeLabel.text = [NSString stringWithFormat:@"%ld m",[data totalTime]/6000];
    [myCell.countDownLabel setText:[NSString stringWithFormat:@"%02ld:%02ld:%02ld",[data remainingTime]/6000,([data remainingTime]/100)%60,[data remainingTime]%100]];
    if(data.timer != NULL){
        [myCell.toggleButton setTitle:@"Pause" forState:UIControlStateNormal];
    }else{
        [myCell.toggleButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

-(void)stepperValueChangedForCell:(TimerTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TimerData *data = [dataArray objectAtIndex:indexPath.row];
    data.totalTime = cell.stepper.value * 6000;
    data.remainingTime = cell.stepper.value * 6000;
}

-(void)toggleButtonPressedForCell:(TimerTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TimerData *data = [dataArray objectAtIndex:indexPath.row];
    if(data.remainingTime != 0){
        [data toggleTimer];
        [cell toggleButtonText];
    }
}

@end