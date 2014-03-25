#import <UIKit/UIKit.h>
#import "TGCapture.h"
#import "TGCaptureTableItem.h"

enum{
    tgCaptureTableViewModeSingleSelection = 1,
    tgCaptureTableViewModeMultiSelection = 2
}; typedef int tgCaptureTableViewMode;

@interface TGCaptureTableView : TGCapture <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView    *tableView;
    NSArray                 *data;
    NSMutableArray          *selectedData;
    tgCaptureTableViewMode  currentMode;
}

- (TGCaptureTableView *)initWithTitle: (NSString *)title andMessage: (NSString *)message andData: (NSArray *)data withMode: (tgCaptureTableViewMode)mode;

@end