#import "TimerData.h"

@implementation TimerData

@synthesize totalTime, remainingTime, timer;

-(id)initWithTime:(long)time andIndex:(int)i{
    index = i;
    totalTime = time;
    remainingTime = time;
    timer = NULL;
    return self;
}

-(void)fireTimer{
    remainingTime = (remainingTime == 0)? 0 : remainingTime - 1;
    if(remainingTime == 0){
        [timer invalidate];
        timer = NULL;
        [self.delegate remainingTimeForIndex:index is:remainingTime];
        remainingTime = totalTime;
        return;
    }
    [self.delegate remainingTimeForIndex:index is:remainingTime];
}

-(void)toggleTimer{
    if(timer != NULL){
        [timer invalidate];
        timer = NULL;
    }else{
        timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

@end