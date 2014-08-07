#import "TimerTableViewCell.h"

@implementation TimerTableViewCell

@synthesize stepper, timeLabel, countDownLabel, toggleButton, delegate;

- (id)init{
    [self.toggleButton setExclusiveTouch:YES];
    return self;
}

-(IBAction)toggleButtonClicked:(id)sender{
    [delegate toggleButtonPressedForCell:self];
}

-(IBAction)stepperValueChanged:(id)sender{
    [timeLabel setText:[NSString stringWithFormat:@"%.0f m",stepper.value]];
    [countDownLabel setText:[NSString stringWithFormat:@"%02.0f:00:00",stepper.value]];
    [delegate stepperValueChangedForCell:self];
}

-(void)toggleButtonText{
    [toggleButton setTitle:[toggleButton.titleLabel.text isEqualToString:@"Start"]?@"Pause":@"Start" forState:UIControlStateNormal];
}

@end