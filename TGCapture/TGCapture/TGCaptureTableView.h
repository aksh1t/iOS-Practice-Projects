#import <UIKit/UIKit.h>

enum {
    tgCaptureTableViewModeSingleSelection = 1,
    tgCaptureTableViewModeMultiSelection = 2
};
typedef int tgCaptureTableViewMode;

@protocol TGCaptureTableViewDelegate;

@interface TGCaptureTableView : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UILabel        *titleLabel;
    IBOutlet UILabel        *messageLabel;
    IBOutlet UIButton       *doneButton;
    IBOutlet UIView         *overlayView;
    IBOutlet UITableView    *tableView;
    
    NSArray                 *data;
    NSMutableArray          *selectedData;
    tgCaptureTableViewMode  currentMode;
}

@property (nonatomic, retain) id<TGCaptureTableViewDelegate> delegate;

- (TGCaptureTableView *)initWithTitle: (NSString *)title andMessage: (NSString *)message andData: (NSArray *)data withMode: (tgCaptureTableViewMode)mode;
- (void)showInViewController: (UIViewController *)vc;

@end

@protocol TGCaptureTableViewDelegate <NSObject>
@required
- (void)tgCaptureTableViewReturnedData: (NSArray *)data;
@end