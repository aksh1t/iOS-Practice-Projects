#import <UIKit/UIKit.h>

@protocol TimerCellProtocol;

@interface TimerTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIStepper *stepper;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *countDownLabel;
@property (nonatomic, retain) IBOutlet UIButton *toggleButton;
@property (nonatomic, assign) id <TimerCellProtocol> delegate;

-(void)toggleButtonText;

@end

@protocol TimerCellProtocol <NSObject>

-(void)stepperValueChangedForCell:(TimerTableViewCell *)cell;
-(void)toggleButtonPressedForCell:(TimerTableViewCell *)cell;

@end