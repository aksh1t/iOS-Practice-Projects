#import <UIKit/UIKit.h>
#import "TimerTableViewCell.h"
#import "TimerData.h"

@interface TimerTableViewController : UITableViewController <TimerCellProtocol, TimerProtocol>{
    NSMutableArray *dataArray;
}

@end